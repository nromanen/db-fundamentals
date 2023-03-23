--1. Show the list of French customers’ names who used to order non-French products.

select distinct c.contact_name 
from customers c 
inner join orders o on o.customer_id = c.customer_id 
inner join order_details od on od.order_id = o.order_id 
inner join products p on p.product_id = od.product_id 
inner join suppliers s on s.supplier_id = p.supplier_id 
where c.city not like 'France' and s.country not like 'France'
order by c.contact_name;

--2. Show the list of suppliers, products and its category.

select s.contact_name 
, p.product_name 
, c.category_name 
from suppliers s 
inner join products p on p.supplier_id = s.supplier_id 
inner join categories c on c.category_id = p.category_id
order by s.contact_name, p.product_name;

--3. Create a report that shows all  information about suppliers and products.

select *
from suppliers s 
full outer join products p on s.supplier_id = p.supplier_id
order by s.supplier_id;
