# Deploy translations fix
Write-Host "Adding AuthForm.tsx to git..." -ForegroundColor Green
git add src/components/AuthForm.tsx

Write-Host "Committing changes..." -ForegroundColor Green
git commit -m "Fix hardcoded translations in AuthForm.tsx"

Write-Host "Pushing to develop branch..." -ForegroundColor Green
git push origin develop

Write-Host "Deployment script completed!" -ForegroundColor Green
Write-Host "Check GitHub Actions for deployment status." -ForegroundColor Yellow 