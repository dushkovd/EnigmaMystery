# Production Build Test Script
# This script tests the production build locally

param(
    [Parameter(Mandatory=$false)]
    [string]$EnvironmentFile = ".env.production",
    
    [Parameter(Mandatory=$false)]
    [switch]$SkipLint,
    
    [Parameter(Mandatory=$false)]
    [switch]$SkipTests
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

Write-Status "Starting production build test..."

# Step 1: Check prerequisites
Write-Status "Step 1: Checking prerequisites..."
try {
    $nodeVersion = node --version
    Write-Success "Node.js version: $nodeVersion"
} catch {
    Write-Error "Node.js not found. Please install Node.js first."
    exit 1
}

try {
    $npmVersion = npm --version
    Write-Success "npm version: $npmVersion"
} catch {
    Write-Error "npm not found. Please install npm first."
    exit 1
}

# Step 2: Load environment variables
Write-Status "Step 2: Loading environment variables..."
if (Test-Path $EnvironmentFile) {
    try {
        Get-Content $EnvironmentFile | ForEach-Object {
            if ($_ -match "^([^#][^=]+)=(.*)$") {
                [Environment]::SetEnvironmentVariable($matches[1], $matches[2], "Process")
            }
        }
        Write-Success "Loaded environment variables from $EnvironmentFile"
    } catch {
        Write-Error "Failed to load environment variables: $_"
        exit 1
    }
} else {
    Write-Warning "Environment file $EnvironmentFile not found"
    Write-Status "Make sure your environment variables are set manually"
}

# Step 3: Clean previous build
Write-Status "Step 3: Cleaning previous build..."
try {
    if (Test-Path "dist") {
        Remove-Item -Recurse -Force "dist"
        Write-Success "Cleaned previous build"
    }
} catch {
    Write-Warning "Could not clean previous build: $_"
}

# Step 4: Install dependencies
Write-Status "Step 4: Installing dependencies..."
try {
    npm ci
    if ($LASTEXITCODE -ne 0) {
        throw "npm ci failed"
    }
    Write-Success "Dependencies installed successfully"
} catch {
    Write-Error "Failed to install dependencies: $_"
    exit 1
}

# Step 5: Run linting (if not skipped)
if (-not $SkipLint) {
    Write-Status "Step 5: Running linting..."
    try {
        npm run lint
        if ($LASTEXITCODE -ne 0) {
            Write-Warning "Linting found issues. Please fix them before deployment."
            $confirmation = Read-Host "Do you want to continue anyway? (y/N)"
            if ($confirmation -ne "y" -and $confirmation -ne "Y") {
                Write-Status "Build test cancelled"
                exit 0
            }
        } else {
            Write-Success "Linting passed"
        }
    } catch {
        Write-Warning "Linting failed: $_"
        $confirmation = Read-Host "Do you want to continue anyway? (y/N)"
        if ($confirmation -ne "y" -and $confirmation -ne "Y") {
            Write-Status "Build test cancelled"
            exit 0
        }
    }
} else {
    Write-Status "Step 5: Skipping linting (--SkipLint flag used)"
}

# Step 6: Build for production
Write-Status "Step 6: Building for production..."
try {
    npx vite build
    if ($LASTEXITCODE -ne 0) {
        throw "npx vite build failed"
    }
    Write-Success "Production build completed successfully"
} catch {
    Write-Error "Production build failed: $_"
    exit 1
}

# Step 7: Verify build output
Write-Status "Step 7: Verifying build output..."
try {
    if (-not (Test-Path "dist")) {
        throw "dist folder not found"
    }
    
    $distFiles = Get-ChildItem -Path "dist" -Recurse
    Write-Success "Build output contains $($distFiles.Count) files"
    
    # Check for essential files
    $essentialFiles = @("index.html", "assets")
    foreach ($file in $essentialFiles) {
        if (Test-Path "dist\$file") {
            Write-Success "Found essential file: $file"
        } else {
            Write-Warning "Missing essential file: $file"
        }
    }
} catch {
    Write-Error "Build verification failed: $_"
    exit 1
}

# Step 8: Check bundle size
Write-Status "Step 8: Checking bundle size..."
try {
    $assetsFolder = "dist\assets"
    if (Test-Path $assetsFolder) {
        $jsFiles = Get-ChildItem -Path $assetsFolder -Filter "*.js" | Measure-Object -Property Length -Sum
        $cssFiles = Get-ChildItem -Path $assetsFolder -Filter "*.css" | Measure-Object -Property Length -Sum
        
        $totalSizeMB = ($jsFiles.Sum + $cssFiles.Sum) / 1MB
        
        Write-Success "Total bundle size: $([math]::Round($totalSizeMB, 2)) MB"
        
        if ($totalSizeMB -gt 5) {
            Write-Warning "Bundle size is large ($([math]::Round($totalSizeMB, 2)) MB). Consider optimization."
        }
    }
} catch {
    Write-Warning "Could not check bundle size: $_"
}

# Step 9: Test production build locally
Write-Status "Step 9: Testing production build locally..."
try {
    Write-Status "Starting local server for testing..."
    $serverProcess = Start-Process -FilePath "npm" -ArgumentList "run", "preview" -PassThru -WindowStyle Hidden
    
    Start-Sleep -Seconds 3
    
    Write-Success "Local server started (PID: $($serverProcess.Id))"
    Write-Status "You can now test the production build at: http://localhost:4173"
    Write-Status "Press Ctrl+C to stop the server when done testing"
    
    try {
        $serverProcess.WaitForExit()
    } catch {
        Write-Status "Server stopped"
    }
} catch {
    Write-Warning "Could not start local server: $_"
    Write-Status "You can manually test the build by running: npm run preview"
}

Write-Success "Production build test completed!"
Write-Status ""
Write-Status "Summary:"
Write-Status "- Dependencies installed"
if (-not $SkipLint) { Write-Status "- Linting completed" }
Write-Status "- Production build successful"
Write-Status "- Build output verified"
Write-Status ""
Write-Status "Next steps:"
Write-Status "1. Test the application functionality in the local preview"
Write-Status "2. Verify all environment variables are working"
Write-Status "3. Test payment processing with production keys"
Write-Status "4. Deploy to production when ready" 