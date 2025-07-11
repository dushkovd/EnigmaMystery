-- Check Current Database Status
-- Run this first to see what's already in place

-- ============================================================================
-- CHECK 1: Current SECURITY DEFINER functions
-- ============================================================================
SELECT 
  'SECURITY DEFINER functions found:' as check_type,
  COUNT(*) as count,
  CASE 
    WHEN COUNT(*) = 0 THEN '✅ GOOD - No SECURITY DEFINER functions'
    ELSE '⚠️  WARNING - Found ' || COUNT(*) || ' SECURITY DEFINER functions'
  END as status
FROM pg_proc p
JOIN pg_namespace n ON p.pronamespace = n.oid
WHERE n.nspname = 'public' 
AND p.prosecdef = true;

-- Show details of any SECURITY DEFINER functions
SELECT 
  proname as function_name,
  prosrc as function_source
FROM pg_proc p
JOIN pg_namespace n ON p.pronamespace = n.oid
WHERE n.nspname = 'public' 
AND p.prosecdef = true;

-- ============================================================================
-- CHECK 2: Current function security settings
-- ============================================================================
SELECT 
  'Function security settings:' as check_type,
  proname as function_name,
  CASE 
    WHEN prosecdef = true THEN 'SECURITY DEFINER'
    ELSE 'SECURITY INVOKER'
  END as security_setting
FROM pg_proc p
JOIN pg_namespace n ON p.pronamespace = n.oid
WHERE n.nspname = 'public' 
AND proname IN ('get_game_image_url', 'update_supabase_url', 'update_protocol_setting', 'get_current_protocol');

-- ============================================================================
-- CHECK 3: Protocol configuration
-- ============================================================================
SELECT 
  'Protocol configuration:' as check_type,
  CASE 
    WHEN current_setting('app.settings.protocol', true) IS NOT NULL 
    THEN '✅ Protocol setting exists: ' || current_setting('app.settings.protocol', true)
    ELSE '❌ No protocol setting found'
  END as status;

-- ============================================================================
-- CHECK 4: View security settings
-- ============================================================================
SELECT 
  'View security settings:' as check_type,
  viewname,
  CASE 
    WHEN security_barrier = true THEN '✅ Security barrier enabled'
    ELSE '❌ Security barrier disabled'
  END as security_status
FROM pg_views 
WHERE schemaname = 'public' 
AND viewname = 'games_with_images';

-- ============================================================================
-- CHECK 5: Test current function behavior
-- ============================================================================
SELECT 
  'Current function test:' as check_type,
  CASE 
    WHEN get_game_image_url('test/image.jpg') IS NOT NULL 
    AND get_game_image_url('test/image.jpg') LIKE 'https://%' 
    THEN '✅ HTTPS URLs working correctly'
    WHEN get_game_image_url('test/image.jpg') IS NOT NULL 
    AND get_game_image_url('test/image.jpg') LIKE 'http://%' 
    THEN '✅ HTTP URLs working correctly'
    ELSE '❌ URL generation issue'
  END as status,
  get_game_image_url('test/image.jpg') as sample_url; 