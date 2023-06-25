create table clients(
	client_id serial primary key
	,first_name varchar(50)
	,last_name varchar(50)
	,email varchar(50)
	,passport_info varchar(50)
	,phone varchar(50)
	,people_amount int
);

create table rooms(
	room_id serial primary key
	,room_bumber int
	,bed_count int
	,room_type varchar(50)
	,price float
);

create table order_details(
	order_id serial primary key
	,client_id int
	,room_id int
	,check_in timestamp
	,check_out timestamp
	,total_price float
	,foreign key(client_id) references clients(client_id)
	,foreign key(room_id) references rooms(room_id)
);


create table rating(
	rating_id serial primary key
	,room_id int
	,room_rating int
	,foreign key(room_id) references rooms(room_id)
);