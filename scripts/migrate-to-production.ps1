# Migration script from staging to production
# Based on Supabase chatbot recommendations

param(
    [Parameter(Mandatory=$true)]
    [string]$StagingProjectId,
    
    [Parameter(Mandatory=$true)]
    [string]$ProductionProjectId
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

Write-Status "Starting migration from staging to production..."
Write-Status "Staging Project ID: $StagingProjectId"
Write-Status "Production Project ID: $ProductionProjectId"

# Step 1: Login to Supabase
Write-Status "Step 1: Logging in to Supabase..."
try {
    supabase login
    if ($LASTEXITCODE -ne 0) {
        throw "Failed to login to Supabase"
    }
    Write-Success "Successfully logged in to Supabase"
} catch {
    Write-Error "Failed to login to Supabase: $_"
    exit 1
}

# Step 2: Link to staging project and pull schema
Write-Status "Step 2: Linking to staging project and pulling schema..."
try {
    supabase link --project-ref $StagingProjectId
    if ($LASTEXITCODE -ne 0) {
        throw "Failed to link to staging project"
    }
    Write-Success "Successfully linked to staging project"
    
    Write-Status "Pulling existing schema from staging..."
    supabase db pull
    if ($LASTEXITCODE -ne 0) {
        throw "Failed to pull schema from staging"
    }
    Write-Success "Successfully pulled schema from staging"
} catch {
    Write-Error "Error in step 2: $_"
    exit 1
}

# Step 3: Link to production project
Write-Status "Step 3: Linking to production project..."
try {
    supabase link --project-ref $ProductionProjectId
    if ($LASTEXITCODE -ne 0) {
        throw "Failed to link to production project"
    }
    Write-Success "Successfully linked to production project"
} catch {
    Write-Error "Error in step 3: $_"
    exit 1
}

# Step 4: Generate migration files
Write-Status "Step 4: Generating migration files..."
try {
    supabase db diff -f initial_setup
    if ($LASTEXITCODE -ne 0) {
        throw "Failed to generate migration files"
    }
    Write-Success "Successfully generated migration files"
} catch {
    Write-Error "Error in step 4: $_"
    exit 1
}

# Step 5: Push migrations to production
Write-Status "Step 5: Pushing migrations to production..."
Write-Warning "This will apply all migrations to your production database!"
Write-Warning "Make sure you have a backup of your production database before proceeding."

$confirmation = Read-Host "Do you want to continue? (y/N)"
if ($confirmation -ne "y" -and $confirmation -ne "Y") {
    Write-Status "Migration cancelled by user"
    exit 0
}

try {
    supabase db push
    if ($LASTEXITCODE -ne 0) {
        throw "Failed to push migrations to production"
    }
    Write-Success "Successfully pushed migrations to production"
} catch {
    Write-Error "Error in step 5: $_"
    exit 1
}

Write-Success "Migration completed successfully!"
Write-Status "Your production database now has the same schema as staging"
Write-Status "Included in the migration:"
Write-Status "  - Tables"
Write-Status "  - Policies (Row Level Security)"
Write-Status "  - Triggers"
Write-Status "  - Functions"
Write-Status "  - Extensions" 