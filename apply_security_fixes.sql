-- Security Fixes for Murder Mystery Game Database
-- Apply this script to your Supabase database to fix SECURITY DEFINER issues and protocol configuration

-- ============================================================================
-- FIX 1: Remove SECURITY DEFINER from functions
-- ============================================================================

-- First, drop the view that depends on the function
DROP VIEW IF EXISTS games_with_images;

-- Now drop the existing SECURITY DEFINER functions
DROP FUNCTION IF EXISTS get_game_image_url(TEXT);
DROP FUNCTION IF EXISTS update_supabase_url(TEXT);

-- Create a safer version of get_game_image_url without SECURITY DEFINER
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

-- Create a safer version of update_supabase_url without SECURITY DEFINER
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

-- Recreate the games_with_images view to use the new function
CREATE OR REPLACE VIEW games_with_images AS
SELECT 
  g.*,
  COALESCE(
    get_game_image_url(g.image_path),
    g.image -- fallback to existing image URL
  ) as image_url
FROM "Games" g;

-- Grant appropriate permissions
GRANT EXECUTE ON FUNCTION get_game_image_url(TEXT) TO authenticated;
GRANT EXECUTE ON FUNCTION get_game_image_url(TEXT) TO anon;
GRANT EXECUTE ON FUNCTION update_supabase_url(TEXT) TO authenticated;
GRANT SELECT ON games_with_images TO authenticated;
GRANT SELECT ON games_with_images TO anon;

-- Add security barrier to view
ALTER VIEW games_with_images SET (security_barrier = true);

-- ============================================================================
-- FIX 2: Make protocol configurable (for HTTP/HTTPS)
-- ============================================================================

-- Add protocol configuration setting
DO $$
BEGIN
    -- Set default protocol to HTTPS since you now have SSL
    PERFORM set_config('app.settings.protocol', 'https://', false);
END $$;

-- Update get_game_image_url function to use configurable protocol
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

-- Create a function to update the protocol setting
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

-- Create a function to get current protocol setting
CREATE OR REPLACE FUNCTION get_current_protocol()
RETURNS TEXT AS $$
BEGIN
    RETURN COALESCE(current_setting('app.settings.protocol', true), 'https://');
END;
$$ LANGUAGE plpgsql SECURITY INVOKER;

-- Grant permissions for the new functions
GRANT EXECUTE ON FUNCTION update_protocol_setting(TEXT) TO authenticated;
GRANT EXECUTE ON FUNCTION get_current_protocol() TO authenticated;
GRANT EXECUTE ON FUNCTION get_current_protocol() TO anon;

-- Add comments explaining the security changes
COMMENT ON FUNCTION get_game_image_url(TEXT) IS 'Updated to use configurable protocol (http:// or https://) without SECURITY DEFINER';
COMMENT ON FUNCTION update_protocol_setting(TEXT) IS 'Function to update protocol setting (http:// or https://)';
COMMENT ON FUNCTION get_current_protocol() IS 'Get the current protocol setting';

-- ============================================================================
-- VERIFICATION QUERIES
-- ============================================================================

-- Check that SECURITY DEFINER functions are removed
-- This should return no rows if the fix worked
SELECT 
  'SECURITY DEFINER functions check:' as check_type,
  CASE 
    WHEN COUNT(*) = 0 THEN 'PASSED - No SECURITY DEFINER functions found'
    ELSE 'FAILED - Found ' || COUNT(*) || ' SECURITY DEFINER functions'
  END as result
FROM pg_proc p
JOIN pg_namespace n ON p.pronamespace = n.oid
WHERE n.nspname = 'public' 
AND p.prosecdef = true;

-- Check current protocol setting (with error handling)
SELECT 
  'Protocol setting check:' as check_type,
  CASE 
    WHEN get_current_protocol() = 'https://' THEN 'PASSED - Protocol set to HTTPS'
    WHEN get_current_protocol() = 'http://' THEN 'PASSED - Protocol set to HTTP'
    ELSE 'UNKNOWN - Protocol is: ' || get_current_protocol()
  END as result;

-- Test image URL generation
SELECT 
  'Image URL generation test:' as check_type,
  CASE 
    WHEN get_game_image_url('test/image.jpg') IS NOT NULL 
    AND get_game_image_url('test/image.jpg') LIKE 'https://%' 
    THEN 'PASSED - HTTPS URLs generated correctly'
    WHEN get_game_image_url('test/image.jpg') IS NOT NULL 
    AND get_game_image_url('test/image.jpg') LIKE 'http://%' 
    THEN 'PASSED - HTTP URLs generated correctly'
    ELSE 'FAILED - URL generation issue'
  END as result;

-- Check view security settings
SELECT 
  'View security barrier check:' as check_type,
  CASE 
    WHEN security_barrier = true THEN 'PASSED - Security barrier enabled'
    ELSE 'FAILED - Security barrier not enabled'
  END as result
FROM pg_views 
WHERE schemaname = 'public' 
AND viewname = 'games_with_images';

-- Show sample generated URL
SELECT 
  'Sample URL:' as info,
  get_game_image_url('test/image.jpg') as generated_url; 