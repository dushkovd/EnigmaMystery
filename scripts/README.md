# Scripts Directory

This directory contains various scripts for managing your murder mystery games project.

## 🚀 Production Deployment Scripts

### `setup-production-env.ps1`
Sets up the production environment configuration.
```powershell
.\scripts\setup-production-env.ps1 -ProductionSupabaseUrl "YOUR_PROD_SUPABASE_URL" -ProductionSupabaseAnonKey "YOUR_PROD_SUPABASE_ANON_KEY" -ProductionStripePublicKey "YOUR_PROD_STRIPE_PUBLIC_KEY" -ProductionFtpServer "YOUR_FTP_SERVER" -ProductionFtpUsername "YOUR_FTP_USERNAME" -ProductionFtpPassword "YOUR_FTP_PASSWORD"
```

### `test-production-build.ps1`
Tests the production build locally before deployment.
```powershell
# Test with full checks
.\scripts\test-production-build.ps1

# Test without linting
.\scripts\test-production-build.ps1 -SkipLint
```

### `deploy-to-production.ps1`
Manually deploys the application to production.
```powershell
# Full deployment
.\scripts\deploy-to-production.ps1

# Deploy without building
.\scripts\deploy-to-production.ps1 -SkipBuild

# Build without deploying
.\scripts\deploy-to-production.ps1 -SkipDeploy
```

## 🗄️ Database Migration Scripts

### `migrate-to-production.ps1`
Migrates database schema from staging to production.
```powershell
.\scripts\migrate-to-production.ps1 -StagingProjectId "YOUR_STAGING_PROJECT_ID" -ProductionProjectId "YOUR_PRODUCTION_PROJECT_ID"
```

### `migrate-to-production.sh`
Linux/macOS version of the migration script.
```bash
./scripts/migrate-to-production.sh "YOUR_STAGING_PROJECT_ID" "YOUR_PRODUCTION_PROJECT_ID"
```

## 📊 Data Management Scripts

### `create-games-3-4-migration.ps1`
Creates migration files for games 3 and 4 data.
```powershell
.\scripts\create-games-3-4-migration.ps1
```

### `filter-games-3-4.ps1`
Filters and prepares games 3 and 4 data for migration.
```powershell
.\scripts\filter-games-3-4.ps1
```

### `dump-and-deploy-games-3-4.ps1`
Dumps and deploys games 3 and 4 data.
```powershell
.\scripts\dump-and-deploy-games-3-4.ps1
```

### `simple-data-migration.ps1`
Simple data migration script.
```powershell
.\scripts\simple-data-migration.ps1
```

### `simple-dump-deploy.ps1`
Simple dump and deploy script.
```powershell
.\scripts\simple-dump-deploy.ps1
```

### `simple-staging-migration.ps1`
Simple staging migration script.
```powershell
.\scripts\simple-staging-migration.ps1
```

### `apply-staging-schema.ps1`
Applies staging schema to target database.
```powershell
.\scripts\apply-staging-schema.ps1
```

### `cli-dump-deploy.ps1`
CLI-based dump and deploy script.
```powershell
.\scripts\cli-dump-deploy.ps1
```

## 🖼️ Image Management Scripts

### `migrate-images.js`
Migrates images between environments.
```javascript
node scripts/migrate-images.js
```

## 📋 Usage Examples

### Complete Production Setup
```powershell
# 1. Set up production environment
.\scripts\setup-production-env.ps1 -ProductionSupabaseUrl "https://your-project.supabase.co" -ProductionSupabaseAnonKey "your-anon-key" -ProductionStripePublicKey "pk_live_..." -ProductionFtpServer "your-ftp-server.com" -ProductionFtpUsername "your-username" -ProductionFtpPassword "your-password"

# 2. Migrate database
.\scripts\migrate-to-production.ps1 -StagingProjectId "your-staging-id" -ProductionProjectId "your-production-id"

# 3. Test production build
.\scripts\test-production-build.ps1

# 4. Deploy to production
.\scripts\deploy-to-production.ps1
```

### Quick Deployment
```powershell
# Test and deploy in one go
.\scripts\test-production-build.ps1
git push origin main  # Triggers automatic deployment
```

### Database Operations
```powershell
# Migrate schema
.\scripts\migrate-to-production.ps1 -StagingProjectId "staging-id" -ProductionProjectId "production-id"

# Migrate specific data
.\scripts\dump-and-deploy-games-3-4.ps1
```

## 🔧 Prerequisites

- Node.js (v18 or higher)
- npm
- Git
- PowerShell (for Windows scripts)
- Supabase CLI
- FTP client (for deployment)

## 📝 Notes

- All scripts include error handling and colored output
- Scripts will prompt for confirmation before destructive operations
- Environment variables are automatically loaded from `.env.production`
- Scripts check for prerequisites and provide helpful error messages

## 🚨 Important

- Always test in staging before deploying to production
- Keep backups of your production database
- Monitor deployments and verify functionality after each deployment
- Use environment protection in GitHub for production secrets 