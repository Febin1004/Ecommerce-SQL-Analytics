-- =========================================================================================
-- PHASE 2: KPI DASHBOARDS & AGGREGATIONS
-- Target Role: Business Intelligence (BI) Analyst
-- Purpose: Backend queries to power BI dashboards (Power BI / Tableau).
-- =========================================================================================

-- 2.1: Monthly Delivered-Order Revenue and MoM Growth

WITH MonthlyRevenue AS (
    SELECT
        strftime('%Y-%m', OrderDate) AS order_month,
        SUM(TotalAmount) AS total_revenue,
        COUNT(DISTINCT OrderID) AS total_orders
    FROM Orders
    WHERE DeliveryStatus = 'Delivered'
    GROUP BY strftime('%Y-%m', OrderDate)
),
MonthlyGrowth AS (
    SELECT
        order_month,
        total_revenue,
        total_orders,
        LAG(total_revenue) OVER (
            ORDER BY order_month
        ) AS prev_month_revenue
    FROM MonthlyRevenue
)
SELECT
    order_month,
    total_revenue,
    total_orders,
    prev_month_revenue,
    ROUND(
        (total_revenue - prev_month_revenue) * 100.0
        / NULLIF(prev_month_revenue, 0),
        2
    ) AS mom_growth_pct
FROM MonthlyGrowth
ORDER BY order_month;


-- 2.2: Top Product Categories by Estimated Revenue

SELECT
    p.Category AS product_category,
    SUM(od.Quantity) AS items_sold,
    ROUND(SUM(od.Quantity * p.Price), 2) AS estimated_product_revenue
FROM OrderDetails AS od
JOIN Products AS p
    ON od.ProductID = p.ProductID
JOIN Orders AS o
    ON od.OrderID = o.OrderID
GROUP BY p.Category
ORDER BY estimated_product_revenue DESC
LIMIT 10;

-- 2.3: Average Order-to-Shipping Time by Region

SELECT
    c.Region AS customer_region,
    ROUND(
        AVG(julianday(o.ShippingDate) - julianday(o.OrderDate)),
        2
    ) AS avg_order_to_shipping_days,
    COUNT(o.OrderID) AS total_orders
FROM Orders AS o
JOIN Customers AS c
    ON o.CustomerID = c.CustomerID
WHERE o.ShippingDate IS NOT NULL
  AND o.OrderDate IS NOT NULL
GROUP BY c.Region
ORDER BY avg_order_to_shipping_days ASC;


DROP VIEW IF EXISTS vw_monthly_sales;

CREATE VIEW vw_monthly_sales AS
SELECT
    strftime('%Y-%m', OrderDate) AS order_month,
    COUNT(DISTINCT OrderID) AS total_orders,
    ROUND(SUM(TotalAmount), 2) AS total_revenue,
    ROUND(AVG(TotalAmount), 2) AS average_order_value
FROM Orders
WHERE OrderDate IS NOT NULL
  AND DeliveryStatus NOT IN ('Cancelled', 'Returned')
GROUP BY strftime('%Y-%m', OrderDate)
ORDER BY order_month;