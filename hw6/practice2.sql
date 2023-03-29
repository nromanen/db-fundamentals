/*1. Show the count of orders made by each customer from France.*/

select c.contact_name
, count(o.order_id)
from customers c 
left join orders o on c.customer_id = o.customer_id 
where c.country like 'France'
group by c.contact_name;

/*2. Show the list of French customers’ names who have made more than one order.*/

select c.contact_name
from customers c 
left join orders o on c.customer_id = o.customer_id 
group by c.contact_name 
having count(o.order_id) > 1; 