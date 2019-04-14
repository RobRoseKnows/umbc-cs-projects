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
  - UPC
  - Req_Temperature
  - Req_Light
  - Req_AirMoisture
  - Req_Feeding
  - Req_Watering
- Pot
  - **ID**
  - UPC
  - Height
  - Volume
  - Holding_Species
  - Holding_Cultivar
  - Holding_Germination_Date
  - Holding_Planting_Date
  - *Holding_Age*
  - OnTray
- Tray
  - **ID**
  - UPC
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

### Constraints



### Justification
