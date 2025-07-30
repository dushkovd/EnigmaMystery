-- SAFE CLEANUP: Remove hanging users from auth.users
-- This script will remove users that exist in auth.users but not in Users table

-- First, let's see what we're about to delete (SAFETY CHECK)
SELECT 
    'WILL DELETE' as action,
    au.id as auth_user_id,
    au.email,
    au.created_at as auth_created_at
FROM auth.users au
LEFT JOIN public."Users" u ON au.id = u.user_id
WHERE u.user_id IS NULL
ORDER BY au.created_at DESC;

-- UNCOMMENT THE BELOW SECTION TO ACTUALLY DELETE
-- WARNING: This will permanently delete users from auth.users
/*
DELETE FROM auth.users 
WHERE id IN (
    SELECT au.id
    FROM auth.users au
    LEFT JOIN public."Users" u ON au.id = u.user_id
    WHERE u.user_id IS NULL
);
*/ 