-- Migration: Fix hardcoded HTTPS protocol in image URL functions
-- This migration makes the protocol configurable for environments without SSL

-- 1. Add protocol configuration setting
DO $$
BEGIN
    -- Set default protocol - change this to 'http://' if you don't have SSL
    PERFORM set_config('app.settings.protocol', 'http://', false);
    
    -- You can also set this to 'https://' when you have SSL
    -- PERFORM set_config('app.settings.protocol', 'https://', false);
END $$;

-- 2. Update get_game_image_url function to use configurable protocol
CREATE OR REPLACE FUNCTION get_game_image_url(image_path TEXT)
RETURNS TEXT AS $$
BEGIN
  -- If image_path is provided, construct the Supabase Storage URL with configurable protocol
  IF image_path IS NOT NULL AND image_path != '' THEN
    RETURN current_setting('app.settings.protocol') || current_setting('app.settings.supabase_url') || '/storage/v1/object/public/game-images/' || image_path;
  ELSE
    -- Fallback to default image or existing image URL
    RETURN NULL;
  END IF;
END;
$$ LANGUAGE plpgsql SECURITY INVOKER;

-- 3. Update get_game_image_url_secure function to use configurable protocol
CREATE OR REPLACE FUNCTION get_game_image_url_secure(image_path TEXT, game_id INTEGER DEFAULT NULL)
RETURNS TEXT AS $$
DECLARE
  user_id UUID;
  has_access BOOLEAN := FALSE;
BEGIN
  -- Get current user ID
  user_id := auth.uid();
  
  -- If no game_id provided, allow access (for public game listings)
  IF game_id IS NULL THEN
    has_access := TRUE;
  ELSE
    -- Check if user has purchased this game or if it's a public game
    SELECT EXISTS (
      SELECT 1 FROM "Order_Items" oi
      JOIN "Orders" o ON oi.order_id = o.order_id
      WHERE oi.game_id = game_id 
      AND o.user_id = user_id 
      AND o.status = 'completed'
    ) INTO has_access;
    
    -- If user hasn't purchased, check if game is active (public)
    IF NOT has_access THEN
      SELECT is_active FROM "Games" WHERE game_id = game_id INTO has_access;
    END IF;
  END IF;
  
  -- Only return URL if user has access
  IF has_access AND image_path IS NOT NULL AND image_path != '' THEN
    RETURN current_setting('app.settings.protocol') || current_setting('app.settings.supabase_url') || '/storage/v1/object/public/game-images/' || image_path;
  ELSE
    RETURN NULL;
  END IF;
END;
$$ LANGUAGE plpgsql SECURITY INVOKER;

-- 4. Create a function to update the protocol setting
CREATE OR REPLACE FUNCTION update_protocol_setting(new_protocol TEXT)
RETURNS VOID AS $$
BEGIN
    -- Only allow authenticated users to update the protocol
    IF auth.role() != 'authenticated' THEN
        RAISE EXCEPTION 'Only authenticated users can update protocol setting';
    END IF;
    
    -- Validate protocol
    IF new_protocol NOT IN ('http://', 'https://') THEN
        RAISE EXCEPTION 'Protocol must be either http:// or https://';
    END IF;
    
    PERFORM set_config('app.settings.protocol', new_protocol, false);
END;
$$ LANGUAGE plpgsql SECURITY INVOKER;

-- 5. Grant permissions for the new function
GRANT EXECUTE ON FUNCTION update_protocol_setting(TEXT) TO authenticated;

-- 6. Add comments explaining the protocol configuration
COMMENT ON FUNCTION get_game_image_url(TEXT) IS 'Updated to use configurable protocol (http:// or https://)';
COMMENT ON FUNCTION get_game_image_url_secure(TEXT, INTEGER) IS 'Updated to use configurable protocol (http:// or https://)';
COMMENT ON FUNCTION update_protocol_setting(TEXT) IS 'Function to update protocol setting (http:// or https://)';

-- 7. Create a function to get current protocol setting
CREATE OR REPLACE FUNCTION get_current_protocol()
RETURNS TEXT AS $$
BEGIN
    RETURN current_setting('app.settings.protocol');
END;
$$ LANGUAGE plpgsql SECURITY INVOKER;

GRANT EXECUTE ON FUNCTION get_current_protocol() TO authenticated;
GRANT EXECUTE ON FUNCTION get_current_protocol() TO anon;

-- 8. Add comment for the getter function
COMMENT ON FUNCTION get_current_protocol() IS 'Get the current protocol setting'; 