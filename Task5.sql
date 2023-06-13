---------------------------------------------------------------------------------------------------------------------------------------------
--1
--Here’s a data model of the relationship between Products and Suppliers.
--We’d like to show, for each product, the associated Supplier from Germany and Spain. Show the ProductID, ProductName, and the CompanyName of the Supplier. Sort by ProductID.
--Note. The Join clause is used to join two or more relational database tables together in a logical way. 

select ProductID, ProductName, CompanyName
from Products join Suppliers
on Products.supplierId = Suppliers.supplierId and Suppliers.country in ('Germany', 'Spain')

---------------------------------------------------------------------------------------------------------------------------------------------
--2
--Here’s a data model of the relationship between Orders and Shippers.
--We’d like to show a list of the Orders that were made, including the Shipper that was used. Show the OrderID, OrderDate (date only with alias ShortDate), and CompanyName of the Shipper, and sort by OrderID. Show only those rows with an OrderID of less than 10260.
--Note. Use strftime('%Y-%m-%d', OrderDate) function to extract only date.

select OrderID, strftime('%Y-%m-%d', OrderDate) as ShortDate, CompanyName
from Shippers
join Orders on  ShipperID = ShipVia
and OrderID < 10260

---------------------------------------------------------------------------------------------------------------------------------------------
--3
--We're doing inventory, and need to show information about OrderID, a list of products, and their quantity for orders which were shipped by Leverling Janet with quantities greater than 50.
--The result should be sorted by Quantity.

select O.OrderID, P.ProductName as ProductName
    , OD.Quantity as Quantity
from Employees E
join Orders O on E.EmployeeID = O.EmployeeID
join "Order Details" OD on O.OrderID = OD.OrderID
join Products P on OD.ProductID = P.ProductID
and E.LastName = 'Leverling'
and OD.Quantity > 50
order by OD.Quantity

---------------------------------------------------------------------------------------------------------------------------------------------
--4
--There are some customers who have never actually placed an order. Show these customers.
--Note. One way of doing this is to use a left join, also known as a left outer join.

select CompanyName
from Customers
left join Orders on Customers.CustomerId = Orders.CustomerId
where Orders.CustomerId is Null

---------------------------------------------------------------------------------------------------------------------------------------------
--5
--One employee (Margaret Peacock, EmployeeID 4) has placed the most orders. However, there are some customers who've never placed an order with her. 
--Show only those customers who have never placed an order with her.

select CompanyName
from Customers
left join Orders
on Customers.CustomerID = Orders.CustomerID
and Orders.EmployeeID = 4
where Orders.OrderID is null

---------------------------------------------------------------------------------------------------------------------------------------------
--6
--We want to send all of our high-value customers a special VIP gift. 
--We're defining high-value customers as those who've made at least 1 order with a total value 
--(not including the discount) equal to $10,000 or more. We only want to consider orders made in the year 2016.
--Use the alias TotalOrderAmount for the calculated column. Order by the total amount of the order, in descending order.

select C.CustomerID
    , C.CompanyName
    , OD.OrderID
    , sum(OD.UnitPrice * OD.Quantity) as TotalOrderAmount
from Orders O
join Customers C
on O.CustomerID = C.CustomerID
and strftime('%Y', O.OrderDate) = '2016'
join "Order Details" OD
on O.OrderID = OD.OrderID
group by O.OrderID
having TotalOrderAmount >= 10000
order by TotalOrderAmount desc

---------------------------------------------------------------------------------------------------------------------------------------------
--7
--We want to send all of our high-value customers a special VIP gift. We're defining high-value customers as those who have orders 
--totaling $15,000 or more in 2016 (not including the discount). 
--Use the alias TotalOrderAmount for the calculated column. Order by the total amount of the order, in descending order.

select C.CustomerID, C.CompanyName,
    sum(OD.UnitPrice * OD.Quantity) as TotalOrderAmount
from Orders O
join "Order Details" OD on O.OrderID = OD.OrderID
and strftime('%Y', O.OrderDate) = '2016'
join Customers C on O.CustomerID = C.CustomerID
group by C.CustomerID
having TotalOrderAmount >= 15000
order by TotalOrderAmount desc

---------------------------------------------------------------------------------------------------------------------------------------------
--8
--We want to send all of our high-value customers a special VIP gift. We're defining high-value customers as orders totaling $15,000 or more in 2016.  
--The result set should include the column TotalOrderAmount with the total sum not including the discount, and the column 
--TotalWithDiscount with the total sum including the discount.
--Order by TotalOrderAmount in descending order.

select C.CustomerID, C.CompanyName,
    sum(OD.UnitPrice * OD.Quantity) as TotalOrderAmount,
    round(sum(OD.UnitPrice * OD.Quantity * (1 - OD.Discount)), 2) as TotalWithDiscount
from Orders O
join "Order Details" OD on O.OrderID = OD.OrderID
and strftime('%Y', O.OrderDate) = '2016'
join Customers C on O.CustomerID = C.CustomerID
group by C.CustomerID
having TotalWithDiscount > 15000
order by TotalOrderAmount desc

---------------------------------------------------------------------------------------------------------------------------------------------
--9
--The Northwind mobile app developers are testing an app that customers will use to show orders. In order to make sure that even the largest orders will 
--show up correctly on the app, they'd like some samples of orders that have lots of individual line items. Show the 10 orders with the most line items, 
--in order of total line items.

select O.OrderID, count(OD.ProductID) as TotalOrderLines
from Orders O
join "Order Details" OD
on O.OrderID = OD.OrderID
group by O.OrderID
order by TotalOrderLines desc
limit 10

---------------------------------------------------------------------------------------------------------------------------------------------
--10
--Some salespeople have more orders arriving late than others. Maybe they're not following up on the order process, and need more training. 
--Which salespeople have the most orders arriving late?

select O.EmployeeID, E.LastName
    ,count(O.EmployeeID) as TotalLateOrders
from Orders O
join Employees E on O.EmployeeID = E.EmployeeID
where O.ShippedDate > O.RequiredDate
group by O.EmployeeID
order by TotalLateOrders desc, E.EmployeeID


























































