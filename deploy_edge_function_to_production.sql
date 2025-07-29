-- Deploy Edge Function to Production
-- This script will help you deploy the create-payment-intent function

-- ============================================================================
-- STEP 1: Check if the function exists in production
-- ============================================================================

SELECT 
    'EDGE_FUNCTION_CHECK' as check_type,
    name,
    version,
    created_at,
    updated_at
FROM supabase_functions.hooks 
WHERE name = 'create-payment-intent';

-- ============================================================================
-- STEP 2: Instructions for deploying the function
-- ============================================================================

-- To deploy the edge function, you need to run these commands in your terminal:

/*
1. Link to your production project:
   supabase link --project-ref YOUR_PRODUCTION_PROJECT_ID

2. Deploy the function:
   supabase functions deploy create-payment-intent --project-ref YOUR_PRODUCTION_PROJECT_ID

3. Or deploy all functions:
   supabase functions deploy --project-ref YOUR_PRODUCTION_PROJECT_ID
*/

-- ============================================================================
-- STEP 3: Check function configuration after deployment
-- ============================================================================

-- After deploying, run this to verify:
SELECT 
    'FUNCTION_VERIFICATION' as check_type,
    name,
    version,
    created_at,
    updated_at
FROM supabase_functions.hooks 
WHERE name = 'create-payment-intent'; 