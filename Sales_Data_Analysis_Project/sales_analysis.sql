-- Sales Data Analysis Project
-- Compatible with MySQL 8+
-- Import sales_data.csv into a table named sales_data first.

CREATE TABLE IF NOT EXISTS sales_data (
    Order_ID VARCHAR(12) PRIMARY KEY,
    Order_Date DATE,
    Region VARCHAR(30),
    City VARCHAR(50),
    Category VARCHAR(50),
    Product VARCHAR(100),
    Quantity INT,
    Unit_Price DECIMAL(10,2),
    Discount_Pct DECIMAL(5,2),
    Unit_Cost DECIMAL(10,2),
    Payment_Method VARCHAR(40),
    Customer_Segment VARCHAR(40)
);

-- 1. Overall KPIs
SELECT
    COUNT(DISTINCT Order_ID) AS total_orders,
    SUM(Quantity) AS units_sold,
    ROUND(SUM(Quantity * Unit_Price * (1 - Discount_Pct)), 2) AS net_revenue,
    ROUND(SUM(Quantity * Unit_Price * (1 - Discount_Pct) - Quantity * Unit_Cost), 2) AS profit
FROM sales_data;

-- 2. Monthly revenue and profit
SELECT DATE_FORMAT(Order_Date, '%Y-%m') AS month,
       ROUND(SUM(Quantity * Unit_Price * (1 - Discount_Pct)), 2) AS revenue,
       ROUND(SUM(Quantity * Unit_Price * (1 - Discount_Pct) - Quantity * Unit_Cost), 2) AS profit
FROM sales_data
GROUP BY DATE_FORMAT(Order_Date, '%Y-%m')
ORDER BY month;

-- 3. Revenue by region
SELECT Region,
       ROUND(SUM(Quantity * Unit_Price * (1 - Discount_Pct)), 2) AS revenue,
       ROUND(SUM(Quantity * Unit_Price * (1 - Discount_Pct) - Quantity * Unit_Cost), 2) AS profit
FROM sales_data
GROUP BY Region
ORDER BY revenue DESC;

-- 4. Category performance
SELECT Category,
       SUM(Quantity) AS units_sold,
       ROUND(SUM(Quantity * Unit_Price * (1 - Discount_Pct)), 2) AS revenue,
       ROUND(SUM(Quantity * Unit_Price * (1 - Discount_Pct) - Quantity * Unit_Cost), 2) AS profit
FROM sales_data
GROUP BY Category
ORDER BY revenue DESC;

-- 5. Top 10 products by revenue
SELECT Product,
       ROUND(SUM(Quantity * Unit_Price * (1 - Discount_Pct)), 2) AS revenue
FROM sales_data
GROUP BY Product
ORDER BY revenue DESC
LIMIT 10;

-- 6. Payment method mix
SELECT Payment_Method, COUNT(*) AS orders,
       ROUND(SUM(Quantity * Unit_Price * (1 - Discount_Pct)), 2) AS revenue
FROM sales_data
GROUP BY Payment_Method
ORDER BY orders DESC;

-- 7. Customer segment analysis
SELECT Customer_Segment,
       COUNT(DISTINCT Order_ID) AS orders,
       ROUND(SUM(Quantity * Unit_Price * (1 - Discount_Pct)), 2) AS revenue,
       ROUND(SUM(Quantity * Unit_Price * (1 - Discount_Pct) - Quantity * Unit_Cost), 2) AS profit
FROM sales_data
GROUP BY Customer_Segment
ORDER BY revenue DESC;

-- 8. Data quality checks
SELECT COUNT(*) AS total_rows,
       COUNT(DISTINCT Order_ID) AS unique_orders,
       SUM(Order_Date IS NULL) AS missing_dates,
       SUM(Quantity IS NULL OR Quantity <= 0) AS invalid_quantities
FROM sales_data;
