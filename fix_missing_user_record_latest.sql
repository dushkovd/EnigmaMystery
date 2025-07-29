-- Fix Missing User Record for Latest User
-- Run this in your Production Supabase Dashboard SQL Editor

-- ============================================================================
-- STEP 1: Insert the missing user record
-- ============================================================================

INSERT INTO "Users" (user_id, email, created_at)
SELECT 
    id,
    email,
    created_at
FROM auth.users 
WHERE id = 'd8a0c76c-eda0-4777-b66e-dc5f9e5a9c4f'
AND NOT EXISTS (
    SELECT 1 FROM "Users" WHERE user_id = auth.users.id
);

-- ============================================================================
-- STEP 2: Verify the fix
-- ============================================================================

SELECT 
    'VERIFICATION' as action,
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
WHERE au.id = 'd8a0c76c-eda0-4777-b66e-dc5f9e5a9c4f';

-- ============================================================================
-- STEP 3: Check all missing users (optional)
-- ============================================================================

-- Find all users that exist in auth.users but not in Users table
SELECT 
    'MISSING_USERS' as check_type,
    au.id,
    au.email,
    au.created_at
FROM auth.users au
LEFT JOIN "Users" u ON au.id = u.user_id
WHERE u.user_id IS NULL
ORDER BY au.created_at DESC; 