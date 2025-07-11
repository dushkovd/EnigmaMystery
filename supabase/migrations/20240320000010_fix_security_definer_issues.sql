-- Migration: Fix SECURITY DEFINER security issues
-- This migration replaces SECURITY DEFINER functions with safer alternatives

-- 1. Drop the existing SECURITY DEFINER functions
DROP FUNCTION IF EXISTS get_game_image_url(TEXT);
DROP FUNCTION IF EXISTS update_supabase_url(TEXT);

-- 2. Create a safer version of get_game_image_url without SECURITY DEFINER
CREATE OR REPLACE FUNCTION get_game_image_url(image_path TEXT)
RETURNS TEXT AS $$
BEGIN
  -- If image_path is provided, construct the Supabase Storage URL
  IF image_path IS NOT NULL AND image_path != '' THEN
    RETURN 'https://' || current_setting('app.settings.supabase_url') || '/storage/v1/object/public/game-images/' || image_path;
  ELSE
    -- Fallback to default image or existing image URL
    RETURN NULL;
  END IF;
END;
$$ LANGUAGE plpgsql SECURITY INVOKER;

-- 3. Create a safer version of update_supabase_url without SECURITY DEFINER
-- This function should only be used by authenticated users with proper permissions
CREATE OR REPLACE FUNCTION update_supabase_url(new_url TEXT)
RETURNS VOID AS $$
BEGIN
    -- Only allow authenticated users to update the URL
    IF auth.role() != 'authenticated' THEN
        RAISE EXCEPTION 'Only authenticated users can update Supabase URL';
    END IF;
    
    PERFORM set_config('app.settings.supabase_url', new_url, false);
END;
$$ LANGUAGE plpgsql SECURITY INVOKER;

-- 4. Recreate the games_with_images view to use the new function
CREATE OR REPLACE VIEW games_with_images AS
SELECT 
  g.*,
  COALESCE(
    get_game_image_url(g.image_path),
    g.image -- fallback to existing image URL
  ) as image_url
FROM "Games" g;

-- 5. Grant appropriate permissions
GRANT EXECUTE ON FUNCTION get_game_image_url(TEXT) TO authenticated;
GRANT EXECUTE ON FUNCTION get_game_image_url(TEXT) TO anon;
GRANT EXECUTE ON FUNCTION update_supabase_url(TEXT) TO authenticated;
GRANT SELECT ON games_with_images TO authenticated;
GRANT SELECT ON games_with_images TO anon;

-- 6. Add RLS policies to ensure proper access control
-- Ensure the view respects RLS policies on the underlying Games table
ALTER VIEW games_with_images SET (security_barrier = true);

-- 7. Create a more secure alternative: a function that checks user permissions
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
    RETURN 'https://' || current_setting('app.settings.supabase_url') || '/storage/v1/object/public/game-images/' || image_path;
  ELSE
    RETURN NULL;
  END IF;
END;
$$ LANGUAGE plpgsql SECURITY INVOKER;

-- Grant permissions for the secure function
GRANT EXECUTE ON FUNCTION get_game_image_url_secure(TEXT, INTEGER) TO authenticated;
GRANT EXECUTE ON FUNCTION get_game_image_url_secure(TEXT, INTEGER) TO anon;

-- 8. Add comments explaining the security changes
COMMENT ON FUNCTION get_game_image_url(TEXT) IS 'Safer version without SECURITY DEFINER - runs with caller privileges';
COMMENT ON FUNCTION get_game_image_url_secure(TEXT, INTEGER) IS 'Secure version that checks user permissions before returning image URL';
COMMENT ON FUNCTION update_supabase_url(TEXT) IS 'Safer version without SECURITY DEFINER - only authenticated users can update URL'; 