-- CMSC 461, Spring 2019
-- Robert Rose
-- robrose2

--- Drop the views first because they depend on a lot of stuff
DROP VIEW IF EXISTS barcode_lookup_view;

DROP VIEW IF EXISTS activities_view;

DROP VIEW IF EXISTS pots_view;

DROP VIEW IF EXISTS tray_view;

--- Drop the tables that we created in reverse order
DROP TABLE IF EXISTS activity_log;

DROP TABLE IF EXISTS weather_event;

DROP TABLE IF EXISTS weather_station;

DROP TABLE IF EXISTS pots;

DROP TABLE IF EXISTS trays;

DROP TABLE IF EXISTS plants;

DROP TABLE IF EXISTS barcodes;