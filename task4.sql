--1. Show the date of the first order ever made in the Orders table.
select MIN(OrderDate)
from Orders o 

--2. Show a list of countries where the Northwind company has customers and the number of Customers who work there (alias NumberOfCustomers).
--The result should be sorted by NumberOfCustomers in descending order
select Country, COUNT(CustomerID) as NumberOfCustomers
from Customers c
group by Country
order by NumberOfCustomers desc, Country

--3. Show a list of countries where Northwind company has customers and the number of Customers who work there (alias NumberOfCustomers).
--The result should contain only the data about countries where the number of customers equals or exceeds 3.
--The result should be sorted by NumberOfCustomers in descending order
select Country, COUNT(CustomerID) as NumberOfCustomers 
from Customers c
group by Country
having NumberOfCustomers >= 3
order by NumberOfCustomers desc, Country

--4. Show a list of all the different values in the Customers table for ContactTitles.
--Also include a count for each ContactTitle (alias TotalContactTitle). 
--The result set should be sorted in descending order by TotalContactTitle.
select ContactTitle 
, COUNT(ContactTitle) as TotalContactTitle
from Customers c
group by ContactTitle
order by TotalContactTitle desc, ContactTitle

--5. Write a query that should show the list of CategoryID, the number of all products within each category
--(NumberOfProducts) only for those products with the value UnitsInStock less than UnitsOnOrder.
--The report should contain only the rows where NumberOfProducts is more than 1. 
--The result set should be sorted in ascending order by NumberOfProducts.
select CategoryID, COUNT(ProductID) as NumberOfProducts
from Products p
where UnitsInStock < UnitsOnOrder
group by CategoryID
having COUNT(ProductID) > 1
order by NumberOfProducts

--6. We want to show the number of orders (NumberOfOrders) and the average Freight (AverageFreight)
--shipped to any Latin American country. But we don’t have a list of Latin American countries in a table in the Northwind database.
--So, we’re going to just use this list of Latin American countries that happen to be in the Orders table: Brazil, Mexico, Argentina,
--and Venezuela.
--The value AverageFreight should be rounded to the 2nd digit after the decimal point. Use this column for ascending order.
select ShipCountry, COUNT(OrderID) as NumberOfOrders, ROUND(avg(Freight), 2) as AverageFreight
from Orders o
where ShipCountry in ('Brazil', 'Mexico', 'Venezuela', 'Argentina')
group by ShipCountry
order by NumberOfOrders

--7. Create a report about the total sum (TotalOrder) of each order, where the discount was used. Use the expression
--UnitPrice * Quantity * (1 - Discount). 
--The value TotalOrder should be rounded to the 2nd digit after the decimal point. Use this column for sorting in descending order.
--The result should contain only the rows with TotalOrder greater than 5000.
select od.OrderID, ROUND(SUM(cast(od.UnitPrice * od.Quantity * (1 - od.Discount) as numeric)), 2) as TotalOrder
from "Order Details" od
where od.Discount > 0 
group by od.OrderID
having SUM(cast(od.UnitPrice * od.Quantity * (1 - od.Discount) as numeric))  > 5000
order by TotalOrder desc

--8. Create a report about the total sum of Freight (TotalFreight) shipped by every
--employee within each specified year of order (OrderYear).
--Show the result only for TotalFreight greater than 2000.
--The result should be sorted by OrderYear and EmployeeID both ascending.
select strftime('%Y', o.OrderDate) as OrderYear
, o.EmployeeID
, sum(o.Freight) as TotalFreight
from Orders o
group by OrderYear, o.EmployeeID
having TotalFreight > 2000
order by OrderYear, o.EmployeeID

--9. Create a report that shows EmployeeID and the total number of late orders (NumberOfDelayedOrders)
--for each of them. The condition of late orders is RequiredDate less than ShippedDate.
--The result should be sorted by NumberOfDelayedOrders descending.
select o.EmployeeID, COUNT(*) as NumberOfDelayedOrders  
from Orders o
where o.RequiredDate < o.ShippedDate
group by o.EmployeeID
order by NumberOfDelayedOrders desc, EmployeeID

--10. Create a report that displays the number of female and male employees (NumberOfEmployees) in the positions they held.
select e.Title
, e.TitleOfCourtesy
, COUNT(*) as NumberOfEmployees
from Employees e
group by e.Title, e.TitleOfCourtesy
