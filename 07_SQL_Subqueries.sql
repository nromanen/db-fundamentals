--TASK 1

--1. Show first and last names of the employees who have the biggest freight.

select e.first_name
	,e.last_name
from employees as e
where e.employee_id = (
						select o.employee_id
						from orders as o
						order by o.freight
						limit 1
					)
					
--2. Show first, last names of the employees, their freight who have the freight bigger then avarage.
	
select e.first_name
	,e.last_name
	,o.freight
from employees as e
join orders as o
	on o.employee_id = e.employee_id
group by e.last_name, e.first_name, o.freight 
having o.freight > (
						select avg(o2.freight)
						from orders as o2
					)
					
--3. Show the names of products, that have the biggest price.
					
select p.product_name
	,p.unit_price
from products as p
group by p.product_name, p.unit_price 
having p.unit_price >= (
						select max(p2.unit_price) 
						from products as p2
					) 

--4. Show the name of customers with the freight bigger then avarage.
					
select c.company_name
	,o.freight 
from customers as c
join orders as o
	on o.customer_id = c.customer_id
group by c.company_name, o.freight
having avg(o.freight) > (
					select avg(o2.freight) 
					from orders as o2
				)
order by o.freight
					
--5. Show the name of supplier who delivered the cheapest product.

select s.company_name
	,p.unit_price 
from suppliers as s
join products as p 
	on p.supplier_id = s.supplier_id
group by s.company_name, p.unit_price
having  p.unit_price <= (
					select min(p2.unit_price)
					from products as p2
					)
					
--TASK 2
					
-- 1. Show the name of the category in which the average price of a certain product is greater than the grand average in the whole stock.
									
select c.category_name 
from categories as c
where (
		select avg(p.unit_price)
		from products as p
		where p.category_id = c.category_id
) > (
	select avg(p2.unit_price)
	from products as p2
)
order by c.category_id
					
-- 2. Show the name of the supplier whose delivery is lower than the grand average in the whole stock.

select s.company_name
from suppliers as s
where (
	select sum(p.units_on_order)
	from products as p
	where p.supplier_id = s.supplier_id
) < (
	select avg(p2.units_on_order)
	from products as p2
)

-- 3. Show the regions where employees work, the middle age of which is higher than over the whole company.

select e.region
	,avg(extract(year from current_date) - extract(year from e.birth_date)) as avg_total
from employees as e
join orders as o
	on o.employee_id = e.employee_id
join customers as c
	on c.customer_id = o.customer_id
group by e.region
having avg(extract(year from current_date) - extract(year from e.birth_date)) > (
	select avg(extract(year from current_date) - extract(year from e2.birth_date))
	from employees as e2
)

-- 4. Show customers whose maximum freight level is less than the average for all customers.


select c.company_name
	,o.freight
from customers as c
join orders as o 
	on o.customer_id = c.customer_id
group by c.company_name, o.freight
having MAX(o.freight) < (
	select avg(o2.freight)
	from orders o2 
)
order by o.freight desc

-- 5. Show the categories of products for which the average discount is higher than the average discount for all products

select p.discontinued 	
from products as p

select c.category_name 
	,od.discount
from categories as c
join products as p
	on p.category_id = c.category_id
join order_details as od
	on od.product_id = p.product_id 
group by c.category_name, od.discount
having avg(od.discount) > (
	select avg(od2.discount)
	from order_details as od2
)
order by od.discount desc

--TASK 3

-- 1. Calculate the average freight of all employees who work not with Western region.

select avg(o.freight) as total
from employees as e
join orders as o
	on o.employee_id = e.employee_id
where e.region not like '%WA%'

-- 2. Show first and last names of employees who shipped orders in cities of USA.

select e.first_name
	,e.last_name
	,o.ship_country
from employees as e
join orders as o
	on o.employee_id = e.employee_id
where o.ship_country like '%USA%'
order by o.ship_country
	
-- 3. Show the names of products and their total cost, which were delivered by German suppliers

select p.product_name
	,sum(od.unit_price * od.quantity * (1 - od.discount)) as total_cost
from products as p
join order_details as od
	on od.product_id = p.product_id
join suppliers as s
	on s.supplier_id = p.supplier_id
where s.country like '%German%'
group by p.product_name

