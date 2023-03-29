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



