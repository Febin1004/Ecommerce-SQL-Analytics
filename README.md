# E-Commerce Analytics Pipeline & Power BI Dashboard

An end-to-end e-commerce analytics project using **SQLite, SQL, Power BI, and DAX** to analyze sales performance, customer behavior, product performance, and order delivery outcomes.

The project investigates a significant increase in order cancellations observed during the final months of 2024 and demonstrates how SQL-based analysis and interactive dashboards can support business decision-making.

---

## Project Overview

This project transforms raw e-commerce transaction data into business insights through:

- Data cleansing and validation using SQL.
- Sales KPI analysis and monthly performance tracking.
- Customer cohort and purchasing behavior analysis.
- Customer feature engineering and churn classification.
- Product performance analysis.
- Order cancellation and delivery analysis.
- Interactive Power BI dashboards.

The analysis focuses on identifying changes in business performance, evaluating customer behavior, and understanding cancellation patterns across different business dimensions.

---

## Business Problem

The business experienced a significant change in order performance during 2024.

The objective was to:

- Analyze sales and order trends.
- Identify changes in cancellation rates.
- Evaluate customer purchasing behavior.
- Compare performance across regions, customer segments, and acquisition channels.
- Analyze product performance and customer lifetime value.
- Build interactive dashboards to support business decisions.

The project uses SQL analytical views and Power BI visualizations to investigate these business questions.

---

## Tech Stack

| Technology | Application |
|---|---|
| SQL | Data cleansing, joins, CTEs, aggregations, analytical views |
| SQLite | Relational database and SQL analysis |
| Power BI | Interactive dashboards, KPI cards, and data visualization |
| DAX | Measures and calculated metrics |
| Python | Supporting scripts and data generation |
| Git & GitHub | Version control and project documentation |

---

## Dataset

The project database contains the following tables:

| Table | Records |
|---|---:|
| Customers | 10,000 |
| Orders | 105,000 |
| OrderDetails | 150,000 |
| Products | 100 |
| **Total** | **265,100** |

The dataset covers **January 2023 through December 2024**.

### Database Tables

- **Customers:** Customer information, customer segment, region, and acquisition channel.
- **Orders:** Order dates, shipping dates, delivery status, customer information, and order amounts.
- **OrderDetails:** Order-level product information and quantities.
- **Products:** Product categories, subcategories, and prices.

The dataset contains multiple delivery statuses, including Delivered, Delivered Late, Cancelled, and Returned.

**Data consideration:** December 2024 contains partial-month data and should be interpreted carefully when comparing monthly performance.

---

## SQL Analysis

The project includes six SQL analysis areas.

### 1. Data Cleansing and Validation

File: `01_data_cleansing.sql`

- Customer data validation.
- Order data quality checks.
- Product data validation.
- Text standardization.
- Identification of missing or inconsistent values.
- Analytical data preparation.

### 2. Sales KPI Analysis

File: `02_kpi_dashboards.sql`

- Total orders.
- Revenue analysis.
- Average order value.
- Monthly sales trends.
- Order status analysis.
- Monthly performance comparisons.

### 3. Customer Cohort Analysis

File: `03_cohort_analysis.sql`

- Customer purchase activity.
- Cohort-based analysis.
- Customer retention patterns.
- Customer purchasing behavior over time.

### 4. Customer Feature Engineering

File: `04_feature_engineering.sql`

Customer-level analytical features include:

- Purchase frequency.
- Customer lifetime value.
- Average order value.
- Unique products purchased.
- Days since last purchase.
- Customer churn classification.

These features support customer segmentation and provide a foundation for future predictive analytics.

### 5. Product Performance Analysis

File: `05_product_performance.sql`

- Product revenue analysis.
- Product quantity analysis.
- Category performance.
- Subcategory performance.
- Product-level sales performance.

### 6. Data Quality Analysis

File: `06_data_quality.sql`

- Order detail validation.
- Duplicate checks.
- Data consistency checks.
- Analytical data quality flags.

