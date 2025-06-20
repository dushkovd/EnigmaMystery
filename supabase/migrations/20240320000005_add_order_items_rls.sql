-- Enable RLS on Order_Items table
ALTER TABLE "Order_Items" ENABLE ROW LEVEL SECURITY;

-- Allow users to view their own order items
CREATE POLICY "Users can view their own order items"
ON "Order_Items"
FOR SELECT
USING (
  EXISTS (
    SELECT 1 FROM "Orders"
    WHERE "Orders".order_id = "Order_Items".order_id
    AND "Orders".user_id = auth.uid()
  )
);

-- Allow users to create order items for their own orders
CREATE POLICY "Users can create order items for their own orders"
ON "Order_Items"
FOR INSERT
WITH CHECK (
  EXISTS (
    SELECT 1 FROM "Orders"
    WHERE "Orders".order_id = "Order_Items".order_id
    AND "Orders".user_id = auth.uid()
  )
);

-- Allow users to update their own order items
CREATE POLICY "Users can update their own order items"
ON "Order_Items"
FOR UPDATE
USING (
  EXISTS (
    SELECT 1 FROM "Orders"
    WHERE "Orders".order_id = "Order_Items".order_id
    AND "Orders".user_id = auth.uid()
  )
)
WITH CHECK (
  EXISTS (
    SELECT 1 FROM "Orders"
    WHERE "Orders".order_id = "Order_Items".order_id
    AND "Orders".user_id = auth.uid()
  )
); 