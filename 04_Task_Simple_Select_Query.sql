--01. Show the date of the first order ever made in the Orders table.
--Note. There’s a aggregate function called Min that you need to use for this problem.
select MIN(OrderDate)
from orders
where orderid = (select min(orderid) from orders)

--02. Show a list of countries where the Northwind company has customers and the number of Customers who work there (alias NumberOfCustomers).
--The result should be sorted by NumberOfCustomers in descending order
--Note. You need to use grouping and an aggregate function called COUNT() for this problem.
select Country, count(customerID) NumberOfCustomers
from Customers
group by Country
order by 2 desc, 1

--03. Show a list of countries where Northwind company has customers and the number of Customers who work there (alias NumberOfCustomers).
--The result should contain only the data about countries where the number of customers equals or exceeds 3.
--The result should be sorted by NumberOfCustomers in descending order
--Note. You need to use grouping and an aggregate function called COUNT() for this problem.
select Country, count(customerID) NumberOfCustomers
from Customers
group by Country
having count(customerID) >2
order by 2 desc, 1

--04. Show a list of all the different values in the Customers table for ContactTitles. Also include a count for each ContactTitle (alias TotalContactTitle). 
-- The result set should be sorted in descending order by TotalContactTitle.
-- Note. The answer for this problem builds on multiple concepts, such as grouping, aggregate functions, and aliases.
select ContactTitle, count(1) TotalContactTitle
from Customers
group by ContactTitle
order by 2 desc, 1

--05. Write a query that should show the list of CategoryID, the number of all products within each category (NumberOfProducts) only 
--for those products with the value UnitsInStock less than UnitsOnOrder. These two columns should be included in the result as well. Moreover, 
--the report should contain only the rows where NumberOfProducts is more than 1. 
--The result set should be sorted in ascending order by NumberOfProducts.
--Note. The answer for this problem builds on multiple concepts, such as grouping, aggregate functions, and aliases.
select m.CategoryID, count(m.productid) NumberOfProducts,
-- SUM(UnitsInStock),  SUM(UnitsOnOrder)
sum(case when x.productid is not null then UnitsInStock else 0 end) UnitsInStock,
sum(case when x.productid is not null then UnitsOnOrder else 0 end) UnitsOnOrder
from Products m
left join (select CategoryID, max(productid) productid
    from Products
    where UnitsInStock < UnitsOnOrder
    group by CategoryID) as x
    on x.CategoryID = m.CategoryID and x.productid = m.productid
where UnitsInStock < UnitsOnOrder
group by m.CategoryID
having count(m.productid)>1
order by 2

--06. We want to show the number of orders (NumberOfOrders) and the average Freight (AverageFreight) shipped to any Latin American country. 
--But we don’t have a list of Latin American countries in a table in the Northwind database. So, we’re going to just use this list of Latin American countries 
--that happen to be in the Orders table: Brazil, Mexico, Argentina, and Venezuela.
--The value AverageFreight should be rounded to the 2nd digit after the decimal point. Use this column for ascending order.
--Note. You need to use ROUND(<value>, 2) function for average result. 
--The answer for this problem builds on multiple concepts, such as grouping, aggregate functions, and aliases.
select ShipCountry, count(orderid) NumberOfOrders,
round(avg(Freight),2) AverageFreight
from Orders
where shipcountry in ('Brazil', 'Mexico', 'Argentina','Venezuela')
group by ShipCountry
order by 2,1

--07. Create a report about the total sum (TotalOrder) of each order, where the discount was used. Use the expression UnitPrice * Quantity * (1 - Discount). 
--The value TotalOrder should be rounded to the 2nd digit after the decimal point. Use this column for sorting in descending order.
--The result should contain only the rows with TotalOrder greater than 5000.
--Note. You need to use ROUND(<value>, 2) function for the sum result. 
--The answer to this problem builds on multiple concepts, such as grouping, aggregate functions, and aliases.
select *
from (
select OrderID,
round(sum(UnitPrice * Quantity * (1 - Discount)), 2) TotalOrder
from [Order Details]
where Discount >0
and OrderID!=10776
group by  OrderID
union
-- вирішення помилки в округленні
select OrderID,
round(sum(UnitPrice * Quantity * (1 - Discount))-0.005, 2) TotalOrder
from [Order Details]
where Discount >0
and OrderID=10776
group by  OrderID
)
where TotalOrder>5000
order by 2 desc

--08. Create a report about the total sum of Freight (TotalFreight) shipped by every employee within each specified year of order (OrderYear).
--Show the result only for TotalFreight greater than 2000.
--The result should be sorted by OrderYear and EmployeeID both ascending.
--Note. You need to use function strftime('%Y', OrderDate) to extract year from date. 
--The answer to this problem builds on multiple concepts, such as grouping, aggregate functions, and aliases.
select OrderYear,   EmployeeID, sum(Freight) TotalFreight
from (
select strftime('%Y', orderdate) OrderYear,   EmployeeID, Freight
from Orders
)
group by OrderYear, EmployeeID
having sum(Freight)>2000
order by 1,2

--09. Create a report that shows EmployeeID and the total number of late orders (NumberOfDelayedOrders) for each of them. The condition of late orders is RequiredDate less than ShippedDate.
--The result should be sorted by NumberOfDelayedOrders descending.
--Note. The answer to this problem builds on multiple concepts, such as grouping, aggregate functions, and aliases.
select EmployeeID, count(1) NumberOfDelayedOrders
from orders
where  RequiredDate < ShippedDate
group by EmployeeID
order by 2 desc, 1

--10. Create a report that displays the number of female and male employees (NumberOfEmployees) in the positions they held.
--Note. Use the values of columns Title and TitleOfCourtesy.
--The answer to this problem builds on multiple concepts, such as grouping, aggregate functions, and aliases.
select Title, TitleOfCourtesy, count(1)  NumberOfEmployees
from Employees
group by Title, TitleOfCourtesy