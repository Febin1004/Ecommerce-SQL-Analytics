# Power BI Build Guide

Since Power BI requires a manual drag-and-drop interface, follow these steps to construct the dashboard using the generated data and DAX code.

## Step 1: Generate the Data
1. Open a terminal in this folder and run `python generate_sample_data.py`.
2. This will create three files: `customers.csv`, `products.csv`, and `orders.csv`.

## Step 2: Load and Model the Data in Power BI
1. Open Power BI Desktop and click **Get Data -> Text/CSV**. Load all three CSV files.
2. Go to the **Model View** (the relationship icon on the left).
3. Connect the tables to create a **Star Schema**:
   * Drag `CustomerID` from `customers.csv` to `orders.csv`.
   * Drag `ProductID` from `products.csv` to `orders.csv`.
4. Create a **Calendar Table**:
   * Go to the Data View, click **New Table**, and paste: `Calendar = CALENDAR(DATE(2023,1,1), DATE(2023,12,31))`
   * Connect `Date` from the Calendar table to `PurchaseDate` in the Orders table.

## Step 3: Create the DAX Measures
1. Right-click the `orders` table and select **New Measure**.
2. Copy and paste the formulas from `DAX_Measures.dax` one by one.

## Step 4: Build the Visuals (Dashboard Layout)
1. **Top Row (KPI Cards):** Add 4 Card visuals for: `Total Revenue`, `Total Orders`, `Average Order Value`, and `MoM Growth %`. (Format MoM Growth as a percentage).
2. **Main Chart (Line and Clustered Column Chart):** 
   * X-Axis: `Month` (from Calendar table).
   * Column Y-Axis: `Total Revenue`.
   * Line Y-Axis: `Total Orders`.
3. **Left Column (Map Visual):**
   * Location: `CustomerState` (from customers table).
   * Bubble Size: `Total Revenue`.
4. **Bottom Right (Donut Chart):**
   * Legend: `ProductCategory` (from products table).
   * Values: `Total Revenue`.

## Step 5: Formatting (The "Premium" Look)
* Change the canvas background to a dark color (e.g., `#1e1e1e`).
* Give all charts a dark background with rounded corners and a subtle shadow.
* Turn off unnecessary gridlines to keep it clean.
