-- Comprehensive Fix for Character Access Issue
-- This addresses multiple potential causes of the problem

-- 1. First, let's check what we're working with
SELECT 'Current RLS policies on Characters:' as info;
SELECT 
  policyname,
  roles,
  cmd,
  qual
FROM pg_policies 
WHERE tablename = 'Characters';

SELECT 'Current RLS policies on Character_Variations:' as info;
SELECT 
  policyname,
  roles,
  cmd,
  qual
FROM pg_policies 
WHERE tablename = 'Character_Variations';

-- 2. Drop ALL existing policies on these tables to start fresh
DROP POLICY IF EXISTS "Allow public read access to Character_Variations for active gam" ON "Character_Variations";
DROP POLICY IF EXISTS "Allow public read access to Characters for active games" ON "Characters";
DROP POLICY IF EXISTS "Allow service role access to Character_Variations" ON "Character_Variations";
DROP POLICY IF EXISTS "Allow service role access to Characters" ON "Characters";

-- 3. Create comprehensive policies that work for all user types
-- Policy for Character_Variations - allow access to active games for all users
CREATE POLICY "Allow read access to Character_Variations for active games" ON "Character_Variations"
FOR SELECT
TO public, authenticated, anon
USING (
  EXISTS (
    SELECT 1 FROM "Game_Variations" gv
    JOIN "Games" g ON gv.game_id = g.game_id
    WHERE gv.variation_id = "Character_Variations".variation_id
    AND g.is_active = true
  )
);

-- Policy for Characters - allow access to active games for all users
CREATE POLICY "Allow read access to Characters for active games" ON "Characters"
FOR SELECT
TO public, authenticated, anon
USING (
  EXISTS (
    SELECT 1 FROM "Character_Variations" cv
    JOIN "Game_Variations" gv ON cv.variation_id = gv.variation_id
    JOIN "Games" g ON gv.game_id = g.game_id
    WHERE cv.character_id = "Characters".character_id
    AND g.is_active = true
  )
);

-- 4. Create admin policies for service role
CREATE POLICY "Allow service role access to Character_Variations" ON "Character_Variations"
FOR ALL
TO public
USING (auth.role() = 'service_role');

CREATE POLICY "Allow service role access to Characters" ON "Characters"
FOR ALL
TO public
USING (auth.role() = 'service_role');

-- 5. Grant ALL necessary permissions to ALL roles
GRANT SELECT ON "Character_Variations" TO authenticated, anon, public;
GRANT SELECT ON "Characters" TO authenticated, anon, public;
GRANT SELECT ON "Game_Variations" TO authenticated, anon, public;
GRANT SELECT ON "Games" TO authenticated, anon, public;

-- 6. Verify the new policies
SELECT 'New RLS policies on Characters:' as info;
SELECT 
  policyname,
  roles,
  cmd,
  qual
FROM pg_policies 
WHERE tablename = 'Characters';

SELECT 'New RLS policies on Character_Variations:' as info;
SELECT 
  policyname,
  roles,
  cmd,
  qual
FROM pg_policies 
WHERE tablename = 'Character_Variations';

-- 7. Test the fix with a comprehensive query
SELECT 'Testing character access - should return results:' as info;
SELECT 
  c.character_id,
  c.name,
  c.name_bg,
  c.description,
  c.description_bg,
  g.title as game_title,
  g.is_active
FROM "Characters" c
JOIN "Character_Variations" cv ON c.character_id = cv.character_id
JOIN "Game_Variations" gv ON cv.variation_id = gv.variation_id
JOIN "Games" g ON gv.game_id = g.game_id
WHERE g.is_active = true
LIMIT 5;



