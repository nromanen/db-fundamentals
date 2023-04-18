CREATE TABLE departments  (
   department_id serial primary key,
   department_name  varchar(50) not null,
   department_head_id  integer
);

CREATE TABLE doctors  (
   doctor_id  serial PRIMARY KEY,
   first_name  varchar(50) not null,
   last_name  varchar(50) not null,
   specialization  varchar(255) not null,
   phone_number  varchar(15),
   department_id  integer
);

CREATE TABLE examinations  (
   examination_id  serial PRIMARY KEY,
   symptoms_description  text not null,
   diagnosis  varchar(255) not null,
   diagnosis_date  date not null,
   doctor_id  integer,
   hospitalization_id  integer
);

CREATE TABLE hospitalizations  (
   hospitalization_id  serial PRIMARY KEY,
   initial_diagnosis  varchar(255) not null,
   start_date  date not null,
   end_date  date not null,
   doctor_id  integer,
   patient_id  integer,
   placement_id  integer
);

CREATE TABLE placements  (
   placement_id  serial PRIMARY KEY,
   room_number  integer not null,
   unit  varchar(15) not null,
   floor  integer
);

CREATE TABLE patients  (
   patient_id  serial PRIMARY KEY,
   first_name  varchar(50) not null,
   last_name  varchar(50) not null,
   birt_date  date,
   phone_number  varchar(15),
   email  varchar(255) unique
);

ALTER TABLE departments ADD FOREIGN KEY (department_head_id) REFERENCES doctors (doctor_id);

ALTER TABLE doctors ADD FOREIGN KEY (department_id) REFERENCES departments (department_id);

ALTER TABLE examinations ADD FOREIGN KEY (doctor_id) REFERENCES doctors (doctor_id);

ALTER TABLE examinations ADD FOREIGN KEY (hospitalization_id) REFERENCES hospitalizations (hospitalization_id);

ALTER TABLE hospitalizations ADD FOREIGN KEY (doctor_id) REFERENCES doctors (doctor_id);

ALTER TABLE hospitalizations ADD FOREIGN KEY (patient_id) REFERENCES patients (patient_id);

ALTER TABLE hospitalizations ADD FOREIGN KEY (placement_id) REFERENCES placements (placement_id);


--DROP TABLE IF EXISTS departments;
--DROP TABLE IF EXISTS doctors;
--DROP TABLE IF EXISTS examinations;
--DROP TABLE IF EXISTS hospitalizations;
--DROP TABLE IF EXISTS placements;
--DROP TABLE IF EXISTS patients;
