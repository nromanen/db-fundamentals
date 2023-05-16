--Show the date of the first order ever made in the Orders table

select min(order_date)
from orders
-----------------------------------------------------------------

--Show a list of countries where the Northwind company has customers and the number of Customers who work there (alias NumberOfCustomers).
--The result should be sorted by NumberOfCustomers in descending order

select
    country
    , count(*) as number_of_customers
from customers
group by country
order by count(*) desc, country asc
-----------------------------------------------------------------

--Show a list of countries where Northwind company has customers and the number of Customers who work there (alias NumberOfCustomers).
--The result should contain only the data about countries where the number of customers equals or exceeds 3.
--The result should be sorted by NumberOfCustomers in descending order

select
    country
    , count(*) as number_of_customers
from customers
group by country
having count(*) >= 3
order by count(*) desc, country asc
-----------------------------------------------------------------

--Show a list of all the different values in the Customers table for ContactTitles. Also include a count for each ContactTitle (alias TotalContactTitle).
--The result set should be sorted in descending order by TotalContactTitle.

select distinct contact_title , count(*) as total_contact_title
from customers
group by contact_title
order by count(*) desc, contact_title
-----------------------------------------------------------------

--Write a query that should show the list of CategoryID, the number of all products within each category (NumberOfProducts)
--only for those products with the value UnitsInStock less than UnitsOnOrder. These two columns should be included in the result as well.
--Moreover, the report should contain only the rows where NumberOfProducts is more than 1.
--The result set should be sorted in ascending order by NumberOfProducts.

select
    category_id
    ,count(*) as number_of_products
    ,sum(units_in_stock) as sum_units_in_stock
    ,sum(units_on_order) as sum_units_in_order
from products
where units_in_stock < units_on_order
group by category_id
having count(*) > 1
order by count(*)
-----------------------------------------------------------------

--We want to show the number of orders (NumberOfOrders) and the average Freight (AverageFreight) shipped to any Latin American country.
--But we don’t have a list of Latin American countries in a table in the Northwind database.
--So, we’re going to just use this list of Latin American countries that happen to be in the Orders table: Brazil, Mexico, Argentina, and Venezuela.
--The value AverageFreight should be rounded to the 2nd digit after the decimal point. Use this column for ascending order.

select
	ship_country
	,count(*) as number_of_orders
	,round(avg(cast(freight as numeric)), 2) as average_freight
from orders
where ship_country in ('Brazil', 'Mexico', 'Argentina', 'Venezuela')
group by ship_country
order by round(avg(cast(freight as numeric)), 2)
-----------------------------------------------------------------

--Create a report about the total sum (TotalOrder) of each order, where the discount was used. Use the expression UnitPrice * Quantity * (1 - Discount).
--The value TotalOrder should be rounded to the 2nd digit after the decimal point. Use this column for sorting in descending order.
--The result should contain only the rows with TotalOrder greater than 5000.

select
    order_id
    ,sum(round(cast((unit_price * quantity * (1 - discount)) as numeric), 2)) as total_order
from order_details
where discount > 0
group by order_id
having sum(round(cast((unit_price * quantity * (1 - discount)) as numeric), 2)) > 5000
order by sum(round(cast((unit_price * quantity * (1 - discount)) as numeric), 2)) desc
-----------------------------------------------------------------

--Create a report about the total sum of Freight (TotalFreight) shipped by every employee within each specified year of order (OrderYear).
--Show the result only for TotalFreight greater than 2000.
--The result should be sorted by OrderYear and EmployeeID both ascending.

select
    extract(year from order_date) as order_year
    ,employee_id
    ,sum(freight) as total_freight
from orders
group by extract(year from order_date), employee_id
having sum(freight) > 2000
order by extract(year from order_date), employee_id
-----------------------------------------------------------------

--Create a report that shows EmployeeID and the total number of late orders (NumberOfDelayedOrders) for each of them.
--The condition of late orders is RequiredDate less than ShippedDate.
--The result should be sorted by NumberOfDelayedOrders descending.

select
	employee_id
	,count(*) as number_of_delayed_orders
from orders
where required_date < shipped_date
group by employee_id
order by count(*) desc, employee_id
-----------------------------------------------------------------

--Create a report that displays the number of female and male employees (NumberOfEmployees) in the positions they held.

select
	title
	,title_of_courtesy
	,count(*) as number_of_employees
from employees
group by title, title_of_courtesy
-----------------------------------------------------------------
