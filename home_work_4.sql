/*Practical tasks*/
/*1. Write a query to get most expense and least expensive Product list (name and unit price).*/

select  p.product_name 
, p.unit_price 
from products p 
where p.unit_price in ((select max(p1.unit_price) from products p1), (select min(p2.unit_price) from products p2));

/*2. Write a query to get Product list (name, unit price) of above average price.*/ 

select  p.product_name 
, p.unit_price 
from products p 
where p.unit_price > (select avg(p1.unit_price) from products p1);

/*3. Write a query to get Product list (name, unit price) of ten most expensive products.*/

select p.product_name
, p.unit_price 
from products p 
order by p.unit_price desc 
limit 10;

/*4. For each employee that served the order (identified by employee_id), calculate a total freight.*/

select o.employee_id 
, sum(o.freight)
from orders o
group by o.employee_id;

/*Home work*/
/*1. Write a query to get Product name and quantity/unit. */

select p.product_name
, p.units_in_stock 
from products p; 

/*2. Write a query to get current Product list (Product ID and name).*/

select p.product_id 
, p.product_name
from products p;

/*3. Write a query to get discontinued Product list (Product ID and name).*/

select p.product_id 
, p.product_name
from products p
where p.discontinued > 0;

/*4. Write a query to get most expense and least expensive Product list (name and unit price). */

select  p.product_name 
, p.unit_price 
from products p 
where p.unit_price in ((select max(p1.unit_price) from products p1), (select min(p2.unit_price) from products p2));

/*5. Write a query to get Product list (id, name, unit price) where current products cost less than $20.*/

select p.product_id 
, p.product_name
, unit_price 
from products p
where p.unit_price < 20;

/*6. Write a query to get Product list (id, name, unit price) where products cost between $15 and $25.*/

select p.product_id 
, p.product_name
, unit_price 
from products p
where p.unit_price between 15 and 25;
 
/*7. Write a query to get Product list (name, unit price) of above average price.*/

select product_id
, product_name 
, unit_price 
from products
where unit_price > (select avg(unit_price) from products);

/*8. Write a query to get Product list (name, unit price) of ten most expensive products.*/

select p.product_name
, p.unit_price 
from products p 
order by p.unit_price desc
limit 10;

/*9. Write a query to count current and discontinued products.*/

select count(product_id) as current_products
, sum(p.discontinued) as discontinued_products
from products p;


/*10. Write a query to get Product list (name, units on order , units in stock) of stock is less than the quantity on order.*/

select p.product_name 
, p.units_on_order 
, p.units_in_stock 
from products p 
where p.units_in_stock < p.units_on_order;
