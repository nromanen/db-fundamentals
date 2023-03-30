-- 1. Calculate the average freight of all employees who work not with Western region.

select e.last_name, e.first_name, round(avg(o.freight)::numeric, 2)
from employees e
         join orders o on e.employee_id = o.employee_id
    and e.employee_id not in (select e.employee_id
                              from employees e
                                       join employee_territories et on e.employee_id = et.employee_id
                                       join territories t on et.territory_id = t.territory_id
                                       join region r on t.region_id = r.region_id
                              where r.region_description like 'Western')
group by o.employee_id, e.last_name, e.first_name;


-- 2. Show first and last names of employees who shipped orders in cities of USA.

select distinct e.first_name, e.last_name
from employees e
         inner join orders o on e.employee_id = o.employee_id
where o.ship_city in
      (select o.ship_city
       from employees e
                inner join orders o on e.employee_id = o.employee_id
       where o.ship_country like 'USA');


-- 3. Show the names of products and their total cost, which were delivered by German suppliers

select p.product_name, p.unit_price
from products p
         inner join suppliers s on p.supplier_id = s.supplier_id
where s.supplier_id in (select s.supplier_id
                        from suppliers s
                        where s.country like 'Germany');


-- 4. Show first and last names of employees that don’t work with Eastern region.

select distinct e.first_name, e.last_name
from employees e
         join orders o on e.employee_id = o.employee_id
    and e.employee_id not in (select e.employee_id
                              from employees e
                                       join employee_territories et on e.employee_id = et.employee_id
                                       join territories t on et.territory_id = t.territory_id
                                       join region r on t.region_id = r.region_id
                              where r.region_description like 'Eastern');



-- 5. Show the name of customers that prefer to order non-domestic products.
-- select

select c.contact_name
from customers c
         inner join orders o on c.customer_id = o.customer_id
         inner join order_details od on o.order_id = od.order_id
         inner join products p on od.product_id = p.product_id
         inner join suppliers s on p.supplier_id = s.supplier_id
where c.country not in (select s.country from suppliers s)
group by c.customer_id;



