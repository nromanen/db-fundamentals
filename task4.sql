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

--4) Write a query that should show the list of CategoryID, the number of all products within each category (NumberOfProducts) only for those products 
     with the value UnitsInStock less than UnitsOnOrder. These two columns should be included in the result as well. Moreover, the report should contain only 
     the rows where NumberOfProducts is more than 1. 
     The result set should be sorted in ascending order by NumberOfProducts.
     Note. The answer for this problem builds on multiple concepts, such as grouping, aggregate functions, and aliases.

select DISTINCT 
	contact_title,
	COUNT(contact_title) as TotalContactTitle 
from customers c
Group by 
	contact_title 
ORDER BY 
	TotalContactTitle DESC,  
	contact_title
	
--5) Write a query that should show the list of CategoryID, the number of all products within each category (NumberOfProducts) only for those products with the value UnitsInStock less than UnitsOnOrder. These two columns should be included in the result as well. Moreover, the report should contain only the rows where NumberOfProducts is more than 1. 
     The result set should be sorted in ascending order by NumberOfProducts.
     Note. The answer for this problem builds on multiple concepts, such as grouping, aggregate functions, and aliases.


----------------------------------------------

--6) We want to show the number of orders (NumberOfOrders) and the average Freight (AverageFreight) shipped to any Latin American country. But we don’t have a list of Latin American countries 
     in a table in the Northwind database. So, we’re going to just use this list of Latin American countries that happen to be in the Orders table: Brazil, Mexico, Argentina, and Venezuela.
     The value AverageFreight should be rounded to the 2nd digit after the decimal point. Use this column for ascending order.
     Note. You need to use ROUND(<value>, 2) function for average result. 
     The answer for this problem builds on multiple concepts, such as grouping, aggregate functions, and aliases.

SELECT 
	ship_country,
	COUNT(order_id) as NumberOfOrders,
	round(cast(AVG(freight) as numeric), 2) as AverageFreight
FROM orders o
WHERE ship_country IN ('Brazil', 'Mexico', 'Argentina', 'Venezuela')
GROUP BY ship_country 
ORDER BY NumberOfOrders
----------------------------------------------

--7) Create a report about the total sum (TotalOrder) of each order, where the discount was used. Use the expression UnitPrice * Quantity * (1 - Discount). 
     The value TotalOrder should be rounded to the 2nd digit after the decimal point. Use this column for sorting in descending order.
     The result should contain only the rows with TotalOrder greater than 5000.
     Note. You need to use ROUND(<value>, 2) function for the sum result. 
     The answer to this problem builds on multiple concepts, such as grouping, aggregate functions, and aliases.
     
select 
	od.order_id,
	sum(
		round(
			cast(od.unit_price * od.quantity * (1 - od.discount) as integer)
			, 2)
		) as TotalOrder 
FROM 
	order_details od
where od.discount > 0
group by od.order_id 
having sum(
		round(
			cast(od.unit_price * od.quantity * (1 - od.discount) as integer)
			, 2)
		) > 5000
order by TotalOrder desc
----------------------------------------------

--8) Create a report about the total sum of Freight (TotalFreight) shipped by every employee within each specified year of order (OrderYear).
     Show the result only for TotalFreight greater than 2000.
     The result should be sorted by OrderYear and EmployeeID both ascending.

     Note. You need to use function strftime('%Y', OrderDate) to extract year from date. 
     The answer to this problem builds on multiple concepts, such as grouping, aggregate functions, and aliases.

SELECT 
    extract(year from o.order_date) as OrderYear,
    o.employee_id AS EmployeeID,
    SUM(freight) AS TotalFreight
FROM orders o
GROUP BY 
--	strftime('%Y', o.OrderDate),
	extract(year from o.order_date), 
	o.employee_id 
HAVING 
	SUM(freight) > 2000
ORDER BY 
	OrderYear,
	EmployeeID
----------------------------------------------

--9) Create a report that shows EmployeeID and the total number of late orders (NumberOfDelayedOrders) for each of them. The condition of late orders is RequiredDate less than ShippedDate.
     The result should be sorted by NumberOfDelayedOrders descending.
     Note. The answer to this problem builds on multiple concepts, such as grouping, aggregate functions, and aliases.
     
select  
    o.employee_id AS EmployeeID,
    COUNT(o.employee_id) as NumberOfDelayedOrders
FROM orders o
WHERE o.required_date < o.shipped_date  
GROUP BY 
	o.employee_id 
ORDER BY 
	NumberOfDelayedOrders DESC,
	EmployeeID       
----------------------------------------------

--10) Create a report that displays the number of female and male employees (NumberOfEmployees) in the positions they held.
      Note. Use the values of columns Title and TitleOfCourtesy.
      The answer to this problem builds on multiple concepts, such as grouping, aggregate functions, and aliases.
      
 select  
	e.title,
	e.title_of_courtesy,
	COUNT(e.employee_id) as NumberOfEmployees 
from 
	employees e
group by 
	e.Title,
	e.title_of_courtesy    
----------------------------------------------



