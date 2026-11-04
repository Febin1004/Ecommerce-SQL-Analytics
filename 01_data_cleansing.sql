-- =========================================================================================
-- PHASE 1: DATA CLEANSING & VALIDATION
-- Target Role: Data Quality Analyst / Data Engineer
-- Purpose: Standardize raw data, handle NULLs, and ensure data integrity before analysis.
-- =========================================================================================

-- 1.1: Standardize Customer Data & Handle NULLs
DROP VIEW IF EXISTS vw_clean_customers;

CREATE VIEW vw_clean_customers AS
SELECT
    CustomerID,
    CustomerSegment,
    UPPER(TRIM(Region)) AS Region_Clean,
    AcquisitionChannel
FROM Customers
WHERE CustomerID IS NOT NULL;


-- 1.2: Validate Orders and Handle Missing Shipping Dates
DROP VIEW IF EXISTS vw_clean_orders;

CREATE VIEW vw_clean_orders AS
SELECT
    OrderID,
    CustomerID,
    OrderDate,
    ShippingDate,
    DeliveryStatus,
    TotalAmount,
    CASE
        WHEN ShippingDate IS NULL THEN 'Missing Shipping Date'
        ELSE 'Valid'
    END AS data_quality_flag
FROM Orders;

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
-- 1.4: Standardize Product Categories
DROP VIEW IF EXISTS vw_clean_products;

CREATE VIEW vw_clean_products AS
SELECT
    ProductID,
    CASE
        WHEN Category IS NULL OR TRIM(Category) = ''
            THEN 'unknown_category'
        ELSE LOWER(TRIM(Category))
    END AS Category_Clean,
    SubCategory,
    Price
FROM Products;
