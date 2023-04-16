--1. Create a report that shows the product name and supplier id for all products supplied by Exotic Liquids, Grandma Kelly's Homestead, and Tokyo Traders.

select p.product_name 
, s.supplier_id
from products p 
inner join suppliers s on p.supplier_id = s.supplier_id 
where s.supplier_id in (select s2.supplier_id 
						from suppliers s2
						where s2.company_name in ('Exotic Liquids', 'Grandma Kelly_s Homestead', 'Tokyo Traders'));
		 				
--2. Create a report that shows all the products which are supplied by a company called ‘Pavlova, Ltd.’.
					
select p.product_name 
from products p 
where p.supplier_id in (select s.supplier_id 
						from suppliers s
						where s.company_name like 'Pavlova, Ltd.');
						
--3. Create a report that shows the orders placed by all the customers excluding the customers who belongs to London city.
				
select o.order_id 
from orders o 
where o.customer_id in (select c.customer_id 
						from customers c
						where c.city not like 'London');
					
--4. Create a report that shows all the customers if there are more than 30 orders shipped in London city.
					
select c.company_name 
from customers c 
where c.customer_id in (select o.customer_id 
						from orders o
						where o.ship_city like 'London'
						group by o.customer_id
						having count(o.order_id) > 30);
					
--5. Create a report that shows all the orders where the employee’s city and order’s ship city are same.
					
select o.order_id 
from orders o 
where o.employee_id in (select e.employee_id 
						from employees e
						where e.city like o.ship_city);
