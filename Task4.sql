---------------------------------------------------------------------------------------------------------------------------------------------
--1
--We have a table Orders. 
--Show the date of the first order ever made in the Orders table.
--Note. There’s a aggregate function called Min that you need to use for this problem.
select MIN(OrderDate) 
from orders
---------------------------------------------------------------------------------------------------------------------------------------------
--2
--We have a table Customers. 
--Show a list of countries where the Northwind company has customers and the number of Customers who work there (alias NumberOfCustomers).
--The result should be sorted by NumberOfCustomers in descending order
--Note. You need to use grouping and an aggregate function called COUNT() for this problem.
select country, count(*) as NumberOfCustomers
from customers
group by country
order by count(*) desc, country asc
---------------------------------------------------------------------------------------------------------------------------------------------
-3
--We have a table Customers. 
--Show a list of countries where Northwind company has customers and the number of Customers who work there (alias NumberOfCustomers).
--The result should contain only the data about countries where the number of customers equals or exceeds 3.
--The result should be sorted by NumberOfCustomers in descending order
--Note. You need to use grouping and an aggregate function called COUNT() for this problem.
SELECT Country, COUNT(*) AS NumberOfCustomers
FROM Customers
GROUP BY Country
HAVING COUNT(*) >= 3
ORDER BY NumberOfCustomers DESC, Country ASC
---------------------------------------------------------------------------------------------------------------------------------------------
--4
--We have a table Customers. 
--Show a list of all the different values in the Customers table for ContactTitles. Also include a count for each ContactTitle (alias TotalContactTitle). 
--The result set should be sorted in descending order by TotalContactTitle.
--Note. The answer for this problem builds on multiple concepts, such as grouping, aggregate functions, and aliases.
SELECT ContactTitle, COUNT(*) AS TotalContactTitle
FROM Customers
GROUP BY ContactTitle
ORDER BY TotalContactTitle DESC, ContactTitle
---------------------------------------------------------------------------------------------------------------------------------------------
-5
--We have a table Products. 
--Write a query that should show the list of CategoryID, the number of all products within each category (NumberOfProducts) only for those products with the value UnitsInStock less than UnitsOnOrder.
--The report should contain only the rows where NumberOfProducts is more than 1. 
--The result set should be sorted in ascending order by NumberOfProducts.
--Note. The answer for this problem builds on multiple concepts, such as grouping, aggregate functions, and aliases.
select categoryid, count(unitprice*unitsonorder) as NumberOfProducts
from products p
where unitsinstock < unitsonorder
group by categoryid
having NumberOfProducts > 1
order by NumberOfProducts asc
---------------------------------------------------------------------------------------------------------------------------------------------
--6
--We have a table Orders. 
--We want to show the number of orders (NumberOfOrders) and the average Freight (AverageFreight) shipped to any Latin American country. But we don’t have a list of Latin American countries in a table in the Northwind database. So, we’re going to just use this list of Latin American countries that happen to be in the Orders table: Brazil, Mexico, Argentina, and Venezuela.
--The value AverageFreight should be rounded to the 2nd digit after the decimal point. Use this column for ascending order.
--Note. You need to use ROUND(<value>, 2) function for average result. 
--The answer for this problem builds on multiple concepts, such as grouping, aggregate functions, and aliases.
select ShipCountry
    , count(ShipCountry) as NumberOfOrders
    , round(avg(Freight), 2) as AverageFreight
from orders
group by ShipCountry
having ShipCountry in ('Argentina', 'Mexico', 'Venezuela', 'Brazil')
order by NumberOfOrders
---------------------------------------------------------------------------------------------------------------------------------------------
--7
--We have a table "Order Details". 
--Create a report about the total sum (TotalOrder) of each order, where the discount was used. Use the expression UnitPrice * Quantity * (1 - Discount). 
--The value TotalOrder should be rounded to the 2nd digit after the decimal point. Use this column for sorting in descending order.
--The result should contain only the rows with TotalOrder greater than 5000.
--Note. You need to use ROUND(<value>, 2) function for the sum result. 
--The answer to this problem builds on multiple concepts, such as grouping, aggregate functions, and aliases.
select OrderID
    , round(sum(UnitPrice * Quantity * (1 - Discount)), 2) as TotalOrder
from [Order Details]
where Discount > 0
group by OrderID
having TotalOrder > 5000
order by TotalOrder desc
---------------------------------------------------------------------------------------------------------------------------------------------
--8
--We have a table Orders. 
--Create a report about the total sum of Freight (TotalFreight) shipped by every employee within each specified year of order (OrderYear).
--Show the result only for TotalFreight greater than 2000.
--The result should be sorted by OrderYear and EmployeeID both ascending.
--Note. You need to use function strftime('%Y', OrderDate) to extract year from date. 
-The answer to this problem builds on multiple concepts, such as grouping, aggregate functions, and aliases.
select strftime('%Y', OrderDate) as OrderYear
    , EmployeeID
    , sum(Freight) as TotalFreight
from Orders
group by OrderYear, EmployeeID
having TotalFreight > 2000
order by OrderYear asc, EmployeeID asc
---------------------------------------------------------------------------------------------------------------------------------------------
--9
--We have a table Orders. 
--Create a report that shows EmployeeID and the total number of late orders (NumberOfDelayedOrders) for each of them. The condition of late orders is RequiredDate less than ShippedDate.
--The result should be sorted by NumberOfDelayedOrders descending.
--Note. The answer to this problem builds on multiple concepts, such as grouping, aggregate functions, and aliases.
select EmployeeID
    , count(EmployeeID) as NumberOfDelayedOrders
from Orders
where RequiredDate < ShippedDate
group by EmployeeID
order by NumberOfDelayedOrders desc, EmployeeID
---------------------------------------------------------------------------------------------------------------------------------------------
--10
--We have a table Employees. 
--Create a report that displays the number of female and male employees (NumberOfEmployees) in the positions they held.
--Note. Use the values of columns Title and TitleOfCourtesy.
--The answer to this problem builds on multiple concepts, such as grouping, aggregate functions, and aliases.
select Title
    , TitleOfCourtesy
    , count(TitleOfCourtesy) as NumberOfEmployees
from Employees
group by Title, TitleOfCourtesy
