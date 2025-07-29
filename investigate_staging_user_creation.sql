-- Investigate Staging User Creation
-- Run this in your STAGING Supabase Dashboard SQL Editor

-- ============================================================================
-- STEP 1: Check recent user creation in both tables
-- ============================================================================

-- Recent auth.users
SELECT 
    'RECENT_AUTH_USERS' as check_type,
    id,
    email,
    created_at,
    email_confirmed_at
FROM auth.users 
ORDER BY created_at DESC 
LIMIT 5;

-- Recent Users table entries
SELECT 
    'RECENT_USERS_TABLE' as check_type,
    user_id,
    email,
    created_at
FROM "Users" 
ORDER BY created_at DESC 
LIMIT 5;

-- ============================================================================
-- STEP 2: Check if there are any differences in user counts
-- ============================================================================

SELECT 
    'USER_COUNT_COMPARISON' as check_type,
    (SELECT COUNT(*) FROM auth.users) as auth_users_count,
    (SELECT COUNT(*) FROM "Users") as users_table_count,
    (SELECT COUNT(*) FROM auth.users) - (SELECT COUNT(*) FROM "Users") as difference;

-- ============================================================================
-- STEP 3: Check for any functions that might handle user creation
-- ============================================================================

SELECT 
    'USER_FUNCTIONS' as check_type,
    routine_schema,
    routine_name,
    routine_type,
    security_type
FROM information_schema.routines 
WHERE routine_name ILIKE '%user%'
   OR routine_name ILIKE '%auth%'
   OR routine_name ILIKE '%handle%'
   OR routine_name ILIKE '%create%'
ORDER BY routine_schema, routine_name;

-- ============================================================================
-- STEP 4: Check for any RLS policies that might auto-create records
-- ============================================================================

SELECT 
    'USERS_RLS_POLICIES' as check_type,
    schemaname,
    tablename,
    policyname,
    permissive,
    roles,
    cmd,
    qual
FROM pg_policies 
WHERE tablename = 'Users'
ORDER BY policyname;

-- ============================================================================
-- STEP 5: Check for any foreign key constraints that might trigger actions
-- ============================================================================

SELECT 
    'FOREIGN_KEYS' as check_type,
    tc.table_schema,
    tc.table_name,
    tc.constraint_name,
    kcu.column_name,
    ccu.table_schema AS foreign_table_schema,
    ccu.table_name AS foreign_table_name,
    ccu.column_name AS foreign_column_name
FROM information_schema.table_constraints AS tc 
JOIN information_schema.key_column_usage AS kcu
  ON tc.constraint_name = kcu.constraint_name
  AND tc.table_schema = kcu.table_schema
JOIN information_schema.constraint_column_usage AS ccu
  ON ccu.constraint_name = tc.constraint_name
  AND ccu.table_schema = tc.table_schema
WHERE tc.constraint_type = 'FOREIGN KEY'
  AND (tc.table_name = 'Users' OR ccu.table_name = 'Users')
ORDER BY tc.table_schema, tc.table_name; 