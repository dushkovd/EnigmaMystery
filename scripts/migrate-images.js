const { createClient } = require('@supabase/supabase-js');
const fetch = require('node-fetch');
const fs = require('fs');
const path = require('path');

// Configuration - Update these with your actual values
const SUPABASE_URL = 'https://gkuwrqpxwehfnmlsqsxa.supabase.co';
const SUPABASE_SERVICE_ROLE_KEY = process.env.SUPABASE_SERVICE_ROLE_KEY; // Set this in your environment

if (!SUPABASE_SERVICE_ROLE_KEY) {
  console.error('Error: SUPABASE_SERVICE_ROLE_KEY environment variable is required');
  console.log('You can find this in your Supabase dashboard under Settings > API > service_role key');
  process.exit(1);
}

const supabase = createClient(SUPABASE_URL, SUPABASE_SERVICE_ROLE_KEY);

/**
 * Download an image from a URL
 */
async function downloadImage(url, gameId) {
  try {
    console.log(`Downloading image for game ${gameId}: ${url}`);
    
    const response = await fetch(url);
    if (!response.ok) {
      throw new Error(`Failed to download image: ${response.statusText}`);
    }
    
    const buffer = await response.buffer();
    const contentType = response.headers.get('content-type');
    
    // Determine file extension from content type
    let extension = 'jpg';
    if (contentType.includes('png')) extension = 'png';
    else if (contentType.includes('webp')) extension = 'webp';
    else if (contentType.includes('gif')) extension = 'gif';
    
    const fileName = `game-${gameId}-migrated.${extension}`;
    const filePath = `${gameId}/${fileName}`;
    
    return { buffer, fileName, filePath, contentType };
  } catch (error) {
    console.error(`Error downloading image for game ${gameId}:`, error.message);
    return null;
  }
}

/**
 * Upload image to Supabase Storage
 */
async function uploadImageToStorage(buffer, filePath, contentType) {
  try {
    const { data, error } = await supabase.storage
      .from('game-images')
      .upload(filePath, buffer, {
        contentType,
        cacheControl: '3600',
        upsert: false
      });
    
    if (error) {
      throw error;
    }
    
    return data.path;
  } catch (error) {
    console.error('Error uploading to storage:', error.message);
    return null;
  }
}

/**
 * Update game record with new image path
 */
async function updateGameImagePath(gameId, imagePath) {
  try {
    const { error } = await supabase
      .from('Games')
      .update({ image_path: imagePath })
      .eq('game_id', gameId);
    
    if (error) {
      throw error;
    }
    
    return true;
  } catch (error) {
    console.error(`Error updating game ${gameId}:`, error.message);
    return false;
  }
}

/**
 * Main migration function
 */
async function migrateImages() {
  try {
    console.log('Starting image migration...');
    
    // Fetch all games with external image URLs
    const { data: games, error } = await supabase
      .from('Games')
      .select('game_id, image, image_path')
      .not('image', 'is', null);
    
    if (error) {
      throw error;
    }
    
    console.log(`Found ${games.length} games to process`);
    
    let successCount = 0;
    let errorCount = 0;
    
    for (const game of games) {
      // Skip if already has image_path
      if (game.image_path) {
        console.log(`Game ${game.game_id} already has image_path, skipping`);
        continue;
      }
      
      // Skip if image URL is already a Supabase Storage URL
      if (game.image && game.image.includes('supabase.co')) {
        console.log(`Game ${game.game_id} already uses Supabase Storage, skipping`);
        continue;
      }
      
      console.log(`\nProcessing game ${game.game_id}...`);
      
      // Download image
      const downloadResult = await downloadImage(game.image, game.game_id);
      if (!downloadResult) {
        errorCount++;
        continue;
      }
      
      // Upload to Supabase Storage
      const uploadedPath = await uploadImageToStorage(
        downloadResult.buffer,
        downloadResult.filePath,
        downloadResult.contentType
      );
      
      if (!uploadedPath) {
        errorCount++;
        continue;
      }
      
      // Update database
      const updateSuccess = await updateGameImagePath(game.game_id, uploadedPath);
      
      if (updateSuccess) {
        console.log(`✓ Successfully migrated game ${game.game_id}`);
        successCount++;
      } else {
        errorCount++;
      }
      
      // Add a small delay to avoid overwhelming the API
      await new Promise(resolve => setTimeout(resolve, 1000));
    }
    
    console.log(`\nMigration completed!`);
    console.log(`Successfully migrated: ${successCount} games`);
    console.log(`Errors: ${errorCount} games`);
    
  } catch (error) {
    console.error('Migration failed:', error.message);
    process.exit(1);
  }
}

// Run the migration
if (require.main === module) {
  migrateImages();
}

module.exports = { migrateImages }; 