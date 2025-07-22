-- Fix RLS policies for Characters table
-- The current policies have incomplete qual clauses

-- 1. Drop the existing incomplete policies
DROP POLICY IF EXISTS "Allow public read access to Characters for active games" ON "Characters";
DROP POLICY IF EXISTS "Allow access to characters of purchased games via variations" ON "Characters";
DROP POLICY IF EXISTS "Users can access characters of purchased games" ON "Characters";

-- 2. Create a proper policy for public read access to characters for active games
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

-- 3. Create a policy for authenticated users to access characters of purchased games
CREATE POLICY "Allow authenticated users to access characters of purchased games" ON "Characters"
  FOR SELECT USING (
    EXISTS (
      SELECT 1 FROM "Character_Variations" cv
      JOIN "Game_Variations" gv ON cv.variation_id = gv.variation_id
      JOIN "Order_Items" oi ON gv.game_id = oi.game_id
      JOIN "Orders" o ON oi.order_id = o.order_id
      WHERE cv.character_id = "Characters".character_id
      AND o.user_id = auth.uid()
      AND o.status = 'completed'
    )
  );

-- 4. Create a policy for service role (admin access)
CREATE POLICY "Allow service role access to Characters" ON "Characters"
  FOR ALL USING (auth.role() = 'service_role');

-- 5. Test the fixed policy
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