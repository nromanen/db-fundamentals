-- Retrieve all first names from employees
select first_name 
from employees;

-- Retrieve all cities where orders were shipped

select distinct ship_city 
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
, avg(unit_price)
from products p, categories c 
where p.category_id = c.category_id 
group by p.product_name 
order by avg(unit_price) desc
limit 1;

-- Get three categories with the largest quantity of products in stock

select c.category_name 
, count(units_in_stock) 
from products p, categories c
where p.category_id = c.category_id
group by c.category_name
order by count(units_in_stock) desc 
limit 3;

-- Get count of unique ship_name for each ship country in orders  table

select count(distinct ship_name), ship_country
from orders
group by ship_country;
