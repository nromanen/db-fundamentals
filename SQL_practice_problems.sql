/*1*/

select * 
from shippers s;

/*2*/

select c.category_name 
, c.description 
from categories c;

/*3*/

select e.last_name 
, e.first_name 
, e.hire_date 
from employees e
where title = 'Sales Representative';

/*4*/

select e.last_name 
, e.first_name 
, e.hire_date 
from employees e
where title = 'Sales Representative'
and country = 'USA';

/*5*/

select order_id 
, order_date
from orders
where employee_id = 5;

/*6*/

select supplier_id 
, contact_name 
, contact_title 
from suppliers s 
where contact_title != 'Marketing Manager';

/*7*/

select product_name
from products p 
where lower(p.product_name) like '%queso%';

/*8*/

select o.order_id 
, o.customer_id 
, o.ship_country 
from orders o 
where ship_country in ('France', 'Belgium');

/*9*/

select o.order_id 
, o.customer_id 
, o.ship_country 
from orders o 
where ship_country in ('Brazil' , 'Mexico' , 'Argentina' , 'Venezuela');

/*10*/

select e.first_name 
, e.last_name 
, e.title 
, e.birth_date 
from employees e 
order by e.birth_date;

/*11*/

select e.first_name 
, e.last_name 
, e.title 
, date(e.birth_date) 
from employees e 
order by e.birth_date;

/*12*/

select e.first_name  
, e.last_name 
, e.first_name || ' ' || e.last_name 
from employees e;

/*13*/

select od.order_id 
, od.product_id 
, od.unit_price 
, od.quantity 
, od.unit_price * od.quantity as total_price
from order_details od 
order by od.order_id, od.product_id;

/*14*/

select count(customer_id)
from customers c;

/*15*/

select min(o.order_date)
from orders o;

select o.order_date
from orders o
order by o.order_date
limit 1;

/*16*/

select distinct c.country 
from customers c;

/*17*/

select c.contact_title 
, count(c.customer_id) as total_contact_title
from customers c
group by c.contact_title
order by total_contact_title desc;

/*18*/

select p.product_id
, p.product_name 
, s.company_name 
from products p 
join suppliers s on p.supplier_id = s.supplier_id;

/*19*/

select o.order_id
, o.order_date 
, s.company_name 
from orders o join shippers s on o.ship_via = s.shipper_id
where o.order_id < 10300
order by o.order_id;

/*20*/

select c.category_name 
, count(p.product_id) 
from products p join categories c on p.category_id = c.category_id 
group by c.category_name 
order by count(p.product_id) desc;

/*21*/

select country
, city
, count(customer_id) 
from customers c 
group by country, city
order by count(customer_id);

/*22*/

select p.product_id 
, p.product_name 
, p.units_in_stock 
, p.reorder_level 
from products p 
where p.units_in_stock < p.reorder_level 
order by p.product_id;

/*23*/

select p.product_id 
, p.product_name 
, p.units_in_stock 
, p.units_on_order 
, p.reorder_level 
, p.discontinued 
from products p 
where (p.units_in_stock + p.units_on_order) < p.reorder_level and discontinued = 0
order by p.product_id;

/*24*/

select c.customer_id 
, c.company_name 
, c.region 
, case
when region is null then 1
else 0
end
from customers c 
order by c.region, c.customer_id;

/*25*/

select o.ship_country 
, avg(o.freight) as average_freight
from orders o 
group by o.ship_country 
order by avg(o.freight) desc
limit 3;

/*26*/

select o.ship_country 
, avg(o.freight) as "AverageFreight"
from orders o 
where extract(year from o.order_date) = 1997
group by o.ship_country
order by avg(o.freight) desc
limit 3;

/*27*/

select o.ship_country 
, avg(o.freight) as average_freight
from orders o
where
o.order_date between '1/1/1996' and '31/12/1997'
group by o.ship_country 
order by average_freight desc
limit 3;

/*28*/

/*29*/

select e.employee_id 
, last_name 
, o.order_id
, p.product_name
, od.quantity 
from employees e 
join orders o on e.employee_id = o.employee_id
join order_details od on o.order_id = od.order_id 
join products p on p.product_id = od.product_id
order by o.order_id, p.product_id ;

/*30*/

select c.customer_id 
, o.order_id 
from customers c 
left join orders o on c.customer_id = o.customer_id 
where o.order_id is null;

/*31*/



/*35*/

select o.employee_id 
, o.order_id 
, o.order_date 
from orders o 
where order_date = (date_trunc('month', order_date) + interval'1 month - 1 day')::date;



