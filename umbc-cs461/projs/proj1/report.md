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
  - Location
  - *LastAction*
- ActivityLog
  - **Timestamp**
  - **PotID**
  - Food
  - Water
  - StartingLoc
  - EndingLoc
  - *AmbientLight*
  - *AirMoisture*
  - *Temperature*
  - WeatherEventID
- WeatherEvent
  - **ID**
  - AmbientLight
  - AirMoisture
  - CurrentLocation
  - Temperature
  - StationID
- WeatherStation
  - **ID**
  - Location
  - Name
  - Barcode

### Constraints

- Plant
  - `Unique(Barcode)` since barcodes should be unique for each plant
  - `Check(DaysToGerminate > 0)` since all plants should take some time to germinate
  - `Check(Req_Feeding >= 0)` since it can't require negative feeding
  - `Check(Req_Watering >= 0)` since it can't require negative watering
  - I'm unsure whether the other requirement values can be negative or positive so
    I'll leave them without check constraints.
- Pot
  - `Unique(Barcode)` since barcodes should be unique for each pot
  - `Check(Height IS IN (3, 4, 5, 6, 6.5, 7, 8, 12, 14))` since those are the only
    valid height values.
  - `Check(Volume IS IN (1, 2, 3, 4, 5, 7, 10, 15, 25))` since those are the only valid
    volume values.
  - `Check(Holding_PlantingDate < Holding_GerminationDate)` because the plant can't
    have germinated before it's planted.
  - `ForeignKey(Holding_Species, Holding_Cultivar) -> Plant(Species, Cultivar)` as
    they are the foreign key references that determine which plant is in the pot.
  - `ForeignKey(OnTray) -> Tray(ID)` as it is the foreign key reference that determines
    which tray a pot is on.
- Tray
  - `Unique(Barcode)` since barcodes should be unique for each tray
- ActivityLog
  - `Check(Food >= 0)` because you can't feed negative food.
  - `Check(Water >= 0)` because you can't water negative water.
  - `ForeignKey(PotID) -> Pot(ID)` the primary keys are Timestamp and PotID, but
    PotID is also a foreign key to the Pot table.
  - `ForeignKey(WeatherEventID) -> WeatherEvent(ID)` this is to preserve needed
    WeatherEvents when they are periodically culled to the last ten.
- WeatherEvent
  - `ForeignKey(StationID) -> WeatherStation(ID)` this is so we can delete older
    records.
- WeatherStation
  - `Unique(Name)` As I metioned earlier in Phase A, I plan to give the weather
    stations human names so that they can be referred to by staff.
  - `Unique(Barcode)` since bacodes should be unique for each weather station.
  - `Unique(Location)` There shouldn't be a need for more than one weather station 
    at the same location so I feel we can also put a Unique constraint on this point.

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
that point to a table with only a single key: the barcode.

### Mapping Entities Onto Tables

