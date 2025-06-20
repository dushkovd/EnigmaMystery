-- Migration: Set up Supabase Storage for game images
-- This migration creates storage buckets and updates the Games table to use Supabase Storage

-- 1. Create storage bucket for game images
INSERT INTO storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
VALUES (
  'game-images',
  'game-images',
  true,
  5242880, -- 5MB limit
  ARRAY['image/jpeg', 'image/png', 'image/webp', 'image/gif']
) ON CONFLICT (id) DO NOTHING;

-- 2. Add image_path column to Games table to store Supabase Storage paths
ALTER TABLE "Games" 
ADD COLUMN IF NOT EXISTS image_path TEXT;

-- Add comment to explain the field
COMMENT ON COLUMN "Games".image_path IS 'Supabase Storage path for the game image';

-- 3. Create RLS policies for the storage bucket
-- Allow public read access to game images (since they're used in the shop)
CREATE POLICY "Public read access to game images"
ON storage.objects FOR SELECT
USING (bucket_id = 'game-images');

-- Allow authenticated users to upload game images (for admin purposes)
CREATE POLICY "Authenticated users can upload game images"
ON storage.objects FOR INSERT
WITH CHECK (
  bucket_id = 'game-images' 
  AND auth.role() = 'authenticated'
);

-- Allow authenticated users to update game images
CREATE POLICY "Authenticated users can update game images"
ON storage.objects FOR UPDATE
USING (
  bucket_id = 'game-images' 
  AND auth.role() = 'authenticated'
)
WITH CHECK (
  bucket_id = 'game-images' 
  AND auth.role() = 'authenticated'
);

-- Allow authenticated users to delete game images
CREATE POLICY "Authenticated users can delete game images"
ON storage.objects FOR DELETE
USING (
  bucket_id = 'game-images' 
  AND auth.role() = 'authenticated'
);

-- 4. Create a function to get the full URL for a game image
CREATE OR REPLACE FUNCTION get_game_image_url(image_path TEXT)
RETURNS TEXT AS $$
BEGIN
  -- If image_path is provided, construct the Supabase Storage URL
  IF image_path IS NOT NULL AND image_path != '' THEN
    RETURN 'https://' || current_setting('app.settings.supabase_url') || '/storage/v1/object/public/game-images/' || image_path;
  ELSE
    -- Fallback to default image or existing image URL
    RETURN NULL;
  END IF;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- 5. Create a view that includes the full image URL
CREATE OR REPLACE VIEW games_with_images AS
SELECT 
  g.*,
  COALESCE(
    get_game_image_url(g.image_path),
    g.image -- fallback to existing image URL
  ) as image_url
FROM "Games" g;

-- Grant access to the view
GRANT SELECT ON games_with_images TO authenticated;
GRANT SELECT ON games_with_images TO anon; 