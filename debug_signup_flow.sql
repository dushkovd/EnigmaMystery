-- Debug Signup Flow - Comprehensive Analysis
-- Run this in your Production Supabase Dashboard SQL Editor

-- ============================================================================
-- STEP 1: Check if the user was actually created in auth.users
-- ============================================================================

-- Check recent auth.users entries
SELECT 
    'RECENT_AUTH_USERS' as check_type,
    id,
    email,
    created_at,
    email_confirmed_at,
    CASE 
        WHEN email_confirmed_at IS NOT NULL THEN 'CONFIRMED'
        ELSE 'NOT_CONFIRMED'
    END as status
FROM auth.users 
ORDER BY created_at DESC 
LIMIT 5;

-- ============================================================================
-- STEP 2: Check if any users exist in Users table
-- ============================================================================

-- Check recent Users table entries
SELECT 
    'RECENT_USERS_TABLE' as check_type,
    user_id,
    email,
    created_at
FROM "Users" 
ORDER BY created_at DESC 
LIMIT 5;

-- ============================================================================
-- STEP 3: Check user count comparison
-- ============================================================================

SELECT 
    'USER_COUNT_COMPARISON' as check_type,
    (SELECT COUNT(*) FROM auth.users) as auth_users_count,
    (SELECT COUNT(*) FROM "Users") as users_table_count,
    (SELECT COUNT(*) FROM auth.users) - (SELECT COUNT(*) FROM "Users") as difference;

-- ============================================================================
-- STEP 4: Check RLS policies on Users table
-- ============================================================================

SELECT 
    'USERS_RLS_POLICIES' as check_type,
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
-- STEP 5: Check if RLS is enabled on Users table
-- ============================================================================

SELECT 
    'RLS_STATUS' as check_type,
    schemaname,
    tablename,
    rowsecurity
FROM pg_tables 
WHERE tablename = 'Users';

-- ============================================================================
-- STEP 6: Test the create_user_record function manually
-- ============================================================================

-- This will test if the function works for the current user
-- (You'll need to run this as an authenticated user)
SELECT 
    'FUNCTION_TEST' as check_type,
    'Run this as authenticated user: SELECT create_user_record();' as instruction;

-- ============================================================================
-- STEP 7: Check if there are any missing users that need manual insertion
-- ============================================================================

-- Find users that exist in auth.users but not in Users table
SELECT 
    'MISSING_USERS' as check_type,
    au.id,
    au.email,
    au.created_at
FROM auth.users au
LEFT JOIN "Users" u ON au.id = u.user_id
WHERE u.user_id IS NULL
ORDER BY au.created_at DESC; 