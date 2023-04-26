 --1. Show the list of customers’ names who used to order the ‘Tofu’ product (use a subquery).

		select contact_name 
		from customers
		where customer_id in (
			select customer_id 
			from orders
			where order_id in(
				select order_id
				from order_details
				where product_id = (
					select product_id
					from products
					where product_name = 'Tofu'
				)
			)
		);	
    
    
--2. Show the list of customers’ names who used to order the ‘Tofu’ product, 
--along with the total amount of the product they have ordered and with the total sum 
--for ordered product calculated.(use only a subquery).
		
		
	select c.ContactName, sum(od.Quantity) as Amounth, 
	round(sum(od.Quantity * od.UnitPrice * (1-od.Discount)), +2) as Sum
	from Customers c
	inner join Orders o on c.CustomerID = o.CustomerID
	inner join [Order Details] od on o.OrderID = od.OrderID
	where od.ProductID = (
	    select p.ProductID 
	    from Products p 
	    where p.ProductName = 'Tofu'
	)
	group by 1;
  
  
  --3. Show the list of french customers’ names who used to order non-french products (use a subquery).
	
	select ContactName 
	from Customers 
	where CustomerId in (
			select CustomerId 
			from Orders 
			where OrderId in (
				select OrderId
				from OrderDetails 
				where ProductId in (
					select ProductId
					from Products
					where SupplierId in(
						select SupplierId
						from Suppliers 
						where Country not like 'France'
					)
				)
			)	
		) and Country like 'France';

--4. Show the total ordering sums calculated for each customer’s country for domestic and non-domestic products separately 
-- (e.g.: “France – French products ordered – Non-french products ordered” and so on for each country).

select VT.ShipCountry, SUM(Domestic) AS Domestic, SUM(NonDomestic) AS 'Non-domestic'
from
  (
    select
      o.ShipCountry,
      case
        when o.ShipCountry = s.Country then round(
          sum(od.UnitPrice * od.Quantity * (1 - od.Discount)),
          2
        )
        else NULL
      end as Domestic,
      case
        when o.ShipCountry <> s.Country then round(
          sum(od.UnitPrice * od.Quantity * (1 - od.Discount)),
          2
        )
        else NULL
      end as NonDomestic
    from
      "Order Details" od
      left join Orders o on od.OrderID = o.OrderID
      left join Customers c on o.CustomerID = c.CustomerID
      left join Products p on od.ProductID = p.ProductID
      left join Suppliers s on p.SupplierID = s.SupplierID
    group by
      o.ShipCountry,
      c.CompanyName,
      s.Country
  ) VT
group by 1;


--1. Create a report that shows the product name and supplier id for all products supplied by Exotic Liquids, Grandma Kelly's Homestead, and Tokyo Traders.
	
	select product_name, supplier_id
	
	from products p
	where supplier_id in 
		(select supplier_id 
		from suppliers
		where company_name in ('Exotic Liquids', 'Grandma Kellys', 'Homestead', 'Tokyo Traders'));
	
	
	--2. Create a report that shows all the products which are supplied by a company called ‘Pavlova, Ltd.’.
	
	select product_name 
	from products
	where supplier_id = 
		(select supplier_id
		from suppliers
		where company_name like 'Pavlova, Ltd.');
		
	
	--3. Create a report that shows the orders placed by all the customers excluding the customers who belongs to London city.
	
	select * 
	from orders
	where customer_id not in
		(select customer_id
		from customers
		where city = 'London');
		
	--4. Create a report that shows all the customers if there are more than 30 orders shipped in London city.
	
	select company_name 
	from customers
	where customer_id in
		(select customer_id 
		from orders
		where ship_city = 'London');
	
		
	--5. Create a report that shows all the orders where the employee’s city and order’s ship city are same.
		
		select *
		from orders o 
		where o.employee_id  in 
			(select e.employee_id 
			from employees e 
			where e.city = o.ship_city);
