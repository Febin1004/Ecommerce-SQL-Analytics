-- =========================================================================================
-- PHASE 3: COHORT & RETENTION ANALYSIS
-- Target Role: Data Analyst
-- Purpose: Segment customers based on acquisition month and track retention over time.
-- =========================================================================================

-- Step 1: Find the first purchase month for every unique customer (Cohort Group)
WITH CustomerCohorts AS (
    SELECT 
        c.customer_unique_id,
        DATE_TRUNC('month', MIN(o.order_purchase_timestamp)) AS cohort_month
    FROM vw_clean_customers c
    JOIN vw_clean_orders o ON c.customer_id = o.customer_id
    GROUP BY c.customer_unique_id
),

-- Step 2: Map all purchases to their respective cohort group and calculate the month index
OrderActivity AS (
    SELECT 
        o.order_id,
        c.customer_unique_id,
        DATE_TRUNC('month', o.order_purchase_timestamp) AS order_month,
        cc.cohort_month,
        -- Calculate the number of months between the cohort month and the order month
        EXTRACT(YEAR FROM AGE(DATE_TRUNC('month', o.order_purchase_timestamp), cc.cohort_month)) * 12 +
        EXTRACT(MONTH FROM AGE(DATE_TRUNC('month', o.order_purchase_timestamp), cc.cohort_month)) AS month_index
    FROM vw_clean_orders o
    JOIN vw_clean_customers c ON o.customer_id = o.customer_id
    JOIN CustomerCohorts cc ON c.customer_unique_id = cc.customer_unique_id
),

-- Step 3: Aggregate the number of unique customers active in each month_index per cohort
CohortSize AS (
    SELECT 
        cohort_month,
        month_index,
        COUNT(DISTINCT customer_unique_id) AS active_customers
    FROM OrderActivity
    GROUP BY cohort_month, month_index
)

-- Step 4: Pivot or display the retention numbers
SELECT 
    cs.cohort_month,
    -- The size of the cohort at Month 0 (the initial acquisition month)
    FIRST_VALUE(cs.active_customers) OVER (PARTITION BY cs.cohort_month ORDER BY cs.month_index) AS initial_cohort_size,
    cs.month_index,
    cs.active_customers,
    -- Calculate Retention Rate
    ROUND(
        cs.active_customers * 100.0 / 
        FIRST_VALUE(cs.active_customers) OVER (PARTITION BY cs.cohort_month ORDER BY cs.month_index), 
    2) AS retention_rate_pct
FROM CohortSize cs
ORDER BY cs.cohort_month, cs.month_index;
