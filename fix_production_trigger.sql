-- Fix Production Trigger Issue
-- Run this in your Supabase Dashboard SQL Editor for the PRODUCTION database

-- ============================================================================
-- STEP 1: Drop and recreate the handle_new_user function with SECURITY DEFINER
-- ============================================================================

DROP FUNCTION IF EXISTS handle_new_user();

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
-- STEP 2: Drop and recreate the trigger
-- ============================================================================

-- Drop the trigger if it exists
DROP TRIGGER IF EXISTS on_auth_user_created ON auth.users;

-- Create the trigger
CREATE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW
  EXECUTE FUNCTION handle_new_user();

-- ============================================================================
-- STEP 3: Grant necessary permissions
-- ============================================================================

-- Grant permissions to authenticated users
GRANT SELECT, UPDATE ON "Users" TO authenticated;
GRANT EXECUTE ON FUNCTION handle_new_user() TO authenticated;

-- ============================================================================
-- STEP 4: Test the trigger manually
-- ============================================================================

-- Check if the trigger exists
SELECT 
    trigger_name,
    event_manipulation,
    action_statement
FROM information_schema.triggers 
WHERE trigger_name = 'on_auth_user_created';

-- Check if the function exists
SELECT 
    routine_name,
    routine_type,
    security_type
FROM information_schema.routines 
WHERE routine_name = 'handle_new_user'; 