--1. Janet Leverling, one of the salespeople, has come to you with a request.
--She thinks that she accidentally double-entered a line item on an order, with a different ProductID, but the same quantity.
--She remembers that the quantity was 60 or more. Show all the OrderIDs that match this, in order of OrderID.

select distinct od1.order_id
from order_details od1
where exists
	(
	select od2.order_id
	from order_details od2
	where od1.order_id = od2.order_id
	    and od1.product_id <> od2.product_id
	    and od1.quantity = od2.quantity
	    and od1.quantity >= 60
	)

------------------------------------------------------------------------------------------

--2. We know that Andrew Fuller is the Vice President of Northwind Company.
--Create the report that shows the list of those employees (last and first name) who were hired earlier than Fuller.

select
	e.last_name
	,e.first_name
from employees e
where e.hire_date <
	(
    select e2.hire_date
    from employees e2
    where e2.last_name = 'Fuller' and e2.first_name = 'Andrew'
	)

------------------------------------------------------------------------------------------

--3. Write the query which should create the list of products and their unit price
--for products with price greater than average products' unit price

select
	p.product_name
	,p.unit_price
from products p
where p.unit_price >
	(
    select avg(p2.unit_price)
    from products p2
	)
order by p.unit_price

------------------------------------------------------------------------------------------

--4. Create the report that should show  the Companies from Germany that placed orders in 2016

select
	c.company_name
from customers c
where c.country = 'Germany' and c.customer_id in
	(
    select o.customer_id
    from orders o
    where extract(year from o.order_date) = '2016'
	)

------------------------------------------------------------------------------------------

--5. Create the query that should show the date when the orders were shipped (alias ShippedDate),
--the number of orders  (NumberOfOrders) and total sum (including discount) of the orders (Total) shipped at this date.
--The report includes only the 1st quarter of 2016 with the number of orders greater than 3.
--The result should be sorted by ShippedDate

with totals as
    (
	select
		od.order_id
		,sum(od.unit_price * od.quantity * (1-od.discount))::numeric(16,2) as total
	from order_details od
	group by od.order_id
	)

select
	o.shipped_date
	,count(*) as number_of_orders
	,sum(t.total) as total
from orders o
join totals t on o.order_id = t.order_id
where o.shipped_date between '2016-01-01' and '2016-03-31'
group by o.shipped_date
having count(*) > 3

------------------------------------------------------------------------------------------

--6. For the category 'Dairy Products' get the list of products sold and the total sales amount including discount
--(alias ProductSales) during the 1st quarter of 2016 year.

select
    'Dairy Products' as category_name
	,p.product_name
	,sum(od.unit_price * od.quantity * (1-od.discount))::numeric(16,2) as product_sales
from orders o
    join order_details od on o.order_id = od.order_id
    join products p on od.product_id = p.product_id
    join categories c on p.category_id = c.category_id
where c.category_name = 'Dairy Products' and o.order_date between '2016-01-01' and '2016-03-31'
group by p.product_name
order by p.product_name

------------------------------------------------------------------------------------------

--7. Andrew, the VP of sales, wants to know the name of the company that placed order 10290.

select c.company_name
from customers c
where customer_id =
	(
	select o.customer_id
	from orders o
	where o.order_id = '10290'
	)

------------------------------------------------------------------------------------------

--8. Some salespeople have more orders arriving late than others. Maybe they're not following up on the order process,
--and need more training. Andrew, the VP of sales, has been doing some more thinking some more about the problem of late orders.
--He realizes that just looking at the number of orders arriving late for each salesperson isn't a good idea.
--It needs to be compared against the total number of orders per salesperson.

with late_orders as
    (
    select employee_id
         ,count(*) as amount
    from orders
    where shipped_date > required_date
    group by employee_id
    )
   ,all_orders as
    (
    select employee_id
         ,count(*) as amount
    from orders
    group by employee_id
    )
select
    e.employee_id
    ,e.last_name
    ,ao.amount as all_orders
    ,lo.amount as late_orders
from employees e
join all_orders ao on ao.employee_id = e.employee_id
join late_orders lo on lo.employee_id = e.employee_id

------------------------------------------------------------------------------------------

--9. We know that Andrew Fuller is the Vice President of Northwind Company.
--Create the report that shows the list of those employees (last and first name) who served more orders than Fuller did.

select e.last_name, e.first_name
from employees e
where (
    select count(*)
    from orders o
    where o.employee_id = e.employee_id
) > (
    select count(*)
    from orders o
    join employees e2 on o.employee_id = e2.employee_id
    where e2.last_name = 'Fuller' and e2.first_name = 'Andrew'
)

------------------------------------------------------------------------------------------

--10. Write the query that should return the EmployeeID,  OrderID, and OrderDate.
--The criteria for the report is that the order must be the last for each employee (maximum OrderDate)

select
    o.employee_id
    ,o.order_id
    ,o.order_date
from orders o
where o.order_date =
    (
    select max(o2.order_date)
    from orders o2
    where o2.employee_id = o.employee_id
    )
order by o.employee_id

------------------------------------------------------------------------------------------
