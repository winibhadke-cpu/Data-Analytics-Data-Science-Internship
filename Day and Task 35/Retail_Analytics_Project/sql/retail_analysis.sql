-- MySQL 8: import transformed_retail_sales.csv into retail_sales first.
SELECT SUM(Sales) AS Revenue, COUNT(DISTINCT Order_ID) AS Orders, COUNT(DISTINCT Customer_Name) AS Observed_Customers, SUM(Sales)/NULLIF(COUNT(DISTINCT Order_ID),0) AS AOV FROM retail_sales;
SELECT Category,SUM(Sales) AS Revenue FROM retail_sales GROUP BY Category ORDER BY Revenue DESC;
SELECT City,SUM(Sales) AS Revenue FROM retail_sales GROUP BY City ORDER BY Revenue DESC;
SELECT Product,SUM(Sales) AS Revenue,SUM(Quantity) AS Units,DENSE_RANK() OVER(ORDER BY SUM(Sales) DESC) AS Revenue_Rank FROM retail_sales GROUP BY Product;
SELECT Customer_Name,SUM(Sales) AS Revenue,COUNT(DISTINCT Order_ID) AS Orders FROM retail_sales GROUP BY Customer_Name ORDER BY Revenue DESC;
SELECT Year,Month,SUM(Sales) AS Revenue FROM retail_sales GROUP BY Year,Month ORDER BY Year,Month;
-- Profit unavailable; do not substitute zero.
