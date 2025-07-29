-- Check Staging Triggers on auth.users
-- Run this in your STAGING Supabase Dashboard SQL Editor

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
-- STEP 2: Check if the specific trigger exists
-- ============================================================================

SELECT 
    'SPECIFIC_TRIGGER_CHECK' as check_type,
    trigger_name,
    event_manipulation,
    action_timing,
    action_statement
FROM information_schema.triggers 
WHERE trigger_name = 'on_auth_user_created'
AND event_object_schema = 'auth'
AND event_object_table = 'users';

-- ============================================================================
-- STEP 3: Check trigger status in pg_trigger
-- ============================================================================

SELECT 
    'TRIGGER_STATUS' as check_type,
    tgname as trigger_name,
    tgenabled as enabled_status,
    tgrelid::regclass as table_name
FROM pg_trigger 
WHERE tgname = 'on_auth_user_created'
AND tgrelid = 'auth.users'::regclass;

-- ============================================================================
-- STEP 4: Check all triggers in the database (broader view)
-- ============================================================================

SELECT 
    'ALL_TRIGGERS' as check_type,
    trigger_schema,
    trigger_name,
    event_object_schema,
    event_object_table,
    event_manipulation,
    action_timing
FROM information_schema.triggers 
ORDER BY trigger_schema, trigger_name;

-- ============================================================================
-- STEP 5: Check if handle_new_user function exists
-- ============================================================================

SELECT 
    'FUNCTION_CHECK' as check_type,
    routine_name,
    routine_type,
    security_type
FROM information_schema.routines 
WHERE routine_name = 'handle_new_user'
AND routine_schema = 'public'; 