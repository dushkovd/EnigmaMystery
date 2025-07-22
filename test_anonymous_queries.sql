-- Test queries as anonymous user to see RLS restrictions
-- Run these queries to simulate what anonymous users can access

-- 1. First, let's see what the current user role is
SELECT 
  current_user as current_user,
  session_user as session_user,
  auth.role() as auth_role;

-- 2. Test if anonymous user can access Games table
SELECT 
  game_id, 
  title, 
  is_active
FROM "Games" 
WHERE game_id = 3
LIMIT 1;

-- 3. Test if anonymous user can access Game_Variations table
SELECT 
  variation_id,
  game_id,
  num_players,
  variation_title
FROM "Game_Variations" 
WHERE game_id = 3
ORDER BY num_players DESC
LIMIT 1;

-- 4. Test if anonymous user can access Character_Variations table
SELECT 
  character_id,
  variation_id
FROM "Character_Variations" 
WHERE variation_id = 15
LIMIT 5;

-- 5. Test if anonymous user can access Characters table directly
SELECT 
  character_id,
  name,
  name_bg,
  description
FROM "Characters" 
LIMIT 5;

-- 6. Test the exact query that the app uses (this should fail if RLS is blocking)
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

-- 7. Test the largest variation query (what the app actually uses)
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