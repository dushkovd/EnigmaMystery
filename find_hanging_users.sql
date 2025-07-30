-- Find hanging users (exist in auth.users but not in Users table)
SELECT 
    au.id as auth_user_id,
    au.email,
    au.created_at as auth_created_at,
    CASE 
        WHEN u.user_id IS NULL THEN 'HANGING - No Users table record'
        ELSE 'OK - Has Users table record'
    END as status
FROM auth.users au
LEFT JOIN public."Users" u ON au.id = u.user_id
WHERE u.user_id IS NULL
ORDER BY au.created_at DESC; 