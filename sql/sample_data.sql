-- ============================================================
--  WHOLESALE SHOP MANAGEMENT SYSTEM - SAMPLE DATA
--  Run this AFTER schema.sql
-- ============================================================

USE wholesale_shop_db;

-- ============================================================
-- INSERT: Categories
-- ============================================================
INSERT INTO categories (category_name, description) VALUES
('Groceries',    'Daily use food and grocery items'),
('Electronics',  'Electronic devices and accessories'),
('Beverages',    'Drinks, juices and cold beverages'),
('Stationery',   'Office and school stationery supplies'),
('Cleaning',     'Cleaning and hygiene products');

-- ============================================================
-- INSERT: Products
-- ============================================================
INSERT INTO products (product_name, category_id, unit_price, cost_price, unit_type, stock_qty, reorder_level) VALUES
-- Groceries (category_id = 1)
('Basmati Rice 25kg',      1,  1800.00,  1500.00, 'bag',    50,  10),
('Wheat Flour 10kg',       1,   450.00,   380.00, 'bag',    80,  15),
('Sugar 50kg',             1,  2200.00,  1950.00, 'bag',    40,  10),
('Refined Oil 15L',        1,  1650.00,  1430.00, 'tin',    60,  10),
('Toor Dal 5kg',           1,   700.00,   600.00, 'packet', 100,  20),

-- Electronics (category_id = 2)
('LED Bulb 9W',            2,    85.00,    60.00, 'piece', 200,  30),
('USB Charger 2A',         2,   250.00,   180.00, 'piece', 150,  25),
('Extension Board 4-plug', 2,   380.00,   290.00, 'piece',  75,  15),
('AA Battery (Pack of 4)', 2,    90.00,    65.00, 'pack',  300,  50),
('Torch LED Medium',       2,   350.00,   260.00, 'piece',  60,  10),

-- Beverages (category_id = 3)
('Coca-Cola 2L (Case 6)',  3,   480.00,   390.00, 'case',   90,  20),
('Mineral Water 1L x 12', 3,   180.00,   140.00, 'case',  120,  25),
('Fruit Juice 1L x 12',   3,   960.00,   800.00, 'case',   45,  10),
('Tea Bags 100pcs',        3,   220.00,   170.00, 'box',   160,  30),

-- Stationery (category_id = 4)
('A4 Paper 500 sheets',    4,   320.00,   260.00, 'ream',   80,  15),
('Ball Pen Box (10pc)',    4,    90.00,    65.00, 'box',   250,  40),
('Notebook A5 (Pack 10)', 4,   350.00,   280.00, 'pack',  100,  20),

-- Cleaning (category_id = 5)
('Detergent Powder 5kg',  5,   450.00,   370.00, 'bag',   130,  25),
('Floor Cleaner 5L',      5,   380.00,   300.00, 'can',    70,  15),
('Dishwash Liquid 2L',    5,   220.00,   170.00, 'bottle', 110,  20);

-- ============================================================
-- INSERT: Customers
-- ============================================================
INSERT INTO customers (customer_name, phone, email, address, gst_number, credit_limit) VALUES
('Ramesh General Store',   '9876543210', 'ramesh@gmail.com',    '12, MG Road, Delhi',            '07AABCU9603R1ZP', 75000.00),
('Sharma Brothers Mart',   '9812345678', 'sharma@gmail.com',    '45, Civil Lines, Agra',         '09AAHCS8586R1ZT', 100000.00),
('Patel Supermarket',      '9701234567', 'patel@gmail.com',     '78, Station Road, Surat',       '24AACCP9801R1ZA', 60000.00),
('City Retail Hub',        '9988776655', 'cityretail@gmail.com','33, Park Street, Kolkata',      '19AABCC1234R1ZB', 150000.00),
('Gupta Wholesale Depot',  '9654321098', 'gupta@gmail.com',     '55, Nehru Nagar, Kanpur',       '09AAECG2345R1ZC', 200000.00),
('Singh Grocery House',    '9543210987', 'singh@gmail.com',     '21, Model Town, Ludhiana',      '03AAEDS3456R1ZD', 80000.00),
('Metro Traders',          '9432109876', 'metro@gmail.com',     '67, Connaught Place, New Delhi','07AABCM4567R1ZE', 120000.00);

