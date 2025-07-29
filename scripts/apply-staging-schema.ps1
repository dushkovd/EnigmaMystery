# Script to apply staging schema to production
# This applies only the single comprehensive migration file

param(
    [Parameter(Mandatory=$true)]
    [string]$ProductionPassword
)

# Function to print colored output
function Write-Status {
    param([string]$Message)
    Write-Host "[INFO] $Message" -ForegroundColor Blue
}

function Write-Success {
    param([string]$Message)
    Write-Host "[SUCCESS] $Message" -ForegroundColor Green
}

function Write-Warning {
    param([string]$Message)
    Write-Host "[WARNING] $Message" -ForegroundColor Yellow
}

function Write-Error {
    param([string]$Message)
    Write-Host "[ERROR] $Message" -ForegroundColor Red
}

Write-Status "Applying staging schema to production..."

# URL encode the password (replace # with %23)
$encodedPassword = $ProductionPassword -replace "#", "%23"

# Create the database URL
$dbUrl = "postgresql://postgres.bjtoxzbkzrallscuygbo:$encodedPassword@aws-0-eu-north-1.pooler.supabase.com:6543/postgres"

Write-Status "Connecting to production database..."

# Apply the single migration file
try {
    Write-Warning "This will apply the complete staging schema to production!"
    Write-Warning "Make sure you have a backup of your production database."
    
    $confirmation = Read-Host "Do you want to continue? (y/N)"
    if ($confirmation -ne "y" -and $confirmation -ne "Y") {
        Write-Status "Operation cancelled by user"
        exit 0
    }
    
    # First, backup existing migrations
    Write-Status "Backing up existing migrations..."
    if (Test-Path "supabase/migrations/backup") {
        Remove-Item "supabase/migrations/backup" -Recurse -Force
    }
    New-Item -ItemType Directory -Path "supabase/migrations/backup" -Force | Out-Null
    
    # Move all existing migrations to backup
    Get-ChildItem "supabase/migrations/*.sql" | Where-Object { $_.Name -ne "20250128000001_staging_to_production_complete.sql" } | ForEach-Object {
        Move-Item $_.FullName "supabase/migrations/backup/"
    }
    
    Write-Status "Applying migration to production using Supabase CLI..."
    
    # Use Supabase CLI to push the single migration
    $result = supabase db push --db-url $dbUrl 2>&1
    
    if ($LASTEXITCODE -eq 0) {
        Write-Success "Migration applied successfully!"
        Write-Status "Production database now matches staging schema"
    } else {
        throw "Migration failed: $result"
    }
    
    # Restore original migrations
    Write-Status "Restoring original migrations..."
    Get-ChildItem "supabase/migrations/backup/*.sql" | ForEach-Object {
        Move-Item $_.FullName "supabase/migrations/"
    }
    Remove-Item "supabase/migrations/backup" -Recurse -Force
    
} catch {
    Write-Error "Error applying migration: $_"
    
    # Restore original migrations on error
    if (Test-Path "supabase/migrations/backup") {
        Write-Status "Restoring original migrations due to error..."
        Get-ChildItem "supabase/migrations/backup/*.sql" | ForEach-Object {
            Move-Item $_.FullName "supabase/migrations/"
        }
        Remove-Item "supabase/migrations/backup" -Recurse -Force
    }
    
    exit 1
}

Write-Success "Staging to production migration completed!" 