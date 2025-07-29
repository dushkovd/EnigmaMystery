# Production Setup Instructions

## 1. Create Production Environment File
Copy the template and fill in your credentials:
`powershell
Copy-Item .env.production.template .env.production
`

Then edit .env.production with your actual values:
- VITE_SUPABASE_URL: Your production Supabase project URL
- VITE_SUPABASE_ANON_KEY: Your production Supabase anon key
- VITE_STRIPE_PUBLIC_KEY: Your production Stripe public key

## 2. Add GitHub Secrets
Go to your GitHub repository â†’ Settings â†’ Secrets and variables â†’ Actions
Add these secrets (use the values from production-config.template.txt):
- PROD_SUPABASE_URL
- PROD_SUPABASE_ANON_KEY
- PROD_STRIPE_PUBLIC_KEY
- PROD_FTP_SERVER
- PROD_FTP_USERNAME
- PROD_FTP_PASSWORD

## 3. Test Production Build
`powershell
.\scripts\test-production-build.ps1
`

## 4. Deploy to Production
`powershell
# Manual deployment
.\scripts\deploy-to-production.ps1

# Or automatic deployment via GitHub Actions
git push origin main
`
