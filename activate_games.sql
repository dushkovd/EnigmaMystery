-- Activate games to allow character preview for anonymous users
-- This will enable the RLS policies to allow access to character data

-- Option 1: Activate all games
UPDATE "Games" 
SET is_active = true 
WHERE game_id IN (1, 2, 3);

-- Option 2: Activate only specific games (uncomment and modify as needed)
-- UPDATE "Games" 
-- SET is_active = true 
-- WHERE game_id = 1;  -- Activate only "Death at the Rosewood Estate"

-- UPDATE "Games" 
-- SET is_active = true 
-- WHERE game_id = 2;  -- Activate only "Murder on the Midnight Express"

-- Verify the changes
SELECT 
  game_id, 
  title, 
  is_active,
  CASE 
    WHEN is_active = true THEN '✅ ACTIVE'
    ELSE '❌ INACTIVE'
  END as status
FROM "Games" 
ORDER BY game_id; 