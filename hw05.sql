/*HW5*/
/*Task from Softserve Academy*/
/*Task 1
 * Given the Northwind database (see the structure below).
 * Show first and last names of the employees who used to serve orders shipped to Madrid. 
 * The result set would be ordered by first name.
 * */
SELECT DISTINCT first_name 
,last_name 
FROM employees e 
NATURAL JOIN orders o 
WHERE o.ship_city LIKE 'Madrid'
ORDER BY first_name;


/*Task 2
 * Given the Northwind database (see the structure below).
 * Write the query, which will show the first and last names of the employees (whether they served orders or not) 
 * as well as the count of orders (CountOfOrders) where served by each of them. 
 * Note. Use LEFT JOIN*/
SELECT first_name
,last_name 
, COUNT(o.order_id) as count_of_Orders 
FROM employees e 
LEFT JOIN orders o ON e.employee_id = o.employee_id  
GROUP BY first_name, last_name
ORDER BY first_name;


/*Task 3 Given the Northwind database (see the structure below).
 * Show first and last names of the employees as well as the count of their orders 
 * shipped after required date during the year 1997 (use left join).
 * */
SELECT e.first_name 
, e.last_name 
, COUNT(o.order_id) AS count_of_order
FROM employees  e 
LEFT JOIN orders o ON (e.employee_id = o.employee_id
AND  o.shipped_date > o.required_date AND extract('year' from o.order_date) = 1997)
GROUP BY e.employee_id
ORDER BY e.first_name;

/*Task 4
 * Given the Northwind database (see the structure below).
 * Show first and last names of the employees who used to serve orders shipped to Madrid.
 * */
SELECT DISTINCT first_name 
,last_name 
FROM employees e 
NATURAL JOIN orders o 
WHERE o.ship_city LIKE 'Madrid'
ORDER BY first_name;

/*Task 5
 * Given the Northwind database (see the structure below).
 * Show the list of french customers’ names who have made more than one order (use grouping).
*/
SELECT c.contact_name  
, COUNT(o.order_id) as count_of_order
FROM customers c 
NATURAL JOIN orders o
WHERE c.country LIKE 'France'
GROUP BY c.customer_id 
HAVING COUNT(o.order_id) > 1
ORDER BY c.contact_name

/*
 * Classroom task
 * Print product name or product names with the maximum sum of the absolute values 
 * of the differences between unit price in product table and unit prices in order details table */

select p.product_id 
, p.product_name 
, c.difference::numeric(10,2)
from products p 
join (select p.product_id 
,sum(abs(od.unit_price - p.unit_price )) as difference
from  order_details od 
join products p 
on od.product_id = p.product_id 
group by p.product_id) as c 
on p.product_id = c.product_id
where c.difference = (select sum(abs(od.unit_price - p.unit_price ))
from  order_details od 
join products p 
on od.product_id = p.product_id 
group by p.product_id 
order by sum(abs(od.unit_price - p.unit_price )) desc 
limit 1)
