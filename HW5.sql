-- PRESENTATON --
--1. Show the list of French customers’ names who used to order non-French products.
select distinct c.company_name
from customers c
join orders o on c.customer_id = o.customer_id
join order_details od on o.order_id = od.order_id
join products p on od.product_id = p.product_id
join suppliers s on p.supplier_id = s.supplier_id
where c.country = 'France' and s.country <> 'France';

--2. Show the list of suppliers, products and its category.
select s.supplier_id, s.company_name, p.product_name, c.category_name
from products p 
join suppliers s on s.supplier_id = p.supplier_id 
join categories c on p.category_id = c.category_id;

--3. Create a report that shows all  information about suppliers and products.   
select distinct *
from products p 
join suppliers s on p.supplier_id = s.supplier_id;


-- SOFT SERVE ACADEMY --
-- 1. Show first and last names of the employees who used to serve orders shipped to Madrid. The result set would be ordered by first name.
select distinct e.FirstName,e.LastName
from Employees e 
inner join Orders o on o.EmployeeID = e.EmployeeID
where o.ShipCity like 'Madrid'
order by e.FirstName;

-- 2. Write the query, which will show the first and last names of the employees (whether they served orders or not) as well as the count of orders (CountOfOrders) where served by each of them. ote. Use LEFT JOIN
select e.FirstName, e.LastName, count(o.OrderId) as CountOfOrders
from Employees e 
left join Orders o on e.EmployeeId = o.EmployeeId
group by e.FirstName, e.LastName
order by e.FirstName;

-- 3. Show the first and last names of the employees as well as the count of their orders shipped (ShippedDate) after the required date (RequiredDate) which were ordered during the year 1997 (use left join).
SELECT e.FirstName, e.LastName, COUNT(o.OrderID) AS CountOfOrder
FROM Employees e
LEFT JOIN Orders o ON e.EmployeeID = o.EmployeeID 
AND strftime('%Y', o.OrderDate) = '1997' 
AND o.ShippedDate > o.RequiredDate 
GROUP BY e.EmployeeID, e.FirstName, e.LastName
HAVING COUNT(o.OrderID) > 0
ORDER BY e.FirstName;

-- 4. Show category names (without duplicates) of products that where ordered by customers that are located in Madrid
SELECT DISTINCT Categories.CategoryName AS Name
FROM Categories
JOIN Products ON Categories.CategoryID = Products.CategoryID
JOIN [Order Details] ON Products.ProductID = [Order Details].ProductID
JOIN Orders ON [Order Details].OrderID = Orders.OrderID
JOIN Customers ON Orders.CustomerID = Customers.CustomerID
WHERE Customers.City = 'Madrid';

-- 5. Show the list of french customers’ names who have made more than one order (use grouping).
SELECT c.ContactName, COUNT(o.OrderID) AS CountOfOrder
FROM Customers c 
JOIN Orders o ON c.CustomerID = o.CustomerID 
AND c.Country = 'France'
GROUP BY c.ContactName
HAVING COUNT(o.OrderID) > 1 
ORDER BY c.ContactName;
