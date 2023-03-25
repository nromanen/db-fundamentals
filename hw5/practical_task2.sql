-- 1. Show first and last names of
--     the employees as well as the count of orders each of them have received during the year 1997

select e.first_name, e.last_name, count(o.employee_id)
from employees e
         inner join orders o on e.employee_id = o.employee_id
where extract(year from o.order_date) = 1997
group by e.employee_id;

-- 2. Show first and last names of the employees as well as the count of their orders shipped after required date during the year 1997.

select e.first_name, e.last_name, count(o.employee_id)
from employees e
         inner join orders o on e.employee_id = o.employee_id
where extract(year from o.order_date) = 1997
  and o.shipped_date > o.required_date
group by e.employee_id;

-- 3. Create a report showing the information about employees and orders, when ever they had orders or not.

select e.first_name, e.last_name, order_id
from employees e
         left join orders o on e.employee_id = o.employee_id
order by o.order_id;