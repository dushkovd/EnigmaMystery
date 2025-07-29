-- Fix User Creation with Manual Function (No SECURITY DEFINER)
-- Run this in your Production Supabase Dashboard SQL Editor

-- ============================================================================
-- STEP 1: Drop any existing triggers
-- ============================================================================

-- Drop the trigger if it exists
DROP TRIGGER IF EXISTS on_auth_user_created ON auth.users;

-- Drop any existing functions
DROP FUNCTION IF EXISTS public.handle_new_user();
DROP FUNCTION IF EXISTS public.create_user_record();

-- ============================================================================
-- STEP 2: Create a manual user creation function
-- ============================================================================

CREATE OR REPLACE FUNCTION public.create_user_record()
RETURNS void AS $$
BEGIN
  INSERT INTO public."Users" (user_id, email, created_at)
  SELECT 
    auth.uid(),
    auth.email(),
    NOW()
  WHERE NOT EXISTS (
    SELECT 1 FROM public."Users" WHERE user_id = auth.uid()
  );
END;
$$ LANGUAGE plpgsql;

-- ============================================================================
-- STEP 3: Grant necessary permissions
-- ============================================================================

-- Grant execute permission to authenticated users
GRANT EXECUTE ON FUNCTION public.create_user_record() TO authenticated;

-- Grant insert permission on Users table
GRANT INSERT ON public."Users" TO authenticated;

-- ============================================================================
-- STEP 4: Create RLS policies for Users table
-- ============================================================================

-- Drop existing policies
DROP POLICY IF EXISTS "Users can view their own data" ON "Users";
DROP POLICY IF EXISTS "Users can insert their own data" ON "Users";

-- Create SELECT policy
CREATE POLICY "Users can view their own data" ON "Users"
FOR SELECT USING (auth.uid() = user_id);

-- Create INSERT policy
CREATE POLICY "Users can insert their own data" ON "Users"
FOR INSERT WITH CHECK (auth.uid() = user_id);

-- ============================================================================
-- STEP 5: Verify the setup
-- ============================================================================

SELECT 
    'FUNCTION_CHECK' as check_type,
    routine_name,
    routine_type,
    security_type
FROM information_schema.routines 
WHERE routine_name = 'create_user_record'
AND routine_schema = 'public';

SELECT 
    'RLS_POLICIES' as check_type,
    policyname,
    permissive,
    roles,
    cmd
FROM pg_policies 
WHERE tablename = 'Users'
ORDER BY policyname;

-- ============================================================================
-- STEP 6: Test the function (optional)
-- ============================================================================

-- This will test if the function works for the current user
-- (You'll need to run this as an authenticated user)
SELECT 
    'FUNCTION_TEST' as check_type,
    'Run this as authenticated user: SELECT create_user_record();' as instruction; 