--1. Show employees (first and last name) working with orders from the United States.

select e.first_name 
, e.last_name 
from employees e
where e.employee_id in (select o.employee_id 
						from orders o
						where o.ship_country like 'USA');
						
--2. Show the info about orders, that contain the cheapest products from USA.
					
select o.order_id 
, o.freight 
, o.ship_country 
from orders o 
inner join order_details od on o.order_id = od.order_id 
inner join products p on od.product_id = p.product_id 
where p.unit_price in (select min(p2.unit_price) 
					   from products p2
					   inner join suppliers s on p2.supplier_id = s.supplier_id
					   where s.country like 'USA');
		 			   
--3. Show the info about customers that prefer to order meat products and never order drinks.
					  
select c.contact_name
from customers c
inner join orders o on c.customer_id = o.customer_id 
inner join order_details od on o.order_id = od.order_id 
inner join products p on od.product_id = p.product_id 
inner join categories c2 on p.category_id = c2.category_id 
where c2.category_name = any (select c3.category_name 
						      from categories c3
                              where c3.category_name like 'Meat/Poultry' and c3.category_name not like 'Beverages')
                              group by c.contact_name;

--4. Show the list of cities where employees and customers are from and where orders have been made to. Duplicates should be eliminated.
          
select e.city 
from employees e
where e.city = any(select c.city  
				   from customers c
 				   where c.city = any(select o.ship_city 
									  from orders o))
group by e.city;

--5. Show the lists the product names that order quantity equals to 100.

select p.product_name 
from products p
where p.product_id in (select od.product_id 
					   from order_details od
					   where od.quantity = 100);







