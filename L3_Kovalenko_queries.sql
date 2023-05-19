-- 1. Show all info about CompanyName and Address from the Customers table.
select company_name, address 
from customers c

-- 2. Show all info about CompanyName and ContactPerson from the Suppliers table.
select company_name, contact_name 
from suppliers s 

-- 3. Show all info about ProductName and UnitPrice from the Products table.
select product_name, unit_price 
from products p 

-- 4. Show all info about LastName, FirstName, BirthDate and HireDate of Employees.
select last_name, first_name, birth_date, hire_date  
from employees e



-- 1. Show all info about the employee with ID 8.
select *
from employees e
where employee_id = 8

-- 2. Show the list of first and last names of the employees from London.
select first_name, last_name 
from employees e
where city in ('London')

-- 3. Show the list of first, last names and ages of the employees whose age is greater than 55.
select first_name, last_name, age(current_date, birth_date) as ages
from employees e
where age(current_date, birth_date) > '55'

-- 4. Show the list of products with the price between 10 and 50.
select product_name, unit_price 
from products p
where unit_price between 10 and 50



-- 1. Show the list of products which names start form ‘N’ and price is greater than 50.
select product_name
from products p 
where product_name like 'C%' and unit_price > 50

-- 2. Show the total number of employees which live in the same city.
select count(employee_id) total_number, city    
from employees e
group by city
having count(employee_id) > 1

-- 3. Show the list of suppliers which name begins with letter ‘E’ and are situated in London. 
select company_name 
from suppliers s 
where company_name like 'E%' and city = 'London' 

-- 4. Calculate the count of customers from Mexico and contact signed as ‘Owner’.
select count(*)
from customers c
where contact_title = 'Owner' and city = 'México D.F.'

