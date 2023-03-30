-- 1. Show the lists the suppliers with a product price equal to 10$.

select s.supplier_id, s.contact_name, s.company_name
from suppliers s
where supplier_id = any (select s.supplier_id
                         from suppliers s
                                  inner join products p on s.supplier_id = p.supplier_id
                         where p.unit_price = 10);


-- 2. Show the list of employee that perform orders with freight 1000.

select e.employee_id, e.first_name, e.last_name
from employees e
where e.employee_id = any (select e.employee_id
                           from employees e
                                    inner join orders o on e.employee_id = o.employee_id
                           group by e.employee_id
                           having sum(o.freight) = 1000);


-- 3. Find the Companies that placed orders in 1997

select c.company_name
from customers c
where c.customer_id = any (select c.customer_id
                           from customers c
                                    inner join orders o on c.customer_id = o.customer_id
                           where extract(year from o.order_date) = 1997);


-- 4. Create a report that shows all products by name that are in the Seafood category.

select p.product_name
from products p
where p.product_id = any (select p.product_id
                          from products p
                                   inner join categories c on c.category_id = p.category_id
                          where c.category_name like 'Seafood');


-- 5. Create a report that shows all companies by name that sell products in the Dairy Products category.

select s.company_name
from suppliers s
where s.supplier_id = any (select s.supplier_id
                           from suppliers s
                                    inner join products p on s.supplier_id = p.supplier_id
                                    inner join categories c on c.category_id = p.category_id
                           where c.category_name like 'Dairy Products');