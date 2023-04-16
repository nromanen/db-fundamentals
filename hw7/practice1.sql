--1. Show first and last names of the employees who have the biggest freight.

select e.first_name 
, e.last_name 
from employees e 
inner join orders o on e.employee_id = o.employee_id 
group by e.employee_id 
having sum(o.freight) = (select sum(o.freight) 
						 from orders o 
 						 group by o.employee_id
						 order by sum(o.freight) desc limit 1);
						
--2. Show first, last names of the employees, their freight who have the freight bigger then avarage.
		
select e.first_name 
, e.last_name 
, sum(o.freight)
from employees e 
inner join orders o on e.employee_id = o.employee_id 
group by e.employee_id 
having sum(o.freight) > (select avg(s.sumOfFreight)
					     from (select sum(o.freight) as sumOfFreight 
						       from orders o 
 						       group by o.employee_id) s);
 						      
--3. Show the names of products, that have the biggest price.
 						    
select p.product_name 
from products p 
where p.unit_price = (select max(p2.unit_price) 
				      from products p2  
 				      group by p.product_id);
 				     
--4. Show the name of customers with the freight bigger then avarage.
 				     
select c.contact_name 
from customers c 
inner join orders o on c.customer_id = o.customer_id 
group by c.customer_id 
having sum(o.freight) > (select avg(s.sumOfFreight)
					     from (select sum(o.freight) as sumOfFreight 
						       from orders o 
 						       group by o.customer_id) s);
 						      		      
--5. Show the name of supplier  who delivered the cheapest product.
 						      
select s.contact_name 
from suppliers s 
inner join products p on s.supplier_id = p.supplier_id 
group by p.product_id, s.contact_name  
having  p.unit_price = (select min(p.unit_price)
						from products p); 



						