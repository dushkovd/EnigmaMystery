-- Fix Trigger Without Security Definer
-- Run this in your Production Supabase Dashboard SQL Editor

-- ============================================================================
-- STEP 1: Drop existing trigger and function
-- ============================================================================

-- Drop the trigger first
DROP TRIGGER IF EXISTS on_auth_user_created ON auth.users;

-- Drop the function
DROP FUNCTION IF EXISTS public.handle_new_user();

-- ============================================================================
-- STEP 2: Create the function WITHOUT SECURITY DEFINER
-- ============================================================================

CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO public."Users" (user_id, email, created_at)
  VALUES (NEW.id, NEW.email, NEW.created_at)
  ON CONFLICT (user_id) DO NOTHING;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- ============================================================================
-- STEP 3: Grant necessary permissions to the function
-- ============================================================================

-- Grant permissions to authenticated users to execute the function
GRANT EXECUTE ON FUNCTION public.handle_new_user() TO authenticated;
GRANT EXECUTE ON FUNCTION public.handle_new_user() TO anon;

-- Grant permissions to insert into Users table
GRANT INSERT ON public."Users" TO authenticated;
GRANT INSERT ON public."Users" TO anon;

-- ============================================================================
-- STEP 4: Create the trigger
-- ============================================================================

CREATE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW EXECUTE FUNCTION public.handle_new_user();

-- ============================================================================
-- STEP 5: Verify the fix
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
-- STEP 6: Check permissions
-- ============================================================================

SELECT 
    'PERMISSIONS_CHECK' as check_type,
    grantee,
    privilege_type
FROM information_schema.role_table_grants 
WHERE table_name = 'Users'
AND table_schema = 'public'
AND grantee IN ('authenticated', 'anon'); 