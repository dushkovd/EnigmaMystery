-- Fix Production Users Table Issue
-- Run this in your Supabase Dashboard SQL Editor for the PRODUCTION database

-- ============================================================================
-- STEP 1: Create the Users table if it doesn't exist
-- ============================================================================

CREATE TABLE IF NOT EXISTS "Users" (
    "user_id" UUID PRIMARY KEY,
    "email" TEXT NOT NULL UNIQUE,
    "created_at" TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    "updated_at" TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- ============================================================================
-- STEP 2: Enable Row Level Security
-- ============================================================================

ALTER TABLE "Users" ENABLE ROW LEVEL SECURITY;

-- ============================================================================
-- STEP 3: Create RLS Policies for Users table
-- ============================================================================

-- Users can view their own data
CREATE POLICY "Users can view their own data" ON "Users"
    FOR SELECT USING (auth.uid() = user_id);

-- Users can update their own data
CREATE POLICY "Users can update their own data" ON "Users"
    FOR UPDATE USING (auth.uid() = user_id);

-- ============================================================================
-- STEP 4: Create the handle_new_user function
-- ============================================================================

CREATE OR REPLACE FUNCTION handle_new_user()
RETURNS TRIGGER AS $$
BEGIN
  -- Insert the new user into the Users table
  INSERT INTO "Users" (user_id, email)
  VALUES (NEW.id, NEW.email)
  ON CONFLICT (user_id) DO NOTHING;
  
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- ============================================================================
-- STEP 5: Create the trigger for new user registration
-- ============================================================================

-- Drop the trigger if it exists
DROP TRIGGER IF EXISTS on_auth_user_created ON auth.users;

-- Create the trigger
CREATE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW
  EXECUTE FUNCTION handle_new_user();

-- ============================================================================
-- STEP 6: Grant necessary permissions
-- ============================================================================

-- Grant permissions to authenticated users
GRANT SELECT, UPDATE ON "Users" TO authenticated;
GRANT EXECUTE ON FUNCTION handle_new_user() TO authenticated;

-- ============================================================================
-- STEP 7: Create any existing users that might have been missed
-- ============================================================================

-- Insert any existing auth.users that don't have corresponding Users records
INSERT INTO "Users" (user_id, email)
SELECT id, email
FROM auth.users
WHERE id NOT IN (SELECT user_id FROM "Users")
ON CONFLICT (user_id) DO NOTHING; 