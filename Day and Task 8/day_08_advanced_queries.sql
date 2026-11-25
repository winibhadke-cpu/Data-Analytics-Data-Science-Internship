-- DAY 8: Advanced SQL | MySQL 8.0+ | 23 November 2026
-- Reuses Day 7 database day07_retail_db; do not rerun Day 7 after adding employees.
-- Run Day 7 setup first if database does not exist. This script does not drop retail data.
-- Revenue = quantity * current catalog unit_price; historical pricing not stored.
USE day07_retail_db;
CREATE TABLE IF NOT EXISTS employees (
 employee_id INT PRIMARY KEY,
 employee_name VARCHAR(100) NOT NULL,
 department VARCHAR(60) NOT NULL,
 salary DECIMAL(10,2) NOT NULL CHECK (salary > 0)
);
-- Upsert avoids duplicate-key errors on reruns (practice dataset only).
INSERT INTO employees (employee_id,employee_name,department,salary) VALUES
 (1,'Aditi Rao','Analytics',85000),
 (2,'Vikram Shah','Analytics',75000),
 (3,'Meera Patil','Sales',65000),
 (4,'Sahil Desai','Sales',65000),
 (5,'Nisha Kulkarni','IT',90000),
 (6,'Rohit Nair','IT',72000),
 (7,'Kavya Joshi','Analytics',85000),
 (8,'Arjun Mehta','HR',58000)
ON DUPLICATE KEY UPDATE employee_name=VALUES(employee_name),department=VALUES(department),salary=VALUES(salary);

-- Query 01: Customer orders with names
-- INNER JOIN returns only matching customer and order records.
SELECT o.order_id,c.customer_name,o.order_date FROM orders o INNER JOIN customers c ON c.customer_id=o.customer_id ORDER BY o.order_id LIMIT 10;

-- Query 02: Order detail with product
-- Join orders to products and calculate line revenue.
SELECT o.order_id,p.product_name,o.quantity,o.quantity*p.unit_price AS revenue FROM orders o INNER JOIN products p ON p.product_id=o.product_id ORDER BY o.order_id LIMIT 10;

-- Query 03: Full order details
-- Join all three retail tables.
SELECT o.order_id,c.customer_name,p.product_name,o.quantity,o.quantity*p.unit_price AS revenue FROM orders o JOIN customers c ON c.customer_id=o.customer_id JOIN products p ON p.product_id=o.product_id ORDER BY o.order_id LIMIT 10;

-- Query 04: Customers including those with no orders
-- LEFT JOIN retains customers with no transactions.
SELECT c.customer_id,c.customer_name,COUNT(o.order_id) AS order_count FROM customers c LEFT JOIN orders o ON o.customer_id=c.customer_id GROUP BY c.customer_id,c.customer_name ORDER BY c.customer_id;

-- Query 05: Products including unsold products
-- LEFT JOIN retains all catalog products.
SELECT p.product_id,p.product_name,COALESCE(SUM(o.quantity),0) AS units_sold FROM products p LEFT JOIN orders o ON o.product_id=p.product_id GROUP BY p.product_id,p.product_name ORDER BY p.product_id;

-- Query 06: Top 3 customers by spending
-- Revenue aggregated by customer then sorted descending.
SELECT c.customer_id,c.customer_name,SUM(o.quantity*p.unit_price) AS total_spent FROM customers c JOIN orders o ON o.customer_id=c.customer_id JOIN products p ON p.product_id=o.product_id GROUP BY c.customer_id,c.customer_name ORDER BY total_spent DESC,c.customer_id LIMIT 3;

-- Query 07: Top 3 products per category
-- ROW_NUMBER partitions products into category rankings.
WITH sales AS (SELECT p.product_id,p.product_name,p.category,COALESCE(SUM(o.quantity*p.unit_price),0) AS revenue FROM products p LEFT JOIN orders o ON o.product_id=p.product_id GROUP BY p.product_id,p.product_name,p.category), ranked AS (SELECT *,ROW_NUMBER() OVER (PARTITION BY category ORDER BY revenue DESC,product_id) AS category_position FROM sales) SELECT category,product_name,revenue,category_position FROM ranked WHERE category_position<=3 ORDER BY category,category_position;

