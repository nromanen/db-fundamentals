--Given the Northwind database (see the structure below).

--Show first and last names of the employees who used to serve orders shipped to Madrid. The result set would be ordered by first name.
select distinct e.FirstName
, e.LastName 
from Employees e inner join Orders o 
on e.EmployeeId = o.EmployeeId 
where o.ShipCity like 'Madrid'
order by FirstName;

--Write the query, which will show the first and last names of the employees (whether they served orders or not) as well as the count of orders (CountOfOrders) where served by each of them. 
select e.FirstName
, e.LastName
, count(o.OrderId) as CountOfOrders
from Employees e left join Orders o 
on e.EmployeeId = o.EmployeeId
group by e.FirstName, e.LastName
order by e.FirstName;

--Show first and last names of the employees as well as the count of their orders shipped after required date during the year 1997 (use left join).
SELECT e.FirstName
, e.LastName
, COUNT(o.OrderID) AS CountOfOrder
FROM Employees e 
LEFT JOIN Orders o ON e.EmployeeID = o.EmployeeID
AND strftime('%Y', o.OrderDate) = '1997' AND o.ShippedDate > o.RequiredDate
GROUP BY e.EmployeeID, e.FirstName, e.LastName
ORDER BY e.FirstName;

--Show first and last names of the employees who used to serve orders shipped to Madrid.
select distinct e.FirstName
, e.LastName 
from Employees e inner join Orders o 
on e.EmployeeId = o.EmployeeId 
where o.ShipCity like 'Madrid'
order by FirstName;

--Show the list of french customers’ names who have made more than one order (use grouping).
SELECT C.ContactName
, COUNT(O.OrderID) AS CountOfOrder
FROM Customers C
INNER JOIN Orders O ON C.CustomerID = O.CustomerID
WHERE C.Country LIKE 'France'
GROUP BY C.CustomerID, C.ContactName
ORDER BY C.ContactName;
