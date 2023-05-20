--1. Write a query to get most expense and least expensive Product list (name and unit price).
select p.product_name, p.unit_price  
from products p
where p.unit_price = (select max(p.unit_price) from products p) or p.unit_price = (select min(p.unit_price) from products p)

--2. Write a query to get Product list (name, unit price) of above average price.
select p.product_name, p.unit_price  
from products p
where p.unit_price > (select avg(p.unit_price) from products p)

--3. Write a query to get Product list (name, unit price) of ten most expensive products.
select p.product_name, p.unit_price 
from products p 
order by p.unit_price
desc limit 10

--4. For each employee that served the order (identified by employee_id), calculate a total freight.
select employee_id, sum(o.freight) as total_freight
from orders o
group by employee_id



--1. Calculate the greatest, the smallest and the average age among the employees from London.
select max(extract (year from age(birth_date))) as biggest, 
	   min(extract (year from age(birth_date))) as smallest,
	   avg(extract (year from age(birth_date))) as average    
from employees e
where city = 'London'

--2. Calculate the greatest, the smallest and the average age of the employees for each city.
select max(extract (year from age(birth_date))) as biggest, 
	   min(extract (year from age(birth_date))) as smallest,
	   avg(extract (year from age(birth_date))) as average,
	   city
from employees e
group by city

--3. Show the list of cities in which the average age of employees is greater than 60 (the average age is also to be shown)
select city, avg(extract (year from age(birth_date))) as average
from employees e
where (select avg(extract (year from age(birth_date))) as average from employees e) > 60
group by city

--4. Show the first and last name(s) of the eldest employee(s).
select first_name, last_name, max(extract (year from age(birth_date))) as biggest   
from employees e
where extract (year from age(birth_date)) = (select max(extract (year from(age(birth_date)))) from employees e) 
group by first_name, last_name

--5. Show first, last names and ages of 3 eldest employees.
select first_name, last_name, max(extract (year from age(birth_date))) as biggest_ages
from employees e
group by first_name, last_name
order by max(extract (year from age(birth_date))) desc
limit 3



--1. Write a query to get Product name and quantity/unit.
select p.product_name, p.quantity_per_unit 
from products p

--2. Write a query to get current Product list (Product ID and name).
select p.product_id, p.product_name 
from products p 

--3. Write a query to get discontinued Product list (Product ID and name).
select p.product_id, p.product_name, p.discontinued 
from products p 

--4. Write a query to get most expense and least expensive Product list (name and unit price).
select p.product_name, p.unit_price  
from products p
where p.unit_price = (select max(p.unit_price) from products p) or p.unit_price = (select min(p.unit_price) from products p)

--5. Write a query to get Product list (id, name, unit price) where current products cost less than $20.
select p.product_id, p.product_name, p.unit_price  
from products p
where p.unit_price < 20

--6. Write a query to get Product list (id, name, unit price) where products cost between $15 and $25.
select p.product_id, p.product_name, p.unit_price  
from products p
where p.unit_price between 15 and 25

--7. Write a query to get Product list (name, unit price) of above average price.
select p.product_name, p.unit_price  
from products p
where p.unit_price > (select avg(p.unit_price) from products p)

--8. Write a query to get Product list (name, unit price) of ten most expensive products.
select p.product_name, p.unit_price 
from products p 
order by p.unit_price
desc limit 10

--9. Write a query to count current and discontinued products.
select sum(p.units_in_stock) as stock, sum(p.discontinued) as discontinued
from products p

--10. Write a query to get Product list (name, units on order , units in stock) of stock is less than the quantity on order.
select p.product_name, p.units_on_order, p.units_in_stock 
from products p 
where p.units_in_stock < p.units_on_order 
