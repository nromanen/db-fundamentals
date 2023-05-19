--1. Return all the fields about all the shippers.
select *
from Shippers

--2. Return two columns, CategoryName and Description from Categories table.
select  CategoryName, Description
from Categories

--3. Return  FirstName, LastName, and HireDate of all the employees with the value 'Sales Representative' in the  Title field.
select FirstName, LastName, HireDate
from employees
where Title = 'Sales Representative'

--4. Show the SupplierID, ContactName, and ContactTitle for those Suppliers whose ContactTitle is not 'Marketing Manager'.
select SupplierID, ContactName, ContactTitle
from suppliers
where not ContactTitle = 'Marketing Manager';

--5. Show ProductID and ProductName from products where the ProductName includes the string “queso”.
select ProductID, ProductName
from products
where ProductName like 'queso%'

--6. Write a query that shows the OrderID, CustomerID, and ShipCountry for the orders where the ShipCountry is either 'France' or 'Belgium' from Orders table.
select OrderID, CustomerID, ShipCountry
from orders
where ShipCountry IN ('France', 'Belgium')

--7. For all the employees in the Employees table, show the FirstName, LastName, Title, and BirthDate. Order the results by BirthDate, so we have the oldest employees first.
--Note. Exclude those employees from the result set whose BirthDate is undefined. 
select FirstName, LastName, Title, BirthDate
from Employees
where BirthDate != 'Null'
Order by BirthDate

--8. For all the employees in the Employees table, show the FirstName and LastName columns from the Employees table, and then create a new column called FullName, 
--showing FirstName and LastName joined together in one column, with a space (' ') in between.
select e.FirstName, e.LastName,
e.FirstName || ' ' || e.LastName as FullName
from Employees e

--9. In the OrderDetails table, we have the fields UnitPrice and Quantity. For the orders with OrderID in range 10250 ..10259 create a new field, TotalPrice, that multiplies UnitPrice and Quantity together. 
--Show the OrderID, ProductID, UnitPrice, and Quantity. Order by OrderID and ProductID.
select OrderID, ProductID, UnitPrice, Quantity,
(UnitPrice*Quantity) as TotalPrice
from 'Order Details'
where OrderID between 10250 and 10259
order by OrderID, ProductID

--10. How many customers do we have in Germany? The result set should contain only one value.
Select count(*) from customers where country = 'Germany'