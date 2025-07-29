-- ROLLBACK SCRIPT - Restore SECURITY DEFINER functions if needed
-- Use this if the security fix causes any issues

-- ============================================================================
-- STEP 1: Restore get_game_image_url function with SECURITY DEFINER
-- ============================================================================

-- Drop the view first
DROP VIEW IF EXISTS games_with_images;

-- Drop and recreate the function with SECURITY DEFINER
DROP FUNCTION IF EXISTS get_game_image_url(TEXT);

CREATE OR REPLACE FUNCTION get_game_image_url(image_path TEXT)
RETURNS TEXT AS $$
DECLARE
    supabase_url TEXT;
    protocol TEXT;
BEGIN
  -- Get protocol setting (default to https://)
  protocol := COALESCE(current_setting('app.settings.protocol', true), 'https://');
  
  -- Get Supabase URL from multiple sources
  supabase_url := COALESCE(
    current_setting('app.settings.supabase_url', true),
    current_setting('SUPABASE_URL', true),
    'gkuwrqpxwehfnmlsqsxa.supabase.co'  -- Fallback
  );
  
  -- If image_path is provided, construct the Supabase Storage URL
  IF image_path IS NOT NULL AND image_path != '' THEN
    RETURN protocol || supabase_url || '/storage/v1/object/public/game-images/' || image_path;
  ELSE
    RETURN NULL;
  END IF;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Recreate the view
CREATE OR REPLACE VIEW games_with_images AS
SELECT 
  g.*,
  COALESCE(
    get_game_image_url(g.image_path),
    g.image -- fallback to existing image URL
  ) as image_url
FROM "Games" g;

-- ============================================================================
-- STEP 2: Restore grant_game_access_on_purchase function with SECURITY DEFINER
-- ============================================================================

-- Drop the trigger first
DROP TRIGGER IF EXISTS grant_game_access_trigger ON "Order_Items";

-- Drop and recreate the function with SECURITY DEFINER
DROP FUNCTION IF EXISTS grant_game_access_on_purchase();

CREATE OR REPLACE FUNCTION grant_game_access_on_purchase()
RETURNS TRIGGER AS $$
DECLARE
  v_user_id UUID;
  v_status TEXT;
BEGIN
  -- Get the user_id and status from the Orders table
  SELECT user_id, status INTO v_user_id, v_status
  FROM "Orders"
  WHERE order_id = NEW.order_id;
  
  -- Only grant access if the order is completed
  IF v_status = 'completed' THEN
    -- Insert access record if it doesn't exist
    INSERT INTO "User_Game_Access" (user_id, game_id)
    VALUES (v_user_id, NEW.game_id)
    ON CONFLICT (user_id, game_id) DO NOTHING;
  END IF;
  
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Recreate the trigger
CREATE TRIGGER grant_game_access_trigger
  AFTER INSERT ON "Order_Items"
  FOR EACH ROW
  EXECUTE FUNCTION grant_game_access_on_purchase();

-- ============================================================================
-- STEP 3: Restore handle_new_user function with SECURITY DEFINER
-- ============================================================================

-- Drop and recreate the function with SECURITY DEFINER
DROP FUNCTION IF EXISTS handle_new_user();

CREATE OR REPLACE FUNCTION handle_new_user()
RETURNS TRIGGER AS $$
BEGIN
  -- Insert the new user into the Users table
  INSERT INTO "Users" (user_id, email)
  VALUES (NEW.id, NEW.email)
  ON CONFLICT (user_id) DO NOTHING;
  
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- ============================================================================
-- STEP 4: Grant permissions
-- ============================================================================

-- Grant permissions for all functions
GRANT EXECUTE ON FUNCTION grant_game_access_on_purchase() TO authenticated;
GRANT EXECUTE ON FUNCTION handle_new_user() TO authenticated;
GRANT EXECUTE ON FUNCTION get_game_image_url(TEXT) TO authenticated;
GRANT EXECUTE ON FUNCTION get_game_image_url(TEXT) TO anon;

-- Grant permissions for the view
GRANT SELECT ON games_with_images TO authenticated;
GRANT SELECT ON games_with_images TO anon;

-- ============================================================================
-- STEP 5: Verify rollback
-- ============================================================================

-- Check that SECURITY DEFINER functions are restored
SELECT 
  'Rollback verification:' as check_type,
  proname as function_name,
  CASE 
    WHEN prosecdef = true THEN '✅ SECURITY DEFINER restored'
    ELSE '❌ Still SECURITY INVOKER'
  END as security_status
FROM pg_proc p
JOIN pg_namespace n ON p.pronamespace = n.oid
WHERE n.nspname = 'public' 
AND proname IN ('get_game_image_url', 'grant_game_access_on_purchase', 'handle_new_user');

-- Test the functions
SELECT 
  'Function tests after rollback:' as check_type,
  CASE 
    WHEN get_game_image_url('test/image.jpg') IS NOT NULL 
    THEN '✅ get_game_image_url working'
    ELSE '❌ get_game_image_url not working'
  END as image_url_test,
  CASE 
    WHEN (SELECT COUNT(*) FROM games_with_images) > 0 
    THEN '✅ games_with_images view working'
    ELSE '❌ games_with_images view not working'
  END as view_test; 