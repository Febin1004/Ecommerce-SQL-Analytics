DROP VIEW IF EXISTS vw_order_detail_quality;

CREATE VIEW vw_order_detail_quality AS

SELECT
    o.DeliveryStatus,
    COUNT(DISTINCT o.OrderID) AS total_orders,

    COUNT(DISTINCT od.OrderID) AS orders_with_details,

    COUNT(DISTINCT CASE
        WHEN od.OrderID IS NULL THEN o.OrderID
    END) AS orders_without_details,

    ROUND(
        100.0 *
        COUNT(DISTINCT CASE
            WHEN od.OrderID IS NULL THEN o.OrderID
        END) /
        COUNT(DISTINCT o.OrderID),
        2
    ) AS missing_detail_percentage

FROM Orders o

LEFT JOIN (
    SELECT DISTINCT OrderID
    FROM OrderDetails
) od
    ON o.OrderID = od.OrderID

GROUP BY o.DeliveryStatus;