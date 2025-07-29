-- Fix Missing User Record
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
WHERE id = '57ef7ee2-2121-4a39-8660-9880b273a275'
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
WHERE au.id = '57ef7ee2-2121-4a39-8660-9880b273a275'; 