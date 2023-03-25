/*Given the Northwind database (see the structure below).
*In the OrderDetails table, we have the fields UnitPrice and Quantity. Write the query *which will return the OrderID, ProductsAmount (amount of products counted by ProductID in *each order)  an additional column TotalPrice (containing the sum of values that multiply *UnitPrice and Quantity). The result set will contain only data about orders with *ProductsAmount of more than 5 and will be ordered by OrderID (ascending) and ProductID (descending).
*/

SELECT OrderID
, COUNT(ProductID) AS ProductsAmount
, (UnitPrice*Quantity) AS TotalPrice
FROM [Order Details]
GROUP BY OrderID
HAVING COUNT(ProductID) > 5
ORDER BY 1, COUNT(ProductID) DESC;

/*Given the Northwind database (see the structure below).
*Show a list of all the different values in the Customers table for ContactTitles. Also 
*include an amount (count) for each ContactTitle with the alias ContactTitlesAmount. The 
*result set would be ordered by ContactTitlesAmount in descending order.
*/

SELECT ContactTitle , COUNT(ContactTitle) AS ContactTitlesAmount 
FROM Customers
GROUP BY ContactTitle 
ORDER BY COUNT(ContactTitle) DESC;

/*
*Given the Northwind database (see the structure below).
*Show the list of the calculated number of orders (AmountOfLateOrders), which were shipped (
*ShipDate) after the required date (RequiredDate) by employees, which would be represented 
*in the result set with their EmployeeID. Include into the list only rows with the 
*AmountOfLateOrders equals and more than 5.
*/

SELECT EmployeeID  
, COUNT(OrderID) AS AmountOfLateOrders
FROM Orders
WHERE ShippedDate > RequiredDate
GROUP BY EmployeeID 
HAVING (COUNT(OrderID)) >= 5
ORDER BY 1;

/*
*Given the Northwind database (see the structure below).
*Show the FirstName and LastName columns from the Employees table, and then create a new 
*column called FullName, showing FirstName and LastName joined together in one column, with 
*a space in between for those employees, who live in the USA or Germany.
*/

SELECT FirstName , LastName , FirstName || ' ' || LastName as FullName
FROM Employees
WHERE Country = 'USA' OR Country = 'Germany';

--Write a query to get Product name and quantity/unit. 

select product_name, quantity_per_unit
from products p ;

--Write a query to get current Product list (Product ID and name). 

select product_id, product_name
from products p ;

--Write a query to get discontinued Product list (Product ID and name). 

select product_id, product_name
from products p 
where discontinued = 0;

--Write a query to get most expense and least expensive Product list (name and unit price). 

select product_name, unit_price
from products
where unit_price = (select MAX(unit_price) from products)
or unit_price = (select MIN(unit_price) from products);

--Write a query to get products list (product_id, product_name, unit_price) where current products cost less than $20. 
select product_id , product_name , unit_price 
from products p 
where unit_price < 20;

--Write a query to get Product list (id, name, unit price) where products cost between $15 and $25. 

select product_id , product_name , unit_price 
from products p 
where p.unit_price > 15 and p.unit_price < 25;

--Write a query to get Product list (name, unit price) of above average price. 

select product_name , unit_price 
from products p 
where unit_price > (select avg(unit_price) from products);

--Write a query to get Product list (name, unit price) of ten most expensive products. 

select product_name, unit_price
from products
order by unit_price desc
limit 10;

--Write a query to count current and discontinued products. 

select
count(case when discontinued = 0 then product_id end) as current_products,
count(case when discontinued = 1 then product_id end) as discontinued_products
from products;


