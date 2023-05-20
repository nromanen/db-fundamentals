--1.Return all the fields about all the shippers
select *
from Shippers

--2.Selecting all the fields using this SQL: 
--select * from Categories 
--…will return 4 columns. We only want to see two columns, CategoryName and Description.
select CategoryName, Description
from Categories
 
--3.We’d like to see just the FirstName, LastName, and HireDate of all the employees with
--the value 'Sales Representative' in the  Title field. Write a SQL statement that returns only those employees.
select FirstName, LastName, HireDate
from Employees
where Title = 'Sales Representative'

--4.Show the SupplierID, ContactName, and ContactTitle for those Suppliers whose ContactTitle is not 'Marketing Manager'
select SupplierID, ContactName, ContactTitle from Suppliers
where not ContactTitle = 'Marketing Manager'

--5.We’d like to see the ProductID and ProductName for those products where the ProductName includes the string “queso”.
select ProductID, ProductName from Products 
where ProductName like '%queso%'

--6.Write a query that shows the OrderID, CustomerID, and ShipCountry for the orders where the ShipCountry is either 'France' or 'Belgium'.
select OrderID
, CustomerID
, ShipCountry 
from Orders
where ShipCountry in ('France', 'Belgium')

--7.Show the FirstName, LastName, Title, and BirthDate.
--Order the results by BirthDate, so we have the oldest employees first.
--Note. Exclude those employees from the result set whose BirthDate is undefined.
select FirstName, LastName, Title, BirthDate
from Employees
where BirthDate is not null
order by BirthDate

--8.Show the FirstName and LastName columns from the Employees table, and then create a new column called FullName,
--showing FirstName and LastName joined together in one column, with a space (' ') in between
select FirstName, LastName, FirstName || ' ' || LastName as FullName 
from Employees

--9.For the orders with OrderID in range 10250 ..10259 create a new field, TotalPrice, that multiplies UnitPrice and Quantity together.
--We’ll ignore the Discount field for now. In addition, show the OrderID, ProductID, UnitPrice, and Quantity.
--Order by OrderID and ProductID.
select o.OrderID
, o.ProductID
, o.UnitPrice
, o.Quantity
, o.UnitPrice * o.Quantity as TotalPrice
from "Order Details" as o
where OrderID between 10250 and 10259
order by OrderID, ProductID

--10.How many customers do we have in Germany? The result set should contain only one value.
--Note. In order to get the total number of customers in Germany, we need to use what’s called an aggregate function.
select count(*) 
from Customers
where Country = 'Germany'
