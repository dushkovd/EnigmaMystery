// Script to replace environment variables in HTML during build
import { readFileSync, writeFileSync } from 'fs';
import { fileURLToPath } from 'url';
import { dirname, join } from 'path';

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

// Get environment variables
const supabaseUrl = process.env.VITE_SUPABASE_URL;

if (!supabaseUrl) {
  console.error('VITE_SUPABASE_URL environment variable is required');
  process.exit(1);
}

// Read the HTML file
const htmlPath = join(__dirname, '..', 'index.html');
let html = readFileSync(htmlPath, 'utf8');

// Replace the placeholder with the actual URL
html = html.replace(/%VITE_SUPABASE_URL%/g, supabaseUrl);

// Write the updated HTML
writeFileSync(htmlPath, html, 'utf8');

console.log(`Updated HTML with Supabase URL: ${supabaseUrl}`);
