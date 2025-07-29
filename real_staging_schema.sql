-- Real Staging Database Schema for Production
-- This script matches your actual staging database structure
-- Run this in your Supabase Dashboard SQL Editor

-- ============================================================================
-- STEP 1: Create all tables with proper structure (matching staging)
-- ============================================================================

-- Users table
CREATE TABLE IF NOT EXISTS "Users" (
    "user_id" UUID PRIMARY KEY,
    "email" TEXT NOT NULL UNIQUE,
    "created_at" TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    "updated_at" TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Games table (with all the actual columns from staging)
CREATE TABLE IF NOT EXISTS "Games" (
    "game_id" INTEGER PRIMARY KEY,
    "title" TEXT NOT NULL,
    "title_bg" TEXT,
    "subtitle" TEXT,
    "subtitle_bg" TEXT,
    "description" TEXT,
    "description_bg" TEXT,
    "setting" TEXT,
    "image" TEXT,
    "image_path" TEXT,
    "difficulty" TEXT,
    "players" TEXT,
    "duration" TEXT,
    "featured" BOOLEAN DEFAULT false,
    "price" DECIMAL(10,2) NOT NULL,
    "is_active" BOOLEAN DEFAULT true,
    "created_at" TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    "updated_at" TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Game_Variations table
CREATE TABLE IF NOT EXISTS "Game_Variations" (
    "variation_id" INTEGER PRIMARY KEY,
    "game_id" INTEGER NOT NULL REFERENCES "Games"("game_id") ON DELETE CASCADE,
    "num_players" INTEGER NOT NULL,
    "variation_title" TEXT,
    "variation_title_bg" TEXT,
    "notes" TEXT,
    "notes_bg" TEXT,
    "created_at" TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Rounds table
CREATE TABLE IF NOT EXISTS "Rounds" (
    "round_id" INTEGER PRIMARY KEY,
    "variation_id" INTEGER NOT NULL REFERENCES "Game_Variations"("variation_id") ON DELETE CASCADE,
    "round_number" INTEGER NOT NULL,
    "title" TEXT,
    "title_bg" TEXT,
    "description" TEXT,
    "description_bg" TEXT,
    "created_at" TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Characters table
CREATE TABLE IF NOT EXISTS "Characters" (
    "character_id" INTEGER PRIMARY KEY,
    "variation_id" INTEGER NOT NULL REFERENCES "Game_Variations"("variation_id") ON DELETE CASCADE,
    "name" TEXT NOT NULL,
    "name_bg" TEXT,
    "description" TEXT,
    "description_bg" TEXT,
    "secret" TEXT,
    "secret_bg" TEXT,
    "created_at" TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Clues table
CREATE TABLE IF NOT EXISTS "Clues" (
    "clue_id" INTEGER PRIMARY KEY,
    "variation_id" INTEGER NOT NULL REFERENCES "Game_Variations"("variation_id") ON DELETE CASCADE,
    "title" TEXT NOT NULL,
    "title_bg" TEXT,
    "description" TEXT NOT NULL,
    "description_bg" TEXT,
    "created_at" TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Character_Variations junction table
CREATE TABLE IF NOT EXISTS "Character_Variations" (
    "character_id" INTEGER NOT NULL,
    "variation_id" INTEGER NOT NULL,
    PRIMARY KEY ("character_id", "variation_id"),
    FOREIGN KEY ("character_id") REFERENCES "Characters"("character_id") ON DELETE CASCADE,
    FOREIGN KEY ("variation_id") REFERENCES "Game_Variations"("variation_id") ON DELETE CASCADE
);

-- Clue_Rounds junction table
CREATE TABLE IF NOT EXISTS "Clue_Rounds" (
    "clue_id" INTEGER NOT NULL,
    "round_id" INTEGER NOT NULL,
    "clue_number" INTEGER NOT NULL,
    PRIMARY KEY ("clue_id", "round_id"),
    FOREIGN KEY ("clue_id") REFERENCES "Clues"("clue_id") ON DELETE CASCADE,
    FOREIGN KEY ("round_id") REFERENCES "Rounds"("round_id") ON DELETE CASCADE
);

-- Orders table
CREATE TABLE IF NOT EXISTS "Orders" (
    "order_id" UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "user_id" UUID NOT NULL REFERENCES "Users"("user_id") ON DELETE CASCADE,
    "total_amount" DECIMAL(10,2) NOT NULL,
    "status" TEXT NOT NULL DEFAULT 'pending' CHECK (status IN ('pending', 'completed', 'cancelled')),
    "created_at" TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    "updated_at" TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Order_Items table (with TEXT game_id as in your actual schema)
CREATE TABLE IF NOT EXISTS "Order_Items" (
    "order_item_id" UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "order_id" UUID NOT NULL REFERENCES "Orders"("order_id") ON DELETE CASCADE,
    "game_id" TEXT NOT NULL, -- This is TEXT in your actual schema
    "quantity" INTEGER NOT NULL DEFAULT 1,
    "price" DECIMAL(10,2) NOT NULL,
    "created_at" TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- User_Game_Access table
CREATE TABLE IF NOT EXISTS "User_Game_Access" (
    "user_id" UUID NOT NULL REFERENCES "Users"("user_id") ON DELETE CASCADE,
    "game_id" TEXT NOT NULL, -- This is TEXT in your actual schema
    "granted_at" TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    PRIMARY KEY ("user_id", "game_id")
);

-- ============================================================================
-- STEP 2: Create indexes for performance
-- ============================================================================

CREATE INDEX IF NOT EXISTS idx_games_is_active ON "Games"("is_active");
CREATE INDEX IF NOT EXISTS idx_games_featured ON "Games"("featured");
CREATE INDEX IF NOT EXISTS idx_game_variations_game_id ON "Game_Variations"("game_id");
CREATE INDEX IF NOT EXISTS idx_rounds_variation_id ON "Rounds"("variation_id");
CREATE INDEX IF NOT EXISTS idx_characters_variation_id ON "Characters"("variation_id");
CREATE INDEX IF NOT EXISTS idx_clues_variation_id ON "Clues"("variation_id");
CREATE INDEX IF NOT EXISTS idx_character_variations_character_id ON "Character_Variations"("character_id");
CREATE INDEX IF NOT EXISTS idx_character_variations_variation_id ON "Character_Variations"("variation_id");
CREATE INDEX IF NOT EXISTS idx_clue_rounds_clue_id ON "Clue_Rounds"("clue_id");
CREATE INDEX IF NOT EXISTS idx_clue_rounds_round_id ON "Clue_Rounds"("round_id");
CREATE INDEX IF NOT EXISTS idx_orders_user_id ON "Orders"("user_id");
CREATE INDEX IF NOT EXISTS idx_orders_status ON "Orders"("status");
CREATE INDEX IF NOT EXISTS idx_order_items_order_id ON "Order_Items"("order_id");
CREATE INDEX IF NOT EXISTS idx_order_items_game_id ON "Order_Items"("game_id");
CREATE INDEX IF NOT EXISTS idx_user_game_access_user_id ON "User_Game_Access"("user_id");
CREATE INDEX IF NOT EXISTS idx_user_game_access_game_id ON "User_Game_Access"("game_id");

-- ============================================================================
-- STEP 3: Create functions
-- ============================================================================

-- Function to handle new user registration
CREATE OR REPLACE FUNCTION handle_new_user()
RETURNS TRIGGER AS $$
BEGIN
  -- Insert the new user into the Users table
  INSERT INTO "Users" (user_id, email)
  VALUES (NEW.id, NEW.email)
  ON CONFLICT (user_id) DO NOTHING;
  
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY INVOKER;

-- Function to grant game access on purchase
CREATE OR REPLACE FUNCTION grant_game_access_on_purchase()
RETURNS TRIGGER AS $$
DECLARE
  v_user_id UUID;
  v_status TEXT;
BEGIN
  -- Get the user_id and status from the Orders table
  SELECT user_id, status INTO v_user_id, v_status
  FROM "Orders"
  WHERE order_id = NEW.order_id;
  
  -- Only grant access if the order is completed
  IF v_status = 'completed' THEN
    -- Insert access record if it doesn't exist
    INSERT INTO "User_Game_Access" (user_id, game_id)
    VALUES (v_user_id, NEW.game_id)
    ON CONFLICT (user_id, game_id) DO NOTHING;
  END IF;
  
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY INVOKER;

-- Function to get game image URL
CREATE OR REPLACE FUNCTION get_game_image_url(image_path TEXT)
RETURNS TEXT AS $$
DECLARE
    supabase_url TEXT;
    protocol TEXT;
BEGIN
  -- Get protocol setting (default to https://)
  protocol := COALESCE(current_setting('app.settings.protocol', true), 'https://');
  
  -- Get Supabase URL from multiple sources
  supabase_url := COALESCE(
    current_setting('app.settings.supabase_url', true),
    current_setting('SUPABASE_URL', true),
    'bjtoxzbkzrallscuygbo.supabase.co'  -- Production URL
  );
  
  -- If image_path is provided, construct the Supabase Storage URL
  IF image_path IS NOT NULL AND image_path != '' THEN
    RETURN protocol || supabase_url || '/storage/v1/object/public/game-images/' || image_path;
  ELSE
    RETURN NULL;
  END IF;
END;
$$ LANGUAGE plpgsql SECURITY INVOKER;

-- ============================================================================
-- STEP 4: Create triggers
-- ============================================================================

-- Trigger for new user registration
DROP TRIGGER IF EXISTS on_auth_user_created ON auth.users;
CREATE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW
  EXECUTE FUNCTION handle_new_user();

-- Trigger for granting game access on purchase
DROP TRIGGER IF EXISTS grant_game_access_trigger ON "Order_Items";
CREATE TRIGGER grant_game_access_trigger
  AFTER INSERT ON "Order_Items"
  FOR EACH ROW
  EXECUTE FUNCTION grant_game_access_on_purchase();

-- ============================================================================
-- STEP 5: Create views
-- ============================================================================

-- View for games with image URLs
CREATE OR REPLACE VIEW games_with_images AS
SELECT 
    g.*,
    get_game_image_url(g.image_path) as image_url
FROM "Games" g;

-- View for characters with variations (backward compatibility)
CREATE OR REPLACE VIEW "Characters_With_Variations" AS
SELECT 
  c.*,
  cv.variation_id
FROM "Characters" c
JOIN "Character_Variations" cv ON c.character_id = cv.character_id;

-- View for clues with rounds (backward compatibility)
CREATE OR REPLACE VIEW "Clues_With_Rounds" AS
SELECT 
  c.*,
  cr.round_id,
  cr.clue_number
FROM "Clues" c
JOIN "Clue_Rounds" cr ON c.clue_id = cr.clue_id;

-- ============================================================================
-- STEP 6: Enable Row Level Security (RLS)
-- ============================================================================

-- Enable RLS on all tables
ALTER TABLE "Users" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "Games" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "Game_Variations" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "Rounds" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "Characters" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "Clues" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "Character_Variations" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "Clue_Rounds" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "Orders" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "Order_Items" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "User_Game_Access" ENABLE ROW LEVEL SECURITY;

-- ============================================================================
-- STEP 7: Create RLS Policies
-- ============================================================================

-- Users policies
CREATE POLICY "Users can view their own data" ON "Users"
    FOR SELECT USING (auth.uid() = user_id);

CREATE POLICY "Users can update their own data" ON "Users"
    FOR UPDATE USING (auth.uid() = user_id);

-- Games policies (public read access for active games)
CREATE POLICY "Anyone can view active games" ON "Games"
    FOR SELECT USING (is_active = true);

CREATE POLICY "Authenticated users can view all games" ON "Games"
    FOR SELECT USING (auth.role() = 'authenticated');

CREATE POLICY "Authenticated users can manage games" ON "Games"
    FOR ALL USING (auth.role() = 'authenticated');

-- Game_Variations policies (public read access)
CREATE POLICY "Anyone can view game variations" ON "Game_Variations"
    FOR SELECT USING (true);

CREATE POLICY "Authenticated users can manage game variations" ON "Game_Variations"
    FOR ALL USING (auth.role() = 'authenticated');

-- Rounds policies (public read access)
CREATE POLICY "Anyone can view rounds" ON "Rounds"
    FOR SELECT USING (true);

CREATE POLICY "Authenticated users can manage rounds" ON "Rounds"
    FOR ALL USING (auth.role() = 'authenticated');

-- Characters policies (public read access for preview)
CREATE POLICY "Anyone can view characters" ON "Characters"
    FOR SELECT USING (true);

CREATE POLICY "Authenticated users can manage characters" ON "Characters"
    FOR ALL USING (auth.role() = 'authenticated');

-- Clues policies (public read access for preview)
CREATE POLICY "Anyone can view clues" ON "Clues"
    FOR SELECT USING (true);

CREATE POLICY "Authenticated users can manage clues" ON "Clues"
    FOR ALL USING (auth.role() = 'authenticated');

-- Character_Variations policies
CREATE POLICY "Allow read access to Character_Variations" ON "Character_Variations"
    FOR SELECT USING (auth.role() = 'authenticated');

CREATE POLICY "Allow admin access to Character_Variations" ON "Character_Variations"
    FOR ALL USING (auth.role() = 'service_role');

-- Clue_Rounds policies
CREATE POLICY "Allow read access to Clue_Rounds" ON "Clue_Rounds"
    FOR SELECT USING (auth.role() = 'authenticated');

CREATE POLICY "Allow admin access to Clue_Rounds" ON "Clue_Rounds"
    FOR ALL USING (auth.role() = 'service_role');

-- Orders policies
CREATE POLICY "Users can view their own orders" ON "Orders"
    FOR SELECT USING (auth.uid() = user_id);

CREATE POLICY "Users can insert their own orders" ON "Orders"
    FOR INSERT WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update their own orders" ON "Orders"
    FOR UPDATE USING (auth.uid() = user_id);

-- Order_Items policies
CREATE POLICY "Users can view their own order items" ON "Order_Items"
    FOR SELECT USING (
        EXISTS (
            SELECT 1 FROM "Orders" o 
            WHERE o.order_id = "Order_Items".order_id 
            AND o.user_id = auth.uid()
        )
    );

CREATE POLICY "Users can insert their own order items" ON "Order_Items"
    FOR INSERT WITH CHECK (
        EXISTS (
            SELECT 1 FROM "Orders" o 
            WHERE o.order_id = "Order_Items".order_id 
            AND o.user_id = auth.uid()
        )
    );

-- User_Game_Access policies
CREATE POLICY "Users can view their own game access" ON "User_Game_Access"
    FOR SELECT USING (auth.uid() = user_id);

CREATE POLICY "Users can insert their own game access" ON "User_Game_Access"
    FOR INSERT WITH CHECK (auth.uid() = user_id);

-- ============================================================================
-- STEP 8: Configure application settings
-- ============================================================================

-- Set production Supabase URL
SELECT set_config('app.settings.supabase_url', 'bjtoxzbkzrallscuygbo.supabase.co', false);
SELECT set_config('app.settings.protocol', 'https://', false);

-- ============================================================================
-- STEP 9: Grant necessary permissions
-- ============================================================================

-- Grant SELECT permissions to anonymous users for public data
GRANT SELECT ON "Games" TO anon;
GRANT SELECT ON "Game_Variations" TO anon;
GRANT SELECT ON "Rounds" TO anon;
GRANT SELECT ON "Characters" TO anon;
GRANT SELECT ON "Clues" TO anon;
GRANT SELECT ON games_with_images TO anon;

-- ============================================================================
-- Setup Complete
-- ============================================================================

-- Your production database now has the complete schema matching staging
-- All tables, functions, triggers, views, and policies are in place
-- The schema includes: Games, Game_Variations, Rounds, Characters, Clues, 
-- Character_Variations, Clue_Rounds, Orders, Order_Items, User_Game_Access 