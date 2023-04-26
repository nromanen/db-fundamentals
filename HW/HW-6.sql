-- 1. Show the list of french customers’ names who used to order non-french products (use left join).
select distinct c.ContactName
from Customers c left join Orders o 
on c.CustomerID = o.CustomerID join [Order Details] od 
on o.OrderID = od.OrderID join Products p 
on od.ProductID = p.ProductID join Suppliers s 
on p.SupplierID = s.SupplierID
where c.Country = 'France' and s.Country <> 'France';

-- 2. Show the list of french customers’ names who used to order french products. The list should be ordered in ascending order.
select Customers.ContactName
from Customers join Orders 
on Customers.CustomerID = Orders.CustomerID join [Order Details] 
ON Orders.OrderID = [Order Details].OrderID join Products 
on [Order Details].ProductID = Products.ProductID join Suppliers 
on Products.SupplierID = Suppliers.SupplierID
where Customers.Country = 'France' and Suppliers.Country = 'France'
order by 1 ASC;

-- 3. Show the total ordering sum calculated for each country where orders were shipped. 
--While calculating the sum take into account the value of the discount (Discount).

select distinct o.ShipCountry, sum(od.Quantity * od.UnitPrice * (1 - Discount))::numeric(10,2) as sum
from Orders o
join Customers c
on c.CustomerId = o.CustomerId 
join Order_Details od 
on o.OrderId = od.OrderId 
group by 1
order by 1;

-- 4 Show the list of product categories along with total ordering sums (considering 
--Discount) calculated for the orders made for the products of each category, during the
--year 1997.

select c.CategoryName
, sum(od.Quantity * od.UnitPrice * (1 - od.Discount))::numeric (30,2) as sum 
from Categories c 
join Products p 
on c.CategoryId = p.CategoryId 
join OrderDetails od 
on p.ProductId = od.ProductId 
join  Orders o 
on o.OrderId = od.OrderId 
where DatePart('year', o.OrderDate) = 1997
group by 1 
order by 1, 2;

-- 5. Show the list of product names along with unit prices and the history of unit 
--prices taken from the orders (show ‘Product name – Unit price – Historical price’). The 
--duplicate records should be eliminated. If no orders were made for a certain product, --then the result for this product should look like ‘Product name – Unit price – NULL’. 
--Sort the list by the product name. 

select distinct p.ProductName, p.UnitPrice, o.UnitPrice
from Products p
left join OrderDetails o on p.ProductId = o.ProductId
order by 1;

-- 6. Show the list of employees’ names along with names of their chiefs (use left join 
--with the same table).

select emp.LastName, emp.FirstName, empl.LastName,  empl.FirstName
from Employees emp
left join Employees empl on emp.ReportsTo = empl.EmployeeID;

-- 7. Show the list of cities where employees and customers are from. Duplicates should be eliminated.

select distinct City
from (select City
	  from Customers
	  union
	  select City
	  from Employees
	  union
	  select ShipCity
	  from Orders)
order by 1;

--1.Show the total ordering sum calculated for each country of customer.
select c.country, sum(od.unit_price * od.quantity) as total_sum
from customers c
join orders o 
on c.customer_id = o.customer_id 
join order_details od on o.order_id = od.order_id 
group by 1
order by 1 desc;

--2.Show the list of product categories along with total ordering sums calculated for the orders
-- made for the products of each category, during the year 1997.

select c.category_name
, sum(od.unit_price * od.quantity)::numeric(10) as total_sum 
from categories c join products p 
on c.category_id = p.category_id join order_details od 
on p.product_id = od.product_id join  orders o 
on o.order_id = od.order_id 
where date_part('year', o.order_date) = 1997
group by 1
order by 2 desc;



--3.Show the list of product names along with unit prices and the history of unit prices 
--taken from the orders (show ‘Product name – Unit price – Historical price’). 
--The duplicate records should be eliminated. If no orders were made for a certain product, 
--then the result for this product should look like ‘Product name – Unit price – NULL’. 
--Sort the list by the product name.


select distinct p.product_name, p.unit_price, o.unit_price as historical_price
from products p left join order_details o 
on p.product_id = o.product_id
ORDER BY 1;
