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