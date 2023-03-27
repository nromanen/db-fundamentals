--Create a report showing the first and last name of all sales representatives who are from  Seattle or Redmond.
select first_name 
, last_name 
from employees
where city = 'Redmond' or city = 'Seattle';
-- Create a report that shows the company name, contact title, city and country of all  customers in Mexico or in any city in Spain except Madrid. 
select company_name
, contact_title 
, city
, country 
from customers c 
where country = 'Mexico'
or country = 'Spain'
and city not like 'Madrid'
--Show first and last names of the employees as well as the count of orders each of them have received during the year 1997.
 select first_name 
, last_name
, count(o.order_id) 
from employees e
left join orders o 
on e.employee_id = o.employee_id 
where extract(year from o.shipped_date) = 1997
group by e.first_name, e.last_name 
--Show first and last names of the employees as well as the count of their orders shipped after required date during the year 1997.
select first_name 
, last_name
, count(o.order_id) 
from employees e
left join orders o 
on e.employee_id = o.employee_id 
where extract(year from o.shipped_date) = 1997
and o.required_date < o.shipped_date 
group by e.first_name, e.last_name 
--Create a report showing the information about employees and orders, whenever they had orders or not.
select first_name 
, last_name
, o.order_id 
from employees e 
right join orders o 
on e.employee_id = o.employee_id 
--Show the list of French customers’ names who used to order non-French products.
select
	distinct c.company_name
from
	customers c
join orders o on
	c.customer_id = o.customer_id
join order_details od on
	o.order_id = od.order_id
join products p on
	od.product_id = p.product_id
join suppliers s on
	p.supplier_id = s.supplier_id
where
	c.country = 'France'
	and s.country != 'France'
--Show the list of suppliers, products and its category.
select
	distinct company_name
	, product_name
	, category_name
from
	suppliers s
join products p on
	s.supplier_id = p.supplier_id
join categories c on
	p.category_id = c.category_id
order by
	company_name
--Create a report that shows all  information about suppliers and products. 
select *
from suppliers s
join products p 
on s.supplier_id = p.supplier_id
order by p.supplier_id
