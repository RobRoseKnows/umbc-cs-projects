create table customer
    (
        `email`     varchar(255) not null,
        `name`      varchar(32) not null,
        `gender`    varchar(1) not null,
        `city`      varchar(16),
        `state`     varchar(2),
        primary key(`email`)
    )

create table dealer
    (
        `website`   varchar(255) not null,
        `name`      varchar(32) not null,
        `city`      varchar(32),
        `state`     varchar(2),
        primary key(`website`)
    )

create table vehicle
    (
        `vin`           varchar(17) not null,
        `make`          varchar(16) not null,
        `model`         varchar(16) not null,
        `year`          numeric(4,0) not null, check (`year` > 1900),
        `bought_from`   varchar(255) not null,
        `sold_to`       varchar(255),
        primary key(`vin`),
        foreign key(`bought_from`) references dealer(`website`),
        foreign key(`sold_to`) references customer(`email`)
        foreign key(`make`, `model`, `year`) references car(`make`, `model`, `year`)
    )

create table car
    (
        `make`      varchar(16) not null,
        `model`     varchar(16) not null,
        `year`      numeric(4,0) not null, check (`year` > 1900),
        primary key(`make`, `model`, `year`)
    )

create table car_option
    (
        `make`      varchar(16) not null,
        `model`     varchar(16) not null,
        `year`      numeric(4,0) not null, check (`year` > 1900),
        `option`    varchar(16) not null,
        primary key(`make`, `model`, `year`, `option`),
        foreign key(`make`, `model`, `year`) references car(`make`, `model`, `year`)
    )

create table has_options
    (
        `make`      varchar(16) not null,
        `model`     varchar(16) not null,
        `year`      numeric(4,0) not null, check (`year` > 1900),
        `option`    varchar(16) not null,
        `vin`       varchar(17) not null,
        primary key(`make`, `model`, `year`, `option`, `vin`),
        foreign key(`make`, `model`, `year`) references car(`make`, `model`, `year`),
        foreign key(`vin`) references vehicle(`vin`)
    )
