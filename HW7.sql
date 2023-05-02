/* Practice */

/* Show first and last names of the employees who have the biggest freight. */
SELECT e.first_name
, e.last_name
, o.freight
FROM employees e 
INNER join orders o ON e.employee_id = o.employee_id
WHERE o.freight = (SELECT MAX(freight) FROM orders);

/* Show first, last names of the employees, their freight who have the freight bigger then average */
SELECT DISTINCT e.first_name
, e.last_name
, AVG(o.freight)
FROM employees e 
INNER JOIN orders o ON e.employee_id = o.employee_id
GROUP BY e.employee_id
HAVING AVG(o.freight) > (SELECT AVG(freight) FROM orders)
ORDER BY 3 DESC;

/* Show the names of products, that have the biggest price. */
SELECT product_name
, unit_price
FROM products
WHERE unit_price = (SELECT MAX(unit_price) FROM products);

/* Show the name of customers with the freight bigger then average. */
SELECT c.company_name
, round(avg(o.freight) ::numeric, 2) AS avg_freight
FROM customers c
INNER JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id
HAVING AVG(o.freight) > (SELECT AVG(freight) FROM orders)
ORDER BY 1;

/* Show the name of supplier who delivered the cheapest product. */
SELECT s.company_name
, p.product_name
, p.unit_price
FROM suppliers s
INNER JOIN products p ON s.supplier_id = p.supplier_id
WHERE p.unit_price = (SELECT MIN(unit_price) FROM products);

/* Calculate the average freight of all employees who work not with Western region. */
SELECT e.last_name
, e.first_name
, ROUND(AVG(o.freight)::numeric, 2) AS avg_freight
FROM employees e
INNER JOIN orders o ON e.employee_id = o.employee_id
AND e.employee_id NOT IN (SELECT e.employee_id
                          FROM employees e
                          INNER JOIN employee_territories et on e.employee_id = et.employee_id
                          INNER JOIN territories t on et.territory_id = t.territory_id
                          INNER JOIN region r on t.region_id = r.region_id
                          WHERE r.region_description LIKE 'Western')
GROUP BY o.employee_id, e.last_name, e.first_name
ORDER BY 1;

/* Show first and last names of employees who shipped orders in cities of USA. */
SELECT DISTINCT e.first_name
, e.last_name
FROM employees e
INNER JOIN orders o on e.employee_id = o.employee_id
WHERE o.ship_city IN (SELECT o.ship_city
						FROM employees e
						INNER JOIN orders o on e.employee_id = o.employee_id
						WHERE o.ship_country like 'USA')
ORDER BY 2;


/* Show the name of customers that prefer to order non-domestic products. */
SELECT company_name 
FROM customers 
WHERE customer_id NOT IN (SELECT c.customer_id 
							FROM customers c
							INNER JOIN orders o on c.customer_id = o.customer_id
							INNER JOIN order_details od on o.order_id = od.order_id
							INNER JOIN products p on od.product_id = p.product_id
							INNER JOIN suppliers s on p.supplier_id = s.supplier_id
							WHERE c.country = s.country)
ORDER BY 1;

/* Show employees (first and last name) working with orders from the United States */
SELECT e.first_name
, e.last_name
FROM employees e
WHERE e.employee_id = ANY (SELECT e.employee_id
							FROM employees e
							INNER JOIN orders o ON e.employee_id = o.employee_id
							WHERE o.ship_country LIKE 'USA')
ORDER BY 2;

/* Show the lists the product names that order quantity equals to 100. */
SELECT p.product_name
FROM products p
WHERE p.product_id = ANY (SELECT p.product_id
                          FROM orders o
                          INNER JOIN order_details od on o.order_id = od.order_id
                          INNER JOIN products p on p.product_id = od.product_id 
						  WHERE od.quantity = 100)
ORDER BY 1;

/* Show the lists the suppliers with a product price equal to 10$. */
SELECT s.supplier_id
, s.company_name
FROM suppliers s
WHERE supplier_id = ANY (SELECT s.supplier_id
                         FROM suppliers s
                         INNER JOIN products p ON s.supplier_id = p.supplier_id
                         WHERE p.unit_price = 10)
ORDER BY 1;

/* Create a report that shows all companies by name that sell products in the Dairy Products category. */
SELECT s.company_name
FROM suppliers s
WHERE s.supplier_id IN (SELECT s.supplier_id
						FROM suppliers s
						INNER JOIN products p on s.supplier_id = p.supplier_id
						INNER JOIN categories c on c.category_id = p.category_id
						WHERE c.category_name like 'Dairy Products')
ORDER BY 1;

/* Homework */

/* Create a report that shows the product name and supplier id for all products supplied by Exotic Liquids, Grandma Kelly's Homestead, and Tokyo Traders. */
SELECT p.product_name
, s.supplier_id
FROM products p
INNER JOIN suppliers s on s.supplier_id = p.supplier_id
WHERE s.supplier_id IN (SELECT s.supplier_id
                        FROM suppliers s
                        WHERE s.company_name IN ('Exotic Liquids', 'Grandma Kelly''s Homestead', 'Tokyo Traders'))
ORDER BY 1; 

/* 2. Create a report that shows all the products which are supplied by a company called ‘Pavlova, Ltd.’. */
SELECT p.product_name
FROM products p
WHERE p.product_id IN (SELECT p.product_id
						FROM products p
						INNER JOIN suppliers s ON s.supplier_id = p.supplier_id
						WHERE s.company_name LIKE 'Pavlova, Ltd.')
ORDER BY 1;                       

/*  3. Create a report that shows the orders placed by all the customers excluding the customers who belongs to London city. */
SELECT *
FROM orders
where customer_id NOT IN (SELECT customer_id
                            FROM customers 
                            WHERE city LIKE 'London');


/* Create a report that shows all the customers if there are more than 30 orders shipped in London city. */
SELECT c.company_name
FROM customers c
WHERE c.customer_id in (SELECT o.customer_id
						FROM orders o
						WHERE o.ship_city like 'London'
						GROUP BY o.customer_id
						HAVING COUNT(o.order_id) > 30);

 /* Create a report that shows all the orders where the employee’s city and order’s ship city are same. */
SELECT o.order_id
, o.employee_id
, o.ship_city
FROM orders o
WHERE o.employee_id IN (SELECT e.employee_id
                        FROM employees e
                        WHERE e.city = o.ship_city);
					