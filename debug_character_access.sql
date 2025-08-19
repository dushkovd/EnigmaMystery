-- Debug Character Access Issue for Authenticated Users
-- Run this in your Supabase SQL Editor to diagnose the problem

-- 1. Check current RLS policies on Characters table
SELECT 
  tablename,
  policyname,
  roles,
  cmd,
  qual
FROM pg_policies 
WHERE tablename = 'Characters'
ORDER BY policyname;

-- 2. Check current RLS policies on Character_Variations table
SELECT 
  tablename,
  policyname,
  roles,
  cmd,
  qual
FROM pg_policies 
WHERE tablename = 'Character_Variations'
ORDER BY policyname;

-- 3. Check if RLS is enabled on these tables
SELECT
  schemaname,
  tablename,
  rowsecurity
FROM pg_tables
WHERE tablename IN ('Characters', 'Character_Variations');

-- 4. Check permissions for authenticated role
SELECT 
  grantee,
  table_name,
  privilege_type
FROM information_schema.role_table_grants 
WHERE table_name IN ('Characters', 'Character_Variations', 'Games', 'Game_Variations')
AND grantee = 'authenticated'
ORDER BY table_name, privilege_type;

-- 5. Test the policy condition manually
-- This should help us understand if the policy logic is correct
SELECT 
  c.character_id,
  c.name,
  EXISTS (
    SELECT 1 FROM "Character_Variations" cv
    JOIN "Game_Variations" gv ON cv.variation_id = gv.variation_id
    JOIN "Games" g ON gv.game_id = g.game_id
    WHERE cv.character_id = c.character_id
    AND g.is_active = true
  ) as policy_check
FROM "Characters" c
LIMIT 5;

-- 6. Check if there are any active games
SELECT 
  game_id,
  title,
  is_active
FROM "Games"
WHERE is_active = true;

-- 7. Check if characters are linked to active games
SELECT 
  c.character_id,
  c.name,
  g.game_id,
  g.title,
  g.is_active
FROM "Characters" c
JOIN "Character_Variations" cv ON c.character_id = cv.character_id
JOIN "Game_Variations" gv ON cv.variation_id = gv.variation_id
JOIN "Games" g ON gv.game_id = g.game_id
WHERE g.is_active = true
LIMIT 5;

-- 8. Test a simple query as authenticated user would see it
-- This simulates what the authenticated user query would return
SELECT 
  c.character_id,
  c.name,
  c.name_bg,
  c.description,
  c.description_bg
FROM "Characters" c
JOIN "Character_Variations" cv ON c.character_id = cv.character_id
JOIN "Game_Variations" gv ON cv.variation_id = gv.variation_id
JOIN "Games" g ON gv.game_id = g.game_id
WHERE g.is_active = true
LIMIT 5;



