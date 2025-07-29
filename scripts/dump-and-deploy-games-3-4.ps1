# Dump and Deploy Games 3 and 4 Data
# This script dumps data from staging and deploys it to production

param(
    [string]$StagingPassword = "Parolatae#1DB",
    [string]$ProductionPassword = "Parolatae#1Enigma"
)

Write-Host "🚀 Starting data dump and deploy for Games 3 and 4..." -ForegroundColor Green

# Step 1: Link to staging database
Write-Host "📡 Linking to staging database..." -ForegroundColor Yellow
$stagingUrl = "postgresql://postgres.gkuwrqpxwehfnmlsqsxa:$StagingPassword@aws-0-eu-north-1.pooler.supabase.com:6543/postgres"

# Create temporary config for staging
$stagingConfig = @"
[api]
enabled = true
port = 54321
schemas = ["public", "storage", "graphql_public"]
extra_search_path = ["public", "extensions"]
max_rows = 1000

[db]
port = 54322
shadow_port = 54320
major_version = 15

[db.pooler]
enabled = false
port = 54329
pool_mode = "transaction"
default_pool_size = 15
max_client_conn = 100

[realtime]
enabled = true
port = 54323

[studio]
enabled = true
port = 54323
api_url = "http://127.0.0.1"

[inbucket]
enabled = true
port = 54324
smtp_port = 54325
pop3_port = 54326

[storage]
enabled = true
file_size_limit = "50MiB"

[auth]
enabled = true
site_url = "http://127.0.0.1:3000"
additional_redirect_urls = ["https://127.0.0.1:3000"]
jwt_expiry = 3600
enable_confirmations = true
secure_password_change = false
max_frequency = "1s"
otp_length = 6
otp_expiry = 3600

[auth.email.template.invite]
subject = "You have been invited"
content_path = "./supabase/templates/invite.html"

[auth.email.template.confirmation]
subject = "Confirm your signup"
content_path = "./supabase/templates/confirmation.html"

[auth.email.template.recovery]
subject = "Reset your password"
content_path = "./supabase/templates/recovery.html"

[auth.email.template.email_change]
subject = "Confirm your email change"
content_path = "./supabase/templates/email_change.html"

[auth.email.template.magic_link]
subject = "Your magic link"
content_path = "./supabase/templates/magic_link.html"

[analytics]
enabled = false
port = 54327
vector_port = 54328
"@

# Save staging config
$stagingConfig | Out-File -FilePath "supabase\config.staging.toml" -Encoding UTF8

try {
    # Step 2: Generate INSERT statements from staging
    Write-Host "📊 Generating INSERT statements from staging..." -ForegroundColor Yellow
    
    # Run the dump script against staging
    $dumpScript = Get-Content "dump_games_3_and_4_data.sql" -Raw
    
    # Create a temporary file with the staging connection
    $tempScript = @"
\set ON_ERROR_STOP on
$dumpScript
"@
    
    $tempScript | Out-File -FilePath "temp_dump_staging.sql" -Encoding UTF8
    
    # Execute against staging (you'll need to run this manually in Supabase dashboard)
    Write-Host "⚠️  Please run the following in your Supabase STAGING dashboard SQL Editor:" -ForegroundColor Red
    Write-Host "   Copy the contents of 'dump_games_3_and_4_data.sql' and execute it" -ForegroundColor Red
    Write-Host "   Save the results to a file called 'games_3_4_inserts.sql'" -ForegroundColor Red
    
    # Step 3: Link to production
    Write-Host "📡 Linking to production database..." -ForegroundColor Yellow
    supabase link --project-ref bjtoxzbkzrallscuygbo --password $ProductionPassword
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✅ Successfully linked to production" -ForegroundColor Green
    } else {
        Write-Host "❌ Failed to link to production" -ForegroundColor Red
        exit 1
    }
    
    # Step 4: Check if insert file exists
    if (Test-Path "games_3_4_inserts.sql") {
        Write-Host "📥 Found insert file, deploying to production..." -ForegroundColor Yellow
        
        # Execute the inserts against production
        Write-Host "⚠️  Please run the following in your Supabase PRODUCTION dashboard SQL Editor:" -ForegroundColor Red
        Write-Host "   Copy the contents of 'games_3_4_inserts.sql' and execute it" -ForegroundColor Red
        
    } else {
        Write-Host "❌ Insert file 'games_3_4_inserts.sql' not found" -ForegroundColor Red
        Write-Host "   Please generate it from staging first" -ForegroundColor Red
    }
    
} catch {
    Write-Host "❌ Error: $($_.Exception.Message)" -ForegroundColor Red
} finally {
    # Cleanup
    if (Test-Path "supabase\config.staging.toml") {
        Remove-Item "supabase\config.staging.toml"
    }
    if (Test-Path "temp_dump_staging.sql") {
        Remove-Item "temp_dump_staging.sql"
    }
}

Write-Host "🎉 Process completed!" -ForegroundColor Green
Write-Host "📋 Next steps:" -ForegroundColor Cyan
Write-Host "   1. Run dump_games_3_and_4_data.sql in STAGING dashboard" -ForegroundColor Cyan
Write-Host "   2. Save results as games_3_4_inserts.sql" -ForegroundColor Cyan
Write-Host "   3. Run games_3_4_inserts.sql in PRODUCTION dashboard" -ForegroundColor Cyan 