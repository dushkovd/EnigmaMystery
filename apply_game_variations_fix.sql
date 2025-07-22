-- Apply RLS policy fix for Game_Variations table

-- Create new policy that includes anon role for public game preview
CREATE POLICY "Allow public read access to Game_Variations for active games" ON "Game_Variations"
FOR SELECT
TO anon
USING (
  EXISTS (
    SELECT 1 FROM "Games" g
    WHERE g.game_id = "Game_Variations".game_id
    AND g.is_active = true
  )
);

-- Verify the new policy was created
SELECT
  tablename,
  policyname,
  roles,
  cmd,
  qual
FROM pg_policies
WHERE tablename = 'Game_Variations'
ORDER BY policyname;

-- Test anonymous access to Game_Variations for Game 3
SELECT
  COUNT(*) as game_variations_count_for_anon
FROM "Game_Variations"
WHERE game_id = 3; 