
--1) Return all the fields about all the shippers

select *
from shippers s
-----------------------------------------------

--2) selecting all the fields using this SQL: 
--   select * from Categories 
--   …will return 4 columns. We only want to see two columns, CategoryName and Description.

select category_name, description
from categories c 
-----------------------------------------------

--3) We’d like to see just the FirstName, LastName, and HireDate of all the employees with the value 
--  'Sales Representative' in the  Title field. Write a SQL statement that returns only those employees.

Select first_name, last_name, hire_date
from employees e
where title = 'Sales Representative'
----------------------------------------------

--4) show the SupplierID, ContactName, and ContactTitle for those Suppliers whose ContactTitle is not 'Marketing Manager'

Select supplier_id, contact_name, contact_title
from suppliers s
where contact_title <> 'Marketing Manager'
----------------------------------------------

--5) we’d like to see the ProductID and ProductName for those products where the ProductName includes the string “queso”.

select product_id, product_name
from products p
where product_name like '%queso%'
----------------------------------------------

--6) Write a query that shows the OrderID, CustomerID, and ShipCountry for the orders where 
--   the ShipCountry is either 'France' or 'Belgium'.

Select order_id, customer_id, ship_country
from orders o 
where (ship_country = 'France' or ship_country = 'Belgium')
----------------------------------------------

--7) show the FirstName, LastName, Title, and BirthDate.
--   Order the results by BirthDate, so we have the oldest employees first.
--   Note. Exclude those employees from the result set whose BirthDate is undefined.

select first_name, last_name, title, birth_date
from employees e  
where birth_date is not null 
order by birth_date
----------------------------------------------

--8) show the FirstName and LastName columns from the Employees table, and then create a new column called FullName, 
--   showing FirstName and LastName joined together in one column, with a space (' ') in between

select first_name, last_name, first_name || ' ' || last_name as full_name
from employees e 
----------------------------------------------

--9) For the orders with OrderID in range 10250 ..10259 create a new field, TotalPrice, that multiplies UnitPrice and 
--   Quantity together. We’ll ignore the Discount field for now. In addition, show the OrderID, ProductID, UnitPrice, 
--   and Quantity. Order by OrderID and ProductID.

select 
	order_id,
	product_id, 
	unit_price,
	quantity,
	(unit_price * quantity) as total_price
from order_details od 
where order_id between 10250 and 10259
order by order_id, product_id 
----------------------------------------------

--10) How many customers do we have in Germany? The result set should contain only one value. Note. In order to get 
      the total number of customers in Germany, we need to use what’s called an aggregate function.

select count(*) 
from customers c 
where country = 'Germany'
----------------------------------------------


