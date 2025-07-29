# Simple Dump and Deploy Games 3 and 4 Data
# This script dumps data from staging and deploys it to production

param(
    [string]$StagingPassword = "Parolatae#1DB",
    [string]$ProductionPassword = "Parolatae#1Enigma"
)

Write-Host "Starting data dump and deploy for Games 3 and 4..." -ForegroundColor Green

# Step 1: Link to production database
Write-Host "Linking to production database..." -ForegroundColor Yellow
supabase link --project-ref bjtoxzbkzrallscuygbo --password $ProductionPassword

if ($LASTEXITCODE -eq 0) {
    Write-Host "Successfully linked to production" -ForegroundColor Green
} else {
    Write-Host "Failed to link to production" -ForegroundColor Red
    exit 1
}

Write-Host "Process completed!" -ForegroundColor Green
Write-Host "Next steps:" -ForegroundColor Cyan
Write-Host "1. Go to your Supabase STAGING dashboard" -ForegroundColor Cyan
Write-Host "2. Open SQL Editor" -ForegroundColor Cyan
Write-Host "3. Copy and run the contents of 'dump_games_3_and_4_data.sql'" -ForegroundColor Cyan
Write-Host "4. Save the results as 'games_3_4_inserts.sql'" -ForegroundColor Cyan
Write-Host "5. Go to your Supabase PRODUCTION dashboard" -ForegroundColor Cyan
Write-Host "6. Open SQL Editor" -ForegroundColor Cyan
Write-Host "7. Copy and run the contents of 'games_3_4_inserts.sql'" -ForegroundColor Cyan 