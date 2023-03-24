--Practice
--1. Show the list of French customers’ names who are working in the same cities.
select c1.company_name 
from customers c1, customers c2 
where c1.country = 'France'
and c1.city = c2.city 
and c1.customer_id != c2.customer_id;

--2. Show the list of German suppliers’ names who are not working in the same cities.
--поки не виходить
select s1.supplier_id, s1.company_name, s1.city
, s2.supplier_id, s2.company_name, s2.city 
from suppliers s1
join suppliers s2 on s1.supplier_id = s2.supplier_id 
and s1.country = 'Germany'
and s1.city != s2.city

select * from suppliers s 
where s.country = 'Germany'

--Show the count of orders made by each customer from France
select o.customer_id, count(o.customer_id), c.country  
from orders o, customers c 
where o.customer_id = c.customer_id 
and c.country  = 'France'  
group by o.customer_id, c.country  
















