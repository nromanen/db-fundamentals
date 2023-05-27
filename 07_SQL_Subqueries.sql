--1. Show first and last names of the employees who have the biggest freight.

select e.first_name
	,e.last_name
from employees as e
where e.employee_id = (
						select o.employee_id
						from orders as o
						order by o.freight
						limit 1
					)
					
--2. Show first, last names of the employees, their freight who have the freight bigger then avarage.
	
select e.first_name
	,e.last_name
	,o.freight
from employees as e
join orders as o
	on o.employee_id = e.employee_id
group by e.last_name, e.first_name, o.freight 
having o.freight > (
						select avg(o2.freight)
						from orders as o2
					)
					
--3. Show the names of products, that have the biggest price.
					
select p.product_name
	,p.unit_price
from products as p
group by p.product_name, p.unit_price 
having p.unit_price >= (
						select max(p2.unit_price) 
						from products as p2
					) 

--4. Show the name of customers with the freight bigger then avarage.
					
select c.company_name
	,o.freight 
from customers as c
join orders as o
	on o.customer_id = c.customer_id
group by c.company_name, o.freight
having avg(o.freight) > (
					select avg(o2.freight) 
					from orders as o2
				)
order by o.freight
					
--5. Show the name of supplier who delivered the cheapest product.

select s.company_name
	,p.unit_price 
from suppliers as s
join products as p 
	on p.supplier_id = s.supplier_id
group by s.company_name, p.unit_price
having  p.unit_price <= (
					select min(p2.unit_price)
					from products as p2
					)
					
					
-- 1. Show the name of the category in which the average price of a certain product is greater than the grand average in the whole stock.
									
select c.category_name 
from categories as c
where (
		select avg(p.unit_price)
		from products as p
		where p.category_id = c.category_id
) > (
	select avg(p2.unit_price)
	from products as p2
)
order by c.category_id
					
-- 2. Show the name of the supplier whose delivery is lower than the grand average in the whole stock.

select s.company_name
from suppliers as s
where (
	select sum(p.units_on_order)
	from products as p
	where p.supplier_id = s.supplier_id
) < (
	select avg(p2.units_on_order)
	from products as p2
)

-- 3. Show the regions where employees work, the middle age of which is higher than over the whole company.

select e.region
	,avg(extract(year from current_date) - extract(year from e.birth_date)) as avg_total
from employees as e
join orders as o
	on o.employee_id = e.employee_id
join customers as c
	on c.customer_id = o.customer_id
group by e.region
having avg(extract(year from current_date) - extract(year from e.birth_date)) > (
	select avg(extract(year from current_date) - extract(year from e2.birth_date))
	from employees as e2
)

-- 4. Show customers whose maximum freight level is less than the average for all customers.


select c.company_name
	,o.freight
from customers as c
join orders as o 
	on o.customer_id = c.customer_id
group by c.company_name, o.freight
having MAX(o.freight) < (
	select avg(o2.freight)
	from orders o2 
)
order by o.freight desc

-- 5. Show the categories of products for which the average discount is higher than the average discount for all products

select p.discontinued 	
from products as p

select c.category_name 
	,od.discount
from categories as c
join products as p
	on p.category_id = c.category_id
join order_details as od
	on od.product_id = p.product_id 
group by c.category_name, od.discount
having avg(od.discount) > (
	select avg(od2.discount)
	from order_details as od2
)
order by od.discount desc