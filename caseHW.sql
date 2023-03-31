select c.company_name,
       case
           when (sum(od.unit_price * od.quantity * (1 - od.discount)) >
                 (select avg(val)
                  from (select sum(od.unit_price * od.quantity * (1 - od.discount)) as val
                        from orders o
                                 inner join order_details od on o.order_id = od.order_id
                        group by o.order_id) as inner_sum)) then 'A'

           when (sum(od.unit_price * od.quantity * (1 - od.discount)) <
                 (select avg(val)
                  from (select sum(od.unit_price * od.quantity * (1 - od.discount)) as val
                        from orders o
                                 inner join order_details od on o.order_id = od.order_id
                        group by o.order_id) as inner_sum)) then 'C'

           when (sum(od.unit_price * od.quantity * (1 - od.discount)) =
                 (select avg(val)
                  from (select sum(od.unit_price * od.quantity * (1 - od.discount)) as val
                        from orders o
                                 inner join order_details od on o.order_id = od.order_id
                        group by o.order_id) as inner_sum)) then 'B'
           else 'unknown'
           end as company_info
from customers c
         inner join orders o
                    on c.customer_id = o.customer_id
         inner join order_details od on o.order_id = od.order_id
group by c.company_name, o.order_id;