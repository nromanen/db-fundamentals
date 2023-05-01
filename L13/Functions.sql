--return initial_diagnosis and doctor_id from hospitalizations table by patient_id.
--If ID is incorect return message in output.
CREATE or replace FUNCTION hospitalization_by_id_patient(id int4)
RETURNS TABLE(_diagnosis varchar(255), _doctor_id_ int)
AS 
$$
begin
	RETURN QUERY SELECT initial_diagnosis, doctor_id
	FROM hospitalizations WHERE patient_id = id;
  if not found then
     raise notice'The id could not be found';
  end if;
end;
$$ 
LANGUAGE plpgsql;
------------------------
--return all fields from patients table by patient_id.
CREATE or replace FUNCTION patients_by_id(id int4)
RETURNS SETOF patients
AS 
$$
begin
	RETURN QUERY
SELECT * FROM patients WHERE patient_id = id;
end
$$
LANGUAGE PLPGSQL;

------------------------------
--return all fields from patients table by patient_id.
CREATE or replace FUNCTION doctors_by_id(id int4)
RETURNS SETOF doctors
AS 
$$
begin
	RETURN QUERY
SELECT * FROM doctors WHERE doctor_id = id;
end
$$
LANGUAGE PLPGSQL;
select * from doctors d 
------------------------------