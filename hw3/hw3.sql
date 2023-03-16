/*1. Retrieve all first names from employees*/

select first_name
from employees;

/*2. Retrieve all cities where orders were shipped*/

select ship_city
from orders;

/*3. Get all orders sorted by ship country*/

select order_id, ship_country
from orders
order by ship_country;

/*4. Get all orders sorted by supplier_id in descending order*/

select orders.order_id, suppliers.supplier_id
from orders, suppliers
order by suppliers.supplier_id desc;

/*5. Get products from category with max average price*/

select category_id, product_name, unit_price
from products
where category_id = (select category_id
from products 
group by category_id 
order by avg(unit_price) desc limit 1);

/*6. Get three categories with the largest quantity of products in stock*/

select category_id, sum(units_in_stock)
from products
group by category_id
order by sum(units_in_stock) desc  limit 3;