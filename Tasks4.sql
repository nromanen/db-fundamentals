--Task from Discord
select concat(e.first_name, ' ', e.last_name) as full_name
--, extract (year from age(e.hire_date)) as years_at_work
--, e.hire_date, 
, case when extract (year from age(e.hire_date)) < 30 then 'less than 30'
	when extract (year from age(e.hire_date)) = 30 then 'exactly 30'
	else 'more than 30' end
	as years_at_work_group
from employees e 

--TASKS FROM LMS

--Q1
--We have a table Orders. 
--Show the date of the first order ever made in the Orders table.

----SQLite
--select MIN(OrderDate)
--from orders

select min(order_date)
from orders

--Q2
--We have a table Customers. 
--Show a list of countries where the Northwind company has customers and the number of Customers who work there (alias NumberOfCustomers).
--The result should be sorted by NumberOfCustomers in descending order

----SQLite
--select country,
--count(country) as NumberOfCustomers
--from customers
--group by country
--order by NumberOfCustomers desc, country

select c.country
, count(c.country) as NumberOfCustomers
from customers c 
group by c.country
order by NumberOfCustomers desc, c.country 

--Q3
--We have a table Customers. 
--Show a list of countries where Northwind company has customers and the number of Customers who work there (alias NumberOfCustomers).
--The result should contain only the data about countries where the number of customers equals or exceeds 3.
--The result should be sorted by NumberOfCustomers in descending order

----SQLite
--select country,
--count(country) as NumberOfCustomers
--from customers
--group by country
--having NumberOfCustomers >= 3
--order by NumberOfCustomers desc, country

select c.country
, count(c.country) as NumberOfCustomers
from customers c 
group by c.country
having count(c.country) >= 3
order by count(c.country) desc, c.country


--Q4
--We have a table Customers. 
--Show a list of all the different values in the Customers table for ContactTitles. Also include a count for each ContactTitle (alias TotalContactTitle). 
--The result set should be sorted in descending order by TotalContactTitle.

----SQLite
--select distinct contacttitle,
--count(contacttitle) as TotalContactTitle
--from customers
--group by contacttitle
--order by TotalContactTitle desc, ContactTitle

select distinct c.contact_title
, count(c.contact_title) as TotalContactTitle
from customers c 
group by c.contact_title 
order by TotalContactTitle desc, c.contact_title 

--Q5
----SQLite
--select CategoryID
--, count(ProductID) as NumberOfProducts
--, sum(UnitsInStock)
--, sum(UnitsOnOrder)
--from Products
--where UnitsInStock < UnitsOnOrder
--group by CategoryID
--having NumberOfProducts > 1
--order by NumberOfProducts

select p.category_id 
, count(category_id) as NumberOfProducts
, sum(p.units_in_stock)
, sum(p.units_on_order)
from products p 
where p.units_in_stock < p.units_on_order
group by p.category_id
having count(category_id) > 1
order by NumberOfProducts

--Q6
--We have a table Orders. 
--We want to show the number of orders (NumberOfOrders) and the average Freight (AverageFreight) shipped to any Latin American country. 
--But we don’t have a list of Latin American countries in a table in the Northwind database. 
--So, we’re going to just use this list of Latin American countries that happen to be in the Orders table: Brazil, Mexico, Argentina, and Venezuela.
--The value AverageFreight should be rounded to the 2nd digit after the decimal point. Use this column for ascending order.

----SQLite
--select ShipCountry
--, count(ShipCountry) as NumberOfOrders
--, round(avg(Freight), 2) as AverageFreight
--from orders
--group by ShipCountry
--having ShipCountry in ('Argentina', 'Mexico', 'Venezuela', 'Brazil')
--order by NumberOfOrders

select o.ship_country 
, count(o.ship_country) as NumberOfOrders
, round(avg(o.freight)::numeric, 2) as AverageFreight
from orders o 
group by o.ship_country 
having o.ship_country in ('Argentina', 'Mexico', 'Venezuela', 'Brazil')
order by NumberOfOrders

--Q7 
--We have a table "Order Details". 
--Create a report about the total sum (TotalOrder) of each order, where the discount was used. Use the expression UnitPrice * Quantity * (1 - Discount). 
--The value TotalOrder should be rounded to the 2nd digit after the decimal point. Use this column for sorting in descending order.
--The result should contain only the rows with TotalOrder greater than 5000.

----SQLite
--select OrderID
--, round(sum(UnitPrice * Quantity * (1 - Discount)), 2) as TotalOrder
--from "Order Details"
--where Discount > 0
--group by OrderID
--having TotalOrder > 5000
--order by TotalOrder desc

select od.order_id 
, round(sum(od.unit_price * od.quantity * (1 - od.discount))::numeric, 2) as TotalOrder
from order_details od  
where od.discount > 0
group by od.order_id 
having round(sum(od.unit_price * od.quantity * (1 - od.discount))::numeric, 2) > 5000
order by TotalOrder desc

--Q8
--We have a table Orders. 
--Create a report about the total sum of Freight (TotalFreight) shipped by every employee within each specified year of order (OrderYear).
--Show the result only for TotalFreight greater than 2000.
--The result should be sorted by OrderYear and EmployeeID both ascending.

----SQLite
--select strftime('%Y', OrderDate) as OrderYear
--, EmployeeID
--, sum(Freight) as TotalFreight
--from Orders
--group by OrderYear, EmployeeID
--having TotalFreight > 2000

select extract (year from o.order_date) as OrderYear
, o.employee_id 
, sum(o.freight) as TotalFreight
from orders o 
group by OrderYear, o.employee_id
having sum(o.freight) > 2000

--Q9
--We have a table Orders. 
--Create a report that shows EmployeeID and the total number of late orders (NumberOfDelayedOrders) for each of them. 
--The condition of late orders is RequiredDate less than ShippedDate.
--The result should be sorted by NumberOfDelayedOrders descending.

----SQLite
--select EmployeeID
--, count(EmployeeID) as NumberOfDelayedOrders
--from Orders
--where RequiredDate < ShippedDate
--group by EmployeeID
--order by NumberOfDelayedOrders desc, EmployeeID

select o.employee_id 
, count(o.employee_id) as NumberOfDelayedOrders
from orders o 
where o.required_date < o.shipped_date 
group by o.employee_id 
order by NumberOfDelayedOrders desc, o.employee_id 

--Q10
--We have a table Employees. 
--Create a report that displays the number of female and male employees (NumberOfEmployees) in the positions they held.

----SQLite
--select Title
--, TitleOfCourtesy
--, count(TitleOfCourtesy) as NumberOfEmployees
--from Employees
--group by TitleOfCourtesy, Title
--order by Title

select e.title 
, e.title_of_courtesy 
, count(e.title_of_courtesy) as NumberOfEmployees
from employees e 
group by e.title_of_courtesy, e.title 
order by e.title 