-- SQLite
SELECT name
FROM sqlite_master
WHERE type = 'view'
  AND name = 'vw_clean_customers';

SELECT *
FROM vw_clean_orders
LIMIT 10;

SELECT
    data_quality_flag,
    COUNT(*) AS order_count
FROM vw_clean_orders
GROUP BY data_quality_flag;

SELECT
    COUNT(*) AS total_orders,
    SUM(CASE WHEN ShippingDate IS NULL THEN 1 ELSE 0 END)
        AS missing_shipping_dates
FROM Orders;

SELECT
    ProductID,
    COUNT(*) AS entry_count
FROM Products
GROUP BY ProductID
HAVING COUNT(*) > 1;

SELECT
    ProductID,
    COUNT(*) AS entry_count
FROM Products
GROUP BY ProductID
HAVING COUNT(*) > 1;

SELECT *
FROM vw_clean_products
LIMIT 10;

SELECT
    DeliveryStatus,
    COUNT(*) AS order_count
FROM Orders
GROUP BY DeliveryStatus
ORDER BY order_count DESC;

WITH CustomerFirstMonth AS (
    SELECT
        CustomerID,
        strftime('%Y-%m', MIN(OrderDate)) AS cohort_month
    FROM Orders
    WHERE OrderDate IS NOT NULL
    GROUP BY CustomerID
)
SELECT
    cohort_month,
    COUNT(*) AS initial_cohort_size
FROM CustomerFirstMonth
GROUP BY cohort_month
ORDER BY cohort_month;

SELECT *
FROM vw_customer_feature_matrix
LIMIT 10;

SELECT COUNT(*) AS customer_count
FROM vw_customer_feature_matrix;

SELECT *
FROM vw_customer_feature_matrix
LIMIT 10;

SELECT COUNT(*) AS total_customers
FROM vw_customer_feature_matrix;

SELECT
    SUM(CASE WHEN CustomerID IS NULL THEN 1 ELSE 0 END) AS missing_customer_ids,
    SUM(CASE WHEN total_orders_freq IS NULL THEN 1 ELSE 0 END) AS missing_order_counts,
    SUM(CASE WHEN lifetime_value_monetary IS NULL THEN 1 ELSE 0 END) AS missing_lifetime_values,
    SUM(CASE WHEN days_since_last_purchase IS NULL THEN 1 ELSE 0 END) AS missing_recency_values
FROM vw_customer_feature_matrix;

SELECT
    is_churned,
    COUNT(*) AS customer_count
FROM vw_customer_feature_matrix
GROUP BY is_churned
ORDER BY is_churned;

SELECT
    MIN(OrderDate) AS first_order_date,
    MAX(OrderDate) AS latest_order_date,
    date('now') AS today
FROM Orders;

SELECT
    MIN(days_since_last_purchase) AS minimum_days,
    MAX(days_since_last_purchase) AS maximum_days,
    SUM(CASE WHEN days_since_last_purchase <= 90 THEN 1 ELSE 0 END)
        AS customers_within_90_days,
    SUM(CASE WHEN days_since_last_purchase > 90 THEN 1 ELSE 0 END)
        AS customers_over_90_days
FROM vw_customer_feature_matrix;

SELECT
    is_churned,
    COUNT(*) AS customer_count
FROM vw_customer_feature_matrix
GROUP BY is_churned
ORDER BY is_churned;

SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT CustomerID) AS unique_customers,
    MIN(total_orders_freq) AS minimum_orders,
    MAX(total_orders_freq) AS maximum_orders
FROM vw_customer_feature_matrix;

SELECT
    MIN(lifetime_value_monetary) AS min_lifetime_value,
    MAX(lifetime_value_monetary) AS max_lifetime_value,
    MIN(average_order_value) AS min_average_order_value,
    MAX(average_order_value) AS max_average_order_value,
    MIN(days_since_last_purchase) AS min_days_since_purchase,
    MAX(days_since_last_purchase) AS max_days_since_purchase
FROM vw_customer_feature_matrix;

SELECT name
FROM sqlite_master
WHERE type = 'view'
ORDER BY name;

SELECT *
FROM vw_monthly_sales
ORDER BY order_month;

