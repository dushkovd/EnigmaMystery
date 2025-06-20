const { createClient } = require('@supabase/supabase-js');
const fs = require('fs');
const path = require('path');

// Configuration
const SUPABASE_URL = 'https://gkuwrqpxwehfnmlsqsxa.supabase.co';
const SUPABASE_SERVICE_ROLE_KEY = process.env.SUPABASE_SERVICE_ROLE_KEY;

if (!SUPABASE_SERVICE_ROLE_KEY) {
  console.error('Error: SUPABASE_SERVICE_ROLE_KEY environment variable is required');
  console.log('You can find this in your Supabase dashboard under Settings > API > service_role key');
  process.exit(1);
}

const supabase = createClient(SUPABASE_URL, SUPABASE_SERVICE_ROLE_KEY);

async function runImageMigrations() {
  try {
    console.log('Running image storage migrations...\n');

    // Read migration files
    const imageStorageMigration = fs.readFileSync(
      path.join(__dirname, 'supabase/migrations/20240320000008_add_image_storage.sql'),
      'utf8'
    );
    
    const supabaseUrlMigration = fs.readFileSync(
      path.join(__dirname, 'supabase/migrations/20240320000009_configure_supabase_url.sql'),
      'utf8'
    );

    // Run image storage migration
    console.log('Running 20240320000008_add_image_storage.sql...');
    const { error: error1 } = await supabase.rpc('exec_sql', { sql: imageStorageMigration });
    
    if (error1) {
      console.error('Error running image storage migration:', error1);
      return;
    }
    console.log('✓ Image storage migration completed\n');

    // Run Supabase URL configuration migration
    console.log('Running 20240320000009_configure_supabase_url.sql...');
    const { error: error2 } = await supabase.rpc('exec_sql', { sql: supabaseUrlMigration });
    
    if (error2) {
      console.error('Error running Supabase URL migration:', error2);
      return;
    }
    console.log('✓ Supabase URL configuration completed\n');

    console.log('🎉 Both image storage migrations completed successfully!');
    console.log('\nYour Supabase Storage is now set up for game images.');
    console.log('You can now:');
    console.log('1. Upload images using the ImageUploader component');
    console.log('2. Use the utility functions in src/utils/imageStorage.ts');
    console.log('3. Run the migration script to move existing images');

  } catch (error) {
    console.error('Migration failed:', error.message);
    process.exit(1);
  }
}

runImageMigrations(); 