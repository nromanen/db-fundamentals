-- Show the date of the first order ever made in the Orders table.

SELECT MIN(OrderDate)
FROM Orders

-- Show a list of countries where the Northwind company
-- has customers and the number of Customers who work there (alias NumberOfCustomers).

SELECT Country, COUNT(*) AS NumberOfCustomers
FROM Customers
GROUP BY Country
ORDER BY NumberOfCustomers DESC, Country ASC

-- Show a list of countries where Northwind company has customers and the number of Customers who work there (alias NumberOfCustomers).
-- The result should contain only the data about countries where the number of customers equals or exceeds 3.
-- The result should be sorted by NumberOfCustomers in descending order

SELECT Country, COUNT(*) AS NumberOfCustomers
FROM Customers
GROUP BY Country
HAVING COUNT(*) >= 3
ORDER BY NumberOfCustomers DESC, Country ASC

-- Show a list of all the different values in the Customers table for ContactTitles.
-- Also include a count for each ContactTitle (alias TotalContactTitle). 
-- The result set should be sorted in descending order by TotalContactTitle.

SELECT ContactTitle, COUNT(*) AS TotalContactTitle
FROM Customers
GROUP BY ContactTitle
ORDER BY TotalContactTitle DESC, ContactTitle ASC

-- Write a query that should show the list of CategoryID, the number of all products within each category (NumberOfProducts) 
-- only for those products with the value UnitsInStock less than UnitsOnOrder.
-- The report should contain only the rows where NumberOfProducts is more than 1. 
--The result set should be sorted in ascending order by NumberOfProducts.

SELECT CategoryID, COUNT(*) AS NumberOfProducts
FROM Products
WHERE UnitsInStock < UnitsOnOrder
GROUP BY CategoryID
HAVING COUNT(*) > 1
ORDER BY NumberOfProducts ASC

-- We want to show the number of orders (NumberOfOrders) and the average Freight (AverageFreight) shipped to any Latin American country. 
-- But we don’t have a list of Latin American countries in a table in the Northwind database. 
-- So, we’re going to just use this list of Latin American countries that happen to be in the Orders table: Brazil, Mexico, Argentina, and Venezuela.
-- The value AverageFreight should be rounded to the 2nd digit after the decimal point. Use this column for ascending order.

SELECT ShipCountry, COUNT(*) AS NumberOfOrders, ROUND(AVG(Freight), 2) AS AverageFreight
FROM Orders
WHERE ShipCountry IN ('Argentina', 'Mexico', 'Venezuela', 'Brazil')
GROUP BY ShipCountry
ORDER BY NumberOfOrders ASC, AverageFreight ASC

-- Create a report about the total sum (TotalOrder) of each order, where the discount was used. Use the expression UnitPrice * Quantity * (1 - Discount). 
-- The value TotalOrder should be rounded to the 2nd digit after the decimal point. 
-- Use this column for sorting in descending order.
-- The result should contain only the rows with TotalOrder greater than 5000.

SELECT OrderID, ROUND(SUM(UnitPrice * Quantity * (1 - Discount)), 2) AS TotalOrder
FROM [Order Details]
WHERE Discount > 0
GROUP BY OrderID
HAVING TotalOrder > 5000
ORDER BY TotalOrder DESC

-- Create a report about the total sum of Freight (TotalFreight) 
-- shipped by every employee within each specified year of order (OrderYear).
-- Show the result only for TotalFreight greater than 2000.
-- The result should be sorted by OrderYear and EmployeeID both ascending.

SELECT strftime('%Y', OrderDate) AS OrderYear, EmployeeID, SUM(Freight) AS TotalFreight
FROM Orders
GROUP BY OrderYear, EmployeeID
HAVING TotalFreight > 2000
ORDER BY OrderYear ASC, EmployeeID ASC

-- Create a report that shows EmployeeID and the total number of late orders (NumberOfDelayedOrders) for each of them. 
-- The condition of late orders is RequiredDate less than ShippedDate.
-- The result should be sorted by NumberOfDelayedOrders descending.

SELECT EmployeeID, COUNT(*) AS NumberOfDelayedOrders
FROM Orders
WHERE RequiredDate < ShippedDate
GROUP BY EmployeeID
ORDER BY NumberOfDelayedOrders DESC, EmployeeID ASC

-- Create a report that displays the number of female and male employees (NumberOfEmployees) in the positions they held.

SELECT Title, TitleOfCourtesy, COUNT(*) AS NumberOfEmployees
FROM Employees
GROUP BY Title, TitleOfCourtesy
