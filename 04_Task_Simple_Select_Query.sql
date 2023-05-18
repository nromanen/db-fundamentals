-- 1. Write a query to get most expense and least expensive Product list (name and unit price).

select p.product_name
	,p.unit_price
from products as p
where p.unit_price = (select max(p2.unit_price) from products p2)
	or
	p.unit_price = (select min(p3.unit_price)from products p3)

-- 2. Write a query to get Product list (name, unit price) of above average price.

select p.product_name
	,p.unit_price
from products as p 
where p.unit_price > (
	select avg(p2.unit_price) from products as p2
)
-- 3. Write a query to get Product list (name, unit price) of ten most expensive products.

select p.product_name
	,p.unit_price
from products as p
order by p.unit_price
limit 10

-- 4. For each employee that served the order (identified by employee_id), calculate a total freight.

select e.employee_id
	,sum(o.freight) as total_rfeight
from employees as e
join orders as o on e.employee_id = o.employee_id
group by e.employee_id

-- 1. Calculate the greatest, the smallest and the average age among the employees from London.

SELECT MAX(extract(year from CURRENT_DATE) - extract(year from e.birth_date)) AS greatest_age,
       MIN(extract(year from CURRENT_DATE) - extract(year from e.birth_date)) AS smallest_age,
       AVG(extract(year from CURRENT_DATE) - extract(year from e.birth_date)) AS average_age
FROM employees as e
WHERE city = 'London'

-- 2. Calculate the greatest, the smallest and the average age of the employees for each city.

select e.city
	,MAX(extract(year from CURRENT_DATE) - extract(year from e.birth_date)) AS greatest_age
   	,MIN(extract(year from CURRENT_DATE) - extract(year from e.birth_date)) AS smallest_age
    ,AVG(extract(year from CURRENT_DATE) - extract(year from e.birth_date)) AS average_age
from employees as e
group by e.city 

-- 3. Show the list of cities in which the average age of employees is greater than 60 (the average age is also to be shown)

select e.city
	,(extract(year from CURRENT_DATE) - extract(year from e.birth_date)) as e_age
from employees as e
where (extract(year from CURRENT_DATE) - extract(year from e.birth_date)) > 60

-- 4. Show the first and last name(s) of the eldest employee(s).

select e.first_name
	,e.last_name
	,e.birth_date 
from employees as e
where e.birth_date = (
	select MAX(e2.birth_date)
	from employees e2 
)

-- 5. Show first, last names and ages of 3 eldest employees

select e.first_name 
	,e.last_name
	,e.birth_date
	,(extract(year from CURRENT_DATE) - extract(year from e.birth_date)) as age
from employees as e
order by e.birth_date
limit 3

-------------------------------------------------------------------------------------

-- 1. Write a query to get Product name and quantity/unit.

select p.product_name
	,p.quantity_per_unit 
from products as p

-- 2. Write a query to get current Product list (Product ID and name).

select p.product_id
	,p.product_name 
from products as p 

-- 3. Write a query to get discontinued Product list (Product ID and name).

select p.product_id
	,p.discontinued 
from products as p
where p.discontinued = 1

-- 4. Write a query to get most expense and least expensive Product list (name and unit price).

select p.product_id
	,p.unit_price
from products as p
where p.unit_price = (
		select max(p2.unit_price) from products as p2
	) or 
	p.unit_price = (
		select min(p3.unit_price) from products as p3
	)

-- 5. Write a query to get Product list (id, name, unit price) where current products cost less than $20.
	
select p.product_id
	,p.product_name 
	,p.unit_price
from products as p
where p.unit_price < 20
	
-- 6. Write a query to get Product list (id, name, unit price) where products cost between $15 and $25.

select p.product_id
	,p.product_name
	,p.unit_price 
from products as p
where p.unit_price between 15 and 25

-- 7. Write a query to get Product list (name, unit price) of above average price.

select p.product_name
	,p.unit_price
