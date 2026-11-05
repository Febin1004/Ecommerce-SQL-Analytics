# E-Commerce Analytics Pipeline & Power BI Dashboard

An end-to-end e-commerce analytics project using **SQL, SQLite, and Power BI** to analyze sales performance, customer behavior, product performance, and order delivery outcomes.

The project transforms raw transactional data into business insights through SQL-based data cleansing, KPI analysis, customer segmentation, cohort analysis, feature engineering, and interactive Power BI dashboards.

---

## Project Overview

E-commerce businesses generate large volumes of transactional data. Analyzing this data helps organizations understand revenue trends, customer purchasing behavior, product performance, and order fulfillment outcomes.

This project builds an analytics pipeline using SQLite and SQL to prepare and analyze transaction data, followed by Power BI dashboards to visualize key business metrics.

The analysis also investigates a significant increase in order cancellations observed during the later months of 2024.

### Business Objectives

- Analyze monthly sales and revenue trends.
- Monitor key business performance indicators.
- Identify product categories and products contributing to sales.
- Understand customer purchasing behavior and retention.
- Perform customer cohort and churn analysis.
- Analyze order cancellations and delivery outcomes.
- Build interactive dashboards to support business decision-making.

---

## Tech Stack

| Technology | Purpose |
|---|---|
| SQL | Data cleansing, joins, aggregations, KPI calculations, and analytical queries |
| SQLite | Relational database used to store and query the project dataset |
| Power BI Desktop | Interactive dashboards and business intelligence reporting |
| DAX | Measures and calculations used in Power BI |
| Git & GitHub | Version control and project documentation |

### SQL Concepts Used

- Common Table Expressions (CTEs)
- Window functions
- `JOIN` operations
- Aggregations using `GROUP BY`
- Conditional logic using `CASE`
- Data cleansing and validation
- Customer-level feature engineering
- Monthly sales analysis
- Cohort analysis
- Data quality checks

---

## Dataset

The project uses an e-commerce transactional dataset stored in SQLite.

### Database

`ecommerce_data.db`

### Dataset Structure

| Table | Description | Records |
|---|---|---:|
| Customers | Customer information, segments, regions, and acquisition channels | 10,000 |
| Orders | Order dates, customer IDs, delivery status, and order amounts | 105,000 |
| OrderDetails | Order-level product and quantity information | 150,000 |
| Products | Product categories, subcategories, and prices | 100 |

The dataset contains **265,100 rows across the four tables**. This is the sum of table records, not the number of unique customers or orders.

### Data Period

January 2023 – December 2024

December 2024 contains partial monthly data and should be interpreted accordingly.

### Order Statuses

The dataset includes:

- Delivered
- Delivered Late
- Cancelled
- Returned

---

## Project Workflow

The project follows a structured analytics workflow:

1. Inspect the database and understand the available tables.
2. Clean and validate customer, order, and product data.
3. Build SQL views for analysis.
4. Calculate sales and business KPIs.
5. Perform cohort and customer behavior analysis.
6. Create customer-level analytical features.
7. Analyze product performance.
8. Perform data quality checks.
9. Connect the analytical data to Power BI.
10. Build interactive dashboards to communicate findings.

---

## SQL Analysis

SQL scripts are organized by analytical task.

### 1. Data Cleansing

Clean and prepare customer, order, and product data.

Key activities:

- Inspect table structures and data types.
- Identify missing or inconsistent values.
- Validate customer and product records.
- Prepare reusable analytical views.

### 2. KPI & Sales Analysis

Analyze business performance using SQL.

Key activities:

- Monthly sales analysis.
- Revenue aggregation.
- Order-level KPI calculations.
- Month-over-month comparisons.
- Revenue trend analysis.

Revenue analysis excludes **Cancelled** and **Returned** orders and includes **Delivered** and **Delivered Late** orders.

### 3. Cohort & Retention Analysis

Analyze customer purchasing behavior over time.

Key activities:

- Identify customer acquisition cohorts.
- Group customers by their first purchase month.
- Track customer activity across subsequent months.
- Analyze customer retention patterns.

### 4. Customer Feature Engineering

Create a customer-level feature matrix for analytical and predictive modeling preparation.

Features include:

- Total order frequency
- Customer lifetime value (LTV)
- Average order value (AOV)
- Number of unique products purchased
- Days since last purchase
- Churn indicator

**Churn definition:** A customer is classified as churned when their last eligible purchase occurred more than 90 days before the latest order date in the dataset.

This is a project-specific analytical definition, not a universal definition of customer churn.

### 5. Product Performance Analysis

Analyze product-level sales performance.

Key activities:

- Product sales aggregation.
- Category and subcategory analysis.
- Product performance comparison.
- Revenue contribution analysis.

### 6. Data Quality Checks

Validate the prepared analytical data.

Key activities:

- Check missing values.
- Inspect duplicate records.
- Validate relationships between tables.
- Check product and order references.
- Review date and status consistency.

---

## Power BI Dashboard

The project contains four dashboard pages designed to provide different views of business performance.

### 1. Sales Overview

Analyze overall business performance.

Key metrics and analysis:

- Revenue trends
- Monthly sales performance
- Order-level KPIs
- Month-over-month changes

### 2. Product Performance Analytics

Understand product and category performance.

Key analysis:

- Product sales
- Category and subcategory performance
- Revenue contribution
- Product comparisons

