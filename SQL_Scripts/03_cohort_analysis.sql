-- =========================================================================================
-- PHASE 3: COHORT & RETENTION ANALYSIS
-- Database: SQLite
-- Purpose: Group customers by first-order month and track monthly activity.
-- =========================================================================================

WITH CustomerCohorts AS (
    -- Step 1: Find each customer's first order month
    SELECT
        CustomerID,
        strftime('%Y-%m', MIN(OrderDate)) AS cohort_month
    FROM Orders
    GROUP BY CustomerID
),

OrderActivity AS (
    -- Step 2: Map each order to its customer's cohort
    SELECT
        o.OrderID,
        o.CustomerID,
        strftime('%Y-%m', o.OrderDate) AS order_month,
        cc.cohort_month,
        (
            CAST(strftime('%Y', o.OrderDate) AS INTEGER)
            - CAST(substr(cc.cohort_month, 1, 4) AS INTEGER)
        ) * 12
        +
        (
            CAST(strftime('%m', o.OrderDate) AS INTEGER)
            - CAST(substr(cc.cohort_month, 6, 2) AS INTEGER)
        ) AS month_index
    FROM Orders AS o
    JOIN CustomerCohorts AS cc
        ON o.CustomerID = cc.CustomerID
    WHERE o.OrderDate IS NOT NULL
),

CohortSize AS (
    -- Step 3: Count distinct active customers per cohort and month
    SELECT
        cohort_month,
        month_index,
        COUNT(DISTINCT CustomerID) AS active_customers
    FROM OrderActivity
    GROUP BY cohort_month, month_index
),

Retention AS (
    -- Step 4: Get each cohort's initial size
    SELECT
        cohort_month,
        month_index,
        active_customers,
        MAX(
            CASE
                WHEN month_index = 0 THEN active_customers
            END
        ) OVER (
            PARTITION BY cohort_month
        ) AS initial_cohort_size
    FROM CohortSize
)

-- Step 5: Calculate retention percentages
SELECT
    cohort_month,
    month_index,
    initial_cohort_size,
    active_customers,
    ROUND(
        active_customers * 100.0
        / NULLIF(initial_cohort_size, 0),
        2
    ) AS retention_rate_pct
FROM Retention
ORDER BY cohort_month, month_index;
