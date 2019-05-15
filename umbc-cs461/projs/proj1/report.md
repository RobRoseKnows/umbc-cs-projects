# UMBC CMSC 461 Project

Robert Rose

## Executive Summary

The PlantNurseryRUs database project takes several attributes of the PlantNursery
business and condenses them into a MySQL database for easing data collection and
entry in the business.

## Introduction

This document chronicles the six Phases of the Project and its design requirements.
Phase A is analysis of the requirements of the project and a high-level description
of the tasks involved. Phase B covers conceptual design (i.e. entity-relationship 
model development, identifying attributes of the entitites, identifying relations and
primary keys, listing contraints for each relation and entity) and justification
of design decisions. Phase C is logical design, which involves mapping the conceptual
design onto the relational data model. Phase D is Physical Design involving a MySQL
database developed in Phase B & C, scripts for the creation and deletion of tables,
scripts for loading data, designing the user interface and justification thereof.
Phase E is Prototype, Development and Testing involving developing Jupyter notebooks
with code to access, populate, update and administer the SQL tabels made as well as
developing user interfaces which satisfy all functional user requirements. Phase F
is developing a user guide for the application.

## Phase A - Analysis

Most of the design choices for the system seem fairly obvious from the data descriptions
and requirements. There will be a minimum of a Plant entity, a Pot entity, a Tray
entity and a Weather Station entity. These will likely map fairly straight-forwardly
to database tables. Additionally, the coordinate system used for the positions of 
things within the nursery seems to suggest a good use case for the MySQL 8 features 
like `POINT` and `SPATIAL INDEX`. This is good as it allows the database engine to 
do a lot of heavy lifting for us in the realm of retrieving things such as the
closest weather station.

The company doesn't seem to have a need for any sort of Business Intelligence or 
data science, as it's rather small, so the number and layout of tables can likely 
be rather limited. Since we don't need to store the data forever we can just delete
old data rather than archiving it to a data warehouse of some sort.

