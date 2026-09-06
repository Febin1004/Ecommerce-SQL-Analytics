-- =========================================================================================
-- PHASE 1: DATA CLEANSING & VALIDATION
-- Purpose: Standardize raw data, handle NULLs, and ensure data integrity before analysis.
-- =========================================================================================

-- 1.1: Standardize Customer Data & Handle NULLs
-- Creating a clean view of the customers table
CREATE OR REPLACE VIEW vw_clean_customers AS
SELECT 
    customer_id,
    customer_unique_id,
    -- Standardize city names (lowercase and trim whitespace)
    TRIM(LOWER(customer_city)) AS customer_city_clean,
    -- Ensure state codes are uppercase
    UPPER(customer_state) AS customer_state_clean
FROM customers
WHERE customer_id IS NOT NULL 
  AND customer_unique_id IS NOT NULL;


-- 1.2: Validate Orders and Handle Missing Delivery Dates
-- Flags orders that are 'delivered' but missing a delivery date
CREATE OR REPLACE VIEW vw_clean_orders AS
SELECT 
    order_id,
    customer_id,
    order_status,
    order_purchase_timestamp,
    -- Use COALESCE to set a default for missing delivery dates on delivered items
    COALESCE(order_delivered_customer_date, order_estimated_delivery_date) AS resolved_delivery_date,
    -- Flag data anomalies
    CASE 
        WHEN order_status = 'delivered' AND order_delivered_customer_date IS NULL THEN 'Anomaly: Missing Delivery Date'
        ELSE 'Valid'
    END AS data_quality_flag
FROM orders;


-- 1.3: Identify Duplicate Product Entries (Data Quality Check)
-- Query to find if any products were mistakenly entered multiple times
SELECT 
    product_id,
    COUNT(*) AS entry_count
FROM products
GROUP BY product_id
HAVING COUNT(*) > 1;


-- 1.4: Standardize Product Categories
-- Grouping similar categories and handling missing category names
CREATE OR REPLACE VIEW vw_clean_products AS
SELECT 
    product_id,
    CASE 
        WHEN product_category_name IS NULL THEN 'unknown_category'
        WHEN product_category_name LIKE '%appliances%' THEN 'home_appliances'
        WHEN product_category_name LIKE '%electronics%' THEN 'electronics'
        ELSE TRIM(LOWER(product_category_name)) 
    END AS product_category_clean
FROM products;
