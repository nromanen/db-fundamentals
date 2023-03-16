/*1. Show the list of products which names start form ‘N’ and price is greater than 50.*/

select product_name, unit_price
from products
where product_name like 'N%' and unit_price > 50;

/*2. Show the total number of employees which live in the same city.*/

select count(employee_id), city
from employees
group by city;

/*3. Show the list of suppliers which name begins with letter ‘A’  and are situated in London.*/

select contact_name, city
from suppliers
where contact_name like 'A%' and city like 'London';

/*4. Show the list of first, last names and ages of the employees whose age is greater than average age of all employees. The result should be sorted by last name.*/

select first_name, last_name, (extract(year from current_date) - extract(year from birth_date)) as age
from employees
where (extract(year from current_date) - extract(year from birth_date)) > (select avg(extract(year from current_date) - extract(year from birth_date)) from employees)
order by last_name;

/*5. Calculate the count of customers from Mexico and contact signed as ‘Owner’.*/

select count(customer_id)
from customers
where city like 'Mexico' and contact_title like 'Owner';
