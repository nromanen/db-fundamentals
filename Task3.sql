--Return all the fields about all the shippers

select * from Shippers

-----------------------------------------------------------------

--Return CategoryName and Description from Categories table.

select CategoryName, Description from Categories

-----------------------------------------------------------------

--FirstName, LastName, and HireDate of all the employees with the value 'Sales Representative' in the  Title field.

select FirstName, LastName, HireDate from Employees as e where Title="Sales Representative"

-----------------------------------------------------------------

--show the SupplierID, ContactName, and ContactTitle for those Suppliers whose ContactTitle is not 'Marketing Manager'

select  SupplierID, ContactName, ContactTitle from Suppliers where ContactTitle<>"Marketing Manager"

-----------------------------------------------------------------

--ProductID and ProductName for those products where the ProductName includes the string “queso”

select ProductID, ProductName from Products where ProductName Like "%queso%"

-----------------------------------------------------------------

--Write a query that shows the OrderID, CustomerID, and ShipCountry for the orders where the ShipCountry is either 'France' or 'Belgium'.

Select OrderID, CustomerID, ShipCountry from orders where ShipCountry IN ('France' , 'Belgium')

-----------------------------------------------------------------

--show the FirstName, LastName, Title, and BirthDate.
--Order the results by BirthDate, so we have the oldest employees first.
--Note. Exclude those employees from the result set whose BirthDate is undefined.

Select FirstName, LastName, Title, BirthDate from Employees where BirthDate is not null Order by BirthDate

-----------------------------------------------------------------

--show the FirstName and LastName columns from the Employees table, and then create a new column called FullName,
--showing FirstName and LastName joined together in one column, with a space (' ') in between

select FirstName,LastName, firstname || ' ' || lastname as FullName from Employees 

-----------------------------------------------------------------

--For the orders with OrderID in range 10250 ..10259 create a new field, TotalPrice, that multiplies UnitPrice and Quantity together. We’ll ignore the Discount field for now.
--In addition, show the OrderID, ProductID, UnitPrice, and Quantity. Order by OrderID and ProductID.

select OrderID, ProductID, UnitPrice, Quantity, Quantity*UnitPrice as TotalPrice
from "Order Details"
where OrderID between 10250 and 10259
Order by OrderID and ProductID

-----------------------------------------------------------------

--How many customers do we have in Germany?

select count(city) as "count(*)" from customers where country="Germany" 

-----------------------------------------------------------------