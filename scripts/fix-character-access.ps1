# Fix Character Access for Authenticated Users
# This script applies the RLS policy fix to allow authenticated users to see characters

Write-Host "🔧 Fixing character access for authenticated users..." -ForegroundColor Yellow

# Read the SQL fix
$sqlFix = @"
-- Fix character access for authenticated users
-- The issue is that the current RLS policies only grant access to 'public' role
-- but authenticated users use the 'authenticated' role, so they can't see characters

-- 1. Drop the existing policies that only grant access to 'public'
DROP POLICY IF EXISTS "Allow public read access to Character_Variations for active gam" ON "Character_Variations";
DROP POLICY IF EXISTS "Allow public read access to Characters for active games" ON "Characters";

-- 2. Create new policies that include both 'public' and 'authenticated' roles
CREATE POLICY "Allow public read access to Character_Variations for active games" ON "Character_Variations"
FOR SELECT
TO public, authenticated
USING (
  EXISTS (
    SELECT 1 FROM "Game_Variations" gv
    JOIN "Games" g ON gv.game_id = g.game_id
    WHERE gv.variation_id = "Character_Variations".variation_id
    AND g.is_active = true
  )
);

CREATE POLICY "Allow public read access to Characters for active games" ON "Characters"
FOR SELECT
TO public, authenticated
USING (
  EXISTS (
    SELECT 1 FROM "Character_Variations" cv
    JOIN "Game_Variations" gv ON cv.variation_id = gv.variation_id
    JOIN "Games" g ON gv.game_id = g.game_id
    WHERE cv.character_id = "Characters".character_id
    AND g.is_active = true
  )
);

-- 3. Ensure the authenticated role has SELECT permissions on the required tables
GRANT SELECT ON "Character_Variations" TO authenticated;
GRANT SELECT ON "Characters" TO authenticated;
GRANT SELECT ON "Game_Variations" TO authenticated;
GRANT SELECT ON "Games" TO authenticated;
"@

# Check if we're in the project directory
if (-not (Test-Path "supabase")) {
    Write-Host "❌ Error: Please run this script from the project root directory" -ForegroundColor Red
    exit 1
}

# Check if Supabase CLI is installed
try {
    $supabaseVersion = supabase --version
    Write-Host "✅ Supabase CLI found: $supabaseVersion" -ForegroundColor Green
} catch {
    Write-Host "❌ Error: Supabase CLI not found. Please install it first." -ForegroundColor Red
    Write-Host "Installation guide: https://supabase.com/docs/guides/cli" -ForegroundColor Yellow
    exit 1
}

# Check if we're logged in to Supabase
try {
    $projects = supabase projects list
    if ($LASTEXITCODE -ne 0) {
        Write-Host "❌ Error: Not logged in to Supabase. Please run 'supabase login' first." -ForegroundColor Red
        exit 1
    }
    Write-Host "✅ Logged in to Supabase" -ForegroundColor Green
} catch {
    Write-Host "❌ Error: Not logged in to Supabase. Please run 'supabase login' first." -ForegroundColor Red
    exit 1
}

Write-Host "🔍 Checking current project..." -ForegroundColor Yellow

# Get the current project reference
try {
    $projectRef = supabase status --output json | ConvertFrom-Json | Select-Object -ExpandProperty project_ref
    if (-not $projectRef) {
        Write-Host "❌ Error: Could not determine project reference. Make sure you're in a Supabase project." -ForegroundColor Red
        exit 1
    }
    Write-Host "✅ Project reference: $projectRef" -ForegroundColor Green
} catch {
    Write-Host "❌ Error: Could not determine project reference. Make sure you're in a Supabase project." -ForegroundColor Red
    exit 1
}

Write-Host "🚀 Applying character access fix..." -ForegroundColor Yellow

# Apply the SQL fix using Supabase CLI
try {
    # Create a temporary SQL file
    $tempFile = "temp_character_fix.sql"
    $sqlFix | Out-File -FilePath $tempFile -Encoding UTF8
    
    # Apply the fix
    supabase db reset --db-url "postgresql://postgres:[YOUR-PASSWORD]@db.$projectRef.supabase.co:5432/postgres" --file $tempFile
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✅ Character access fix applied successfully!" -ForegroundColor Green
        Write-Host "🎉 Authenticated users should now be able to see characters on game preview pages." -ForegroundColor Green
    } else {
        Write-Host "❌ Error applying the fix. Please check the error messages above." -ForegroundColor Red
    }
    
    # Clean up temporary file
    Remove-Item $tempFile -ErrorAction SilentlyContinue
    
} catch {
    Write-Host "❌ Error applying the fix: $($_.Exception.Message)" -ForegroundColor Red
    Write-Host "💡 Alternative: You can manually run the SQL commands in your Supabase dashboard." -ForegroundColor Yellow
}

Write-Host "📋 Summary of changes:" -ForegroundColor Cyan
Write-Host "   • Updated RLS policies to include 'authenticated' role" -ForegroundColor White
Write-Host "   • Granted SELECT permissions to authenticated role on character tables" -ForegroundColor White
Write-Host "   • Both anonymous and authenticated users can now see characters" -ForegroundColor White

Write-Host "🧪 To test the fix:" -ForegroundColor Cyan
Write-Host "   1. Log in to your app with a user account" -ForegroundColor White
Write-Host "   2. Navigate to a game preview page" -ForegroundColor White
Write-Host "   3. Check if the characters list is visible" -ForegroundColor White 