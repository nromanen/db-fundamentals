--1. Show the lists the suppliers with a product price equal to 10$.

select s.contact_name 
from suppliers s 
where s.supplier_id in (select p.supplier_id 
						from products p
						where p.unit_price = 10);
						
--2. Show the list of employee that perform orders with freight 1000.
					
select e.first_name 
, e.first_name 
from employees e 
where e.employee_id in (select o.employee_id 
						from orders o 
						where o.freight = 1000);
						
--3. Find the Companies that placed orders in 1997.
					
select c.company_name  
from customers c 
where c.customer_id in (select o.customer_id 
						from orders o
						where extract(year from o.order_date) = 1997);
					
--4. Create a report that shows all products by name that are in the Seafood category.
					
select p.product_name 
from products p 
where p.category_id in (select c.category_id 
						from categories c
						where c.category_name like 'Seafood');
					
--5. Create a report that shows all companies by name that sell products in the Dairy Products category.
					
select s.company_name 
from suppliers s 
where s.supplier_id in (select p.supplier_id 
						from products p
						inner join categories c on p.category_id = c.category_id 
						and c.category_name like 'Dairy Products');