-- 4. Show first and last names of employees that don’t work with Eastern region.

select e.first_name
	,e.last_name
	,r.region_description 
from employees as e
join employee_territories as et
	on et.employee_id = e.employee_id
join territories as t 
	on t.territory_id = et.territory_id
join region as r
	on r.region_id = t.region_id
where r.region_description  not like '%Eastern%'

-- 5. Show the name of customers that prefer to order non-domestic products

select c.company_name
	,c.country
	,s.country 
from customers as c
join orders as o
	on o.customer_id = c.customer_id
join order_details as od
	on od.order_id = o.order_id
join products as p
	on p.product_id  = od.product_id
join suppliers as s
	on s.supplier_id = p.supplier_id
where c.country <> s.country


select c.company_name
	,c.country
from customers as c
join (
	select od.order_id, p.supplier_id
	from order_details as od
	join products as p
		on p.product_id = od.product_id
) as od_suppliers on c.customer_id = (
	select o.customer_id 
	from orders as o
	where o.order_id = od_suppliers.order_id
)
join suppliers as s
	on s.supplier_id = od_suppliers.supplier_id
where c.country <> s.country 


-- TASK 4
-- 1. Show employees (first and last name) working with orders from the United States.

select e.first_name
	,e.last_name 
from employees as e
join orders as o
	on o.employee_id = e.employee_id
where o.order_id in (
	select od.order_id 
	from order_details as od
	join products as p 
		on p.product_id = od.product_id
	join suppliers as s
		on s.supplier_id = p.supplier_id
	where s.country like '%USA%'
)

-- 2. Show the info about orders, that contain the cheapest products from USA.

select o.order_id
from orders o
join order_details od
	on od.order_id = o.order_id 
join (
	select min(p.unit_price) as min_prise
	from products p 
	join suppliers s 
		on s.supplier_id = p.supplier_id
		where s.country like '%USA%'
) as min_price_table on od.unit_price = min_price_table.min_prise

-- 3. Show the info about customers that prefer to order meat products and never order drinks.

select c.company_name
from customers c
join orders o
	on o.customer_id = c.customer_id 
join order_details od
	on od.order_id = o.order_id
join (
	select p.product_id
	from products p
	join categories as ca
		on ca.category_id  = p.category_id
		where ca.description like '%meat%' and ca.description not like '%drink%'
) as id_of_products on od.product_id = id_of_products.product_id


-- 4. Show the list of cities where employees and customers are from and where orders have been made to. Duplicates should be eliminated

select e.city 
from employees e
where e.city in (
	select o.ship_city 
	from orders o 
	join customers c 
		on c.customer_id = o.customer_id
	where c.city = o.ship_city
)

-- 5. Show the lists the product names that order quantity equals to 100.

select p.product_name
	,od.quantity
from products p
join order_details od
	on od.product_id = p.product_id
group by p.product_name, od.quantity 
having od.quantity = 100


-- TASK 5

-- 1. Show the lists the suppliers with a product price equal to 10$.

select s.company_name
	,s.supplier_id 
from suppliers s
where s.supplier_id in (
	select p.supplier_id 
	from products p 
	where p.unit_price = 10
)

-- 2. Show the list of employee that perform orders with freight 1000.

select e.employee_id 
from employees e 
where e.employee_id in (
	select o.employee_id 
	from orders o 
	where o.freight > 1000
)

-- 3. Find the Companies that placed orders in 1997

select c.company_name 
from customers c 
where c.customer_id in (
	select o.customer_id 
	from orders o
	where extract(year from o.order_date) = 1997
)

-- 4. Create a report that shows all products by name that are in the Seafood category.

select p.product_name
from products p, categories c2 
where p.category_id in (
	select c.category_id 
	from categories c
	where c.category_name like '%Seafood%'
)
group by p.product_name

-- 5. Create a report that shows all companies by name that sell products in the Dairy Products category.

select s.company_name 
from suppliers s 
where supplier_id in (
	select p.supplier_id 
	from products p 
	join categories c
		on c.category_id = p.product_id
	where c.category_name like '%Dairy Products%'
)


-- HOME work 

-- 1. Create a report that shows the product name and supplier id for all products supplied by Exotic Liquids, Grandma Kelly's Homestead, and Tokyo Traders.