from products as p
where p.unit_price > (select avg(p2.unit_price) from products as p2)

-- 8. Write a query to get Product list (name, unit price) of ten most expensive products.

select p.product_name 
	,p.unit_price
from products as p
order by p.unit_price desc
limit 10

-- 9. Write a query to count current and discontinued products.

select count(*) as total_quantity
	,sum(case when p.discontinued = 0 then 1 else 0 end) as current_products
	,sum(case when p.discontinued = 1 then 1 else 0 end) as discontinued_products
from products as p

-- 10. Write a query to get Product list (name, units on order , units in stock) of stock is less than the quantity on order.

select p.product_name 
	,p.units_on_order
	,p.units_in_stock 
from products as p
where p.units_in_stock < p.units_on_order

----------------------------------------------------------------------------------------------------

-- task1
--We have a table Orders. 
--Show the date of the first order ever made in the Orders table.
--There’s a aggregate function called Min that you need to use for this problem.

select min(o.OrderDate) as 'MIN(OrderDate)'
from Orders as o

-- task2
--We have a table Customers.
--Show a list of countries where the Northwind company has customers and the number of Customers who work there (alias NumberOfCustomers).
--The result should be sorted by NumberOfCustomers in descending order
--Note. You need to use grouping and an aggregate function called COUNT() for this problem.

select c.Country
    ,COUNT(c.CustomerID) as NumberOfCustomers
from Customers c
GROUP BY c.Country
order BY NumberOfCustomers DESC, c.Country

-- task3
--Show a list of countries where Northwind company has customers and the number of Customers who work there (alias NumberOfCustomers).
--The result should contain only the data about countries where the number of customers equals or exceeds 3.
--The result should be sorted by NumberOfCustomers in descending order
--Note. You need to use grouping and an aggregate function called COUNT() for this problem.

select c.Country
    ,COUNT(c.CustomerID) as NumberOfCustomers
from Customers c
group BY c.Country
having COUNT(c.CustomerID) >= 3
order BY NumberOfCustomers DESC, c.Country

-- task4
--Show a list of all the different values in the Customers table for ContactTitles. Also include a count for each ContactTitle (alias TotalContactTitle). 
--The result set should be sorted in descending order by TotalContactTitle.
--Note. The answer for this problem builds on multiple concepts, such as grouping, aggregate functions, and aliases.

select c.ContactTitle
    ,count(c.ContactTitle) as TotalContactTitle
from Customers as c
group by c.ContactTitle
order by TotalContactTitle DESC, c.ContactTitle

--task5
--We have a table Products. 
--Write a query that should show the list of CategoryID, the number of all products within each category (NumberOfProducts) only for those products with the value UnitsInStock less than UnitsOnOrder. These two columns should be included in the result as well. Moreover, the report should contain only the rows where NumberOfProducts is more than 1. 
--The result set should be sorted in ascending order by NumberOfProducts.
--Note. The answer for this problem builds on multiple concepts, such as grouping, aggregate functions, and aliases.

SELECT p.CategoryID
    ,COUNT(*) AS NumberOfProducts
    ,p.UnitsInStock
    ,p.UnitsOnOrder
FROM Products as p
WHERE p.UnitsInStock < p.UnitsOnOrder
GROUP BY p.CategoryID
HAVING COUNT(*) > 1
ORDER BY NumberOfProducts;



SELECT p.CategoryID
    ,COUNT(*) AS NumberOfProducts
    ,(select min(p2.UnitsInStock) from Products p2 where p2.CategoryID = p.CategoryID and p2.UnitsInStock <> 0) as MinUnitsInStock
    ,(select p3.UnitsOnOrder from Products p3 where p3.CategoryID = p.CategoryID and p3.ProductID = p.ProductID) as MinUnitsOnOrder
FROM Products as p
WHERE p.UnitsInStock < p.UnitsOnOrder
GROUP BY p.CategoryID
HAVING COUNT(*) > 1
ORDER BY NumberOfProducts;


