--1. We have  between Products and Suppliers.
-- We’d like to show, for each product,the associated Supplier from Germany and Spain. 
-- Show the ProductID, ProductName, and the CompanyName of the Supplier. Sort by ProductID.
Note. The Join clause is used to join two or more relational database tables together in a logical way.
select p.ProductID, p.ProductName, s.CompanyName
from Products p
join Suppliers s on p.SupplierID=s.SupplierID
where s.country in ('Germany','Spain')
group by p.ProductID, s.CompanyName
order by p.ProductID

--2. We have between Orders and Shippers.
-- We’d like to show a list of the Orders that were made, including the Shipper that was used.
-- Show the OrderID, OrderDate (date only with alias ShortDate), and CompanyName of the Shipper, and sort by OrderID. Show only those rows with an OrderID of less than 10260.
Note. Use strftime('%Y-%m-%d', OrderDate) function to extract only date.
select o.OrderID, strftime('%Y-%m-%d', o.OrderDate) as ShortDate, s.CompanyName
from Orders o
join Shippers s on s.ShipperID=o.ShipVia
where o.OrderID < 10260
group by o.Orderid, s.CompanyName
order by o.OrderID

--3. We're doing inventory, and need to show information about OrderID, a list of products, 
-- and their quantity for orders which were shipped by Leverling Janet with quantities 
-- greater than 50. The result should be sorted by Quantity.
select o.OrderID, p.ProductName, od.Quantity
from Orders o
left join Employees e on e.EmployeeID = o.EmployeeID
join 'Order Details' od on o.OrderID=od.OrderID
join Products p on od.ProductID=p.ProductID
where od.Quantity > 50 and e.LastName = 'Leverling' 
and e.FirstName = 'Janet'
order by od.Quantity

--4. There are some customers who have never actually placed an order. Show these customers.
-- Note. One way of doing this is to use a left join, also known as a left outer join.
select c.CompanyName
from Customers c
left join Orders o on c.CustomerID = o.CustomerID
where employeeID is null

--5. One employee (Margaret Peacock, EmployeeID 4) has placed the most orders. 
-- However, there are some customers who've never placed an order with her. 
-- Show only those customers who have never placed an order with her.
-- Note. One way of doing this is to use one type of outer join (left or right). 
-- Because the filters in the WHERE clause are applied after the results of the JOIN, 
-- we need the EmployeeID = 4 filter in the JOIN clause, instead of the WHERE clause.
select c.companyname
from customers c 
left outer join orders o on c.customerid=o.customerid and o.employeeid = 4
where o.employeeid is null

--6. We want to send all of our high-value customers a special VIP gift. We're defining 
-- high-value customers as those who've made at least 1 order with a total value 
-- (not including the discount) equal to $10,000 or more. We only want to consider orders 
-- made in the year 2016. Use the alias TotalOrderAmount for the calculated column. 
-- Order by the total amount of the order, in descending order.
select c.CustomerID, c.CompanyName, o.OrderID, sum(od.Unitprice*od.Quantity) as TotalOrderAmount
from Customers c
join Orders o on c.CustomerID=o.CustomerID
join 'Order Details' od on o.OrderID=od.OrderID
where strftime('%Y', OrderDate) = '2016'
group by od.OrderID
having sum(Unitprice*Quantity) >= 10000
Order by TotalOrderAmount desc

--7. We want to send all of our high-value customers a special VIP gift. We're defining 
-- high-value customers as those who have orders totaling $15,000 or more in 2016 
-- (not including the discount). Use the alias TotalOrderAmount for the calculated column. 
-- Order by the total amount of the order, in descending order.
select c.CustomerID, c.CompanyName, round(sum(Unitprice*Quantity),2) as TotalOrderAmount
from Customers c
join Orders o on c.CustomerID=o.CustomerID
join 'Order Details' od on o.OrderID=od.OrderID
where strftime('%Y', OrderDate) = '2016' 
group by c.CustomerID, c.CompanyName 
having round(sum(Unitprice*Quantity),2) >= 15000
Order by TotalOrderAmount desc

--8. We want to send all of our high-value customers a special VIP gift. We're defining 
-- high-value customers as orders totaling $15,000 or more in 2016.  The result set should 
-- include the column TotalOrderAmount with the total sum not including the discount, 
-- and the column TotalWithDiscount with the total sum including the discount.
-- Order by TotalOrderAmount in descending order.
select c.CustomerID, c.CompanyName, round(sum(Unitprice*Quantity),2) as TotalOrderAmount,
round(sum(Unitprice*Quantity*(1 - Discount)),2) as TotalWithDiscount
from Customers c
join Orders o on c.CustomerID=o.CustomerID
join 'Order Details' od on o.OrderID=od.OrderID
where strftime('%Y', OrderDate) = '2016' 
group by c.CustomerID, c.CompanyName 
having round(sum(Unitprice*Quantity*(1 - Discount)),2) >= 15000
Order by TotalOrderAmount desc

--9. The Northwind mobile app developers are testing an app that customers will use to show 
-- orders. In order to make sure that even the largest orders will show up correctly on the 
-- app, they'd like some samples of orders that have lots of individual line items. 
-- Show the 10 orders with the most line items, in order of total line items.
-- Note. Using Orders and OrderDetails, you'll use Group by and count() functionality. 
-- Use the alias TotalOrderLines for the calculated column.
select o.OrderID, count(o.OrderID) as TotalOrderLines
from Orders o
join 'Order Details' od on o.OrderID = od.OrderID
group by o.OrderID
order by TotalOrderLines desc
limit 10

--10. Some salespeople have more orders arriving late than others. Maybe they're not 
-- following up on the order process, and need more training. Which salespeople have 
-- the most orders arriving late?
select e.EmployeeID, e.LastName, count(o.OrderID) as TotalLateOrders
from Employees e
join Orders o on e.EmployeeID=o.EmployeeID
where ShippedDate > RequiredDate
group by e.EmployeeID, e.LastName
order by TotalLateOrders desc
