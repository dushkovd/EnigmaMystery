-- Complete fix for malformed RLS policies
-- Drop all existing policies and recreate them properly

-- 1. Drop all existing policies on Character_Variations
DROP POLICY IF EXISTS "Allow admin access to Character_Variations" ON "Character_Variations";
DROP POLICY IF EXISTS "Allow public read access to Character_Variations for active gam" ON "Character_Variations";

-- 2. Drop all existing policies on Characters
DROP POLICY IF EXISTS "Allow access to characters of purchased games via variations" ON "Characters";
DROP POLICY IF EXISTS "Allow public read access to Characters for active games" ON "Characters";
DROP POLICY IF EXISTS "Users can access characters of purchased games" ON "Characters";

-- 3. Create proper RLS policy for Character_Variations (public read access for active games)
CREATE POLICY "Allow public read access to Character_Variations for active games" ON "Character_Variations"
  FOR SELECT USING (
    EXISTS (
      SELECT 1 FROM "Game_Variations" gv
      JOIN "Games" g ON gv.game_id = g.game_id
      WHERE gv.variation_id = "Character_Variations".variation_id
      AND g.is_active = true
    )
  );

-- 4. Create proper RLS policy for Characters (public read access for active games)
CREATE POLICY "Allow public read access to Characters for active games" ON "Characters"
  FOR SELECT USING (
    EXISTS (
      SELECT 1 FROM "Character_Variations" cv
      JOIN "Game_Variations" gv ON cv.variation_id = gv.variation_id
      JOIN "Games" g ON gv.game_id = g.game_id
      WHERE cv.character_id = "Characters".character_id
      AND g.is_active = true
    )
  );

-- 5. Create admin policies for service role
CREATE POLICY "Allow service role access to Character_Variations" ON "Character_Variations"
  FOR ALL USING (auth.role() = 'service_role');

CREATE POLICY "Allow service role access to Characters" ON "Characters"
  FOR ALL USING (auth.role() = 'service_role');

-- 6. Test the fixed policies
-- Test Character_Variations access
SELECT 
  COUNT(*) as character_variations_count
FROM "Character_Variations" cv
JOIN "Game_Variations" gv ON cv.variation_id = gv.variation_id
JOIN "Games" g ON gv.game_id = g.game_id
WHERE g.game_id = 3 
  AND g.is_active = true;

-- Test Characters access
SELECT 
  COUNT(*) as characters_count
FROM "Characters" c
JOIN "Character_Variations" cv ON c.character_id = cv.character_id
JOIN "Game_Variations" gv ON cv.variation_id = gv.variation_id
JOIN "Games" g ON gv.game_id = g.game_id
WHERE g.game_id = 3 
  AND g.is_active = true;

-- Test the exact query the app uses
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