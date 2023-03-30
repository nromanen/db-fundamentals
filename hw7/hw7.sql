-- 1. Create a report that shows the product name and supplier id for all products supplied by Exotic Liquids,
-- Grandma Kelly's Homestead, and Tokyo Traders.

select p.product_name, s.supplier_id
from products p
         inner join suppliers s on s.supplier_id = p.supplier_id
where s.supplier_id = any (select s.supplier_id
                           from suppliers s
                           where s.company_name in ('Exotic Liquids', 'Grandma Kelly''s Homestead', 'Tokyo Traders'));


-- 2. Create a report that shows all the products which are supplied by a company called ‘Pavlova, Ltd.’.

select p.product_name
from products p
where p.product_id = any (select p.product_id
                          from products p
                                   inner join suppliers s on s.supplier_id = p.supplier_id
                          where s.company_name like 'Pavlova, Ltd.');


-- 3. Create a report that shows the orders placed by all the customers excluding the customers who belongs to
-- London city.

select o.*
from orders o
         inner join customers c on c.customer_id = o.customer_id
where c.customer_id != any (select c.customer_id
                            from customers c
                            where c.city like 'London');


-- 4. Create a report that shows all the customers if there are more than 30 orders shipped in London city.

select c.company_name
from customers c
         inner join orders o on c.customer_id = o.customer_id
group by c.customer_id
having count(o.order_id in (select o.order_id from orders o where o.ship_city like 'London')) > 30;


-- 5. Create a report that shows all the orders where the employee’s city and order’s ship city are same

select *
from orders o
where o.order_id = any (select o2.order_id
                       from employees e
                                inner join orders o2 on e.employee_id = o2.employee_id
                       where e.city like o2.ship_city);