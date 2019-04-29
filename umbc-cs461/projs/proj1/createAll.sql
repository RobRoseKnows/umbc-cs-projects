-- CMSC 461, Spring 2019
-- Robert Rose
-- robrose2

CREATE TABLE plants (
    species             varchar(255) not null,
    cultivar            varchar(255) not null,
    common_name         varchar(255) not null,
    is_perannual        boolean not null,
    days_to_germinate   integer not null,
    barcode             varchar(13),
    req_temperature     decimal(4,1) not null,
    req_light           float not null,
    req_air_moisture    float not null,
    req_feeding         float not null,
    req_watering        float not null
);

CREATE TABLE pots (

);

CREATE TABLE trays (

);

CREATE TABLE activity_log (

);

CREATE TABLE weather_event (

);

CREATE TABLE weather_station (

);

CREATE TABLE barcodes (

);

CREATE VIEW tray_view AS SELECT * FROM trays;

CREATE VIEW activities AS SELECT * FROM activity_log;
