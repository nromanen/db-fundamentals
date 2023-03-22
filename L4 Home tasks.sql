/*
 * In the OrderDetails table, we have the fields UnitPrice and Quantity. 
 * Write the query which will return the OrderID, ProductsAmount (amount of products counted by ProductID in each order) 
 * an additional column TotalPrice (containing the sum of values that multiply UnitPrice and Quantity). 
 * The result set will contain only data about orders with ProductsAmount of more than 5 and will be ordered by OrderID (ascending) and
 *  ProductsAmount (descending).
**/
SELECT od.OrderID 
, COUNT(od.ProductID) as ProductsAmount
, SUM(od.UnitPrice * od.Quantity) as TotalPrice
FROM "Order Details" od
GROUP by od.OrderID 
HAVING COUNT(od.ProductID) > 5
ORDER BY od.OrderID, ProductsAmount;

/*
 * Show a list of all the different values in the Customers table for ContactTitles. 
 * Also include an amount (count) for each ContactTitle with the alias ContactTitlesAmount. 
 * The result set would be ordered by ContactTitlesAmount in descending order.
**/
SELECT c.ContactTitle
, COUNT(c.ContactTitle) as ContactTitlesAmount
FROM Customers c 
GROUP BY c.ContactTitle 
ORDER BY COUNT(c.ContactTitle) DESC;

/*
 * Show the list of the calculated number of orders (AmountOfLateOrders), 
 * which were shipped (ShipDate) after the required date (RequiredDate) by employees, 
 * which would be represented in the result set with their EmployeeID. 
 * Include into the list only rows with the AmountOfLateOrders equals and more than 5.
 * */
SELECT o.EmployeeID 
, COUNT(o.OrderID) as AmountOfLateOrders
FROM Orders o 
WHERE o.ShippedDate > o.RequiredDate 
GROUP BY o.EmployeeID 
HAVING COUNT(o.OrderID) >= 5;

/*
 * Show the FirstName and LastName columns from the Employees table, and then create a new column called FullName, 
 * showing FirstName and LastName joined together in one column, with a space in between for those employees, 
 * who live in the USA or Germany.
 * */
SELECT e.FirstName 
, e.LastName 
, e.FirstName || ' ' || e.LastName as FullName
FROM Employees e 
WHERE e.Country IN ('USA', 'Germany');