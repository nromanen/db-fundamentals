-- 1. Show the list of french customers’ names who used to order non-french products (use left join).
SELECT DISTINCT c.ContactName
FROM Customers c
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN [Order Details] od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
JOIN Suppliers s ON p.SupplierID = s.SupplierID
WHERE c.Country = 'France' AND s.Country <> 'France';

-- 2. Show the list of french customers’ names who used to order french products. The list should be ordered in ascending order.
SELECT DISTINCT Customers.ContactName
FROM Customers
JOIN Orders ON Customers.CustomerID = Orders.CustomerID
JOIN [Order Details] ON Orders.OrderID = [Order Details].OrderID
JOIN Products ON [Order Details].ProductID = Products.ProductID
JOIN Suppliers ON Products.SupplierID = Suppliers.SupplierID
WHERE Customers.Country = 'France' AND Suppliers.Country = 'France'
ORDER BY Customers.ContactName ASC;

-- 3. Show the total ordering sum calculated for each country where orders were shipped. While calculating the sum take into account the value of the discount (Discount).
SELECT ShipCountry, Round(SUM(UnitPrice * Quantity - (UnitPrice * Quantity) * Discount ),2) AS Sum
FROM Orders
JOIN [Order Details] ON Orders.OrderID = [Order Details].OrderID
GROUP BY ShipCountry;

-- 4 X. Show the list of product categories along with total ordering sums (considering Discount) calculated for the orders made for the products of each category, during the year 1997.
SELECT Categories.CategoryName, round(SUM([Order Details].UnitPrice * [Order Details].Quantity * (1 - [Order Details].Discount)),2) AS Sum
FROM Products
JOIN Categories ON Products.CategoryID = Categories.CategoryID
JOIN [Order Details] ON Products.ProductID = [Order Details].ProductID
JOIN Orders ON [Order Details].OrderID = Orders.OrderID
WHERE strftime('%Y', Orders.ShippedDate) = '1997'
GROUP BY Categories.CategoryName;

-- 5. Show the list of product names along with unit prices and the history of unit prices taken from the orders (show ‘Product name – Unit price – Historical price’). The duplicate records should be eliminated. If no orders were made for a certain product, then the result for this product should look like ‘Product name – Unit price – NULL’. Sort the list by the product name. 
SELECT DISTINCT Products.ProductName, Products.UnitPrice, [Order Details].UnitPrice AS HistoricalPrice
FROM Products
LEFT JOIN [Order Details] ON Products.ProductID = [Order Details].ProductID
LEFT JOIN Orders ON [Order Details].OrderID = Orders.OrderID
ORDER BY Products.ProductName;

-- 6. Show the list of employees’ names along with names of their chiefs (use left join with the same table).
SELECT e1.LastName, e1.FirstName, e2.LastName AS ChiefLastName,  e2.FirstName  AS ChiefFirstName 
FROM Employees e1
LEFT JOIN Employees e2 ON e1.ReportsTo = e2.EmployeeID;

-- 7. Show the list of cities where employees and customers are from. Duplicates should be eliminated.
INSERT INTO Customers(CustomerID, CompanyName, City)
VALUES ('ZROZR', 'CMP', 'Colchester');
SELECT DISTINCT City
FROM (
    SELECT City FROM Employees
    UNION ALL
    SELECT City FROM Customers
) AS Cities
ORDER BY City;
