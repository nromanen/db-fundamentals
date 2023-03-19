select distinct ship_city
from orders;

select *
from orders
order by ship_country;

select *
from orders
order by ship_country;

select c.category_name, avg(unit_price) as avg_price
from products p join categories c 
on p.category_id = c.category_id
group by c.category_name;

select c.category_name
, sum(units_in_stock) as max_quantity
from products p join categories c 
on p.category_id = c.category_id 
group by c.category_name
order by max_quantity desc limit 3;



