-- Check Email Confirmation Settings
-- Run this in your Supabase Dashboard SQL Editor

-- ============================================================================
-- STEP 1: Check auth configuration
-- ============================================================================

-- Check if email confirmation is enabled
SELECT 
    'EMAIL_CONFIRMATION' as setting_type,
    value as setting_value
FROM auth.config 
WHERE key = 'enable_signup';

-- ============================================================================
-- STEP 2: Check recent users and their confirmation status
-- ============================================================================

-- Check recent users and their email confirmation status
SELECT 
    id,
    email,
    email_confirmed_at,
    created_at,
    CASE 
        WHEN email_confirmed_at IS NOT NULL THEN 'CONFIRMED'
        ELSE 'NOT_CONFIRMED'
    END as status
FROM auth.users 
ORDER BY created_at DESC 
LIMIT 10;

-- ============================================================================
-- STEP 3: Check if there are unconfirmed users
-- ============================================================================

SELECT 
    'UNCONFIRMED_USERS' as check_type,
    COUNT(*) as count
FROM auth.users 
WHERE email_confirmed_at IS NULL;

-- ============================================================================
-- STEP 4: Check Users table vs auth.users
-- ============================================================================

-- Compare Users table with auth.users
SELECT 
    'COMPARISON' as check_type,
    (SELECT COUNT(*) FROM auth.users) as auth_users_count,
    (SELECT COUNT(*) FROM "Users") as users_table_count,
    (SELECT COUNT(*) FROM auth.users WHERE email_confirmed_at IS NULL) as unconfirmed_count; 