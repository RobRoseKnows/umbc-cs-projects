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
- tray_view
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
table and I wanted to minimize data duplication. 

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
