-- Migration: Configure Supabase URL for image storage
-- This migration sets up the configuration needed for the get_game_image_url function

-- Set the Supabase URL configuration
-- Note: This should be updated with your actual Supabase project URL
-- You can find this in your Supabase dashboard under Settings > API
DO $$
BEGIN
    -- Set the Supabase URL - replace with your actual project URL
    -- Format: https://your-project-ref.supabase.co
    PERFORM set_config('app.settings.supabase_url', 'gkuwrqpxwehfnmlsqsxa.supabase.co', false);
    
    -- Alternative: You can also set this as an environment variable
    -- PERFORM set_config('app.settings.supabase_url', current_setting('SUPABASE_URL'), false);
END $$;

-- Create a function to update the Supabase URL if needed
CREATE OR REPLACE FUNCTION update_supabase_url(new_url TEXT)
RETURNS VOID AS $$
BEGIN
    PERFORM set_config('app.settings.supabase_url', new_url, false);
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Grant execute permission to authenticated users
GRANT EXECUTE ON FUNCTION update_supabase_url(TEXT) TO authenticated; 