select p.product_name
	,p.supplier_id 
from products p 
where p.supplier_id in (
	select s.supplier_id 
	from suppliers s 
	where s.company_name in ('Exotic Liquids', 'Grandma Kell''ys Homestead', 'Tokyo Traders')
)

-- 2. Create a report that shows all the products which are supplied by a company called ‘Pavlova, Ltd.’.

select p.product_name 
from products p 
where p.supplier_id in (
	select s.supplier_id 
	from suppliers s 
	where s.company_name like '%Pavlova, Ltd.%'
)

-- 3. Create a report that shows the orders placed by all the customers excluding the customers who belongs to London city.

select o.order_id
	,o.customer_id
from orders o 
where o.customer_id in (
	select c.customer_id 
	from customers c 
	where c.city <> 'London'
)

-- 4. Create a report that shows all the customers if there are more than 30 orders shipped in London city.

select c.company_name 
from customers c 
where c.customer_id in (
	select o.customer_id 
	from orders o
	where o.ship_city = 'London'
)

-- 5. Create a report that shows all the orders where the employee’s city and order’s ship city are same.

select o.order_id
from orders o
join employees e
	on e.employee_id = o.employee_id
	where e.city = o.ship_city 
	
	
	
-- TASKS FROM MUUDLE
	
-- Task1

-- Janet Leverling, one of the salespeople, has come to you with a request. She thinks that she accidentally double-entered 
-- a line item on an order, with a different ProductID, but the same quantity. She remembers that the quantity was 60 or more.
-- Show all the OrderIDs that match this, in order of OrderID.
	
SELECT od.OrderID
FROM "Order Details" od
WHERE EXISTS (
    SELECT 1
    FROM "Order Details" od2
    WHERE od.OrderID = od2.OrderID
        and od2.Quantity >= 60
      AND od.Quantity = od2.Quantity
      AND od.ProductID <> od2.ProductID
)
Group by od.OrderID
ORDER BY od.OrderID

-- Task 2

-- We know that Andrew Fuller is the Vice President of Northwind Company. Create the report that shows the list of those employees (last and first name) who were hired earlier than Fuller.

select e.LastName
    ,e.FirstName
from Employees as e
where e.HireDate < (
    select e1.HireDate
    from Employees as e1
    where e1.FirstName = 'Andrew'  and e1.LastName = 'Fuller'
)

-- Task 3

-- Write the query which should create the list of products and their unit price for products with price greater than average products' unit price
-- Note. Use the subquery to get the average UnitPrice from the Products table.

select p. ProductName
    ,p.UnitPrice
from Products as p
where p.UnitPrice > (
    select avg(p1.UnitPrice)
    from Products as p1
)
order by p.UnitPrice

-- Task 4

-- Create the report that should show  the Companies from Germany that placed orders in 2016
-- Note. You may use STRFTIME('%Y', OrderDate) function to retrieve the year from the date (the type of result would be 'string'  in this case).
-- Use subquery to create this report.

select c.CompanyName
from Customers as c
where c.CustomerID in (
    select o.CustomerID
    from Orders as o
    where STRFTIME('%Y', o.OrderDate) = '2016'
)
group by c.CustomerID
having c.Country like '%German%'



select c.company_name 
from customers as c
where c.customer_id in (
    select o.customer_id 
    from orders as o
    where extract(year from o.order_date) = 1996
)
group by c.customer_id  
having c.country like '%Germany%'

-- Task 5
-- Create the query that should show the date when the orders were shipped (alias ShippedDate),  
-- the number of orders  (NumberOfOrders) and total sum (including discount) of the orders (Total) shipped at this date.  
-- The report includes only the 1st quarter of 2016 with the number of orders greater than 3.
-- The result should be sorted by ShippedDate

-- Note. A subtotal is calculated by a sub-query for each order. The sub-query forms a table and then joined with the Orders table.
--You may use STRFTIME('%Y', OrderDate) function to retrieve the year from the date (the type of result would be 'string'  in this case).
--Use ROUND() function for calculated sum of each order in subquery.

