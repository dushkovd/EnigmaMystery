-- Fix User Creation with RLS Policy (Supabase-Friendly)
-- Run this in your Production Supabase Dashboard SQL Editor

-- ============================================================================
-- STEP 1: Drop the trigger approach
-- ============================================================================

-- Drop the trigger first
DROP TRIGGER IF EXISTS on_auth_user_created ON auth.users;

-- Drop the function
DROP FUNCTION IF EXISTS public.handle_new_user();

-- ============================================================================
-- STEP 2: Create an INSERT policy that auto-creates user records
-- ============================================================================

-- Drop existing policies on Users table
DROP POLICY IF EXISTS "Users can view their own data" ON "Users";
DROP POLICY IF EXISTS "Users can insert their own data" ON "Users";

-- Create a policy that allows users to insert their own record
CREATE POLICY "Users can insert their own data" ON "Users"
FOR INSERT WITH CHECK (auth.uid() = user_id);

-- Recreate the SELECT policy
CREATE POLICY "Users can view their own data" ON "Users"
FOR SELECT USING (auth.uid() = user_id);

-- ============================================================================
-- STEP 3: Create a function to handle user creation manually
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
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Grant execute permission
GRANT EXECUTE ON FUNCTION public.create_user_record() TO authenticated;

-- ============================================================================
-- STEP 4: Verify the setup
-- ============================================================================

SELECT 
    'RLS_POLICIES' as check_type,
    policyname,
    permissive,
    roles,
    cmd
FROM pg_policies 
WHERE tablename = 'Users'
ORDER BY policyname;

SELECT 
    'FUNCTION_CHECK' as check_type,
    routine_name,
    routine_type,
    security_type
FROM information_schema.routines 
WHERE routine_name = 'create_user_record'
AND routine_schema = 'public'; 