// Extract critical CSS for inlining
import { readFileSync, writeFileSync } from 'fs';
import { fileURLToPath } from 'url';
import { dirname, join } from 'path';

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

// Critical CSS that should be inlined for FCP
const criticalCSS = `
/* Critical CSS for FCP */
html { scroll-behavior: smooth; }
body { 
  font-family: 'Lora', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
  color: #1f2937;
  background-color: #f9fafb;
  margin: 0;
  padding: 0;
}
h1, h2, h3, h4, h5, h6 { 
  font-family: 'Playfair Display', serif;
  font-weight: 700;
  color: #1f2937;
  margin: 0;
}
#root {
  min-height: 100vh;
  display: flex;
  flex-direction: column;
}
/* Loading state */
.loading {
  display: flex;
  align-items: center;
  justify-content: center;
  min-height: 100vh;
  font-size: 1.125rem;
  color: #6b7280;
}
/* Critical layout */
.container-custom {
  max-width: 1200px;
  margin: 0 auto;
  padding: 0 1rem;
}
@media (min-width: 640px) {
  .container-custom { padding: 0 1.5rem; }
}
@media (min-width: 1024px) {
  .container-custom { padding: 0 2rem; }
}
/* Critical buttons */
.btn {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  padding: 0.75rem 1.5rem;
  border-radius: 0.375rem;
  font-weight: 500;
  transition: all 0.2s;
  border: none;
  cursor: pointer;
  text-decoration: none;
}
.btn-primary {
  background-color: #dc2626;
  color: white;
}
.btn-primary:hover {
  background-color: #b91c1c;
}
/* Critical cards */
.card {
  background: white;
  border-radius: 0.5rem;
  box-shadow: 0 1px 3px 0 rgba(0, 0, 0, 0.1);
  overflow: hidden;
  border: 1px solid #f3f4f6;
}
`;

// Read the current HTML
const htmlPath = join(__dirname, '..', 'index.html');
let html = readFileSync(htmlPath, 'utf8');

// Replace the CSS link with inline critical CSS
html = html.replace(
  /<link rel="preload" as="style" href="\/src\/index\.css">\s*<link rel="stylesheet" href="\/src\/index\.css">/,
  `<style>${criticalCSS}</style>`
);

// Add non-critical CSS loading
html = html.replace(
  '</head>',
  `<link rel="preload" as="style" href="/src/index.css" onload="this.onload=null;this.rel='stylesheet'">
<noscript><link rel="stylesheet" href="/src/index.css"></noscript>
</head>`
);

// Write the updated HTML
writeFileSync(htmlPath, html, 'utf8');

console.log('Critical CSS inlined for faster FCP');
