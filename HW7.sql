/*
 * Create a report that shows the product name and supplier id for all products supplied by Exotic Liquids, 
 * Grandma Kelly's Homestead, and Tokyo Traders.
 * */
select
	p.product_name 
,	p.supplier_id
from
	products p
where
	p.supplier_id IN (
	select
		s.supplier_id 
	from
		suppliers s
	where
		s.company_name in ('Exotic Liquids', 'Grandma Kelly''s Homestead', 'Tokyo Traders'));
		
/**
 * Create a report that shows all the products which are supplied by a company called ‘Pavlova, Ltd.’.
 */
select
	p.product_name 
from
	products p
where
	p.supplier_id = (
	select
		s.supplier_id 
	from
		suppliers s
	where
		s.company_name = 'Pavlova, Ltd.');
		
/*
 * Create a report that shows the orders placed by all the customers excluding the customers who belongs to London city.
 **/
select 
		o.order_id
from 
		orders o
where
	o.customer_id in (
	select
		c.customer_id
	from
		customers c
	where
		c.city not like 'London');
	
/*
 * Create a report that shows all the customers if there are more than 30 orders shipped in London city.
 * */
select
	cust.contact_name
from
	customers cust
where
	cust.customer_id in 
	(select
		distinct c.customer_id
	from
		customers c
	inner join orders o on
		c.customer_id = o.customer_id
	where
		o.ship_city like 'London');

	
/*
 * Create a report that shows all the orders where the employee’s city and order’s ship city are same.
 * */
select o.order_id 
from employees e 
inner join orders o on e.employee_id = o.employee_id 
where e.city = o.ship_city;