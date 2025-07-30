-- Fix Permissions for create_user_record Function
-- Run this in your Production Supabase Dashboard SQL Editor

-- ============================================================================
-- STEP 1: Drop and recreate the function with proper permissions
-- ============================================================================

-- Drop existing function
DROP FUNCTION IF EXISTS public.create_user_record(UUID);
DROP FUNCTION IF EXISTS public.create_user_record();

-- Create the function with SECURITY DEFINER to bypass RLS
CREATE OR REPLACE FUNCTION public.create_user_record(input_user_id UUID DEFAULT NULL)
RETURNS void AS $$
DECLARE
    v_user_id UUID;
    v_email TEXT;
BEGIN
    -- Use provided user_id or get from auth context
    v_user_id := COALESCE(input_user_id, auth.uid());
    
    -- Get email from auth.users table
    SELECT email INTO v_email
    FROM auth.users
    WHERE id = v_user_id;
    
    -- Insert user record
    INSERT INTO public."Users" (user_id, email, created_at)
    VALUES (v_user_id, v_email, NOW())
    ON CONFLICT (user_id) DO NOTHING;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- ============================================================================
-- STEP 2: Grant execute permissions
-- ============================================================================

-- Grant execute permission to authenticated users
GRANT EXECUTE ON FUNCTION public.create_user_record(UUID) TO authenticated;

-- ============================================================================
-- STEP 3: Ensure Users table has proper RLS policies
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
-- STEP 4: Verify the setup
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
-- STEP 5: Test the function (optional)
-- ============================================================================

-- Uncomment the lines below to test the function:

/*
-- Test with a specific user ID
SELECT create_user_record('a2e7674f-d555-4996-95c9-b1893c3f488b');

-- Check if the user was created
SELECT 
    'TEST_RESULT' as check_type,
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
WHERE au.id = 'a2e7674f-d555-4996-95c9-b1893c3f488b';
*/ 