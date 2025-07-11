-- Migration: Restructure database with junction tables for Characters and Clues
-- This eliminates duplication and makes the system more efficient

-- 1. Create new junction tables
CREATE TABLE IF NOT EXISTS "Character_Variations" (
  character_id INTEGER NOT NULL,
  variation_id INTEGER NOT NULL,
  PRIMARY KEY (character_id, variation_id),
  FOREIGN KEY (character_id) REFERENCES "Characters"(character_id) ON DELETE CASCADE,
  FOREIGN KEY (variation_id) REFERENCES "Game_Variations"(variation_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS "Clue_Rounds" (
  clue_id INTEGER NOT NULL,
  round_id INTEGER NOT NULL,
  clue_number INTEGER NOT NULL,
  PRIMARY KEY (clue_id, round_id),
  FOREIGN KEY (clue_id) REFERENCES "Clues"(clue_id) ON DELETE CASCADE,
  FOREIGN KEY (round_id) REFERENCES "Rounds"(round_id) ON DELETE CASCADE
);

-- 2. Migrate existing character data to new structure
-- First, create unique characters by removing duplicates
INSERT INTO "Character_Variations" (character_id, variation_id)
SELECT DISTINCT character_id, variation_id 
FROM "Characters" 
WHERE character_id IS NOT NULL AND variation_id IS NOT NULL;

-- 3. Migrate existing clue data to new structure
-- First, create unique clues by removing duplicates
INSERT INTO "Clue_Rounds" (clue_id, round_id, clue_number)
SELECT DISTINCT clue_id, round_id, clue_number 
FROM "Clues" 
WHERE clue_id IS NOT NULL AND round_id IS NOT NULL;

-- 4. Add indexes for better performance
CREATE INDEX IF NOT EXISTS idx_character_variations_character_id ON "Character_Variations"(character_id);
CREATE INDEX IF NOT EXISTS idx_character_variations_variation_id ON "Character_Variations"(variation_id);
CREATE INDEX IF NOT EXISTS idx_clue_rounds_clue_id ON "Clue_Rounds"(clue_id);
CREATE INDEX IF NOT EXISTS idx_clue_rounds_round_id ON "Clue_Rounds"(round_id);

-- 5. Add comments for documentation
COMMENT ON TABLE "Character_Variations" IS 'Junction table linking characters to game variations';
COMMENT ON TABLE "Clue_Rounds" IS 'Junction table linking clues to rounds';
COMMENT ON COLUMN "Character_Variations".character_id IS 'Reference to Characters table';
COMMENT ON COLUMN "Character_Variations".variation_id IS 'Reference to Game_Variations table';
COMMENT ON COLUMN "Clue_Rounds".clue_id IS 'Reference to Clues table';
COMMENT ON COLUMN "Clue_Rounds".round_id IS 'Reference to Rounds table';
COMMENT ON COLUMN "Clue_Rounds".clue_number IS 'Order of clue within the round';

-- 6. Create views for backward compatibility (optional - for existing application code)
CREATE OR REPLACE VIEW "Characters_With_Variations" AS
SELECT 
  c.*,
  cv.variation_id
FROM "Characters" c
JOIN "Character_Variations" cv ON c.character_id = cv.character_id;

CREATE OR REPLACE VIEW "Clues_With_Rounds" AS
SELECT 
  c.*,
  cr.round_id,
  cr.clue_number
FROM "Clues" c
JOIN "Clue_Rounds" cr ON c.clue_id = cr.clue_id;

-- 7. Add RLS policies for the new tables
ALTER TABLE "Character_Variations" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "Clue_Rounds" ENABLE ROW LEVEL SECURITY;

-- Allow read access to authenticated users
CREATE POLICY "Allow read access to Character_Variations" ON "Character_Variations"
  FOR SELECT USING (auth.role() = 'authenticated');

CREATE POLICY "Allow read access to Clue_Rounds" ON "Clue_Rounds"
  FOR SELECT USING (auth.role() = 'authenticated');

-- Allow insert/update/delete for service role (admin operations)
CREATE POLICY "Allow admin access to Character_Variations" ON "Character_Variations"
  FOR ALL USING (auth.role() = 'service_role');

CREATE POLICY "Allow admin access to Clue_Rounds" ON "Clue_Rounds"
  FOR ALL USING (auth.role() = 'service_role'); 