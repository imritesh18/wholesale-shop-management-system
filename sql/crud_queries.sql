-- ============================================================
--  WHOLESALE SHOP MANAGEMENT SYSTEM - CRUD QUERIES
--  Use these queries to practice SQL for TCS interviews
-- ============================================================

USE wholesale_shop_db;

-- ============================================================
--  SECTION 1: PRODUCT CRUD OPERATIONS
-- ============================================================

-- CREATE: Add a new product
INSERT INTO products (product_name, category_id, unit_price, cost_price, unit_type, stock_qty, reorder_level)
VALUES ('New Product Name', 1, 500.00, 400.00, 'piece', 100, 20);

-- READ: View all products with category name (JOIN)
SELECT
    p.product_id,
    p.product_name,
    c.category_name,
    p.unit_price,
    p.cost_price,
    p.stock_qty,
    p.unit_type,
    p.reorder_level
FROM products p
JOIN categories c ON p.category_id = c.category_id
ORDER BY c.category_name, p.product_name;

-- READ: Search product by name
SELECT * FROM products WHERE product_name LIKE '%rice%';

-- READ: Products with low stock (below reorder level)
SELECT product_name, stock_qty, reorder_level
FROM products
WHERE stock_qty <= reorder_level
ORDER BY stock_qty ASC;

-- UPDATE: Update product price
UPDATE products
SET unit_price = 1900.00, updated_at = CURRENT_TIMESTAMP
WHERE product_id = 1;

-- UPDATE: Update stock quantity
UPDATE products
SET stock_qty = stock_qty + 50
WHERE product_id = 1;

-- DELETE: Delete a product (only if no bill references it)
DELETE FROM products WHERE product_id = 1;


-- ============================================================
--  SECTION 2: CUSTOMER CRUD OPERATIONS
-- ============================================================

-- CREATE: Add a new customer
INSERT INTO customers (customer_name, phone, email, address, gst_number, credit_limit)
VALUES ('New Customer', '9000000001', 'new@gmail.com', 'Address here', 'GST123456', 50000.00);

-- READ: View all customers
SELECT customer_id, customer_name, phone, email, credit_limit
FROM customers
ORDER BY customer_name;

-- READ: Search customer by name or phone
SELECT * FROM customers
WHERE customer_name LIKE '%ramesh%' OR phone = '9876543210';

-- UPDATE: Update customer contact info
UPDATE customers
SET phone = '9111111111', email = 'updated@gmail.com'
WHERE customer_id = 1;

-- UPDATE: Increase customer credit limit
UPDATE customers
SET credit_limit = 100000.00
WHERE customer_id = 1;

-- DELETE: Delete a customer
DELETE FROM customers WHERE customer_id = 7;


-- ============================================================
--  SECTION 3: BILLING CRUD OPERATIONS
-- ============================================================

-- CREATE: Insert a new bill header
INSERT INTO bills (customer_id, bill_date, total_amount, discount_pct, tax_pct, final_amount, payment_status, payment_mode)
VALUES (1, CURDATE(), 5000.00, 5.00, 18.00, 5605.00, 'Unpaid', 'Credit');

-- CREATE: Insert bill items for the new bill
INSERT INTO bill_items (bill_id, product_id, quantity, unit_price, subtotal)
VALUES (LAST_INSERT_ID(), 2, 5, 450.00, 2250.00);

-- READ: View all bills with customer name
SELECT
    b.bill_id,
    c.customer_name,
    b.bill_date,
    b.total_amount,
    b.discount_pct,
    b.tax_pct,
    b.final_amount,
    b.payment_status,
    b.payment_mode
FROM bills b
JOIN customers c ON b.customer_id = c.customer_id
ORDER BY b.bill_date DESC;

-- READ: View complete bill details (header + line items)
SELECT
    b.bill_id,
    c.customer_name,
    b.bill_date,
    p.product_name,
    bi.quantity,
    bi.unit_price,
    bi.subtotal,
    b.discount_pct,
    b.tax_pct,
    b.final_amount,
    b.payment_status