select o.ShippedDate
    ,(select count(o2.OrderID)
        from Orders as o2
        where o.ShippedDate = o2.ShippedDate
    ) as NumberOfOrders
    ,(select round(SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)), 2)
        from 'Order Details' as od
        join Orders as o3
            on o3.OrderID = od.OrderID
        where o.ShippedDate = o3.ShippedDate
    ) as Total
from Orders as o
where o.ShippedDate >= '2016-01-01' and o.ShippedDate <= '2016-03-31'
    and NumberOfOrders > 3
group by o.ShippedDate

-- Task 6

-- For the category 'Dairy Products' get the list of products sold and the total sales amount including discount (alias ProductSales) during the 1st quarter of 2016 year. 
-- Note. Use the subquery to get sales for each product on each order. Join the table from the subquery with an outer query on ProductID. 
-- You may use STRFTIME('%Y', OrderDate) function to retrieve the year from the date (the type of result would be 'string'  in this case).
-- Use ROUND() function for a calculated total for each product in the subquery.

select c.CategoryName
    ,p.ProductName
    ,ROUND(SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)), 2) as ProductSales
from Categories c
join Products p
    on p.CategoryID = c.CategoryID
join 'Order Details' od
    on od.ProductID = p.ProductID
join Orders as o
    on o.OrderID = od.OrderID
where p.CategoryID = (
    select c2.CategoryID
    from Categories c2
    where c2.CategoryName = 'Dairy Products'
) and  o.OrderDate >= '2016-01-01' and o.OrderDate <= '2016-03-31'
group by p.ProductName

-- Task 7

-- Andrew, the VP of sales, wants to know the name of the company that placed order 10290.
-- Note. Use subquery.

select c.CompanyName
from Customers c
where c.CustomerID = (
    select o.CustomerID
    from Orders o
    where o.OrderID = 10290
)

-- Task 8

-- Some salespeople have more orders arriving late than others. Maybe they're not following up on the order process, 
-- and need more training. Andrew, the VP of sales, has been doing some more thinking some more about the problem of late orders. 
-- He realizes that just looking at the number of orders arriving late for each salesperson isn't a good idea. 
-- It needs to be compared against the total number of orders per salesperson.
-- Note. To determine which orders are late, you can use a combination of the RequiredDate and ShippedDate. 
-- It's not exact, but if ShippedDate is actually after RequiredDate, you can be sure it's late.
-- Use the aliases AllOrders and LateOrders for the calculated columns.
-- You'll need to join to the Employee table to get the last name, and also add Count to show the total late orders.

select e.EmployeeID
    ,e.LastName
    ,count(o.OrderID) as AllOrders
    ,(
        select count(o2.OrderID)
        from Orders o2
        where o2.RequiredDate <= o2.ShippedDate
            and o2.EmployeeID = e.EmployeeID
    ) as LateOrders
from Employees e
join Orders o
    on o.EmployeeID = e.EmployeeID
group by e.EmployeeID

-- Task 9

-- We know that Andrew Fuller is the Vice President of Northwind Company. Create the report that shows the list of those employees 
-- (last and first name) who served more orders than Fuller did.

select e.LastName
    ,e.FirstName
from Employees e
join (
    select o.EmployeeID
        ,count(*) as TotalOrders
    from Orders o
    group by o.EmployeeID
) as EmployeeOrders on EmployeeOrders.EmployeeID = e.EmployeeID
join (
    select count(*) as TotalFullerOrders
    from Orders o2
    where o2.EmployeeID = (
        select e2.EmployeeID
        from Employees e2
        where e2.LastName = 'Fuller' and e2.FirstName = 'Andrew'
    )
) as FullerOrders on EmployeeOrders.TotalOrders > FullerOrders.TotalFullerOrders


-- Task 10

-- Write the query that should return the EmployeeID,  OrderID, and OrderDate. 
-- The criteria for the report is that the order must be the last for each employee (maximum OrderDate) 

select o.EmployeeID
    ,(
        select o2.OrderID as Ord
        from Orders o2
        group by o2.EmployeeID
        having o.EmployeeID = o2.EmployeeID and max(o2.OrderDate)
    ) as OrderID
    ,(
        select o3.OrderDate
        from Orders o3
        group by o3.EmployeeID
        having o.EmployeeID = o3.EmployeeID and max(o3.OrderDate)
    ) as OrderDate
from Orders o
group by o.EmployeeID