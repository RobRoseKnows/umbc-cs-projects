-- CMSC 461, Spring 2019
-- Robert Rose
-- robrose2

CREATE TABLE plants (
    species             VARCHAR(255) NOT NULL,
    cultivar            VARCHAR(255) NOT NULL,
    common_name         VARCHAR(255) NOT NULL,
    is_perannual        BOOLEAN NOT NULL,
    days_to_germinate   INT NOT NULL,
    barcode             VARCHAR(13),
    req_temperature     DECIMAL(4,1) NOT NULL,
    req_light           FLOAT NOT NULL,
    req_air_moisture    FLOAT NOT NULL,
    req_feeding         FLOAT NOT NULL,
    req_watering        FLOAT NOT NULL,
    PRIMARY KEY(species, cultivar)
);

CREATE TABLE pots (
    id                  INT AUTO_INCREMENT,
    barcode             VARCHAR(13),
    height              DECIMAL(2,0) NOT NULL,
    volume              DECIMAL(3,1) NOT NULL,
    species             VARCHAR(255) NOT NULL,
    cultivar            VARCHAR(255) NOT NULL,
    germination_date    DATE,
    planting_date       DATE,
    age                 INT GENERATED ALWAYS AS (
        IF germination_date IS NOT NULL THEN DATEDIFF(NOW(), germination_date)
            ELSE NULL
        END IF
    ) VIRTUAL,
    on_tray             INT,
    PRIMARY KEY(id)
);

CREATE TABLE trays (
    id                  INT AUTO_INCREMENT,
    barcode             VARCHAR(13),
    position            POINT NOT NULL,
    PRIMARY KEY(id)
);

CREATE TABLE activity_log (
    time_stamp          DATETIME NOT NULL,
    pot_id              INT NOT NULL,
    food                FLOAT NOT NULL,
    water               FLOAT NOT NULL,
    starting_pos        POINT NOT NULL,
    ending_pos          POINT, -- Ending Position Will be NULL if there's no movement.
    starting_tray       INT NOT NULL,
    ending_tray         INT, -- Ending Tray will be NULL if there's no movement.
    weather_event_id    INT NOT NULL,
    PRIMARY KEY(time_stamp, pot_id)
);

CREATE TABLE weather_event (
    id                  INT AUTO_INCREMENT,
    ambient_light       FLOAT NOT NULL,
    air_moisture        FLOAT NOT NULL,
    current_pos         POINT NOT NULL,
    temperature         DECIMAL(4,1) NOT NULL,
    station_id          INT NOT NULL,
    PRIMARY KEY(id)
);

CREATE TABLE weather_station (
    id                  INT AUTO_INCREMENT,
    position            POINT NOT NULL,
    station_name        VARCHAR(32) NOT NULL,
    barcode             VARCHAR(13),
    PRIMARY KEY(id)
);

CREATE TABLE barcodes (
    barcode             VARCHAR(13),
    PRIMARY KEY(barcode)
);

CREATE VIEW tray_view AS SELECT * FROM trays;

CREATE VIEW activities AS SELECT * FROM activity_log;
