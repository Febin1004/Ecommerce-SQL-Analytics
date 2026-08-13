-- =========================================================================================
-- PHASE 4: FEATURE ENGINEERING FOR MACHINE LEARNING
-- Target Role: Data Scientist / Risk Analyst
-- Purpose: Extract behavioral features for predictive modeling (e.g., predicting churn or LTV).
-- =========================================================================================

-- Create a wide Feature Matrix at the Customer level
CREATE OR REPLACE VIEW vw_customer_feature_matrix AS
WITH CustomerAggregations AS (
    SELECT 
        c.customer_unique_id,
        
        -- RFM Features (Recency, Frequency, Monetary)
        COUNT(DISTINCT o.order_id) AS total_orders_freq,
        SUM(oi.price) AS lifetime_value_monetary,
        MAX(o.order_purchase_timestamp) AS last_purchase_date,
        
        -- Behavioral Features
        AVG(oi.price) AS average_order_value,
        COUNT(DISTINCT oi.product_id) AS unique_products_bought,
        
        -- Experience / Risk Features
        AVG(r.review_score) AS average_review_score,
        SUM(CASE WHEN r.review_score <= 2 THEN 1 ELSE 0 END) AS count_bad_reviews
        
    FROM vw_clean_customers c
    JOIN vw_clean_orders o ON c.customer_id = o.customer_id
    LEFT JOIN order_items oi ON o.order_id = oi.order_id
    LEFT JOIN order_reviews r ON o.order_id = r.order_id
    WHERE o.order_status != 'canceled'
    GROUP BY c.customer_unique_id
)

SELECT 
    customer_unique_id,
    total_orders_freq,
    lifetime_value_monetary,
    average_order_value,
    unique_products_bought,
    average_review_score,
    count_bad_reviews,
    
    -- Calculate Recency (Days since last purchase compared to an analysis date)
    -- Assuming analysis date is '2018-12-31' for this dataset
    EXTRACT(DAY FROM ('2018-12-31'::timestamp - last_purchase_date)) AS days_since_last_purchase,
    
    -- Target Variable Creation (e.g., Churn Definition: Hasn't purchased in > 90 days)
    CASE 
        WHEN EXTRACT(DAY FROM ('2018-12-31'::timestamp - last_purchase_date)) > 90 THEN 1 
        ELSE 0 
    END AS is_churned

FROM CustomerAggregations;

-- This resulting view can be exported directly into a pandas dataframe
-- for training an XGBoost or Random Forest model.
