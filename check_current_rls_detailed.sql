-- Check the current RLS policies in detail

-- 1. Check all RLS policies on Character_Variations and Characters
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
WHERE tablename IN ('Character_Variations', 'Characters')
ORDER BY tablename, policyname;

-- 2. Check if RLS is enabled on these tables
SELECT
  schemaname,
  tablename,
  rowsecurity
FROM pg_tables
WHERE tablename IN ('Character_Variations', 'Characters');

-- 3. Check the exact qual clause for the anonymous policy on Character_Variations
SELECT
  policyname,
  qual
FROM pg_policies
WHERE tablename = 'Character_Variations'
AND 'anon' = ANY(roles);

-- 4. Check the exact qual clause for the anonymous policy on Characters
SELECT
  policyname,
  qual
FROM pg_policies
WHERE tablename = 'Characters'
AND 'anon' = ANY(roles);

-- 5. Test the exact qual clause manually for Character_Variations
-- (This will show us what the policy is actually checking)
SELECT
  cv.character_id,
  cv.variation_id,
  EXISTS (
    SELECT 1 FROM "Game_Variations" gv
    JOIN "Games" g ON gv.game_id = g.game_id
    WHERE gv.variation_id = cv.variation_id
    AND g.is_active = true
  ) as policy_check
FROM "Character_Variations" cv
WHERE cv.variation_id = 15
LIMIT 5;

-- 6. Test the exact qual clause manually for Characters
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
WHERE c.character_id IN (
  SELECT cv.character_id 
  FROM "Character_Variations" cv 
  WHERE cv.variation_id = 15
)
LIMIT 5; 