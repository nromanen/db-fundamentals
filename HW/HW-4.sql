/*Given the Northwind database (see the structure below).
*In the OrderDetails table, we have the fields UnitPrice and Quantity. Write the query *which will return the OrderID, ProductsAmount (amount of products counted by ProductID in *each order)  an additional column TotalPrice (containing the sum of values that multiply *UnitPrice and Quantity). The result set will contain only data about orders with *ProductsAmount of more than 5 and will be ordered by OrderID (ascending) and ProductID (descending).
*/

SELECT OrderID
, COUNT(ProductID) AS ProductsAmount
, (UnitPrice*Quantity) AS TotalPrice
FROM [Order Details]
GROUP BY OrderID
HAVING COUNT(ProductID) > 5
ORDER BY 1, COUNT(ProductID) DESC;

/*Given the Northwind database (see the structure below).
*Show a list of all the different values in the Customers table for ContactTitles. Also 
*include an amount (count) for each ContactTitle with the alias ContactTitlesAmount. The 
*result set would be ordered by ContactTitlesAmount in descending order.
*/

SELECT ContactTitle , COUNT(ContactTitle) AS ContactTitlesAmount 
FROM Customers
GROUP BY ContactTitle 
ORDER BY COUNT(ContactTitle) DESC;

/*
*Given the Northwind database (see the structure below).
*Show the list of the calculated number of orders (AmountOfLateOrders), which were shipped (
*ShipDate) after the required date (RequiredDate) by employees, which would be represented 
*in the result set with their EmployeeID. Include into the list only rows with the 
*AmountOfLateOrders equals and more than 5.
*/

SELECT EmployeeID  
, COUNT(OrderID) AS AmountOfLateOrders
FROM Orders
WHERE ShippedDate > RequiredDate
GROUP BY EmployeeID 
HAVING (COUNT(OrderID)) >= 5
ORDER BY 1;

/*
*Given the Northwind database (see the structure below).
*Show the FirstName and LastName columns from the Employees table, and then create a new 
*column called FullName, showing FirstName and LastName joined together in one column, with 
*a space in between for those employees, who live in the USA or Germany.
*/

SELECT FirstName , LastName , FirstName || ' ' || LastName as FullName
FROM Employees
WHERE Country = 'USA' OR Country = 'Germany';

