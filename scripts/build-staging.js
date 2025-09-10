// Build script for staging environment
import { execSync } from 'child_process';

// Set staging environment variables
process.env.VITE_SUPABASE_URL = 'https://gkuwrqpxwehfnmlsqsxa.supabase.co';

// Run the prepare-html script
console.log('Preparing HTML for staging...');
execSync('node scripts/prepare-html.js', { stdio: 'inherit' });

// Run the build
console.log('Building for staging...');
execSync('vite build', { stdio: 'inherit' });

console.log('Staging build completed!');
