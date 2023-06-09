--01. Show the date of the first order ever made in the Orders table.
--Note. There’s a aggregate function called Min that you need to use for this problem.
select MIN(OrderDate)
from Orders

--02. Show a list of countries where the Northwind company has customers and the number of Customers who work there (alias NumberOfCustomers).
--The result should be sorted by NumberOfCustomers in descending order
--Note. You need to use grouping and an aggregate function called COUNT() for this problem.
select Country, COUNT(*) as NumberOfCustomers
from Customers
GROUP BY Country
ORDER BY NumberOfCustomers DESC, Country ASC

--03. Show a list of countries where Northwind company has customers and the number of Customers who work there (alias NumberOfCustomers).
--The result should contain only the data about countries where the number of customers equals or exceeds 3.
--The result should be sorted by NumberOfCustomers in descending order
--Note. You need to use grouping and an aggregate function called COUNT() for this problem.
select Country, COUNT(*) as NumberOfCustomers
from Customers
GROUP BY Country
HAVING COUNT(CustomerID) >=3
ORDER BY NumberOfCustomers DESC, Country ASC

--04. Show a list of all the different values in the Customers table for ContactTitles. Also include a count for each ContactTitle (alias TotalContactTitle). 
-- The result set should be sorted in descending order by TotalContactTitle.
-- Note. The answer for this problem builds on multiple concepts, such as grouping, aggregate functions, and aliases.
select DISTINCT ContactTitle, COUNT(ContactTitle) as TotalContactTitle
from Customers
GROUP BY ContactTitle
ORDER BY TotalContactTitle DESC, ContactTitle ASC

--05. Write a query that should show the list of CategoryID, the number of all products within each category (NumberOfProducts) only 
--for those products with the value UnitsInStock less than UnitsOnOrder. These two columns should be included in the result as well. Moreover, 
--the report should contain only the rows where NumberOfProducts is more than 1. 
--The result set should be sorted in ascending order by NumberOfProducts.
--Note. The answer for this problem builds on multiple concepts, such as grouping, aggregate functions, and aliases.
SELECT CategoryID
, COUNT(*) AS NumberOfProducts
, SUM(UnitsInStock) as UnitsInStock
, SUM(UnitsOnOrder) as UnitsOnOrder
FROM Products
WHERE UnitsInStock < UnitsOnOrder
GROUP BY CategoryID
HAVING COUNT(*) > 1
ORDER BY NumberOfProducts ASC;

--06. We want to show the number of orders (NumberOfOrders) and the average Freight (AverageFreight) shipped to any Latin American country. 
--But we don’t have a list of Latin American countries in a table in the Northwind database. So, we’re going to just use this list of Latin American countries 
--that happen to be in the Orders table: Brazil, Mexico, Argentina, and Venezuela.
--The value AverageFreight should be rounded to the 2nd digit after the decimal point. Use this column for ascending order.
--Note. You need to use ROUND(<value>, 2) function for average result. 
--The answer for this problem builds on multiple concepts, such as grouping, aggregate functions, and aliases.
SELECT ShipCountry
, count(OrderDate) as NumberOfOrders
, ROUND(avg(Freight),2) as AverageFreight
FROM Orders
WHERE ShipCountry IN ('Argentina', 'Mexico', 'Venezuela', 'Brazil')
GROUP BY ShipCountry
ORDER BY NumberOfOrders;

--07. Create a report about the total sum (TotalOrder) of each order, where the discount was used. Use the expression UnitPrice * Quantity * (1 - Discount). 
--The value TotalOrder should be rounded to the 2nd digit after the decimal point. Use this column for sorting in descending order.
--The result should contain only the rows with TotalOrder greater than 5000.
--Note. You need to use ROUND(<value>, 2) function for the sum result. 
--The answer to this problem builds on multiple concepts, such as grouping, aggregate functions, and aliases.
SELECT OrderID
, ROUND(SUM(UnitPrice * Quantity * (1 - Discount)),2) AS TotalOrder
FROM "Order Details"
WHERE Discount > 0
GROUP BY OrderID
HAVING TotalOrder > 5000
ORDER BY TotalOrder DESC;

--08. Create a report about the total sum of Freight (TotalFreight) shipped by every employee within each specified year of order (OrderYear).
--Show the result only for TotalFreight greater than 2000.
--The result should be sorted by OrderYear and EmployeeID both ascending.
--Note. You need to use function strftime('%Y', OrderDate) to extract year from date. 
--The answer to this problem builds on multiple concepts, such as grouping, aggregate functions, and aliases.
SELECT strftime('%Y', OrderDate) as OrderYear
, EmployeeID
, SUM(Freight) as TotalFreight
FROM Orders
GROUP BY OrderYear, EmployeeID
HAVING TotalFreight > 2000
ORDER BY OrderYear ASC;

--09. Create a report that shows EmployeeID and the total number of late orders (NumberOfDelayedOrders) for each of them. The condition of late orders is RequiredDate less than ShippedDate.
--The result should be sorted by NumberOfDelayedOrders descending.
--Note. The answer to this problem builds on multiple concepts, such as grouping, aggregate functions, and aliases.
SELECT EmployeeID
, COUNT(EmployeeID) as NumberOfDelayedOrders
FROM Orders
WHERE RequiredDate < ShippedDate
GROUP BY EmployeeID
ORDER BY NumberOfDelayedOrders DESC, EmployeeID ASC;

--10. Create a report that displays the number of female and male employees (NumberOfEmployees) in the positions they held.
--Note. Use the values of columns Title and TitleOfCourtesy.
--The answer to this problem builds on multiple concepts, such as grouping, aggregate functions, and aliases.
SELECT Title
    , TitleOfCourtesy
    , COUNT(TitleOfCourtesy) as NumberOfEmployees
FROM Employees
GROUP BY Title, TitleOfCourtesy
