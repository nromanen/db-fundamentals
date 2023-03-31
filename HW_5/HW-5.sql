--Show first and last names of the employees who used to serve orders shipped to Madrid. The result set would be ordered by first name.

select distinct  first_name 
, last_name 
from employees e 
left join orders o on e.employee_id =o.employee_id 
where o.ship_city = 'Madrid'
order by first_name;

select distinct  FirstName 
, LastName 
from Employees e 
left join Orders o on e.employeeid =o.employeeid 
where o.ShipCity = 'Madrid'
order by FirstName;

-- Write the query, which will show the first and last names of the employees (whether they served orders or not) as well as the count of orders (CountOfOrders) where served by each of them. 
--Note. Use LEFT JOIN

select first_name
, last_name 
, count(o.order_id) as CountOfOrders
from employees e 
left join orders o on e.employee_id = o.employee_id
group by e.employee_id
order by first_name;

select FirstName
, LastName 
, count(o.orderid) as CountOfOrders
from Employees e 
left join Orders o on e.employeeid = o.employeeid
group by e.employeeid
order by FirstName;

-- Show first and last names of the employees as well as the count of their orders shipped after required date during the year 1997 (use left join).
select first_name 
, last_name 
, count(o.order_id) as CountOfOrders
from employees e 
left join Orders o on e.employee_id = o.employee_id
and extract (year from o.required_date) = 1997 and   o.shipped_date > o.required_date 
group by e.employee_id
order by first_name;

SELECT FirstName
, LastName 
, count(o.orderid) AS CountOfOrder
FROM Employees e 
LEFT JOIN Orders o ON e.employeeid = o.employeeid
AND strftime('%Y-%m-%d', o.orderdate) like '1997%' AND   o.ShippedDate > o.RequiredDate
GROUP BY e.employeeid
ORDER BY FirstName;

--Show category names (without duplicates) of products that where ordered by customers that are located  in Madrid
select distinct category_name 
from categories c 
inner join products p on c.category_id =p.category_id 
inner join order_details od on p.product_id =od.product_id 
inner  join orders o on od.order_id = o.order_id 
inner join customers c2 on o.customer_id = c2.customer_id 
where c2.city  = 'Madrid'

select distinct categoryname as Name
from categories c 
inner join products p on c.categoryid =p.categoryid 
inner join [order details] od on p.productid =od.productid 
inner join orders o on od.orderid = o.orderid 
inner join customers c2 on o.customerid = c2.customerid 
where c2.city  = 'Madrid'

-- Show the list of french customers’ names who have made more than one order (use grouping).

select contact_name 
, count(o.customer_id)
from customers c 
inner join orders o on c.customer_id = o.customer_id
where country like 'Fr%'
group by c.contact_name
having count(o.customer_id) > 1
order by contact_name 

SELECT ContactName 
, count(o.customerid) AS CountOfOrder
FROM customers c 
INNER JOIN orders o ON c.customerid = o.customerid
WHERE country like 'Fr%'
GROUP BY c.ContactName
HAVING count(o.customerid) > 1
ORDER BY ContactName;


