--Procedure for add new doctor with if
create or replace procedure add_new_doctor
(
p_first_name varchar,
p_last_name varchar,
p_specialization varchar default 'no specialization',
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

call add_new_doctor('f_name', 'l_name', default , '+7556987', 3);
drop procedure add_new_doctor(int4, varchar, varchar, varchar, varchar, int4);

select * from doctors d;
select * from departments d2;

INSERT INTO doctors(first_name, last_name, specialization, phone_number, department_id)
VALUES ('Dr. Andry', 'Smith', 'Diagnostic Medicine', '+7556987', 8);

INSERT INTO departments(department_name, department_head_id)
VALUES ('new department', '1');

delete from doctors where doctor_id=11;
delete from departments where department_id=8;