-- Test script for anonymous user access to character data
-- Run this in Supabase SQL Editor to test RLS policies

-- 1. First, let's see what games exist and if they're active
SELECT 
  game_id, 
  title, 
  is_active,
  CASE 
    WHEN is_active = true THEN '✅ ACTIVE'
    ELSE '❌ INACTIVE'
  END as status
FROM "Games" 
ORDER BY game_id;

-- 2. Check what variations exist for each game
SELECT 
  g.game_id,
  g.title as game_title,
  g.is_active,
  gv.variation_id,
  gv.num_players,
  gv.variation_title
FROM "Games" g
LEFT JOIN "Game_Variations" gv ON g.game_id = gv.game_id
ORDER BY g.game_id, gv.num_players;

-- 3. Check if Character_Variations table has data
SELECT 
  COUNT(*) as total_character_variations,
  COUNT(DISTINCT variation_id) as unique_variations,
  COUNT(DISTINCT character_id) as unique_characters
FROM "Character_Variations";

-- 4. Check what characters exist
SELECT 
  character_id,
  name,
  name_bg,
  description
FROM "Characters" 
LIMIT 5;

-- 5. Test the exact query that the app uses for game 1
-- This should work if RLS policies are correct
SELECT 
  cv.character_id,
  cv.variation_id,
  c.name,
  c.name_bg,
  c.description,
  c.description_bg
FROM "Character_Variations" cv
JOIN "Characters" c ON cv.character_id = c.character_id
JOIN "Game_Variations" gv ON cv.variation_id = gv.variation_id
JOIN "Games" g ON gv.game_id = g.game_id
WHERE g.game_id = 1 
  AND g.is_active = true
ORDER BY cv.variation_id, c.name;

-- 6. Test the exact query that the app uses for game 2
SELECT 
  cv.character_id,
  cv.variation_id,
  c.name,
  c.name_bg,
  c.description,
  c.description_bg
FROM "Character_Variations" cv
JOIN "Characters" c ON cv.character_id = c.character_id
JOIN "Game_Variations" gv ON cv.variation_id = gv.variation_id
JOIN "Games" g ON gv.game_id = g.game_id
WHERE g.game_id = 2 
  AND g.is_active = true
ORDER BY cv.variation_id, c.name;

-- 7. Check RLS policies on Character_Variations table
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
WHERE tablename = 'Character_Variations';

-- 8. Check RLS policies on Characters table
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
WHERE tablename = 'Characters';

-- 9. Check if RLS is enabled on these tables
SELECT 
  schemaname,
  tablename,
  rowsecurity
FROM pg_tables 
WHERE tablename IN ('Character_Variations', 'Characters', 'Games', 'Game_Variations')
ORDER BY tablename; 