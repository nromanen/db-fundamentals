
/*------HW3-----*/
/*Task from Softserve Academy site*/
/*
 * Task 1 
 * Given the Northwind database (see the structure below).
 * Show all info about the employee with ID 8.
*/
select *
from employees e 
where employee_id = 8;

/*
 * Task 2
 * Given the Northwind database (see the structure below).
 * Show the list of first and last names of the employees from London.
*/
select first_name, last_name 
from employees e 
where city  = 'London';


/*
 * Task 3
 * Given the Northwind database (see the structure below).
 * Show the list of first and last names of the employees whose first name begins with letter A.
*/
select first_name, last_name 
from employees e 
where first_name  like 'A%';

/*
 * Task 4
 * Given the Northwind database (see the structure below).
 * Calculate the count of employees from London.
*/
select count(*)
from employees e 
where city = 'London';
group by city;


/*Additional tasks*/

/* Retrieve all first names from employees*/
select first_name 
from employees e ;

/*Retrieve all cities where orders were shipped*/
select distinct ship_city 
from orders o ;

/*Get all orders sorted by ship country*/
select ship_country, ship_city, ship_name
from orders o
order by  ship_country ;
/*Get all orders sorted by supplier_id in descending order*/
select employee_id, ship_country, ship_city, ship_name
from orders o
order by employee_id  desc;
/*Get products from category with max average price */
select product_name, category_id
from products
where category_id = (select category_id
from products p 
group by category_id
order by sum(unit_price)/count(unit_price) desc 
limit 1);

/*Get three categories with the largest quantity of products in stock*/
select category_name, sum(units_in_stock) as total_units_in_stock
from products p 
join categories c on p.category_id = c.category_id 
group by c.category_name
order by total_units_in_stock desc
limit 3;


/*Get count of unique ship_name for each ship country in orders  table .*/
select ship_country, ship_name, count(ship_name)  
from orders o 
group by ship_name,ship_country
order by ship_country;
