-- Test if the RLS policies are working after the fix

-- 1. Check current RLS policies to make sure they were applied
SELECT 
  tablename,
  policyname,
  cmd,
  qual
FROM pg_policies 
WHERE tablename IN ('Character_Variations', 'Characters')
ORDER BY tablename, policyname;

-- 2. Test anonymous access to Character_Variations
SELECT 
  COUNT(*) as character_variations_count
FROM "Character_Variations" cv
JOIN "Game_Variations" gv ON cv.variation_id = gv.variation_id
JOIN "Games" g ON gv.game_id = g.game_id
WHERE g.game_id = 3 
  AND g.is_active = true;

-- 3. Test anonymous access to Characters
SELECT 
  COUNT(*) as characters_count
FROM "Characters" c
JOIN "Character_Variations" cv ON c.character_id = cv.character_id
JOIN "Game_Variations" gv ON cv.variation_id = gv.variation_id
JOIN "Games" g ON gv.game_id = g.game_id
WHERE g.game_id = 3 
  AND g.is_active = true;

-- 4. Test the exact query the app uses
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
WHERE g.game_id = 3 
  AND g.is_active = true
ORDER BY cv.variation_id, c.name;

-- 5. Test the largest variation query specifically
SELECT 
  cv.character_id,
  cv.variation_id,
  c.name,
  c.name_bg,
  c.description,
  c.description_bg
FROM "Character_Variations" cv
JOIN "Characters" c ON cv.character_id = c.character_id
WHERE cv.variation_id = 15
ORDER BY c.name; 