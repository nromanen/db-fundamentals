-- 1.Show first and last names of the employees who have the biggest freight.

select e.first_name, e.last_name, o.freight
from employees e
         join orders o on e.employee_id = o.employee_id
where o.freight = (select max(o.freight)
                   from orders o);


-- 2.Show first, last names of the employees, their freight who have the freight bigger then average

select distinct e.first_name, e.last_name, avg(o.freight)
from employees e
         inner join orders o on e.employee_id = o.employee_id
group by e.employee_id
having avg(o.freight) > (select avg(o.freight) from orders o);



-- 3. Show the names of products, that have the biggest price.

select product_name, unit_price
from products
where unit_price = (select max(unit_price) from products);



-- 4. Show the name of customers with the freight bigger then average.

select c.company_name, round(avg(o.freight) ::numeric, 2)
from customers c
         inner join orders o on c.customer_id = o.customer_id
group by c.customer_id
having avg(o.freight) > (select avg(o.freight) from orders o);



-- 5. Show the name of supplier who delivered the cheapest product.

select s.company_name, p.product_name, p.unit_price
from suppliers s
         inner join products p on s.supplier_id = p.supplier_id
where p.unit_price = (select min(p.unit_price) from products p);

