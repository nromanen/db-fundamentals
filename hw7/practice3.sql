--1. Calculate the average freight of all employees who work not with Western region.

select avg(o.freight) 
from orders o 
where o.employee_id in (select e.employee_id 
						from employees e 
						inner join employee_territories et on et.employee_id = e.employee_id 
						inner join territories t on et.territory_id = t.territory_id 
						inner join region r on t.region_id = r.region_id 
						where r.region_description not like 'Western');
						
--2. Show first and last names of employees who shipped orders in cities of USA.
					
select e.first_name 
, e.last_name 
from employees e
where e.employee_id in (select o2.employee_id 
						from orders o2 
						where o2.ship_country like 'USA');
						
--3. Show the names of products and their total cost, which were delivered by German suppliers.
					
select p.product_name 
, round(sum(od.unit_price*od.quantity))  as "total cost"
from products p 
inner join order_details od on p.product_id = od.product_id 
and p.supplier_id in (select s.supplier_id 
					  from suppliers s
				      where s.country like 'Germany')
group by p.product_name;

--4. Show first and last names of employees that don’t work with Eastern region.

select e.first_name
, e.last_name 
from employees e 
where e.employee_id in (select e.employee_id 
						from employees e 
						inner join employee_territories et on et.employee_id = e.employee_id 
						inner join territories t on et.territory_id = t.territory_id 
						inner join region r on t.region_id = r.region_id 
						where r.region_description not like 'Eastern');
						
--5. Show the name of customers that prefer to order non-domestic products.
					
select c.contact_name
from customers c 
where c.country not in (select s2.country 
						from suppliers s2);


