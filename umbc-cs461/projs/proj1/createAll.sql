-- CMSC 461, Spring 2019
-- Robert Rose
-- robrose2

CREATE TABLE IF NOT EXISTS barcodes (
    barcode             VARCHAR(13),
    PRIMARY KEY(barcode)
);

CREATE TABLE IF NOT EXISTS plants (
    species             VARCHAR(255) NOT NULL,
    cultivar            VARCHAR(255) NOT NULL,
    common_name         VARCHAR(255) NOT NULL,
    plant_type          VARCHAR(10) NOT NULL,
    is_perannual        BOOLEAN NOT NULL,
    days_to_germinate   INT NOT NULL,
    barcode             VARCHAR(13) NOT NULL,
    req_temperature     DECIMAL(4,1) NOT NULL,
    req_light           FLOAT NOT NULL,
    req_air_moisture    FLOAT NOT NULL,
    req_feeding         FLOAT NOT NULL,
    req_watering        FLOAT NOT NULL,
    PRIMARY KEY(species, cultivar),
    UNIQUE(barcode),
    FOREIGN KEY(barcode) REFERENCES barcodes(barcode),
    CONSTRAINT check_days_to_germinate_non_negative CHECK(days_to_germinate >= 0),
    CONSTRAINT check_plants_req_feeding_non_negative CHECK(req_feeding >= 0),
    CONSTRAINT check_plants_req_watering_non_nevative CHECK(req_watering >= 0),
    CONSTRAINT check_plants_valid_type CHECK(plant_type IN ('herbs', 'vegetables', 'flowers'))
);

CREATE TABLE IF NOT EXISTS trays (
    id                  INT AUTO_INCREMENT,
    barcode             VARCHAR(13) NOT NULL,
    position            POINT NOT NULL,
    PRIMARY KEY(id),
    UNIQUE(barcode),
    FOREIGN KEY(barcode) REFERENCES barcodes(barcode)
);

CREATE TABLE IF NOT EXISTS pots (
    id                          INT AUTO_INCREMENT,
    barcode                     VARCHAR(13) NOT NULL,
    height                      DECIMAL(3,1) NOT NULL,
    volume                      DECIMAL(3,1) NOT NULL,
    holding_species             VARCHAR(255),
    holding_cultivar            VARCHAR(255),
    holding_germination_date    DATE,
    holding_planting_date       DATE,
    on_tray                     INT, -- Can be null when a pot initially enters service.
    PRIMARY KEY(id),
    UNIQUE(barcode),
    FOREIGN KEY(holding_species, holding_cultivar) REFERENCES plants(species, cultivar),
    FOREIGN KEY(on_tray) REFERENCES trays(id),
    FOREIGN KEY(barcode) REFERENCES barcodes(barcode),
    CONSTRAINT check_height_is_valid CHECK(height IN (3, 4, 5, 6, 6.5, 7, 8, 12, 14)),
    CONSTRAINT check_volume_is_valid CHECK(volume IN (1, 2, 3, 4, 5, 7, 10, 15, 25)),
    CONSTRAINT check_planting_before_germination CHECK(
        holding_planting_date IS NULL OR 
        holding_germination_date IS NULL OR 
        (holding_planting_date <= holding_germination_date)),
    CONSTRAINT check_planting_non_null_when_germination_non_null CHECK(
        IF(holding_germination_date IS NOT NULL, holding_planting_date IS NULL, 1=1)
    )
);

CREATE TABLE IF NOT EXISTS weather_station (
    id                  INT AUTO_INCREMENT,
    position            POINT NOT NULL,
    station_name        VARCHAR(32) NOT NULL,
    barcode             VARCHAR(13) NOT NULL,
    PRIMARY KEY(id),
    UNIQUE(station_name),
    UNIQUE(barcode),
    FOREIGN KEY(barcode) REFERENCES barcodes(barcode)
);

CREATE TABLE IF NOT EXISTS weather_event (
    id                  INT AUTO_INCREMENT,
    ambient_light       FLOAT NOT NULL,
    air_moisture        FLOAT NOT NULL,
    curr_pos            POINT NOT NULL,
    curr_time           DATETIME NOT NULL,
    temperature         DECIMAL(4,1) NOT NULL,
    station_id          INT NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY(station_id) REFERENCES weather_station(id)
);

CREATE TABLE IF NOT EXISTS activity_log (
    time_stamp          DATETIME NOT NULL,
    pot_id              INT NOT NULL,
    food                FLOAT NOT NULL,
    water               FLOAT NOT NULL,
    starting_pos        POINT,
    ending_pos          POINT NOT NULL,
    starting_tray       INT,
    ending_tray         INT NOT NULL,
    weather_event_id    INT NOT NULL,
    PRIMARY KEY(time_stamp, pot_id),
    FOREIGN KEY(pot_id) REFERENCES pots(id),
    FOREIGN KEY(weather_event_id) REFERENCES weather_event(id),
    FOREIGN KEY(starting_tray) REFERENCES trays(id),
    FOREIGN KEY(ending_tray) REFERENCES trays(id),
    CONSTRAINT check_log_food_positive_or_zero CHECK(food >= 0),
    CONSTRAINT check_log_water_positive_or_zero CHECK(water >= 0)
);

-- This view will be very messy, so I'll come back and make it only if I have time.
-- CREATE VIEW IF NOT EXISTS tray_view AS (
--     SELECT id, barcode, position, (
--         SELECT time_stamp FROM 
--     ) AS last_activity 
--     FROM trays
-- );

CREATE VIEW IF NOT EXISTS pots_view AS (
    SELECT *, IF(holding_germination_date IS NOT NULL, 
    DATEDIFF(NOW(), holding_germination_date), NULL) AS holding_age
    FROM pots); 

CREATE VIEW IF NOT EXISTS activities_view AS (
    SELECT  activity_log.time_stamp AS time_stamp,
            activity_log.pot_id AS pot_id,
            activity_log.food AS food,
            activity_log.water AS water,
            activity_log.starting_pos AS starting_pos,
            activity_log.ending_pos AS ending_pos,
            activity_log.starting_tray AS starting_tray,
            activity_log.ending_tray AS ending_tray,
            weather_event.ambient_light AS ambient_light,
            weather_event.air_moisture AS air_moisture,
            weather_event.temperature AS temperature
    FROM activity_log
        JOIN weather_event
            ON activity_log.weather_event_id = weather_event.id
);

CREATE VIEW IF NOT EXISTS barcode_lookup_view AS (
    SELECT  barcodes.barcode AS barcode, 
            plants.species AS species, 
            plants.cultivar AS cultivar,
            trays.id AS tray_id,
            pots.id AS pots_id,
            weather_station.id AS station_id
    FROM    barcodes
        JOIN plants
            ON plants.barcode = barcodes.barcode
        JOIN trays
            ON trays.barcode = barcodes.barcode
        JOIN pots
            ON pots.barcode = barcodes.barcode
        JOIN weather_station
            ON weather_station.barcode = barcodes.barcode
);