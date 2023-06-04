--1.--We’d like to show, for each product, the associated Supplier from Germany and Spain. 
--Show the ProductID, ProductName, and the CompanyName of the Supplier. Sort by ProductID.
--Note. The Join clause is used to join two or more relational database tables together in a logical way.
select p.ProductID, p.ProductName, s.CompanyName 
from Products p
inner join Suppliers s on p.SupplierID = s.SupplierID 
where s.Country in ('Germany', 'Spain')
order by p.ProductID

--2.We’d like to show a list of the Orders that were made, including the Shipper that was used.
--Show the OrderID, OrderDate (date only with alias ShortDate), and CompanyName of the Shipper,
--and sort by OrderID. Show only those rows with an OrderID of less than 10260.
--Note. Use strftime('%Y-%m-%d', OrderDate) function to extract only date.
select o.OrderID, strftime('%Y-%m-%d', OrderDate) as ShortDate, s.CompanyName  
from Orders o
inner join Shippers s on o.ShipVia = s.ShipperID
where OrderID < 10260
order by OrderID

--3.We're doing inventory, and need to show information about OrderID, a list of products,
--and their quantity for orders which were shipped by Leverling Janet with quantities greater than 50.
--The result should be sorted by OrderID.
select o.OrderID, p.ProductName, od.Quantity
from Orders o
inner join "Order Details" od on o.OrderID = od.OrderID
inner join Employees e on o.EmployeeID = e.EmployeeID
inner join Products p on od.ProductID = p.ProductID
where e.LastName = 'Leverling' and e.FirstName = 'Janet' and od.Quantity > 50
order by od.Quantity

--4.There are some customers who have never actually placed an order. Show these customers.
--Note. One way of doing this is to use a left join, also known as a left outer join.
select c.CompanyName
from Customers c
left join Orders o on c.CustomerID = o.CustomerID
where o.CustomerID is NULL 

--5.One employee (Margaret Peacock, EmployeeID 4) has placed the most orders.
--However, there are some customers who've never placed an order with her.
--Show only those customers who have never placed an order with her.
--Note. One way of doing this is to use one type of outer join (left or right).
--Because the filters in the WHERE clause are applied after the results of the JOIN,
--we need the EmployeeID = 4 filter in the JOIN clause, instead of the WHERE clause.
select c.CompanyName
from Customers c
left join Orders o on c.CustomerID = o.CustomerID and EmployeeID = 4
where o.CustomerID is NUll

--6.We want to send all of our high-value customers a special VIP gift.
--We're defining high-value customers as those who've made at least 1 order with a total value
--(not including the discount) equal to $10,000 or more. We only want to consider orders made in the year 2016.
--Use the alias TotalOrderAmount for the calculated column. Order by the total amount of the order, in descending order.
select c.CustomerID, c.CompanyName, o.OrderID, sum(od.UnitPrice * od.Quantity) as TotalOrderAmount
from Orders o
join Customers c on o.CustomerID = c.CustomerID
join "Order Details" od on o.OrderID = od.OrderID
where strftime("%Y", o.OrderDate) = '2016'
group by c.CustomerID, c.CompanyName, o.OrderID
having sum(od.UnitPrice * od.Quantity) >= 10000
order by sum(od.UnitPrice * od.Quantity) desc

--7.We want to send all of our high-value customers a special VIP gift. We're defining high-value customers as those
--who have orders totaling $15,000 or more in 2016 (not including the discount). 
--Use the alias TotalOrderAmount for the calculated column. Order by the total amount of the order, in descending order.
select c.CustomerID
, c.CompanyName
, sum(od.UnitPrice * od.Quantity) as TotalOrderAmount
from Orders o
join Customers c on o.CustomerID = c.CustomerID
left join "Order Details" od on o.OrderID = od.OrderID
where strftime('%Y', o.OrderDate) = '2016'
group by c.CustomerID, c.CompanyName
having sum(od.UnitPrice * od.Quantity) >= 15000
order by sum(od.UnitPrice * od.Quantity) desc 

--8.We want to send all of our high-value customers a special VIP gift. We're defining high-value customers as orders
--totaling $15,000 or more in 2016.  The result set should include the column TotalOrderAmount with the total sum not including
--the discount, and the column TotalWithDiscount with the total sum including the discount.
--Order by TotalWithDiscount in descending order.
--Note. Use ROUND(<value>, 2) function to round up TotalWithDiscount values to the 2nd digit after the decimal point.
select c.CustomerID
, c.CompanyName
, sum(od.UnitPrice * od.Quantity) as TotalOrderAmount
, ROUND(sum(od.UnitPrice * od.Quantity*(1-od.Discount)), 2) as TotalWithDiscount
from Orders o
join Customers c on o.CustomerID = c.CustomerID
join "Order Details" od on o.OrderID = od.OrderID
where strftime('%Y', o.OrderDate) = '2016' 
group by c.CustomerID, c.CompanyName 
having ROUND(sum(od.UnitPrice * od.Quantity*(1-od.Discount)), 2) >= 15000 
order by TotalOrderAmount desc

--9.The Northwind mobile app developers are testing an app that customers will use to show orders.
--In order to make sure that even the largest orders will show up correctly on the app,
--they'd like some samples of orders that have lots of individual line items.
--Show the 10 orders with the most line items, in order of total line items.
--Note. Using Orders and OrderDetails, you'll use Group by and count() functionality. 
--Use the alias TotalOrderLines for the calculated column.
--Use select <body of the select statement> limit 10 ; to limit the number of rows in the result set.
select o.OrderID, count(od.ProductID) as TotalOrderLines
from Orders o
join "Order Details" od on o.OrderID = od.OrderID
group by o.OrderID
order by count(od.ProductID) desc 
limit 10

--10.Some salespeople have more orders arriving late than others. Maybe they're not following up
--on the order process, and need more training. Which salespeople have the most orders arriving late?
--Note. To determine which orders are late, you can use a combination of the RequiredDate and ShippedDate.
--It's not exact, but if ShippedDate is actually after RequiredDate, you can be sure it's late.
--Use the alias TotalLateOrders for the calculated column.
--You'll need to join to the Employee table to get the last name, and also add Count to show the total late orders.
select e.EmployeeID, e.LastName, count(o.OrderID) as TotalLateOrders
from Orders o
join Employees e on o.EmployeeID = e.EmployeeID
where o.RequiredDate < o.ShippedDate
group by e.EmployeeID, e.LastName
order by TotalLateOrders desc


