--Q1
--Janet Leverling, one of the salespeople, has come to you with a request. She thinks that she accidentally double-entered a 
--line item on an order, with a different ProductID, but the same quantity. She remembers that the quantity was 60 or more. 
--Show all the OrderIDs that match this, in order of OrderID.
--
----SQLite
--select distinct od.orderid
--from "order details" od
--where od.orderid in (
--        select od2.orderid
--        from "order details" od2
--        where od.quantity >= 60
--        and od.quantity = od2.quantity
--        and od.productid <> od2.productid
--        )
--order by od.orderid

select distinct od.order_id
from order_details od 
where od.order_id in (
        select od2.order_id
        from order_details od2
        where od.quantity >= 60
        and od.quantity = od2.quantity
        and od.product_id <> od2.product_id
        )
order by od.order_id

--Q2
--We know that Andrew Fuller is the Vice President of Northwind Company. Create the report that shows the list of those employees 
--(last and first name) who were hired earlier than Fuller.
--
----SQLite
--select e1.LastName, e1.FirstName
--from employees e1
--where e1.LastName <> 'Fuller'
--and e1.HireDate <= (select e2.hiredate
--                        from employees e2
--                        where e2.LastName = 'Fuller'
--                        )

select e1.last_name, e1.first_name
from employees e1
where e1.last_name <> 'Fuller'
and e1.hire_date <= (select e2.hire_date
                        from employees e2
                        where e2.last_name = 'Fuller'
                        )

--Q3
--Write the query which should create the list of products and their unit price for products with price greater than average products' unit price
--
----SQLite
--select p1.productname, p1.unitprice
--from products p1
--where p1.unitprice >= (select avg(p2.unitprice)
--                        from products p2)
--order by p1.unitprice

select p1.product_name, p1.unit_price
from products p1
where p1.unit_price >= (select avg(p2.unit_price)
                        from products p2)
order by p1.unit_price


--Q4
--Create the report that should show  the Companies from Germany that placed orders in 2016
--
----SQLite
--select c.companyname
--from customers c
--where c.country = "Germany"
--and c.customerid in (select o.customerid
--                        from orders o
--                        where strftime('%Y', o.orderdate) = '2016'
--                        )

select c.company_name
from customers c
where c.country = 'Germany'
and c.customer_id in (select o.customer_id
                        from orders o
                        where extract(year from o.order_date) = 1997
                        )

--Q5
--Create the query that should show the date when the orders were shipped (alias ShippedDate),  the number of orders  
--(NumberOfOrders) and total sum (including discount) of the orders (Total) shipped at this date.  
--The report includes only the 1st quarter of 2016 with the number of orders greater than 3.
--The result should be sorted by ShippedDate
--
----SQLite
--select o.shippeddate
--    , (select count(o2.orderid)
--        from orders o2 
--        where o.shippeddate = o2.shippeddate
--        ) as NumberOfOrders
--    , (select round(sum(od.unitprice * od.quantity * (1 - od.discount)), 2)
--        from "order details" od
--        join orders o3 on o3.orderid = od.orderid
--        where o.shippeddate = o3.shippeddate
--        ) as Total
--from orders o
--where o.shippeddate between '2016-01-01' and '2016-03-31'
--and NumberOfOrders > 3
--group by o.shippeddate

select o.shipped_date
    , (select count(o2.order_id)
        from orders o2 
        where o.shipped_date = o2.shipped_date
		) as NumberOfOrders
    , (select round(sum(od.unit_price::numeric * od.quantity::numeric * (1 - od.discount::numeric)), 2)
        from order_details od
        join orders o3 on o3.order_id = od.order_id
        where o.shipped_date = o3.shipped_date
        ) as Total
from orders o
where o.shipped_date between '1997-01-01' and '1997-03-31'
and (select count(o2.order_id)
        from orders o2 
        where o.shipped_date = o2.shipped_date
        ) > 3
group by o.shipped_date

