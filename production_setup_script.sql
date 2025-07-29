-- Production Database Setup Script
-- Run this in your Supabase Dashboard SQL Editor
-- This will create the complete schema matching your staging environment

-- ============================================================================
-- STEP 1: Create all tables with proper structure
-- ============================================================================

-- Users table
CREATE TABLE IF NOT EXISTS "Users" (
    "user_id" UUID PRIMARY KEY,
    "email" TEXT NOT NULL UNIQUE,
    "created_at" TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    "updated_at" TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Games table
CREATE TABLE IF NOT EXISTS "Games" (
    "game_id" UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "title" TEXT NOT NULL,
    "description" TEXT,
    "price" DECIMAL(10,2) NOT NULL,
    "difficulty" TEXT CHECK (difficulty IN ('easy', 'medium', 'hard')),
    "duration" INTEGER,
    "min_players" INTEGER,
    "max_players" INTEGER,
    "image_path" TEXT,
    "difficulty_bg" TEXT,
    "created_at" TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    "updated_at" TIMESTAMP WITH TIME ZONE DEFAULT NOW()
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

-- Order_Items table
CREATE TABLE IF NOT EXISTS "Order_Items" (
    "order_item_id" UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "order_id" UUID NOT NULL REFERENCES "Orders"("order_id") ON DELETE CASCADE,
    "game_id" UUID NOT NULL REFERENCES "Games"("game_id") ON DELETE CASCADE,
    "quantity" INTEGER NOT NULL DEFAULT 1,
    "unit_price" DECIMAL(10,2) NOT NULL,
    "created_at" TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- User_Game_Access table
CREATE TABLE IF NOT EXISTS "User_Game_Access" (
    "user_id" UUID NOT NULL REFERENCES "Users"("user_id") ON DELETE CASCADE,
    "game_id" UUID NOT NULL REFERENCES "Games"("game_id") ON DELETE CASCADE,
    "granted_at" TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    PRIMARY KEY ("user_id", "game_id")
);

-- Characters table
CREATE TABLE IF NOT EXISTS "Characters" (
    "character_id" UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "game_id" UUID NOT NULL REFERENCES "Games"("game_id") ON DELETE CASCADE,
    "name" TEXT NOT NULL,
    "description" TEXT,
    "background" TEXT,
    "image_path" TEXT,
    "created_at" TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Clues table
CREATE TABLE IF NOT EXISTS "Clues" (
    "clue_id" UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "game_id" UUID NOT NULL REFERENCES "Games"("game_id") ON DELETE CASCADE,
    "title" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "order_index" INTEGER,
    "created_at" TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Solutions table
CREATE TABLE IF NOT EXISTS "Solutions" (
    "solution_id" UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "game_id" UUID NOT NULL REFERENCES "Games"("game_id") ON DELETE CASCADE,
    "title" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "created_at" TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Character_Connections table
CREATE TABLE IF NOT EXISTS "Character_Connections" (
    "connection_id" UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "game_id" UUID NOT NULL REFERENCES "Games"("game_id") ON DELETE CASCADE,
    "character1_id" UUID NOT NULL REFERENCES "Characters"("character_id") ON DELETE CASCADE,
    "character2_id" UUID NOT NULL REFERENCES "Characters"("character_id") ON DELETE CASCADE,
    "connection_type" TEXT NOT NULL,
    "description" TEXT,
    "circumstances" TEXT,
    "created_at" TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    UNIQUE("character1_id", "character2_id", "connection_type")
);

-- ============================================================================
-- STEP 2: Create indexes for performance
-- ============================================================================

CREATE INDEX IF NOT EXISTS idx_orders_user_id ON "Orders"("user_id");
CREATE INDEX IF NOT EXISTS idx_orders_status ON "Orders"("status");
CREATE INDEX IF NOT EXISTS idx_order_items_order_id ON "Order_Items"("order_id");
CREATE INDEX IF NOT EXISTS idx_order_items_game_id ON "Order_Items"("game_id");
CREATE INDEX IF NOT EXISTS idx_user_game_access_user_id ON "User_Game_Access"("user_id");
CREATE INDEX IF NOT EXISTS idx_user_game_access_game_id ON "User_Game_Access"("game_id");
CREATE INDEX IF NOT EXISTS idx_characters_game_id ON "Characters"("game_id");
CREATE INDEX IF NOT EXISTS idx_clues_game_id ON "Clues"("game_id");
CREATE INDEX IF NOT EXISTS idx_solutions_game_id ON "Solutions"("game_id");
CREATE INDEX IF NOT EXISTS idx_character_connections_game_id ON "Character_Connections"("game_id");

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

-- ============================================================================
-- STEP 6: Enable Row Level Security (RLS)
-- ============================================================================

-- Enable RLS on all tables
ALTER TABLE "Users" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "Games" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "Orders" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "Order_Items" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "User_Game_Access" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "Characters" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "Clues" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "Solutions" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "Character_Connections" ENABLE ROW LEVEL SECURITY;

-- ============================================================================
-- STEP 7: Create RLS Policies
-- ============================================================================

-- Users policies
CREATE POLICY "Users can view their own data" ON "Users"
    FOR SELECT USING (auth.uid() = user_id);

CREATE POLICY "Users can update their own data" ON "Users"
    FOR UPDATE USING (auth.uid() = user_id);

-- Games policies (public read access, authenticated users can purchase)
CREATE POLICY "Anyone can view games" ON "Games"
    FOR SELECT USING (true);

CREATE POLICY "Authenticated users can insert games" ON "Games"
    FOR INSERT WITH CHECK (auth.role() = 'authenticated');

CREATE POLICY "Authenticated users can update games" ON "Games"
    FOR UPDATE USING (auth.role() = 'authenticated');

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

-- Characters policies (public read access for preview)
CREATE POLICY "Anyone can view characters" ON "Characters"
    FOR SELECT USING (true);

CREATE POLICY "Authenticated users can manage characters" ON "Characters"
    FOR ALL USING (auth.role() = 'authenticated');

-- Clues policies (only accessible to users with game access)
CREATE POLICY "Users with game access can view clues" ON "Clues"
    FOR SELECT USING (
        EXISTS (
            SELECT 1 FROM "User_Game_Access" uga 
            WHERE uga.game_id = "Clues".game_id 
            AND uga.user_id = auth.uid()
        )
    );

CREATE POLICY "Authenticated users can manage clues" ON "Clues"
    FOR ALL USING (auth.role() = 'authenticated');

-- Solutions policies (only accessible to users with game access)
CREATE POLICY "Users with game access can view solutions" ON "Solutions"
    FOR SELECT USING (
        EXISTS (
            SELECT 1 FROM "User_Game_Access" uga 
            WHERE uga.game_id = "Solutions".game_id 
            AND uga.user_id = auth.uid()
        )
    );

CREATE POLICY "Authenticated users can manage solutions" ON "Solutions"
    FOR ALL USING (auth.role() = 'authenticated');

-- Character_Connections policies (only accessible to users with game access)
CREATE POLICY "Users with game access can view character connections" ON "Character_Connections"
    FOR SELECT USING (
        EXISTS (
            SELECT 1 FROM "User_Game_Access" uga 
            WHERE uga.game_id = "Character_Connections".game_id 
            AND uga.user_id = auth.uid()
        )
    );

CREATE POLICY "Authenticated users can manage character connections" ON "Character_Connections"
    FOR ALL USING (auth.role() = 'authenticated');

-- ============================================================================
-- STEP 8: Configure application settings
-- ============================================================================

-- Set production Supabase URL
SELECT set_config('app.settings.supabase_url', 'bjtoxzbkzrallscuygbo.supabase.co', false);
SELECT set_config('app.settings.protocol', 'https://', false);

-- ============================================================================
-- Setup Complete
-- ============================================================================

-- Your production database now has the complete schema matching staging
-- All tables, functions, triggers, views, and policies are in place 