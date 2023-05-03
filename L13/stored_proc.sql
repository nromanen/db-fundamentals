--Procedure for add new doctor with if
create or replace procedure add_new_doctor
(
p_first_name varchar,
p_last_name varchar,
p_specialization varchar = NULL,
p_phone_number varchar = NULL,
p_department_id int4 = null
)
as
$$
declare
begin
	if p_first_name is null then
		raise exception 'first_name must have a value';
	end if;

	if p_last_name is null then
		raise exception 'last_name must have a value';
	end if;
	
	insert into doctors(first_name, last_name, specialization, phone_number, department_id)
	values (p_first_name, p_last_name, p_specialization, p_phone_number, p_department_id);
end;
$$ language plpgsql;

call add_new_doctor('f_name', 'l_name', 'default' , '+7556987', 3);
drop procedure add_new_doctor(int4, varchar, varchar, varchar, varchar, int4);

select * from doctors d;
select * from departments d2;

INSERT INTO doctors(first_name, last_name, specialization, phone_number, department_id)
VALUES ('Dr. Andry', 'Smith', 'Diagnostic Medicine', '+7556987', 8);

INSERT INTO departments(department_name, department_head_id)
VALUES ('new department', '1');

delete from doctors where doctor_id=7;
delete from departments where department_id=8;
-------------------------------------

INSERT INTO patients(first_name, last_name, birth_date, phone_number, email)
VALUES ('Alice', 'Teylor', '1995-06-10', '+78936901', 'alice.teylor@mail.ua');

INSERT INTO hospitalizations(initial_diagnosis, start_date, end_date, doctor_id, patient_id, placement_id)
VALUES ('Some initial diagnosis', '2023-01-10', null, 1, 1, 1);

select now() from 

create or replace procedure add_new_patient
(
--for patients table
p_first_name varchar(50),
p_last_name varchar(50),
p_birth_date varchar(50),
p_phone_number varchar(15),
p_email varchar(255),

--for hospitalizations table
initial_diagnosis varchar(255),
start_date date default now(),
end_date date 
doctor_id int4,
patient_id int4,
placement_id int4

--employee_id smallint,
--freight numeric,
--ship_via int default 1,
--ship_name varchar default 'Rancho grande',
--ship_address varchar default 'Av. del Libertador 900',
--ship_city varchar default 'Buenos Aires',
--ship_region varchar default null,
--ship_postal_code varchar default 1010,
--ship_country varchar default 'Argentina'
)
as
$$
declare
new_id int;
begin
	
	
	
	insert into orders
values (id, customer_id, employee_id, now(), 
now() + INTERVAL '30 days', now() + INTERVAL '30 days',
ship_via, freight, ship_name, ship_address,
ship_city, ship_region, ship_postal_code, ship_country);


exception
WHEN unique_violation 
then new_id = next_order_id();
insert into orders
values (new_id, customer_id, employee_id, now(), now() + INTERVAL '30 days', 
now() + INTERVAL '30 days',
ship_via, freight, ship_name, ship_address,
ship_city, ship_region, ship_postal_code, ship_country);
end;
$$ language plpgsql;








