I will likely need surrogate keys for several of the entities as Pots, Trays and 
Micro-weather stations don't have convenient natural keys to use, especially
considering they can be moved. I think I'll give micro-weather stations names that
can be used by employees to refer to them in conversation (e.g. "Move Achilles to 
section 1,1") I plan to use the names of Greek mythological figures for my sample
scripts, but the final database could use any name they might want.

Another requirement which I'm confused about is that the Pots descritpion says it
records the "the average... of the measurement events maintained by the nearest 
micro-weather station at the activity’s timestamp." I'm confused as to what it's
averaging. Instead, I plan to simply have the measurement reference the most recent
measurement event of the nearest micro-weather station. Additionally, in order to 
keep the number of micro-weather measurements manageable, I plan on writing a
transaction to delete all but the last 10 measurements of a given station but also
keep the ones referenced by activity logs.

An additional requirement I plan on adding is to include barcodes for each plant,
pot, tray and weather station. This is so that the shop could eventually label
their items with barcodes to ease data entry later on.

## Phase B - Conceptual Design

### Entity-Relationship Diagram

![Entity-relationship diagram](./erd.png)

### Attributes

Primary key(s) are in **bold**. When more than one attribute is bolded, there is a
composite primary key. Derived attributes are in *itallics*.

- Plant
  - **Species**
  - **Cultivar**
  - CommonName
  - Type
  - IsPerannual
  - DaysToGerminate
  - Barcode
  - Req_Temperature
  - Req_Light
  - Req_AirMoisture
  - Req_Feeding
  - Req_Watering
- Pot
  - **ID**
  - Barcode
  - Height
  - Volume
  - Holding_Species
  - Holding_Cultivar
  - Holding_GerminationDate
  - Holding_PlantingDate
  - *Holding_Age*
  - OnTray
- Tray
  - **ID**
  - Barcode
  - Position
  - *LastAction*
- ActivityLog
  - **Timestamp**
  - **PotID**
  - Food
  - Water
  - StartingPos
  - EndingPos
  - StartingTray
  - EndingTray
  - *AmbientLight*
  - *AirMoisture*
  - *Temperature*
  - WeatherEventID
- WeatherEvent
  - **ID**
  - AmbientLight
  - AirMoisture
  - CurrentPosition
  - Temperature
  - StationID
- WeatherStation
  - **ID**
  - Position
  - Name
  - Barcode
- Barcodes
  - **Barcode**

### Constraints

- Plant
  - `Unique(Barcode)` since barcodes should be unique accross all plants
  - `ForeignKey(Barcode) -> Barcodes(Barcodes)` since barcodes should be unique accross
    all tables.
  - `Check(Type IN ('herbs', 'vegetables', 'flowers'))` because those are the only
  types of plants allowed.
  - `Check(DaysToGerminate >= 0)` since all plants should take some time to germinate
  - `Check(Req_Feeding >= 0)` since it can't require negative feeding
  - `Check(Req_Watering >= 0)` since it can't require negative watering
  - I'm unsure whether the other requirement values can be negative or positive so
    I'll leave them without check constraints.
- Pot
  - `Unique(Barcode)` since barcodes should be unique for each pot
  - `ForeignKey(Holding_Species, Holding_Cultivar) -> Plant(Species, Cultivar)` as
    they are the foreign key references that determine which plant is in the pot.
  - `ForeignKey(OnTray) -> Tray(ID)` as it is the foreign key reference that determines
    which tray a pot is on.
  - `ForeignKey(Barcode) -> Barcodes(Barcodes)` since barcodes should be unique accross
    all tables.  
  - `Check(Height IS IN (3, 4, 5, 6, 6.5, 7, 8, 12, 14))` since those are the only
    valid height values.
  - `Check(Volume IS IN (1, 2, 3, 4, 5, 7, 10, 15, 25))` since those are the only valid
    volume values.
  - `Check(Holding_PlantingDate < Holding_GerminationDate)` because the plant can't
    have germinated before it's planted.
  - `Check(Holding_PlantingDate non null when Germination Date is non null)` because 
    if the germination date is non null, the planting date must have happened, so must
    be non-null.
- Tray
  - `Unique(Barcode)` since barcodes should be unique for each tray
  - `ForeignKey(Barcode) -> Barcodes(Barcodes)` since barcodes should be unique accross
    all tables.
- ActivityLog
  - `Check(Food >= 0)` because you can't feed negative food.
  - `Check(Water >= 0)` because you can't water negative water.
  - `ForeignKey(PotID) -> Pot(ID)` the primary keys are Timestamp and PotID, but
    PotID is also a foreign key to the Pot table.
  - `ForeignKey(WeatherEventID) -> WeatherEvent(ID)` this is to preserve needed
    WeatherEvents when they are periodically culled to the last ten.
  - `ForeignKey(StartingTray) -> Trays(ID)` make sure we started on a valid tray or null.
  - `ForeignKey(EndingTray) -> Trays(ID)` make sure we ended on a valid tray or null.
  - I considered writing `Check` constraints to make sure the trays and locations corresponded,
    but decided not to as that would mean the trays couldn't ever move or the constraint
    would fail.
- WeatherEvent
  - `ForeignKey(StationID) -> WeatherStation(ID)` this is so we can delete older
    records.
- WeatherStation
  - `Unique(Name)` As I metioned earlier in Phase A, I plan to give the weather
    stations human names so that they can be referred to by staff.
  - `Unique(Barcode)` since bacodes should be unique for each weather station.
  - `ForeignKey(Barcode) -> Barcodes(Barcodes)` since barcodes should be unique accross
    all tables.
- Barcodes
  - The primary key on `Barcode` means it will be unique.

### Justification

I am presuming that all `CHECK` constraints will be used on a modern version of 
MySQL 8, which does parse and enforce `CHECK` constraints as opposed to earlier 
versions which parsed and ignored them.

Justifications for constraints can be found in line with their descriptions in
the constraints section above.

The reason I decided to design WeatherEvents stored separately instead of with
the activity log is to reduce data duplication and to leave a clear chain of record
of where the measurements came from.


## Phase C - Logical Design

In this phase of the design I will take the entities and relations I detailed in
Phase B and map them on to the relationship model. Most of that is straightforward,
though I did decide to add some enhancements from Phase B.

### Enhancements From Phase B

When creating the database tables, I chose to create a separate table for barcodes,
so that every barcode created in the flower shop will be unique, meaning they can
be scanned without duplication. In the final version instead of using the Unique
constraints on barcodes as detailed in Phase B, they will be foreign key constraints
that point to a table with only a single key: the barcode. Also renamed `Location`
column to `Position` since it looks like "location" might be a reserved word. Finally,
added starting and ending trays to the activity log as that might be a better way to 
track movements than just position.

### Mapping Entities Onto Tables

Tables:
- plants
- pots
- trays
- activity_log
- weather_event
- weather_station
- barcodes
Views:
<!-- - tray_view -->
- pots_view
- activities_view
- barcode_lookup_view

No additional tables other than the ones for each entity are necessary, as I don't
have any many-to-many relationships. I was originally planning to use a generated
column in pots to calculate the age of the plant, but that's not possible because
`NOW()` (and similar functions) can't be used in generated columns. So instead
I created pots_view, that calculates the holdings_age on query.

I do however need to create two views that allow me to get the derived values of 
last action on a tray and the weather statistics for an activity log. I chose to
design the database this way because generated columns can't use data from another
table and I wanted to minimize data duplication. I chose to hold off on creating the
tray_view until later on as the query to find the most recent timestamp will be
rather complex, it will be easier just to do it in Python code.

I also created a barcode_lookup_view that makes it easy for someone to lookup what a
barcode corresponds to. This is because the alternative is needing to join together
multiple tables in every query using the barcode.

### Column Types

Much of the data is in a text form, which means varchar columns will be common.
Barcodes will be the most common varchar column type, and I will cap them at 13
characters, because that's the length of a traditional UPC.

For all names and such, I will use `varchar(255)` as I expect most names will be
rather short, and they will likely not exceed (or even get close to) 255 characters.

For dates such as germination and planting date on the pot, I will use the `DATE` type
to store the date. For the timestamps, I will use `DATETIME` because I don't expect to
need to calculate anything across timezones, which is what `TIMESTAMP` is mostly
useful for.

### Nullability

Most of the nullability questions were fairly self explanatory, and don't require much
in the way of justification. The ones that I thought weren't straight-forward however,
I wanted to go into detail here.

For the activity_log table, I originally intended for stating position and tray to
be not null and for the ending positions to be nullable, in case an activity didn't involve
moving the pot, it would be `NULL`. I realized however that when a pot initially comes into 
service, it will have no starting position or tray. So I reveresed the nullability,
making the starting position nullable, for when a pot initially enters service, and the
ending position not null, since I can simply check if an activity didn't involve moving
the pot by SQL statements.

### Justification

I have been thinking about how I would map these to a database from the very beginning
so there's not that many changes I need to make. Most of the logical design will be
constructed during Phase D when I create scripts for creating the tables.

## Phase D - Physical Design

In this phase I created the scripts to create the tables, relations and constraints
for the MySQL database described in Section B and C. There were a few differences 
and changes that I made from the original Phase B, that I acknowledged in Phase C.

### createAll.sql

The createAll script creates the tables and views in the database, as well as adding
the relations and constraints. It does not create any indexes because that was supposed
to happen at a later stage. The entire script is visible below:

```sql
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
    ts                  DATETIME NOT NULL,
    pot_id              INT NOT NULL,
    food                FLOAT NOT NULL,
    water               FLOAT NOT NULL,
    starting_pos        POINT,
    ending_pos          POINT NOT NULL,
    starting_tray       INT,
    ending_tray         INT NOT NULL,
    weather_event_id    INT NOT NULL,
    PRIMARY KEY(ts, pot_id),
    FOREIGN KEY(pot_id) REFERENCES pots(id),
    FOREIGN KEY(weather_event_id) REFERENCES weather_event(id),
    FOREIGN KEY(starting_tray) REFERENCES trays(id),
    FOREIGN KEY(ending_tray) REFERENCES trays(id),
    CONSTRAINT check_log_food_positive_or_zero CHECK(food >= 0),
    CONSTRAINT check_log_water_positive_or_zero CHECK(water >= 0)
);

-- This view will be very messy, so I'll come back and make it only if I have time.
-- CREATE OR REPLACE VIEW tray_view AS (
--     SELECT id, barcode, position, (
--         SELECT ts FROM 
--     ) AS last_activity 
--     FROM trays
-- );

CREATE OR REPLACE VIEW pots_view AS (
    SELECT *, IF(holding_germination_date IS NOT NULL, 
    DATEDIFF(NOW(), holding_germination_date), NULL) AS holding_age
    FROM pots); 

CREATE OR REPLACE VIEW activities_view AS (
    SELECT  activity_log.ts AS ts,
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

CREATE OR REPLACE VIEW barcode_lookup_view AS (
    SELECT  barcodes.barcode AS barcode, 
            plants.species AS species, 
            plants.cultivar AS cultivar,
            trays.id AS tray_id,
            pots.id AS pots_id,
            weather_station.id AS station_id
    FROM    barcodes
        LEFT JOIN plants
            ON plants.barcode = barcodes.barcode
        LEFT JOIN trays
            ON trays.barcode = barcodes.barcode
        LEFT JOIN pots
            ON pots.barcode = barcodes.barcode
        LEFT JOIN weather_station
            ON weather_station.barcode = barcodes.barcode
);
```

We create the tables in the order that we must in order for the relations to not
have non-existent dependencies.

### dropAll.sql

The `dropAll.sql` script is much simipler than the `createAll,sql` script, as it 
only has to drop the tables in reverse order.

```sql
-- Drop the views first because they depend on a lot of stuff
DROP VIEW IF EXISTS barcode_lookup_view;

DROP VIEW IF EXISTS activities_view;

DROP VIEW IF EXISTS pots_view;

DROP VIEW IF EXISTS tray_view;

-- Drop the tables that we created in reverse order
DROP TABLE IF EXISTS activity_log;

DROP TABLE IF EXISTS weather_event;

DROP TABLE IF EXISTS weather_station;

DROP TABLE IF EXISTS pots;

DROP TABLE IF EXISTS trays;

DROP TABLE IF EXISTS plants;

DROP TABLE IF EXISTS barcodes;
```

### loadAll.sql

The `loadAll.sql` script took the longest out of everything because I was creating
data to enter mostly manually. In retrospect, I probably should have written
scripts to create the data for me, and ignored the need for things to have meaningful
data. It would have gone significantly faster.

In fact, it was taking so long that I didn't end up making entries in the activity log
for every pot, just a few entries to show what it's capable of and the three month 
spanning entries that were required by the project specification.

```sql
INSERT INTO barcodes 
    (barcode) 
VALUES
    -- Format for plant barcodes: PL{type}XXX{4:species#}{3:cultivar#}
    ('PLVXXX0001001'), -- Plants Vegetables Species 1
    ('PLVXXX0001002'),
    ('PLVXXX0002001'), -- Species 2
    ('PLVXXX0002002'),
    ('PLVXXX0003001'), -- Species 3
    ('PLVXXX0003002'),
    ('PLVXXX0004001'), -- Species 4
    ('PLVXXX0004002'),
    ('PLVXXX0005001'), -- Species 5
    ('PLVXXX0005002'),
    ('PLVXXX0006001'), -- Species 6
    ('PLVXXX0006002'),    
    ('PLHXXX0007001'), -- Plants Herbs Species 1
    ('PLHXXX0007002'),
    ('PLHXXX0008001'), -- Species 2
    ('PLHXXX0008002'),
    ('PLHXXX0009001'), -- Species 3
    ('PLHXXX0009002'),
    ('PLHXXX0010001'), -- Species 4
    ('PLHXXX0010002'),
    ('PLHXXX0011001'), -- Species 5
    ('PLHXXX0011002'),
    ('PLHXXX0012001'), -- Species 6
    ('PLHXXX0012002'),
    ('PLFXXX0013001'), -- Plants Flowers Species 1
    ('PLFXXX0013002'),
    ('PLFXXX0014001'), -- Species 2
    ('PLFXXX0014002'),
    ('PLFXXX0015001'), -- Species 3
    ('PLFXXX0015002'),
    ('PLFXXX0016001'), -- Species 4
    ('PLFXXX0016002'),
    ('PLFXXX0017001'), -- Species 5
    ('PLFXXX0017002'),
    ('PLFXXX0018001'), -- Species 6
    ('PLFXXX0018002'),
    -- Format for tray barcodes: TRXXXX{7:id#}
    ('TRXXXX0000001'),
    ('TRXXXX0000002'),
    ('TRXXXX0000003'),
    ('TRXXXX0000004'),
    ('TRXXXX0000005'),
    ('TRXXXX0000006'),
    ('TRXXXX0000007'),
    -- Format for pots barcodes: PT{2:height}{2:volume}{7:id#}
    ('PT03010000001'), -- Height 3"
    ('PT03010000002'),
    ('PT03010000003'),
    ('PT03050000004'),
    ('PT03050000005'),
    ('PT03050000006'),
    ('PT03150000007'),
    ('PT03150000008'),
    ('PT03150000009'),
    ('PT65010000010'), -- Height 6.5"
    ('PT65010000011'),
    ('PT65010000012'),
    ('PT65050000013'),
    ('PT65050000014'),
    ('PT65050000015'),
    ('PT65150000016'),
    ('PT65150000017'),
    ('PT65150000018'),
    ('PT07010000019'), -- Height 7"
    ('PT07010000020'),
    ('PT07010000021'),
    ('PT07050000022'),
    ('PT07050000023'),
    ('PT07050000024'),
    ('PT07150000025'),
    ('PT07150000026'),
    ('PT07150000027'),
    ('PT12040000028'), -- Height 12"
    ('PT12040000029'),
    ('PT12040000030'),
    ('PT12050000031'),
    ('PT12050000032'),
    ('PT12050000033'),
    ('PT12150000034'),
    ('PT12150000035'),
    ('PT12150000036'),
    ('PT12250000037'),
    ('PT12250000038'),
    ('PT12250000039'),
    -- Format for weather station barcodes: WSX{3:start of name}X{6:id#}
    ('WSXARTX000001'), -- Artemis
    ('WSXHADX000002'), -- Hades
    ('WSXACHX000003'), -- Achiles
    ('WSXGANX000004'); -- Ganymede 

INSERT INTO plants
    (
        species, cultivar, common_name, 
        plant_type, is_perannual, days_to_germinate, barcode, 
        req_temperature, req_light, req_air_moisture, req_feeding, req_watering
    )
VALUES
    -- Vegetables
    (
        'Capsicum annuum', 'green', 'Green bell pepper',
        'vegetables', FALSE, 10, 'PLVXXX0001001', 
        70.0, 6.0, 1.0, 1.0, 1.0
    ),
    (
        'Capsicum annuum', 'red', 'Red bell pepper',
        'vegetables', FALSE, 10, 'PLVXXX0001002', 
        70.0, 6.0, 1.0, 1.0, 1.0
    ),
    (
        'Allium sativum', 'red', 'Red garlic',
        'vegetables', TRUE, 20, 'PLVXXX0002001', 
        20.0, 6.0, 1.0, 1.0, 1.0
    ),
    (
        'Allium sativum', 'white', 'White garlic',
        'vegetables', TRUE, 20, 'PLVXXX0002002', 
        20.0, 6.0, 1.0, 1.0, 1.0
    ),    
    (
        'Cucurbita pepo', 'pepo', 'Pumpkin',
        'vegetables', FALSE, 50, 'PLVXXX0003001', 
        20.0, 7.0, 1.0, 1.0, 1.0
    ),
    (
        'Cucurbita pepo', 'cylindrica', 'Zucchini',
        'vegetables', FALSE, 50, 'PLVXXX0003002', 
        20.0, 7.0, 1.0, 1.0, 1.0
    ),
    (
        'Beta vulgaris', 'altissima', 'Sugar beet',
        'vegetables', FALSE, 10, 'PLVXXX0004001', 
        20.0, 6.0, 1.0, 1.0, 1.0
    ),
    (
        'Beta vulgaris', 'conditiva', 'Beetroot',
        'vegetables', FALSE, 10, 'PLVXXX0004002', 
        20.0, 6.0, 1.0, 1.0, 1.0
    ),
    (
        'Brassica oleracea', 'italica', 'Broccoli',
        'vegetables', FALSE, 20, 'PLVXXX0005001', 
        25.0, 8.3, 1.5, 1.5, 2.5
    ),
    (
        'Brassica oleracea', 'botrytis', 'Cauliflower',
        'vegetables', FALSE, 20, 'PLVXXX0005002', 
        25.0, 8.0, 2.0, 2.0, 2.0
    ),
    (
        'Brassica rapa', 'chinensis', 'Bok choy',
        'vegetables', FALSE, 30, 'PLVXXX0006001', 
        23.0, 7.0, 1.5, 2.5, 1.5
    ),
    (
        'Brassica rapa', 'rapa', 'Turnip',
        'vegetables', FALSE, 30, 'PLVXXX0006002', 
        23.0, 7.6, 2.5, 3.0, 3.0
    ),
    -- Herbs
    (
        'Trientalis latifolia', 'white', 'White starflower',
        'herbs', TRUE, 21, 'PLHXXX0007001', 
        40.0, 6.5, 0.5, 1.6, 1.0
    ),
    (
        'Trientalis latifolia', 'pink', 'Pink starflower',
        'herbs', TRUE, 21, 'PLHXXX0007002', 
        40.0, 6.5, 0.5, 1.6, 1.0
    ),
    (
        'Nepeta cataria', 'pink', 'Pink catnip',
        'herbs', TRUE, 14, 'PLHXXX0008001', 
        30.0, 7.5, 1.5, 1.5, 2.5
    ),
    (
        'Nepeta cataria', 'spotted', 'Spotted catnip',
        'herbs', TRUE, 14, 'PLHXXX0008002', 
        30.0, 7.5, 1.5, 1.5, 2.5
    ),    
    (
        'Ocimum basilicum', 'purpureum', 'Dark opal basil',
        'herbs', FALSE, 20, 'PLHXXX0009001', 
        25.0, 6.0, 1.0, 1.0, 1.0
    ),
    (
        'Ocimum basilicum', 'thyrsiflora', 'Cinnamon basil',
        'herbs', TRUE, 20, 'PLHXXX0009002', 
        25.0, 6.0, 1.0, 1.0, 1.0
    ),
    (
        'Origanum vulgare', 'gracile', 'Oregano',
        'herbs', TRUE, 10, 'PLHXXX0010001', 
        30.0, 6.0, 1.0, 1.0, 1.0
    ),
    (
        'Origanum vulgare', 'hirtum', 'Oregano',
        'herbs', TRUE, 10, 'PLHXXX0010002', 
        30.0, 6.0, 1.0, 1.0, 1.0
    ),
    (
        'Mentha × piperita', 'Candymint', 'Peppermint',
        'herbs', TRUE, 20, 'PLHXXX0011001', 
        35.0, 6.3, 4.5, 1.5, 6.0
    ),
    (
        'Mentha × piperita', 'Citrata', 'Lemon mint',
        'herbs', TRUE, 20, 'PLHXXX0011002', 
        35.0, 6.0, 4.0, 2.0, 6.0
    ),
    (
        'Rosmarinus officinalis', 'albus', 'Albus Rosemary',
        'herbs', FALSE, 30, 'PLHXXX0012001', 
        23.0, 6.0, 1.5, 2.5, 1.5
    ),
    (
        'Rosmarinus officinalis', 'irene', 'Irene Rosemary',
        'herbs', FALSE, 30, 'PLHXXX0012002', 
        23.0, 6.0, 2.5, 3.0, 3.0
    ),
    -- Flowers
    (
        'Tulipa × gesneriana', 'yonina', 'Yonina tulip',
        'flowers', TRUE, 14, 'PLFXXX0013001', 
        26.0, 6.0, 1.5, 2.5, 1.5
    ),
    (
        'Tulipa × gesneriana', 'texas flame', 'Texas flame tulip',
        'flowers', TRUE, 14, 'PLFXXX0013002', 
        26.0, 6.0, 1.5, 2.5, 1.5
    ),   
    (
        'Calendula officinalis', 'lemon', 'Lemon marigold',
        'flowers', TRUE, 14, 'PLFXXX0014001', 
        25.0, 6.2, 1.2, 2.5, 1.4
    ),
    (
        'Calendula officinalis', 'alpha', 'Alpha marigold',
        'flowers', TRUE, 14, 'PLFXXX0014002', 
        25.0, 6.2, 1.2, 2.5, 1.4
    ),
    (
        'Ismelia carinata', 'red', 'Red tricolor daisy',
        'flowers', FALSE, 21, 'PLFXXX0015001', 
        30.0, 6.1, 1.2, 2.5, 1.4
    ),
    (
        'Ismelia carinata', 'white', 'White tricolor daisy',
        'flowers', FALSE, 21, 'PLFXXX0015002', 
        30.0, 6.1, 1.2, 2.5, 1.4
    ),
    (
        'Chrysanthemum morifolium', 'yellow', "Yellow florist's daisy",
        'flowers', TRUE, 21, 'PLFXXX0016001', 
        20.0, 6.0, 1.2, 2.5, 1.3
    ),
    (
        'Chrysanthemum morifolium', 'white', "White florist's daisy",
        'flowers', TRUE, 21, 'PLFXXX0016002', 
        20.0, 6.0, 1.2, 2.5, 1.3
    ),
    (
        'Helianthus annuus', 'american giant', 'American Giant sunflower',
        'flowers', FALSE, 28, 'PLFXXX0017001', 
        20.0, 6.0, 1.5, 2.5, 2.0
    ),
    (
        'Helianthus annuus', 'titan', 'Titan sunflower',
        'flowers', FALSE, 28, 'PLFXXX0017002', 
        20.0, 6.0, 1.5, 2.5, 2.0
    ),
    (
        'Hemerocallis lilioasphodelus', 'wayside king royale', "Wauside King Royale daylily",
        'flowers', FALSE, 21, 'PLFXXX0018001', 
        20.0, 7.0, 1.1, 2.5, 1.3
    ),
    (
        'Hemerocallis lilioasphodelus', 'red magic', "Red Magic daylily",
        'flowers', FALSE, 21, 'PLFXXX0018002', 
        20.0, 7.0, 1.1, 2.5, 1.3
    );

INSERT INTO trays
    (id, barcode, position)
VALUES
    (1, 'TRXXXX0000001', POINT( 0,  0)),
    (2, 'TRXXXX0000002', POINT(-1, -1)),
    (3, 'TRXXXX0000003', POINT(-1,  1)),
    (4, 'TRXXXX0000004', POINT(-2, -1)),
    (5, 'TRXXXX0000005', POINT(-2,  1)),
    (6, 'TRXXXX0000006', POINT( 1, -1)),
    (7, 'TRXXXX0000007', POINT( 1,  1));

INSERT INTO pots
    (
        id, barcode, height, volume, on_tray,
        holding_species, holding_cultivar, holding_planting_date, holding_germination_date
    )
VALUES
    (   -- Height 3"
        01, 'PT03010000001', 03, 01, 1,
        'Calendula officinalis', 'alpha', DATE('2019-03-20'), DATE('2019-04-03') 
    ), 
    (
        02, 'PT03010000002', 03, 01, 1,
        'Calendula officinalis', 'alpha', DATE('2019-03-20'), DATE('2019-04-03') 
    ),
    (
        03, 'PT03010000003', 03, 01, 1,
        'Calendula officinalis', 'alpha', DATE('2019-03-20'), DATE('2019-04-04') 
    ),
    (
        04, 'PT03050000004', 03, 05, 1,
        'Calendula officinalis', 'lemon', DATE('2019-03-20'), DATE('2019-04-03') 
    ),
    (
        05, 'PT03050000005', 03, 05, 1,
        'Calendula officinalis', 'lemon', DATE('2019-03-20'), DATE('2019-04-03') 
    ),
    (
        06, 'PT03050000006', 03, 05, 1,
        'Calendula officinalis', 'lemon', DATE('2019-03-20'), DATE('2019-04-04') 
    ),
    (
        07, 'PT03150000007', 03, 15, 2,
        'Ismelia carinata', 'white', DATE('2019-03-20'), DATE('2019-04-10')
    ),
    (
        08, 'PT03150000008', 03, 15, 2,
        'Ismelia carinata', 'red', DATE('2019-03-20'), DATE('2019-04-10') 
    ),
    (
        09, 'PT03150000009', 03, 15, 2,
        'Ismelia carinata', 'red', DATE('2019-03-20'), DATE('2019-04-11') 
    ),
    (   -- Height 6.5"
        10, 'PT65010000010', 6.5, 01, 3,
        'Nepeta cataria', 'spotted', DATE('2019-04-06'), DATE('2019-04-20') 
    ), 
    (
        11, 'PT65010000011', 6.5, 01, 3,
        'Nepeta cataria', 'spotted', DATE('2019-04-06'), DATE('2019-04-20') 
    ),
    (
        12, 'PT65010000012', 6.5, 01, 3,
       'Nepeta cataria', 'pink', DATE('2019-04-06'), DATE('2019-04-20') 
    ),
    (
        13, 'PT65050000013', 6.5, 05, 2,
        'Ismelia carinata', 'red', DATE('2019-04-02'), DATE('2019-04-16') 
    ),
    (
        14, 'PT65050000014', 6.5, 05, 2,
        'Ismelia carinata', 'red', DATE('2019-04-02'), DATE('2019-04-16') 
    ),
    (
        15, 'PT65050000015', 6.5, 05, 2,
         'Ismelia carinata', 'red', DATE('2019-04-02'), DATE('2019-04-16') 
    ),
    (
        16, 'PT65150000016', 6.5, 15, 2,
         'Ismelia carinata', 'white', DATE('2019-04-02'), DATE('2019-04-17') 
    ),
    (
        17, 'PT65150000017', 6.5, 15, 3,
        'Nepeta cataria', 'pink', DATE('2019-04-05'), DATE('2019-04-20') 
    ),
    (
        18, 'PT65150000018', 6.5, 15, 3,
        'Nepeta cataria', 'pink', DATE('2019-04-07'), DATE('2019-04-20') 
    ),
    (   -- Height 7"
        19, 'PT07010000019', 07, 01, NULL,
        NULL, NULL, NULL, NULL
    ), 
    (
        20, 'PT07010000020', 07, 01, NULL,
        NULL, NULL, NULL, NULL  
    ),
    (
        21, 'PT07010000021', 07, 01, NULL,
        NULL, NULL, NULL, NULL
    ),
    (
        22, 'PT07050000022', 07, 05, 4,
        'Mentha × piperita', 'Candymint', DATE('2019-02-01'), DATE('2019-02-20')
    ),
    (
        23, 'PT07050000023', 07, 05, 4,
        'Mentha × piperita', 'Candymint', DATE('2019-02-01'), DATE('2019-02-20')
    ),
    (
        24, 'PT07050000024', 07, 05, 4,
        'Mentha × piperita', 'Citrata', DATE('2019-02-01'), DATE('2019-02-20') 
    ),
    (
        25, 'PT07150000025', 07, 15, 5,
        'Cucurbita pepo', 'cylindrica', DATE('2019-04-01'), NULL
    ),
    (
        26, 'PT07150000026', 07, 15, 5,
        'Cucurbita pepo', 'cylindrica', DATE('2019-04-01'), NULL
    ),
    (
        27, 'PT07150000027', 07, 15, 5,
        'Cucurbita pepo', 'cylindrica', DATE('2019-04-01'), NULL
    ),
    (   -- Height 12"
        28, 'PT12040000028', 12, 04, 7,
        'Brassica rapa', 'chinensis', DATE('2019-04-01'), DATE('2019-05-01')
    ), 
    (
        29, 'PT12040000029', 12, 04, 7,
        'Brassica rapa', 'chinensis', DATE('2019-04-01'), DATE('2019-05-01')
    ),
    (
        30, 'PT12040000030', 12, 04, 7,
        'Brassica rapa', 'chinensis', DATE('2019-04-01'), DATE('2019-05-01')
    ),
    (
        31, 'PT12050000031', 12, 05, 6,
        'Cucurbita pepo', 'pepo', DATE('2019-04-01'), NULL
    ),
    (
        32, 'PT12050000032', 12, 05, 6,
        'Cucurbita pepo', 'pepo', DATE('2019-04-01'), NULL
    ),
    (
        33, 'PT12050000033', 12, 05, 6,
        'Cucurbita pepo', 'pepo', DATE('2019-04-01'), NULL
    ),
    (
        34, 'PT12150000034', 12, 15, 7,
        'Brassica rapa', 'rapa', DATE('2019-05-01'), NULL
    ),
    (
        35, 'PT12150000035', 12, 15, 7,
        'Brassica rapa', 'rapa', DATE('2019-05-01'), NULL
    ),
    (
        36, 'PT12150000036', 12, 15, 7,
        'Brassica rapa', 'rapa', DATE('2019-05-01'), NULL
    ),
    (
        37, 'PT12250000037', 12, 25, 6,
        'Cucurbita pepo', 'pepo', DATE('2019-04-01'), NULL
    ),
    (
        38, 'PT12250000038', 12, 25, 6,
        'Cucurbita pepo', 'pepo', DATE('2019-04-01'), NULL
    ),
    (
        39, 'PT12250000039', 12, 25, 6,
        'Cucurbita pepo', 'pepo', DATE('2019-04-01'), NULL
    );

INSERT INTO weather_station
    (id, position, station_name, barcode)
VALUES
    (1, POINT(0, 0),    'Artemis',  'WSXARTX000001'),
    (2, POINT(1, 1),    'Hades',    'WSXHADX000002'),
    (3, POINT(-1, -1),  'Achiles',  'WSXACHX000003'),
    (4, POINT(-2, -2),  'Ganymede', 'WSXGANX000004');

-- The last 10 weather events for each station.
INSERT INTO weather_event
    (id, ambient_light, air_moisture, curr_pos, curr_time, temperature, station_id)
VALUES
    (01, 2.0, 2.0, POINT(0, 0), DATETIME('2019-05-01 12:00:00'), 69.0, 1),
    (02, 2.0, 2.0, POINT(0, 0), DATETIME('2019-04-30 12:00:00'), 69.0, 1),
    (03, 2.0, 2.0, POINT(0, 0), DATETIME('2019-04-29 12:00:00'), 69.0, 1),
    (04, 2.0, 2.0, POINT(0, 0), DATETIME('2019-04-28 12:00:00'), 69.0, 1),
    (05, 2.0, 2.0, POINT(0, 0), DATETIME('2019-04-27 12:00:00'), 69.0, 1),
    (06, 2.0, 2.0, POINT(0, 0), DATETIME('2019-04-26 12:00:00'), 69.0, 1),
    (07, 2.0, 2.0, POINT(0, 0), DATETIME('2019-04-25 12:00:00'), 69.0, 1),
    (08, 2.0, 2.0, POINT(0, 0), DATETIME('2019-04-24 12:00:00'), 69.0, 1),
    (09, 2.0, 2.0, POINT(0, 0), DATETIME('2019-04-23 12:00:00'), 69.0, 1),
    (10, 2.0, 2.0, POINT(0, 0), DATETIME('2019-04-22 12:00:00'), 69.0, 1),
    (11, 2.5, 2.1, POINT(1, 1), DATETIME('2019-05-01 12:00:00'), 68.5, 2),
    (12, 2.5, 2.1, POINT(1, 1), DATETIME('2019-04-30 12:00:00'), 68.5, 2),
    (13, 2.5, 2.1, POINT(1, 1), DATETIME('2019-04-29 12:00:00'), 68.5, 2),
    (14, 2.5, 2.1, POINT(1, 1), DATETIME('2019-04-28 12:00:00'), 68.5, 2),
    (15, 2.5, 2.1, POINT(1, 1), DATETIME('2019-04-27 12:00:00'), 68.5, 2),
    (16, 2.5, 2.1, POINT(1, 1), DATETIME('2019-04-26 12:00:00'), 68.5, 2),
    (17, 2.5, 2.1, POINT(1, 1), DATETIME('2019-04-25 12:00:00'), 68.5, 2),
    (18, 2.5, 2.1, POINT(1, 1), DATETIME('2019-04-24 12:00:00'), 68.5, 2),
    (19, 2.5, 2.1, POINT(1, 1), DATETIME('2019-04-23 12:00:00'), 68.5, 2),
    (20, 2.5, 2.1, POINT(1, 1), DATETIME('2019-04-22 12:00:00'), 68.5, 2),
    (21, 2.1, 2.0, POINT(-1, -1), DATETIME('2019-05-01 12:00:00'), 69.0, 3),
    (22, 2.1, 2.0, POINT(-1, -1), DATETIME('2019-04-30 12:00:00'), 69.0, 3),
    (23, 2.1, 2.0, POINT(-1, -1), DATETIME('2019-04-29 12:00:00'), 69.0, 3),
    (24, 2.1, 2.0, POINT(-1, -1), DATETIME('2019-04-28 12:00:00'), 69.0, 3),
    (25, 2.1, 2.0, POINT(-1, -1), DATETIME('2019-04-27 12:00:00'), 69.0, 3),
    (26, 2.1, 2.0, POINT(-1, -1), DATETIME('2019-04-26 12:00:00'), 69.0, 3),
    (27, 2.1, 2.0, POINT(-1, -1), DATETIME('2019-04-25 12:00:00'), 69.0, 3),
    (28, 2.1, 2.0, POINT(-1, -1), DATETIME('2019-04-24 12:00:00'), 69.0, 3),
    (29, 2.1, 2.0, POINT(-1, -1), DATETIME('2019-04-23 12:00:00'), 69.0, 3),
    (30, 2.1, 2.0, POINT(-1, -1), DATETIME('2019-04-22 12:00:00'), 69.0, 3),
    (31, 2.0, 2.1, POINT(-2, -2), DATETIME('2019-05-01 12:00:00'), 69.0, 4),
    (32, 2.0, 2.1, POINT(-2, -2), DATETIME('2019-04-30 12:00:00'), 69.0, 4),
    (33, 2.0, 2.1, POINT(-2, -2), DATETIME('2019-04-29 12:00:00'), 69.0, 4),
    (34, 2.0, 2.1, POINT(-2, -2), DATETIME('2019-04-28 12:00:00'), 69.0, 4),
    (35, 2.0, 2.1, POINT(-2, -2), DATETIME('2019-04-27 12:00:00'), 69.0, 4),
    (36, 2.0, 2.1, POINT(-2, -2), DATETIME('2019-04-26 12:00:00'), 69.0, 4),
    (37, 2.0, 2.1, POINT(-2, -2), DATETIME('2019-04-25 12:00:00'), 69.0, 4),
    (38, 2.0, 2.1, POINT(-2, -2), DATETIME('2019-04-24 12:00:00'), 69.0, 4),
    (39, 2.0, 2.1, POINT(-2, -2), DATETIME('2019-04-23 12:00:00'), 69.0, 4),
    (40, 2.0, 2.1, POINT(-2, -2), DATETIME('2019-04-22 12:00:00'), 69.0, 4);

-- The weather events for the activity log.
INSERT INTO weather_event
    (id, ambient_light, air_moisture, curr_pos, curr_time, temperature, station_id)
VALUES
    (41, 2.0, 2.0, POINT(0, 0), DATETIME('2019-03-20 12:00:00'), 66.0, 1),
    (42, 2.0, 2.0, POINT(0, 0), DATETIME('2019-03-27 12:00:00'), 67.0, 1),
    (43, 2.0, 2.0, POINT(0, 0), DATETIME('2019-04-04 12:00:00'), 68.0, 1),
    (44, 2.1, 2.0, POINT(0, 0), DATETIME('2019-04-11 12:00:00'), 68.5, 1),
    (45, 2.0, 2.0, POINT(0, 0), DATETIME('2019-04-18 12:00:00'), 69.0, 1);


INSERT INTO activity_log
    (
        ts, pot_id, food, water, weather_event_id,
        starting_pos, ending_pos, starting_tray, ending_tray
    )
VALUES
    (
        DATETIME('2019-03-20 12:29:00'), 01, 7.0, 7.0, 41,
        NULL,           POINT( 0,  0),  NULL,   1
    ),
    (
        DATETIME('2019-03-20 12:31:00'), 02, 7.0, 7.0, 41,
        NULL,           POINT( 0,  0),  NULL,   1
    ),
    (
        DATETIME('2019-03-20 12:33:00'), 03, 7.0, 7.0, 41,
        NULL,           POINT( 0,  0),  NULL,   1
    ),
    (
        DATETIME('2019-03-20 12:37:00'), 04, 7.0, 7.0, 41,
        NULL,           POINT( 0,  0),  NULL,   1
    ),
    (
        DATETIME('2019-03-20 12:40:00'), 05, 7.0, 7.0, 41,
        NULL,           POINT( 0,  0),  NULL,   1
    ),
    (
        DATETIME('2019-03-20 12:45:00'), 06, 7.0, 7.0, 41,
        NULL,           POINT( 0,  0),  NULL,   1
    ),
    (
        DATETIME('2019-03-27 12:31:00'), 01, 7.0, 7.0, 42,
        POINT( 0,  0),  POINT( 0,  0),  1,      1
    ),
    (
        DATETIME('2019-03-27 12:32:00'), 02, 7.0, 7.0, 42,
        POINT( 0,  0),  POINT( 0,  0),  1,      1
    ),
    (
        DATETIME('2019-03-27 12:33:00'), 03, 7.0, 7.0, 42,
        POINT( 0,  0),  POINT( 0,  0),  1,      1
    ),
    (
        DATETIME('2019-03-27 12:37:00'), 04, 7.0, 7.0, 42,
        POINT( 0,  0),  POINT( 0,  0),  1,      1
    ),
    (
        DATETIME('2019-03-27 12:40:00'), 05, 7.0, 7.0, 42,
        POINT( 0,  0),  POINT( 0,  0),  1,      1
    ),
    (
        DATETIME('2019-03-27 12:45:00'), 06, 7.0, 7.0, 42,
        POINT( 0,  0),  POINT( 0,  0),  1,      1
    ),
    (
        DATETIME('2019-04-04 12:31:00'), 01, 7.0, 7.0, 43,
        POINT( 0,  0),  POINT( 0,  0),  1,      1
    ),
    (
        DATETIME('2019-04-04 12:32:00'), 02, 7.0, 7.0, 43,
        POINT( 0,  0),  POINT( 0,  0),  1,      1
    ),
    (
        DATETIME('2019-04-04 12:33:00'), 03, 7.0, 7.0, 43,
        POINT( 0,  0),  POINT( 0,  0),  1,      1
    ),
    (
        DATETIME('2019-04-04 12:37:00'), 04, 7.0, 7.0, 43,
        POINT( 0,  0),  POINT( 0,  0),  1,      1
    ),
    (
        DATETIME('2019-04-04 12:40:00'), 05, 7.0, 7.0, 43,
        POINT( 0,  0),  POINT( 0,  0),  1,      1
    ),
    (
        DATETIME('2019-04-04 12:45:00'), 06, 7.0, 7.0, 43,
        POINT( 0,  0),  POINT( 0,  0),  1,      1
    ),
    (
        DATETIME('2019-04-11 12:31:00'), 01, 7.0, 7.0, 44,
        POINT( 0,  0),  POINT( 0,  0),  1,      1
    ),
    (
        DATETIME('2019-04-11 12:32:00'), 02, 7.0, 7.0, 44,
        POINT( 0,  0),  POINT( 0,  0),  1,      1
    ),
    (
        DATETIME('2019-04-11 12:33:00'), 03, 7.0, 7.0, 44,
        POINT( 0,  0),  POINT( 0,  0),  1,      1
    ),
    (
        DATETIME('2019-04-11 12:37:00'), 04, 7.0, 7.0, 44,
        POINT( 0,  0),  POINT( 0,  0),  1,      1
    ),
    (
        DATETIME('2019-04-11 12:40:00'), 05, 7.0, 7.0, 44,
        POINT( 0,  0),  POINT( 0,  0),  1,      1
    ),
    (
        DATETIME('2019-04-11 12:45:00'), 06, 7.0, 7.0, 44,
        POINT( 0,  0),  POINT( 0,  0),  1,      1
    ),
    (
        DATETIME('2019-04-18 12:31:00'), 01, 7.0, 7.0, 45,
        POINT( 0,  0),  POINT( 0,  0),  1,      1
    ),
    (
        DATETIME('2019-04-18 12:32:00'), 02, 7.0, 7.0, 45,
        POINT( 0,  0),  POINT( 0,  0),  1,      1
    ),
    (
        DATETIME('2019-04-18 12:33:00'), 03, 7.0, 7.0, 45,
        POINT( 0,  0),  POINT( 0,  0),  1,      1
    ),
    (
        DATETIME('2019-04-18 12:37:00'), 04, 7.0, 7.0, 45,
        POINT( 0,  0),  POINT( 0,  0),  1,      1
    ),
    (
        DATETIME('2019-04-18 12:40:00'), 05, 7.0, 7.0, 45,
        POINT( 0,  0),  POINT( 0,  0),  1,      1
    ),
    (
        DATETIME('2019-04-18 12:45:00'), 06, 7.0, 7.0, 45,
        POINT( 0,  0),  POINT( 0,  0),  1,      1
    ),
    (
        DATETIME('2019-04-22 12:31:00'), 01, 7.0, 7.0, 10,
        POINT( 0,  0),  POINT( 0,  0),  1,      1
    ),
    (
        DATETIME('2019-04-22 12:32:00'), 02, 7.0, 7.0, 10,
        POINT( 0,  0),  POINT( 0,  0),  1,      1
    ),
    (
        DATETIME('2019-04-22 12:33:00'), 03, 7.0, 7.0, 10,
        POINT( 0,  0),  POINT( 0,  0),  1,      1
    ),
    (
        DATETIME('2019-04-22 12:37:00'), 04, 7.0, 7.0, 10,
        POINT( 0,  0),  POINT( 0,  0),  1,      1
    ),
    (
        DATETIME('2019-04-22 12:40:00'), 05, 7.0, 7.0, 10,
        POINT( 0,  0),  POINT( 0,  0),  1,      1
    ),
    (
        DATETIME('2019-04-22 12:45:00'), 06, 7.0, 7.0, 10,
        POINT( 0,  0),  POINT( 0,  0),  1,      1
    ),
    (
        DATETIME('2019-04-23 12:31:00'), 01, 7.0, 7.0, 19,
        POINT( 0,  0),  POINT( 1,  1),  1,      7
    ),
    (
        DATETIME('2019-04-23 12:32:00'), 02, 7.0, 7.0, 19,
        POINT( 0,  0),  POINT( 1,  1),  1,      7
    ),
    (
        DATETIME('2019-04-23 12:33:00'), 03, 7.0, 7.0, 19,
        POINT( 0,  0),  POINT( 1,  1),  1,      7
    ),
    (
        DATETIME('2019-04-23 12:37:00'), 04, 7.0, 7.0, 19,
        POINT( 0,  0),  POINT( 1,  1),  1,      7
    ),
    (
        DATETIME('2019-04-23 12:40:00'), 05, 7.0, 7.0, 19,
        POINT( 0,  0),  POINT( 1,  1),  1,      7
    ),
    (
        DATETIME('2019-04-23 12:45:00'), 06, 7.0, 7.0, 19,
        POINT( 0,  0),  POINT( 1,  1),  1,      7
    ),
    (
        DATETIME('2019-04-24 12:31:00'), 01, 7.0, 7.0, 08,
        POINT( 1,  1),  POINT( 0,  0),  7,      1
    ),
    (
        DATETIME('2019-04-24 12:32:00'), 02, 7.0, 7.0, 08,
        POINT( 1,  1),  POINT( 0,  0),  7,      1
    ),
    (
        DATETIME('2019-04-24 12:33:00'), 03, 7.0, 7.0, 08,
        POINT( 1,  1),  POINT( 0,  0),  7,      1
    ),
    (
        DATETIME('2019-04-24 12:37:00'), 04, 7.0, 7.0, 08,
        POINT( 1,  1),  POINT( 0,  0),  7,      1
    ),
    (
        DATETIME('2019-04-24 12:40:00'), 05, 7.0, 7.0, 08,
        POINT( 1,  1),  POINT( 0,  0),  7,      1
    ),
    (
        DATETIME('2019-04-24 12:45:00'), 06, 7.0, 7.0, 08,
        POINT( 1,  1),  POINT( 0,  0),  7,      1
    );
```