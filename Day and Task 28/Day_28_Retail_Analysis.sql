USE retail_day28;
-- Profit is unavailable; NULL is not zero. City is a region proxy.
-- 01. Total sales
SELECT SUM(Sales) AS total_sales FROM retail_sales;

-- 02. Total profit
SELECT CASE WHEN COUNT(Profit)=COUNT(*) THEN SUM(Profit) ELSE NULL END AS total_profit FROM retail_sales;

-- 03. Total orders
SELECT COUNT(DISTINCT Order_ID) AS total_orders FROM retail_sales;

-- 04. Total customers
SELECT COUNT(DISTINCT Customer_Name) AS total_customers FROM retail_sales;

-- 05. Average order value
SELECT ROUND(SUM(Sales)/COUNT(DISTINCT Order_ID),2) AS average_order_value FROM retail_sales;

-- 06. Sales by category
SELECT Category, SUM(Sales) AS revenue FROM retail_sales GROUP BY Category ORDER BY revenue DESC;

-- 07. Sales by region
SELECT City AS region_proxy, SUM(Sales) AS revenue FROM retail_sales GROUP BY City ORDER BY revenue DESC;

-- 08. Profit by category
SELECT Category, CASE WHEN COUNT(Profit)=COUNT(*) THEN SUM(Profit) ELSE NULL END AS profit FROM retail_sales GROUP BY Category;

-- 09. Profit by region
SELECT City AS region_proxy, CASE WHEN COUNT(Profit)=COUNT(*) THEN SUM(Profit) ELSE NULL END AS profit FROM retail_sales GROUP BY City;

-- 10. Sales by month
SELECT SUBSTR(Order_Date,1,7) AS sales_month, SUM(Sales) AS revenue FROM retail_sales GROUP BY SUBSTR(Order_Date,1,7) ORDER BY sales_month;

-- 11. Top 10 customers
SELECT Customer_Name, SUM(Sales) AS revenue FROM retail_sales GROUP BY Customer_Name ORDER BY revenue DESC, Customer_Name LIMIT 10;

-- 12. Repeat customers
SELECT Customer_Name, COUNT(DISTINCT Order_ID) AS orders FROM retail_sales GROUP BY Customer_Name HAVING COUNT(DISTINCT Order_ID)>1 ORDER BY orders DESC, Customer_Name;

-- 13. Average customer spending
WITH spending AS (SELECT Customer_Name, SUM(Sales) AS total FROM retail_sales GROUP BY Customer_Name) SELECT ROUND(AVG(total),2) AS avg_customer_spending FROM spending;

-- 14. Top products
SELECT Product, SUM(Sales) AS revenue FROM retail_sales GROUP BY Product ORDER BY revenue DESC, Product LIMIT 10;

-- 15. Bottom products
SELECT Product, SUM(Sales) AS revenue FROM retail_sales GROUP BY Product ORDER BY revenue ASC, Product LIMIT 10;

-- 16. Most profitable products
WITH totals AS (SELECT Product, CASE WHEN COUNT(Profit)=COUNT(*) THEN SUM(Profit) ELSE NULL END AS profit FROM retail_sales GROUP BY Product) SELECT * FROM totals WHERE profit IS NOT NULL ORDER BY profit DESC LIMIT 10;

-- 17. Customer ranking
WITH totals AS (SELECT Customer_Name, SUM(Sales) AS revenue FROM retail_sales GROUP BY Customer_Name) SELECT *, DENSE_RANK() OVER (ORDER BY revenue DESC) AS revenue_rank FROM totals ORDER BY revenue_rank, Customer_Name;

-- 18. Product ranking
WITH totals AS (SELECT Product, SUM(Sales) AS revenue FROM retail_sales GROUP BY Product) SELECT *, DENSE_RANK() OVER (ORDER BY revenue DESC) AS revenue_rank FROM totals ORDER BY revenue_rank, Product;

-- 19. Monthly growth
WITH monthly AS (SELECT SUBSTR(Order_Date,1,7) AS sales_month, SUM(Sales) AS revenue FROM retail_sales GROUP BY SUBSTR(Order_Date,1,7)), prior AS (SELECT *, LAG(revenue) OVER (ORDER BY sales_month) AS previous_revenue FROM monthly) SELECT *, ROUND(100.0*(revenue-previous_revenue)/NULLIF(previous_revenue,0),2) AS growth_pct FROM prior ORDER BY sales_month;

-- 20. Category ranking
WITH totals AS (SELECT Category, SUM(Sales) AS revenue FROM retail_sales GROUP BY Category) SELECT *, DENSE_RANK() OVER (ORDER BY revenue DESC) AS revenue_rank FROM totals ORDER BY revenue_rank, Category;

-- 21. Customer revenue and order counts using JOIN
WITH totals AS (SELECT Customer_Name, SUM(Sales) AS revenue FROM retail_sales GROUP BY Customer_Name), counts AS (SELECT Customer_Name, COUNT(DISTINCT Order_ID) AS orders FROM retail_sales GROUP BY Customer_Name) SELECT t.Customer_Name,t.revenue,c.orders, CASE WHEN c.orders>1 THEN 'Repeat' ELSE 'Single' END AS customer_type FROM totals t JOIN counts c ON t.Customer_Name=c.Customer_Name ORDER BY t.revenue DESC;