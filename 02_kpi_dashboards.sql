-- =========================================================================================
-- PHASE 2: KPI DASHBOARDS & AGGREGATIONS
-- Target Role: Business Intelligence (BI) Analyst
-- Purpose: Backend queries to power BI dashboards (Power BI / Tableau).
-- =========================================================================================

-- 2.1: Monthly Revenue & Month-over-Month (MoM) Growth
-- Calculates total revenue per month and the percentage growth compared to the previous month
WITH MonthlyRevenue AS (
    SELECT 
        DATE_TRUNC('month', o.order_purchase_timestamp) AS order_month,
        SUM(oi.price + oi.freight_value) AS total_revenue,
        COUNT(DISTINCT o.order_id) AS total_orders
    FROM vw_clean_orders o
    JOIN order_items oi ON o.order_id = oi.order_id
    WHERE o.order_status = 'delivered'
    GROUP BY DATE_TRUNC('month', o.order_purchase_timestamp)
)
SELECT 
    order_month,
    total_revenue,
    total_orders,
    -- Window Function to get the previous month's revenue
    LAG(total_revenue) OVER (ORDER BY order_month) AS prev_month_revenue,
    -- Calculate MoM Growth Percentage
    ROUND(
        (total_revenue - LAG(total_revenue) OVER (ORDER BY order_month)) / 
        NULLIF(LAG(total_revenue) OVER (ORDER BY order_month), 0) * 100, 
    2) AS mom_growth_pct
FROM MonthlyRevenue
ORDER BY order_month;


-- 2.2: Top Selling Product Categories by Revenue
-- Identifying the most valuable product categories
SELECT 
    p.product_category_clean,
    COUNT(oi.order_item_id) AS items_sold,
    SUM(oi.price) AS total_product_revenue
FROM order_items oi
JOIN vw_clean_products p ON oi.product_id = p.product_id
JOIN vw_clean_orders o ON oi.order_id = o.order_id
WHERE o.order_status = 'delivered'
GROUP BY p.product_category_clean
ORDER BY total_product_revenue DESC
LIMIT 10;


-- 2.3: Average Delivery Time by State
-- Assessing supply chain and logistics performance
SELECT 
    c.customer_state_clean,
    AVG(EXTRACT(DAY FROM (o.resolved_delivery_date - o.order_purchase_timestamp))) AS avg_delivery_days,
    COUNT(o.order_id) AS total_deliveries
FROM vw_clean_orders o
JOIN vw_clean_customers c ON o.customer_id = c.customer_id
WHERE o.order_status = 'delivered'
GROUP BY c.customer_state_clean
ORDER BY avg_delivery_days ASC;
