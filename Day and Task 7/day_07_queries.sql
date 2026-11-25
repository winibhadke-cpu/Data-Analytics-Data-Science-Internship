-- DAY 7: SQL Fundamentals | MySQL 8.0+ | 23 November 2026
-- Currency: INR; order_amount = quantity * unit_price (price at current catalog rate).
-- Re-running this script resets the internship practice database.
DROP DATABASE IF EXISTS day07_retail_db;
CREATE DATABASE day07_retail_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE day07_retail_db;

CREATE TABLE customers (
  customer_id INT PRIMARY KEY,
  customer_name VARCHAR(100) NOT NULL,
  city VARCHAR(60) NOT NULL,
  email VARCHAR(120) UNIQUE NOT NULL
);
CREATE TABLE products (
  product_id INT PRIMARY KEY,
  product_name VARCHAR(100) NOT NULL,
  category VARCHAR(60) NOT NULL,
  unit_price DECIMAL(10,2) NOT NULL CHECK (unit_price > 0)
);
CREATE TABLE orders (
  order_id INT PRIMARY KEY,
  customer_id INT NOT NULL,
  product_id INT NOT NULL,
  quantity INT NOT NULL CHECK (quantity > 0),
  order_date DATE NOT NULL,
  FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
  FOREIGN KEY (product_id) REFERENCES products(product_id)
);
INSERT INTO customers (customer_id, customer_name, city, email) VALUES (1, 'Aarav Sharma', 'Pune', 'aarav@example.com');
INSERT INTO customers (customer_id, customer_name, city, email) VALUES (2, 'Priya Patil', 'Mumbai', 'priya@example.com');
INSERT INTO customers (customer_id, customer_name, city, email) VALUES (3, 'Neha Kulkarni', 'Pune', 'neha@example.com');
INSERT INTO customers (customer_id, customer_name, city, email) VALUES (4, 'Rahul Mehta', 'Nashik', 'rahul@example.com');
INSERT INTO customers (customer_id, customer_name, city, email) VALUES (5, 'Sneha Joshi', 'Pune', 'sneha@example.com');
INSERT INTO customers (customer_id, customer_name, city, email) VALUES (6, 'Kabir Shah', 'Nagpur', 'kabir@example.com');
INSERT INTO customers (customer_id, customer_name, city, email) VALUES (7, 'Isha Deshmukh', 'Mumbai', 'isha@example.com');
INSERT INTO customers (customer_id, customer_name, city, email) VALUES (8, 'Rohan Gupta', 'Pune', 'rohan@example.com');
INSERT INTO customers (customer_id, customer_name, city, email) VALUES (9, 'Ananya Rao', 'Kolhapur', 'ananya@example.com');
INSERT INTO customers (customer_id, customer_name, city, email) VALUES (10, 'Vivek Nair', 'Pune', 'vivek@example.com');
INSERT INTO products (product_id, product_name, category, unit_price) VALUES (101, 'Laptop', 'Electronics', 55000);
INSERT INTO products (product_id, product_name, category, unit_price) VALUES (102, 'Smartphone', 'Electronics', 22000);
INSERT INTO products (product_id, product_name, category, unit_price) VALUES (103, 'Headphones', 'Accessories', 1800);
INSERT INTO products (product_id, product_name, category, unit_price) VALUES (104, 'Office Chair', 'Furniture', 7500);
INSERT INTO products (product_id, product_name, category, unit_price) VALUES (105, 'Notebook', 'Stationery', 120);
INSERT INTO products (product_id, product_name, category, unit_price) VALUES (106, 'Desk Lamp', 'Furniture', 1600);
INSERT INTO products (product_id, product_name, category, unit_price) VALUES (107, 'Keyboard', 'Accessories', 950);
INSERT INTO products (product_id, product_name, category, unit_price) VALUES (108, 'Monitor', 'Electronics', 12500);
INSERT INTO orders (order_id, customer_id, product_id, quantity, order_date) VALUES (1001, 1, 101, 1, '2026-01-05');
INSERT INTO orders (order_id, customer_id, product_id, quantity, order_date) VALUES (1002, 2, 102, 1, '2026-01-09');
INSERT INTO orders (order_id, customer_id, product_id, quantity, order_date) VALUES (1003, 3, 103, 2, '2026-01-12');
INSERT INTO orders (order_id, customer_id, product_id, quantity, order_date) VALUES (1004, 1, 105, 5, '2026-02-02');
INSERT INTO orders (order_id, customer_id, product_id, quantity, order_date) VALUES (1005, 4, 104, 2, '2026-02-11');
INSERT INTO orders (order_id, customer_id, product_id, quantity, order_date) VALUES (1006, 5, 108, 1, '2026-02-14');
INSERT INTO orders (order_id, customer_id, product_id, quantity, order_date) VALUES (1007, 6, 107, 3, '2026-03-01');
INSERT INTO orders (order_id, customer_id, product_id, quantity, order_date) VALUES (1008, 7, 102, 2, '2026-03-08');
INSERT INTO orders (order_id, customer_id, product_id, quantity, order_date) VALUES (1009, 8, 106, 2, '2026-03-11');
INSERT INTO orders (order_id, customer_id, product_id, quantity, order_date) VALUES (1010, 9, 105, 10, '2026-03-18');
INSERT INTO orders (order_id, customer_id, product_id, quantity, order_date) VALUES (1011, 10, 101, 1, '2026-04-04');
INSERT INTO orders (order_id, customer_id, product_id, quantity, order_date) VALUES (1012, 3, 104, 1, '2026-04-09');
INSERT INTO orders (order_id, customer_id, product_id, quantity, order_date) VALUES (1013, 5, 103, 3, '2026-04-15');
INSERT INTO orders (order_id, customer_id, product_id, quantity, order_date) VALUES (1014, 2, 108, 2, '2026-05-03');
INSERT INTO orders (order_id, customer_id, product_id, quantity, order_date) VALUES (1015, 8, 107, 1, '2026-05-08');
INSERT INTO orders (order_id, customer_id, product_id, quantity, order_date) VALUES (1016, 1, 102, 1, '2026-05-14');
INSERT INTO orders (order_id, customer_id, product_id, quantity, order_date) VALUES (1017, 4, 106, 1, '2026-06-02');
INSERT INTO orders (order_id, customer_id, product_id, quantity, order_date) VALUES (1018, 6, 103, 2, '2026-06-12');
INSERT INTO orders (order_id, customer_id, product_id, quantity, order_date) VALUES (1019, 7, 101, 1, '2026-07-06');
INSERT INTO orders (order_id, customer_id, product_id, quantity, order_date) VALUES (1020, 9, 104, 1, '2026-07-21');
INSERT INTO orders (order_id, customer_id, product_id, quantity, order_date) VALUES (1021, 10, 105, 4, '2026-08-01');
INSERT INTO orders (order_id, customer_id, product_id, quantity, order_date) VALUES (1022, 5, 102, 1, '2026-08-13');
INSERT INTO orders (order_id, customer_id, product_id, quantity, order_date) VALUES (1023, 3, 108, 1, '2026-09-07');
INSERT INTO orders (order_id, customer_id, product_id, quantity, order_date) VALUES (1024, 8, 103, 1, '2026-09-20');
INSERT INTO orders (order_id, customer_id, product_id, quantity, order_date) VALUES (1025, 2, 107, 2, '2026-10-05');
INSERT INTO orders (order_id, customer_id, product_id, quantity, order_date) VALUES (1026, 1, 104, 1, '2026-10-17');
INSERT INTO orders (order_id, customer_id, product_id, quantity, order_date) VALUES (1027, 6, 105, 8, '2026-11-02');
INSERT INTO orders (order_id, customer_id, product_id, quantity, order_date) VALUES (1028, 10, 108, 1, '2026-11-10');

