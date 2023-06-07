--1. Janet Leverling, one of the salespeople, has come to you with a request.
-- She thinks that she accidentally double-entered a line item on an order, with a different ProductID,
-- but the same quantity. She remembers that the quantity was 60 or more. Show all the OrderIDs that match this, in order of OrderID.
-- Use Orders, Orders Details tables.

select distinct od1.OrderID
from 'Order Details' od1
join 'Order Details' od2 on od1.OrderID=od2.OrderID
where od1.quantity=od2.quantity and
od1.quantity >= 60 and 
od1.productid <> od2.productid
order by od1.OrderID


--2. We know that Andrew Fuller is the Vice President of Northwind Company. Create the report that shows 
-- the list of those employees (last and first name) who were hired earlier than Fuller.
-- Note. Use the subquery.
-- Use Employees table.

select LastName, FirstName
from employees
where hiredate < (select hiredate from employees
where LastName = 'Fuller')


--3. Write the query which should create the list of products and their unit price for products with price 
-- greater than average products' unit price. 
-- Note. Use the subquery to get the average UnitPrice from the Products table.
-- Use Products table.

select ProductName, UnitPrice
from Products
where UnitPrice > (select avg(UnitPrice)
from Products)
order by UnitPrice asc


--4. Create the report that should show  the Companies from Germany that placed orders in 2016.
-- Note. You may use STRFTIME('%Y', OrderDate) function to retrieve the year from the date (the type of result would be 'string'  in this case).
-- Use subquery to create this report.
-- Use Orders and Customers tables.

select CompanyName
from customers
where country = 'Germany' and
CustomerID in (
select CustomerID
from Orders
where STRFTIME('%Y', OrderDate) = '2016')


--5. Create the query that should show the date when the orders were shipped (alias ShippedDate), 
-- the number of orders  (NumberOfOrders) and total sum (including discount) of the orders (Total) 
-- shipped at this date.  The report includes only the 1st quarter of 2016 with the number of orders greater than 3.
-- The result should be sorted by ShippedDate.
-- Note. A subtotal is calculated by a sub-query for each order. The sub-query forms a table and then joined with the Orders table.
-- You may use STRFTIME('%Y', OrderDate) function to retrieve the year from the date (the type of result would be 'string'  in this case).
-- Use ROUND() function for calculated sum of each order in subquery.
-- Use Orders, Orders Details tables.

select o.ShippedDate, count(o.OrderID) as NumberOfOrders, 
round(sum((select sum(od.unitprice*od.quantity*(1-od.discount)) from 'Order Details' od
group by od.OrderID
having o.OrderID = od.OrderID)), 2) as Total
from Orders o
where o.ShippedDate between '2016-01-01' and '2016-03-31'
group by o.ShippedDate
having NumberofOrders > 3


--6. For the category 'Dairy Products' get the list of products sold and the total sales amount including discount (alias ProductSales) during 
-- the 1st quarter of 2016 year.
-- Note. Use the subquery to get sales for each product on each order. Join the table from the subquery with an outer query on ProductID. 
-- You may use STRFTIME('%Y', OrderDate) function to retrieve the year from the date (the type of result would be 'string'  in this case).
-- Use ROUND() function for a calculated total for each product in the subquery.
-- Use Orders, Orders Details, and Products tables.

select c.CategoryName,
       p.ProductName,
      sum((
      select sum(round(od.unitprice*od.quantity*(1-od.discount),2))
      from 'Order Details' od
      join Orders o on od.OrderID=o.OrderID
      where o.OrderDate between '2016-01-01' and '2016-03-31'
      and p.ProductID=od.ProductID
      )) as ProductSales
from Products p
join Categories c
on p.CategoryID=c.CategoryID
where CategoryName = 'Dairy Products'
group by p.ProductName


--7. Andrew, the VP of sales, wants to know the name of the company that placed order 10290.
-- Note. Use subquery.
-- Use Orders and Customers tables.

select c.CompanyName
from customers c
where (select Orderid from orders o 
where c.customerid=o.customerid and o.orderid = 10290)


--8. Some salespeople have more orders arriving late than others. Maybe they're not following up on the order process, 
-- and need more training. Andrew, the VP of sales, has been doing some more thinking some more about the problem of 
-- late orders. He realizes that just looking at the number of orders arriving late for each salesperson isn't a good idea. 
-- It needs to be compared against the total number of orders per salesperson.
-- Note. To determine which orders are late, you can use a comparison of the RequiredDate and ShippedDate. 
-- Use the aliases AllOrders and LateOrders for the calculated columns.
-- You'll need to join the Employee table to get the last name, and also add Count to show the total late orders.
-- Use Orders and Employees tables.

select e.EmployeeID, e.LastName,
(select count(o.orderID) from orders o where o.EmployeeID = e.EmployeeID) as AllOrders, 
(select count(o.orderID) from orders o where o.EmployeeID = e.EmployeeID and o.RequiredDate <= o.ShippedDate) as LateOrders
from employees e
group by e.EmployeeID, e.LastName
having AllOrders != 0 and LateOrders != 0


--9. We know that Andrew Fuller is the Vice President of Northwind Company. Create the report that shows the list of those 
-- employees (last and first name) who served more orders than Fuller did.
-- Note. Use the subqueries.
-- Use Orders and Employees tables.

select lastname, firstname
from employees
where EmployeeID in 
(select employeeID from Orders GROUP BY employeeID having count(Orderid) > 
(select count(Orderid) from Orders where EmployeeID = 2 group by EmployeeID))


--10. Write the query that should return the EmployeeID,  OrderID, and OrderDate. The criteria for the report is that the 
-- order must be the last for each employee (maximum OrderDate). Note. Use the correlated subquery. 
-- Use Orders and Employees tables.

select EmployeeID, (select OrderID from Orders o where o.EmployeeID=e.EmployeeID ORDER BY o.OrderDate DESC LIMIT 1) as OrderID, 
(select OrderDate from Orders o where o.EmployeeID=e.EmployeeID ORDER BY o.OrderDate DESC LIMIT 1) as OrderDate
from Employees e
where EmployeeID in (
select EmployeeID
from orders o
group by EmployeeID

select o.EmployeeID, o.OrderID, OrderDate
FROM Orders o
where OrderDate IN (select max(OrderDate) from Orders o1 where o.EmployeeID=o1.EmployeeID)
Order by o.EmployeeID

SELECT o.EmployeeID, o.OrderID, max(o.OrderDate)
FROM Orders o
group by o.EmployeeID
