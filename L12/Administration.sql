--enter bu admin
psql -U postgres -d hospital

--create roles and users
create role manager;
create role doctor;
create user Ostapenko_manager with password '123';
create user House_doc with password '123';

--grant for roles
GRANT SELECT ON ALL TABLES IN SCHEMA public TO manager;
GRANT INSERT ON ALL TABLES IN SCHEMA public TO manager;
GRANT UPDATE ON ALL TABLES IN SCHEMA public TO manager;
GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA public TO manager;
GRANT SELECT ON patients TO doctor;
GRANT SELECT ON hospitalizations TO doctor;
GRANT SELECT ON examinations TO doctor;

--grant roles to users
GRANT manager TO Ostapenko_manager;
GRANT doctor TO House_doc;