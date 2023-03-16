--Retrieve all first names from employees
select distinct first_name 
from employees;

--Retrieve all cities where orders were shipped
select distinct ship_city 
from orders
order by ship_city;

--Get all orders sorted by ship country
select order_id, ship_country 
from orders
order by ship_country;

--Get all orders sorted by supplier_id in descending order
select od.order_id, p.product_id, p.supplier_id 
from order_details od left join products p 
on od.product_id = p.product_id
order by p.supplier_id desc;

--Get products from category with max average price
select c_max_p.*,
	p.product_id,
	p.product_name,
	p.unit_price
from (select category_id, 
			avg(unit_price) as avg_price
		from products
		group by category_id
		order by avg_price desc
		limit 1) as c_max_p 
	left join products p 
	on c_max_p.category_id = p.category_id;

--Get three categories with the largest quantity of products in stock
select category_id, sum(units_in_stock) as total_quantity
from products 
group by category_id 
order by total_quantity desc
limit 3;

--Get count of unique ship_name for each_ship country in orders table
select ship_country, count(distinct ship_name) as count_of_ship_name 
from orders
group by ship_country;