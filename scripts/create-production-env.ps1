# Create Production Environment File
# This script helps you create your .env.production file from the template

param(
    [Parameter(Mandatory=$false)]
    [switch]$Force
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

Write-Status "Creating production environment file..."

# Check if template exists
if (-not (Test-Path ".env.production.template")) {
    Write-Error ".env.production.template not found!"
    Write-Status "Please run .\scripts\setup-production-env.ps1 first"
    exit 1
}

# Check if .env.production already exists
if (Test-Path ".env.production") {
    if (-not $Force) {
        Write-Warning ".env.production already exists!"
        $confirmation = Read-Host "Do you want to overwrite it? (y/N)"
        if ($confirmation -ne "y" -and $confirmation -ne "Y") {
            Write-Status "Operation cancelled"
            exit 0
        }
    }
    Write-Status "Overwriting existing .env.production file..."
}

# Copy template to .env.production
try {
    Copy-Item ".env.production.template" ".env.production"
    Write-Success "Created .env.production file from template"
} catch {
    Write-Error "Failed to create .env.production file: $_"
    exit 1
}

Write-Success "Production environment file created!"
Write-Status ""
Write-Status "Next steps:"
Write-Status "1. Edit .env.production and replace the placeholder values with your actual credentials"
Write-Status "2. Test your setup with: .\scripts\test-production-build.ps1"
Write-Status ""
Write-Status "Required credentials:"
Write-Status "  - VITE_SUPABASE_URL: Your production Supabase project URL"
Write-Status "  - VITE_SUPABASE_ANON_KEY: Your production Supabase anon key"
Write-Status "  - VITE_STRIPE_PUBLIC_KEY: Your production Stripe public key" 