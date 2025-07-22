-- Simple test for Game 3 characters (fixing the ambiguous column issue)

-- 1. Check if Game 3 has character variations
SELECT 
  COUNT(*) as total_character_variations
FROM "Character_Variations" cv
JOIN "Game_Variations" gv ON cv.variation_id = gv.variation_id
WHERE gv.game_id = 3;

-- 2. Test the exact query that the app uses for Game 3
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

-- 3. Test the largest variation (10 players) specifically
SELECT 
  cv.character_id,
  cv.variation_id,
  c.name,
  c.name_bg,
  c.description,
  c.description_bg
FROM "Character_Variations" cv
JOIN "Characters" c ON cv.character_id = c.character_id
WHERE cv.variation_id = 15  -- 10-player variation for Game 3
ORDER BY c.name; 