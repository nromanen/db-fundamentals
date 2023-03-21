--Practice
--Show first and last names of the employees as well as the count 
--of orders each of them have received during the year 1997.
select e.first_name, e.last_name, count(o.order_id) as count_orders_in_1997y
from employees e join orders o on e.employee_id = o.employee_id
where date_part('year', o.order_date) = 1997
group by e.employee_id;


--Show first and last names of the employees as well as the count of their orders 
--shipped after required date during the year 1997
select e.first_name, e.last_name, count(o.order_id) as count_orders_in_1997y
from employees e join orders o on e.employee_id = o.employee_id
where date_part('year', o.order_date) = 1997 and shipped_date > required_date
group by e.employee_id;

--Create a report showing the information about employees and orders, 
--whenever they had orders or not.
select first_name, last_name, o.order_id from employees e
left join orders o on e.employee_id = o.employee_id 

--Show the list of suppliers, products and its category.
select s.company_name, p.product_name, c.category_name  
from products p 
join suppliers s on s.supplier_id = p.supplier_id 
join categories c on c.category_id = p.category_id 