### 3. Customer Analytics

Analyze customer behavior and purchasing patterns.

Key analysis:

- Customer segmentation
- Customer purchasing activity
- Customer lifetime value
- Customer cohort and churn-related insights

### 4. Order & Delivery Analysis

Analyze order fulfillment and delivery outcomes.

Key analysis:

- Order status distribution
- Cancellation trends
- Delivery outcomes
- Monthly cancellation patterns

---



## Dashboard Previews

### Sales Overview
![Sales Overview](Dashboard_Previews/SALES%20OVERVIEW.png)

### Product Performance Analytics
![Product Performance Analytics](Dashboard_Previews/PRODUCT%20PERFORMANCE%20ANALYTICS.png)

### Customer Analytics
![Customer Analytics](Dashboard_Previews/CUSTOMER%20ANALYTICS.png)

### Order & Delivery Analysis
![Order & Delivery Analysis](Dashboard_Previews/ORDER%20%26%20DELIVERY%20ANALYSIS.png)


---

## Key Insights

### 1. Order Cancellation Rate

The analysis identified an overall cancellation rate of approximately **16.73%**.

This indicates that cancellations represent a significant portion of the recorded orders and should be monitored as a business KPI.

### 2. Cancellation Increase During 2024

A substantial increase in cancellations was observed during **September–November 2024**, with monthly cancellation rates reaching approximately **62–63%**.

December 2024 contains partial data, so it should not be directly compared with complete months without accounting for the data coverage.

### 3. Cancellation Patterns Across Customer Groups

The increase was observed across multiple geographic regions, customer segments, and acquisition channels.

This suggests that the pattern was not confined to a single region or customer group.

However, the available dataset does not establish the operational cause of the cancellation increase. Further investigation would be required to determine whether it was related to inventory, fulfillment, customer behavior, data quality, or another factor.

### 4. Customer Analytics

Customer-level features were created to support analysis of purchasing frequency, spending behavior, recency, and churn classification.

These features provide a foundation for further customer segmentation and predictive modeling.

---

## Repository Structure

```text

Ecommerce-SQL-Analytics/
│
├── 01_data_cleansing.sql
├── 02_kpi_dashboards.sql
├── 03_cohort_analysis.sql
├── 04_feature_engineering.sql
├── 05_product_performance.sql
├── 06_data_quality.sql
├── inspect_database.sql
├── README.md
│
├── CUSTOMER ANALYTICS.png
├── ORDER & DELIVERY ANALYSIS.png
├── PRODUCT PERFORMANCE ANALYTICS.png
├── SALES OVERVIEW.png
│
└── ecommerce_data.db

```

*Note: The structure above represents the project organization. Adjust filenames if they differ from the files currently present in your repository.*

---

## How to Run the Project

### Prerequisites

- SQLite-compatible database viewer or SQLite command-line tool
- Power BI Desktop
- Git (optional, for cloning the repository)

### 1. Clone the Repository

```bash
git clone https://github.com/Febin1004/Ecommerce-SQL-Analytics.git
```

Navigate to the project directory:

```bash
cd Ecommerce-SQL-Analytics
```

### 2. Open the SQLite Database

Locate the database:

```text
03_Ecommerce_Analytics_Project/Datasets/ecommerce_data.db
```

Open it using SQLite or a compatible database tool.

### 3. Run the SQL Scripts

Navigate to:

```text
Ecommerce-SQL-Analytics/
```

Run the scripts in the following order:

1. `inspect_database.sql` — inspect database tables and structure.
2. `01_data_cleansing.sql` — prepare and clean the data.
3. `02_kpi_dashboards.sql` — calculate sales and KPI metrics.
4. `03_cohort_analysis.sql` — analyze customer cohorts and retention.
5. `04_feature_engineering.sql` — create customer-level analytical features.
6. `05_product_performance.sql` — analyze product performance.
7. `06_data_quality.sql` — perform data quality checks.

The scripts create analytical views used for reporting and analysis.

### 4. Open the Power BI Dashboard

Open:

```text
Power BI dashboard: https://github.com/Febin1004/PowerBI-Ecommerce-Dashboard
```

If Power BI requests a data source, connect it to the SQLite database using the configured SQLite data source or driver.

Refresh the data and explore the four dashboard pages.

---

## Limitations

- The analysis is based on the available dataset and its recorded fields.
- December 2024 contains partial data.
- The cancellation spike is an observed pattern; its underlying cause has not been established.
- Customer churn is defined using a project-specific 90-day inactivity threshold relative to the latest dataset order date.
- Revenue calculations follow the project's order-status filters and should not be interpreted as audited financial revenue.
- Predictive modeling is not presented as a completed production deployment.

---

## Future Improvements

- Investigate cancellation drivers using additional operational data.
- Add inventory and fulfillment information for deeper logistics analysis.
- Extend customer segmentation and retention analysis.
- Develop and validate predictive models for customer churn.
- Add automated refresh and reporting workflows.
- Improve dashboard performance and documentation.

---

## Author

**Febin T. Nabeel**

- GitHub: [Febin1004](https://github.com/Febin1004)
- LinkedIn: [Febin T. Nabeel](https://www.linkedin.com/in/febin-t-nabeel-a50222274/)

---

## License

This project is intended for educational, portfolio, and analytical demonstration purposes.

Add a `LICENSE` file if you intend to distribute the repository under a specific open-source license.
