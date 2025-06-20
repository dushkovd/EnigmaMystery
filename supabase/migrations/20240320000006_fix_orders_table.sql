-- Ensure Orders table has the correct structure
DO $$ 
BEGIN
    -- Add order_id if it doesn't exist
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns 
                  WHERE table_name = 'Orders' AND column_name = 'order_id') THEN
        ALTER TABLE "Orders" ADD COLUMN "order_id" UUID DEFAULT gen_random_uuid() PRIMARY KEY;
    END IF;

    -- Add user_id if it doesn't exist
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns 
                  WHERE table_name = 'Orders' AND column_name = 'user_id') THEN
        ALTER TABLE "Orders" ADD COLUMN "user_id" UUID NOT NULL;
    END IF;

    -- Add total_amount if it doesn't exist
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns 
                  WHERE table_name = 'Orders' AND column_name = 'total_amount') THEN
        ALTER TABLE "Orders" ADD COLUMN "total_amount" DECIMAL(10,2) NOT NULL;
    END IF;

    -- Add status if it doesn't exist
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns 
                  WHERE table_name = 'Orders' AND column_name = 'status') THEN
        ALTER TABLE "Orders" ADD COLUMN "status" TEXT NOT NULL DEFAULT 'pending';
    END IF;

    -- Add payment_intent_id if it doesn't exist
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns 
                  WHERE table_name = 'Orders' AND column_name = 'payment_intent_id') THEN
        ALTER TABLE "Orders" ADD COLUMN "payment_intent_id" TEXT;
    END IF;

    -- Add created_at if it doesn't exist
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns 
                  WHERE table_name = 'Orders' AND column_name = 'created_at') THEN
        ALTER TABLE "Orders" ADD COLUMN "created_at" TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP;
    END IF;
END $$;

-- Add foreign key constraint for user_id if it doesn't exist
DO $$ 
BEGIN
    IF NOT EXISTS (SELECT 1 FROM information_schema.table_constraints 
                  WHERE table_name = 'Orders' 
                  AND constraint_name = 'Orders_user_id_fkey') THEN
        ALTER TABLE "Orders" 
        ADD CONSTRAINT "Orders_user_id_fkey" 
        FOREIGN KEY (user_id) REFERENCES auth.users(id);
    END IF;
END $$;

-- Add comments
COMMENT ON COLUMN "Orders"."order_id" IS 'Primary key for the order';
COMMENT ON COLUMN "Orders"."user_id" IS 'Reference to the user who placed the order';
COMMENT ON COLUMN "Orders"."total_amount" IS 'Total amount of the order';
COMMENT ON COLUMN "Orders"."status" IS 'Status of the order (pending, completed, cancelled)';
COMMENT ON COLUMN "Orders"."payment_intent_id" IS 'Stripe payment intent ID';
COMMENT ON COLUMN "Orders"."created_at" IS 'When the order was created'; 