SELECT
    strftime('%Y-%m', OrderDate) AS order_month,
    COUNT(*) AS total_orders,
    DeliveryStatus,
    COUNT(*) AS status_count
FROM Orders
GROUP BY
    strftime('%Y-%m', OrderDate),
    DeliveryStatus
ORDER BY order_month, DeliveryStatus;

SELECT
    MIN(OrderDate) AS first_order,
    MAX(OrderDate) AS last_order,
    COUNT(*) AS total_orders
FROM Orders;

SELECT
    strftime('%Y-%m', OrderDate) AS order_month,
    COUNT(*) AS total_orders,
    SUM(CASE WHEN DeliveryStatus = 'Delivered' THEN 1 ELSE 0 END)
        AS delivered,
    SUM(CASE WHEN DeliveryStatus = 'Delivered Late' THEN 1 ELSE 0 END)
        AS delivered_late,
    SUM(CASE WHEN DeliveryStatus = 'Cancelled' THEN 1 ELSE 0 END)
        AS cancelled,
    SUM(CASE WHEN DeliveryStatus = 'Returned' THEN 1 ELSE 0 END)
        AS returned
FROM Orders
GROUP BY strftime('%Y-%m', OrderDate)
ORDER BY order_month;

SELECT
    strftime('%Y-%m', OrderDate) AS order_month,
    COUNT(*) AS total_orders,
    SUM(
        CASE WHEN DeliveryStatus = 'Cancelled'
        THEN 1 ELSE 0 END
    ) AS cancelled_orders,
    ROUND(
        SUM(
            CASE WHEN DeliveryStatus = 'Cancelled'
            THEN 1.0 ELSE 0 END
        ) * 100.0 / COUNT(*),
        2
    ) AS cancellation_rate_pct
FROM Orders
GROUP BY strftime('%Y-%m', OrderDate)
ORDER BY order_month;

SELECT
    c.Region,
    COUNT(o.OrderID) AS total_orders,
    SUM(
        CASE
            WHEN o.DeliveryStatus = 'Cancelled' THEN 1
            ELSE 0
        END
    ) AS cancelled_orders,
    ROUND(
        SUM(
            CASE
                WHEN o.DeliveryStatus = 'Cancelled' THEN 1.0
                ELSE 0
            END
        ) * 100.0 / COUNT(o.OrderID),
        2
    ) AS cancellation_rate_pct
FROM Orders AS o
JOIN Customers AS c
    ON o.CustomerID = c.CustomerID
WHERE o.OrderDate >= '2024-09-01'
GROUP BY c.Region
ORDER BY cancellation_rate_pct DESC;

SELECT
    c.CustomerSegment,
    COUNT(o.OrderID) AS total_orders,
    SUM(
        CASE
            WHEN o.DeliveryStatus = 'Cancelled' THEN 1
            ELSE 0
        END
    ) AS cancelled_orders,
    ROUND(
        SUM(
            CASE
                WHEN o.DeliveryStatus = 'Cancelled' THEN 1.0
                ELSE 0
            END
        ) * 100.0 / COUNT(o.OrderID),
        2
    ) AS cancellation_rate_pct
FROM Orders AS o
JOIN Customers AS c
    ON o.CustomerID = c.CustomerID
WHERE o.OrderDate >= '2024-09-01'
GROUP BY c.CustomerSegment
ORDER BY cancellation_rate_pct DESC;

SELECT
    c.AcquisitionChannel,
    COUNT(o.OrderID) AS total_orders,
    SUM(
        CASE
            WHEN o.DeliveryStatus = 'Cancelled' THEN 1
            ELSE 0
        END
    ) AS cancelled_orders,
    ROUND(
        SUM(
            CASE
                WHEN o.DeliveryStatus = 'Cancelled' THEN 1.0
                ELSE 0
            END
        ) * 100.0 / COUNT(o.OrderID),
        2
    ) AS cancellation_rate_pct
FROM Orders AS o
JOIN Customers AS c
    ON o.CustomerID = c.CustomerID
WHERE o.OrderDate >= '2024-09-01'
GROUP BY c.AcquisitionChannel
ORDER BY cancellation_rate_pct DESC;


SELECT *
FROM vw_order_detail_quality;