# Filter Games 3 and 4 Data from Dump
# This script extracts only the game-related data for games 3 and 4

Write-Host "Filtering games 3 and 4 data from dump..." -ForegroundColor Green

# Read the dump file
$dumpContent = Get-Content "games_3_4_data.sql" -Raw

# Create filtered content with only game-related tables
$filteredContent = @"
-- Filtered data for Games 3 and 4 only
-- Extracted from staging database dump

SET session_replication_role = replica;

-- Games data
"@

# Extract Games table data
$gamesMatches = [regex]::Matches($dumpContent, 'INSERT INTO "public"\."Games"[^;]+;')
foreach ($match in $gamesMatches) {
    if ($match.Value -match 'VALUES\s*\([^)]*3[^)]*\)' -or $match.Value -match 'VALUES\s*\([^)]*4[^)]*\)') {
        $filteredContent += "`n" + $match.Value
    }
}

# Extract Game_Variations table data
$filteredContent += "`n`n-- Game Variations data`n"
$variationsMatches = [regex]::Matches($dumpContent, 'INSERT INTO "public"\."Game_Variations"[^;]+;')
foreach ($match in $variationsMatches) {
    if ($match.Value -match 'VALUES\s*\([^)]*3[^)]*\)' -or $match.Value -match 'VALUES\s*\([^)]*4[^)]*\)') {
        $filteredContent += "`n" + $match.Value
    }
}

# Extract Characters table data
$filteredContent += "`n`n-- Characters data`n"
$charactersMatches = [regex]::Matches($dumpContent, 'INSERT INTO "public"\."Characters"[^;]+;')
foreach ($match in $charactersMatches) {
    $filteredContent += "`n" + $match.Value
}

# Extract Character_Variations table data
$filteredContent += "`n`n-- Character Variations data`n"
$charVarMatches = [regex]::Matches($dumpContent, 'INSERT INTO "public"\."Character_Variations"[^;]+;')
foreach ($match in $charVarMatches) {
    $filteredContent += "`n" + $match.Value
}

# Extract Rounds table data
$filteredContent += "`n`n-- Rounds data`n"
$roundsMatches = [regex]::Matches($dumpContent, 'INSERT INTO "public"\."Rounds"[^;]+;')
foreach ($match in $roundsMatches) {
    $filteredContent += "`n" + $match.Value
}

# Extract Clues table data
$filteredContent += "`n`n-- Clues data`n"
$cluesMatches = [regex]::Matches($dumpContent, 'INSERT INTO "public"\."Clues"[^;]+;')
foreach ($match in $cluesMatches) {
    $filteredContent += "`n" + $match.Value
}

# Extract Clue_Rounds table data
$filteredContent += "`n`n-- Clue Rounds data`n"
$clueRoundsMatches = [regex]::Matches($dumpContent, 'INSERT INTO "public"\."Clue_Rounds"[^;]+;')
foreach ($match in $clueRoundsMatches) {
    $filteredContent += "`n" + $match.Value
}

# Extract Final_Reveal table data
$filteredContent += "`n`n-- Final Reveal data`n"
$finalRevealMatches = [regex]::Matches($dumpContent, 'INSERT INTO "public"\."Final_Reveal"[^;]+;')
foreach ($match in $finalRevealMatches) {
    $filteredContent += "`n" + $match.Value
}

# Add sequence resets
$filteredContent += @"

-- Reset sequences
SELECT setval('public."Games_game_id_seq"', (SELECT COALESCE(MAX(game_id), 0) FROM "Games"));
SELECT setval('public."Game_Variations_variation_id_seq"', (SELECT COALESCE(MAX(variation_id), 0) FROM "Game_Variations"));
SELECT setval('public."Characters_character_id_seq"', (SELECT COALESCE(MAX(character_id), 0) FROM "Characters"));
SELECT setval('public."Rounds_round_id_seq"', (SELECT COALESCE(MAX(round_id), 0) FROM "Rounds"));
SELECT setval('public."Clues_clue_id_seq"', (SELECT COALESCE(MAX(clue_id), 0) FROM "Clues"));
SELECT setval('public."Final_Reveal_reveal_id_seq"', (SELECT COALESCE(MAX(reveal_id), 0) FROM "Final_Reveal"));

SET session_replication_role = DEFAULT;
"@

# Save the filtered content
$filteredContent | Out-File -FilePath "games_3_4_filtered.sql" -Encoding UTF8

Write-Host "Created filtered file: games_3_4_filtered.sql" -ForegroundColor Green
Write-Host "This file contains only game-related data for games 3 and 4" -ForegroundColor Cyan
Write-Host "You can now run this in your PRODUCTION Supabase dashboard" -ForegroundColor Cyan 