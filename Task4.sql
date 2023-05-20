--01. Show the date of the first order ever made in the Orders table.
--Note. There’s a aggregate function called Min that you need to use for this problem.
select MIN(OrderDate)
from orders o

--02. Show a list of countries where the Northwind company has customers and the number of Customers who work there (alias NumberOfCustomers).
--The result should be sorted by NumberOfCustomers in descending order

select   c.country 
		,count(c.CustomerID) as NumberOfCustomers 
from customers c 
group by c.country 
order by count(c.country) desc, c.country

--03. Show a list of countries where Northwind company has customers and the number of Customers who work there (alias NumberOfCustomers).
--The result should contain only the data about countries where the number of customers equals or exceeds 3.
--The result should be sorted by NumberOfCustomers in descending order

select   c.country 
	    ,count(c.country) as NumberOfCustomers 
from customers c 
group by c.country 
having count(c.country)>=3
order by count(c.CustomerId) desc, c.country 

--04. Show a list of all the different values in the Customers table for ContactTitles. Also include a count for each ContactTitle (alias TotalContactTitle). 
-- The result set should be sorted in descending order by TotalContactTitle.

select c.contacttitle , count(c.contacttitle) as TotalContactTitle
from customers c 
group by c.contacttitle 
order by TotalContactTitle desc, c.contacttitle

--05. Write a query that should show the list of CategoryID, the number of all products within each category (NumberOfProducts) only 
--for those products with the value UnitsInStock less than UnitsOnOrder. These two columns should be included in the result as well. Moreover, 
--the report should contain only the rows where NumberOfProducts is more than 1. 
--The result set should be sorted in ascending order by NumberOfProducts.

select p.categoryid
		,count(p.categoryid) as NumberOfProducts
from products p
where  p.unitsinstock < p.unitsonorder 
group by p.categoryid
having count(p.categoryid)>1
order by NumberOfProducts

--06. We want to show the number of orders (NumberOfOrders) and the average Freight (AverageFreight) shipped to any Latin American country. 
--But we don’t have a list of Latin American countries in a table in the Northwind database. So, we’re going to just use this list of Latin American countries 
--that happen to be in the Orders table: Brazil, Mexico, Argentina, and Venezuela.
--The value AverageFreight should be rounded to the 2nd digit after the decimal point. Use this column for ascending order.

select o.shipcountry
     , count(o.shipcountry) as NumberOfOrders
     , ROUND(cast (avg(o.freight) as numeric),2) as AverageFreight 
from orders o 
where o.shipcountry in ('Brazil', 'Mexico', 'Argentina', 'Venezuela')
group by o.shipcountry
order by numberoforders

--07. Create a report about the total sum (TotalOrder) of each order, where the discount was used. Use the expression UnitPrice * Quantity * (1 - Discount). 
--The value TotalOrder should be rounded to the 2nd digit after the decimal point. Use this column for sorting in descending order.
--The result should contain only the rows with TotalOrder greater than 5000.

select od.orderid, ROUND(sum(cast ((od.unitprice * od.quantity * (1-od.discount)) as numeric)),2) as TotalOrder 
from "order details" od 
where od.discount <> 0
group by od.orderid 
having sum(cast ((od.unitprice * od.quantity * (1-od.discount)) as numeric))>5000
order by TotalOrder desc

--08. Create a report about the total sum of Freight (TotalFreight) shipped by every employee within each specified year of order (OrderYear).
--Show the result only for TotalFreight greater than 2000.
--The result should be sorted by OrderYear and EmployeeID both ascending.

select strftime('%Y', o.orderdate) as OrderYear 
	    , o.employeeid 
	    , ROUND(sum(o.freight),2) as TotalFreight
from orders o 
group by  orderyear, o.employeeid  
having sum(o.freight)>2000
order by orderyear, o.employeeid 

--09. Create a report that shows EmployeeID and the total number of late orders (NumberOfDelayedOrders) for each of them. The condition of late orders is RequiredDate less than ShippedDate.
--The result should be sorted by NumberOfDelayedOrders descending.

select o.employeeid
     , count(o.orderid) as NumberOfDelayedOrders
from orders o 
where o.requireddate < o.shippeddate 
group by  o.employeeid  
order by NumberOfDelayedOrders desc, o.employeeid 

--10. Create a report that displays the number of female and male employees (NumberOfEmployees) in the positions they held.

select    e.title
		, e.titleofcourtesy 
		, count(e.employeeid) as NumberOfEmployees 
from employees e 
group by e.title , e.titleofcourtesy 
order by e.title 