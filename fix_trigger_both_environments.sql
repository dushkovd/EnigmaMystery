-- Fix Trigger on Both Environments
-- Run this script on BOTH production and staging environments

-- ============================================================================
-- STEP 1: Create the missing trigger
-- ============================================================================

CREATE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW EXECUTE FUNCTION public.handle_new_user();

-- ============================================================================
-- STEP 2: Verify the trigger was created
-- ============================================================================

SELECT 
    'TRIGGER_CREATED' as check_type,
    trigger_name,
    event_manipulation,
    action_timing,
    action_statement
FROM information_schema.triggers 
WHERE event_object_table = 'users' 
AND event_object_schema = 'auth'
ORDER BY trigger_name;

-- ============================================================================
-- STEP 3: Check trigger status
-- ============================================================================

SELECT 
    'TRIGGER_STATUS' as check_type,
    tgname as trigger_name,
    tgenabled as enabled_status,
    tgrelid::regclass as table_name
FROM pg_trigger 
WHERE tgname = 'on_auth_user_created'
AND tgrelid = 'auth.users'::regclass;

-- ============================================================================
-- STEP 4: Test the trigger (optional)
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