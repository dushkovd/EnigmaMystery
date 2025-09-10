// Build script for production environment
import { execSync } from 'child_process';

// Run the prepare-html script (will use environment variables from GitHub secrets)
console.log('Preparing HTML for production...');
execSync('node scripts/prepare-html.js', { stdio: 'inherit' });

// Run the build
console.log('Building for production...');
execSync('vite build', { stdio: 'inherit' });

console.log('Production build completed!');
