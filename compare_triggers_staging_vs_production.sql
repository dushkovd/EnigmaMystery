-- Compare Triggers: Staging vs Production
-- Run this script on BOTH staging and production environments
-- Copy the results and compare them

-- ============================================================================
-- STEP 1: Check all triggers on auth.users table
-- ============================================================================

SELECT 
    'AUTH_USERS_TRIGGERS' as check_type,
    trigger_name,
    event_manipulation,
    action_timing,
    action_statement,
    action_orientation
FROM information_schema.triggers 
WHERE event_object_table = 'users' 
AND event_object_schema = 'auth'
ORDER BY trigger_name;

-- ============================================================================
-- STEP 2: Check the handle_new_user function
-- ============================================================================

SELECT 
    'HANDLE_NEW_USER_FUNCTION' as check_type,
    routine_name,
    routine_type,
    data_type,
    security_type,
    is_deterministic,
    sql_data_access,
    created,
    last_altered
FROM information_schema.routines 
WHERE routine_name = 'handle_new_user'
AND routine_schema = 'public';

-- ============================================================================
-- STEP 3: Get the function definition
-- ============================================================================

SELECT 
    'FUNCTION_DEFINITION' as check_type,
    pg_get_functiondef(oid) as function_definition
FROM pg_proc 
WHERE proname = 'handle_new_user'
AND pronamespace = (SELECT oid FROM pg_namespace WHERE nspname = 'public');

-- ============================================================================
-- STEP 4: Check function permissions
-- ============================================================================

SELECT 
    'FUNCTION_PERMISSIONS' as check_type,
    p.proname as function_name,
    p.prosecdef as security_definer,
    p.proacl as access_privileges
FROM pg_proc p
WHERE p.proname = 'handle_new_user'
AND p.pronamespace = (SELECT oid FROM pg_namespace WHERE nspname = 'public');

-- ============================================================================
-- STEP 5: Check trigger function relationship
-- ============================================================================

SELECT 
    'TRIGGER_FUNCTION_LINK' as check_type,
    t.tgname as trigger_name,
    t.tgrelid::regclass as table_name,
    p.proname as function_name,
    p.prosecdef as security_definer,
    t.tgenabled as trigger_enabled
FROM pg_trigger t
JOIN pg_proc p ON t.tgfoid = p.oid
WHERE t.tgname = 'on_auth_user_created'
AND t.tgrelid = 'auth.users'::regclass;

-- ============================================================================
-- STEP 6: Check if trigger is actually enabled
-- ============================================================================

SELECT 
    'TRIGGER_STATUS' as check_type,
    tgname as trigger_name,
    tgenabled as enabled_status,
    tgdeferrable as deferrable,
    tginitdeferred as initially_deferred
FROM pg_trigger 
WHERE tgname = 'on_auth_user_created'
AND tgrelid = 'auth.users'::regclass;

-- ============================================================================
-- STEP 7: Check RLS policies on Users table
-- ============================================================================

SELECT 
    'USERS_RLS_POLICIES' as check_type,
    schemaname,
    tablename,
    policyname,
    permissive,
    roles,
    cmd,
    qual,
    with_check
FROM pg_policies 
WHERE tablename = 'Users'
ORDER BY policyname;

-- ============================================================================
-- STEP 8: Check Users table structure
-- ============================================================================

SELECT 
    'USERS_TABLE_STRUCTURE' as check_type,
    column_name,
    data_type,
    is_nullable,
    column_default
FROM information_schema.columns 
WHERE table_name = 'Users'
AND table_schema = 'public'
ORDER BY ordinal_position;

-- ============================================================================
-- STEP 9: Test trigger manually (optional - uncomment to test)
-- ============================================================================

/*
-- This will test if the trigger works by creating a test user
-- Uncomment these lines to test:

INSERT INTO auth.users (id, email, created_at, email_confirmed_at)
VALUES (
    gen_random_uuid(),
    'trigger-test@example.com',
    NOW(),
    NOW()
);

-- Check if the trigger worked
SELECT 
    'TRIGGER_TEST_RESULT' as check_type,
    au.id,
    au.email,
    au.created_at,
    u.user_id,
    u.email as users_email,
    u.created_at as users_created_at
FROM auth.users au
LEFT JOIN "Users" u ON au.id = u.user_id
WHERE au.email = 'trigger-test@example.com';

-- Clean up test
DELETE FROM "Users" WHERE email = 'trigger-test@example.com';
DELETE FROM auth.users WHERE email = 'trigger-test@example.com';
*/ 