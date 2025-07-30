-- Debug Translations - Check Current State
-- This is just for reference - the issue is likely deployment/caching

-- ============================================================================
-- STEP 1: Check if the function fix worked
-- ============================================================================

-- Verify the create_user_record function exists and has correct permissions
SELECT 
    'FUNCTION_STATUS' as check_type,
    routine_name,
    routine_type,
    security_type
FROM information_schema.routines 
WHERE routine_name = 'create_user_record'
AND routine_schema = 'public';

-- ============================================================================
-- STEP 2: Test the function manually
-- ============================================================================

-- Test with the user ID from your console log
-- Uncomment the line below to test:

-- SELECT create_user_record('a2e7674f-d555-4996-95c9-b1893c3f488b');

-- ============================================================================
-- STEP 3: Check if the user record was created
-- ============================================================================

-- Check if the user exists in both tables
SELECT 
    'USER_STATUS' as check_type,
    au.id,
    au.email,
    au.created_at,
    u.user_id,
    u.email as users_email,
    CASE 
        WHEN u.user_id IS NOT NULL THEN 'FIXED'
        ELSE 'STILL_MISSING'
    END as status
FROM auth.users au
LEFT JOIN "Users" u ON au.id = u.user_id
WHERE au.id = 'a2e7674f-d555-4996-95c9-b1893c3f488b'; 