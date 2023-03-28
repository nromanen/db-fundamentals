/*HW07
 * TASKS FROM SOFTSERVE ACADEMY
 * Task 1
 * Given the Northwind database (see the structure below).
 * Show the list of customers’ names who used to order the ‘Tofu’ product (use a subquery).
*/
SELECT c.contact_name  
FROM customers c 
WHERE c.customer_id  IN (SELECT o.customer_id  
FROM Orders o 
WHERE o.order_id  IN (SELECT od.order_id  
from order_details od 
WHERE od.product_id  in (SELECT p.product_id  
FROM Products p 
WHERE p.product_name = 'Tofu')));

/*
 * Task2
 * Given the Northwind database (see the structure below).
 * Show the list of customers’ names who used to order the ‘Tofu’ product, 
 * along with the total amount of the product they have ordered and with the total sum for ordered product calculated.
 **/
SELECT c.company_name,
SUM (od.quantity) AS amounth,
SUM (od.unit_price*od.quantity *(1-od.discount))::numeric(10,2) AS "sum"
FROM Customers c 
JOIN Orders o 
ON c.customer_id  = o.customer_id  
JOIN order_details od 
ON o.order_id  = od.order_id  
WHERE od.product_id  in (SELECT p.product_id  
FROM Products p 
WHERE p.product_name  = 'Tofu')
GROUP BY c.company_name  
ORDER BY c.company_name  ;

/*
 * Task3
 * Given the Northwind database (see the structure below).
 * Show the list of french customers’ names who used to order non-french products (use a subquery).
 **/
SELECT c.contact_name  
FROM Customers c 
WHERE c.customer_id  IN (SELECT o.customer_id  
FROM Orders o 
WHERE o.order_id  IN (SELECT od.order_id  
FROM order_details od 
WHERE od.product_id  in (SELECT p.product_id  
FROM Products p 
WHERE p.supplier_id  IN (SELECT s.supplier_id  
FROM Suppliers s 
WHERE s.country  != 'France')))) AND c.country = 'France';

/*
 * Task4
 * Given the Northwind database (see the structure below).
 * Show the total ordering sums calculated for each customer’s country for domestic and non-domestic 
 * products separately (e.g.: “France – French products ordered – Non-french products ordered” and so on for each country).
 **/
SELECT o.ship_country
  ,SUM(CASE WHEN s.country = o.ship_country  THEN od.unit_price *od.quantity *(1-od.discount)  END)::numeric(10,2) AS Domestic
  ,SUM(CASE WHEN s.country != o.ship_country  THEN od.unit_price *od.quantity *(1-od.discount) END)::numeric(10,2) AS "Non-domestic"
FROM Orders o 
LEFT JOIN order_details od 
ON o.order_id  = od.order_id  
JOIN Products p 
ON p.product_id  = od.product_id  
JOIN (select * from suppliers s) as s
ON s.supplier_id = p.supplier_id  
GROUP BY o.ship_country ;

/*
 * TASKS FROMM DISCORD */
/*Categories, and the total products in each category*/
select c.category_name 
, count(p.product_id) as products_count
from products p 
join categories c 
on c.category_id = p.category_id 
group by c.category_name; 

/*In the Customers table, show the total number of customers per Country and City. */
select c.country 
, c.city 
, count(c.customer_id)
from customers c 
group by c.country, c.city
order by c.country, c.city;

/*2. Products that need reordering
What products do we have in our inventory that should be reordered? For now, just use the fields UnitsInStock and ReorderLevel, where UnitsInStock is less than the ReorderLevel.
*/
select p.product_name 
, p.units_in_stock 
, p.reorder_level 
from products p
where p.units_in_stock < p.reorder_level ; 

/*3. High freight charges - last year
 * We  want to get the three ship countries with the highest average freight charges. 
 * But instead of filtering for a particular year, we want to use the last 12 months of order data, 
 * using as the end date the last OrderDate in Orders.*/
select o.ship_country 
, AVG(o.freight)::numeric(10,2) AS average_freight
from orders o 
where o.order_date BETWEEN  
    (SELECT MAX(o2.order_date) - interval '1 year' FROM orders o2)
    AND 
    (SELECT MAX(o3.order_date) FROM orders o3)
group by o.ship_country 
order by AVG(o.freight) desc
limit 3;

/*TASKS FROM POWERPOINT
/*Slide 31 Homework
 * Create a report that shows the product name and supplier id for all products supplied by Exotic Liquids, Grandma Kelly's Homestead, and Tokyo Traders.*/
SELECT p.product_name, s.supplier_id
FROM products p
JOIN suppliers s ON p.supplier_id = s.supplier_id
WHERE s.company_name IN ('Exotic Liquids', 'Grandma Kelly''s Homestead', 'Tokyo Traders')


/*Create a report that shows all the products which are supplied by a company called ‘Pavlova, Ltd.’.*/
SELECT * FROM products p
JOIN suppliers s ON p.supplier_id = s.supplier_id
WHERE s.company_name = 'Pavlova, Ltd.';

/*Create a report that shows the orders placed by all the customers excluding the customers who belongs to London city.*/
SELECT o.*
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
WHERE c.city <> 'London';


/*Create a report that shows all the customers if there are more than 30 orders shipped in London city.*/
SELECT c.company_name, COUNT(o.order_id) as num_orders
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
WHERE o.ship_city = 'London'
GROUP BY c.customer_id
HAVING COUNT(o.order_id) > 2;

/*Create a report that shows all the orders where the employee’s city and order’s ship city are same.*/
SELECT o.*
FROM orders o
JOIN employees e
ON o.employee_id = e.employee_id
WHERE e.city = o.ship_city;

/*
 * Classroom task 
 * Given the Northwind database (see the structure below).
 * Show the list of cities where employees and customers are from and where orders have 
 * been made to. Duplicates should be eliminated*/
/*first solution*/
SELECT 
COUNT(CASE WHEN t2.buy_local = 0 AND t2.buy_abroad != 0 THEN c2.customer_id END) AS only_abroad
,COUNT(CASE WHEN t2.buy_local != 0 AND t2.buy_abroad = 0 THEN c2.customer_id END) AS only_local
,COUNT(CASE WHEN t2.buy_local != 0 AND t2.buy_abroad != 0 THEN c2.customer_id END) AS anywhere
FROM customers c2 
JOIN
(SELECT c.customer_id, c.country, 
COUNT(CASE WHEN c.country = s.country THEN c.customer_id END) AS buy_local,
COUNT(CASE WHEN c.country != s.country THEN c.customer_id END) AS buy_abroad
FROM customers c 
JOIN orders o ON o.customer_id = c.customer_id 
JOIN order_details od ON od.order_id = o.order_id 
JOIN products p ON p.product_id = od.product_id 
JOIN suppliers s ON p.supplier_id = s.supplier_id
GROUP BY c.customer_id, c.country) AS t2
ON t2.customer_id = c2.customer_id;

/*Second solution*/
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
where c.country = s.country)
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
