--show, for each product, the associated Supplier from Germany and Spain.
-- Show the ProductID, ProductName, and the CompanyName of the Supplier. Sort by ProductID.

select  p.ProductID, p.ProductName, s.CompanyName
from products p
join suppliers as s on p.supplierID=s.supplierID
where s.country in ('Germany','Spain')
order by productid

-- show a list of the Orders that were made, including the Shipper that was used.
-- Show the OrderID, OrderDate (date only with alias ShortDate), and CompanyName of the
-- Shipper, and sort by OrderID. Show only those rows with an OrderID of less than 10260.

select o.OrderID, strftime('%Y-%m-%d',o.OrderDate) as ShortDate, s.companyname  
from orders o 
join shippers s on o.shipvia = s.shipperid 
where OrderID<10260
order by o.orderid 

--We're doing inventory, and need to show information about OrderID, 
--a list of products, and their quantity for orders which were shipped
-- by Leverling Janet with quantities greater than 50.
--The result should be sorted by OrderID.


select o.OrderID, p.productname , od.quantity  
from orders o 
join "order details" od on o.orderid  = od.orderid 
join products p on od.productid = p.productid  
join employees e on o.employeeid = e.employeeid 
where od.quantity > 50 and e.lastname = 'Leverling' 
order by od.quantity  -- інакше тест не проходить :)

-- There are some customers who have never actually placed an order. Show these customers.


select c.companyname
from customers c 
left join orders o on o.customerid = c.customerid 
where o.customerid is NULL

--One employee (Margaret Peacock, EmployeeID 4) has placed the most orders.
--However, there are some customers who've never placed an order with her. 
--Show only those customers who have never placed an order with her.

select c.companyname
from customers c 
left join orders o on o.customerid = c.customerid and o.employeeid = 4
where o.employeeid is NULL


--We want to send all of our high-value customers a special VIP gift. 
--We're defining high-value customers as those who've made at least 1 order with 
--a total value (not including the discount) equal to $10,000 or more. 
--We only want to consider orders made in the year 2016.
--Use the alias TotalOrderAmount for the calculated column. 
--Order by the total amount of the order, in descending order.

select    c.customerid
		, c.companyname
		, o.orderid
		, sum(od.quantity*od.unitprice ) as TotalOrderAmount
from customers c 
join orders o on o.customerid = c.customerid 
join 'order details' od on od.orderid = o.orderid
group by o.orderid , c.customerid , c.companyname 
having sum(od.quantity*od.unitprice )>10000 and strftime('%Y',o.OrderDate) = '2016'
order by totalorderamount desc


--We want to send all of our high-value customers a special VIP gift. We're defining high-value customers as 
--those who have orders totaling $15,000 or more in 2016 (not including the discount).
--Use the alias TotalOrderAmount for the calculated column.
-- Order by the total amount of the order, in descending order.

select    c.customerid
		, c.companyname
		, sum(od.quantity*od.unitprice ) as TotalOrderAmount
from customers c 
join orders o on o.customerid = c.customerid 
join 'order details' od on od.orderid = o.orderid
where strftime('%Y',o.OrderDate) = '2016'
group by c.customerid , c.companyname 
having sum(od.quantity*od.unitprice )>15000 
order by totalorderamount desc


--We want to send all of our high-value customers a special VIP gift. 
--We're defining high-value customers as orders totaling $15,000 or more in 2016.
--  The result set should include the column TotalOrderAmount with the
-- total sum not including the discount, and the column TotalWithDiscount with the 
--total sum including the discount. Order by TotalWithDiscount in descending order.

select    c.customerid
		, c.companyname
		, sum(od.quantity*od.unitprice ) as TotalOrderAmount
		, sum(ROUND(od.quantity*od.unitprice*(1-od.discount), 2)) as TotalWithDiscount
from customers c 
join orders o on o.customerid = c.customerid 
join 'order details' od on od.orderid = o.orderid
where strftime('%Y',o.OrderDate) = '2016'
group by c.customerid , c.companyname 
having sum(od.quantity*od.unitprice*(1-od.discount) )>15000 
order by TotalOrderAmount desc

--The Northwind mobile app developers are testing an app that customers
-- will use to show orders. In order to make sure that even the largest 
--orders will show up correctly on the app, they'd like some samples of
-- orders that have lots of individual line items. Show the 10 orders with 
--the most line items, in order of total line items.

select  o.orderid, count(od.orderid) as TotalOrderLines
from customers c 
join orders o on o.customerid = c.customerid 
join 'order details' od on od.orderid = o.orderid
group by o.orderid
order by TotalOrderLines desc
limit 10

--Some salespeople have more orders arriving late than others.
-- Maybe they're not following up on the order process, and need more training.
-- Which salespeople have the most orders arriving late?

select e.employeeid
		, e.lastname 
		, count(e.employeeid) as TotalLateOrders
from employees e 
join orders o on o.employeeid = e.employeeid
where o.shippeddate>o.requireddate
group by e.employeeid , e.lastname 
order by TotalLateOrders desc