-- Migration: Add difficulty_bg field to Games table
-- This field will store the Bulgarian translation of the difficulty level

-- Add difficulty_bg column to Games table
ALTER TABLE "Games" 
ADD COLUMN IF NOT EXISTS difficulty_bg TEXT;

-- Add comment to explain the field
COMMENT ON COLUMN "Games".difficulty_bg IS 'Bulgarian translation of the difficulty level';

-- Update existing games with Bulgarian difficulty translations
UPDATE "Games" 
SET difficulty_bg = CASE 
  WHEN difficulty = 'Easy' THEN 'Лесно'
  WHEN difficulty = 'Medium' THEN 'Средно'
  WHEN difficulty = 'Hard' THEN 'Трудно'
  ELSE difficulty
END
WHERE difficulty_bg IS NULL; 