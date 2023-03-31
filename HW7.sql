--Given the Northwind database (see the structure below).
--Show the list of customers’ names who used to order the ‘Tofu’ product (use a subquery).
SELECT ContactName 
FROM Customers 
WHERE CustomerID IN (SELECT CustomerID FROM Orders
WHERE OrderID IN (SELECT OrderID FROM "Order Details"
WHERE ProductID IN (SELECT ProductID FROM Products
WHERE ProductName LIKE 'Tofu')));

--Given the Northwind database (see the structure below).
--Show the list of customers’ names who used to order the ‘Tofu’ product,
--along with the total amount of the product they have ordered
--and with the total sum for ordered product calculated.

SELECT c.ContactName
, sum(od.Quantity) as Amounth
, ROUND(sum(od.UnitPrice * od.Quantity  * (1 - od.Discount)), 2) as Sum
FROM Customers c 
LEFT JOIN Orders o 
on c.CustomerID = o.CustomerID 
LEFT JOIN "Order Details" od 
on o.OrderID = od.OrderID
LEFT JOIN (SELECT * FROM Products) p 
on od.ProductID = p.ProductID
WHERE p.ProductName LIKE 'Tofu'
GROUP BY c.ContactName
ORDER BY c.ContactName;

--Given the Northwind database (see the structure below).
--Show the list of french customers’ names who used to order non-french products (use a subquery).

SELECT c.ContactName 
FROM Customers c 
WHERE c.CustomerID IN (
SELECT o.CustomerID  
FROM Orders o
LEFT JOIN "Order Details" od 
on o.OrderID = od.OrderID 
LEFT JOIN Products p 
on p.ProductID = od.ProductID 
LEFT JOIN Suppliers s 
on s.SupplierID = p.SupplierID 
WHERE s.Country NOT LIKE 'France'
) AND c.Country LIKE 'France'

--Given the Northwind database (see the structure below).
--Show the total ordering sums calculated for each customer’s country for domestic and non-domestic products separately (e.g.: “France – French products ordered – Non-french products ordered” and so on for each country).

SELECT DISTINCT ShipCountry, SUM(Domestic) AS 'Domestic',
SUM([Non-domestic]) AS 'Non-domestic' 
FROM
	(SELECT o.ShipCountry,
	CASE WHEN o.ShipCountry = S.Country
	THEN ROUND (SUM(od.UnitPrice*od.Quantity*(1-od.Discount)), +2)
	ELSE NULL END AS 'Domestic',
	CASE WHEN o.ShipCountry <> S.Country
	THEN ROUND (SUM(od.UnitPrice*od.Quantity*(1-od.Discount)), +2)
	ELSE NULL END AS 'Non-domestic'
	FROM [Order Details] AS od
	LEFT JOIN Orders o on o.OrderID = od.OrderID
	LEFT JOIN Customers c on c.CustomerID = o.CustomerID
	LEFT JOIN Products p on p.ProductID = od.ProductID
	LEFT JOIN Suppliers s on s.SupplierID = p.SupplierID 
	GROUP BY o.ShipCountry, c.ContactName, s.Country) T
GROUP BY ShipCountry