-- Fix Trigger Final Working Solution
-- Run this in your Production Supabase Dashboard SQL Editor

-- ============================================================================
-- STEP 1: Drop existing trigger and function
-- ============================================================================

-- Drop the trigger first
DROP TRIGGER IF EXISTS on_auth_user_created ON auth.users;

-- Drop the function
DROP FUNCTION IF EXISTS public.handle_new_user();

-- ============================================================================
-- STEP 2: Create the function with proper permissions
-- ============================================================================

CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO public."Users" (user_id, email, created_at)
  VALUES (NEW.id, NEW.email, NEW.created_at)
  ON CONFLICT (user_id) DO NOTHING;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- ============================================================================
-- STEP 3: Grant necessary permissions
-- ============================================================================

-- Grant execute permission to the function
GRANT EXECUTE ON FUNCTION public.handle_new_user() TO postgres;
GRANT EXECUTE ON FUNCTION public.handle_new_user() TO authenticated;
GRANT EXECUTE ON FUNCTION public.handle_new_user() TO anon;

-- Grant insert permission on Users table
GRANT INSERT ON public."Users" TO postgres;
GRANT INSERT ON public."Users" TO authenticated;
GRANT INSERT ON public."Users" TO anon;

-- ============================================================================
-- STEP 4: Create the trigger
-- ============================================================================

CREATE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW EXECUTE FUNCTION public.handle_new_user();

-- ============================================================================
-- STEP 5: Verify the setup
-- ============================================================================

SELECT 
    'FUNCTION_SECURITY' as check_type,
    routine_name,
    security_type
FROM information_schema.routines 
WHERE routine_name = 'handle_new_user'
AND routine_schema = 'public';

SELECT 
    'TRIGGER_VERIFICATION' as check_type,
    trigger_name,
    event_manipulation,
    action_timing
FROM information_schema.triggers 
WHERE trigger_name = 'on_auth_user_created'
AND event_object_schema = 'auth';

-- ============================================================================
-- STEP 6: Test the trigger (optional)
-- ============================================================================

-- Uncomment the lines below to test the trigger:

/*
-- Create a test user to verify the trigger works
INSERT INTO auth.users (id, email, created_at, email_confirmed_at)
VALUES (
    gen_random_uuid(),
    'trigger-test@example.com',
    NOW(),
    NOW()
);

-- Check if the trigger worked
SELECT 
    'TRIGGER_TEST' as check_type,
    au.id,
    au.email,
    u.user_id,
    u.email as users_email,
    CASE 
        WHEN u.user_id IS NOT NULL THEN 'SUCCESS'
        ELSE 'FAILED'
    END as result
FROM auth.users au
LEFT JOIN "Users" u ON au.id = u.user_id
WHERE au.email = 'trigger-test@example.com';

-- Clean up test data
DELETE FROM "Users" WHERE email = 'trigger-test@example.com';
DELETE FROM auth.users WHERE email = 'trigger-test@example.com';
*/ 