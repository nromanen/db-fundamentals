/*1. Show the list of customers’ names who used to order the ‘Tofu’ product.*/

select distinct c.contact_name
from customers c 
inner join orders o on c.customer_id = o.customer_id 
inner join order_details od on o.order_id = od.order_id 
inner join products p on od.product_id = p.product_id 
where p.product_name like 'Tofu';

/*2. Show the list of French customers’ names who used to order non-French products.*/

select distinct c.contact_name 
from customers c 
inner join orders o on c.customer_id = o.customer_id 
inner join order_details od on o.order_id = od.order_id 
inner join products p on od.product_id = p.product_id
inner join suppliers s on p.supplier_id = s.supplier_id 
where c.country like 'France' and s.country not like 'France';

/*3. Show the list of French customers’ names who used to order French products.*/

select distinct c.contact_name 
from customers c 
inner join orders o on c.customer_id = o.customer_id 
inner join order_details od on o.order_id = od.order_id 
inner join products p on od.product_id = p.product_id
inner join suppliers s on p.supplier_id = s.supplier_id 
where c.country like 'France' and s.country like 'France';