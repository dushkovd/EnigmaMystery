# Simple Data Migration for Games 3 and 4
# Since production is empty, we only need INSERT statements

Write-Host "Creating data migration for Games 3 and 4..." -ForegroundColor Green

# Create the migration file
$timestamp = Get-Date -Format "yyyyMMddHHmmss"
$migrationFile = "supabase\migrations\${timestamp}_games_3_4_data.sql"

$migrationContent = @"
-- Data migration for Games 3 and 4
-- This migration inserts all data for games 3 and 4

-- Note: Replace this comment with the INSERT statements from staging
-- Run the dump_games_3_and_4_data.sql in your STAGING dashboard
-- Copy all the INSERT statements and paste them here

-- Example of what will be here:
-- INSERT INTO "Games" (game_id, title, description, ...) VALUES (3, 'Game Title', 'Description', ...);
-- INSERT INTO "Game_Variations" (variation_id, game_id, num_players, ...) VALUES (...);
-- etc.
"@

$migrationContent | Out-File -FilePath $migrationFile -Encoding UTF8

Write-Host "Created migration file: $migrationFile" -ForegroundColor Green
Write-Host "" -ForegroundColor White
Write-Host "Next steps:" -ForegroundColor Cyan
Write-Host "1. Go to your STAGING Supabase dashboard" -ForegroundColor Cyan
Write-Host "2. Open SQL Editor" -ForegroundColor Cyan
Write-Host "3. Copy and run the contents of 'dump_games_3_and_4_data.sql'" -ForegroundColor Cyan
Write-Host "4. Copy all the INSERT statements from the results" -ForegroundColor Cyan
Write-Host "5. Replace the comment in '$migrationFile' with the INSERT statements" -ForegroundColor Cyan
Write-Host "6. Run: supabase db push" -ForegroundColor Cyan 