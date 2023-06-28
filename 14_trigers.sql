-------------------------------#1

create or replace function add_rating()
returns trigger as $$
declare last_room_id int;
begin
	select room_id
	into last_room_id
	from order_details
	order by order_id desc
	limit 1;
	update rating
	set room_rating = room_rating + 1
	where room_id = last_room_id;
	return new;
end;
$$ language plpgsql;

create trigger add_rating_trigger
after insert on order_details
for each row 
execute function add_rating();

------------------------------- #2

create or replace function add_item_rating()
returns trigger as $$
declare last_room_id int;
begin
	select room_id
	into last_room_id
	from rooms
	order by room_id desc
	limit 1;
	insert into rating(room_id, room_rating)
	values (last_room_id, 0);
	return new;
end;
$$ language plpgsql;

create trigger add_item_rating_trigger
after insert on rooms
for each row 
execute function add_item_rating();

------------------------------ # 3

CREATE OR REPLACE FUNCTION change_total_price_od()
RETURNS TRIGGER AS $$
BEGIN
  UPDATE order_details
  SET total_price = new.price
  WHERE room_id = new.room_id;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER change_total_price_od_trigger
AFTER UPDATE OF price ON rooms
FOR EACH ROW
EXECUTE FUNCTION change_total_price_od();

DROP TRIGGER IF EXISTS change_total_price_od_trigger ON rooms;