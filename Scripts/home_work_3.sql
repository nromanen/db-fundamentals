/*Part 1*/
/*1. Show all info about company_name and address from the customers table.*/

select c.company_name, c.address
from customers c;

/*2. Show all info about company_name and contact_person from the suppliers table.*/

select s.company_name, s.contact_name
from suppliers s;

/*3. Show all info about product_name and unit_price from the products table.*/

select p.product_name, p.unit_price
from products p;

/*4. Show all info about last_name, first_name, birth_date and hire_date of employees.*/

select e.last_name, e.first_name, e.birth_date, e.hire_date 
from employees e;

/*Part 2*/
/*1. Show all info about the employee with ID 8.*/

select *
from employees e 
where employee_id = 8;

/*2. Show the list of first and last names of the employees from London.*/

select e.first_name, e.last_name 
from employees e 
where city = 'London';

/*3. Show the list of first, last names and ages of the employees whose age is greater than 55. */

select e.first_name, e.last_name, extract(year from current_date) - extract(year from e.birth_date) as age
from employees e
where extract(year from current_date) - extract(year from e.birth_date)  > 55;


/*4. Show the list of products with the price between 10 and 50.*/

select *
from products p 
where unit_price between 10 and 50;

/*Part 3*/
/*1. Show the list of products which names start form ‘N’ and price is greater than 50.*/

select *
from products p 
where p.product_name like 'N%' and p.unit_price > 50;

/*2. Show the total number of employees which live in the same city.*/

select e.city, count(employee_id) 
from employees e 
group by e.city;

/*3. Show the list of suppliers which name begins with letter ‘A’  and are situated in London.*/

select *
from suppliers s 
where company_name like 'A%' and city = 'London';

/*4. Show the list of first, last names and ages of the employees whose age is greater than average age of all employees.
  The result should be sorted by last name.*/

/*5. Calculate the count of customers from Mexico and contact signed as ‘Owner’.*/

select count(customer_id) 
from customers c 
where contact_title = 'Owner';
