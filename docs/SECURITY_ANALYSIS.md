# Security Analysis: SECURITY DEFINER Issues

## Overview

This document analyzes the security warning received from Supabase regarding `SECURITY DEFINER` functions and provides comprehensive solutions.

## The Problem

### What is SECURITY DEFINER?

`SECURITY DEFINER` is a PostgreSQL function attribute that makes a function run with the **privileges of the function creator** rather than the **privileges of the calling user**. This can create security vulnerabilities.

### Affected Functions

1. **`get_game_image_url(TEXT)`** - Creates Supabase Storage URLs for game images
2. **`update_supabase_url(TEXT)`** - Updates Supabase URL configuration

### Security Risks

1. **Privilege Escalation**: Functions run with elevated privileges
2. **RLS Bypass**: Row Level Security policies might be circumvented
3. **Data Access**: Functions might access data beyond user permissions
4. **Configuration Changes**: Unauthorized users might modify system settings

## Current Implementation Analysis

### Function Usage

```sql
-- Current problematic implementation
CREATE OR REPLACE FUNCTION get_game_image_url(image_path TEXT)
RETURNS TEXT AS $$
BEGIN
  IF image_path IS NOT NULL AND image_path != '' THEN
    RETURN 'https://' || current_setting('app.settings.supabase_url') || '/storage/v1/object/public/game-images/' || image_path;
  ELSE
    RETURN NULL;
  END IF;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER; -- ❌ Security risk
```

### View Usage

```sql
-- View that uses the SECURITY DEFINER function
CREATE OR REPLACE VIEW games_with_images AS
SELECT 
  g.*,
  COALESCE(
    get_game_image_url(g.image_path), -- ❌ Calls SECURITY DEFINER function
    g.image
  ) as image_url
FROM "Games" g;
```

## Solutions

### Solution 1: Remove SECURITY DEFINER (Recommended)

**Migration**: `20240320000010_fix_security_definer_issues.sql`

#### Changes Made:

1. **Replace SECURITY DEFINER with SECURITY INVOKER**
   ```sql
   -- Before
   $$ LANGUAGE plpgsql SECURITY DEFINER;
   
   -- After
   $$ LANGUAGE plpgsql SECURITY INVOKER;
   ```

2. **Add Authentication Checks**
   ```sql
   CREATE OR REPLACE FUNCTION update_supabase_url(new_url TEXT)
   RETURNS VOID AS $$
   BEGIN
       -- Only allow authenticated users
       IF auth.role() != 'authenticated' THEN
           RAISE EXCEPTION 'Only authenticated users can update Supabase URL';
       END IF;
       
       PERFORM set_config('app.settings.supabase_url', new_url, false);
   END;
   $$ LANGUAGE plpgsql SECURITY INVOKER;
   ```

3. **Add Security Barrier to View**
   ```sql
   ALTER VIEW games_with_images SET (security_barrier = true);
   ```

### Solution 2: Enhanced Security Function

Create a more secure version that checks user permissions:

```sql
CREATE OR REPLACE FUNCTION get_game_image_url_secure(image_path TEXT, game_id INTEGER DEFAULT NULL)
RETURNS TEXT AS $$
DECLARE
  user_id UUID;
  has_access BOOLEAN := FALSE;
BEGIN
  user_id := auth.uid();
  
  -- Allow access for public game listings
  IF game_id IS NULL THEN
    has_access := TRUE;
  ELSE
    -- Check if user purchased the game
    SELECT EXISTS (
      SELECT 1 FROM "Order_Items" oi
      JOIN "Orders" o ON oi.order_id = o.order_id
      WHERE oi.game_id = game_id 
      AND o.user_id = user_id 
      AND o.status = 'completed'
    ) INTO has_access;
    
    -- If not purchased, check if game is public
    IF NOT has_access THEN
      SELECT is_active FROM "Games" WHERE game_id = game_id INTO has_access;
    END IF;
  END IF;
  
  -- Only return URL if user has access
  IF has_access AND image_path IS NOT NULL AND image_path != '' THEN
    RETURN 'https://' || current_setting('app.settings.supabase_url') || '/storage/v1/object/public/game-images/' || image_path;
  ELSE
    RETURN NULL;
  END IF;
END;
$$ LANGUAGE plpgsql SECURITY INVOKER;
```

