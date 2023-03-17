select * 
from Employees 
where EmployeeID = 8;

select FirstName, LastName 
from Employees where City like 'London';

select FirstName, LastName 
from Employees 
where FirstName like 'A%'

select COUNT(EmployeeID) as 'COUNT(FirstName)' 
from Employees 
where City like 'London';

--Retrieve all first names from employees
select first_name
from employees;

--Retrieve all cities where orders were shipped
select city
from customers;

--Get all orders sorted by ship country
select *
from orders
order by ship_country;

--Get all orders sorted by supplier_id in descending order
select *
from products
order by supplier_id desc;

--Get products from category with max average price
select *
from products
where category_id = (select category_id
from products
group by category_id
order by avg(unit_price) desc limit 1);

--Get three categories with the largest quantity of products in stock
select c.category_id, c.category_name, sum(units_in_stock) as max
from categories c
         join products p on c.category_id = p.category_id
group by c.category_id, c.category_name
order by max desc
limit 3;
