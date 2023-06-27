-------------------------- FUNCTIONS

create or replace function get_client_info()
	returns table(client_id int, last_name text, people_amount int)
as $$
begin
	return query
	select c.client_id
		,c.last_name::text
		,c.people_amount 
	from clients as c;
end;
$$ language plpgsql

select * from get_client_info() 

-----------------------------------------------

create or replace function get_orders_with_over_price(total int)
	returns table (order_id int, client_id int, total_price FLOAT)
as $$
begin
	return query
	select od.order_id
		,od.client_id
		,od.total_price
	from order_details as od
	where od.total_price > total;
end
$$ language plpgsql

select * from get_orders_with_over_price(150)

------------------------------------------------

create or replace function get_romms_with_over_rating(rate int)
	returns table (room_id int, room_rating int)
as $$
begin
	return query
	select r.room_id
		,r.room_rating 
	from rating as r
	where r.room_rating > rate;
end
$$ language plpgsql

select * from get_romms_with_over_rating(50)

--------------------------------- PROCEDURES

--- #1

create or replace PROCEDURE add_customer(
	inout added_client_id int
	,first_name varchar(50)
	,last_name varchar(50)
	,email varchar(50)
	,passport_info varchar(50)
	,phone varchar(50)
	,people_amount int
)
as $$
begin
	insert into clients(
		first_name
		,last_name
		,email
		,passport_info
		,phone
		,people_amount
	)
	values(
		first_name
		,last_name
		,email
		,passport_info
		,phone
		,people_amount
	)
	returning client_id into added_client_id;
end
$$ language plpgsql

-- calling procedure

do $$
declare
	added_client_id int;
begin
	added_client_id := 0;
	call add_customer(added_client_id, 'William', 'Hock', 'asas12323d@gmail.com', 'DERT12874', '0501255534', 6);
	raise notice 'Added customer id: %', added_client_id;
end;
$$;

--- #2

create or replace PROCEDURE add_raing(
	inout a_rating_id int
	,a_room_id int
	,a_room_rating int
)
as $$
begin
	if exists (select 1 from rooms as r where r.room_id = a_room_id) 
		and not exists (select 1 from rating as rr where rr.room_id = a_room_id) then
		insert into rating (room_id, room_rating)
		values (a_room_id, a_room_rating)
		returning rating_id into a_rating_id;
	end if;
end;
$$ language plpgsql;

-- calling procedure

do $$
declare
	rating_id int;
begin
	call add_raing(rating_id, 13, 145);
	raise notice 'Added rating with ID: %', rating_id;
end
$$;

-- 3

create or replace procedure update_rating_room(
	u_room_id int
	,u_room_rating int
)
as $$
begin 
	update rating
	set room_rating = u_room_rating
	where room_id = u_room_id;
end;
$$ language plpgsql;

do $$
begin
	call update_rating_room(6, 125);
	raise notice 'Update status completed';
end
$$;

-- 4

CREATE OR REPLACE PROCEDURE update_room_price(
  u_room_number INT
  ,u_price float(8)
)
AS $$
BEGIN
  UPDATE rooms
  SET price = u_price
  WHERE room_number = u_room_number;
END;
$$ language plpgsql;

do $$
begin
	call update_room_price(29, 125);
	raise notice 'Update status completed';
end
$$;