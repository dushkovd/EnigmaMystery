-- Migration: Fix character access for anonymous users
-- The issue is that the current RLS policies only grant access to 'public' role
-- but anonymous users use the 'anon' role, so they can't see characters

-- 1. Drop the existing policies that only grant access to 'public'
DROP POLICY IF EXISTS "Allow public read access to Character_Variations for active gam" ON "Character_Variations";
DROP POLICY IF EXISTS "Allow public read access to Characters for active games" ON "Characters";

-- 2. Create new policies that include both 'public' and 'anon' roles
CREATE POLICY "Allow public read access to Character_Variations for active games" ON "Character_Variations"
FOR SELECT
TO public, anon
USING (
  EXISTS (
    SELECT 1 FROM "Game_Variations" gv
    JOIN "Games" g ON gv.game_id = g.game_id
    WHERE gv.variation_id = "Character_Variations".variation_id
    AND g.is_active = true
  )
);

CREATE POLICY "Allow public read access to Characters for active games" ON "Characters"
FOR SELECT
TO public, anon
USING (
  EXISTS (
    SELECT 1 FROM "Character_Variations" cv
    JOIN "Game_Variations" gv ON cv.variation_id = gv.variation_id
    JOIN "Games" g ON gv.game_id = g.game_id
    WHERE cv.character_id = "Characters".character_id
    AND g.is_active = true
  )
);

-- 3. Ensure the anon role has SELECT permissions on the required tables
GRANT SELECT ON "Character_Variations" TO anon;
GRANT SELECT ON "Characters" TO anon;
GRANT SELECT ON "Game_Variations" TO anon;
GRANT SELECT ON "Games" TO anon; 