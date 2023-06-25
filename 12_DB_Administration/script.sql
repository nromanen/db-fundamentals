create role hotel_manager

create role hotel_staff

grant manager to ivan

grant hotel staff to petro

create trigger updata_clients_data
after insert or update or delete
on clients
for each row
execute function updata_clients_data_f()