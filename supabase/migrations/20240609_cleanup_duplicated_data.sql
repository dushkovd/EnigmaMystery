-- Migration: Clean up duplicated data and create unique characters/clues
-- This creates the foundation for the new junction table structure

-- 1. Create temporary tables to store unique character data
CREATE TEMP TABLE unique_characters AS
SELECT DISTINCT 
  name, name_bg, description, description_bg, 
  secret, secret_bg, connection, connection_bg, 
  circumstances, circumstances_bg
FROM "Characters"
WHERE name IS NOT NULL;

-- 2. Create temporary table to store unique clue data
CREATE TEMP TABLE unique_clues AS
SELECT DISTINCT 
  content, content_bg
FROM "Clues"
WHERE content IS NOT NULL;

-- 3. Create new unique character IDs
CREATE SEQUENCE IF NOT EXISTS new_character_id_seq START 1000;
CREATE SEQUENCE IF NOT EXISTS new_clue_id_seq START 2000;

-- 4. Create mapping tables for the migration
CREATE TEMP TABLE character_mapping AS
SELECT 
  c.character_id as old_id,
  (SELECT nextval('new_character_id_seq')) as new_id,
  c.name, c.name_bg, c.description, c.description_bg,
  c.secret, c.secret_bg, c.connection, c.connection_bg,
  c.circumstances, c.circumstances_bg
FROM "Characters" c
WHERE c.name IS NOT NULL;

CREATE TEMP TABLE clue_mapping AS
SELECT 
  cl.clue_id as old_id,
  (SELECT nextval('new_clue_id_seq')) as new_id,
  cl.content, cl.content_bg
FROM "Clues" cl
WHERE cl.content IS NOT NULL;

-- 5. Backup existing junction data
CREATE TEMP TABLE backup_character_variations AS
SELECT character_id, variation_id FROM "Character_Variations";

CREATE TEMP TABLE backup_clue_rounds AS
SELECT clue_id, round_id, clue_number FROM "Clue_Rounds";

-- 6. Clear existing junction tables
DELETE FROM "Character_Variations";
DELETE FROM "Clue_Rounds";

-- 7. Insert unique characters with new IDs
INSERT INTO "Characters" (
  character_id, name, name_bg, description, description_bg,
  secret, secret_bg, connection, connection_bg,
  circumstances, circumstances_bg
)
SELECT 
  new_id, name, name_bg, description, description_bg,
  secret, secret_bg, connection, connection_bg,
  circumstances, circumstances_bg
FROM character_mapping;

-- 8. Insert unique clues with new IDs
INSERT INTO "Clues" (
  clue_id, content, content_bg
)
SELECT 
  new_id, content, content_bg
FROM clue_mapping;

-- 9. Recreate character-variation relationships using new IDs
INSERT INTO "Character_Variations" (character_id, variation_id)
SELECT DISTINCT
  cm.new_id as character_id,
  cv.variation_id
FROM backup_character_variations cv
JOIN character_mapping cm ON cv.character_id = cm.old_id;

-- 10. Recreate clue-round relationships using new IDs
INSERT INTO "Clue_Rounds" (clue_id, round_id, clue_number)
SELECT DISTINCT
  clm.new_id as clue_id,
  cr.round_id,
  cr.clue_number
FROM backup_clue_rounds cr
JOIN clue_mapping clm ON cr.clue_id = clm.old_id;

-- 11. Clean up old duplicate records (keep only the new unique ones)
DELETE FROM "Characters" 
WHERE character_id NOT IN (
  SELECT new_id FROM character_mapping
);

DELETE FROM "Clues" 
WHERE clue_id NOT IN (
  SELECT new_id FROM clue_mapping
);

-- 12. Drop temporary tables and sequences
DROP TABLE unique_characters;
DROP TABLE unique_clues;
DROP TABLE character_mapping;
DROP TABLE clue_mapping;
DROP TABLE backup_character_variations;
DROP TABLE backup_clue_rounds;
DROP SEQUENCE new_character_id_seq;
DROP SEQUENCE new_clue_id_seq; 