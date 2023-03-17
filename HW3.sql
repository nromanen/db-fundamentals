SELECT * 
FROM employees
WHERE employee_id = 8;

SELECT first_name, last_name 
FROM employees
WHERE city = 'London';

SELECT first_name, last_name 
FROM employees
WHERE first_name LIKE 'A%';

SELECT count(first_name) 
FROM employees
WHERE city = 'London';

--Retrieve all first names from employees
SELECT first_name 
FROM employees;

--Retrieve all cities where orders were shipped
SELECT DISTINCT ship_city 
FROM orders;

--Get all orders sorted by ship country
SELECT *
FROM orders
ORDER BY ship_country;

--Get all orders sorted by supplier_id in descending order
SELECT *
FROM suppliers
ORDER BY supplier_id desc;

--Get count of unique ship_name for each ship country in orders table
SELECT ship_country, count(DISTINCT ship_name) AS amount_unique_ship_name 
FROM orders
GROUP BY ship_country;