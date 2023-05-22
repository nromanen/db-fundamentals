--Return all the fields about all the shippers

select *
from shippers


-----------------------------------------------------------------

--Return CategoryName and Description from Categories table.

select categoryname, description
from categories


-----------------------------------------------------------------

--FirstName, LastName, and HireDate of all the employees with the value 'Sales Representative' in the  Title field.

select first_name, last_name, hire_date
from employees
where title = 'Sales Representative'


-----------------------------------------------------------------

--show the SupplierID, ContactName, and ContactTitle for those Suppliers whose ContactTitle is not 'Marketing Manager'

select supplier_id, contact_name, contact_title
from suppliers
where contact_title <> 'Marketing Manager'


-----------------------------------------------------------------

--ProductID and ProductName for those products where the ProductName includes the string “queso”

select product_id, product_name
from products
where product_name ilike '%queso%'


-----------------------------------------------------------------

--Write a query that shows the OrderID, CustomerID, and ShipCountry for the orders where the ShipCountry is either 'France' or 'Belgium'.

select order_id, customer_id, ship_country
from orders
where ship_country in ('France', 'Belgium')


-----------------------------------------------------------------

--show the FirstName, LastName, Title, and BirthDate.
--Order the results by BirthDate, so we have the oldest employees first.
--Note. Exclude those employees from the result set whose BirthDate is undefined.

select first_name, last_name, title, birth_date
from employees
where birth_date is not null
order by birth_date


-----------------------------------------------------------------

--show the FirstName and LastName columns from the Employees table, and then create a new column called FullName,
--showing FirstName and LastName joined together in one column, with a space (' ') in between

SELECT
    FirstName,
    LastName,
    FirstName || ' ' || LastName AS FullName
FROM
    Employees;



-----------------------------------------------------------------

--For the orders with OrderID in range 10250 ..10259 create a new field, TotalPrice, that multiplies UnitPrice and Quantity together. We’ll ignore the Discount field for now.
--In addition, show the OrderID, ProductID, UnitPrice, and Quantity. Order by OrderID and ProductID.

select OrderID, ProductID, UnitPrice, Quantity, Quantity*UnitPrice as TotalPrice
from "Order Details"
where OrderID between 10250 and 10259
Order by OrderID and ProductID


-----------------------------------------------------------------

--How many customers do we have in Germany?
select count(city) as "count(*)" from customers where country="Germany" 


-----------------------------------------------------------------
