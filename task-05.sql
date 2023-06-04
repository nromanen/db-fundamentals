-- Task #1
-- We’d like to show, for each product, the associated Supplier from Germany and Spain. 
-- Show the ProductID, ProductName, and the CompanyName of the Supplier. Sort by ProductID.
-- Note. The Join clause is used to join two or more relational database tables together in a logical way.

select p.ProductID
    ,p.ProductName
    ,s.CompanyName
from Products p
join Suppliers s on p.SupplierID = s.SupplierID
where s.Country IN ('Germany', 'Spain')
order by p.ProductID;

-- Task #2
-- We’d like to show a list of the Orders that were made, 
-- including the Shipper that was used. Show the OrderID, OrderDate (date only with alias ShortDate), 
-- and CompanyName of the Shipper, and sort by OrderID. Show only those rows with an OrderID of less than 10260.
-- Note. Use strftime('%Y-%m-%d', OrderDate) function to extract only date.

select o.OrderID
    ,strftime('%Y-%m-%d', o.OrderDate) AS ShortDate
    ,s.CompanyName
from Orders o
join Shippers s ON o.ShipVia = s.ShipperID
where o.OrderID < 10260
order by o.OrderID;

-- Task #3
-- We're doing inventory, and need to show information about OrderID, a list of products, 
-- and their quantity for orders which were shipped by Leverling Janet with quantities greater than 50.
-- The result should be sorted by Quantity.

select o.OrderID
    ,p.ProductName
    ,od.Quantity
from Orders o
join 'Order Details' od on o.OrderID = od.OrderID
join Products p on p.ProductID = od.ProductID
join Employees e on o.EmployeeID = e.EmployeeID
where e.LastName = 'Leverling' and e.FirstName = 'Janet'
and od.Quantity > 50
order by od.Quantity

-- Task #4
-- There are some customers who have never actually placed an order. Show these customers.

select c.CompanyName
from Customers c
left join Orders o ON c.CustomerID = o.CustomerID
where o.OrderID IS NULL;

-- Task #5
-- One employee (Margaret Peacock, EmployeeID 4) has placed the most orders. However, 
-- there are some customers who've never placed an order with her. 
-- Show only those customers who have never placed an order with her.

select c.CompanyName
from Customers c
left join Orders o ON c.CustomerID = o.CustomerID AND o.EmployeeID = 4
where o.OrderID IS NULL;

-- Task #6
-- We want to send all of our high-value customers a special VIP gift. 
-- We're defining high-value customers as those who've made 
-- at least 1 order with a total value (not including the discount) 
-- equal to $10,000 or more. We only want to consider orders made in the year 2016.
-- Use the alias TotalOrderAmount for the calculated column. 
-- Order by the total amount of the order, in descending order.

select c.CustomerID
  ,c.CompanyName
  ,od.OrderID
  ,SUM(od.UnitPrice * od.Quantity) AS TotalOrderAmount
from Customers as c
join Orders as o ON c.CustomerID = o.CustomerID
join 'Order Details' as od ON o.OrderID = od.OrderID
where o.OrderDate >= '2016-01-01' AND o.OrderDate <= '2016-12-31'
group by od.OrderID
having sum(od.UnitPrice * od.Quantity) >= 10000
order by TotalOrderAmount DESC;

-- Task #7
-- We want to send all of our high-value customers a special VIP gift. 
-- We're defining high-value customers as those who have orders totaling $15,000 or more in 2016 (not including the discount). 
-- Use the alias TotalOrderAmount for the calculated column. 
-- Order by the total amount of the order, in descending order.

select c.CustomerID
    ,c.CompanyName
    ,SUM(od.UnitPrice * od.Quantity) TotalOrderAmount
from Customers c
join Orders o on c.CustomerID = o.CustomerID
join 'Order Details' od on o.OrderID = od.OrderID
WHERE o.OrderDate >= '2016-01-01' AND o.OrderDate <= '2016-12-31'
group by c.CustomerID
having TotalOrderAmount > 15000
order by TotalOrderAmount DESC;

-- Task #8
-- We want to send all of our high-value customers a special VIP gift. 
-- We're defining high-value customers as orders totaling $15,000 or more in 2016.  
-- The result set should include the column TotalOrderAmount with the total sum not including the discount, 
-- and the column TotalWithDiscount with the total sum including the discount.
-- Order by TotalOrderAmount in descending order.

select c.CustomerID
    ,c.CompanyName
    ,round(SUM(od.UnitPrice * od.Quantity), 2) TotalOrderAmount
    ,round(SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)), 2) TotalWithDiscount 
from Customers c
join Orders o on c.CustomerID = o.CustomerID
join 'Order Details' od on o.OrderID = od.OrderID
where o.OrderDate >= '2016-01-01' and o.OrderDate <= '2016-12-31'
group by c.CustomerID
having TotalWithDiscount > 15000
order by TotalOrderAmount DESC

-- Task #9
-- The Northwind mobile app developers are testing an app that customers will use to show orders. 
-- In order to make sure that even the largest orders will show up correctly on the app, 
-- they'd like some samples of orders that have lots of individual line items. 
-- Show the 10 orders with the most line items, in order of total line items.

select o.OrderID
    ,count(od.ProductID) TotalOrderLines
from Orders o
join 'Order Details' od on o.OrderID = od.OrderID
group by o.OrderID
order by TotalOrderLines DESC
limit 10

-- Task #10
-- Some salespeople have more orders arriving late than others. 
-- Maybe they're not following up on the order process, and need more training. 
-- Which salespeople have the most orders arriving late?

select e.EmployeeID
    ,e.LastName
    ,count(o.OrderID) TotalLateOrders
from Employees e
join Orders o on e.EmployeeID = o.EmployeeID
where o.ShippedDate > o.RequiredDate
group by e.EmployeeID
order by TotalLateOrders desc, e.EmployeeID
