import { defineConfig } from 'vite';
import react from '@vitejs/plugin-react';
import { visualizer } from 'rollup-plugin-visualizer';

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [
    react(),
    visualizer({
      filename: 'dist/stats.html',
      open: true,
      gzipSize: true,
      brotliSize: true,
    })
  ],
  publicDir: 'public',
  optimizeDeps: {
    exclude: ['lucide-react'],
  },
  build: {
    target: 'esnext',
    minify: 'esbuild',
    cssCodeSplit: false,
    sourcemap: false,
    rollupOptions: {
      output: {
        manualChunks: (id) => {
          // Core React libraries
          if (id.includes('react') || id.includes('react-dom')) {
            return 'react-core';
          }
          // Router
          if (id.includes('react-router')) {
            return 'router';
          }
          // UI libraries
          if (id.includes('framer-motion') || id.includes('lucide-react')) {
            return 'ui';
          }
          // Payment processing
          if (id.includes('stripe')) {
            return 'payment';
          }
          // Database
          if (id.includes('supabase')) {
            return 'database';
          }
          // Pages - split by route
          if (id.includes('/pages/')) {
            const pageName = id.split('/pages/')[1].split('.')[0];
            return `page-${pageName.toLowerCase()}`;
          }
          // Components
          if (id.includes('/components/')) {
            return 'components';
          }
          // Utils
          if (id.includes('/utils/')) {
            return 'utils';
          }
          // Everything else
          return 'vendor';
        },
        chunkFileNames: 'assets/[name]-[hash].js',
        entryFileNames: 'assets/[name]-[hash].js',
        assetFileNames: 'assets/[name]-[hash].[ext]'
      },
    },
    chunkSizeWarningLimit: 500, // Reduced from 1000
  },
  esbuild: {
    drop: ['console', 'debugger'],
    treeShaking: true,
  },
  optimizeDeps: {
    exclude: ['lucide-react'],
    include: ['react', 'react-dom', 'react-router-dom'],
  },
});

