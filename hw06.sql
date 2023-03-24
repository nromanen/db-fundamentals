/*HW6*/
/*Task1
 * Given the Northwind database (see the structure below).
 * Show the list of french customers’ names who used to order non-french products (use left join).
*/

SELECT DISTINCT c.contact_name  
FROM customers c 
LEFT JOIN orders o 
ON c.customer_id = o.customer_id  
JOIN order_details od 
ON o.order_id = od.order_id 
JOIN products p 
ON od.product_id = p.product_id  
JOIN suppliers s 
ON s.supplier_id = p.supplier_id  
WHERE c.country = 'France' AND s.country != c.country;

/*Task2
 * Given the Northwind database (see the structure below).
 * Show the list of french customers’ names who used to order french products.
*/
SELECT DISTINCT c.contact_name
FROM customers  c 
JOIN orders o 
ON c.customer_id = o.customer_id  
JOIN order_details od 
ON o.order_id = od.order_id 
JOIN products p 
ON od.product_id = p.product_id  
JOIN suppliers s 
ON s.supplier_id = p.supplier_id  
WHERE c.country = 'France' AND s.country = c.country;

/*Task3
 * Given the Northwind database (see the structure below).
 * Show the total ordering sum calculated for each country where orders were shipped.
*/
SELECT o.ship_country  
, SUM(od.unit_price * od.quantity * (1 - od.discount))::numeric(10,2) as sum
FROM orders o 
JOIN order_details od 
ON o.order_id = od.order_id 
GROUP BY o.ship_country;

/*Task4
 * Given the Northwind database (see the structure below).
 * Show the list of product categories along with total ordering sums calculated for 
 * the orders made for the products of each category, during the year 1997.
*/
SELECT c.category_name  
, SUM(od.unit_price * od.quantity * (1 - od.discount))::numeric(10,2) as sum
FROM orders o 
JOIN order_details od 
ON o.order_id = od.order_id 
JOIN products p 
ON od.product_id = p.product_id 
JOIN categories c 
ON p.category_id  = c.category_id  
where extract('year' from o.shipped_date) = 1997
GROUP BY c.category_id ;

/*Task 5
 * Given the Northwind database (see the structure below).
Show the list of product names along with unit prices and the history of unit prices taken from the orders 
(show ‘Product name – Unit price – Historical price’). The duplicate records should be eliminated. 
If no orders were made for a certain product, then the result for this product should look like ‘Product name – Unit price – NULL’.
 Sort the list by the product name.
*/

select DISTINCT p.product_name 
, p.unit_price 
, od.unit_price as historical_price
from order_details od 
join products p 
on od.product_id =p.product_id 
order by p.product_name;

/*Task 6
 * Given the Northwind database (see the structure below).
 * Show the list of employees’ names along with names of their chiefs (use left join with the same table).*/

SELECT e.last_name 
, e.first_name 
, e2.last_name as chief_last_name
, e2.first_name as chief_first_name
from employees e 
LEFT JOIN employees e2 
ON e.reports_to = e2.employee_id;

/*Task 7
 * Given the Northwind database (see the structure below).
 * Show the list of cities where employees and customers are from and where orders have 
 * been made to. Duplicates should be eliminated
*/
select DISTINCT e.city 
from employees e 
union 
select DISTINCT c.city 
from 
customers c 
union
select DISTINCT o.ship_city  
FROM orders o 
where o.ship_city != 'Colchester'

/** Classroom task*/
select '1' as "#",
'Only abroad' as where_customer_buy
,count(c.customer_id)
from customers c
where c.customer_id not in (select distinct c.customer_id
from customers c 
join orders o 
on o.customer_id = c.customer_id 
join order_details od 
on o.order_id = od.order_id 
join products p 
on od.product_id = p.product_id 
join suppliers s 
on p.supplier_id = s.supplier_id 
where c.country = s.country)
union
select '2' as "#",
'Only local' as where_customer_buy
,count(c.customer_id)
from customers c
where c.customer_id not in (select distinct c.customer_id
from customers c 
join orders o 
on o.customer_id = c.customer_id 
join order_details od 
on o.order_id = od.order_id 
join products p 
on od.product_id = p.product_id 
join suppliers s 
on p.supplier_id = s.supplier_id 
where c.country != s.country)
union
select '3' as "#",
'Anywhere' as where_customer_buy
,count(c.customer_id)
from customers c
where c.customer_id in (select distinct c.customer_id
from customers c 
join orders o 
on o.customer_id = c.customer_id 
join order_details od 
on o.order_id = od.order_id 
join products p 
on od.product_id = p.product_id 
join suppliers s 
on p.supplier_id = s.supplier_id 
where c.country = s.country)
and c.customer_id in (select distinct c.customer_id
from customers c 
join orders o 
on o.customer_id = c.customer_id 
join order_details od 
on o.order_id = od.order_id 
join products p 
on od.product_id = p.product_id 
join suppliers s 
on p.supplier_id = s.supplier_id 
where c.country != s.country)
order by "#";