select * from orders;
select * from products;
select * from customers;

-- 28 practice queries. Execute individually after running the setup above.

-- Query 01: All customers
SELECT * FROM customers ORDER BY customer_id;

-- Query 02: Customers from Pune
SELECT customer_id, customer_name, city FROM customers WHERE city = 'Pune' ORDER BY customer_name;

-- Query 03: Distinct customer cities
SELECT DISTINCT city FROM customers ORDER BY city;

-- Query 04: All products by price (high to low)
SELECT product_id, product_name, unit_price FROM products ORDER BY unit_price DESC;

-- Query 05: Electronics products
SELECT product_name, unit_price FROM products WHERE category = 'Electronics' ORDER BY unit_price;

-- Query 06: Products priced between INR 1000 and INR 15000
SELECT product_name, unit_price FROM products WHERE unit_price BETWEEN 1000 AND 15000 ORDER BY unit_price;

-- Query 07: All orders with calculated amounts
SELECT o.order_id, o.quantity, p.product_name, o.quantity * p.unit_price AS order_amount FROM orders o JOIN products p ON o.product_id = p.product_id ORDER BY o.order_id;

-- Query 08: Orders above INR 5000
SELECT o.order_id, c.customer_name, o.quantity * p.unit_price AS order_amount FROM orders o JOIN customers c ON o.customer_id = c.customer_id JOIN products p ON o.product_id = p.product_id WHERE o.quantity * p.unit_price > 5000 ORDER BY order_amount DESC;

-- Query 09: Orders with customer and product names
SELECT o.order_id, c.customer_name, p.product_name, o.quantity, o.order_date FROM orders o JOIN customers c ON o.customer_id = c.customer_id JOIN products p ON o.product_id = p.product_id ORDER BY o.order_id;

