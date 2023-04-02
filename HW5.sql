--1. Show the list of French customers’ names who used to order non-French products.
select distinct c.company_name
from customers c
join orders o on c.customer_id = o.customer_id
join order_details od on o.order_id = od.order_id
join products p on od.product_id = p.product_id
join suppliers s on p.supplier_id = s.supplier_id
where c.country = 'France' and s.country <> 'France';

--2. Show the list of suppliers, products and its category.
select s.supplier_id, s.company_name, p.product_name, c.category_name
from products p 
join suppliers s on s.supplier_id = p.supplier_id 
join categories c on p.category_id = c.category_id 

--3. Create a report that shows all  information about suppliers and products.   
select distinct *
from products p 
join suppliers s on p.supplier_id = s.supplier_id 
