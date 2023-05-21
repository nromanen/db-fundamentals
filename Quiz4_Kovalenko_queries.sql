--1. Show the date of the first order ever made in the Orders table.
select MIN(OrderDate) 
from orders


--2. We have a table Customers. Show a list of countries where the Northwind company has customers 
-- and the number of Customers who work there (alias NumberOfCustomers).
The result should be sorted by NumberOfCustomers in descending order
select country, count(CustomerID) as NumberOfCustomers
from customers c
group by country
order by NumberOfCustomers desc, country


--3. We have a table Customers. Show a list of countries where Northwind company has customers 
-- and the number of Customers who work there (alias NumberOfCustomers). The result should contain only 
-- the data about countries where the number of customers equals or exceeds 3. The result should be
-- sorted by NumberOfCustomers in descending order.
select Country, count(*) as NumberOfCustomers
from Customers 
group by Country
having count(*) >= 3
order by NumberOfCustomers desc, country


--4. From customers table show a list of all the different values in the Customers table for ContactTitles. Also 
-- include a countfor each ContactTitle (alias TotalContactTitle). The result set should be sorted in descending
-- order by TotalContactTitle.
select ContactTitle, count(CustomerID) as TotalContactTitle 
from customers c
group by ContactTitle 
order by TotalContactTitle desc, ContactTitle


--5. From table Products write a query that should show the list of CategoryID, the number of all products 
-- within each category (NumberOfProducts) only for those products with the value UnitsInStock less than
-- UnitsOnOrder. The report should contain only the rows where NumberOfProducts is more than 1. 
-- The result set should be sorted in ascending order by NumberOfProducts.
select categoryid, count(unitprice*unitsonorder) as NumberOfProducts
from products p
where unitsinstock < unitsonorder
group by categoryid
having NumberOfProducts > 1
order by NumberOfProducts asc


--6.From Orders table. We want to show the number of orders (NumberOfOrders) and the average Freight(AverageFreight)
--shipped to any Latin American country. But we don’t have a list of Latin American countries in a table in 
-- the Northwind database. So, we’re going to just use this list of Latin American countries that happen to be 
-- in the Orders table: Brazil, Mexico, Argentina, and Venezuela. The value AverageFreight should be rounded to
-- the 2nd digit after the decimal point. Use this column for ascending order.
select ShipCountry, count(*) as NumberOfOrders, round(avg(Freight),2) as AverageFreight 
from orders
where ShipCountry in ('Argentina', 'Mexico', 'Brazil', 'Venezuela')
group by ShipCountry
order by NumberOfOrders asc


--7. From table Order Details create a report about the total sum (TotalOrder) of each order, where the 
-- discount was used. Use the expression UnitPrice * Quantity * (1 - Discount). The value TotalOrder should be
-- rounded to the 2nd digit after the decimal point. Use this column for sorting in descending order.
-- The result should contain only the rows with TotalOrder greater than 5000.
select OrderID, round(sum(cast(unitprice  * quantity  * (1 - discount)as numeric)),2) as TotalOrder
from 'Order details'
where Discount != 0
group by OrderID 
having round(sum(cast(unitprice  * quantity  * (1 - discount)as numeric)),2) > 5000
order by TotalOrder desc


--8. From a table Orders create a report about the total sum of Freight (TotalFreight) shipped by every
-- employee within each specified year of order (OrderYear). Show the result only for TotalFreight greater
-- than 2000. The result should be sorted by OrderYear and EmployeeID both ascending.
-- Note. You need to use function strftime('%Y', OrderDate) to extract year from date.
select strftime('%Y', OrderDate) as OrderYear, EmployeeID,
sum(Freight) as TotalFreight
from Orders
group by OrderYear, EmployeeID
having sum(Freight) > 2000
order by OrderYear asc


--9. We have a table Orders. Create a report that shows EmployeeID and the total number of late orders 
-- (NumberOfDelayedOrders) for each of them. The condition of late orders is RequiredDate less than
-- ShippedDate. The result should be sorted by NumberOfDelayedOrders descending.
select EmployeeID, count(*) as NumberOfDelayedOrders
from Orders
where RequiredDate < ShippedDate
group by EmployeeID
order by NumberOfDelayedOrders desc, EmployeeID asc


--10. From table Employees create a report that displays the number of female and male employees 
-- (NumberOfEmployees) in the positions they held.
select Title, TitleOfCourtesy, count(*) as NumberOfEmployees
from Employees
group by Title, TitleOfCourtesy

