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


