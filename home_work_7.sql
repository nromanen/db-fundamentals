/*Task 1*/
/*1. Show first and last names of the employees who have the biggest freight.*/

select e.first_name 
, e.last_name 
from employees e 
join orders o on o.employee_id = e.employee_id 
where o.freight  = 
(select max(freight)
from orders);

/*2. Show first, last names of the employees, their freight who have the freight bigger then avarage.*/

select e.first_name 
, e.last_name 
, o.freight 
from employees e 
join orders o on e.employee_id = o.employee_id 
where o.freight > 
(select avg(o1.freight)
from orders o1);

/*3. Show the names of products, that have the biggest price.*/

select p.product_name 
from products p 
where p.unit_price = 
(select max(p2.unit_price)
from products p2); 

/*4. Show the name of customers with the freight bigger then avarage.*/

select c.company_name 
from customers c 
left join orders o on c.customer_id = o.customer_id 
where o.freight > 
(select avg(o2.freight)
from orders o2); 

/*5. Show the name of supplier  who delivered the cheapest product.*/

select s.company_name 
from suppliers s  
join products p on s.supplier_id = p.supplier_id 
where p.unit_price = 
(select min(p2.unit_price)
from products p2);

/*Task 2*/
/*1. Show the name of the category in which the average price of  a certain product is greater than the grand average in the whole stock.*/

select c.category_name 
, avg(p.unit_price)
from categories c 
join products p on p.category_id = c.category_id 
group by c.category_id, c.category_name  
having avg(p.unit_price) > 
(select avg(p2.unit_price)
from products p2);

/*2. Show the name of the supplier whose delivery  is lower than the grand average in the whole stock.*/

select s.company_name 
, avg(o.freight)
from suppliers s
join products p on p.supplier_id = s.supplier_id 
join order_details od on od.product_id = p.product_id 
join orders o on o.order_id = od.order_id 
group by s.supplier_id 
having avg(o.freight) < 
(select avg(o2.freight)
from orders o2);

/*3. Show the regions where employees work, the middle age of which is higher than over the whole company.*/

select e.region 
from employees e 
group by e.region 
having avg(age(birth_date))>
(select avg(age(e2.birth_date))
from employees e2);

/*4. Show customers whose maximum freight level is less than the average for all customers.*/

select c.company_name
from customers c 
join orders o on o.customer_id = c.customer_id
group by c.customer_id
having max(o.freight) < 
(select avg(o2.freight)
from orders o2);

/*5. Show the categories of products for which the average discount is higher than the average discount for all products.*/

select c.category_name 
from categories c 
join products p on p.category_id = c.category_id 
join order_details od on od.product_id = p.product_id 
group by c.category_id 
having avg(od.discount) >
(select avg(od2.discount)
from order_details od2);

/*Task 3*/
/*1. Calculate the average freight of all employees who work not with Western region.*/

select concat(e.last_name, ' ', e.first_name)
, avg(o.freight)
from employees e 
join orders o on o.employee_id = e.employee_id 
where e.employee_id not in 
(select o.employee_id 
from orders o2 
where o2.ship_region = 'WA')
group by e.employee_id;

/*2. Show first and last names of employees who shipped orders in cities of USA.*/

select distinct e.first_name 
, e.last_name 
from employees e 
join orders o on o.employee_id = e.employee_id 
where o.ship_city in 
(select o2.ship_city
from orders o2
where o2.ship_country = 'USA');

/*3. Show the names of products and their total cost, which were delivered by German suppliers.*/

select p.product_name 
, sum(p.unit_price)
from suppliers s 
join products p on p.supplier_id = s.supplier_id 
where s.supplier_id in
(select s2.supplier_id 
from suppliers s2
where s.country = 'Germany')
group by p.product_id;

/*4. Show first and last names of employees that don’t work with Eastern region.*/

select distinct e.first_name 
, e.last_name 
from employees e 
where e.employee_id not in 
(select e1.employee_id  
from orders o
join employees e1 on o.employee_id = e1.employee_id 
where o.ship_region = 'AK');

/*5. Show the name of customers that prefer to order non-domestic products.*/

select c.contact_name 
from customers c 
join orders o on o.customer_id = c.customer_id 
join order_details od on o.order_id = od.order_id 
join products p on p.product_id = od.product_id 
join suppliers s2 on s2.supplier_id = p.supplier_id 
where c.country not in 
(select s.country 
from suppliers s)
group by c.customer_id;

