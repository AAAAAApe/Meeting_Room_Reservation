create table if not exists sequence (
    year integer not null,
    role varchar(10) not null,
    current_value int not null,
    primary key (year, role)
);

create table if not exists user (
    user_id char(9) not null,
    encrypted_password varchar(60) not null,
    role varchar(10) not null,
    primary key (user_id)
);