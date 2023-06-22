-- Janet Leverling, one of the salespeople, has come to you with a request. 
--She thinks that she accidentally double-entered a line item on an order, 
--with a different ProductID, but the same quantity. She remembers that the quantity
-- was 60 or more. Show all the OrderIDs that match this, in order of OrderID.

select i.OrderID as OrderID
from (select od.orderid, count(od.productid), od.quantity from "order details" od where od.quantity >= 60 group by od.orderid, od.quantity
having count(od.productid)>=2) as i
order by i.orderid


--We know that Andrew Fuller is the Vice President of Northwind Company. 
--Create the report that shows the list of those employees (last and first name)
--sewho were hired earlier than Fuller.

select e.lastname 
	 , e.firstname 
from employees e 
where e.hiredate<
(
select e2.hiredate
from employees e2 
where e2.lastname='Fuller' and e2.firstname='Andrew'
)

--Write the query which should create the list of products and their unit price for 
--products with price greater than average products' unit price

select p.productname 
      ,p.unitprice
from products p 
where p.unitprice > (
	select avg(p2.unitprice)
	from products p2 
)
order by p.unitprice 

--Create the report that should show  the Companies from Germany
-- that placed orders in 2016

select c.companyname 
from customers c 
where c.customerid in (
	select distinct customerid 
	from orders o 
	where STRFTIME('%Y', OrderDate)='2016'
) and c.country = 'Germany'

--Create the query that should show the date when the orders were shipped 
--(alias ShippedDate),  the number of orders  (NumberOfOrders) and 
--total sum (including discount) of the orders (Total) shipped at this date. 
--The report includes only the 1st quarter of 2016 with the number of orders 
--greater than 3. The result should be sorted by ShippedDate

select o.shippeddate, count(distinct o.orderid) as NumberOfOrders
      ,round(cast(sum(od.unitprice*od.quantity*(1-od.discount)) as numeric),2) as Total
from orders o 
join "order details" od on o.orderid = od.orderid 
where o.shippeddate  between '2016-01-01' and '2016-03-31'
group by o.shippeddate 
having count(distinct o.orderid)>3
order by o.shippeddate

--For the category 'Dairy Products' get the list of products sold and the total sales
-- amount including discount (alias ProductSales) during the 1st quarter of 2016 year.


select c.categoryname , sq.ProductName, sq.ProductSales
from (select p.categoryid as cat_id , p.productname as ProductName , sum(round(cast (od.unitprice * od.quantity *(1-od.discount) as numeric),2)) as ProductSales
from "order details" od 
join orders o on od.orderid = o.orderid 
join products p on p.productid = od.productid 
where o.orderdate between '2016-01-01' and '2016-03-31'
group by p.categoryid, p.productname ) as sq
join categories c on sq.cat_id = c.categoryid 
where c.categoryname = 'Dairy Products'

--Andrew, the VP of sales, wants to know the name of the company that placed order 10290.

select oc.CompanyName
from (select o.orderid as OrderId, c.companyname as CompanyName
from orders o 
join customers c on o.customerid = c.customerid ) as oc
where oc.OrderId = 10290

-- Some salespeople have more orders arriving late than others. 
--Maybe they're not following up on the order process, and need more training.
--  Andrew, the VP of sales, has been doing some more thinking some more about
-- the problem of late orders. He realizes that just looking at the number of orders
-- arriving late for each salesperson isn't a good idea. It needs to be compared 
--against the total number of orders per salesperson.

select e.employeeid , e.lastname , ord.AllOrders , lateord.LateOrders
from employees e 
join(
select o.employeeid, count (o.orderid)as AllOrders
from orders o
group by employeeid ) as ord on ord.employeeid = e.employeeid 
join(
select o2.employeeid, count (o2.orderid) as LateOrders
from orders o2
where o2.shippeddate >= o2.requireddate 
group by o2.employeeid )as lateord on e.employeeid = lateord.employeeid 
order by e.employeeid 

--We know that Andrew Fuller is the Vice President of Northwind Company. 
--Create the report that shows the list of those employees (last and first name)
-- who served more orders than Fuller did.

select e.lastname, e.firstname
from (select o.employeeid as eid, count(o.orderid) as ord
from orders o 
group by o.employeeid ) as ordcount
join employees e on ordcount.eid = e.employeeid 
where ordcount.ord > (
select  count(o3.orderid) 
from orders o3 
where o3.employeeid = (select e3.employeeid from employees e3 where e3.lastname = 'Fuller')
)

--Write the query that should return the EmployeeID,  OrderID, and OrderDate. 
--The criteria for the report is that the order must be the last for each employee (maximum OrderDate) 

select e.employeeid
	  ,(select max(o.orderid )
	  	from orders o
	  	where o.employeeid = e.employeeid and o.orderdate = (select max(o3.orderdate )
	  	from orders o3
	  	where o3.employeeid = e.employeeid  )
	  	) as OrderID
	  ,(select max(o1.orderdate )
	  	from orders o1
	  	where o1.employeeid = e.employeeid  ) as OrderDate 
from  employees e
where (select o.orderid
	  	from orders o
	  	where o.employeeid = e.employeeid) is not null
