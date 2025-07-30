-- Fix Function with User ID Parameter
-- Run this in your STAGING Supabase Dashboard SQL Editor

-- ============================================================================
-- STEP 1: Drop existing function
-- ============================================================================

DROP FUNCTION IF EXISTS public.create_user_record();

-- ============================================================================
-- STEP 2: Create function that accepts user_id parameter
-- ============================================================================

CREATE OR REPLACE FUNCTION public.create_user_record(user_id UUID DEFAULT NULL)
RETURNS void AS $$
DECLARE
    v_user_id UUID;
    v_email TEXT;
BEGIN
    -- Use provided user_id or get from auth context
    v_user_id := COALESCE(user_id, auth.uid());
    
    -- Get email from auth.users table
    SELECT email INTO v_email
    FROM auth.users
    WHERE id = v_user_id;
    
    -- Insert user record
    INSERT INTO public."Users" (user_id, email, created_at)
    VALUES (v_user_id, v_email, NOW())
    ON CONFLICT (user_id) DO NOTHING;
END;
$$ LANGUAGE plpgsql;

-- ============================================================================
-- STEP 3: Grant permissions
-- ============================================================================

GRANT EXECUTE ON FUNCTION public.create_user_record(UUID) TO authenticated;
GRANT EXECUTE ON FUNCTION public.create_user_record() TO authenticated;
GRANT INSERT ON public."Users" TO authenticated;

-- ============================================================================
-- STEP 4: Test the function with the specific user
-- ============================================================================

-- Test with the specific user ID
SELECT create_user_record('68037416-f3e6-4ed8-958a-36057013a46d');

-- Check if it worked
SELECT 
    'FUNCTION_TEST_RESULT' as check_type,
    user_id,
    email,
    created_at
FROM "Users" 
WHERE user_id = '68037416-f3e6-4ed8-958a-36057013a46d'; 