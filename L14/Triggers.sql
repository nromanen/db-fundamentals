create table patients_logs (
change_id serial PRIMARY KEY,
patient_id int not null,
first_name varchar(50) not null,
last_name varchar(50) not null,
birth_date  date,
phone_number  varchar(15),
email varchar(255), 
update_at timestamp with time zone  not null,
operation char(10) not null,
check(operation ='insert' or operation = 'update')
);

create or replace function patients_update ()
	returns trigger 
	language plpgsql
as 
$$
begin 
		insert into patients_logs(patient_id, first_name, last_name,
		birth_date, phone_number, email, update_at, operation)
		select new.patient_id,
		new.first_name,
		new.last_name,
		new.birth_date,
		new.phone_number,
		new.email,
		now(),
		case 
			when TG_OP = 'INSERT' then 'insert'
			when TG_OP = 'UPDATE' then 'update'
		end;
		return null;		
end;
$$
--------------------------------------
create or replace trigger trg_patients_audit
after insert or update
on patients
for each row 
execute function patients_update ();
--------------------------------------