Analytical SQL views were created to support reporting and Power BI analysis.

---

## Key SQL Skills Demonstrated

### Window Functions

- `LAG()` — Compare current-period metrics with previous-period values for month-over-month analysis.
- `LEAD()` — Access subsequent rows for period comparisons and trend analysis.
- `ROW_NUMBER()` — Assign row numbers for ranking and record identification.
- `MIN() OVER()` — Calculate minimum values across defined windows.

### Common Table Expressions (CTEs)

- Use `WITH` clauses to organize complex SQL queries into logical steps.
- Improve query readability and simplify multi-stage analytical transformations.
- Combine intermediate results for customer, sales, and product analysis.

### Advanced Aggregations and Grouping

- Calculate revenue, order volume, average order value, and cancellation rates.
- Group transaction data by month, region, customer segment, and acquisition channel.
- Apply aggregate functions such as `SUM()`, `COUNT()`, `AVG()`, `MIN()`, and `MAX()`.
- Analyze monthly performance and identify changes in business trends.

### Data Cleansing and Validation

- `COALESCE()` — Handle missing values.
- `TRIM()` — Remove unwanted whitespace.
- `LOWER()` and `UPPER()` — Standardize text values.
- `CASE WHEN` — Create conditional classifications and data quality flags.
- Identify duplicate records, missing values, and inconsistencies.

### Multi-Table JOINs

- Combine customer, order, order detail, and product data.
- Use `INNER JOIN` and `LEFT JOIN` to connect related datasets.
- Build analytical views for customer behavior, product performance, and order analysis.

### Business Analytics

- Analyze sales performance and monthly trends.
- Evaluate customer purchasing behavior and lifetime value.
- Investigate cancellation patterns across business dimensions.
- Prepare SQL analytical views for Power BI reporting.

---

## Power BI Dashboards

The project contains four interactive dashboard pages.

### 1. Sales Overview

Analyzes overall sales performance and order trends.

Key metrics:

- Total revenue.
- Total orders.
- Average order value.
- Monthly revenue trend.
- Monthly order volume.
- Revenue comparison across years.

![Sales Overview](03_Ecommerce_Analytics_Project/Dashboard_Previews/SALES%20OVERVIEW.png)

### 2. Product Performance Analytics

Evaluates product and category performance.

Key metrics:

- Revenue by product category.
- Quantity sold by category.
- Top-performing products.
- Revenue by product subcategory.
- Product-level sales performance.

![Product Performance Analytics](03_Ecommerce_Analytics_Project/Dashboard_Previews/PRODUCT%20PERFORMANCE%20ANALYTICS.png)

### 3. Customer Analytics

Analyzes customer purchasing behavior and customer value.

Key metrics:

- Total customers.
- Customer distribution by segment.
- Customer distribution by region.
- Customer lifetime value.
- Customer churn rate.
- Churned customer distribution.

![Customer Analytics](03_Ecommerce_Analytics_Project/Dashboard_Previews/CUSTOMER%20ANALYTICS.png)

### 4. Order & Delivery Analysis

Analyzes order fulfillment and cancellation patterns.

Key metrics:

- Orders by delivery status.
- Monthly cancellation trend.
- Cancellation rate by region.
- Cancellation rate by customer segment.
- Cancellation rate by acquisition channel.
- Order detail quality checks.

![Order & Delivery Analysis](03_Ecommerce_Analytics_Project/Dashboard_Previews/ORDER%20%26%20DELIVERY%20ANALYSIS.png)

---

## Key Business Findings

The analysis identified the following patterns:

- The overall cancellation rate across the dataset is approximately **16.73%**.
- A sharp increase in cancellations was observed beginning in September 2024.
- Cancellation rates reached approximately **62–63% during September–November 2024**.
- The increase was observed across regions, customer segments, and acquisition channels.
- The pattern was not isolated to one specific region or customer group.
- Further investigation is required to determine whether the change resulted from operational factors, business policy, or data-related issues.

### Business Interpretation

The cancellation increase represents a significant change in order performance.

