/*Practice*/
/*1. Create a report showing the first and last name of all sales representatives who are from  Seattle or Redmond. */

select e.first_name 
, e.last_name 
from employees e 
where e.city = 'Seattle' or e.city = 'Redmond';

/*2. Create a report that shows the company name, contact title, city and country of all  
  customers in Mexico or in any city in Spain except Madrid.  */

select c.company_name 
, c.contact_title 
, c.city
, c.country 
from customers c 
where c.country in ('Mexico', 'Spain')
and city != 'Madrid';

/*Practice*/
/*1. Show first and last names of the employees as well as the count of orders each of them have received during the year 1997.*/

select e.first_name 
, e.last_name 
, count(order_id)
from employees e 
left join orders o 
on e.employee_id = o.employee_id 
where extract (year from o.order_date) = 1997
group by e.employee_id;

/*2. Show first and last names of the employees as well as the count of their orders shipped after required date during the year 1997. */

select e.first_name 
, e.last_name 
, count(order_id)
from employees e 
left join orders o 
on e.employee_id = o.employee_id 
where o.required_date < o.shipped_date and extract (year from o.order_date) = 1997
group by e.employee_id;

/*3. Create a report showing the information about employees and orders, whenever they had orders or not. */

select e.first_name 
, e.last_name 
, order_id
from employees e 
left join orders o 
on e.employee_id = o.employee_id 
order by o.order_id;

/*Practice*/
/*1. Show the list of French customers’ names who used to order non-French products.*/

select c.company_name 
from customers c 
join orders o on c.customer_id = o.customer_id 
join order_details od on o.order_id = od.order_id 
join products p on p.product_id = od.product_id 
join suppliers s on s.supplier_id = p.supplier_id 
where c.country = 'France' and s.country !='France';

/*2. Show the list of suppliers, products and its category.*/

select s.company_name 
, p.product_name 
, c.category_name 
from suppliers s 
inner join products p 
on s.supplier_id = p.supplier_id
inner join categories c 
on p.category_id = c.category_id;

/*3. Create a report that shows all  information about suppliers and products.*/ 
select *
from suppliers s 
full join products p 
on s.supplier_id = p.supplier_id;



