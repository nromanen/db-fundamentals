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

-------------------------------------
--Procedure add new patient
create or replace procedure add_new_patient
(
--for patients table
p_first_name varchar(50),
p_last_name varchar(50),
p_birth_date date,
p_phone_number varchar(15),
p_email varchar(255),

--for hospitalizations table
p_initial_diagnosis varchar(255),
p_end_date date,
p_doctor_id int4,
p_patient_id int4,
p_placement_id int4,
p_start_date date default now()

)
as
$$
declare
new_id int;
begin
	
	INSERT INTO patients(first_name, last_name, birth_date, phone_number, email)
	values (p_first_name, p_last_name, 
	p_birth_date, p_phone_number, p_email);

	INSERT INTO hospitalizations(initial_diagnosis, start_date, end_date, doctor_id, patient_id, placement_id)
	values(p_initial_diagnosis, p_start_date, p_end_date, 
	p_doctor_id, p_patient_id, p_placement_id);

end;
$$ language plpgsql;

call add_new_patient('Test', 'lastName', '1990-01-01', '+7855699', 'Test.lastName@mail.ua',
'new initial diagnosis', null, 1, 1, 1, '2023-11-11');








