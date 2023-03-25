-- 1. Show the count of orders made by each customer from France.
select distinct c.company_name, count(o.order_id) as count_of_orders
from customers c
         inner join orders o on c.customer_id = o.customer_id
where c.country like 'France'
group by c.company_name;


-- 2. Show the list of French customers’ names who have made more than one order.
select distinct c.company_name, count(o.order_id) as count_of_orders
from customers c
         inner join orders o on c.customer_id = o.customer_id
where c.country like 'France'
group by c.company_name
having count(o.order_id) > 1;
