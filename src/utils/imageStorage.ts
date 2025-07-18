import { supabase } from '../supabaseClient';

export interface ImageUploadResult {
  path: string;
  url: string;
  error?: string;
}

export interface ImageDeleteResult {
  success: boolean;
  error?: string;
}

/**
 * Upload an image to Supabase Storage
 * @param file - The image file to upload
 * @param gameId - The game ID to associate with the image
 * @param fileName - Optional custom filename
 * @returns Promise<ImageUploadResult>
 */
export const uploadGameImage = async (
  file: File,
  gameId: number,
  fileName?: string
): Promise<ImageUploadResult> => {
  try {
    // Validate file type
    const allowedTypes = ['image/jpeg', 'image/png', 'image/webp', 'image/gif'];
    if (!allowedTypes.includes(file.type)) {
      return {
        path: '',
        url: '',
        error: 'Invalid file type. Only JPEG, PNG, WebP, and GIF are allowed.'
      };
    }

    // Validate file size (5MB limit)
    const maxSize = 5 * 1024 * 1024; // 5MB
    if (file.size > maxSize) {
      return {
        path: '',
        url: '',
        error: 'File size too large. Maximum size is 5MB.'
      };
    }

    // Generate filename if not provided
    const timestamp = Date.now();
    const fileExtension = file.name.split('.').pop();
    const finalFileName = fileName || `game-${gameId}-${timestamp}.${fileExtension}`;
    const filePath = `${gameId}/${finalFileName}`;

    // Upload to Supabase Storage
    const { data, error } = await supabase.storage
      .from('game-images')
      .upload(filePath, file, {
        cacheControl: '3600',
        upsert: false
      });

    if (error) {
      console.error('Upload error:', error);
      return {
        path: '',
        url: '',
        error: error.message
      };
    }

    // Get the public URL
    const { data: urlData } = supabase.storage
      .from('game-images')
      .getPublicUrl(filePath);

    return {
      path: filePath,
      url: urlData.publicUrl
    };
  } catch (error) {
    console.error('Upload error:', error);
    return {
      path: '',
      url: '',
      error: error instanceof Error ? error.message : 'Unknown error occurred'
    };
  }
};

/**
 * Delete an image from Supabase Storage
 * @param imagePath - The storage path of the image to delete
 * @returns Promise<ImageDeleteResult>
 */
export const deleteGameImage = async (imagePath: string): Promise<ImageDeleteResult> => {
  try {
    const { error } = await supabase.storage
      .from('game-images')
      .remove([imagePath]);

    if (error) {
      console.error('Delete error:', error);
      return {
        success: false,
        error: error.message
      };
    }

    return { success: true };
  } catch (error) {
    console.error('Delete error:', error);
    return {
      success: false,
      error: error instanceof Error ? error.message : 'Unknown error occurred'
    };
  }
};

/**
 * Get the public URL for a game image
 * @param imagePath - The storage path of the image
 * @returns The public URL for the image
 */
export const getGameImageUrl = (imagePath: string): string => {
  if (!imagePath) return '';
  
  const { data } = supabase.storage
    .from('game-images')
    .getPublicUrl(imagePath);
  
  return data.publicUrl;
};

/**
 * Get all images from a game's folder
 * @param gameId - The game ID
 * @returns Promise<string[]> - Array of image URLs
 */
export const getGameImages = async (gameId: number): Promise<string[]> => {
  try {
    // List all files in the game's folder
    const { data: files, error } = await supabase.storage
      .from('game-images')
      .list(`${gameId}/`);

    if (error) {
      console.error('Error listing game images:', error);
      return [];
    }

    if (!files || files.length === 0) {
      return [];
    }

    // Filter for image files and get their URLs
    const imageFiles = files.filter(file => 
      file.name && /\.(jpg|jpeg|png|webp|gif)$/i.test(file.name)
    );

    const imageUrls = imageFiles.map(file => {
      const { data } = supabase.storage
        .from('game-images')
        .getPublicUrl(`${gameId}/${file.name}`);
      return data.publicUrl;
    });

    return imageUrls;
  } catch (error) {
    console.error('Error getting game images:', error);
    return [];
  }
};

/**
 * Update a game's image in the database
 * @param gameId - The game ID
 * @param imagePath - The new image path
 * @returns Promise<boolean>
 */
export const updateGameImagePath = async (
  gameId: number,
  imagePath: string
): Promise<boolean> => {
  try {
    const { error } = await supabase
      .from('Games')
      .update({ image_path: imagePath })
      .eq('game_id', gameId);

    if (error) {
      console.error('Database update error:', error);
      return false;
    }

    return true;
  } catch (error) {
    console.error('Database update error:', error);
    return false;
  }
};

/**
 * Replace a game's image (upload new one and delete old one)
 * @param file - The new image file
 * @param gameId - The game ID
 * @param oldImagePath - The old image path to delete
 * @returns Promise<ImageUploadResult>
 */
export const replaceGameImage = async (
  file: File,
  gameId: number,
  oldImagePath?: string
): Promise<ImageUploadResult> => {
  try {
    // Upload new image
    const uploadResult = await uploadGameImage(file, gameId);
    
    if (uploadResult.error) {
      return uploadResult;
    }

    // Update database with new image path
    const updateSuccess = await updateGameImagePath(gameId, uploadResult.path);
    
    if (!updateSuccess) {
      // If database update fails, delete the uploaded file
      await deleteGameImage(uploadResult.path);
      return {
        path: '',
        url: '',
        error: 'Failed to update database with new image path'
      };
    }

    // Delete old image if it exists
    if (oldImagePath) {
      await deleteGameImage(oldImagePath);
    }

    return uploadResult;
  } catch (error) {
    console.error('Replace image error:', error);
    return {
      path: '',
      url: '',
      error: error instanceof Error ? error.message : 'Unknown error occurred'
    };
  }
};

/**
 * Validate image file before upload
 * @param file - The file to validate
 * @returns Object with validation result
 */
export const validateImageFile = (file: File): { valid: boolean; error?: string } => {
  // Check file type
  const allowedTypes = ['image/jpeg', 'image/png', 'image/webp', 'image/gif'];
  if (!allowedTypes.includes(file.type)) {
    return {
      valid: false,
      error: 'Invalid file type. Only JPEG, PNG, WebP, and GIF are allowed.'
    };
  }

  // Check file size (5MB limit)
  const maxSize = 5 * 1024 * 1024; // 5MB
  if (file.size > maxSize) {
    return {
      valid: false,
      error: 'File size too large. Maximum size is 5MB.'
    };
  }

  return { valid: true };
}; 