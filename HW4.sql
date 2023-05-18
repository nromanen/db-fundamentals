--1. Write a query to get Product name and quantity/unit.
select p.product_name 
, p.quantity_per_unit 
from products p 

--2. Write a query to get current Product list (Product ID and name).
select p.product_id 
, p.product_name  
from products p 

--3. Write a query to get discontinued Product list (Product ID and name).
select p.product_id 
, p.product_name
from products p 
where p.discontinued = 1 

--4. Write a query to get most expense and least expensive Product list (name and unit price).
--Most expensive
select p.product_name 
, p.unit_price 
from products p 
order by p.unit_price desc
limit 1
--Least expensive
select p.product_name 
, p.unit_price 
from products p 
order by p.unit_price asc
limit 1

--5. Write a query to get Product list (id, name, unit price) where current products cost less than $20.
select p.product_id 
, p.product_name 
, p.unit_price 
from products p
where p.discontinued <> 1 and p.unit_price < 20 

--6. Write a query to get Product list (id, name, unit price) where products cost between $15 and $25.
select p.product_id 
, p.product_name 
, p.unit_price 
from products p
where p.unit_price between 15 and 25

--7. Write a query to get Product list (name, unit price) of above average price.
select p.product_name 
, p.unit_price 
from products p
group by product_id 
having p.unit_price > avg(p.unit_price)

--8. Write a query to get Product list (name, unit price) of ten most expensive products.
select p.product_name 
, p.unit_price 
from products p
order by p.unit_price desc
limit 10

--9. Write a query to count current and discontinued products.
--discontinued
select count(p.product_id)
from products p
where p.discontinued = 1
--current
select count(p.product_id)
from products p
where p.discontinued = 0

--10. Write a query to get Product list (name, units on order , units in stock) of stock is less than the quantity on order.
select p.product_name 
, p.units_on_order 
, p.units_in_stock 
from products p 
where p.units_in_stock < p.units_on_order 