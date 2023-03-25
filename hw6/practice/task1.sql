-- 1. Show the list of French customers’ names who are working in the
-- same cities.

select a.company_name, a.city
from customers a
         inner join customers b on a.city like b.city
where a.country like 'France'
order by city;

-- 2. Show the list of German suppliers’ names who are not working in the
-- same cities.

select distinct on (city) city, company_name
from customers
where country like 'Germany';