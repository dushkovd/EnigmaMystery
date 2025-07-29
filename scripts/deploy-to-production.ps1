# Production Deployment Script
# This script manually deploys the application to production

param(
    [Parameter(Mandatory=$false)]
    [switch]$SkipBuild,
    
    [Parameter(Mandatory=$false)]
    [switch]$SkipDeploy,
    
    [Parameter(Mandatory=$false)]
    [string]$EnvironmentFile = ".env.production"
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

Write-Status "Starting production deployment..."

# Step 1: Check if we're on the main branch
Write-Status "Step 1: Checking current branch..."
try {
    $currentBranch = git branch --show-current
    if ($currentBranch -ne "main") {
        Write-Warning "You are not on the main branch (current: $currentBranch)"
        $confirmation = Read-Host "Do you want to continue anyway? (y/N)"
        if ($confirmation -ne "y" -and $confirmation -ne "Y") {
            Write-Status "Deployment cancelled"
            exit 0
        }
    } else {
        Write-Success "On main branch"
    }
} catch {
    Write-Warning "Could not determine current branch: $_"
}

# Step 2: Check for uncommitted changes
Write-Status "Step 2: Checking for uncommitted changes..."
try {
    $status = git status --porcelain
    if ($status) {
        Write-Warning "You have uncommitted changes:"
        Write-Host $status
        $confirmation = Read-Host "Do you want to continue anyway? (y/N)"
        if ($confirmation -ne "y" -and $confirmation -ne "Y") {
            Write-Status "Deployment cancelled"
            exit 0
        }
    } else {
        Write-Success "No uncommitted changes"
    }
} catch {
    Write-Warning "Could not check git status: $_"
}

# Step 3: Load environment variables
Write-Status "Step 3: Loading environment variables..."
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

# Step 4: Build the project
if (-not $SkipBuild) {
    Write-Status "Step 4: Building the project..."
    try {
        # Install dependencies
        Write-Status "Installing dependencies..."
        npm install
        if ($LASTEXITCODE -ne 0) {
            throw "npm install failed"
        }
        
        # Build for production
        Write-Status "Building for production..."
        npm run build
        if ($LASTEXITCODE -ne 0) {
            throw "npm run build failed"
        }
        
        Write-Success "Build completed successfully"
    } catch {
        Write-Error "Build failed: $_"
        exit 1
    }
} else {
    Write-Status "Step 4: Skipping build (--SkipBuild flag used)"
}

# Step 5: Deploy to production
if (-not $SkipDeploy) {
    Write-Status "Step 5: Deploying to production..."
    
    # Check if FTP credentials are available
    $ftpServer = $env:PROD_FTP_SERVER
    $ftpUsername = $env:PROD_FTP_USERNAME
    $ftpPassword = $env:PROD_FTP_PASSWORD
    
    if (-not $ftpServer -or -not $ftpUsername -or -not $ftpPassword) {
        Write-Error "FTP credentials not found in environment variables"
        Write-Status "Please set PROD_FTP_SERVER, PROD_FTP_USERNAME, and PROD_FTP_PASSWORD"
        exit 1
    }
    
    Write-Warning "About to deploy to production server: $ftpServer"
    $confirmation = Read-Host "Do you want to continue? (y/N)"
    if ($confirmation -ne "y" -and $confirmation -ne "Y") {
        Write-Status "Deployment cancelled"
        exit 0
    }
    
    try {
        # Use WinSCP for FTP deployment (if available)
        if (Get-Command "winscp" -ErrorAction SilentlyContinue) {
            Write-Status "Using WinSCP for deployment..."
            
            $winscpScript = @"
option batch abort
option confirm off
open ftps://$ftpUsername`:$ftpPassword@$ftpServer
synchronize remote ./dist/ ./
close
exit
"@
            
            $winscpScript | winscp /command=-
            
            if ($LASTEXITCODE -eq 0) {
                Write-Success "Deployment completed successfully using WinSCP"
            } else {
                throw "WinSCP deployment failed"
            }
        } else {
            Write-Status "WinSCP not found, using PowerShell FTP..."
            
            # Create FTP session
            $ftp = [System.Net.FtpWebRequest]::Create("ftp://$ftpServer/")
            $ftp.Credentials = New-Object System.Net.NetworkCredential($ftpUsername, $ftpPassword)
            $ftp.Method = [System.Net.WebRequestMethods+Ftp]::ListDirectory
            
            try {
                $response = $ftp.GetResponse()
                Write-Success "FTP connection successful"
                $response.Close()
            } catch {
                Write-Error "FTP connection failed: $_"
                Write-Status "Please check your FTP credentials and server settings"
                exit 1
            }
            
            Write-Warning "PowerShell FTP upload not implemented"
            Write-Status "Please use WinSCP or manually upload the dist folder"
        }
    } catch {
        Write-Error "Deployment failed: $_"
        exit 1
    }
} else {
    Write-Status "Step 5: Skipping deployment (--SkipDeploy flag used)"
}

Write-Success "Production deployment process completed!"
Write-Status ""
Write-Status "Next steps:"
Write-Status "1. Verify the deployment by visiting your production website"
Write-Status "2. Test all functionality (user registration, payments, games)"
Write-Status "3. Monitor for any errors or issues"
Write-Status "4. Check that all environment variables are working correctly" 