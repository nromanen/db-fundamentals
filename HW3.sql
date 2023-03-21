-- Retrieve all first names from employees
select first_name 
from employees;
-- Retrieve all cities where orders were shipped
select ship_city
from orders;
-- Get all orders sorted by ship country
select *
from orders
order by ship_country;
-- Get all orders sorted by supplier_id in descending order
select *
from orders
order by customer_id desc;
-- Get products from category with max average price
select product_name
, category_id 
, unit_price
from products p
where category_id = (
select category_id
from products p 
group by category_id
order by avg(unit_price) desc limit 1
);
-- Get three categories with the largest quantity of products in stock
select
	category_name
from
	categories c
where
	category_id in (
	select
		category_id
	from
		products p
	order by
		units_in_stock desc
	limit 3
)
--Get count of unique ship_name for each ship country in orders  table
