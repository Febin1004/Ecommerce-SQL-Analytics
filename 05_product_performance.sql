DROP VIEW IF EXISTS vw_product_performance;

CREATE VIEW vw_product_performance AS

WITH ProductLines AS (
    SELECT
        o.OrderID,
        o.TotalAmount,
        od.ProductID,
        od.Quantity,
        p.Category,
        p.SubCategory,
        od.Quantity * p.Price AS line_value,

        SUM(od.Quantity * p.Price) OVER (
            PARTITION BY o.OrderID
        ) AS order_line_value

    FROM Orders o

    JOIN OrderDetails od
        ON o.OrderID = od.OrderID

    JOIN Products p
        ON od.ProductID = p.ProductID

    WHERE o.OrderDate IS NOT NULL
      AND o.DeliveryStatus NOT IN ('Cancelled', 'Returned')
),

AllocatedRevenue AS (
    SELECT
        OrderID,
        ProductID,
        Quantity,
        Category,
        SubCategory,

        CASE
            WHEN order_line_value > 0
            THEN TotalAmount * line_value / order_line_value
            ELSE 0
        END AS allocated_revenue

    FROM ProductLines
)

SELECT
    ProductID,
    Category,
    SubCategory,
    COUNT(DISTINCT OrderID) AS total_orders,
    SUM(Quantity) AS total_quantity_sold,
    ROUND(SUM(allocated_revenue), 2) AS total_revenue

FROM AllocatedRevenue

GROUP BY
    ProductID,
    Category,
    SubCategory;



