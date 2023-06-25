insert into clients (first_name, last_name, email, passport_info, phone, people_amount)
values ('Nick', 'Cage', '123@gmail.com', 'ADER7485', '050555555', 1),
		('Kate', 'Denson', '123a@gmail.com', 'CEIY9123', '05055553', 2),
		('Steve', 'Harrnigton', '12123@gmail.com', 'ASEQ0450', '050545555', 4),
		('Jane', 'Romero', '12321@gmail.com', 'OTEM7956', '0505555533', 3),
		('Quentin', 'Smith', '123sdf@gmail.com', 'INEM4597', '0505555233', 2),
		('Yui', 'Kimura', '123f32@gmail.com', 'UNEO8811', '050555558', 1),
		('Nancy', 'Wheeler', '123sdf@gmail.com', 'OINM4322', '050555255', 2),
		('Claire', 'Redfield', '123sdg@gmail.com', 'KEPM6237', '050555235', 2),
		('Leon-Scott', 'Kennedy', '123sdg@gmail.com', 'UMBR7798', '050555355', 2),
		('William', 'Overback', '12323d@gmail.com', 'DERT2374', '0505555534', 1);
		

insert into rooms (room_number, room_type, bed_count, price)
values (1, 'Single standard', 1, 149.90),
		(2, 'Single standard', 2, 152.50),
		(10, 'Multi-room luxury', 4, 349.99),
		(3, 'Multi-room standard', 3, 249.99),
		(25, 'Double standard', 1, 175),
		(26, 'Single luxury', 1, 239.99),
		(29, 'Double luxury', 1, 225),
		(30, 'Double standard', 1, 175),
		(41, 'Single standard', 2, 152.50),
		(33,'Single standard', 1, 149.90),
		(125, 'Double luxury', 1, 225),
		(324, 'Single luxury', 1, 239.99),
		(12, 'Multi-room standard', 4, 252.99);
		
insert into order_details (client_id, room_id, check_in, check_out, total_price)
values 
        (1, 1, '2023-06-23 14:00:00', '2023-06-25 10:00:00', 299.80),
        (2, 2, '2023-06-24 12:00:00', '2023-06-26 11:00:00', 305.00),
        (3, 3, '2023-06-25 15:00:00', '2023-06-29 10:00:00', 1399.96),
        (4, 4, '2023-06-26 13:00:00', '2023-06-28 12:00:00', 749.97),
        (5, 5, '2023-06-27 10:00:00', '2023-06-29 10:00:00', 350.00),
        (6, 6, '2023-06-28 16:00:00', '2023-06-29 12:00:00', 239.99),
        (7, 7, '2023-06-29 14:00:00', '2023-07-01 12:00:00', 450.00),
        (8, 8, '2023-06-30 11:00:00', '2023-07-03 10:00:00', 525.00),
        (9, 9, '2023-07-01 13:00:00', '2023-07-04 12:00:00', 675.00),
        (10, 10, '2023-07-02 10:00:00', '2023-07-03 10:00:00', 149.90);
  
insert into rating (room_id, room_rating)
values (1, 34),
        (2,15),
        (3, 128),
        (4, 150),
        (5, 25),
        (6, 185),
        (7, 456),
        (8, 4568),
        (9, 456),
        (10, 456)