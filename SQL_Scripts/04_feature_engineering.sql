
DROP VIEW IF EXISTS vw_customer_feature_matrix;

CREATE VIEW vw_customer_feature_matrix AS

WITH CustomerOrderFeatures AS (
    SELECT
        CustomerID,
        COUNT(DISTINCT OrderID) AS total_orders_freq,
        SUM(TotalAmount) AS lifetime_value_monetary,
        AVG(TotalAmount) AS average_order_value,
        MAX(OrderDate) AS last_purchase_date
    FROM Orders
    WHERE OrderDate IS NOT NULL
      AND DeliveryStatus NOT IN ('Cancelled', 'Returned')
    GROUP BY CustomerID
),

CustomerProductFeatures AS (
    SELECT
        o.CustomerID,
        COUNT(DISTINCT od.ProductID) AS unique_products_bought
    FROM Orders AS o
    JOIN OrderDetails AS od
        ON o.OrderID = od.OrderID
    WHERE o.DeliveryStatus NOT IN ('Cancelled', 'Returned')
    GROUP BY o.CustomerID
)

SELECT
    cof.CustomerID,
    cof.total_orders_freq,
    ROUND(cof.lifetime_value_monetary, 2)
        AS lifetime_value_monetary,
    ROUND(cof.average_order_value, 2)
        AS average_order_value,
    COALESCE(cpf.unique_products_bought, 0)
        AS unique_products_bought,
    CAST(
    julianday((SELECT MAX(OrderDate) FROM Orders))
    - julianday(cof.last_purchase_date)
    AS INTEGER
) AS days_since_last_purchase,

CASE
    WHEN julianday((SELECT MAX(OrderDate) FROM Orders))
         - julianday(cof.last_purchase_date) > 90
    THEN 1
    ELSE 0
END AS is_churned
FROM CustomerOrderFeatures AS cof
LEFT JOIN CustomerProductFeatures AS cpf
    ON cof.CustomerID = cpf.CustomerID;
