--Write a query to get Product name and quantity/unit.
select
	p.product_name 
,	p.quantity_per_unit
from
	products p;

--Write a query to get current Product list (Product ID and name).
select
	p.product_id 
,	p.product_name
from
	products p;

--Write a query to get discontinued Product list (Product ID and name).
select
	p.product_id 
,	p.product_name
from
	products p
where
	p.discontinued = 1;

--Write a query to get most expense and least expensive Product list (name and unit price).
select
	p.product_name 
,	p.unit_price
from
	products p
where
	p.unit_price = (
	select
		max(unit_price)
	from
		products)
union
select
	p.product_name 
,	p.unit_price
from
	products p
where
	p.unit_price = (
	select
		min(unit_price)
	from
		products);
	
--Write a query to get Product list (id, name, unit price) where current products cost less than $20. 
select
	p.product_id 
,	p.product_name 
,	p.unit_price
from
	products p
where
	p.unit_price < 20;

--Write a query to get Product list (id, name, unit price) where products cost between $15 and $25. 
select
	p.product_id 
,	p.product_name 
,	p.unit_price
from
	products p
where
	p.unit_price between 15 and 25;

--Write a query to get Product list (name, unit price) of above average price. 
select
	p.product_name 
,	p.unit_price
from
	products p
where
	p.unit_price > (
	select
		avg(unit_price)
	from
		products);
	
--Write a query to get Product list (name, unit price) of ten most expensive products. 
select
	p.product_name 
,	p.unit_price
from
	products p
order by
	p.unit_price desc
limit 10;

--Write a query to count current and discontinued products. 
select
	(select
		count(p.product_id)
	from
		products p
	where
		p.discontinued = 1) as amount_dicd_prod
,	(select
		count(p.product_id)
	from
		products p
	where
		p.discontinued = 0) as amount_non_dicd_prod;
		
--Write a query to get Product list (name, units on order , units in stock) of stock is less than the quantity on order. 
select
	p.product_name 
,	p.units_on_order 
,   p.units_in_stock 
from
	products p
where 
	p.units_in_stock < p.units_on_order;