--Q1
--Return all the fields about all the shippers

select *
from shippers

--Q2
--In the Categories table, 
--selecting all the fields using this SQL: 
--select * from Categories 
--…will return 4 columns. We only want to see two columns, CategoryName and Description.

select c.category_name 
, c.description
from categories c

--Q3
--Given the table Employees
--We’d like to see just the FirstName, LastName, and HireDate of all the employees with the value 'Sales Representative' in the  Title field. 
--Write a SQL statement that returns only those employees.

select e.first_name
, e.last_name
, e.hire_date 
from employees e
where title = 'Sales Representative'

--Q4
--In the Suppliers table, 
--show the SupplierID, ContactName, and ContactTitle for those Suppliers whose ContactTitle is not 'Marketing Manager'

select s.supplier_id
, s.contact_name
, s.contact_title
from suppliers s
where not s.contact_title  = 'Marketing Manager'

--Q5
--In the Products table, 
--we’d like to see the ProductID and ProductName for those products where the ProductName includes the string “queso”.

select p.product_id 
, p.product_name 
from products p
where p.product_name ilike '%queso%'

--Q6
--Looking at the Orders table, there’s a field called ShipCountry. 
--Write a query that shows the OrderID, CustomerID, and ShipCountry for the orders where the ShipCountry is either 'France' or 'Belgium'.

select o.order_id
, o.customer_id
, o.ship_country
from orders o
where o.ship_country in ('France', 'Belgium')

--Q7
--For all the employees in the Employees table,
--show the FirstName, LastName, Title, and BirthDate.
--Order the results by BirthDate, so we have the oldest employees first.
--Note. Exclude those employees from the result set whose BirthDate is undefined. 

select e.first_name
, e.last_name
, e.title
, e.birth_date
from employees e
where e.birth_date is not null 
order by e.birth_date

--Q8
--For all the employees in the Employees table
--show the FirstName and LastName columns from the Employees table, and then create a new column called FullName, 
--showing FirstName and LastName joined together in one column, with a space (' ') in between

select e.first_name
, e.last_name
, concat(e.first_name, ' ', e.last_name) as FullName
from employees e

--Q9
--In the OrderDetails table, we have the fields UnitPrice and Quantity.
--For the orders with OrderID in range 10250 ..10259 create a new field, TotalPrice, that multiplies UnitPrice and Quantity together. 
--We’ll ignore the Discount field for now.
--In addition, show the OrderID, ProductID, UnitPrice, and Quantity. Order by OrderID and ProductID.

select order_id
, od.product_id 
, od.unit_price 
, od.quantity 
, od.unit_price  * od.quantity as TotalPrice
from order_details od
where od.order_id between 10250 and 10259
order by od.order_id
, od.product_id 

--Q10
--Given Customers table
--How many customers do we have in Germany? The result set should contain only one value.
--Note. In order to get the total number of customers in Germany, we need to use what’s called an aggregate function.

select count(*)
from customers c
where c.country = 'Germany'

