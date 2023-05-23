--Return all the fields about all the shippers
SELECT * FROM Shippers

--We only want to see two columns, CategoryName and Description
SELECT CategoryName, Description FROM Categories

--FirstName, LastName, and HireDate of all the employees with the value 'Sales Representative' in the  Title field.
SELECT FirstName, LastName, HireDate
FROM Employees
WHERE Title = 'Sales Representative'

--show the SupplierID, ContactName, and ContactTitle for those Suppliers whose ContactTitle is not 'Marketing Manager'
SELECT SupplierID, ContactName, ContactTitle
FROM Suppliers
WHERE ContactTitle <> "Marketing Manager"

--we’d like to see the ProductID and ProductName for those products where the ProductName includes the string “queso”.
SELECT ProductID, ProductName
FROM Products
WHERE ProductName LIKE '%queso%'


--Write a query that shows the OrderID, CustomerID, and ShipCountry for the orders where the ShipCountry is either 'France' or 'Belgium'.
SELECT OrderID, CustomerID, ShipCountry
FROM Orders
WHERE ShipCountry IN ('France', 'Belgium')

--show the FirstName, LastName, Title, and BirthDate. Order the results by BirthDate, so we have the oldest employees first.
SELECT FirstName, LastName, Title, BirthDate
FROM Employees
WHERE BirthDate IS NOT NULL
ORDER BY BirthDate ASC

--show the FirstName and LastName columns from the Employees table, and then create a new column called FullName, showing FirstName and LastName joined together in one column, with a space (' ') in between
SELECT FirstName, LastName, FirstName || ' ' || LastName AS FullName
FROM Employees

--For the orders with OrderID in range 10250 ..10259 create a new field, TotalPrice, that multiplies UnitPrice and Quantity together. We’ll ignore the Discount field for now. In addition, show the OrderID, ProductID, UnitPrice, and Quantity. Order by OrderID and ProductID.
SELECT OrderID, ProductID, UnitPrice, Quantity, (UnitPrice * Quantity) AS TotalPrice
FROM "Order Details"
WHERE OrderID BETWEEN 10250 AND 10259
ORDER BY OrderID, ProductID


--How many customers do we have in Germany? The result set should contain only one value.
SELECT COUNT(*) AS "count(*)"
FROM Customers
WHERE Country = 'Germany'
