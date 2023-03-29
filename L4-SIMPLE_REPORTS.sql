--Practice
--Write a query to get most expense and least expensive Product list (name and unit price).
select product_name
, unit_price
from products
order by unit_price;

--Write a query to get Product list (name, unit price) of above average price
select product_name
, unit_price
from products
where unit_price > (select avg(unit_price) from products);

--Write a query to get Product list (name, unit price) of ten most expensive products.
select product_name, unit_price 
from products
order by unit_price desc
limit 10;

--For each employee that served the order (identified by employee_id), calculate a total freight.
select o.employee_id, e.first_name, e.last_name, sum(freight) as sum_freight 
from employees e
inner join orders o on e.employee_id = o.employee_id
group by o.employee_id, e.first_name, e.last_name;


--Calculate the greatest, the smallest and the average age among the employees from London.
select min(date_part('year', CURRENT_DATE) - date_part('year', birth_date)) as min_age
, max(date_part('year', CURRENT_DATE) - date_part('year', birth_date)) as max_age
, ROUND(avg(date_part('year', CURRENT_DATE) - date_part('year', birth_date))) as avg_age
from employees
where city = 'London';
--select (SELECT min(date_part('year', CURRENT_DATE) - date_part('year', birth_date)) from employees) as min_age
--, (SELECT max(date_part('year', CURRENT_DATE) - date_part('year', birth_date)) from employees) as max_age
--, (SELECT ROUND(avg(date_part('year', CURRENT_DATE) - date_part('year', birth_date))) from employees) as avg_age;


--Show the list of cities in which the average age of employees is greater than 60 (the average age is also to be shown)
select city, avg(date_part('year', CURRENT_DATE) - date_part('year', birth_date)) as avg_age 
from employees
group by city having avg(date_part('year', CURRENT_DATE) - date_part('year', birth_date)) > 60;

--Show the first and last name(s) of the eldest employee(s).
select first_name || ' ' || last_name as full_name
, date_part('year', CURRENT_DATE) - date_part('year', birth_date) as age
from employees e 
order by birth_date;

--Show first, last names and ages of 3 eldest employees.
select first_name || ' ' || last_name as full_name
, date_part('year', CURRENT_DATE) - date_part('year', birth_date) as age
from employees e 
order by birth_date
limit 3;

-----------------------------------------------------------------------------------
--HOME WORK
--Write a query to get Product name and quantity/unit.
select product_name, quantity_per_unit from products;

--4. Write a query to get most expense and least expensive Product list (name and unit price). 
select product_name, unit_price from products
where product_id in ((select product_id from products order by unit_price limit 1)
, (select product_id from products order by unit_price desc limit 1));

--5. Write a query to get Product list (id, name, unit price) where current products cost less than $20. 
select product_id, product_name, unit_price from products
where unit_price < 20;

--8. Write a query to get Product list (name, unit price) of ten most expensive products. 
select product_name, unit_price from products
order by unit_price desc limit 10;

--9. Write a query to count current and discontinued products. 
select count(product_id), discontinued  from products
group by discontinued;

--10. Write a query to get Product list (name, units on order , units in stock) of stock is less than the quantity on order.
select product_name, unit_price, units_in_stock  from products
where units_in_stock < units_on_order;

