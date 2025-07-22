-- Check current RLS policies to see what's wrong

-- 1. Check RLS policies on Character_Variations table
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
WHERE tablename = 'Character_Variations'
ORDER BY policyname;

-- 2. Check RLS policies on Characters table
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
WHERE tablename = 'Characters'
ORDER BY policyname;

-- 3. Check if anon role has SELECT permissions
SELECT 
  grantee,
  table_name,
  privilege_type
FROM information_schema.role_table_grants 
WHERE table_name IN ('Character_Variations', 'Characters')
AND grantee = 'anon'
ORDER BY table_name, privilege_type;

-- 4. Test a simple query to see if the policy condition works
-- This should help us understand if the policy logic is correct
SELECT 
  EXISTS (
    SELECT 1 FROM "Game_Variations" gv
    JOIN "Games" g ON gv.game_id = g.game_id
    WHERE gv.variation_id = 15
    AND g.is_active = true
  ) as policy_condition_result; 