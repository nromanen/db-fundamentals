--Show the date of the first order ever made in the Orders table.

select min(OrderDate)
from Orders


--Show a list of countries where the Northwind company has customers and the number of Customers who work there (alias NumberOfCustomers).
--The result should be sorted by NumberOfCustomers in descending order

select Country, count(*) as NumberOfCustomers
from Customers
group by Country
order by count(*) desc, Country asc


--Show a list of countries where Northwind company has customers and the number of Customers who work there (alias NumberOfCustomers).
--The result should contain only the data about countries where the number of customers equals or exceeds 3.
--The result should be sorted by NumberOfCustomers in descending order

select Country, count(*) as NumberOfCustomers
from Customers
group by Country
having count(*) >= 3
order by NumberOfCustomers desc, country asc


--Show a list of all the different values in the Customers table for ContactTitles. Also include a count for each ContactTitle (alias TotalContactTitle). 
--The result set should be sorted in descending order by TotalContactTitle.

select distinct ContactTitle , count(*) as TotalContactTitle
from Customers
group by ContactTitle
order by count(*) desc, ContactTitle


--Write a query that should show the list of CategoryID, the number of all products within each category (NumberOfProducts) 
--only for those products with the value UnitsInStock less than UnitsOnOrder. 
--These two columns should be included in the result as well. 
--Moreover, the report should contain only the rows where NumberOfProducts is more than 1. 
--The result set should be sorted in ascending order by NumberOfProducts.



--We want to show the number of orders (NumberOfOrders) and the average Freight (AverageFreight) shipped to any Latin American country. 
--But we don’t have a list of Latin American countries in a table in the Northwind database. 
--So, we’re going to just use this list of Latin American countries that happen to be in the Orders table: 
--Brazil, Mexico, Argentina, and Venezuela.
--The value AverageFreight should be rounded to the 2nd digit after the decimal point. Use this column for ascending order.

select ShipCountry, count(*) as NumberOfOrders, round(avg(cast(Freight as numeric)), 2) as AverageFreight
from Orders
where ShipCountry in ('Brazil', 'Mexico', 'Argentina', 'Venezuela')
group by ShipCountry
order by count(*)


--Create a report about the total sum (TotalOrder) of each order, where the discount was used. 
--Use the expression UnitPrice * Quantity * (1 - Discount). 
--The value TotalOrder should be rounded to the 2nd digit after the decimal point. Use this column for sorting in descending order.
--The result should contain only the rows with TotalOrder greater than 5000.

select OrderID, sum(round(cast((UnitPrice * Quantity * (1 - Discount)) as numeric), 2)) as TotalOrder
from "Order Details"
where Discount > 0
group by OrderID
having sum(round(cast((UnitPrice * Quantity * (1 - Discount)) as numeric), 2)) > 5000
order by sum(round(cast((UnitPrice * Quantity * (1 - Discount)) as numeric), 2)) desc


--Create a report about the total sum of Freight (TotalFreight) shipped by every employee within each specified year of order (OrderYear).
--Show the result only for TotalFreight greater than 2000.
--The result should be sorted by OrderYear and EmployeeID both ascending.

SELECT strftime('%Y', OrderDate) AS OrderYear, EmployeeID, SUM(Freight) AS TotalFreight
FROM Orders
GROUP BY OrderYear, EmployeeID
HAVING SUM(Freight) > 2000
ORDER BY OrderYear, EmployeeID;


--Create a report that shows EmployeeID and the total number of late orders (NumberOfDelayedOrders) for each of them. 
--The condition of late orders is RequiredDate less than ShippedDate.
--The result should be sorted by NumberOfDelayedOrders descending.

select EmployeeID, count(*) as NumberOfDelayedOrders
from Orders
where RequiredDate < ShippedDate
group by EmployeeID
order by count(*) desc, EmployeeID


--Create a report that displays the number of female and male employees (NumberOfEmployees) in the positions they held.

select Title, TitleOfCourtesy, count(*) as NumberOfEmployees
from Employees
group by Title, TitleOfCourtesy


--
