-- Compare Staging vs Production
-- Run this on BOTH staging and production to see the differences

-- ============================================================================
-- STEP 1: Check all triggers (this should show the difference)
-- ============================================================================

SELECT 
    'TRIGGERS' as check_type,
    trigger_name,
    event_object_table,
    event_manipulation,
    action_statement
FROM information_schema.triggers 
ORDER BY trigger_name;

-- ============================================================================
-- STEP 2: Check user-related functions
-- ============================================================================

SELECT 
    'FUNCTIONS' as check_type,
    routine_name,
    routine_type,
    security_type
FROM information_schema.routines 
WHERE routine_name IN ('handle_new_user', 'grant_game_access_on_purchase')
ORDER BY routine_name;

-- ============================================================================
-- STEP 3: Check Users table data
-- ============================================================================

SELECT 
    'USERS_TABLE' as check_type,
    COUNT(*) as users_count 
FROM "Users";

-- ============================================================================
-- STEP 4: Check auth.users data
-- ============================================================================

SELECT 
    'AUTH_USERS' as check_type,
    COUNT(*) as auth_users_count 
FROM auth.users;

-- ============================================================================
-- STEP 5: Check RLS policies on Users table
-- ============================================================================

SELECT 
    'RLS_POLICIES' as check_type,
    policyname,
    cmd,
    permissive
FROM pg_policies 
WHERE tablename = 'Users'; 