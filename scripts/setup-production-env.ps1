# Production Environment Setup Script
# This script helps set up the production environment configuration

param(
    [Parameter(Mandatory=$false)]
    [switch]$Interactive,
    
    [Parameter(Mandatory=$false)]
    [string]$ProductionSupabaseUrl,
    
    [Parameter(Mandatory=$false)]
    [string]$ProductionSupabaseAnonKey,
    
    [Parameter(Mandatory=$false)]
    [string]$ProductionStripePublicKey,
    
    [Parameter(Mandatory=$false)]
    [string]$ProductionFtpServer,
    
    [Parameter(Mandatory=$false)]
    [string]$ProductionFtpUsername,
    
    [Parameter(Mandatory=$false)]
    [string]$ProductionFtpPassword
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

Write-Status "Setting up production environment configuration..."

# Step 1: Create .env.production template
Write-Status "Step 1: Creating .env.production template..."
$envTemplate = @"
# Production Environment Variables
# Replace the placeholder values with your actual production credentials

# Supabase Configuration
VITE_SUPABASE_URL=https://your-production-project.supabase.co
VITE_SUPABASE_ANON_KEY=your-production-anon-key

# Stripe Configuration
VITE_STRIPE_PUBLIC_KEY=pk_live_your-production-stripe-key

# Environment
NODE_ENV=production
"@

try {
    $envTemplate | Out-File -FilePath ".env.production.template" -Encoding UTF8
    Write-Success "Created .env.production.template file"
} catch {
    Write-Error "Failed to create .env.production.template file: $_"
    exit 1
}

# Step 2: Create production deployment configuration template
Write-Status "Step 2: Creating production deployment configuration template..."
$deployConfigTemplate = @"
# Production Deployment Configuration
# Replace the placeholder values with your actual production credentials
# These values will be used as GitHub Secrets

# Supabase Configuration
PROD_SUPABASE_URL=https://your-production-project.supabase.co
PROD_SUPABASE_ANON_KEY=your-production-anon-key

# Stripe Configuration
PROD_STRIPE_PUBLIC_KEY=pk_live_your-production-stripe-key

# FTP Configuration
PROD_FTP_SERVER=your-ftp-server.com
PROD_FTP_USERNAME=your-ftp-username
PROD_FTP_PASSWORD=your-ftp-password
"@

try {
    $deployConfigTemplate | Out-File -FilePath "production-config.template.txt" -Encoding UTF8
    Write-Success "Created production-config.template.txt file"
} catch {
    Write-Error "Failed to create production-config.template.txt file: $_"
    exit 1
}

# Step 3: Update .gitignore to exclude production config
Write-Status "Step 3: Updating .gitignore..."
$gitignoreContent = @"

# Production configuration
.env.production
production-config.txt
.env.production.local
"@

try {
    $gitignoreContent | Add-Content -Path ".gitignore"
    Write-Success "Updated .gitignore to exclude production config"
} catch {
    Write-Warning "Could not update .gitignore (file might not exist or be read-only)"
}

# Step 4: Create production build script
Write-Status "Step 4: Creating production build script..."
$buildScript = @"
# Production Build Script
Write-Host "Building for production..." -ForegroundColor Blue

# Load production environment variables
if (Test-Path ".env.production") {
    Get-Content ".env.production" | ForEach-Object {
        if ($_ -match "^([^#][^=]+)=(.*)$") {
            [Environment]::SetEnvironmentVariable($matches[1], $matches[2], "Process")
        }
    }
    Write-Host "Loaded environment variables from .env.production" -ForegroundColor Green
} else {
    Write-Host "Warning: .env.production file not found" -ForegroundColor Yellow
    Write-Host "Please create .env.production file with your production credentials" -ForegroundColor Yellow
}

# Install dependencies
npm install

# Build for production
npm run build

Write-Host "Production build completed!" -ForegroundColor Green
Write-Host "Build output is in the 'dist' folder" -ForegroundColor Green
"@

try {
    $buildScript | Out-File -FilePath "scripts/build-production.ps1" -Encoding UTF8
    Write-Success "Created production build script"
} catch {
    Write-Error "Failed to create production build script: $_"
    exit 1
}

# Step 5: Create setup instructions
Write-Status "Step 5: Creating setup instructions..."
$setupInstructions = @"
# Production Setup Instructions

## 1. Create Production Environment File
Copy the template and fill in your credentials:
```powershell
Copy-Item .env.production.template .env.production
```

Then edit .env.production with your actual values:
- VITE_SUPABASE_URL: Your production Supabase project URL
- VITE_SUPABASE_ANON_KEY: Your production Supabase anon key
- VITE_STRIPE_PUBLIC_KEY: Your production Stripe public key

## 2. Add GitHub Secrets
Go to your GitHub repository → Settings → Secrets and variables → Actions
Add these secrets (use the values from production-config.template.txt):
- PROD_SUPABASE_URL
- PROD_SUPABASE_ANON_KEY
- PROD_STRIPE_PUBLIC_KEY
- PROD_FTP_SERVER
- PROD_FTP_USERNAME
- PROD_FTP_PASSWORD

## 3. Test Production Build
```powershell
.\scripts\test-production-build.ps1
```

## 4. Deploy to Production
```powershell
# Manual deployment
.\scripts\deploy-to-production.ps1

# Or automatic deployment via GitHub Actions
git push origin main
```
"@

try {
    $setupInstructions | Out-File -FilePath "PRODUCTION_SETUP_INSTRUCTIONS.md" -Encoding UTF8
    Write-Success "Created production setup instructions"
} catch {
    Write-Error "Failed to create setup instructions: $_"
    exit 1
}

Write-Success "Production environment setup completed!"
Write-Status ""
Write-Status "Next steps:"
Write-Status "1. Copy .env.production.template to .env.production and fill in your credentials"
Write-Status "2. Add the production secrets to your GitHub repository"
Write-Status "3. Test the production build locally"
Write-Status "4. Deploy to production when ready"
Write-Status ""
Write-Status "Files created:"
Write-Status "  - .env.production.template (fill in your credentials)"
Write-Status "  - production-config.template.txt (for GitHub secrets)"
Write-Status "  - scripts/build-production.ps1 (production build script)"
Write-Status "  - PRODUCTION_SETUP_INSTRUCTIONS.md (detailed instructions)" 