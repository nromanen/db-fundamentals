/*1. Show all info about company_name and address from the customers table.*/

select company_name, address
from customers;

/*2. Show all info about company_name and contact_person from the suppliers table.*/

select company_name, contact_name 
from suppliers;

/*3. Show all info about product_name and unit_price from the products table.*/

select product_name, unit_price
from products;

/*4. Show all info about last_name, first_name, birth_date and hire_date of employees.*/

select last_name, first_name, birth_date, hire_date
from employees;