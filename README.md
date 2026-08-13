# End-to-End E-Commerce Customer Journey & Sales Analytics

This repository contains a comprehensive SQL project demonstrating an end-to-end analytics pipeline for an e-commerce platform. It is designed to showcase advanced SQL skills relevant to Data Analysts, BI Analysts, Data Quality Analysts, and Data Scientists.

## The Dataset
This project assumes a schema similar to the **Olist Brazilian E-Commerce Dataset** (available on Kaggle), which includes the following core tables:
* `customers` (customer_id, customer_unique_id, customer_city, customer_state)
* `orders` (order_id, customer_id, order_status, order_purchase_timestamp, order_delivered_customer_date)
* `order_items` (order_id, order_item_id, product_id, seller_id, price, freight_value)
* `products` (product_id, product_category_name)
* `order_reviews` (review_id, order_id, review_score, review_creation_date)

## Project Structure

* **`01_data_cleansing.sql`**: Data Quality & Validation
  * Identifies and handles NULL values, standardizes text fields, and finds duplicate records.
* **`02_kpi_dashboards.sql`**: Business Intelligence & Aggregations
  * Backend queries to power BI dashboards. Calculates Month-over-Month (MoM) revenue, top product categories, and delivery time metrics.
* **`03_cohort_analysis.sql`**: Advanced Data Analytics
  * Utilizes CTEs and Window Functions to segment customers by their first purchase month and track their retention rates over subsequent months.
* **`04_feature_engineering.sql`**: Data Science & Predictive Analytics Prep
  * Extracts behavioral features (Lifetime Value, Average Order Value, Days Since Last Purchase) into a unified feature matrix for Machine Learning models (e.g., predicting customer churn).

## Key SQL Skills Demonstrated
* **Window Functions:** `LAG()`, `LEAD()`, `ROW_NUMBER()`, `MIN() OVER()`
* **CTEs (Common Table Expressions):** Modularizing complex logic for readability and performance.
* **Advanced Aggregations & Grouping:** Grouping by truncated dates, calculating moving averages.
* **Data Cleansing:** `COALESCE()`, `TRIM()`, `LOWER()`, `CASE WHEN`.
* **Multi-Table JOINs:** Connecting disparate data sources into cohesive views.
