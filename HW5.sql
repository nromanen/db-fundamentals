USE Northwind;

/* Show first and last names of the employees who used to serve orders shipped to Madrid. The result set would be ordered by first name. */

SELECT DISTINCT e.FirstName
, e.LastName
FROM Orders o LEFT JOIN Employees e
ON o.EmployeeID = e.EmployeeID
WHERE o.ShipCity LIKE 'Madrid'
ORDER BY 1;

/*
Write the query, which will show the first and last names of the employees (whether they served orders or not) as well as the count of orders (CountOfOrders) where served by each of them. 
Note. Use LEFT JOIN
*/
SELECT e.FirstName
, e.LastName
, COUNT(o.OrderID) AS CountOfOrders
FROM Employees e LEFT JOIN Orders o
ON e.EmployeeID = o.EmployeeID 
GROUP BY e.EmployeeID, e.FirstName, e.LastName
ORDER BY 1;

/* Show the first and last names of the employees as well as the count of their orders shipped (ShippedDate) after the required date (RequiredDate) which were ordered during the year 1997 (use left join). */
SELECT e.FirstName
, e.LastName
, COUNT(o.OrderID) AS CountOfOrder
FROM Orders o INNER JOIN Employees e
ON o.EmployeeID = e.EmployeeID 
WHERE o.ShippedDate > o.RequiredDate AND YEAR(o.OrderDate) = 1997
GROUP BY e.EmployeeID, e.FirstName, e.LastName
ORDER BY 1;

/* Show category names (without duplicates) of products that where ordered by customers that are located  in Madrid */
SELECT DISTINCT ct.CategoryName AS Name
FROM Orders o INNER JOIN Customers c ON o.CustomerID = c.CustomerID
INNER JOIN [Order Details] od ON o.OrderID = od.OrderID
INNER JOIN Products p ON od.ProductID = p.ProductID
INNER JOIN Categories ct ON ct.CategoryID = p.CategoryID
WHERE c.City LIKE 'Madrid';

/* Show the list of french customers’ names who have made more than one order (use grouping). */
SELECT c.ContactName
, COUNT(o.OrderID) AS CountOfOrder  
FROM Orders o INNER JOIN Customers c
ON O.CustomerID = c.CustomerID
WHERE c.Country LIKE 'France'
GROUP BY c.ContactName
HAVING COUNT(o.OrderID) > 1; 

