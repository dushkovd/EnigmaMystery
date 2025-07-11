-- Minimal Security Fix
-- Only applies the necessary changes without recreating everything

-- ============================================================================
-- STEP 1: Check current status first
-- ============================================================================
-- Run this to see what needs to be fixed:
-- SELECT proname, prosecdef FROM pg_proc p JOIN pg_namespace n ON p.pronamespace = n.oid WHERE n.nspname = 'public' AND proname IN ('get_game_image_url', 'update_supabase_url');

-- ============================================================================
-- STEP 2: Fix SECURITY DEFINER functions (only if needed)
-- ============================================================================

-- Option A: If functions exist with SECURITY DEFINER, recreate them
-- Uncomment the lines below ONLY if the check above shows SECURITY DEFINER functions

/*
-- Drop and recreate get_game_image_url with SECURITY INVOKER
DROP VIEW IF EXISTS games_with_images;
DROP FUNCTION IF EXISTS get_game_image_url(TEXT);

CREATE OR REPLACE FUNCTION get_game_image_url(image_path TEXT)
RETURNS TEXT AS $$
BEGIN
  IF image_path IS NOT NULL AND image_path != '' THEN
    RETURN COALESCE(current_setting('app.settings.protocol', true), 'https://') || current_setting('app.settings.supabase_url') || '/storage/v1/object/public/game-images/' || image_path;
  ELSE
    RETURN NULL;
  END IF;
END;
$$ LANGUAGE plpgsql SECURITY INVOKER;

-- Recreate the view
CREATE OR REPLACE VIEW games_with_images AS
SELECT 
  g.*,
  COALESCE(
    get_game_image_url(g.image_path),
    g.image
  ) as image_url
FROM "Games" g;

GRANT SELECT ON games_with_images TO authenticated;
GRANT SELECT ON games_with_images TO anon;
ALTER VIEW games_with_images SET (security_barrier = true);
*/

-- ============================================================================
-- STEP 3: Add protocol configuration (only if missing)
-- ============================================================================

-- Set protocol to HTTPS (only if not already set)
DO $$
BEGIN
    IF current_setting('app.settings.protocol', true) IS NULL THEN
        PERFORM set_config('app.settings.protocol', 'https://', false);
        RAISE NOTICE 'Protocol setting added: https://';
    ELSE
        RAISE NOTICE 'Protocol setting already exists: %', current_setting('app.settings.protocol');
    END IF;
END $$;

-- ============================================================================
-- STEP 4: Create missing functions (only if they don't exist)
-- ============================================================================

-- Create update_protocol_setting function if it doesn't exist
CREATE OR REPLACE FUNCTION update_protocol_setting(new_protocol TEXT)
RETURNS VOID AS $$
BEGIN
    IF auth.role() != 'authenticated' THEN
        RAISE EXCEPTION 'Only authenticated users can update protocol setting';
    END IF;
    
    IF new_protocol NOT IN ('http://', 'https://') THEN
        RAISE EXCEPTION 'Protocol must be either http:// or https://';
    END IF;
    
    PERFORM set_config('app.settings.protocol', new_protocol, false);
END;
$$ LANGUAGE plpgsql SECURITY INVOKER;

-- Create get_current_protocol function if it doesn't exist
CREATE OR REPLACE FUNCTION get_current_protocol()
RETURNS TEXT AS $$
BEGIN
    RETURN COALESCE(current_setting('app.settings.protocol', true), 'https://');
END;
$$ LANGUAGE plpgsql SECURITY INVOKER;

-- Grant permissions
GRANT EXECUTE ON FUNCTION update_protocol_setting(TEXT) TO authenticated;
GRANT EXECUTE ON FUNCTION get_current_protocol() TO authenticated;
GRANT EXECUTE ON FUNCTION get_current_protocol() TO anon;

-- ============================================================================
-- STEP 5: Verification
-- ============================================================================

-- Quick verification
SELECT 
  'Final check:' as check_type,
  CASE 
    WHEN COUNT(*) = 0 THEN '✅ SECURITY DEFINER issue resolved'
    ELSE '❌ Still have ' || COUNT(*) || ' SECURITY DEFINER functions'
  END as status
FROM pg_proc p
JOIN pg_namespace n ON p.pronamespace = n.oid
WHERE n.nspname = 'public' 
AND p.prosecdef = true;

SELECT 
  'Protocol:' as check_type,
  get_current_protocol() as current_protocol; 