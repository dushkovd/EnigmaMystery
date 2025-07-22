-- Test character access specifically for Game 3 (Murder on the Orient Express)
-- This game is marked as active, so characters should be visible

-- 1. First, let's verify Game 3 is active
SELECT 
  game_id, 
  title, 
  is_active,
  CASE 
    WHEN is_active = true THEN '✅ ACTIVE'
    ELSE '❌ INACTIVE'
  END as status
FROM "Games" 
WHERE game_id = 3;

-- 2. Check what variations exist for Game 3
SELECT 
  variation_id,
  num_players,
  variation_title,
  variation_title_bg
FROM "Game_Variations" 
WHERE game_id = 3
ORDER BY num_players;

-- 3. Check if there are character variations for Game 3
SELECT 
  COUNT(*) as total_character_variations,
  COUNT(DISTINCT variation_id) as unique_variations,
  COUNT(DISTINCT character_id) as unique_characters
FROM "Character_Variations" cv
JOIN "Game_Variations" gv ON cv.variation_id = gv.variation_id
WHERE gv.game_id = 3;

-- 4. Test the exact query that the app uses for Game 3
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

-- 5. Test the largest variation query (what the app actually uses)
-- First, find the largest variation for Game 3
SELECT 
  variation_id,
  num_players,
  variation_title
FROM "Game_Variations" 
WHERE game_id = 3
ORDER BY num_players DESC
LIMIT 1;

-- 6. Then test characters for that specific variation
-- (Replace VARIATION_ID with the actual variation_id from step 5)
SELECT 
  cv.character_id,
  cv.variation_id,
  c.name,
  c.name_bg,
  c.description,
  c.description_bg
FROM "Character_Variations" cv
JOIN "Characters" c ON cv.character_id = c.character_id
WHERE cv.variation_id = 15  -- This should be the largest variation for Game 3
ORDER BY c.name; 