# Production Deployment Guide

This guide will walk you through setting up and deploying your murder mystery games website to production.

## 🚀 Quick Start

### 1. Initial Setup
```powershell
# Run the production environment setup script
.\scripts\setup-production-env.ps1 -ProductionSupabaseUrl "YOUR_PROD_SUPABASE_URL" -ProductionSupabaseAnonKey "YOUR_PROD_SUPABASE_ANON_KEY" -ProductionStripePublicKey "YOUR_PROD_STRIPE_PUBLIC_KEY" -ProductionFtpServer "YOUR_FTP_SERVER" -ProductionFtpUsername "YOUR_FTP_USERNAME" -ProductionFtpPassword "YOUR_FTP_PASSWORD"
```

### 2. Add GitHub Secrets
Go to your GitHub repository → Settings → Secrets and variables → Actions, and add:
- `PROD_SUPABASE_URL`
- `PROD_SUPABASE_ANON_KEY`
- `PROD_STRIPE_PUBLIC_KEY`
- `PROD_FTP_SERVER`
- `PROD_FTP_USERNAME`
- `PROD_FTP_PASSWORD`

### 3. Deploy
```powershell
# Test the production build locally
.\scripts\test-production-build.ps1

# Deploy to production (automatic via GitHub Actions)
git push origin main

# Or deploy manually
.\scripts\deploy-to-production.ps1
```

## 📋 Detailed Steps

### Phase 1: Environment Setup

#### 1.1 Create Production Supabase Project
1. Go to [Supabase Dashboard](https://supabase.com/dashboard)
2. Create a new project for production
3. Choose a region close to your target users
4. Select the appropriate plan (Pro recommended for production)
5. Note down the project URL and anon key

#### 1.2 Set Up Production Database
```powershell
# Run the database migration script
.\scripts\migrate-to-production.ps1 -StagingProjectId "YOUR_STAGING_PROJECT_ID" -ProductionProjectId "YOUR_PRODUCTION_PROJECT_ID"
```

#### 1.3 Configure Production Environment
```powershell
# Set up production environment variables
.\scripts\setup-production-env.ps1 -ProductionSupabaseUrl "https://your-project.supabase.co" -ProductionSupabaseAnonKey "your-anon-key" -ProductionStripePublicKey "pk_live_..." -ProductionFtpServer "your-ftp-server.com" -ProductionFtpUsername "your-username" -ProductionFtpPassword "your-password"
```

### Phase 2: GitHub Configuration

#### 2.1 Add Production Secrets
1. Go to your GitHub repository
2. Navigate to Settings → Secrets and variables → Actions
3. Add the following secrets:
   - `PROD_SUPABASE_URL`: Your production Supabase project URL
   - `PROD_SUPABASE_ANON_KEY`: Your production Supabase anon key
   - `PROD_STRIPE_PUBLIC_KEY`: Your production Stripe public key
   - `PROD_FTP_SERVER`: Your production FTP server
   - `PROD_FTP_USERNAME`: Your production FTP username
   - `PROD_FTP_PASSWORD`: Your production FTP password

#### 2.2 Set Up Environment Protection (Optional)
1. Go to Settings → Environments
2. Create a new environment called "production"
3. Add protection rules (e.g., require review, restrict to main branch)
4. Assign the production secrets to this environment

### Phase 3: Testing

#### 3.1 Test Production Build Locally
```powershell
# Test the production build
.\scripts\test-production-build.ps1

# Test with linting disabled (if needed)
.\scripts\test-production-build.ps1 -SkipLint
```

#### 3.2 Verify Environment Variables
1. Check that all environment variables are loaded correctly
2. Test database connectivity
3. Test Stripe integration with production keys
4. Verify all game data is accessible

### Phase 4: Deployment

#### 4.1 Automatic Deployment (Recommended)
```bash
# Push to main branch to trigger automatic deployment
git add .
git commit -m "Ready for production deployment"
git push origin main
```

#### 4.2 Manual Deployment
```powershell
# Deploy manually
.\scripts\deploy-to-production.ps1

# Deploy without building (if build is already done)
.\scripts\deploy-to-production.ps1 -SkipBuild

# Build without deploying
.\scripts\deploy-to-production.ps1 -SkipDeploy
```

### Phase 5: Post-Deployment Verification

#### 5.1 Basic Functionality Tests
- [ ] Website loads correctly
- [ ] User registration works
- [ ] User login works
- [ ] Game browsing works
- [ ] Payment processing works
- [ ] Game access after purchase works
- [ ] Game gameplay works

#### 5.2 Payment Testing
- [ ] Test with Stripe test cards
- [ ] Verify webhook processing
- [ ] Test payment success scenarios
- [ ] Test payment failure scenarios
- [ ] Verify order completion

#### 5.3 Security Verification
- [ ] RLS policies are working
- [ ] User access controls are enforced
- [ ] Game access restrictions are working
- [ ] Admin functionality is secure

## 🔧 Troubleshooting

### Common Issues

#### Build Failures
```powershell
# Clean and rebuild
Remove-Item -Recurse -Force dist
npm install
npm run build
```

#### Environment Variable Issues
```powershell
# Check environment variables
Get-Content .env.production
```

#### FTP Connection Issues
- Verify FTP credentials
- Check server settings
- Ensure FTPS is enabled
- Test connection manually

#### Database Connection Issues
- Verify Supabase URL and keys
- Check RLS policies
- Test with Supabase dashboard

### Debug Commands

```powershell
# Check current environment
node --version
npm --version
git branch

# Test database connection
# (Use Supabase dashboard or CLI)

# Test FTP connection
# (Use FTP client to test manually)
```

## 📊 Monitoring

### GitHub Actions
- Monitor deployment status in Actions tab
- Check for build failures
- Review deployment logs

### Application Monitoring
- Set up error tracking (Sentry, LogRocket)
- Monitor performance metrics
- Track user analytics

### Database Monitoring
- Monitor Supabase dashboard
- Check for slow queries
- Monitor storage usage

## 🔄 Maintenance

### Regular Updates
1. Keep dependencies updated
2. Monitor for security updates
3. Backup database regularly
4. Review and update environment variables

### Rollback Procedure
1. Revert to previous commit
2. Push to main branch
3. Monitor deployment
4. Verify functionality

## 📞 Support

If you encounter issues:
1. Check the troubleshooting section
2. Review GitHub Actions logs
3. Test locally with production environment
4. Contact support if needed

## 🎯 Best Practices

### Security
- Never commit secrets to version control
- Use environment variables for all sensitive data
- Regularly rotate API keys
- Monitor for security issues

### Performance
- Optimize bundle size
- Use CDN for static assets
- Monitor page load times
- Optimize database queries

### Reliability
- Test thoroughly before deployment
- Have a rollback plan
- Monitor application health
- Keep backups updated 