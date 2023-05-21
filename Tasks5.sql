--Q1
--Here’s a data model of the relationship between Products and Suppliers.
--We’d like to show, for each product, the associated Supplier from Germany and Spain. Show the ProductID, ProductName, and the CompanyName of the Supplier. Sort by ProductID.
--Note. The Join clause is used to join two or more relational database tables together in a logical way.
--
----SQLite
--select 
--	ProductID
--	, ProductName
--	, CompanyName
--from Products P
--join Suppliers S on P.SupplierID = S.SupplierID
--where S.Country in ('Germany', 'Spain')
--order by ProductID

select 
	product_id 
	, product_name 
	, company_name
from products p
join suppliers s on p.supplier_id = s.supplier_id 
where s.country in ('Germany', 'Spain')
order by p.product_id 

--Q2
--Here’s a data model of the relationship between Orders and Shippers.
--We’d like to show a list of the Orders that were made, including the Shipper that was used. 
--Show the OrderID, OrderDate (date only with alias ShortDate), and CompanyName of the Shipper, and sort by OrderID. Show only those rows with an OrderID of less than 10260.
--Note. Use strftime('%Y-%m-%d', OrderDate) function to extract only date.
--
----SQLite
--select
--    O.OrderID
--    , strftime('%Y-%m-%d', O.OrderDate) as ShortDate
--    , S.CompanyName
--from Shippers S
--join Orders O on O.ShipVia = S.ShipperID
--    and O.OrderID < 10260
--order by O.OrderID

select
    o.order_id
    , extract(year from o.order_date) as ShortDate
    , s.company_name
from shippers s 
join orders o  on o.ship_via = s.shipper_id
    and o.order_id < 10260
order by o.order_id

--Q3
--We're doing inventory, and need to show information about OrderID, a list of products, and their quantity for orders which were shipped by Leverling Janet with quantities greater than 50.
--The result should be sorted by OrderID.
--
----SQLite
--select 
--    O.OrderID
--    , P.ProductName as ProductName
--    , OD.Quantity as Quantity
--from Employees E
--join Orders O on E.EmployeeID = O.EmployeeID
--join "Order Details" OD on O.OrderID = OD.OrderID
--join Products P on OD.ProductID = P.ProductID
--and E.LastName = 'Leverling'
--and OD.Quantity > 50
--order by OD.Quantity, O.OrderID

select 
    o.order_id
    , p.product_name as ProductName
    , od.quantity as Quantity
from employees e 
join orders o on e.employee_id = o.employee_id
join order_details od on o.order_id = od.order_id
join products p on od.product_id = p.product_id
and e.last_name = 'Leverling'
and od.quantity > 50
order by od.quantity, o.order_id


--Q4
--There are some customers who have never actually placed an order. Show these customers.
--
----SQLite
--select C.CompanyName
--from Customers C
--left join Orders O
--on C.CustomerID = O.CustomerID
--where O.CustomerID is null

select c.company_name
from customers c 
left join orders o on c.customer_id = o.customer_id 
where o.customer_id is null

--Q5
--One employee (Margaret Peacock, EmployeeID 4) has placed the most orders. 
--However, there are some customers who've never placed an order with her. Show only those customers who have never placed an order with her.
----SQLite
--select C.CompanyName
--from Customers C
--left join Orders O
--on C.CustomerID = O.CustomerID
--and O.EmployeeID = 4
--where O.OrderID is null

select c.company_name
from customers c 
left join orders o on c.customer_id = o.customer_id 
	and o.employee_id = 4
where o.customer_id is null

--Q6
--We want to send all of our high-value customers a special VIP gift. 
--We're defining high-value customers as those who've made at least 1 order with a total value (not including the discount) equal to $10,000 or more. 
--We only want to consider orders made in the year 2016.
--Use the alias TotalOrderAmount for the calculated column. Order by the total amount of the order, in descending order.
----SQLite
--select 
--    C.CustomerID
--    , C.CompanyName
--    , OD.OrderID
--    , sum(OD.UnitPrice * OD.Quantity) as TotalOrderAmount
--from Orders O
--join Customers C
--on O.CustomerID = C.CustomerID
--and strftime('%Y', O.OrderDate) = '2016'
--join "Order Details" OD
--on O.OrderID = OD.OrderID
--group by O.OrderID
--having TotalOrderAmount >= 10000
--order by TotalOrderAmount desc

select 
    c.customer_id
    , c.company_name
    , od.order_id
    , sum(od.unit_price * od.quantity) as TotalOrderAmount
