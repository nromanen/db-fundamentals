/*Retrieve all first names from employees*/
select first_name from employees;

/*Retrieve all cities where orders were shipped*/
select ship_city from orders;

/*Get all orders sorted by ship country*/
select order_id, ship_country from orders order by ship_country;

/*Get all orders sorted by supplier_id in descending order*/
select order_id, customer_id from orders order by customer_id desc;

/*Get products from category with max average price*/
select category_id, product_name, unit_price
from products
where category_id = (select category_id
from products 
group by category_id 
order by avg(unit_price) desc limit 1);

/*Get three categories with the largest quantity of products in stock*/
select c.category_id, c.category_name, sum(units_in_stock) as total_quantity
from categories c
join products p on c.category_id = p.category_id
group by c.category_id, c.category_name
order by total_quantity desc
limit 3;