-- Query 08: Customer ranking with RANK
-- Ties receive equal rank with gaps.
WITH spend AS (SELECT c.customer_id,c.customer_name,COALESCE(SUM(o.quantity*p.unit_price),0) AS total_spent FROM customers c LEFT JOIN orders o ON o.customer_id=c.customer_id LEFT JOIN products p ON p.product_id=o.product_id GROUP BY c.customer_id,c.customer_name) SELECT customer_name,total_spent,RANK() OVER (ORDER BY total_spent DESC) AS spending_rank FROM spend ORDER BY spending_rank,customer_id;

-- Query 09: Customer dense ranking
-- DENSE_RANK avoids rank gaps.
WITH spend AS (SELECT c.customer_id,c.customer_name,COALESCE(SUM(o.quantity*p.unit_price),0) AS total_spent FROM customers c LEFT JOIN orders o ON o.customer_id=c.customer_id LEFT JOIN products p ON p.product_id=o.product_id GROUP BY c.customer_id,c.customer_name) SELECT customer_name,total_spent,DENSE_RANK() OVER (ORDER BY total_spent DESC) AS dense_rank_no FROM spend ORDER BY dense_rank_no,customer_id;

-- Query 10: Monthly revenue
-- Monthly sales aggregated by year-month.
SELECT DATE_FORMAT(o.order_date,'%Y-%m') AS sales_month,SUM(o.quantity*p.unit_price) AS revenue FROM orders o JOIN products p ON p.product_id=o.product_id GROUP BY DATE_FORMAT(o.order_date,'%Y-%m') ORDER BY sales_month;

-- Query 11: Previous month revenue
-- LAG retrieves the preceding calendar month from monthly totals.
WITH monthly AS (SELECT DATE_FORMAT(o.order_date,'%Y-%m') AS sales_month,SUM(o.quantity*p.unit_price) AS revenue FROM orders o JOIN products p ON p.product_id=o.product_id GROUP BY DATE_FORMAT(o.order_date,'%Y-%m')) SELECT sales_month,revenue,LAG(revenue) OVER (ORDER BY sales_month) AS previous_month_revenue FROM monthly ORDER BY sales_month;

-- Query 12: Month-over-month growth
-- Percentage change versus previous month; first month NULL.
WITH monthly AS (SELECT DATE_FORMAT(o.order_date,'%Y-%m') AS sales_month,SUM(o.quantity*p.unit_price) AS revenue FROM orders o JOIN products p ON p.product_id=o.product_id GROUP BY DATE_FORMAT(o.order_date,'%Y-%m')), changes AS (SELECT sales_month,revenue,LAG(revenue) OVER (ORDER BY sales_month) AS previous_revenue FROM monthly) SELECT sales_month,revenue,previous_revenue,ROUND(100.0*(revenue-previous_revenue)/NULLIF(previous_revenue,0),2) AS mom_growth_pct FROM changes ORDER BY sales_month;

-- Query 13: Employee salary ranking
-- RANK salaries across all employees.
SELECT employee_name,department,salary,RANK() OVER (ORDER BY salary DESC) AS salary_rank FROM employees ORDER BY salary_rank,employee_id;

-- Query 14: Department salary ranking
-- DENSE_RANK within each department.
SELECT department,employee_name,salary,DENSE_RANK() OVER (PARTITION BY department ORDER BY salary DESC) AS department_rank FROM employees ORDER BY department,department_rank,employee_id;

-- Query 15: Highest paid employee per department
-- ROW_NUMBER selects exactly one top earner per department.
WITH ranked AS (SELECT employee_id,employee_name,department,salary,ROW_NUMBER() OVER (PARTITION BY department ORDER BY salary DESC,employee_id) AS rn FROM employees) SELECT department,employee_name,salary FROM ranked WHERE rn=1 ORDER BY department;

-- Query 16: Above-average salary employees
-- Scalar subquery filters against global salary average.
SELECT employee_name,department,salary FROM employees WHERE salary>(SELECT AVG(salary) FROM employees) ORDER BY salary DESC,employee_name;

-- Query 17: Customers above average spending
-- CTE and subquery compare customer totals.
WITH totals AS (SELECT c.customer_id,c.customer_name,COALESCE(SUM(o.quantity*p.unit_price),0) AS total_spent FROM customers c LEFT JOIN orders o ON o.customer_id=c.customer_id LEFT JOIN products p ON p.product_id=o.product_id GROUP BY c.customer_id,c.customer_name) SELECT customer_name,total_spent FROM totals WHERE total_spent>(SELECT AVG(total_spent) FROM totals) ORDER BY total_spent DESC;

