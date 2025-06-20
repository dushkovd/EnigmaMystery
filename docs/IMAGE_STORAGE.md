# Image Storage System

This document describes the secure, production-ready image storage system using Supabase Storage.

## Overview

The image storage system replaces external image URLs with Supabase Storage, providing:
- **Security**: Images are stored in your own Supabase project
- **Reliability**: No dependency on external services
- **Performance**: CDN-backed storage with global distribution
- **Control**: Full control over image access and management

## Architecture

### Storage Bucket
- **Bucket Name**: `game-images`
- **Public Access**: Yes (for reading game images in the shop)
- **File Size Limit**: 5MB
- **Allowed Types**: JPEG, PNG, WebP, GIF

### Database Schema
- **Table**: `Games`
- **New Column**: `image_path` (TEXT) - stores the Supabase Storage path
- **Fallback**: `image` column still exists for backward compatibility

### File Structure
```
game-images/
├── 1/
│   ├── game-1-1234567890.jpg
│   └── game-1-1234567891.png
├── 2/
│   └── game-2-1234567892.webp
└── ...
```

## Setup Instructions

### 1. Run Migrations
```bash
# Apply the storage setup migration
supabase db push

# Or run migrations manually
supabase migration up
```

### 2. Configure Supabase URL
Update the Supabase URL in the migration file `20240320000009_configure_supabase_url.sql`:
```sql
PERFORM set_config('app.settings.supabase_url', 'your-project-ref.supabase.co', false);
```

### 3. Set Environment Variables
Add your Supabase service role key to your environment:
```bash
export SUPABASE_SERVICE_ROLE_KEY="your-service-role-key"
```

## Usage

### Uploading Images

#### Using the ImageUploader Component
```tsx
import ImageUploader from '../components/admin/ImageUploader';

<ImageUploader
  gameId={game.game_id}
  currentImagePath={game.image_path}
  currentImageUrl={game.image}
  onImageUpdate={(imagePath, imageUrl) => {
    // Handle image update
    console.log('New image path:', imagePath);
    console.log('New image URL:', imageUrl);
  }}
/>
```

#### Using Utility Functions
```tsx
import { uploadGameImage, replaceGameImage } from '../utils/imageStorage';

// Upload new image
const result = await uploadGameImage(file, gameId);
if (result.error) {
  console.error('Upload failed:', result.error);
} else {
  console.log('Upload successful:', result.url);
}

// Replace existing image
const result = await replaceGameImage(file, gameId, oldImagePath);
```

### Displaying Images

The `transformGameData` function in `src/api/games.ts` automatically handles image URL resolution:

1. **Priority**: `image_path` (Supabase Storage) → `image` (fallback URL)
2. **Automatic URL generation**: Converts storage paths to public URLs
3. **Backward compatibility**: Still works with existing external URLs

### Managing Images

#### Delete an Image
```tsx
import { deleteGameImage } from '../utils/imageStorage';

const result = await deleteGameImage(imagePath);
if (result.success) {
  console.log('Image deleted successfully');
} else {
  console.error('Delete failed:', result.error);
}
```

#### Get Image URL
```tsx
import { getGameImageUrl } from '../utils/imageStorage';

const imageUrl = getGameImageUrl(imagePath);
```

## Migration from External URLs

### Automatic Migration Script
Use the provided migration script to move existing images:

```bash
# Install dependencies if needed
npm install node-fetch

# Set your service role key
export SUPABASE_SERVICE_ROLE_KEY="your-service-role-key"

# Run migration
node scripts/migrate-images.js
```

### Manual Migration
1. Download images from external URLs
2. Upload to Supabase Storage using `uploadGameImage`
3. Update database with new `image_path`
4. Optionally delete old images from external services

## Security

### Row Level Security (RLS)
- **Public Read**: Anyone can view game images (needed for shop)
- **Authenticated Upload**: Only authenticated users can upload
- **Authenticated Update**: Only authenticated users can update
- **Authenticated Delete**: Only authenticated users can delete

### File Validation
- **Type Checking**: Only image files allowed
- **Size Limits**: 5MB maximum file size
- **Content Validation**: Server-side validation of file contents

## Best Practices

### File Naming
- Use descriptive names: `game-{id}-{timestamp}.{extension}`
- Include game ID in path for organization
- Use timestamps to avoid conflicts

### Error Handling
- Always check for upload errors
- Implement retry logic for failed uploads
- Clean up failed uploads to avoid storage bloat

### Performance
- Use appropriate image formats (WebP for web)
- Optimize images before upload
- Consider implementing image resizing for different sizes

## Troubleshooting

### Common Issues

#### "Bucket not found" Error
- Ensure the migration ran successfully
- Check that the bucket name matches exactly: `game-images`

#### "Permission denied" Error
- Verify RLS policies are in place
- Check that user is authenticated for upload operations
- Ensure service role key is correct for admin operations

#### "Invalid file type" Error
- Check that file is actually an image
- Verify file extension matches content type
- Ensure file is not corrupted

#### "File too large" Error
- Compress image before upload
- Consider using a different image format
- Check file size limit (5MB)

### Debugging
```tsx
// Enable debug logging
console.log('Upload result:', result);
console.log('Storage URL:', getGameImageUrl(imagePath));
```

## API Reference

### ImageUploadResult
```tsx
interface ImageUploadResult {
  path: string;      // Storage path
  url: string;       // Public URL
  error?: string;    // Error message if failed
}
```

### ImageDeleteResult
```tsx
interface ImageDeleteResult {
  success: boolean;  // Whether deletion succeeded
  error?: string;    // Error message if failed
}
```

### Functions
- `uploadGameImage(file, gameId, fileName?)` - Upload new image
- `replaceGameImage(file, gameId, oldImagePath?)` - Replace existing image
- `deleteGameImage(imagePath)` - Delete image from storage
- `getGameImageUrl(imagePath)` - Get public URL for image
- `updateGameImagePath(gameId, imagePath)` - Update database record
- `validateImageFile(file)` - Validate file before upload 