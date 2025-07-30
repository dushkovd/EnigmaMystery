-- Test script to add a discount to an existing game
-- Run this in your Supabase SQL Editor to test the discount functionality

-- First, let's see what games we have
SELECT game_id, title, price FROM "Games" WHERE is_active = true LIMIT 5;

-- Add a 20% discount to the first game (replace game_id with an actual game ID from your database)
UPDATE "Games" 
SET price_with_discount = price * 0.8  -- 20% discount
WHERE game_id = 1  -- Replace with actual game ID
AND is_active = true;

-- Verify the discount was applied
SELECT 
  game_id, 
  title, 
  price, 
  price_with_discount,
  ROUND(((price - price_with_discount) / price) * 100, 0) as discount_percentage
FROM "Games" 
WHERE game_id = 1  -- Replace with actual game ID
AND price_with_discount IS NOT NULL; 