--Q6
--For the category 'Dairy Products' get the list of products sold and the total sales amount including discount 
--(alias ProductSales) during the 1st quarter of 2016 year. 
--
----SQLite
--select c.categoryname
--        , p.productname
--        , sum(round(od.unitprice * od.quantity * (1-od.discount),2 )) as ProductSales
--from categories c join products p on c.categoryid = p.categoryid
--and c.categoryname = 'Dairy Products'
--join "order details" od on od.productid = p.productid 
--join orders o on o.orderid = od.orderid
--and o.orderdate between '2016-01-01' and '2016-03-31'
--group by p.productname

select c.category_name
        , p.product_name
        , sum(round(od.unit_price::numeric * od.quantity::numeric * (1-od.discount::numeric),2 )) as ProductSales
from categories c join products p on c.category_id = p.category_id
and c.category_name = 'Dairy Products'
join order_details od on od.product_id = p.product_id 
join orders o on o.order_id = od.order_id
and o.order_date between '1997-01-01' and '1997-03-31'
group by p.product_name, c.category_name

--Q7
--Andrew, the VP of sales, wants to know the name of the company that placed order 10290.
--
----SQLite
--select c.companyname
--from customers c
--where c.customerid = (
--    select o.customerid
--    from orders o
--    where o.orderid = 10290)
    
select c.company_name
from customers c
where c.customer_id = (
    select o.customer_id
    from orders o
    where o.order_id = 10290)

--Q8
--Some salespeople have more orders arriving late than others. Maybe they're not following up on the order process, and need more training. 
--Andrew, the VP of sales, has been doing some more thinking some more about the problem of late orders. He realizes that just looking at 
--the number of orders arriving late for each salesperson isn't a good idea. It needs to be compared against the total number of orders per salesperson.
--
----SQLite
--select e.employeeid
--    , e.lastname
--    , (select count(o.orderid) 
--    from orders o
--    where e.employeeid = o.employeeid) as AllOrders 
--    , (select count(o.orderid)
--    from orders o
--    where o.shippeddate >= o.requireddate
--    and e.employeeid = o.employeeid) as LateOrders
--from employees e
--where LateOrders <> 0

select e.employee_id
    , e.last_name
    , (select count(o.order_id) 
    from orders o
    where e.employee_id = o.employee_id) as AllOrders 
    , (select count(o.order_id)
    from orders o
    where o.shipped_date >= o.required_date
    and e.employee_id = o.employee_id) as LateOrders
from employees e

--Q9
--We know that Andrew Fuller is the Vice President of Northwind Company. Create the report that shows the list of those employees (last and first name) 
--who served more orders than Fuller did.
--
----SQLite
--select e.lastname
--    , e.firstname
--from employees e
--where e.employeeid in (
--    select o.employeeid
--    from orders o
--    group by o.employeeid
--    having count(o.orderid) > (
--        select count(o2.orderid)
--        from orders o2
--        where o2.employeeid in (
--            select e.employeeid
--            from employees e
--            where e.lastname = 'Fuller'
--        )
--    )
--)

select e.last_name
    , e.first_name
from employees e
where e.employee_id in (
    select o.employee_id
    from orders o
    group by o.employee_id
    having count(o.order_id) > (
        select count(o2.order_id)
        from orders o2
        where o2.employee_id in (
            select e.employee_id
            from employees e
            where e.last_name = 'Fuller'
        )
    )
)

--Q10
--Write the query that should return the EmployeeID,  OrderID, and OrderDate. 
--The criteria for the report is that the order must be the last for each employee (maximum OrderDate) 
--
----SQLite
--select o.employeeid
--    , (select o2.orderid
--        from orders o2
--        group by o2.employeeid
--        having o.employeeid = o2.employeeid and max(o2.orderdate)
--        ) as OrderID
--    , (select o3.orderdate
--        from orders o3
--        group by o3.employeeid
--        having o.employeeid = o3.employeeid and max(o3.orderdate)
--        ) as OrderDate
--from orders o
--group by o.employeeid

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