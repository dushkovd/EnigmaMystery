-- Final test to verify anonymous access is working

-- Test the exact query that the app uses for Game 3
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

-- Test the largest variation query specifically
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