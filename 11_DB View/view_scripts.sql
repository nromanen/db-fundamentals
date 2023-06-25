create view hor_client_view
as
	select *
	from clients as c
	where client_id < 6

create view ver_client_view
as
	select c.first_name
		,c.email
		,c.people_amount
	from clients as c
	
create view mixed_client_view
as
	select c.first_name
		,c.email
		,c.people_amount 
	from clients as c
	where client_id > 5
	
create view clients_with_join
as
	select c.client_id
		,c.last_name
		,od.order_id
		,r.room_id
	from clients as c
	join order_details as od
		on c.client_id = od.client_id 
	join rooms as r
		on od.room_id = r.room_id
		
create view clients_wtih_subquery
as
	select c.client_id
		,c.first_name 
	from clients as c
	where people_amount < (select avg(c2.people_amount) from clients as c2)
		
create view clients_with_union
as
	select c.client_id
		,c.last_name
	from clients as c
	where c.client_id < 5
	union 
	select c2.client_id
		,c2.last_name
	from clients as c2
	where c2.people_amount < 2
	

create view clients_on_other_view
as
	select * 
	from clients_with_join as cj
	where cj.client_id > 5
	
create view orders_with_check_options
as
	select od.client_id
		,od.room_id
		,od.total_price
	from order_details as od
	with check option
	
	
	
	
	
	
select * from clients_on_other_view
	
select * from clients_wtih_subquery	
	
select avg(people_amount)
from clients as c

select * from clients
		
select * 
from clients_with_join
		
select * from mixed_client_view
	
select *
from ver_client_view
	
select *
from hor_client_view 