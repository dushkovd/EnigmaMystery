# Simple script to apply staging schema to production
# This uses a direct approach without complex migration management

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

Write-Warning "This will apply the complete staging schema to production!"
Write-Warning "Make sure you have a backup of your production database."
Write-Warning "This approach will reset the production database schema!"

$confirmation = Read-Host "Do you want to continue? (y/N)"
if ($confirmation -ne "y" -and $confirmation -ne "Y") {
    Write-Status "Operation cancelled by user"
    exit 0
}

try {
    # Create a temporary directory with only our migration
    Write-Status "Creating temporary migration directory..."
    $tempDir = "temp_migrations_$(Get-Date -Format 'yyyyMMdd_HHmmss')"
    New-Item -ItemType Directory -Path $tempDir -Force | Out-Null
    New-Item -ItemType Directory -Path "$tempDir/supabase" -Force | Out-Null
    New-Item -ItemType Directory -Path "$tempDir/supabase/migrations" -Force | Out-Null
    
    # Copy our migration file
    Copy-Item "supabase/migrations/20250128000001_staging_to_production_complete.sql" "$tempDir/supabase/migrations/"
    
    # Change to temp directory
    Push-Location $tempDir
    
    Write-Status "Applying migration to production..."
    
    # Use Supabase CLI to push the migration
    $result = supabase db push --db-url "postgresql://postgres.bjtoxzbkzrallscuygbo:$encodedPassword@aws-0-eu-north-1.pooler.supabase.com:6543/postgres" 2>&1
    
    # Return to original directory
    Pop-Location
    
    if ($LASTEXITCODE -eq 0) {
        Write-Success "Migration applied successfully!"
        Write-Status "Production database now matches staging schema"
    } else {
        throw "Migration failed: $result"
    }
    
} catch {
    Write-Error "Error applying migration: $_"
    exit 1
} finally {
    # Clean up temp directory
    if (Test-Path $tempDir) {
        Remove-Item $tempDir -Recurse -Force -ErrorAction SilentlyContinue
    }
}

Write-Success "Staging to production migration completed!" 