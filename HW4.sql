
--Write a query to get Product name and quantity/unit. 
select product_name, units_in_stock
from products
order by units_in_stock desc

--Write a query to get current Product list (Product ID and name). 
select product_id, product_name
from products

--Write a query to get discontinued Product list (Product ID and name).
select product_id, product_name
from products 
where discontinued = 1
 
--Write a query to get most expense and least expensive Product list (name and unit price). 
select p.product_id, p.product_name, round(unit_price::numeric, 0)
from products p
order by p.unit_price desc
limit 10

--Write a query to get Product list (id, name, unit price) where current products cost less than $20.
select product_id, product_name, round(unit_price::numeric, 0)
from products 
where unit_price < 20 
order by unit_price desc
limit 20
 
--Write a query to get Product list (id, name, unit price) where products cost between $15 and $25. 
select product_id, product_name, round(unit_price::numeric, 0)
from products 
where unit_price > 15 and unit_price <20
order by unit_price desc

--Write a query to get Product list (name, unit price) of above average price.
select p.product_name, round(p.unit_price::numeric, 0)
from products p
where p.unit_price > (select avg(unit_price) from products )
 
--Write a query to get Product list (name, unit price) of ten most expensive products. 
select product_name, round(unit_price::numeric, 0)
from products 
order by unit_price desc 
limit 10

--Write a query to count current and discontinued products. 
select discontinued, count(*)
from products 
group by discontinued 

--Write a query to get Product list (name, units on order , units in stock) of stock is less than the quantity on order. 
select product_name, units_on_order, units_in_stock, units_on_order - units_in_stock  as the_lack
from products 
where units_in_stock  < units_on_order 
order by (units_in_stock  - units_on_order) asc
