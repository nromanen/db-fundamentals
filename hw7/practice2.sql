--1. Show the name of the category in which the average price of  a certain product is greater than the grand average in the whole stock.

select c.category_name 
from categories c 
inner join products p on c.category_id = p.category_id 
group by c.category_name 
having avg(p.unit_price) > (select avg(p.unit_price)
							from products p);
						
--2. Show the name of the supplier whose delivery  is lower than the grand average in the whole stock.
						
select s.contact_name 
from suppliers s 
inner join products p on s.supplier_id = p.supplier_id 
inner join order_details od on p.product_id = od.product_id 
group by s.contact_name 
having avg(od.quantity) < (select avg(od.quantity) 
						   from order_details od);
						   
--3. Show the regions where employees work, the middle age of which is higher than over the whole company.
						 
select r.region_description 
from region r 
inner join territories t on r.region_id = t.region_id 
inner join employee_territories et on t.territory_id = et.territory_id 
inner join employees e on et.employee_id = e.employee_id 
group by r.region_description 
having avg(extract(year from age(e.birth_date))) > (select avg(extract(year from age(e.birth_date)))
													from employees e); 
												
--4. Show customers whose maximum freight level is less than the average for all customers.
												
select c.contact_name 
from customers c 
inner join orders o on c.customer_id = o.customer_id 
group by c.contact_name 
having max(o.freight) < (select avg(o.freight) 
						 from orders o);
						 
--5. Show the categories of products for which the average discount is higher than the average discount for all products.
						
select c.category_name
from categories c 
inner join products p on c.category_id = p.category_id 
inner join order_details od on p.product_id = od.product_id 
group by c.category_name 
having avg(od.discount) > (select avg(od.discount)
						   from order_details od);


