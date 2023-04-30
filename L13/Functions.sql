CREATE or replace FUNCTION hospitalization_by_id_patient(id int4)
RETURNS TABLE(diagnosis varchar(255), doctor_id int)
AS 
$$
begin
	RETURN QUERY SELECT initial_diagnosis as diagnosis, doctor_id as doctor_id   
	FROM hospitalizations WHERE patient_id = id;
  if not found then
     raise notice'The id could not be found';
  end if;

end;
$$ 
LANGUAGE plpgsql;


select * from hospitalizations h;
select * from hospitalization_by_id_patient(1);



CREATE or replace FUNCTION sale(quantity int, 
list_price decimal(10,2), discount decimal(4,2)
)
RETURNS decimal(10,2)
LANGUAGE plpgsql
as
$$
begin
	RETURN quantity * list_price * (1-discount);
end
$$

select * from sale(2, 5, 0.2);
drop function  hospitalizations_by_id_patient(int4);