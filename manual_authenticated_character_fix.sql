-- Manual Fix for Authenticated User Character Access Issue
-- Run this in your Supabase SQL Editor

-- The problem: Authenticated users can't see characters because the RLS policies
-- only grant access to 'public' role, but authenticated users use 'authenticated' role.

-- Step 1: Drop the existing restrictive policies
DROP POLICY IF EXISTS "Allow public read access to Character_Variations for active gam" ON "Character_Variations";
DROP POLICY IF EXISTS "Allow public read access to Characters for active games" ON "Characters";

-- Step 2: Create new policies that include both 'public' and 'authenticated' roles
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

-- Step 3: Grant SELECT permissions to authenticated role
GRANT SELECT ON "Character_Variations" TO authenticated;
GRANT SELECT ON "Characters" TO authenticated;
GRANT SELECT ON "Game_Variations" TO authenticated;
GRANT SELECT ON "Games" TO authenticated;

-- Step 4: Verify the fix worked
-- This query should now work for both anonymous and authenticated users
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