-- Task #1
-- Janet Leverling, one of the salespeople, has come to you with a request. She thinks that she accidentally double-entered 
-- a line item on an order, with a different ProductID, but the same quantity. 
-- She remembers that the quantity was 60 or more. Show all the OrderIDs that match this, in order of OrderID.

select od.OrderID
from 'Order Details' od
where exists (
    select 1
    from 'Order Details' od2
    where od.OrderID = od2.OrderID and od.Quantity >= 60
    and od.Quantity = od2.Quantity
    and od.ProductID <> od2.ProductID
)
group by od.OrderID
order by od.OrderID

-- Task #2
-- We know that Andrew Fuller is the Vice President of Northwind Company. 
-- Create the report that shows the list of those employees 
-- (last and first name) who were hired earlier than Fuller.

select e.LastName
    ,e.FirstName
from Employees e
where e.HireDate < (
    select e1.HireDate
    from Employees e1
    where e1.LastName = 'Fuller' and e1.FirstName = 'Andrew'
)

-- Task #3
-- Write the query which should create the list of products and their 
-- unit price for products with price greater than average products' unit price

select p.ProductName
    ,p.UnitPrice
from Products p
where p.UnitPrice > (
    select avg(p1.UnitPrice)
    from Products p1
)
order by p.UnitPrice

-- Task #4 
-- Create the report that should show  the Companies from Germany that placed orders in 2016

select c.CompanyName
from Customers c
where c.CustomerID in (
    select o.CustomerID
    from Orders o
    where STRFTIME('%Y', o.OrderDate) = '2016'
)
group by c.CustomerID
having c.Country like '%German%'

-- Task #5
-- Create the query that should show the date when the orders were shipped (alias ShippedDate),  
-- the number of orders  (NumberOfOrders) and total sum (including discount) of the orders (Total) shipped at this date.  
-- The report includes only the 1st quarter of 2016 with the number of orders greater than 3.
-- The result should be sorted by ShippedDate

select o.ShippedDate
    ,(select count(o2.OrderID)
        from Orders o2
        where o.ShippedDate = o2.ShippedDate
    ) NumberOfOrders
    ,(select round(SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)), 2)
        from 'Order Details' od
        join Orders o3 on od.OrderID = o3.OrderID
        where o.ShippedDate = o3.ShippedDate
    ) Total
from Orders o
where o.ShippedDate >= '2016-01-01' and o.ShippedDate <= '2016-03-31'
and NumberOfOrders > 3
group by o.ShippedDate

-- Task #6
-- For the category 'Dairy Products' get the list of products sold 
-- and the total sales amount including discount (alias ProductSales) during the 1st quarter of 2016 year. 

select c.CategoryName
    ,p.ProductName
    ,SUM(ROUND(od.UnitPrice * od.Quantity * (1 - od.Discount), 2)) AS ProductSales
from Categories c
join Products p on p.CategoryID = c.CategoryID
join 'Order Details' od on od.ProductID = p.ProductID
join Orders as o on o.OrderID = od.OrderID
where p.CategoryID = (
    select c2.CategoryID
    from Categories c2
    where c2.CategoryName = 'Dairy Products'
) and  o.OrderDate >= '2016-01-01' and o.OrderDate <= '2016-03-31'
group by p.ProductName

-- Task #7
-- Andrew, the VP of sales, wants to know the name of the company that placed order 10290.

select c.CompanyName
from Customers c
where c.CustomerID = (
    select o.CustomerID
    from Orders o
    where o.OrderID = 10290
)

-- Task #8
-- Some salespeople have more orders arriving late than others. Maybe they're not following up on the order process,
-- and need more training. Andrew, the VP of sales, has been doing some more thinking some more about the problem of late orders. 
-- He realizes that just looking at the number of orders arriving late for each salesperson isn't a good idea. 
-- It needs to be compared against the total number of orders per salesperson.

select e.EmployeeID
    ,e.LastName
    ,count(o.OrderID) AllOrders
    ,(
    select count(o2.OrderID)
    from Orders o2
    where o2.RequiredDate <= o2.ShippedDate
    and o2.EmployeeID = e.EmployeeID
    ) LateOrders
from Employees e
join Orders o on o.EmployeeID = e.EmployeeID
group by e.EmployeeID

-- Task #9
-- We know that Andrew Fuller is the Vice President of Northwind Company. 
-- Create the report that shows the list of those employees (last and first name) who served more orders than Fuller did.

select e.LastName
    ,e.FirstName
from Employees e
join (
    select o.EmployeeID
        ,count(*) TotalOrders
    from Orders o
    group by o.EmployeeID
) EmployeeOrders on EmployeeOrders.EmployeeID = e.EmployeeID
join (
    select count(*) TotalFullerOrders
    from Orders o2
    where o2.EmployeeID = (
        select e2.EmployeeID
        from Employees e2
        where e2.LastName = 'Fuller' and e2.FirstName = 'Andrew'
    )
) FullerOrders on EmployeeOrders.TotalOrders > FullerOrders.TotalFullerOrders

-- Task #10
-- Write the query that should return the EmployeeID,  OrderID, and OrderDate. 
-- The criteria for the report is that the order must be the last for each employee (maximum OrderDate)

select ord.EmployeeID
    ,ord.OrderID
    ,ord.OrderDate
from Orders ord
join (select EmployeeID, max(OrderDate) maxOrderDate
 from Orders
group by EmployeeID) o on ord.EmployeeID = o.EmployeeID
and ord.OrderDate = o.maxOrderDate
order by 1
