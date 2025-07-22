-- Migration: Fix RLS policies for Characters to allow public access for game preview
-- This allows unauthenticated users to view character information for active games only

-- 1. Drop existing restrictive policies
DROP POLICY IF EXISTS "Allow read access to Character_Variations" ON "Character_Variations";

-- 2. Create new policy that allows public read access to Character_Variations for active games only
CREATE POLICY "Allow public read access to Character_Variations for active games" ON "Character_Variations"
  FOR SELECT USING (
    EXISTS (
      SELECT 1 FROM "Game_Variations" gv
      JOIN "Games" g ON gv.game_id = g.game_id
      WHERE gv.variation_id = "Character_Variations".variation_id
      AND g.is_active = true
    )
  );

-- 3. Add RLS policies for Characters table if not already present
DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM pg_tables 
    WHERE tablename = 'Characters' 
    AND schemaname = 'public'
  ) THEN
    RAISE NOTICE 'Characters table does not exist, skipping RLS setup';
  ELSE
    -- Enable RLS on Characters table if not already enabled
    ALTER TABLE "Characters" ENABLE ROW LEVEL SECURITY;
    
    -- Drop existing policies if they exist
    DROP POLICY IF EXISTS "Allow read access to Characters" ON "Characters";
    DROP POLICY IF EXISTS "Allow public read access to Characters" ON "Characters";
    
    -- Create new policy for Characters table - only allow access to characters that are linked to active games
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
  END IF;
END $$;

-- 4. Keep existing admin policies for authenticated users
-- These policies allow authenticated users to perform admin operations
CREATE POLICY "Allow admin access to Character_Variations" ON "Character_Variations"
  FOR ALL USING (auth.role() = 'service_role');

-- 5. Add comments explaining the new policies
COMMENT ON POLICY "Allow public read access to Character_Variations for active games" ON "Character_Variations" 
IS 'Allows unauthenticated users to read character variations for active games (for preview purposes only)';

COMMENT ON POLICY "Allow public read access to Characters for active games" ON "Characters" 
IS 'Allows unauthenticated users to read characters for active games (for preview purposes only)';

-- 6. Grant necessary permissions to anon role (only for character-related tables)
GRANT SELECT ON "Character_Variations" TO anon;
GRANT SELECT ON "Characters" TO anon;
GRANT SELECT ON "Game_Variations" TO anon;
GRANT SELECT ON "Games" TO anon; 