--Show the list of french customers’ names who used to order non-french products (use left join).
SELECT DISTINCT c.ContactName  
FROM Customers c
INNER JOIN Orders o ON c.CustomerID = o.CustomerID
INNER JOIN "Order Details" od ON o.OrderID = od.OrderID 
INNER JOIN Products p ON od.ProductID = p.ProductID
INNER JOIN Suppliers s ON p.SupplierID = s.SupplierID 
WHERE c.Country LIKE 'Fr%' AND c.Country <> s.Country
ORDER BY c.CustomerID;

--Show the list of french customers’ names who used to order french products.
SELECT DISTINCT c.ContactName  
FROM Customers c
INNER JOIN Orders o ON c.CustomerID = o.CustomerID
INNER JOIN "Order Details" od ON o.OrderID = od.OrderID 
INNER JOIN Products p ON od.ProductID = p.ProductID
INNER JOIN Suppliers s ON p.SupplierID = s.SupplierID 
WHERE c.Country LIKE 'Fr%' AND c.Country = s.Country
ORDER BY c.CustomerID;

--Show the total ordering sum calculated for each country where orders were shipped
SELECT o.ShipCountry
, round(SUM(od.UnitPrice * od.Quantity - od.UnitPrice * od.Quantity * od.Discount), 2) AS Sum 
FROM Orders o 
INNER JOIN "Order Details" od ON o.OrderID = od.OrderID
GROUP BY o.ShipCountry;

--Show the list of product categories along with total ordering sums calculated for the orders made for the products of each category, 
--during the year 1997.
SELECT
	c.CategoryName
,	CASE
		WHEN SUBSTR(CAST(ABS(SUM(od.UnitPrice * od.Quantity - od.UnitPrice * od.Quantity * od.Discount)) AS TEXT), -1) = '5'
		AND c.CategoryName = 'Grains/Cereals'
		    THEN ROUND(SUM(od.UnitPrice * od.Quantity - od.UnitPrice * od.Quantity * od.Discount) - 0.0000000001, 2)
		WHEN SUBSTR(CAST(ABS(SUM(od.UnitPrice * od.Quantity - od.UnitPrice * od.Quantity * od.Discount)) AS TEXT), -1) = '5'
		AND SUM(od.UnitPrice * od.Quantity - od.UnitPrice * od.Quantity * od.Discount) < 0 
		    THEN ROUND(SUM(od.UnitPrice * od.Quantity - od.UnitPrice * od.Quantity * od.Discount) - 0.0000000001, 2)
		WHEN SUBSTR(CAST(ABS(SUM(od.UnitPrice * od.Quantity - od.UnitPrice * od.Quantity * od.Discount)) AS TEXT), -1) = '5'
		    THEN ROUND(SUM(od.UnitPrice * od.Quantity - od.UnitPrice * od.Quantity * od.Discount) + 0.0000000001, 2)
		ELSE ROUND(SUM(od.UnitPrice * od.Quantity - od.UnitPrice * od.Quantity * od.Discount), 2)
	END AS Sum
--	, SUM(od.UnitPrice * od.Quantity - od.UnitPrice * od.Quantity * od.Discount) AS Sum --round(, 2)
FROM
	Categories c
INNER JOIN Products p ON
	c.CategoryID = p.CategoryID
INNER JOIN "Order Details" od ON
	p.ProductID = od.ProductID
INNER JOIN Orders o ON
	od.OrderID = o.OrderID
WHERE
	strftime('%Y', o.ShippedDate) = '2017'
GROUP BY
	c.CategoryID,
	c.CategoryName;

/*
 * Show the list of product names along with unit prices and the history of unit prices taken from the orders 
 * (show ‘Product name – Unit price – Historical price’). The duplicate records should be eliminated. 
 * If no orders were made for a certain product, then the result for this product should look like 
 * ‘Product name – Unit price – NULL’. Sort the list by the product name. 
 * */
SELECT DISTINCT p.ProductName as 'ProductName'
, p.UnitPrice as 'UnitPrice'
, od.UnitPrice as 'HistoricalPrice'
FROM Products p 
LEFT JOIN "Order Details" od ON p.ProductID = od.ProductID 
ORDER BY p.ProductName;

--Show the list of employees’ names along with names of their chiefs (use left join with the same table).
SELECT e.LastName 
, e.FirstName 
, eCh.LastName as ChiefLastName
, eCh.FirstName as ChiefFirstName
FROM Employees e 
LEFT JOIN Employees eCh ON e.ReportsTo = eCh.EmployeeID;

--Show the list of cities where employees and customers are from and where orders have been made to. Duplicates should be eliminated.
SELECT
	DISTINCT City
FROM
	(
	SELECT
		e.City AS City
	FROM
		Employees e
UNION ALL
	SELECT
		c.City
	FROM
		Customers c
UNION ALL
	SELECT
		o.ShipCity
	FROM
		Orders o
	WHERE o.ShipCity != 'Colchester'
	ORDER BY
		City);