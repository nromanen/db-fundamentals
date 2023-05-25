--1. Create a report that shows the CompanyName and total number of orders by the customer since December 31, 2015.
--Show the number of Orders greater than 10. Use alias NumberofOrders for the calculated column.

select
	c.company_name
	,count(*) as number_of_orders
from customers c
join orders o on c.customer_id = o.customer_id
where o.order_date > '2015-12-31'
group by c.company_name
having count(*) > 10
order by lower(c.company_name)

-----------------------------------------------------------------------------------------

--2. Create a report that shows the EmployeeID, the LastName and FirstName as Employee (alias), and the LastName
--and FirstName of who they report to as Manager (alias) from the Employees table sorted by EmployeeID.

select
	e1.employee_id
	,concat_ws(' ', e1.last_name, e1.first_name) as employee
	,concat_ws(' ', e2.last_name, e2.first_name) as manager
from employees e1
left join employees e2 on e1.reports_to = e2.employee_id

-----------------------------------------------------------------------------------------

--3. Create a report that shows the  ContactName of customer, TotalSum
--(alias for the calculated column UnitPrice*Quantity*(1-Discount)) from the Order Details, and Customers table
--with the discount given on every purchase. Show only VIP customers with TotalSum greater than 10000.

select
	c.contact_name
	,sum(od.unit_price * od.quantity * (1- od.discount))::numeric(16,2) as total_sum
from customers c
join orders o on c.customer_id = o.customer_id
join order_details od on od.order_id = o.order_id
where od.discount > 0
group by c.contact_name
having sum(od.unit_price * od.quantity * (1- od.discount))::numeric(16,2) > 10000
order by c.contact_name

-----------------------------------------------------------------------------------------

--4. Create a report that shows the total quantity of products (alias TotalUnits)
--ordered. Only show records for products for which the quantity ordered is fewer than 200.

select
	p.product_name
	,sum(od.quantity) as total_units
from order_details od
join products p on od.product_id = p.product_id
group by p.product_name
having sum(od.quantity) < 200
order by p.product_name

-----------------------------------------------------------------------------------------

--5. Create a report that shows the total number of orders (alias NumOrders ) by Customer since December 31, 2015.
--The report should only return rows for which the NumOrders is greater than 5.
--The result should be sorted by NumOrders descending.

select
	c.company_name
	,count(o.order_id) as num_orders
from customers c
join orders o on c.customer_id = o.customer_id
where o.order_date > '2015-12-31'
group by c.company_name
having count(o.order_id) > 5
order by count(o.order_id) desc

-----------------------------------------------------------------------------------------

--6. Create a report that shows the company name, order id, and total price (alias TotalPrice) of all products of which
--Northwind has sold more than $10,000 worth. The result should be sorted by TotalPrice descending

select
	c.company_name
	,o.order_id
	,sum(od.unit_price * od.quantity * (1-od.discount))::numeric(16,2)
from orders o
join order_details od on o.order_id = od.order_id
join customers c on o.customer_id = c.customer_id
group by c.company_name, o.order_id, od.product_id
having sum(od.unit_price * od.quantity * (1-od.discount))::numeric(16,2) > 10000
order by sum(od.unit_price * od.quantity * (1-od.discount))::numeric(16,2) desc

-----------------------------------------------------------------------------------------


--7. Create a report that shows the number of employees (alias numEmployees) and number of customers (alias numCompanies)
--from each city that has employees in it. The result should be ordered by the name of city.

select
	count(distinct e.employee_id) as num_employees
	,count(distinct c.customer_id) as num_companies
	,e.city
from employees e
join customers c on e.city = c.city
group by e.city
order by count(distinct e.employee_id)

-----------------------------------------------------------------------------------------

--8. Get the lastname and firstname of employee (alias Name), company names and phone numbers (alias Phone)
--of all employees, customers, and suppliers, who are situated in London. Add the column (alias Type) to the result set
--which should specify what type of counterparty (employee, customer, or supplier) it is.

select
	c.company_name as name
	,c.phone
	,'customer' as type
from customers c
where c.city = 'London'
union
select
	concat_ws(' ', e.first_name, e.last_name) as name
	,e.home_phone as phone
	,'employee' as type
from employees e
where e.city = 'London'
union
select
	s.company_name as name
	,s.phone
	,'supplier' as type
from suppliers s
where s.city = 'London'
order by 3

-----------------------------------------------------------------------------------------

--9. Write the query which would show the list of employees (FirstName and LastName)
--and their total sales (alias TotalSales) who have sold more than 200 positions of products.

select
	e.first_name
	,e.last_name
	,sum(od.unit_price * od.quantity * (1-od.discount))::numeric(16,2) as total_sales
from employees e
join orders o on e.employee_id = o.employee_id
join order_details od on o.order_id = od.order_id
group by e.first_name, e.last_name
having count(od.product_id) > 200
order by e.first_name

-----------------------------------------------------------------------------------------

--10. Write the query which would show the names of employees who sell the products
--of more than 25 suppliers during the 2016 year.

select
	e.first_name
	,e.last_name
from employees e
join orders o on e.employee_id = o.employee_id
join order_details od on o.order_id = od.order_id
join products p on od.product_id = p.product_id
join suppliers s on p.supplier_id = s.supplier_id
where extract(year from o.order_date) = 2016
group by e.employee_id
having count(distinct s.supplier_id) > 25
order by e.first_name

-----------------------------------------------------------------------------------------