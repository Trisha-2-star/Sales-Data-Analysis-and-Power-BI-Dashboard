# Sales Data Analysis and Power BI Dashboard

## Project status
Starter project with a synthetic practice dataset. Complete the analysis and dashboard before listing it as a completed project on your resume.

## Objective
Analyze sales performance across time, region, product category, product, payment method, and customer segment. Identify trends and communicate practical business insights.

## Files
- `sales_data.csv` — 600 synthetic order records for practice
- `sales_analysis.sql` — MySQL table definition and analysis queries
- `README.md` — build guide

## Dataset fields
Order_ID, Order_Date, Region, City, Category, Product, Quantity, Unit_Price, Discount_Pct, Unit_Cost, Payment_Method, Customer_Segment.

The dataset is synthetic and is not real company or customer data.

## Step 1: Analyze in SQL
1. Create a database, for example `sales_analysis`.
2. Import `sales_data.csv` into a table called `sales_data` using MySQL Workbench's Table Data Import Wizard.
3. If you create the table manually, use the schema in `sales_analysis.sql`.
4. Run each query and save the results or screenshots for your portfolio.
5. Check data quality: row count, duplicate Order_ID values, missing dates, and invalid quantities.

## Step 2: Explore in Excel
1. Open `sales_data.csv` in Excel.
2. Check date and numeric column types; inspect blanks and duplicates.
3. Create PivotTables for monthly revenue, region, category, and payment method.
4. Use filters and conditional formatting to highlight high/low performance.
5. Compare PivotTable results with the SQL outputs.

## Step 3: Build the Power BI report
1. Open Power BI Desktop and choose Get Data > Text/CSV; select `sales_data.csv`.
2. In Power Query, set `Order_Date` to Date; set quantity to Whole Number and prices/costs/discount to Decimal Number.
3. Check for nulls and duplicate order IDs. Keep a documented record of any changes.
4. Create these DAX measures (table name assumed to be `sales_data`):

```DAX
Total Orders = DISTINCTCOUNT(sales_data[Order_ID])

Units Sold = SUM(sales_data[Quantity])

Net Revenue =
SUMX(
    sales_data,
    sales_data[Quantity] * sales_data[Unit_Price] * (1 - sales_data[Discount_Pct])
)

Total Cost =
SUMX(sales_data, sales_data[Quantity] * sales_data[Unit_Cost])

Profit = [Net Revenue] - [Total Cost]

Profit Margin % = DIVIDE([Profit], [Net Revenue], 0)
```

5. Build one report page with:
   - KPI cards: Total Orders, Net Revenue, Profit, Profit Margin %
   - Line chart: Net Revenue by month
   - Bar chart: Net Revenue by Region
   - Column chart: Revenue and Profit by Category
   - Bar chart: Top 10 Products by Net Revenue
   - Donut chart: Orders by Payment Method
   - Slicers: Order_Date, Region, Category, Customer_Segment
6. Add a clear report title, consistent number formats, readable labels, and useful tooltips.

## Step 4: Write 3–5 evidence-based insights
Use your actual query/dashboard results; do not guess. Examples of questions to answer:
- Which month had the highest net revenue?
- Which region contributed the most revenue and profit?
- Which category had the highest profit margin?
- Which products ranked in the top 10 by revenue?
- Which customer segment contributed the most revenue?
- Did larger discounts coincide with lower profit margins?

## Step 5: Validate and publish to your portfolio
- Confirm dashboard totals match SQL results.
- Take screenshots of the dashboard and selected SQL queries.
- Write a short project summary and upload the SQL, dataset, and screenshots to GitHub.
- Do not publish confidential data; this starter uses synthetic data.

