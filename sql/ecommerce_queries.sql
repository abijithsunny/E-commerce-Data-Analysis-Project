CREATE DATABASE ecommerce;
 USE ecommerce;
 
 CREATE TABLE  total_revenue AS
 SELECT SUM(quantity*price) AS total_revenue FROM orders_clean;
   SELECT * FROM orders_clean;
   
   
 CREATE TABLE  total_revenue AS
SELECT SUM(quantity * price) AS total_revenue 
FROM orders_clean;

CREATE TABLE monthly_sales AS
SELECT 
    YEAR(order_date) AS year,
    MONTH(order_date) AS month,
    SUM(quantity * price) AS revenue
FROM   orders_clean
GROUP BY year, month
ORDER BY year, month;


ALTER TABLE orders_clean DROP INDEX order_date;

ALTER TABLE orders_clean
MODIFY order_date DATE;


SELECT order_date FROM orders_clean;


UPDATE orders_clean
SET order_date = STR_TO_DATE(order_date, '%d-%m-%Y');


UPDATE orders_clean
SET order_date = STR_TO_DATE(order_date, '%d-%m-%Y')
WHERE order_id IS NOT NULL;

SET SQL_SAFE_UPDATES = 0;


CREATE TABLE top_products AS
SELECT 
    p.product_name,
    SUM(o.quantity) AS total_sold
FROM orders_clean o
JOIN products_clean p 
    ON o.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_sold DESC
LIMIT 5;

SELECT * FROM top_products;

CREATE TABLE top_customers AS
SELECT 
    c.name,
    SUM(o.quantity * o.price) AS total_spent
FROM orders_clean o
JOIN `customers-clean` c ON o.customer_id = c.customer_id
GROUP BY c.name
ORDER BY total_spent DESC
LIMIT 5;

SELECT * FROM top_customers;


