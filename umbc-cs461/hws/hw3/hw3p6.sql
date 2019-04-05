create table book
    (
        `ISBN`          varchar(13) not null,
        `title`         varchar(32) not null,
        `year`          numeric(4,0) not null,
        `price`         decimal(3,2) not null, check(`price` > 0),
        `written_by`    varchar(32) not null,
        `published_by`  varchar(32) not null,
        primary key(`ISBN`),
        foreign key(`written_by`) references author(`name`),
        foreign key(`published_by`) references publihser(`name`)
    )

create table blu_ray_disc
    (
        `name`      varchar(32) not null,
        `price`     decimal(3,2) not null, check(`price` > 0),
        primary key(`name`)
    )

create table video
    (
        `name`      varchar(32) not null,
        `price`     decimal(3,2) not null, check(`price` > 0),
        primary key(`name`)
    )

create table author
    (
        `name`      varchar(32) not null,
        `address`   varchar(32),
        `URL`       varchar(255),
        primary key(`name`)
    )

create table publisher
    (
        `name`      varchar(32) not null,
        `address`   varchar(32),
        `phone`     varchar(10),
        `URL`       varchar(255),
        primary key(`name`)
    )

create table warehouse
    (
        `code`      varchar(3) not null,
        `address`   varchar(32),
        `phone`     varchar(10),
        primary key(`code`)
    )

create table shopping_basket
    (
        `basket_id` varchar(8) not null,
        `basket_of` varchar(255) not null,
        primary key(`basket_id`),
        foreign key(`basket_of`) references customer(`email`)
    )

create table customer
    (
        `email`     varchar(255) not null,
        `name`      varchar(32) not null,
        `address`   varchar(32),
        `phone`     varchar(10),
        primary key(`email`)
    )

create table contains_book
    (
        `ISBN`      varchar(13) not null,
        `basket_id` varchar(8) not null,
        `number`    numeric(2,0) not null, check(`number` > 0),
        primary key(`ISBN`, `basket_id`),
        foreign key(`ISBN`) references book(`ISBN`)
        foreign key(`basket_id`) references shopping_basket(`basket_id`)
    )

create table contains_disc
    (
        `name`      varchar(32) not null,
        `basket_id` varchar(8) not null,
        `number`    numeric(2,0) not null, check(`number` > 0),
        primary key(`name`, `basket_id`),
        foreign key(`name`) references blu_ray_disc(`name`)
        foreign key(`basket_id`) references shopping_basket(`basket_id`)
    )

create table contains_video
    (
        `name`      varchar(32) not null,
        `basket_id` varchar(8) not null,
        `number`    numeric(2,0) not null, check(`number` > 0),
        primary key(`name`, `basket_id`),
        foreign key(`name`) references video(`name`)
        foreign key(`basket_id`) references shopping_basket(`basket_id`)
    )

create table stocks_book
    (
        `ISBN`      varchar(13) not null,
        `code`      varchar(3) not null,
        `number`    numeric(2,0) not null, check(`number` >= 0),
        primary key(`ISBN`, `code`),
        foreign key(`ISBN`) references book(`ISBN`)
        foreign key(`code`) references warehouse(`code`)
    )

create table stocks_disc
    (
        `name`      varchar(32) not null,
        `code`      varchar(3) not null,
        `number`    numeric(2,0) not null, check(`number` >= 0),
        primary key(`name`, `code`),
        foreign key(`name`) references blu_ray_disc(`name`)
        foreign key(`code`) references warehouse(`code`)
    )