FROM bills b
JOIN customers  c  ON b.customer_id  = c.customer_id
JOIN bill_items bi ON b.bill_id      = bi.bill_id
JOIN products   p  ON bi.product_id  = p.product_id
WHERE b.bill_id = 1;

-- UPDATE: Mark a bill as paid
UPDATE bills
SET payment_status = 'Paid', payment_mode = 'Cash'
WHERE bill_id = 3;

-- READ: Unpaid bills list
SELECT b.bill_id, c.customer_name, b.bill_date, b.final_amount
FROM bills b
JOIN customers c ON b.customer_id = c.customer_id
WHERE b.payment_status = 'Unpaid'
ORDER BY b.bill_date;


-- ============================================================
--  SECTION 4: INVENTORY MANAGEMENT QUERIES
-- ============================================================

-- CREATE: Log a new stock purchase
INSERT INTO inventory_log (product_id, change_type, quantity, remarks)
VALUES (1, 'Purchase', 50, 'Purchased from ABC Supplier');

-- Then update stock in products table
UPDATE products SET stock_qty = stock_qty + 50 WHERE product_id = 1;

-- READ: Full inventory log with product names
SELECT
    il.log_id,
    p.product_name,
    il.change_type,
    il.quantity,
    il.remarks,
    il.log_date
FROM inventory_log il
JOIN products p ON il.product_id = p.product_id
ORDER BY il.log_date DESC;

-- READ: Current stock status of all products
SELECT
    p.product_name,
    c.category_name,
    p.stock_qty,
    p.reorder_level,
    p.unit_type,
    CASE
        WHEN p.stock_qty = 0            THEN 'OUT OF STOCK'
        WHEN p.stock_qty <= p.reorder_level THEN 'LOW STOCK'
        ELSE 'IN STOCK'
    END AS stock_status
FROM products p
JOIN categories c ON p.category_id = c.category_id
ORDER BY p.stock_qty ASC;


-- ============================================================
--  SECTION 5: BUSINESS ANALYTICS / REPORTS
-- ============================================================

-- Total revenue from paid bills
SELECT
    SUM(final_amount) AS total_revenue
FROM bills
WHERE payment_status = 'Paid';

-- Monthly sales summary
SELECT
    DATE_FORMAT(bill_date, '%Y-%m') AS month,
    COUNT(bill_id)                  AS total_bills,
    SUM(final_amount)               AS total_revenue
FROM bills
GROUP BY DATE_FORMAT(bill_date, '%Y-%m')
ORDER BY month DESC;

-- Top 5 best-selling products by quantity
SELECT
    p.product_name,
    SUM(bi.quantity)  AS total_sold,
    SUM(bi.subtotal)  AS total_revenue
FROM bill_items bi
JOIN products p ON bi.product_id = p.product_id
GROUP BY p.product_id, p.product_name
ORDER BY total_sold DESC
LIMIT 5;

-- Top customers by purchase value
SELECT
    c.customer_name,
    COUNT(b.bill_id)    AS total_orders,
    SUM(b.final_amount) AS total_purchase
FROM customers c
JOIN bills b ON c.customer_id = b.customer_id
GROUP BY c.customer_id, c.customer_name
ORDER BY total_purchase DESC;

-- Profit margin per product (unit_price - cost_price)
SELECT
    product_name,
    unit_price,
    cost_price,
    (unit_price - cost_price)                              AS profit_per_unit,
    ROUND((unit_price - cost_price) / unit_price * 100, 2) AS profit_margin_pct
FROM products
ORDER BY profit_margin_pct DESC;

-- Outstanding dues (Unpaid + Partial bills)
SELECT
    c.customer_name,
    c.phone,
    SUM(b.final_amount) AS amount_due
FROM bills b
JOIN customers c ON b.customer_id = c.customer_id
WHERE b.payment_status IN ('Unpaid', 'Partial')
GROUP BY c.customer_id, c.customer_name, c.phone
ORDER BY amount_due DESC;

-- ============================================================
-- END OF CRUD QUERIES
-- ============================================================
