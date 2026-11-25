-- Day 20 | MySQL 8.0 | Run in MySQL Workbench
-- Load data/retail_sales.csv via Table Data Import Wizard into retail_sales (choose types below).
CREATE DATABASE IF NOT EXISTS day20_retail;
USE day20_retail;
CREATE TABLE IF NOT EXISTS retail_sales (
 Order_ID VARCHAR(20) PRIMARY KEY, Order_Date DATE, Customer_Name VARCHAR(80),
 City VARCHAR(50), Category VARCHAR(50), Product VARCHAR(100),
 Quantity INT, Unit_Price DECIMAL(12,2), Sales DECIMAL(12,2),
 Customer_Rating INT NULL
);
-- Import CSV into this table with Workbench Table Data Import Wizard.
SELECT COUNT(*) AS total_orders, SUM(Sales) AS total_revenue,
 SUM(Quantity) AS units_sold, ROUND(AVG(Sales),2) AS avg_order_value
FROM retail_sales;
SELECT Category, COUNT(*) AS orders, SUM(Sales) AS revenue
FROM retail_sales GROUP BY Category ORDER BY revenue DESC;
SELECT City, SUM(Sales) AS revenue FROM retail_sales GROUP BY City ORDER BY revenue DESC;
SELECT Product, SUM(Sales) AS revenue FROM retail_sales GROUP BY Product ORDER BY revenue DESC LIMIT 5;
SELECT DATE(Order_Date) AS order_day, SUM(Sales) AS daily_revenue
FROM retail_sales GROUP BY DATE(Order_Date) ORDER BY order_day;
SELECT Customer_Name, COUNT(*) AS orders, SUM(Sales) AS revenue
FROM retail_sales GROUP BY Customer_Name ORDER BY revenue DESC;
SELECT Category, ROUND(AVG(Customer_Rating),2) AS avg_rating, COUNT(Customer_Rating) AS rated_orders
FROM retail_sales GROUP BY Category;
SELECT COUNT(*) AS mismatched_sales FROM retail_sales WHERE Sales <> Quantity * Unit_Price;
-- Expected baseline: 30 orders; 81870 revenue; 90 units.
