-- 1) Show the date of the first order ever made in the Orders table.
      Note. There’s a aggregate function called Min that you need to use for this problem

select min(o.order_date)
from orders o 
----------------------------------------------

-- 2) Show a list of countries where the Northwind company has customers and the number of Customers who work there (alias NumberOfCustomers).
      The result should be sorted by NumberOfCustomers in descending order
      Note. You need to use grouping and an aggregate function called COUNT() for this problem.
      
select  
	country,
	COUNT(customer_id) as NumberOfCustomers 
from customers c
Group by 
	country
ORDER BY
    NumberOfCustomers DESC,
    country ASC 
----------------------------------------------

-- 3) Show a list of all the different values in the Customers table for ContactTitles. Also include a count for each ContactTitle (alias TotalContactTitle). 
      The result set should be sorted in descending order by TotalContactTitle.
      Note. The answer for this problem builds on multiple concepts, such as grouping, aggregate functions, and aliases.

select  
	country,
	COUNT(customer_id) as NumberOfCustomers 
from customers c
Group by 
	country  
HAVING COUNT(customer_id) >= 3
ORDER BY 
    NumberOfCustomers DESC,
    country ASC
----------------------------------------------

--4) 