-- ============================================================
-- INSERT: Bills (Sample invoices)
-- ============================================================
INSERT INTO bills (customer_id, bill_date, total_amount, discount_pct, tax_pct, final_amount, payment_status, payment_mode) VALUES
(1, '2024-05-10', 10500.00, 5.00, 18.00, 11799.00, 'Paid',    'Cash'),
(2, '2024-05-12', 25000.00, 8.00, 18.00, 27260.00, 'Paid',    'Online'),
(3, '2024-05-15',  8000.00, 0.00, 18.00,  9440.00, 'Unpaid',  'Credit'),
(4, '2024-05-18', 45000.00, 10.0, 18.00, 47628.00, 'Partial', 'Credit'),
(5, '2024-05-20', 18000.00, 5.00, 18.00, 20214.00, 'Paid',    'Online'),
(1, '2024-05-22', 12000.00, 0.00, 18.00, 14160.00, 'Unpaid',  'Credit');

-- ============================================================
-- INSERT: Bill Items (line items for each bill)
-- ============================================================
INSERT INTO bill_items (bill_id, product_id, quantity, unit_price, subtotal) VALUES
-- Bill 1: Ramesh General Store
(1, 1,  3, 1800.00, 5400.00),   -- 3 bags Basmati Rice
(1, 3,  2, 2200.00, 4400.00),   -- 2 bags Sugar
(1, 7,  3,  250.00,  750.00),   -- 3 USB Chargers (rounded for demo)

-- Bill 2: Sharma Brothers Mart
(2, 4,  5, 1650.00, 8250.00),   -- 5 tins Refined Oil
(2, 2,  8,  450.00, 3600.00),   -- 8 bags Wheat Flour
(2, 11, 10,  480.00, 4800.00),  -- 10 cases Coca-Cola
(2, 18, 12,  450.00, 5400.00),  -- 12 bags Detergent
(2, 17, 8,   350.00, 2800.00),  -- 8 packs Notebook

-- Bill 3: Patel Supermarket
(3, 6,  40, 85.00,  3400.00),   -- 40 LED Bulbs
(3, 9, 50,  90.00,  4500.00),   -- 50 packs AA Battery

-- Bill 4: City Retail Hub
(4, 1, 10, 1800.00, 18000.00),  -- 10 bags Basmati Rice
(4, 4,  8, 1650.00, 13200.00),  -- 8 tins Refined Oil
(4, 5, 15,  700.00, 10500.00),  -- 15 packets Toor Dal
(4, 12, 15, 180.00,  2700.00),  -- 15 cases Mineral Water

-- Bill 5: Gupta Wholesale Depot
(5, 2, 20,  450.00, 9000.00),   -- 20 bags Wheat Flour
(5, 3,  4, 2200.00, 8800.00),   -- 4 bags Sugar

-- Bill 6: Ramesh General Store (second bill)
(6, 15, 20, 320.00, 6400.00),   -- 20 reams A4 Paper
(6, 16, 30,  90.00, 2700.00),   -- 30 boxes Ball Pen
(6, 19, 8,  380.00, 3040.00);   -- 8 cans Floor Cleaner

-- ============================================================
-- INSERT: Inventory Log (stock history)
-- ============================================================
INSERT INTO inventory_log (product_id, change_type, quantity, remarks) VALUES
(1, 'Purchase',    100, 'Initial stock purchase from supplier'),
(2, 'Purchase',    150, 'Initial stock purchase from supplier'),
(3, 'Purchase',     80, 'Initial stock purchase from supplier'),
(4, 'Purchase',    100, 'Initial stock purchase from supplier'),
(5, 'Purchase',    150, 'Initial stock purchase from supplier'),
(6, 'Purchase',    300, 'Initial stock purchase'),
(7, 'Purchase',    200, 'Initial stock purchase'),
(1, 'Sale',        -13, 'Sold via Bill #1 and #4'),
(3, 'Sale',         -6, 'Sold via Bill #1 and #4'),
(4, 'Sale',        -13, 'Sold via Bill #2 and #4'),
(6, 'Sale',        -40, 'Sold via Bill #3'),
(2, 'Adjustment',  -20, 'Stock correction after physical count'),
(1, 'Return',        5, 'Customer return - damaged packaging');

-- ============================================================
-- END OF SAMPLE DATA
-- ============================================================
