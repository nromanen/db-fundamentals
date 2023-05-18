--Return all the fields about all the shippers

SELECT * FROM Shippers

--------------------------------------------------------------------------------------------------------------------------------------------
--In the Categories table, selecting all the fields using this SQL: 
--select * from Categories will return 4 columns. We only want to see two columns, CategoryName and Description.

SELECT CategoryName, Description FROM Categories

--------------------------------------------------------------------------------------------------------------------------------------------
--Given the table Employees
--We’d like to see just the FirstName, LastName, and HireDate of all the employees with the value 'Sales Representative' in the  Title field. 
--Write a SQL statement that returns only those employees.

SELECT FirstName, LastName, HireDate
FROM Employees
WHERE Title = 'Sales Representative'

--------------------------------------------------------------------------------------------------------------------------------------------
--In the Suppliers table, 
--show the SupplierID, ContactName, and ContactTitle for those Suppliers whose ContactTitle is not 'Marketing Manager'

SELECT SupplierID, ContactName, ContactTitle
FROM Suppliers
WHERE ContactTitle != 'Marketing Manager'

--------------------------------------------------------------------------------------------------------------------------------------------
--In the Products table, 
--we’d like to see the ProductID and ProductName for those products where the ProductName includes the string “queso”.

SELECT ProductID, ProductName
FROM Products
WHERE ProductName LIKE '%queso%'

--------------------------------------------------------------------------------------------------------------------------------------------
--Looking at the Orders table, there’s a field called ShipCountry. 
--Write a query that shows the OrderID, CustomerID, and ShipCountry for the orders where the ShipCountry is either 'France' or 'Belgium'.

SELECT OrderID, CustomerID, ShipCountry
FROM Orders
WHERE ShipCountry IN ('France', 'Belgium')

--------------------------------------------------------------------------------------------------------------------------------------------
--For all the employees in the Employees table, show the FirstName, LastName, Title, and BirthDate.
--Order the results by BirthDate, so we have the oldest employees first.
--Note. Exclude those employees from the result set whose BirthDate is undefined. 

SELECT FirstName, LastName, Title, BirthDate
FROM Employees
WHERE BirthDate IS NOT NULL
ORDER BY BirthDate

--------------------------------------------------------------------------------------------------------------------------------------------
--For all the employees in the Employees table
--show the FirstName and LastName columns from the Employees table, and then create a new column called FullName, 
--showing FirstName and LastName joined together in one column, with a space (' ') in between

SELECT FirstName, LastName, (FirstName || ' ' || LastName) AS FullName
FROM Employees

--------------------------------------------------------------------------------------------------------------------------------------------
--In the OrderDetails table, we have the fields UnitPrice and Quantity.
--For the orders with OrderID in range 10250 ..10259 create a new field, TotalPrice, that multiplies UnitPrice and Quantity together. 
--We’ll ignore the Discount field for now. In addition, show the OrderID, ProductID, UnitPrice, and Quantity. Order by OrderID and ProductID.

SELECT OrderID, ProductID, UnitPrice, Quantity, UnitPrice * Quantity AS TotalPrice
FROM "OrderDetails"
WHERE OrderID BETWEEN 10250 AND 10259
ORDER BY OrderID, ProductID

--------------------------------------------------------------------------------------------------------------------------------------------
--Given Customers table. How many customers do we have in Germany? The result set should contain only one value.
--Note. In order to get the total number of customers in Germany, we need to use what’s called an aggregate function.

SELECT count(*)
FROM Customers
WHERE Country = 'Germany'
