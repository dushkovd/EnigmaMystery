-- Comprehensive Staging vs Production Comparison
-- Run this on BOTH environments to find the difference

-- ============================================================================
-- STEP 1: Check ALL triggers in the database
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
-- STEP 2: Check ALL functions that might handle user creation
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
ORDER BY routine_schema, routine_name;

-- ============================================================================
-- STEP 3: Check if there are any database functions (not just public schema)
-- ============================================================================

SELECT 
    'ALL_FUNCTIONS' as check_type,
    n.nspname as schema_name,
    p.proname as function_name,
    p.prosecdef as security_definer
FROM pg_proc p
JOIN pg_namespace n ON p.pronamespace = n.oid
WHERE p.proname ILIKE '%user%'
   OR p.proname ILIKE '%auth%'
   OR p.proname ILIKE '%handle%'
ORDER BY n.nspname, p.proname;

-- ============================================================================
-- STEP 4: Check for any RLS policies that might auto-create records
-- ============================================================================

SELECT 
    'ALL_RLS_POLICIES' as check_type,
    schemaname,
    tablename,
    policyname,
    permissive,
    roles,
    cmd,
    qual
FROM pg_policies 
WHERE tablename ILIKE '%user%'
   OR tablename ILIKE '%auth%'
ORDER BY schemaname, tablename, policyname;

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
  AND (tc.table_name ILIKE '%user%' OR ccu.table_name ILIKE '%user%')
ORDER BY tc.table_schema, tc.table_name;

-- ============================================================================
-- STEP 6: Check for any rules on tables
-- ============================================================================

SELECT 
    'TABLE_RULES' as check_type,
    schemaname,
    tablename,
    rulename,
    definition
FROM pg_rules 
WHERE tablename ILIKE '%user%'
   OR tablename ILIKE '%auth%'
ORDER BY schemaname, tablename;

-- ============================================================================
-- STEP 7: Check recent user creation in both tables
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
-- STEP 8: Check if there are any differences in user counts
-- ============================================================================

SELECT 
    'USER_COUNT_COMPARISON' as check_type,
    (SELECT COUNT(*) FROM auth.users) as auth_users_count,
    (SELECT COUNT(*) FROM "Users") as users_table_count,
    (SELECT COUNT(*) FROM auth.users) - (SELECT COUNT(*) FROM "Users") as difference;

-- ============================================================================
-- STEP 9: Check for any Supabase-specific functions or extensions
-- ============================================================================

SELECT 
    'SUPABASE_EXTENSIONS' as check_type,
    extname,
    extversion
FROM pg_extension 
WHERE extname ILIKE '%supabase%'
   OR extname ILIKE '%auth%'
   OR extname ILIKE '%realtime%';

-- ============================================================================
-- STEP 10: Check for any custom schemas
-- ============================================================================

SELECT 
    'CUSTOM_SCHEMAS' as check_type,
    schema_name,
    schema_owner
FROM information_schema.schemata 
WHERE schema_name NOT IN ('information_schema', 'pg_catalog', 'pg_toast')
ORDER BY schema_name; 