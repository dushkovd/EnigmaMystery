# Production Build Script
Write-Host "Building for production..." -ForegroundColor Blue

# Load production environment variables
if (Test-Path ".env.production") {
    Get-Content ".env.production" | ForEach-Object {
        if ( -match "^([^#][^=]+)=(.*)$") {
            [Environment]::SetEnvironmentVariable([1], [2], "Process")
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
