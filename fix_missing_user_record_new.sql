-- Fix Missing User Record for New User
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
WHERE id = 'a39ae34c-1dd5-466a-9b8b-b9150a6c5f0a'
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
WHERE au.id = 'a39ae34c-1dd5-466a-9b8b-b9150a6c5f0a'; 