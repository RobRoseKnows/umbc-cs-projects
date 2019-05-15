-- CMSC 461, Spring 2019
-- Robert Rose
-- robrose2

-- 1. List the unique common names of all the vegetables currently planted
SELECT DISTINCT plants.common_name 
FROM pots JOIN plants ON (pots.holding_species, pots.holding_cultivar) = (plants.species, plants.cultivar) 
WHERE plants.plant_type = 'vegetables';

-- 2. List the species name and number of varieties for each plant species for all the plants
SELECT species, COUNT(cultivar) AS num_varieties FROM plants
GROUP BY species;

-- 3. Find the total number of pots currently holding a plant with a given common name.
SELECT COUNT(pots.id) AS TOTAL
FROM pots JOIN plants ON (pots.holding_species, pots.holding_cultivar) = (plants.species, plants.cultivar) 
WHERE plants.common_name = 'Pumpkin'; -- Change name here!!!
-- For this file, here's a query that gets all the counts for all the common names.
SELECT plants.common_name AS common_name, COUNT(pots.id) AS TOTAL
FROM pots JOIN plants ON (pots.holding_species, pots.holding_cultivar) = (plants.species, plants.cultivar) 
GROUP BY plants.common_name

-- 4. Find the histogram (value and count) of volumes of pots with germinated plants 
-- with a given common name.
SELECT pots.volume AS volume, COUNT(pots.id) AS NUM
FROM pots JOIN plants ON (pots.holding_species, pots.holding_cultivar) = (plants.species, plants.cultivar) 
WHERE plants.common_name = 'Pumpkin' -- Change name here!!!
GROUP BY pots.volume;

-- 5. Find the most populous species among the pots with germinated plants. 
SELECT pots.holding_species, COUNT(pots.id) AS NUM
FROM pots
WHERE pots.holding_germination_date IS NOT NULL
GROUP BY pots.holding_species
ORDER BY NUM DESC
LIMIT 1;

-- 6. Find the oldest (in terms of current age) vegetable plant(s) among those 
-- that germinated during the previous month.
SELECT 
    pots_view.id, 
    pots_view.holding_species, 
    pots_view.holding_cultivar, 
    pots_view.holding_age
FROM pots_view
WHERE pots_view.holding_age IS NOT NULL AND pots_view.holding_age <= 31
ORDER BY pots_view.holding_age DESC
LIMIT 1;

-- 7. Find the germinated plant(s) that received the most daily water (averaged 
-- over their age). 


-- 8. Find the number of planted herbs that received more food than the average 
-- amount of food received by the germinated vegetables.


-- 9. Find the germinated flowers that received more daily ambient light in a 
-- given month than the previous month.