-- Query 10: Count customers
SELECT COUNT(*) AS total_customers FROM customers;

-- Query 11: Count orders
SELECT COUNT(*) AS total_orders FROM orders;

-- Query 12: Total sales revenue
SELECT SUM(o.quantity * p.unit_price) AS total_sales_inr FROM orders o JOIN products p ON o.product_id = p.product_id;

-- Query 13: Average order value
SELECT ROUND(AVG(o.quantity * p.unit_price),2) AS avg_order_value_inr FROM orders o JOIN products p ON o.product_id = p.product_id;

-- Query 14: Minimum and maximum order amounts
SELECT MIN(o.quantity * p.unit_price) AS minimum_order_inr, MAX(o.quantity * p.unit_price) AS maximum_order_inr FROM orders o JOIN products p ON o.product_id = p.product_id;

-- Query 15: Orders per city
SELECT c.city, COUNT(*) AS order_count FROM orders o JOIN customers c ON o.customer_id = c.customer_id GROUP BY c.city ORDER BY order_count DESC, c.city;

-- Query 16: Revenue by city
SELECT c.city, SUM(o.quantity * p.unit_price) AS revenue_inr FROM orders o JOIN customers c ON o.customer_id = c.customer_id JOIN products p ON o.product_id = p.product_id GROUP BY c.city ORDER BY revenue_inr DESC;

-- Query 17: Top 5 products by revenue
SELECT p.product_name, SUM(o.quantity) AS units_sold, SUM(o.quantity * p.unit_price) AS revenue_inr FROM orders o JOIN products p ON o.product_id = p.product_id GROUP BY p.product_id, p.product_name ORDER BY revenue_inr DESC LIMIT 5;

-- Query 18: Top 5 products by quantity
SELECT p.product_name, SUM(o.quantity) AS units_sold FROM orders o JOIN products p ON o.product_id = p.product_id GROUP BY p.product_id, p.product_name ORDER BY units_sold DESC LIMIT 5;

-- Query 19: Revenue by category
SELECT p.category, SUM(o.quantity * p.unit_price) AS revenue_inr FROM orders o JOIN products p ON o.product_id = p.product_id GROUP BY p.category ORDER BY revenue_inr DESC;

-- Query 20: Categories with revenue above INR 20000
SELECT p.category, SUM(o.quantity * p.unit_price) AS revenue_inr FROM orders o JOIN products p ON o.product_id = p.product_id GROUP BY p.category HAVING SUM(o.quantity * p.unit_price) > 20000 ORDER BY revenue_inr DESC;

-- Query 21: Top 5 customers by spending
SELECT c.customer_name, COUNT(*) AS orders_placed, SUM(o.quantity * p.unit_price) AS total_spent_inr FROM orders o JOIN customers c ON o.customer_id = c.customer_id JOIN products p ON o.product_id = p.product_id GROUP BY c.customer_id, c.customer_name ORDER BY total_spent_inr DESC LIMIT 5;

-- Query 22: Monthly revenue
SELECT DATE_FORMAT(o.order_date, '%Y-%m') AS order_month, SUM(o.quantity * p.unit_price) AS revenue_inr FROM orders o JOIN products p ON o.product_id = p.product_id GROUP BY DATE_FORMAT(o.order_date, '%Y-%m') ORDER BY order_month;

-- Query 23: CASE order value bands
SELECT o.order_id, o.quantity * p.unit_price AS order_amount, CASE WHEN o.quantity * p.unit_price >= 20000 THEN 'High' WHEN o.quantity * p.unit_price >= 5000 THEN 'Medium' ELSE 'Low' END AS value_band FROM orders o JOIN products p ON o.product_id = p.product_id ORDER BY o.order_id;

-- Query 24: Customers with at least 3 orders
SELECT c.customer_name, COUNT(*) AS order_count FROM customers c JOIN orders o ON c.customer_id = o.customer_id GROUP BY c.customer_id, c.customer_name HAVING COUNT(*) >= 3 ORDER BY order_count DESC, c.customer_name;

-- Query 25: Customer name starts with A
SELECT customer_id, customer_name FROM customers WHERE customer_name LIKE 'A%' ORDER BY customer_name;

-- Query 26: Orders placed in October 2026
SELECT order_id, customer_id, order_date FROM orders WHERE order_date >= '2026-10-01' AND order_date < '2026-11-01' ORDER BY order_date;

-- Query 27: Product count per category
SELECT category, COUNT(*) AS product_count FROM products GROUP BY category ORDER BY product_count DESC, category;

-- Query 28: Pune customer orders
SELECT o.order_id, c.customer_name, p.product_name, o.quantity * p.unit_price AS order_amount FROM orders o JOIN customers c ON o.customer_id = c.customer_id JOIN products p ON o.product_id = p.product_id WHERE c.city = 'Pune' ORDER BY o.order_id;
