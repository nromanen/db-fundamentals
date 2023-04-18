INSERT INTO patients(first_name, last_name, birth_date, phone_number, email)
VALUES ('Richard', 'Brenson', '1964-02-01', '+78165168', 'rich@mail.ua');
INSERT INTO patients(first_name, last_name, birth_date, phone_number, email)
VALUES ('Alex', 'Tornu', '1986-05-26', '+78236985', 'alex.tornu@mail.ua');
INSERT INTO patients(first_name, last_name, birth_date, phone_number, email)
VALUES ('Roman', 'Furda', '1991-11-04', '+78598746', 'roman.furda@mail.ua');
INSERT INTO patients(first_name, last_name, birth_date, phone_number, email)
VALUES ('Alice', 'Teylor', '1995-06-10', '+78936901', 'alice.teylor@mail.ua');
INSERT INTO patients(first_name, last_name, birth_date, phone_number, email)
VALUES ('Taras', 'Bobryk', '1989-07-11', '+78569832', 'taras.bobryk@mail.ua'),
('Ostap', 'Yarysh', '1992-08-12', '+78369874', 'ostap.yarysh@mail.ua'),
('Oleg', 'Fisun', '1993-09-12', '+78315354', 'oleg.fisun@mail.ua'),
('Ivan', 'Kucab', '1985-10-15', '+78951236', 'ivan.kucab@mail.ua');


INSERT INTO placements(room_number, unit, floor)
VALUES ('101', 'A', '1');
INSERT INTO placements(room_number, unit, floor)
VALUES ('102', 'A', '1');
INSERT INTO placements(room_number, unit, floor)
VALUES ('103', 'A', '1');
INSERT INTO placements(room_number, unit, floor)
VALUES ('201', 'A', '2');
INSERT INTO placements(room_number, unit, floor)
VALUES ('202', 'A', '2');
INSERT INTO placements(room_number, unit, floor)
VALUES ('203', 'A', '2');
INSERT INTO placements(room_number, unit, floor)
VALUES ('101', 'B', '1');
INSERT INTO placements(room_number, unit, floor)
VALUES ('102', 'B', '1');
INSERT INTO placements(room_number, unit, floor)
VALUES ('201', 'B', '2');
INSERT INTO placements(room_number, unit, floor)
VALUES ('202', 'B', '2');


INSERT INTO doctors(first_name, last_name, specialization, phone_number, department_id)
VALUES ('Dr. Gregory', 'House', 'Diagnostic Medicine', '+7512396', null);
INSERT INTO doctors(first_name, last_name, specialization, phone_number, department_id)
VALUES ('Lisa', 'Cuddy', 'Dean of Medicine, endocrinologist', '+7556987', null);
INSERT INTO doctors(first_name, last_name, specialization, phone_number, department_id)
VALUES ('James', 'Wilson', 'Diagnostic Medicine', '+7512396', null);
INSERT INTO doctors(first_name, last_name, specialization, phone_number, department_id)
VALUES ('Eric', 'Foreman', 'Diagnostic Medicine, neurologist', '+7532658', null);
INSERT INTO doctors(first_name, last_name, specialization, phone_number, department_id)
VALUES ('Allison', 'Cameron', 'Emergency Medicine, immunologist', '+7578965', null);
INSERT INTO doctors(first_name, last_name, specialization, phone_number, department_id)
VALUES ('Robert','Chase', 'Surgeon, intensive care specialist', '+7532149', null);

UPDATE doctors
SET department_id = 7
WHERE doctor_id=6

INSERT INTO departments(department_name, department_head_id)
VALUES ('Neurology', '1');
INSERT INTO departments(department_name, department_head_id)
VALUES ('Anaesthetics', '2');
INSERT INTO departments(department_name, department_head_id)
VALUES ('Cardiology', '3');
INSERT INTO departments(department_name, department_head_id)
VALUES ('Diagnostic imaging', '4');
INSERT INTO departments(department_name, department_head_id)
VALUES ('Gastroenterology', '5');


INSERT INTO hospitalizations(initial_diagnosis, start_date, end_date, doctor_id, patient_id, placement_id)
VALUES ('Some initial diagnosis', '2023-01-10', null, 1, 1, 1);
INSERT INTO hospitalizations(initial_diagnosis, start_date, end_date, doctor_id, patient_id, placement_id)
VALUES ('Some initial diagnosis 1', '2022-11-09', null, 1, 2, 1);
INSERT INTO hospitalizations(initial_diagnosis, start_date, end_date, doctor_id, patient_id, placement_id)
VALUES ('Some initial diagnosis 2', '2022-12-13', '2023-01-26', 2, 3, 2);
INSERT INTO hospitalizations(initial_diagnosis, start_date, end_date, doctor_id, patient_id, placement_id)
VALUES ('Some initial diagnosis 3', '2023-02-02', null, 2, 4, 2);
INSERT INTO hospitalizations(initial_diagnosis, start_date, end_date, doctor_id, patient_id, placement_id)
VALUES ('Some initial diagnosis 4', '2022-11-04', null, 3, 5, 3),
('Some initial diagnosis 4', '2022-11-04', null, 4, 6, 3),
('Some initial diagnosis 4', '2022-11-04', null, 5, 7, 4),
('Some initial diagnosis 4', '2022-11-04', null, 1, 8, 4);


INSERT INTO examinations(symptoms_description, diagnosis, diagnosis_date, doctor_id, hospitalization_id)
VALUES ('Abdominal pain in adults', null, '2023-01-12', 1, 1);
INSERT INTO examinations(symptoms_description, diagnosis, diagnosis_date, doctor_id, hospitalization_id)
VALUES ('Cough in adults', null, '2022-11-20', 2, 2);
