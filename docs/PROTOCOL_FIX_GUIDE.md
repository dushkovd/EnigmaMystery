# Protocol Fix Guide

## Problem
The security fix migration hardcoded `https://` in the image URL functions, but your website doesn't have SSL yet.

## Solution
I've created a fix that makes the protocol configurable. Here's how to apply it:

## Step 1: Apply the Protocol Fix Migration

Run this command to apply the protocol fix:

```bash
supabase db push
```

This will run the migration `20240320000011_fix_protocol_configuration.sql` which:

1. **Sets default protocol to `http://`** (for environments without SSL)
2. **Makes protocol configurable** via database settings
3. **Updates all image URL functions** to use the configurable protocol
4. **Adds functions** to update protocol when you get SSL later

## Step 2: Verify the Fix

After running the migration, you can verify it worked:

```sql
-- Check current protocol setting
SELECT get_current_protocol();

-- Test image URL generation
SELECT get_game_image_url('test/image.jpg');
```

Expected results:
- `get_current_protocol()` should return `http://`
- `get_game_image_url()` should return URLs starting with `http://`

## Step 3: When You Get SSL Later

When you add SSL to your website, you can update the protocol:

```sql
-- Update to HTTPS
SELECT update_protocol_setting('https://');

-- Verify the change
SELECT get_current_protocol();
```

## Alternative: Environment Variable

You can also set the protocol via environment variable:

```bash
# In your .env file
VITE_PROTOCOL=http://

# Or for HTTPS later
VITE_PROTOCOL=https://
```

## What This Fixes

✅ **Removes hardcoded HTTPS** from database functions  
✅ **Makes protocol configurable** for different environments  
✅ **Maintains security fixes** (removes SECURITY DEFINER)  
✅ **Provides easy upgrade path** when you get SSL  
✅ **Works with your current HTTP setup**  

## Testing

After applying the fix:

1. **Check your game images** - they should load correctly with `http://` URLs
2. **Test image uploads** - new images should use the correct protocol
3. **Verify security** - the SECURITY DEFINER warning should be resolved

## Troubleshooting

### Images Still Not Loading
- Check that the migration ran successfully
- Verify the protocol setting: `SELECT get_current_protocol();`
- Check browser console for any errors

### Migration Fails
- Make sure you have the latest migrations
- Check that the previous security fix migration ran first
- Verify your Supabase connection

### Need to Rollback
If you need to rollback to HTTPS:

```sql
SELECT update_protocol_setting('https://');
```

## Summary

This fix addresses both:
1. **Security warning** - Removes SECURITY DEFINER
2. **Protocol issue** - Makes HTTPS/HTTP configurable

Your application will now work correctly with HTTP and can easily be upgraded to HTTPS when you add SSL. 