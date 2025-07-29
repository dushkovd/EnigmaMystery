-- Debug Production Triggers and Functions
-- Run this in your Supabase Dashboard SQL Editor for the PRODUCTION database

-- ============================================================================
-- STEP 1: Check all triggers in the database
-- ============================================================================

SELECT 
    trigger_name,
    event_object_table,
    event_manipulation,
    action_statement
FROM information_schema.triggers 
ORDER BY trigger_name;

-- ============================================================================
-- STEP 2: Check all functions related to user management
-- ============================================================================

SELECT 
    routine_name,
    routine_type,
    security_type,
    routine_definition
FROM information_schema.routines 
WHERE routine_name IN ('handle_new_user', 'grant_game_access_on_purchase')
ORDER BY routine_name;

-- ============================================================================
-- STEP 3: Check if the Users table exists and has data
-- ============================================================================

-- Check if Users table exists
SELECT 
    table_name,
    table_type
FROM information_schema.tables 
WHERE table_name = 'Users';

-- Check Users table structure
SELECT 
    column_name,
    data_type,
    is_nullable,
    column_default
FROM information_schema.columns 
WHERE table_name = 'Users'
ORDER BY ordinal_position;

-- Check if there are any users in the Users table
SELECT COUNT(*) as users_count FROM "Users";

-- ============================================================================
-- STEP 4: Check auth.users table
-- ============================================================================

-- Check if there are users in auth.users
SELECT COUNT(*) as auth_users_count FROM auth.users;

-- Check recent auth.users (last 5)
SELECT 
    id,
    email,
    created_at
FROM auth.users 
ORDER BY created_at DESC 
LIMIT 5;

-- ============================================================================
-- STEP 5: Check RLS policies on Users table
-- ============================================================================

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