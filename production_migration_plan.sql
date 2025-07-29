-- ============================================================================
-- PRODUCTION DATABASE MIGRATION PLAN
-- Run this on your NEW production Supabase database
-- ============================================================================

-- ============================================================================
-- STEP 1: Create all tables (if not using migrations)
-- ============================================================================

-- Users table (if not using Supabase Auth)
CREATE TABLE IF NOT EXISTS "Users" (
    user_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    email VARCHAR(255) UNIQUE NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Games table
CREATE TABLE IF NOT EXISTS "Games" (
    game_id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    title_bg VARCHAR(255),
    description TEXT,
    description_bg TEXT,
    price DECIMAL(10,2) NOT NULL,
    difficulty VARCHAR(50),
    duration_minutes INTEGER,
    min_players INTEGER,
    max_players INTEGER,
    image VARCHAR(500),
    image_path VARCHAR(500),
    is_active BOOLEAN DEFAULT true,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Game Variations table
CREATE TABLE IF NOT EXISTS "Game_Variations" (
    variation_id SERIAL PRIMARY KEY,
    game_id INTEGER REFERENCES "Games"(game_id) ON DELETE CASCADE,
    min_players INTEGER NOT NULL,
    max_players INTEGER NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Characters table
CREATE TABLE IF NOT EXISTS "Characters" (
    character_id SERIAL PRIMARY KEY,
    game_id INTEGER REFERENCES "Games"(game_id) ON DELETE CASCADE,
    name VARCHAR(255) NOT NULL,
    name_bg VARCHAR(255),
    description TEXT,
    description_bg TEXT,
    image VARCHAR(500),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Character Variations table
CREATE TABLE IF NOT EXISTS "Character_Variations" (
    character_variation_id SERIAL PRIMARY KEY,
    character_id INTEGER REFERENCES "Characters"(character_id) ON DELETE CASCADE,
    variation_id INTEGER REFERENCES "Game_Variations"(variation_id) ON DELETE CASCADE,
    is_included BOOLEAN DEFAULT true,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Clues table
CREATE TABLE IF NOT EXISTS "Clues" (
    clue_id SERIAL PRIMARY KEY,
    game_id INTEGER REFERENCES "Games"(game_id) ON DELETE CASCADE,
    character_id INTEGER REFERENCES "Characters"(character_id) ON DELETE CASCADE,
    content TEXT NOT NULL,
    content_bg TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Rounds table
CREATE TABLE IF NOT EXISTS "Rounds" (
    round_id SERIAL PRIMARY KEY,
    variation_id INTEGER REFERENCES "Game_Variations"(variation_id) ON DELETE CASCADE,
    round_number INTEGER NOT NULL,
    title VARCHAR(255) NOT NULL,
    title_bg VARCHAR(255),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Round Clues table
CREATE TABLE IF NOT EXISTS "Round_Clues" (
    round_clue_id SERIAL PRIMARY KEY,
    round_id INTEGER REFERENCES "Rounds"(round_id) ON DELETE CASCADE,
    clue_id INTEGER REFERENCES "Clues"(clue_id) ON DELETE CASCADE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Final Reveals table
CREATE TABLE IF NOT EXISTS "Final_Reveals" (
    reveal_id SERIAL PRIMARY KEY,
    variation_id INTEGER REFERENCES "Game_Variations"(variation_id) ON DELETE CASCADE,
    content TEXT NOT NULL,
    content_bg TEXT,
    murderer_name VARCHAR(255),
    murderer_name_bg VARCHAR(255),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Orders table
CREATE TABLE IF NOT EXISTS "Orders" (
    order_id SERIAL PRIMARY KEY,
    user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
    total_amount DECIMAL(10,2) NOT NULL,
    status VARCHAR(50) DEFAULT 'pending',
    payment_intent_id VARCHAR(255),
    order_date TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Order Items table
CREATE TABLE IF NOT EXISTS "Order_Items" (
    order_item_id SERIAL PRIMARY KEY,
    order_id INTEGER REFERENCES "Orders"(order_id) ON DELETE CASCADE,
    game_id INTEGER REFERENCES "Games"(game_id) ON DELETE CASCADE,
    quantity INTEGER DEFAULT 1,
    price DECIMAL(10,2) NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- User Game Access table
CREATE TABLE IF NOT EXISTS "User_Game_Access" (
    user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
    game_id INTEGER REFERENCES "Games"(game_id) ON DELETE CASCADE,
    access_granted TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (user_id, game_id)
);

-- ============================================================================
-- STEP 2: Enable Row Level Security (RLS)
-- ============================================================================

ALTER TABLE "Games" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "Game_Variations" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "Characters" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "Character_Variations" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "Clues" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "Rounds" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "Round_Clues" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "Final_Reveals" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "Orders" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "Order_Items" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "User_Game_Access" ENABLE ROW LEVEL SECURITY;

-- ============================================================================
-- STEP 3: Create RLS Policies
-- ============================================================================

-- Games policies
CREATE POLICY "Anyone can view active games" ON "Games"
FOR SELECT USING (is_active = true);

-- Game Variations policies
CREATE POLICY "Anyone can view game variations" ON "Game_Variations"
FOR SELECT USING (true);

-- Characters policies
CREATE POLICY "Anyone can view characters" ON "Characters"
FOR SELECT USING (true);

-- Character Variations policies
CREATE POLICY "Anyone can view character variations" ON "Character_Variations"
FOR SELECT USING (true);

-- Clues policies
CREATE POLICY "Anyone can view clues" ON "Clues"
FOR SELECT USING (true);

-- Rounds policies
CREATE POLICY "Anyone can view rounds" ON "Rounds"
FOR SELECT USING (true);

-- Round Clues policies
CREATE POLICY "Anyone can view round clues" ON "Round_Clues"
FOR SELECT USING (true);

-- Final Reveals policies
CREATE POLICY "Anyone can view final reveals" ON "Final_Reveals"
FOR SELECT USING (true);

-- Orders policies
CREATE POLICY "Users can view their own orders" ON "Orders"
FOR SELECT USING (user_id = auth.uid());

CREATE POLICY "Users can create their own orders" ON "Orders"
FOR INSERT WITH CHECK (user_id = auth.uid());

CREATE POLICY "Users can update their own orders" ON "Orders"
FOR UPDATE USING (user_id = auth.uid()) WITH CHECK (user_id = auth.uid());

-- Order Items policies
CREATE POLICY "Users can view their own order items" ON "Order_Items"
FOR SELECT USING (
  EXISTS (
    SELECT 1 FROM "Orders"
    WHERE "Orders".order_id = "Order_Items".order_id
    AND "Orders".user_id = auth.uid()
  )
);

CREATE POLICY "Allow authenticated users to create order items" ON "Order_Items"
FOR INSERT WITH CHECK (auth.role() = 'authenticated');

-- User Game Access policies
CREATE POLICY "Users can view their own game access" ON "User_Game_Access"
FOR SELECT USING (user_id = auth.uid());

CREATE POLICY "Allow authenticated users to create game access" ON "User_Game_Access"
FOR INSERT WITH CHECK (auth.role() = 'authenticated');

CREATE POLICY "Users can update their own game access" ON "User_Game_Access"
FOR UPDATE USING (user_id = auth.uid()) WITH CHECK (user_id = auth.uid());

CREATE POLICY "Users can delete their own game access" ON "User_Game_Access"
FOR DELETE USING (user_id = auth.uid());

-- ============================================================================
-- STEP 4: Grant Permissions
-- ============================================================================

GRANT SELECT ON "Games" TO authenticated, anon;
GRANT SELECT ON "Game_Variations" TO authenticated, anon;
GRANT SELECT ON "Characters" TO authenticated, anon;
GRANT SELECT ON "Character_Variations" TO authenticated, anon;
GRANT SELECT ON "Clues" TO authenticated, anon;
GRANT SELECT ON "Rounds" TO authenticated, anon;
GRANT SELECT ON "Round_Clues" TO authenticated, anon;
GRANT SELECT ON "Final_Reveals" TO authenticated, anon;

GRANT SELECT, INSERT, UPDATE ON "Orders" TO authenticated;
GRANT SELECT, INSERT ON "Order_Items" TO authenticated;
GRANT SELECT, INSERT, UPDATE, DELETE ON "User_Game_Access" TO authenticated;

-- ============================================================================
-- STEP 5: Create Functions and Triggers
-- ============================================================================

-- Function to grant game access on purchase
CREATE OR REPLACE FUNCTION grant_game_access_on_purchase()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO "User_Game_Access" (user_id, game_id, access_granted)
  VALUES (
    (SELECT user_id FROM "Orders" WHERE order_id = NEW.order_id),
    NEW.game_id,
    NOW()
  )
  ON CONFLICT (user_id, game_id) DO NOTHING;
  
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Trigger to automatically grant game access
CREATE TRIGGER trg_grant_game_access
  AFTER INSERT ON "Order_Items"
  FOR EACH ROW
  EXECUTE FUNCTION grant_game_access_on_purchase();

-- ============================================================================
-- STEP 6: Create Indexes for Performance
-- ============================================================================

CREATE INDEX IF NOT EXISTS idx_games_active ON "Games"(is_active);
CREATE INDEX IF NOT EXISTS idx_game_variations_game_id ON "Game_Variations"(game_id);
CREATE INDEX IF NOT EXISTS idx_characters_game_id ON "Characters"(game_id);
CREATE INDEX IF NOT EXISTS idx_clues_game_id ON "Clues"(game_id);
CREATE INDEX IF NOT EXISTS idx_orders_user_id ON "Orders"(user_id);
CREATE INDEX IF NOT EXISTS idx_order_items_order_id ON "Order_Items"(order_id);
CREATE INDEX IF NOT EXISTS idx_user_game_access_user_id ON "User_Game_Access"(user_id);
CREATE INDEX IF NOT EXISTS idx_user_game_access_game_id ON "User_Game_Access"(game_id);

-- ============================================================================
-- STEP 7: Insert Production Data
-- ============================================================================

-- Insert your games data here
-- (Copy from your staging database)

-- ============================================================================
-- STEP 8: Verify Setup
-- ============================================================================

SELECT 'Database setup complete' as status;
SELECT COUNT(*) as games_count FROM "Games";
SELECT COUNT(*) as users_count FROM auth.users; 