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

-- 1. Show the name of the category in which the average price of a certain product is greater than the grand
-- average in the whole stock.

select c.category_name
from categories c
         join products p on c.category_id = p.category_id
group by c.category_name
having avg(p.unit_price) > (select avg(p.unit_price) from products p);


-- 2. Show the name of the supplier whose delivery is lower then the grand average in the whole stock.

select s.company_name
from suppliers s
         inner join products p on s.supplier_id = p.supplier_id
         inner join order_details od on p.product_id = od.product_id
         inner join orders o on od.order_id = o.order_id
group by s.supplier_id
having avg(o.freight) > (select avg(o.freight) from orders o);


-- 3. Show the regions where employees work, the middle age of which is higher than over the whole company.

select r.region_description
from region r
         inner join territories t on r.region_id = t.region_id
         inner join employee_territories et on t.territory_id = et.territory_id
         inner join employees e on et.employee_id = e.employee_id
group by r.region_description
having avg(age(e.birth_date)) > (select avg(age(e.birth_date)) from employees e);


-- 4. Show customers whose maximum freight level is less than the average for all customers.

select c.company_name
from customers c
         inner join orders o on c.customer_id = o.customer_id
group by c.customer_id
having max(o.freight) < (select avg(o.freight)
                         from orders o);


-- 5. Show the categories of products for which the average discount is higher than the average discount for all
-- products

select c.category_name
from categories c
         inner join products p on c.category_id = p.category_id
         inner join order_details od on p.product_id = od.product_id
group by c.category_id
having avg(od.discount) > (select avg(od.discount) from order_details od);