The analysis identifies when the change occurred and evaluates how broadly it affected the business.

However, the available analysis does not establish the underlying cause. Additional operational information and data validation would be required to determine whether the increase reflects a genuine business event or a data-related issue.

---

## Customer Churn Definition

Customers were classified as churned when their last purchase was more than **90 days before the latest order date in the dataset**.

The churn calculation uses the latest available order date as the reference date rather than the current date.

This is a project-specific analytical assumption and should not be interpreted as a universal definition of customer churn.

---

## Repository Structure

```text
E-Commerce-Analytics-Pipeline/
│
├── 03_Ecommerce_Analytics_Project/
│   │
│   ├── Dashboard_Previews/
│   │   ├── CUSTOMER ANALYTICS.png
│   │   ├── ORDER & DELIVERY ANALYSIS.png
│   │   ├── PRODUCT PERFORMANCE ANALYTICS.png
│   │   └── SALES OVERVIEW.png
│   │
│   ├── Datasets/
│   │   └── ecommerce_data.db
│   │
│   ├── PowerBI_and_DAX/
│   │   ├── DAX_Measures.dax
│   │   ├── E-Commerce_Analytics.pbix
│   │   ├── PowerBI_Build_Guide.md
│   │   └── README.md
│   │
│   ├── SQL_Scripts/
│   │   ├── 01_data_cleansing.sql
│   │   ├── 02_kpi_dashboards.sql
│   │   ├── 03_cohort_analysis.sql
│   │   ├── 04_feature_engineering.sql
│   │   ├── 05_product_performance.sql
│   │   ├── 06_data_quality.sql
│   │   └── inspect_database.sql
│   │
│   └── README.md
│
└── README.md
```

---

## How to Use

### Prerequisites

- SQLite-compatible database software.
- Power BI Desktop.
- Git (optional, for cloning the repository).

### Step 1: Clone the Repository

```bash
git clone https://github.com/Febin1004/E-Commerce-Analytics-Pipeline.git
```

### Step 2: Navigate to the Project

Open the project folder:

```text
03_Ecommerce_Analytics_Project/
```

### Step 3: Access the Database

Open the SQLite database:

```text
Datasets/ecommerce_data.db
```

Use SQLite-compatible software to inspect the tables and execute SQL queries.

### Step 4: Execute SQL Scripts

Navigate to:

```text
SQL_Scripts/
```

Review and execute the SQL scripts against the project database.

The scripts cover data cleansing, KPI analysis, cohort analysis, customer feature engineering, product performance, and data quality validation.

### Step 5: Open the Power BI Dashboard

Open:

```text
PowerBI_and_DAX/E-Commerce_Analytics.pbix
```

in Power BI Desktop.

### Step 6: Configure and Refresh Data

If required:

1. Configure the database connection.
2. Verify the data source path.
3. Refresh the data.
4. Confirm that the dashboard visuals load correctly.

### Step 7: Explore the Dashboards

Navigate through the four dashboard pages:

- Sales Overview.
- Product Performance Analytics.
- Customer Analytics.
- Order & Delivery Analysis.

Use the interactive visuals to explore business performance and cancellation patterns.

---

## Limitations

- December 2024 contains partial-month data.
- The churn definition is based on a 90-day inactivity threshold.
- Cancellation trends identify a change in order behavior but do not prove its cause.
- Revenue measures should be interpreted according to the included order-status filters.
- The findings are based on the available dataset and may not represent all real-world e-commerce operations.
- Further validation is required before using the findings for operational decisions.

---

## Future Improvements

Potential extensions of this project include:

- Automated data refresh and reporting.
- Additional customer segmentation.
- Predictive customer churn modeling.
- Cancellation prediction.
- Enhanced data quality monitoring.
- Additional business performance KPIs.

---

## Author

**Febin T Nabeel**

GitHub Profile: [Febin1004](https://github.com/Febin1004)

Project Repository: [E-Commerce Analytics Pipeline](https://github.com/Febin1004/E-Commerce-Analytics-Pipeline)
