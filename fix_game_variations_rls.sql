-- Check and fix RLS policies for Game_Variations table

-- 1. Check current RLS policies on Game_Variations
SELECT
  tablename,
  policyname,
  roles,
  cmd,
  qual
FROM pg_policies
WHERE tablename = 'Game_Variations'
ORDER BY policyname;

-- 2. Check if RLS is enabled on Game_Variations
SELECT
  schemaname,
  tablename,
  rowsecurity
FROM pg_tables
WHERE tablename = 'Game_Variations';

-- 3. Test anonymous access to Game_Variations for Game 3
SELECT
  COUNT(*) as game_variations_count
FROM "Game_Variations"
WHERE game_id = 3;

-- 4. If no policies exist for anon role, create them
-- Drop existing policies if they don't include anon role
DROP POLICY IF EXISTS "Allow public read access to Game_Variations for active games" ON "Game_Variations";

-- Create new policy that includes anon role
CREATE POLICY "Allow public read access to Game_Variations for active games" ON "Game_Variations"
FOR SELECT
TO public, anon
USING (
  EXISTS (
    SELECT 1 FROM "Games" g
    WHERE g.game_id = "Game_Variations".game_id
    AND g.is_active = true
  )
);

-- 5. Verify the new policy
SELECT
  tablename,
  policyname,
  roles,
  cmd,
  qual
FROM pg_policies
WHERE tablename = 'Game_Variations'
AND policyname LIKE '%active games%'; 