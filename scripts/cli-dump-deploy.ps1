# Supabase CLI Data Dump and Deploy for Games 3 and 4
# This script uses Supabase CLI to transfer data between databases

param(
    [string]$StagingPassword = "Parolatae#1DB",
    [string]$ProductionPassword = "Parolatae#1Enigma"
)

Write-Host "Starting Supabase CLI data transfer for Games 3 and 4..." -ForegroundColor Green

# Step 1: Create a temporary migration file with the data
Write-Host "Creating data migration file..." -ForegroundColor Yellow

$migrationContent = @"
-- Data migration for Games 3 and 4
-- This migration inserts all data for games 3 and 4

-- Clear existing data for games 3 and 4 (if any)
DELETE FROM "Final_Reveal" WHERE variation_id IN (SELECT variation_id FROM "Game_Variations" WHERE game_id IN (3, 4));
DELETE FROM "Clue_Rounds" WHERE clue_id IN (SELECT c.clue_id FROM "Clues" c JOIN "Rounds" r ON c.round_id = r.round_id JOIN "Game_Variations" gv ON r.variation_id = gv.variation_id WHERE gv.game_id IN (3, 4));
DELETE FROM "Clues" WHERE round_id IN (SELECT r.round_id FROM "Rounds" r JOIN "Game_Variations" gv ON r.variation_id = gv.variation_id WHERE gv.game_id IN (3, 4));
DELETE FROM "Rounds" WHERE variation_id IN (SELECT variation_id FROM "Game_Variations" WHERE game_id IN (3, 4));
DELETE FROM "Character_Variations" WHERE variation_id IN (SELECT variation_id FROM "Game_Variations" WHERE game_id IN (3, 4));
DELETE FROM "Characters" WHERE variation_id IN (SELECT variation_id FROM "Game_Variations" WHERE game_id IN (3, 4));
DELETE FROM "Game_Variations" WHERE game_id IN (3, 4);
DELETE FROM "Games" WHERE game_id IN (3, 4);

-- Reset sequences
SELECT setval('public."Games_game_id_seq"', (SELECT COALESCE(MAX(game_id), 0) FROM "Games"));
SELECT setval('public."Game_Variations_variation_id_seq"', (SELECT COALESCE(MAX(variation_id), 0) FROM "Game_Variations"));
SELECT setval('public."Characters_character_id_seq"', (SELECT COALESCE(MAX(character_id), 0) FROM "Characters"));
SELECT setval('public."Rounds_round_id_seq"', (SELECT COALESCE(MAX(round_id), 0) FROM "Rounds"));
SELECT setval('public."Clues_clue_id_seq"', (SELECT COALESCE(MAX(clue_id), 0) FROM "Clues"));
SELECT setval('public."Final_Reveal_reveal_id_seq"', (SELECT COALESCE(MAX(reveal_id), 0) FROM "Final_Reveal"));

-- Note: The actual INSERT statements will be generated from staging and added here
-- This is a placeholder for the data migration
"@

# Create the migration file
$timestamp = Get-Date -Format "yyyyMMddHHmmss"
$migrationFile = "supabase\migrations\${timestamp}_games_3_4_data.sql"
$migrationContent | Out-File -FilePath $migrationFile -Encoding UTF8

Write-Host "Created migration file: $migrationFile" -ForegroundColor Green

# Step 2: Generate INSERT statements from staging
Write-Host "Generating INSERT statements from staging..." -ForegroundColor Yellow

# Create a temporary script to extract data from staging
$extractScript = @"
-- Extract data from staging for games 3 and 4
-- Run this in your STAGING Supabase dashboard SQL Editor

-- Copy the contents of dump_games_3_and_4_data.sql and run it
-- Save the results and replace the placeholder in the migration file
"@

$extractScript | Out-File -FilePath "extract_from_staging.sql" -Encoding UTF8

Write-Host "Created extract script: extract_from_staging.sql" -ForegroundColor Green

# Step 3: Instructions for manual steps
Write-Host "Manual steps required:" -ForegroundColor Red
Write-Host "1. Go to your STAGING Supabase dashboard" -ForegroundColor Cyan
Write-Host "2. Open SQL Editor" -ForegroundColor Cyan
Write-Host "3. Copy and run the contents of 'dump_games_3_and_4_data.sql'" -ForegroundColor Cyan
Write-Host "4. Copy all the INSERT statements from the results" -ForegroundColor Cyan
Write-Host "5. Replace the placeholder comment in '$migrationFile' with the INSERT statements" -ForegroundColor Cyan
Write-Host "6. Save the migration file" -ForegroundColor Cyan

# Step 4: Deploy to production
Write-Host "To deploy to production, run:" -ForegroundColor Yellow
Write-Host "supabase db push" -ForegroundColor White

Write-Host "Process completed! Follow the manual steps above." -ForegroundColor Green 