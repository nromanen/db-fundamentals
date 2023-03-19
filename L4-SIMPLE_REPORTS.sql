--Write a query to get most expense and least expensive Product list (name and unit price).
select product_name
, unit_price
from products
order by unit_price;

--Write a query to get Product list (name, unit price) of above average price
select product_name
, unit_price
from products
where unit_price > (select avg(unit_price) from products);

--Write a query to get Product list (name, unit price) of ten most expensive products.
select product_name, unit_price 
from products
order by unit_price desc
limit 10;

--For each employee that served the order (identified by employee_id), calculate a total freight.
select o.employee_id, e.first_name, e.last_name, sum(freight) as sum_freight 
from employees e
inner join orders o on e.employee_id = o.employee_id
group by o.employee_id, e.first_name, e.last_name;













