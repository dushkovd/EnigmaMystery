-- Step-by-step debug to find where the issue is

-- 1. Check if Game 3 is actually active
SELECT 
  game_id, 
  title, 
  is_active
FROM "Games" 
WHERE game_id = 3;

-- 2. Check if Game 3 has variations
SELECT 
  variation_id,
  game_id,
  num_players,
  variation_title
FROM "Game_Variations" 
WHERE game_id = 3
ORDER BY num_players;

-- 3. Check if variation_id 15 exists and belongs to game 3
SELECT 
  gv.variation_id,
  gv.game_id,
  gv.num_players,
  g.title as game_title,
  g.is_active
FROM "Game_Variations" gv
JOIN "Games" g ON gv.game_id = g.game_id
WHERE gv.variation_id = 15;

-- 4. Check if there are character variations for variation_id 15
SELECT 
  COUNT(*) as character_variations_for_variation_15
FROM "Character_Variations" 
WHERE variation_id = 15;

-- 5. Check if there are character variations for any Game 3 variation
SELECT 
  cv.variation_id,
  COUNT(*) as character_count
FROM "Character_Variations" cv
JOIN "Game_Variations" gv ON cv.variation_id = gv.variation_id
WHERE gv.game_id = 3
GROUP BY cv.variation_id
ORDER BY cv.variation_id;

-- 6. Test the RLS policy condition manually
SELECT 
  EXISTS (
    SELECT 1 FROM "Game_Variations" gv
    JOIN "Games" g ON gv.game_id = g.game_id
    WHERE gv.variation_id = 15
    AND g.is_active = true
  ) as policy_condition_result;

-- 7. Test if we can access Character_Variations at all
SELECT 
  COUNT(*) as total_character_variations_accessible
FROM "Character_Variations";

-- 8. Test if we can access Characters at all
SELECT 
  COUNT(*) as total_characters_accessible
FROM "Characters"; 