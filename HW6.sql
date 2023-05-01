/* Show the total ordering sum calculated for each country of customer. */
SELECT c.country AS country,
  SUM((od.unit_price * od.quantity)*(1 - od.discount)) AS total_order_sum
FROM customers c 
INNER JOIN orders o ON c.customer_id = o.customer_id
INNER JOIN order_details od ON o.order_id = od.order_id 
GROUP BY 1
ORDER BY 2 DESC;

/* Show the list of product categories along with total ordering sums calculated for the orders made for the products of each category, during the year 1997. */
SELECT c.category_name,
  SUM((od.unit_price * od.quantity)*(1 - od.discount)) AS total_order_sum
FROM orders o 
INNER JOIN order_details od ON o.order_id = od.order_id
INNER JOIN products p ON od.product_id = p.product_id
INNER JOIN categories c ON p.category_id = c.category_id
WHERE DATE_PART('Year', o.order_date) = 1997
GROUP BY 1
ORDER BY 1;

/* Show the list of product names along with unit prices and the history of unit prices taken from the orders
  (show ‘Product name – Unit price – Historical price’). The duplicate records should be eliminated.
  If no orders were made for a certain product, then the result for this product should look like 
  ‘Product name – Unit price – NULL’. Sort the list by the product name.
 */

SELECT DISTINCT 
	product_name, 
	p.unit_price, 
	od.unit_price AS historical_price
FROM products p LEFT JOIN order_details od 
ON p.product_id = od.product_id
ORDER BY 1;

/* Moodle tasks for Module 06. COMPLICATED REPORTS */
/*Show the list of french customers’ names who used to order non-french products (use left join).*/

SELECT DISTINCT  c.contact_name 
FROM customers c 
LEFT JOIN orders o ON c.customer_id = o.customer_id 
LEFT JOIN order_details od ON o.order_id  = od.order_id 
LEFT JOIN products p ON od.product_id = p.product_id 
LEFT JOIN suppliers s ON p.supplier_id  = s.supplier_id  
WHERE c.country  LIKE 'France%' AND s.country <> c.country;

/*Show the list of french customers’ names who used to order french products. The list should be ordered in ascending order.*/
SELECT DISTINCT  c.contact_name 
FROM customers c 
LEFT JOIN orders o ON c.customer_id = o.customer_id 
LEFT JOIN order_details od ON o.order_id  = od.order_id 
LEFT JOIN products p ON od.product_id = p.product_id 
LEFT JOIN suppliers s ON p.supplier_id  = s.supplier_id  
WHERE c.country  LIKE 'France%' AND s.country = c.country
ORDER BY 1;

/*
Show the total ordering sum calculated for each country where orders were shipped.
While calculating the sum take into account the value of the discount (Discount).
*/
SELECT o.ship_country 
, ROUND(SUM(od.unit_price  * od.quantity  * (1- od.discount))::numeric, 2) AS total_sum_by_country
FROM orders o 
INNER JOIN order_details od ON o.order_id  = od.order_id
GROUP BY 1
ORDER BY 1;

/*
Show the list of product categories along with total ordering sums (considering Discount) 
calculated for the orders made for the products of each category, during the year 1997.
and then rounded to 2 decimal signs.
*/
SELECT c.category_name
, ROUND(SUM(od.unit_price  * od.quantity  * (1- od.discount))::numeric, 2) AS total_order_sum
FROM orders o 
INNER JOIN order_details od ON o.order_id = od.order_id
INNER JOIN products p ON od.product_id = p.product_id
INNER JOIN categories c ON p.category_id = c.category_id AND DATE_PART('Year', o.shipped_date) = 1997
GROUP BY 1
ORDER BY 1;

/*
Show the list of product names along with unit prices and the history of unit prices taken from the orders
(show ‘Product name – Unit price – Historical price’). The duplicate records should be eliminated. 
If no orders were made for a certain product, then the result for this product should look like ‘Product name – Unit price – NULL’.
 Sort the list by the product name.
*/
SELECT DISTINCT p.product_name 
, p.unit_price  AS unit_price
, od.unit_price AS historical_price
FROM products p 
LEFT JOIN order_details od ON p.product_id  = od.product_id 
ORDER BY 1;

/*Show the list of employees’ names along with names of their chiefs (use left join with the same table).*/
SELECT e1.last_name 
, e1.first_name 
, e2.last_name AS chief_last_name
, e2.first_name AS chief_first_name 
FROM employees e1 
LEFT JOIN employees e2 ON e1.reports_to  = e2.employee_id 
ORDER BY 1;

/*Show the list of cities where employees and customers are from. Duplicates should be eliminated.*/
SELECT DISTINCT * 
FROM (
    SELECT e.city
    FROM employees e
    UNION
    SELECT c.city
    FROM customers c
) AS cities
ORDER BY 1;





