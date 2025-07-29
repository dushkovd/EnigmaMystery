-- Fix Production Trigger Permanently
-- Run this in your Production Supabase Dashboard SQL Editor

-- ============================================================================
-- STEP 1: Drop existing function and trigger (if they exist)
-- ============================================================================

-- Drop the trigger first
DROP TRIGGER IF EXISTS on_auth_user_created ON auth.users;

-- Drop the function
DROP FUNCTION IF EXISTS public.handle_new_user();

-- ============================================================================
-- STEP 2: Create the function with SECURITY DEFINER
-- ============================================================================

CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO public."Users" (user_id, email, created_at)
  VALUES (NEW.id, NEW.email, NEW.created_at);
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- ============================================================================
-- STEP 3: Create the trigger
-- ============================================================================

CREATE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW EXECUTE FUNCTION public.handle_new_user();

-- ============================================================================
-- STEP 4: Verify the trigger is created
-- ============================================================================

SELECT 
    'TRIGGER_VERIFICATION' as check_type,
    trigger_name,
    event_manipulation,
    action_statement
FROM information_schema.triggers 
WHERE trigger_name = 'on_auth_user_created';

-- ============================================================================
-- STEP 5: Test the trigger with a dummy user (optional)
-- ============================================================================

-- This will test if the trigger works (you can delete this test user later)
-- Uncomment the lines below to test:

/*
INSERT INTO auth.users (id, email, created_at, email_confirmed_at)
VALUES (
    gen_random_uuid(),
    'test@example.com',
    NOW(),
    NOW()
);

-- Check if the trigger worked
SELECT 
    'TEST_RESULT' as check_type,
    au.id,
    au.email,
    u.user_id,
    u.email as users_email
FROM auth.users au
LEFT JOIN "Users" u ON au.id = u.user_id
WHERE au.email = 'test@example.com';

-- Clean up test user
DELETE FROM "Users" WHERE email = 'test@example.com';
DELETE FROM auth.users WHERE email = 'test@example.com';
*/ 