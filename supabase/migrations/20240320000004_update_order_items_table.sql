-- Ensure Order_Items table has all required columns
DO $$ 
BEGIN
    -- Add order_id if it doesn't exist
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns 
                  WHERE table_name = 'Order_Items' AND column_name = 'order_id') THEN
        ALTER TABLE "Order_Items" ADD COLUMN "order_id" UUID NOT NULL;
    END IF;

    -- Add game_id if it doesn't exist
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns 
                  WHERE table_name = 'Order_Items' AND column_name = 'game_id') THEN
        ALTER TABLE "Order_Items" ADD COLUMN "game_id" TEXT NOT NULL;
    END IF;

    -- Add quantity if it doesn't exist
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns 
                  WHERE table_name = 'Order_Items' AND column_name = 'quantity') THEN
        ALTER TABLE "Order_Items" ADD COLUMN "quantity" INTEGER NOT NULL DEFAULT 1;
    END IF;

    -- Add price if it doesn't exist
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns 
                  WHERE table_name = 'Order_Items' AND column_name = 'price') THEN
        ALTER TABLE "Order_Items" ADD COLUMN "price" DECIMAL(10,2) NOT NULL;
    END IF;

    -- Add created_at if it doesn't exist
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns 
                  WHERE table_name = 'Order_Items' AND column_name = 'created_at') THEN
        ALTER TABLE "Order_Items" ADD COLUMN "created_at" TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP;
    END IF;
END $$;

-- Add foreign key constraints if they don't exist
DO $$ 
BEGIN
    -- Add foreign key to Orders table if it doesn't exist
    IF NOT EXISTS (SELECT 1 FROM information_schema.table_constraints 
                  WHERE table_name = 'Order_Items' 
                  AND constraint_name = 'Order_Items_order_id_fkey') THEN
        ALTER TABLE "Order_Items" 
        ADD CONSTRAINT "Order_Items_order_id_fkey" 
        FOREIGN KEY (order_id) REFERENCES "Orders"(order_id);
    END IF;

    -- Add foreign key to Games table if it doesn't exist
    IF NOT EXISTS (SELECT 1 FROM information_schema.table_constraints 
                  WHERE table_name = 'Order_Items' 
                  AND constraint_name = 'Order_Items_game_id_fkey') THEN
        ALTER TABLE "Order_Items" 
        ADD CONSTRAINT "Order_Items_game_id_fkey" 
        FOREIGN KEY (game_id) REFERENCES "Games"(game_id);
    END IF;
END $$;

-- Add comments
COMMENT ON COLUMN "Order_Items"."order_id" IS 'Reference to the order';
COMMENT ON COLUMN "Order_Items"."game_id" IS 'Reference to the game';
COMMENT ON COLUMN "Order_Items"."quantity" IS 'Number of items ordered';
COMMENT ON COLUMN "Order_Items"."price" IS 'Price per item at time of purchase';
COMMENT ON COLUMN "Order_Items"."created_at" IS 'When the order item was created'; 