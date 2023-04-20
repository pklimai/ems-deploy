-- psql -h 192.168.65.52 -p 5000 -U postgres -d event_db

-- drop table bmn_event;
-- drop table software_;
-- drop table file_;
-- drop table storage_;


create table if not exists software_
(
    software_id smallserial primary key,
    software_version varchar (20) not null unique
);

create table if not exists storage_
(
    storage_id smallserial primary key,
    storage_name varchar (20) not null unique
);

create table if not exists file_
(
    file_guid serial primary key,
    storage_id smallint not null references storage_(storage_id) on update cascade,
    file_path varchar(255) not null
);

create table if not exists event
(
    file_guid int not null references file_(file_guid) on update cascade,
    event_number int not null check (event_number >= 0),
    primary key (file_guid, event_number),

    software_id smallint not null references software_(software_id) on update cascade,
    period_number smallint not null check (period_number >= 0),
    run_number int not null check (run_number >= 0),

    track_number int not null default (-1)
);