/*Task 4*/
/*1. Show employees (first and last name) working with orders from the United States.*/

select e.first_name 
, e.last_name 
from employees e 
where e.employee_id = any 
(select o.employee_id 
from orders o
where o.ship_country = 'USA');

/*2. Show the info about orders, that contain the cheapest products from USA.*/

select o.order_id 
, p.unit_price 
, s.country 
, o.shipped_date 
, o.ship_country 
from orders o 
join order_details od ON o.order_id = od.order_id 
join products p on od.product_id = p.product_id 
join suppliers s on s.supplier_id = p.supplier_id 
where s.supplier_id = any 
(select s2.supplier_id 
from suppliers s2
where s2.country = 'USA') and p.unit_price = 
(select min(p2.unit_price) 
from suppliers s3
join products p2 on p2.supplier_id = s3.supplier_id 
where s3.country = 'USA'
group by s3.country);

/*3. Show the info about customers that prefer to order meat products and never order drinks.*/

select *
from customers c2 
group by customer_id 
having c2.customer_id = any
(select o.customer_id 
from orders o 
where o.order_id in 
(select od.order_id 
from order_details od 
where od.product_id = any 
(select p.product_id 
from products p 
where p.category_id = any 
(select c.category_id 
from categories c
where c.description like '%meat%' or c.description like '%drink%'))));

/*4. Show the list of cities where employees and customers are from and where orders have been made to. Duplicates should be eliminated.*/

select e.city 
from employees e 
union 
select c.city 
from customers c
union 
select o.ship_city 
from orders o; 

/*5. Show the lists the product names that order quantity equals to 100.*/

select p.product_name 
from products p 
where p.product_id = any 
(select od.product_id 
from order_details od
where od.quantity = 100);

/*Task 5*/
/*1. Show the lists the suppliers with a product price equal to 10$.*/

select s.company_name  
from suppliers s 
where s.supplier_id = any 
(select p.supplier_id 
from products p
where p.unit_price = 10);

/*2. Show the list of employee that perform orders with freight 1000.*/

select *
from employees e 
where e.employee_id = any 
(select o.employee_id 
from orders o
where o.freight = 1000);

/*3. Find the Companies that placed orders in 1997.*/

select c.company_name 
from customers c 
where c.customer_id = any 
(select o.customer_id 
from orders o
where extract(year from o.order_date) = 1997);

/*4. Create a report that shows all products by name that are in the Seafood category.*/

select p.product_name 
from products p 
where p.category_id = any 
(select c.category_id 
from categories c
where c.category_name like 'Seafood');

/*5. Create a report that shows all companies by name that sell products in the Dairy Products category.*/

select s.company_name 
from suppliers s 
where s.supplier_id = any 
(select p.supplier_id 
from products p
where p.category_id = any
(select c.category_id 
from categories c
where c.category_name = 'Dairy Products'));

/*Home work*/
/*1. Create a report that shows the product name and supplier id for all products supplied by Exotic Liquids, 
    Grandma Kelly's Homestead, and Tokyo Traders.*/

select p.product_name 
, p.supplier_id 
from products p 
where p.supplier_id = any 
(select s.supplier_id 
from suppliers s
where s.company_name in ( 'Exotic Liquids', 
    /*"Grandma Kelly's Homestead",*/ 'Tokyo Traders'));

/*2. Create a report that shows all the products which are supplied by a company called ‘Pavlova, Ltd.’.*/
   
select p.product_id 
, p.product_name 
from products p 
where p.supplier_id =
(select s.supplier_id 
from suppliers s
where s.company_name = 'Pavlova, Ltd.');
   
/*3. Create a report that shows the orders placed by all the customers excluding the customers who belongs to London city.*/

select *
from orders o 
where o.customer_id not in 
(select c.customer_id 
from customers c 
where c.city = 'London');

/*4. Create a report that shows all the customers if there are more than 30 orders shipped in London city.*/

select c.company_name
from customers c 
join orders o on c.customer_id = o.customer_id 
group by c.customer_id 
having count(c.customer_id in (select o2.customer_id from orders o2 where o2.ship_city = 'London')) > 30;

/*5. Create a report that shows all the orders where the employee’s city and order’s ship city are same.*/

select *
from orders o 
join employees e on e.employee_id = o.employee_id 
where e.city = any
(select o.ship_city
from orders);



