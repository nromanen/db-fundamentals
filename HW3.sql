/*Retrieve all first names from employees*/
SELECT first_name
FROM employees;

/*Retrieve all cities where orders were shipped*/
SELECT DISTINCT ship_city 
FROM orders;

/*Get all orders sorted by ship country*/
SELECT order_id, 
		ship_country
FROM orders
ORDER BY ship_country;

/*Get all orders sorted by customer_id in descending order*/
SELECT order_id, 
		customer_id 
FROM orders
order BY customer_id DESC;

/*Get products from category with max average price*/
SELECT category_id, product_name, unit_price
FROM products
WHERE category_id = (SELECT category_id
					FROM products 
					GROUP BY category_id 
					ORDER BY avg(unit_price) DESC 
					LIMIT 1);

/*Get three categories with the largest quantity of products in stock*/
SELECT c.category_id, 
		c.category_name,
		SUM(units_in_stock) AS total_stock
FROM categories c
INNER JOIN products p ON c.category_id = p.category_id
GROUP BY c.category_id, c.category_name
ORDER BY total_stock DESC
LIMIT 3;
