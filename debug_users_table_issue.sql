-- Debug Users Table Issue
-- Run this in your Production Supabase Dashboard SQL Editor

-- ============================================================================
-- STEP 1: Check if the specific user exists in auth.users
-- ============================================================================

SELECT 
    'AUTH_USERS_CHECK' as check_type,
    id,
    email,
    email_confirmed_at,
    created_at
FROM auth.users 
WHERE id = '57ef7ee2-2121-4a39-8660-9880b273a275';

-- ============================================================================
-- STEP 2: Check if the user exists in Users table
-- ============================================================================

SELECT 
    'USERS_TABLE_CHECK' as check_type,
    user_id,
    email,
    created_at
FROM "Users" 
WHERE user_id = '57ef7ee2-2121-4a39-8660-9880b273a275';

-- ============================================================================
-- STEP 3: Check RLS policies on Users table
-- ============================================================================

-- Check RLS policies
SELECT 
    schemaname,
    tablename,
    policyname,
    permissive,
    roles,
    cmd,
    qual,
    with_check
FROM pg_policies 
WHERE tablename = 'Users';

-- ============================================================================
-- STEP 4: Check if RLS is enabled on Users table
-- ============================================================================

SELECT 
    schemaname,
    tablename,
    rowsecurity
FROM pg_tables 
WHERE tablename = 'Users';

-- ============================================================================
-- STEP 5: Test direct query with proper headers
-- ============================================================================

-- This simulates what your app is trying to do
-- Run this to see if the query works directly
SELECT 
    'DIRECT_QUERY_TEST' as test_type,
    user_id
FROM "Users" 
WHERE user_id = '57ef7ee2-2121-4a39-8660-9880b273a275';

-- ============================================================================
-- STEP 6: Check recent users in both tables
-- ============================================================================

-- Recent auth.users
SELECT 
    'RECENT_AUTH_USERS' as source,
    id,
    email,
    created_at
FROM auth.users 
ORDER BY created_at DESC 
LIMIT 5;

-- Recent Users table entries
SELECT 
    'RECENT_USERS_TABLE' as source,
    user_id,
    email,
    created_at
FROM "Users" 
ORDER BY created_at DESC 
LIMIT 5; 