-- Add price_with_discount field to Games table
-- This field will store the discounted price when a game is on sale

ALTER TABLE "Games" 
ADD COLUMN IF NOT EXISTS "price_with_discount" DECIMAL(10,2);

-- Add a comment to document the field
COMMENT ON COLUMN "Games"."price_with_discount" IS 'Discounted price when the game is on sale. If NULL, no discount is applied.';

-- Add a check constraint to ensure discount price is not higher than regular price
ALTER TABLE "Games" 
ADD CONSTRAINT IF NOT EXISTS "check_discount_price" 
CHECK ("price_with_discount" IS NULL OR "price_with_discount" <= "price"); 