--Show first and last names of the employees who have the biggest freight.
select o.employee_id, e.first_name, e.last_name, avg(o.freight)  
from employees e
join orders o on e.employee_id = o.employee_id
group by o.employee_id
, e.first_name
, e.last_name
having avg(o.freight) > (select avg(freight) from orders)
order by o.employee_id

--Show the name of supplier  who delivered the cheapest product.
select s.supplier_id, s.company_name from suppliers s
join products p on s.supplier_id = p.supplier_id 
where p.unit_price in (
	select unit_price 
	from products p
	order by unit_price
	limit 5
	)
-----------------
--Home Work
--Create a report that shows the product name and supplier id 
--for all products supplied by Exotic Liquids, Grandma Kelly's Homestead, and Tokyo Traders.
--1
SELECT p.product_name, p.supplier_id 
FROM products p 
where p.supplier_id in (
select supplier_id from suppliers s 
where s.company_name in ('Exotic Liquids', 'Grandma Kelly''s Homestead','Tokyo Traders'))

--Create a report that shows all the products which are supplied by a company called ‘Pavlova, Ltd.’.
--2
SELECT p.product_id, p.product_name, p.category_id 
FROM products p 
where p.supplier_id in (
select supplier_id from suppliers s 
where s.company_name = 'Pavlova, Ltd.')

--Create a report that shows the orders placed by all the customers 
--excluding the customers who belongs to London city.
--3
select *
from orders o 
where o.customer_id in (
select customer_id from customers c where c.city != 'London' )

--Create a report that shows all the customers 
--if there are more than 30 orders shipped in London city.
--4
select o2.customer_id, c.company_name, count(o2.order_id) from customers c 
join orders o2 on c.customer_id = o2.customer_id 
where o2.ship_city = 'London'
group by o2.customer_id, c.company_name having count(o2.order_id) > 30