### Solution 3: Alternative Approach - Client-Side URL Generation

Instead of database functions, generate URLs in the application:

```typescript
// utils/imageStorage.ts
export const getGameImageUrl = (imagePath: string): string => {
  if (!imagePath) return '';
  
  const supabaseUrl = import.meta.env.VITE_SUPABASE_URL;
  return `https://${supabaseUrl}/storage/v1/object/public/game-images/${imagePath}`;
};
```

## Implementation Steps

### 1. Apply the Migration

```bash
# Apply the security fix migration
supabase db push

# Or run manually
supabase migration up
```

### 2. Test the Changes

```bash
# Test that functions still work
psql -h your-project.supabase.co -U postgres -d postgres -c "SELECT get_game_image_url('test/path.jpg');"

# Test that permissions are enforced
psql -h your-project.supabase.co -U anon -d postgres -c "SELECT get_game_image_url('test/path.jpg');"
```

### 3. Update Application Code (if needed)

If you switch to client-side URL generation:

```typescript
// Update src/api/games.ts
import { getGameImageUrl } from '../utils/imageStorage';

const transformGameData = (game: any): Game => {
  let imageUrl = game.image || defaultImageUrl;
  
  if (game.image_path) {
    const storageUrl = getGameImageUrl(game.image_path);
    if (storageUrl) {
      imageUrl = storageUrl;
    }
  }

  return {
    // ... other fields
    image: imageUrl,
  };
};
```

## Security Best Practices

### 1. Function Security

- ✅ Use `SECURITY INVOKER` instead of `SECURITY DEFINER`
- ✅ Add authentication checks in functions
- ✅ Validate input parameters
- ✅ Use parameterized queries

### 2. View Security

- ✅ Set `security_barrier = true` on views
- ✅ Ensure views respect RLS policies
- ✅ Grant minimal necessary permissions

### 3. RLS Policies

- ✅ Implement proper Row Level Security
- ✅ Test policies with different user roles
- ✅ Regularly audit access patterns

### 4. Monitoring

- ✅ Monitor function execution logs
- ✅ Set up alerts for suspicious activity
- ✅ Regular security audits

## Verification

### Check Current Status

```sql
-- Check for remaining SECURITY DEFINER functions
SELECT 
  proname as function_name,
  prosrc as function_source
FROM pg_proc p
JOIN pg_namespace n ON p.pronamespace = n.oid
WHERE n.nspname = 'public' 
AND p.prosecdef = true;

-- Check view security settings
SELECT 
  schemaname,
  viewname,
  security_barrier
FROM pg_views 
WHERE schemaname = 'public' 
AND viewname = 'games_with_images';
```

### Expected Results After Fix

```sql
-- Should return no SECURITY DEFINER functions
SELECT proname FROM pg_proc p
JOIN pg_namespace n ON p.pronamespace = n.oid
WHERE n.nspname = 'public' AND p.prosecdef = true;
-- Expected: No rows returned

-- Should show security_barrier = true
SELECT viewname, security_barrier 
FROM pg_views 
WHERE viewname = 'games_with_images';
-- Expected: games_with_images | t
```

## Rollback Plan

If issues arise after applying the fix:

```sql
-- Rollback to SECURITY DEFINER (if absolutely necessary)
CREATE OR REPLACE FUNCTION get_game_image_url(image_path TEXT)
RETURNS TEXT AS $$
BEGIN
  IF image_path IS NOT NULL AND image_path != '' THEN
    RETURN 'https://' || current_setting('app.settings.supabase_url') || '/storage/v1/object/public/game-images/' || image_path;
  ELSE
    RETURN NULL;
  END IF;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;
```

## Conclusion

The security warning has been addressed by:

1. **Removing SECURITY DEFINER** from all functions
2. **Adding proper authentication checks**
3. **Implementing security barriers** on views
4. **Creating enhanced security functions** for sensitive operations

These changes maintain functionality while significantly improving security posture. The application will continue to work as expected, but with proper privilege isolation and access controls. 