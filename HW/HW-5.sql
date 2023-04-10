---------------------------------------------------------------------------------------------------------------------------------

--Show first and last names of the employees as well as the count of orders each of them have received during the year 1997

select e.last_name , e.first_name, count(e.employee_id)
from employees e left join orders o 
on e.employee_id  = o.employee_id 
where o.order_date > '1997-01-01' and o.order_date < '1997-12-31'
group by 1,2;

--Show first and last names of the employees as well as the count of their orders shipped after required date during the year 1997.    

select e.last_name , e.first_name, count(e.employee_id)
from employees e left join orders o
on e.employee_id = o.employee_id
where o.order_date > '1997-12-31'
group by 1,2;

--Create a report showing the information about employees and orders, whenever they had orders or not.
select e.last_name, e.first_name, count(o.order_id)
from employees e left join orders o
on e.employee_id = o.employee_id
group by 1,2

--Show the list of French customers’ names who used to order non-French products.

select distinct c.contact_name 
from customers c join orders o 
on o.customer_id = c.customer_id 
				 join order_details od
on od.order_id = o.order_id 
				 join products p 
on p.product_id = od.product_id 
				 join suppliers s 
on s.supplier_id = p.supplier_id 
where c.city not like 'France' and s.country not like 'France'
order by c.contact_name;

--Show the list of suppliers, products and its category.

select s.company_name , p.product_name , c.category_name 
from suppliers s join products p 
on s.supplier_id = p.supplier_id
				 join categories c 
on p.category_id = c.category_id 


--Create a report that shows all information about suppliers and products.

select *
from suppliers s join products p 
on s.supplier_id = p.supplier_id 

