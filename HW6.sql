--Given the Northwind database (see the structure below).
--Show the list of french customers’ names who used to order non-french products (use left join).
SELECT DISTINCT c.ContactName  
FROM Customers c
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
INNER JOIN "Order Details" od ON o.OrderID = od.OrderID 
INNER JOIN Products p ON od.ProductID = p.ProductID
INNER JOIN Suppliers s ON p.SupplierID = s.SupplierID 
WHERE c.Country LIKE 'France' AND c.Country != s.Country
ORDER BY c.CustomerID;
--Given the Northwind database (see the structure below).
--Show the list of french customers’ names who used to order french products. 
SELECT DISTINCT c.ContactName
FROM Customers c
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
INNER JOIN "Order Details" od ON o.OrderID = od.OrderID 
INNER JOIN Products p ON od.ProductID = p.ProductID
INNER JOIN Suppliers s ON p.SupplierID = s.SupplierID 
WHERE c.Country LIKE 'France' AND c.Country = s.Country
ORDER BY c.CustomerID;
--Given the Northwind database (see the structure below).
--Show the total ordering sum calculated for each country where orders were shipped.
--While calculating the sum take into account the value of the discount (Discount).
SELECT o.ShipCountry
, round(SUM(od.UnitPrice * od.Quantity - od.UnitPrice * od.Quantity * od.Discount), 2) AS Sum 
FROM Orders o 
INNER JOIN "Order Details" od ON o.OrderID = od.OrderID
GROUP BY o.ShipCountry;
--Given the Northwind database (see the structure below).
--Show the list of product categories along with total ordering sums (considering Discount) calculated for the orders made for the products of each category, during the year 1997.
select c.CategoryName
, sum(od.Quantity * od.UnitPrice * (1 - od.Discount)) AS sum 
from Categories c 
join Products p 
on c.CategoryID = p.CategoryID 
join "Order Details" od 
on p.ProductID = od.ProductID 
join  Orders o 
on o.OrderID = od.OrderID 
where strftime('%Y', o.ShippedDate) = 1997
group by c.CategoryName
--Given the Northwind database (see the structure below).
--Show the list of product names along with unit prices and the history of unit prices taken from the orders (show ‘Product name – Unit price – Historical price’). The duplicate records should be eliminated. If no orders were made for a certain product, then the result for this product should look like ‘Product name – Unit price – NULL’. Sort the list by the product name.
SELECT DISTINCT p.ProductName, p.UnitPrice, o.UnitPrice AS HistoricalPrice
FROM Products p
LEFT JOIN "Order Details" o on p.ProductID = o.ProductID
ORDER BY p.ProductName;
--Given the Northwind database (see the structure below).
--Show the list of employees’ names along with names of their chiefs (use left join with the same table).
SELECT e.LastName 
, e.FirstName 
, e2.LastName as ChiefLastName
, e2.FirstName as ChiefFirstName
from Employees e 
LEFT JOIN Employees e2 
ON e.ReportsTo = e2.EmployeeID;
--Given the Northwind database (see the structure below).
--Show the list of cities where employees and customers are from. Duplicates should be eliminated.
select DISTINCT e.City 
from Employees e 
union 
select DISTINCT c.City 
from 
Customers c 
union
select DISTINCT o.ShipCity  
FROM Orders o 
where o.ShipCity != 'Colchester'

