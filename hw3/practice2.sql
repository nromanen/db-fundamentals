/*1. Show all info about the employee with ID 8.*/

select *
from employees
where employee_id = 8;

/*2. Show the list of first and last names of the employees from London.*/

select first_name, last_name
from employees
where city like 'London';

/*3. Show the list of first, last names and ages of the employees whose age is greater than 55.*/

select first_name, last_name, (extract (year from current_date) - extract(year from birth_date))
from employees
where  (extract (year from current_date) - extract(year from birth_date)) > 55;

/*4. Show the list of products with the price between 10 and 50.*/

select product_name, unit_price 
from products
where unit_price between 10 and 50;