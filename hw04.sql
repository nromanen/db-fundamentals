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


--create a report with employees full names and their time on job (<30 years, 30 years, >30 years)

select concat_ws(' ', e.first_name, e.last_name) as full_name,
case
	when extract(year from age(e.hire_date)) < 30 then 'less than 30 years'
	when extract(year from age(e.hire_date)) = 30 then '30 years'
	else 'more than 30 years'
end as years_on_job
from employees e


--Write a query to get Product name and quantity/unit.

select p.product_name, p.quantity_per_unit
from products p


--Write a query to get current Product list (Product ID and name).

select p.product_id, p.product_name
from products p
where p.discontinued <> 1


--Write a query to get discontinued Product list (Product ID and name).

select p.product_id, p.product_name
from products p
where p.discontinued = 1


--Write a query to get Product list (id, name, unit price) where products cost between $15 and $25

select p.product_id, p.product_name, p.unit_price
from products p
where p.unit_price between 15 and 25


--Write a query to get Product list (name, unit price) of above average price.

select p.product_name, p.unit_price
from products p
where p.unit_price > (select avg(unit_price) from products)


--Write a query to get Product list (name, unit price) of ten most expensive products.

select p.product_name, p.unit_price
from products p
order by p.unit_price desc
limit 10


--Write a query to count current and discontinued products.

select
case
	when p.discontinued = 1 then 'discontinued'
	else 'current'
end as status
	,count(*) as number_of_products
from products p
group by p.discontinued


--Write a query to get Product list (name, units on order, units in stock) if stock is less than the quantity on order.

select p.product_name, p.units_on_order, p.units_in_stock
from products p
where p.units_in_stock < p.units_on_order