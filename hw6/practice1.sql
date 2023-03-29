/*1. Show the list of French customers’ names who are working in the same cities.*/

select c.contact_name
, c2.contact_name 
from customers c 
inner join customers c2 on c.customer_id <> c2.customer_id and c.city = c2.city 
where c.country like 'France';

/*2. Show the list of German suppliers’ names who are not working in the same cities.*/

select distinct s.city 
, s.contact_name 
from suppliers s 
where s.country like 'Germany';