-- Query 18: Customers who bought electronics
-- EXISTS correlated subquery checks purchase history.
SELECT c.customer_id,c.customer_name FROM customers c WHERE EXISTS (SELECT 1 FROM orders o JOIN products p ON p.product_id=o.product_id WHERE o.customer_id=c.customer_id AND p.category='Electronics') ORDER BY c.customer_id;

-- Query 19: Revenue by category
-- Join products and orders to compare categories.
SELECT p.category,SUM(o.quantity*p.unit_price) AS revenue FROM orders o JOIN products p ON p.product_id=o.product_id GROUP BY p.category ORDER BY revenue DESC;

-- Query 20: Product revenue ranks by category
-- RANK product revenue within each category.
WITH sales AS (SELECT p.product_id,p.product_name,p.category,COALESCE(SUM(o.quantity*p.unit_price),0) AS revenue FROM products p LEFT JOIN orders o ON o.product_id=p.product_id GROUP BY p.product_id,p.product_name,p.category) SELECT category,product_name,revenue,RANK() OVER (PARTITION BY category ORDER BY revenue DESC) AS revenue_rank FROM sales ORDER BY category,revenue_rank,product_id;

-- Query 21: Next month revenue
-- LEAD retrieves next observed month revenue.
WITH monthly AS (SELECT DATE_FORMAT(o.order_date,'%Y-%m') AS sales_month,SUM(o.quantity*p.unit_price) AS revenue FROM orders o JOIN products p ON p.product_id=o.product_id GROUP BY DATE_FORMAT(o.order_date,'%Y-%m')) SELECT sales_month,revenue,LEAD(revenue) OVER (ORDER BY sales_month) AS next_month_revenue FROM monthly ORDER BY sales_month;

-- Query 22: Running monthly revenue
-- Cumulative revenue through each month.
WITH monthly AS (SELECT DATE_FORMAT(o.order_date,'%Y-%m') AS sales_month,SUM(o.quantity*p.unit_price) AS revenue FROM orders o JOIN products p ON p.product_id=o.product_id GROUP BY DATE_FORMAT(o.order_date,'%Y-%m')) SELECT sales_month,revenue,SUM(revenue) OVER (ORDER BY sales_month ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS cumulative_revenue FROM monthly ORDER BY sales_month;

-- Query 23: Monthly order counts and average value
-- Counts and averages per month.
SELECT DATE_FORMAT(o.order_date,'%Y-%m') AS sales_month,COUNT(*) AS order_count,ROUND(AVG(o.quantity*p.unit_price),2) AS avg_order_value FROM orders o JOIN products p ON p.product_id=o.product_id GROUP BY DATE_FORMAT(o.order_date,'%Y-%m') ORDER BY sales_month;

-- Query 24: Orders above customer average
-- Correlated subquery identifies larger-than-usual orders.
SELECT o.order_id,o.customer_id,o.quantity*p.unit_price AS order_amount FROM orders o JOIN products p ON p.product_id=o.product_id WHERE o.quantity*p.unit_price>(SELECT AVG(o2.quantity*p2.unit_price) FROM orders o2 JOIN products p2 ON p2.product_id=o2.product_id WHERE o2.customer_id=o.customer_id) ORDER BY o.customer_id,o.order_id;

-- Query 25: Top order per customer
-- ROW_NUMBER isolates each customer highest value order.
WITH ranked AS (SELECT o.order_id,o.customer_id,o.quantity*p.unit_price AS order_amount,ROW_NUMBER() OVER (PARTITION BY o.customer_id ORDER BY o.quantity*p.unit_price DESC,o.order_id) AS rn FROM orders o JOIN products p ON p.product_id=o.product_id) SELECT customer_id,order_id,order_amount FROM ranked WHERE rn=1 ORDER BY customer_id;

-- Query 26: Department salary summary
-- CTE aggregates salary by department.
WITH department_pay AS (SELECT department,COUNT(*) AS employee_count,ROUND(AVG(salary),2) AS avg_salary,MAX(salary) AS max_salary FROM employees GROUP BY department) SELECT * FROM department_pay ORDER BY avg_salary DESC;

-- Query 27: Customer purchase sequence
-- ROW_NUMBER orders purchases within customer.
SELECT customer_id,order_id,order_date,ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY order_date,order_id) AS purchase_number FROM orders ORDER BY customer_id,purchase_number;

-- Query 28: Previous purchase date
-- LAG shows preceding order date per customer.
SELECT customer_id,order_id,order_date,LAG(order_date) OVER (PARTITION BY customer_id ORDER BY order_date,order_id) AS previous_order_date FROM orders ORDER BY customer_id,order_date,order_id;