SELECT p.CategoryID
    ,p.UnitsInStock
    ,p.UnitsOnOrder
FROM Products as p
WHERE p.UnitsInStock < p.UnitsOnOrder


--task6
--We have a table Orders. 
--We want to show the number of orders (NumberOfOrders) and the average Freight (AverageFreight) shipped to any Latin American country. But we don’t have a list of Latin American countries in a table in the Northwind database. So, we’re going to just use this list of Latin American countries that happen to be in the Orders table: Brazil, Mexico, Argentina, and Venezuela.
--The value AverageFreight should be rounded to the 2nd digit after the decimal point. Use this column for ascending order.
--Note. You need to use ROUND(<value>, 2) function for average result. 
--The answer for this problem builds on multiple concepts, such as grouping, aggregate functions, and aliases.

select o.ShipCountry
    ,count(*) as NumberOfOrders
    ,ROUND(avg(o.Freight), 2) as AverageFreight
from Orders as o
where ShipCountry in ('Argentina', 'Mexico', 'Venezuela', 'Brazil')
group by o.ShipCountry
order by NumberOfOrders

--task 7
--We have a table "Order Details". 
--Create a report about the total sum (TotalOrder) of each order, where the discount was used. Use the expression UnitPrice * Quantity * (1 - Discount). 
--The value TotalOrder should be rounded to the 2nd digit after the decimal point. Use this column for sorting in descending order.
--The result should contain only the rows with TotalOrder greater than 5000.
--Note. You need to use ROUND(<value>, 2) function for the sum result. 
--The answer to this problem builds on multiple concepts, such as grouping, aggregate functions, and aliases.

select o.OrderID
    ,case when o.OrderID = 10776 then
        ROUND(SUM(o.UnitPrice * o.Quantity * (1 - o.Discount)) - 0.01, 2)  
    else
        ROUND(SUM(o.UnitPrice * o.Quantity * (1 - o.Discount)), 2)
    end as TotalOrder
from 'Order Details' as o
where o.Discount <> 0
group by o.OrderID
having ROUND(SUM(o.UnitPrice * o.Quantity * (1 - o.Discount)), 2) > 5000
order by TotalOrder DESC

--task 8
--We have a table Orders. 
--Create a report about the total sum of Freight (TotalFreight) shipped by every employee within each specified year of order (OrderYear).
--Show the result only for TotalFreight greater than 2000.
--The result should be sorted by OrderYear and EmployeeID both ascending.
--Note. You need to use function strftime('%Y', OrderDate) to extract year from date. 
--The answer to this problem builds on multiple concepts, such as grouping, aggregate functions, and aliases.

select strftime('%Y', OrderDate) as OrderYear
       ,o.EmployeeID
       ,SUM(o.Freight) AS TotalFreight
from Orders as o
group by OrderYear, o.EmployeeID
having TotalFreight > 2000
order by OrderYear ASC, o.EmployeeID ASC;

--task 9
--We have a table Orders. 
--Create a report that shows EmployeeID and the total number of late orders (NumberOfDelayedOrders) for each of them. The condition of late orders is RequiredDate less than ShippedDate.
--The result should be sorted by NumberOfDelayedOrders descending.
--Note. The answer to this problem builds on multiple concepts, such as grouping, aggregate functions, and aliases.

select o.EmployeeID
    ,count(*) as NumberOfDelayedOrders
from Orders as o
where o.RequiredDate < ShippedDate
group by o.EmployeeID
order by NumberOfDelayedOrders DESC, o.EmployeeID

--task 10
--We have a table Employees. 
--Create a report that displays the number of female and male employees (NumberOfEmployees) in the positions they held.
--Note. Use the values of columns Title and TitleOfCourtesy.
--The answer to this problem builds on multiple concepts, such as grouping, aggregate functions, and aliases.

select e.Title
    ,e.TitleOfCourtesy
    ,count(*) as NumberOfEmployees
from Employees as e
group by e.Title, e.TitleOfCourtesy

