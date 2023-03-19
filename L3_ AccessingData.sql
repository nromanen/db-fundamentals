--Show all info about company_name and address from the customers table.
select company_name, address from customers 

--Show all info about the employee with ID 8
select * from employees where employee_id = 8

--Show the list of products with the price between 10 and 50.
select product_id
, product_name
, unit_price 
from products where unit_price between 10 and 50

--Show the list of products which names start form ‘N’ and price is greater than 50.
select product_id
, product_name
, unit_price 
from products 
where product_name like 'N%' and unit_price > 50

--Show the list of first, last names and ages of the employees 
--whose age is greater than average age of all employees. 
--The result should be sorted by last name
select last_name
, first_name
, date_part('year', CURRENT_DATE) - date_part('year', birth_date) as age_empl
from employees
where date_part('year', birth_date) > (select avg(date_part('year', CURRENT_DATE) - date_part('year', birth_date)) from employees)
order by last_name;


--Calculate the count of customers from Mexico and contact signed as ‘Owner’.
select count(*) from customers 
where country  like 'Mexico'
and contact_title like 'Owner';






