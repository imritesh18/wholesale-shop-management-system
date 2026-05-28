-- ============================================================
--  WHOLESALE SHOP MANAGEMENT SYSTEM - DATABASE SCHEMA
--  Author: [Your Name]
--  Description: MySQL schema for managing products, customers,
--               inventory and billing in a wholesale shop.
-- ============================================================

-- Step 1: Create and select the database
CREATE DATABASE IF NOT EXISTS wholesale_shop_db;
USE wholesale_shop_db;

-- ============================================================
-- TABLE 1: categories
-- Stores product categories (e.g., Electronics, Groceries)
-- ============================================================
CREATE TABLE IF NOT EXISTS categories (
    category_id   INT           AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(100)  NOT NULL,
    description   TEXT,
    created_at    TIMESTAMP     DEFAULT CURRENT_TIMESTAMP
);

-- ============================================================
-- TABLE 2: products
-- Stores all wholesale products with pricing and stock info
-- ============================================================
CREATE TABLE IF NOT EXISTS products (
    product_id    INT             AUTO_INCREMENT PRIMARY KEY,
    product_name  VARCHAR(150)    NOT NULL,
    category_id   INT             NOT NULL,
    unit_price    DECIMAL(10, 2)  NOT NULL,          -- Selling price per unit
    cost_price    DECIMAL(10, 2)  NOT NULL,          -- Purchase/cost price
    unit_type     VARCHAR(50)     DEFAULT 'piece',   -- e.g., kg, litre, piece, box
    stock_qty     INT             DEFAULT 0,         -- Current stock quantity
    reorder_level INT             DEFAULT 10,        -- Alert when stock falls below this
    created_at    TIMESTAMP       DEFAULT CURRENT_TIMESTAMP,
    updated_at    TIMESTAMP       DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    -- Foreign key: each product belongs to a category
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

-- ============================================================
-- TABLE 3: customers
-- Stores wholesale customer (retailer/dealer) information
-- ============================================================
CREATE TABLE IF NOT EXISTS customers (
    customer_id   INT          AUTO_INCREMENT PRIMARY KEY,
    customer_name VARCHAR(150) NOT NULL,
    phone         VARCHAR(15)  NOT NULL UNIQUE,
    email         VARCHAR(150),
    address       TEXT,
    gst_number    VARCHAR(20),                       -- GST number for business customers
    credit_limit  DECIMAL(10, 2) DEFAULT 50000.00,  -- Max credit allowed
    created_at    TIMESTAMP    DEFAULT CURRENT_TIMESTAMP
);

-- ============================================================
-- TABLE 4: bills
-- Stores bill/invoice header information
-- ============================================================
CREATE TABLE IF NOT EXISTS bills (
    bill_id         INT             AUTO_INCREMENT PRIMARY KEY,
    customer_id     INT             NOT NULL,
    bill_date       DATE            NOT NULL,
    total_amount    DECIMAL(12, 2)  NOT NULL DEFAULT 0.00,
    discount_pct    DECIMAL(5, 2)   DEFAULT 0.00,   -- Discount percentage (0-100)
    tax_pct         DECIMAL(5, 2)   DEFAULT 18.00,  -- GST/Tax percentage
    final_amount    DECIMAL(12, 2)  NOT NULL DEFAULT 0.00,
    payment_status  ENUM('Paid','Unpaid','Partial')  DEFAULT 'Unpaid',
    payment_mode    ENUM('Cash','Credit','Online')   DEFAULT 'Cash',
    notes           TEXT,
    created_at      TIMESTAMP       DEFAULT CURRENT_TIMESTAMP,

    -- Foreign key: each bill belongs to a customer
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- ============================================================
-- TABLE 5: bill_items
-- Stores individual line items for each bill (order details)
-- ============================================================
CREATE TABLE IF NOT EXISTS bill_items (
    item_id     INT             AUTO_INCREMENT PRIMARY KEY,
    bill_id     INT             NOT NULL,
    product_id  INT             NOT NULL,
    quantity    INT             NOT NULL,
    unit_price  DECIMAL(10, 2)  NOT NULL,  -- Price at time of billing (snapshot)
    subtotal    DECIMAL(12, 2)  NOT NULL,  -- quantity * unit_price

    -- Foreign keys
    FOREIGN KEY (bill_id)    REFERENCES bills(bill_id)    ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- ============================================================
-- TABLE 6: inventory_log
-- Tracks every stock movement (purchase/sale/adjustment)
-- ============================================================
CREATE TABLE IF NOT EXISTS inventory_log (
    log_id        INT          AUTO_INCREMENT PRIMARY KEY,
    product_id    INT          NOT NULL,
    change_type   ENUM('Purchase','Sale','Adjustment','Return') NOT NULL,
    quantity      INT          NOT NULL,   -- Positive = stock in, Negative = stock out
    remarks       VARCHAR(255),
    log_date      TIMESTAMP    DEFAULT CURRENT_TIMESTAMP,

    -- Foreign key
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- ============================================================
-- END OF SCHEMA
-- ============================================================
