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

/* From slides */

--1.	Show the list of products which names start form ‘N’ and price is greater than 50.
select product_name, unit_price 
from products p 
where product_name like 'N%' and unit_price > 20

--2.	Show the total number of employees which live in the same city.
select city, count(*)
from employees e 
group by city 

--3.	Show the list of suppliers which name begins with letter ‘A’  and are situated in London.
select company_name
from suppliers s
where company_name like 'A%' and city = 'London'

--4.	Calculate the count of customers from Mexico and contact signed as ‘Owner’.
select customer_id, company_name, city 
from customers c 
where city like 'M%xico%' 
