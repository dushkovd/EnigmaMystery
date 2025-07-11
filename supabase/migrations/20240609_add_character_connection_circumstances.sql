-- Migration: Add connection and circumstances fields to Characters table
-- This migration adds new fields to support character relationships and arrival circumstances

-- Add new columns to Characters table
ALTER TABLE "Characters" 
ADD COLUMN IF NOT EXISTS connection TEXT,
ADD COLUMN IF NOT EXISTS connection_bg TEXT,
ADD COLUMN IF NOT EXISTS circumstances TEXT,
ADD COLUMN IF NOT EXISTS circumstances_bg TEXT;

-- Add comments to explain the new fields
COMMENT ON COLUMN "Characters".connection IS 'How the character knows the victim (English)';
COMMENT ON COLUMN "Characters".connection_bg IS 'How the character knows the victim (Bulgarian)';
COMMENT ON COLUMN "Characters".circumstances IS 'How the character arrived at the crime scene (English)';
COMMENT ON COLUMN "Characters".circumstances_bg IS 'How the character arrived at the crime scene (Bulgarian)';

-- Update existing characters with placeholder values (optional)
-- This ensures existing games still work while new games can use the enhanced fields
UPDATE "Characters" 
SET 
  connection = 'Connected to the victim through the mystery',
  connection_bg = 'Свързан с жертвата чрез мистерията',
  circumstances = 'Present at the scene when the crime occurred',
  circumstances_bg = 'Присъства на мястото, когато се случи престъплението'
WHERE connection IS NULL; 