from orders o 
join customers c on o.customer_id = c.customer_id 
	and extract(year from o.order_date) = 1997
join order_details od on o.order_id = od.order_id 
group by c.customer_id, od.order_id
having sum(od.unit_price * od.quantity) >= 10000
order by sum(od.unit_price * od.quantity) desc

--Q7
--We want to send all of our high-value customers a special VIP gift. We're defining high-value customers as those who have orders totaling $15,000 or more in 2016 (not including the discount). 
--Use the alias TotalOrderAmount for the calculated column. Order by the total amount of the order, in descending order.
----SQLite
--select 
--    C.CustomerID,
--    C.CompanyName,
--    sum(OD.UnitPrice * OD.Quantity) as TotalOrderAmount
--from Orders O
--join "Order Details" OD on O.OrderID = OD.OrderID
--and strftime('%Y', O.OrderDate) = '2016'
--join Customers C on O.CustomerID = C.CustomerID
--group by C.CustomerID
--having TotalOrderAmount >= 15000
--order by TotalOrderAmount desc

select 
    c.customer_id
    , c.company_name
    , sum(od.unit_price * od.quantity) as TotalOrderAmount
from orders o 
join order_details od on o.order_id = od.order_id
	and extract(year from o.order_date) = 1997
join customers c on o.customer_id = c.customer_id 
group by c.customer_id, od.order_id
having sum(od.unit_price * od.quantity) >= 10500
order by sum(od.unit_price * od.quantity) desc

--Q8
--We want to send all of our high-value customers a special VIP gift. 
--We're defining high-value customers as orders totaling $15,000 or more in 2016.  
--The result set should include the column TotalOrderAmount with the total sum not including the discount, and the column TotalWithDiscount with the total sum including the discount.
--Order by TotalWithDiscount in descending order.
----SQLite
--select 
--    C.CustomerID,
--    C.CompanyName,
--    sum(OD.UnitPrice * OD.Quantity) as TotalOrderAmount,
--    round(sum(OD.UnitPrice * OD.Quantity * (1 - OD.Discount)), 2) as TotalWithDiscount
--from Orders O
--join "Order Details" OD on O.OrderID = OD.OrderID
--and strftime('%Y', O.OrderDate) = '2016'
--join Customers C on O.CustomerID = C.CustomerID
--group by C.CustomerID
--having TotalWithDiscount >= 15000
--order by TotalOrderAmount desc

select 
    c.customer_id
    , c.company_name
    , sum(od.unit_price * od.quantity) as TotalOrderAmount
    , round(sum(od.unit_price * od.quantity * (1 - od.discount))::numeric, 2) as TotalWithDiscount
from orders o
join order_details od on o.order_id = od.order_id
	and extract(year from o.order_date) = 1997
join customers c on o.customer_id = c.customer_id 
group by c.customer_id
having round(sum(od.unit_price * od.quantity * (1 - od.discount))::numeric, 2) > 10500
order by sum(od.unit_price * od.quantity) desc

--Q9
--The Northwind mobile app developers are testing an app that customers will use to show orders. 
--In order to make sure that even the largest orders will show up correctly on the app, they'd like some samples of orders that have lots of individual line items. 
--Show the 10 orders with the most line items, in order of total line items.
----SQLite
--select 
--    O.OrderID,
--    count(OD.ProductID) as TotalOrderLines
--from Orders O
--join "Order Details" OD
--on O.OrderID = OD.OrderID
--group by O.OrderID
--order by TotalOrderLines desc
--limit 10

select 
    o.order_id
    , count(od.product_id) as TotalOrderLines
from orders o 
join order_details od 
on o.order_id  = od.order_id 
group by o.order_id 
order by count(od.product_id) desc
limit 10

--Q10
--Some salespeople have more orders arriving late than others. 
--Maybe they're not following up on the order process, and need more training. Which salespeople have the most orders arriving late?
----SQLite
--select 
--    O.EmployeeID,
--    E.LastName
--    ,count(O.EmployeeID) as TotalLateOrders
--from Orders O
--join Employees E
--on O.EmployeeID = E.EmployeeID
--where O.ShippedDate > O.RequiredDate
--group by O.EmployeeID
--order by TotalLateOrders desc, E.EmployeeID

select 
	o.employee_id 
	, e.last_name 
	, count(o.employee_id) as TotalLateOrders
from orders o 
join employees e on o.employee_id = e.employee_id 
where o.shipped_date > o.required_date 
group by o.employee_id, e.employee_id 
order by count(o.employee_id) desc, o.employee_id 
