-- 1. Show employees (first and last name) working with orders from the United States

select e.first_name, e.last_name
from employees e
where e.employee_id = any (select e.employee_id
                           from employees e
                                    inner join orders o on e.employee_id = o.employee_id
                           where o.ship_country like 'USA');


-- 2. Show the info about orders, that contain the cheapest products from USA

select *
from orders o
         inner join order_details od on o.order_id = od.order_id
         inner join products p on p.product_id = od.product_id
where p.unit_price = (select min(p.unit_price)
                      from products p
                      where p.product_id = any (select p.product_id
                                                from products p
                                                         inner join suppliers s on s.supplier_id = p.supplier_id
                                                where s.country like 'USA'));


-- 3. Show the info about customers that prefer to order meat products and never order drinks.

select c.customer_id, c.contact_name
from customers c
         inner join orders o on c.customer_id = o.customer_id
         inner join order_details od on o.order_id = od.order_id
         inner join products p on p.product_id = od.product_id
         inner join categories c2 on c2.category_id = p.category_id
where c2.category_id = any (select c.category_id
                            from products p
                                     inner join categories c on p.category_id = c.category_id
                            where c.category_name like 'Meat/Poultry')
  and c2.category_id != any (select c.category_id
                             from products p
                                      inner join categories c on p.category_id = c.category_id
                             where c.category_name like 'Beverages')
group by c.customer_id, c.contact_name;



-- 4. Show the list of cities where employees and customers are from and where orders have been made to.
-- Duplicates should be eliminated

select e.city
from employees e
union
distinct
select c.city
from customers c
union
distinct
select o.ship_city
from orders o;


--  5. Show the lists the product names that order quantity equals to 100.

select p.product_name
from products p
where p.product_id = any (select p.product_id
                          from orders o
                                   inner join order_details od on o.order_id = od.order_id
                                   inner join products p on p.product_id = od.product_id and od.quantity = 100);




