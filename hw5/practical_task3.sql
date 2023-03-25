-- 1. Show the list of French customers’ names who used to order non-French products.

select distinct c.company_name
from customers c
         inner join orders o on c.customer_id = o.customer_id
         inner join order_details od on o.order_id = od.order_id
         inner join products p on od.product_id = p.product_id
         inner join order_details d on o.order_id = d.order_id
         inner join suppliers s on p.supplier_id = s.supplier_id
where c.country like 'France'
  and s.country not like 'France';


-- 2. Show the list of suppliers, products and its category

select distinct s.company_name, p.product_name, c.category_id
from suppliers s
         inner join products p on s.supplier_id = p.supplier_id
         inner join categories c on c.category_id = p.category_id;


-- 3. Create a report that shows all information about suppliers and products.

select *
from suppliers s full outer join products p on s.supplier_id = p.supplier_id;
