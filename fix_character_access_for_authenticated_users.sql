-- Fix character access for authenticated users
-- The issue is that the current RLS policies only grant access to 'public' role
-- but authenticated users use the 'authenticated' role, so they can't see characters

-- 1. Drop the existing policies that only grant access to 'public'
DROP POLICY IF EXISTS "Allow public read access to Character_Variations for active gam" ON "Character_Variations";
DROP POLICY IF EXISTS "Allow public read access to Characters for active games" ON "Characters";

-- 2. Create new policies that include both 'public' and 'authenticated' roles
CREATE POLICY "Allow public read access to Character_Variations for active games" ON "Character_Variations"
FOR SELECT
TO public, authenticated
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
TO public, authenticated
USING (
  EXISTS (
    SELECT 1 FROM "Character_Variations" cv
    JOIN "Game_Variations" gv ON cv.variation_id = gv.variation_id
    JOIN "Games" g ON gv.game_id = g.game_id
    WHERE cv.character_id = "Characters".character_id
    AND g.is_active = true
  )
);

-- 3. Ensure the authenticated role has SELECT permissions on the required tables
GRANT SELECT ON "Character_Variations" TO authenticated;
GRANT SELECT ON "Characters" TO authenticated;
GRANT SELECT ON "Game_Variations" TO authenticated;
GRANT SELECT ON "Games" TO authenticated;

-- 4. Verify the policies were created correctly
SELECT
  tablename,
  policyname,
  roles,
  cmd,
  qual
FROM pg_policies
WHERE tablename IN ('Character_Variations', 'Characters')
AND policyname LIKE '%active games%'
ORDER BY tablename;

-- 5. Test the fix by checking if authenticated users can access characters
-- This query should work for both anonymous and authenticated users
SELECT 
  c.character_id,
  c.name,
  c.name_bg,
  c.description,
  c.description_bg
FROM "Characters" c
JOIN "Character_Variations" cv ON c.character_id = cv.character_id
JOIN "Game_Variations" gv ON cv.variation_id = gv.variation_id
JOIN "Games" g ON gv.game_id = g.game_id
WHERE g.is_active = true
LIMIT 5; 