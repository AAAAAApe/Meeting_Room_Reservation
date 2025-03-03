create table if not exists sequence (
    year char(4) not null,
    role varchar(10) not null,
    current_value int not null,
    primary key (year, role)
);

create table if not exists user (
    userId char(9) not null,
    hashedPassword varchar(60) not null,
    role varchar(10) not null,
    primary key (userId)
);