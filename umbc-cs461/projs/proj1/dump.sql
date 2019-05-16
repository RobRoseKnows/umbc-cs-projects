-- MySQL dump 10.13  Distrib 8.0.15, for Linux (x86_64)
--
-- Host: localhost    Database: project
-- ------------------------------------------------------
-- Server version	8.0.15

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
 SET NAMES utf8 ;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Temporary view structure for view `activities_view`
--

DROP TABLE IF EXISTS `activities_view`;
/*!50001 DROP VIEW IF EXISTS `activities_view`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8mb4;
/*!50001 CREATE VIEW `activities_view` AS SELECT 
 1 AS `ts`,
 1 AS `pot_id`,
 1 AS `food`,
 1 AS `water`,
 1 AS `starting_pos`,
 1 AS `ending_pos`,
 1 AS `starting_tray`,
 1 AS `ending_tray`,
 1 AS `ambient_light`,
 1 AS `air_moisture`,
 1 AS `temperature`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `activity_log`
--

DROP TABLE IF EXISTS `activity_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `activity_log` (
  `ts` datetime NOT NULL,
  `pot_id` int(11) NOT NULL,
  `food` float NOT NULL,
  `water` float NOT NULL,
  `starting_pos` point DEFAULT NULL,
  `ending_pos` point NOT NULL,
  `starting_tray` int(11) DEFAULT NULL,
  `ending_tray` int(11) NOT NULL,
  `weather_event_id` int(11) NOT NULL,
  PRIMARY KEY (`ts`,`pot_id`),
  KEY `pot_id` (`pot_id`),
  KEY `weather_event_id` (`weather_event_id`),
  KEY `starting_tray` (`starting_tray`),
  KEY `ending_tray` (`ending_tray`),
  CONSTRAINT `activity_log_ibfk_1` FOREIGN KEY (`pot_id`) REFERENCES `pots` (`id`),
  CONSTRAINT `activity_log_ibfk_2` FOREIGN KEY (`weather_event_id`) REFERENCES `weather_event` (`id`),
  CONSTRAINT `activity_log_ibfk_3` FOREIGN KEY (`starting_tray`) REFERENCES `trays` (`id`),
  CONSTRAINT `activity_log_ibfk_4` FOREIGN KEY (`ending_tray`) REFERENCES `trays` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `activity_log`
--

LOCK TABLES `activity_log` WRITE;
/*!40000 ALTER TABLE `activity_log` DISABLE KEYS */;
INSERT INTO `activity_log` VALUES ('2019-03-20 12:29:00',1,7,7,NULL,_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',NULL,1,41),('2019-03-20 12:31:00',2,7,7,NULL,_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',NULL,1,41),('2019-03-20 12:33:00',3,7,7,NULL,_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',NULL,1,41),('2019-03-20 12:37:00',4,7,7,NULL,_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',NULL,1,41),('2019-03-20 12:40:00',5,7,7,NULL,_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',NULL,1,41),('2019-03-20 12:45:00',6,7,7,NULL,_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',NULL,1,41),('2019-03-27 12:31:00',1,7,7,_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',1,1,42),('2019-03-27 12:32:00',2,7,7,_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',1,1,42),('2019-03-27 12:33:00',3,7,7,_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',1,1,42),('2019-03-27 12:37:00',4,7,7,_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',1,1,42),('2019-03-27 12:40:00',5,7,7,_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',1,1,42),('2019-03-27 12:45:00',6,7,7,_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',1,1,42),('2019-04-04 12:31:00',1,7,7,_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',1,1,43),('2019-04-04 12:32:00',2,7,7,_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',1,1,43),('2019-04-04 12:33:00',3,7,7,_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',1,1,43),('2019-04-04 12:37:00',4,7,7,_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',1,1,43),('2019-04-04 12:40:00',5,7,7,_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',1,1,43),('2019-04-04 12:45:00',6,7,7,_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',1,1,43),('2019-04-11 12:31:00',1,7,7,_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',1,1,44),('2019-04-11 12:32:00',2,7,7,_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',1,1,44),('2019-04-11 12:33:00',3,7,7,_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',1,1,44),('2019-04-11 12:37:00',4,7,7,_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',1,1,44),('2019-04-11 12:40:00',5,7,7,_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',1,1,44),('2019-04-11 12:45:00',6,7,7,_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',1,1,44),('2019-04-18 12:31:00',1,7,7,_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',1,1,45),('2019-04-18 12:32:00',2,7,7,_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',1,1,45),('2019-04-18 12:33:00',3,7,7,_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',1,1,45),('2019-04-18 12:37:00',4,7,7,_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',1,1,45),('2019-04-18 12:40:00',5,7,7,_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',1,1,45),('2019-04-18 12:45:00',6,7,7,_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',1,1,45),('2019-04-22 12:31:00',1,7,7,_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',1,1,10),('2019-04-22 12:32:00',2,7,7,_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',1,1,10),('2019-04-22 12:33:00',3,7,7,_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',1,1,10),('2019-04-22 12:37:00',4,7,7,_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',1,1,10),('2019-04-22 12:40:00',5,7,7,_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',1,1,10),('2019-04-22 12:45:00',6,7,7,_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',1,1,10),('2019-04-23 12:31:00',1,7,7,_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0ð?\0\0\0\0\0\0ð?',1,7,19),('2019-04-23 12:32:00',2,7,7,_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0ð?\0\0\0\0\0\0ð?',1,7,19),('2019-04-23 12:33:00',3,7,7,_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0ð?\0\0\0\0\0\0ð?',1,7,19),('2019-04-23 12:37:00',4,7,7,_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0ð?\0\0\0\0\0\0ð?',1,7,19),('2019-04-23 12:40:00',5,7,7,_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0ð?\0\0\0\0\0\0ð?',1,7,19),('2019-04-23 12:45:00',6,7,7,_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0ð?\0\0\0\0\0\0ð?',1,7,19),('2019-04-24 12:31:00',1,7,7,_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0ð?\0\0\0\0\0\0ð?',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',7,1,8),('2019-04-24 12:32:00',2,7,7,_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0ð?\0\0\0\0\0\0ð?',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',7,1,8),('2019-04-24 12:33:00',3,7,7,_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0ð?\0\0\0\0\0\0ð?',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',7,1,8),('2019-04-24 12:37:00',4,7,7,_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0ð?\0\0\0\0\0\0ð?',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',7,1,8),('2019-04-24 12:40:00',5,7,7,_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0ð?\0\0\0\0\0\0ð?',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',7,1,8),('2019-04-24 12:45:00',6,7,7,_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0ð?\0\0\0\0\0\0ð?',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',7,1,8);
/*!40000 ALTER TABLE `activity_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `barcode_lookup_view`
--

DROP TABLE IF EXISTS `barcode_lookup_view`;
/*!50001 DROP VIEW IF EXISTS `barcode_lookup_view`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8mb4;
/*!50001 CREATE VIEW `barcode_lookup_view` AS SELECT 
 1 AS `barcode`,
 1 AS `species`,
 1 AS `cultivar`,
 1 AS `tray_id`,
 1 AS `pots_id`,
 1 AS `station_id`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `barcodes`
--

DROP TABLE IF EXISTS `barcodes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `barcodes` (
  `barcode` varchar(13) NOT NULL,
  PRIMARY KEY (`barcode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `barcodes`
--

LOCK TABLES `barcodes` WRITE;
/*!40000 ALTER TABLE `barcodes` DISABLE KEYS */;
INSERT INTO `barcodes` VALUES ('PLFXXX0013001'),('PLFXXX0013002'),('PLFXXX0014001'),('PLFXXX0014002'),('PLFXXX0015001'),('PLFXXX0015002'),('PLFXXX0016001'),('PLFXXX0016002'),('PLFXXX0017001'),('PLFXXX0017002'),('PLFXXX0018001'),('PLFXXX0018002'),('PLHXXX0007001'),('PLHXXX0007002'),('PLHXXX0008001'),('PLHXXX0008002'),('PLHXXX0009001'),('PLHXXX0009002'),('PLHXXX0010001'),('PLHXXX0010002'),('PLHXXX0011001'),('PLHXXX0011002'),('PLHXXX0012001'),('PLHXXX0012002'),('PLVXXX0001001'),('PLVXXX0001002'),('PLVXXX0002001'),('PLVXXX0002002'),('PLVXXX0003001'),('PLVXXX0003002'),('PLVXXX0004001'),('PLVXXX0004002'),('PLVXXX0005001'),('PLVXXX0005002'),('PLVXXX0006001'),('PLVXXX0006002'),('PT03010000001'),('PT03010000002'),('PT03010000003'),('PT03050000004'),('PT03050000005'),('PT03050000006'),('PT03150000007'),('PT03150000008'),('PT03150000009'),('PT07010000019'),('PT07010000020'),('PT07010000021'),('PT07050000022'),('PT07050000023'),('PT07050000024'),('PT07150000025'),('PT07150000026'),('PT07150000027'),('PT12040000028'),('PT12040000029'),('PT12040000030'),('PT12050000031'),('PT12050000032'),('PT12050000033'),('PT12150000034'),('PT12150000035'),('PT12150000036'),('PT12250000037'),('PT12250000038'),('PT12250000039'),('PT65010000010'),('PT65010000011'),('PT65010000012'),('PT65050000013'),('PT65050000014'),('PT65050000015'),('PT65150000016'),('PT65150000017'),('PT65150000018'),('TRXXXX0000001'),('TRXXXX0000002'),('TRXXXX0000003'),('TRXXXX0000004'),('TRXXXX0000005'),('TRXXXX0000006'),('TRXXXX0000007'),('WSXACHX000003'),('WSXARTX000001'),('WSXGANX000004'),('WSXHADX000002');
/*!40000 ALTER TABLE `barcodes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `plants`
--

DROP TABLE IF EXISTS `plants`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `plants` (
  `species` varchar(255) NOT NULL,
  `cultivar` varchar(255) NOT NULL,
  `common_name` varchar(255) NOT NULL,
  `plant_type` varchar(10) NOT NULL,
  `is_perannual` tinyint(1) NOT NULL,
  `days_to_germinate` int(11) NOT NULL,
  `barcode` varchar(13) NOT NULL,
  `req_temperature` decimal(4,1) NOT NULL,
  `req_light` float NOT NULL,
  `req_air_moisture` float NOT NULL,
  `req_feeding` float NOT NULL,
  `req_watering` float NOT NULL,
  PRIMARY KEY (`species`,`cultivar`),
  UNIQUE KEY `barcode` (`barcode`),
  CONSTRAINT `plants_ibfk_1` FOREIGN KEY (`barcode`) REFERENCES `barcodes` (`barcode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `plants`
--

LOCK TABLES `plants` WRITE;
/*!40000 ALTER TABLE `plants` DISABLE KEYS */;
INSERT INTO `plants` VALUES ('Allium sativum','red','Red garlic','vegetables',1,20,'PLVXXX0002001',20.0,6,1,1,1),('Allium sativum','white','White garlic','vegetables',1,20,'PLVXXX0002002',20.0,6,1,1,1),('Beta vulgaris','altissima','Sugar beet','vegetables',0,10,'PLVXXX0004001',20.0,6,1,1,1),('Beta vulgaris','conditiva','Beetroot','vegetables',0,10,'PLVXXX0004002',20.0,6,1,1,1),('Brassica oleracea','botrytis','Cauliflower','vegetables',0,20,'PLVXXX0005002',25.0,8,2,2,2),('Brassica oleracea','italica','Broccoli','vegetables',0,20,'PLVXXX0005001',25.0,8.3,1.5,1.5,2.5),('Brassica rapa','chinensis','Bok choy','vegetables',0,30,'PLVXXX0006001',23.0,7,1.5,2.5,1.5),('Brassica rapa','rapa','Turnip','vegetables',0,30,'PLVXXX0006002',23.0,7.6,2.5,3,3),('Calendula officinalis','alpha','Alpha marigold','flowers',1,14,'PLFXXX0014002',25.0,6.2,1.2,2.5,1.4),('Calendula officinalis','lemon','Lemon marigold','flowers',1,14,'PLFXXX0014001',25.0,6.2,1.2,2.5,1.4),('Capsicum annuum','green','Green bell pepper','vegetables',0,10,'PLVXXX0001001',70.0,6,1,1,1),('Capsicum annuum','red','Red bell pepper','vegetables',0,10,'PLVXXX0001002',70.0,6,1,1,1),('Chrysanthemum morifolium','white','White florist\'s daisy','flowers',1,21,'PLFXXX0016002',20.0,6,1.2,2.5,1.3),('Chrysanthemum morifolium','yellow','Yellow florist\'s daisy','flowers',1,21,'PLFXXX0016001',20.0,6,1.2,2.5,1.3),('Cucurbita pepo','cylindrica','Zucchini','vegetables',0,50,'PLVXXX0003002',20.0,7,1,1,1),('Cucurbita pepo','pepo','Pumpkin','vegetables',0,50,'PLVXXX0003001',20.0,7,1,1,1),('Helianthus annuus','american giant','American Giant sunflower','flowers',0,28,'PLFXXX0017001',20.0,6,1.5,2.5,2),('Helianthus annuus','titan','Titan sunflower','flowers',0,28,'PLFXXX0017002',20.0,6,1.5,2.5,2),('Hemerocallis lilioasphodelus','red magic','Red Magic daylily','flowers',0,21,'PLFXXX0018002',20.0,7,1.1,2.5,1.3),('Hemerocallis lilioasphodelus','wayside king royale','Wauside King Royale daylily','flowers',0,21,'PLFXXX0018001',20.0,7,1.1,2.5,1.3),('Ismelia carinata','red','Red tricolor daisy','flowers',0,21,'PLFXXX0015001',30.0,6.1,1.2,2.5,1.4),('Ismelia carinata','white','White tricolor daisy','flowers',0,21,'PLFXXX0015002',30.0,6.1,1.2,2.5,1.4),('Mentha Ã— piperita','Candymint','Peppermint','herbs',1,20,'PLHXXX0011001',35.0,6.3,4.5,1.5,6),('Mentha Ã— piperita','Citrata','Lemon mint','herbs',1,20,'PLHXXX0011002',35.0,6,4,2,6),('Nepeta cataria','pink','Pink catnip','herbs',1,14,'PLHXXX0008001',30.0,7.5,1.5,1.5,2.5),('Nepeta cataria','spotted','Spotted catnip','herbs',1,14,'PLHXXX0008002',30.0,7.5,1.5,1.5,2.5),('Ocimum basilicum','purpureum','Dark opal basil','herbs',0,20,'PLHXXX0009001',25.0,6,1,1,1),('Ocimum basilicum','thyrsiflora','Cinnamon basil','herbs',1,20,'PLHXXX0009002',25.0,6,1,1,1),('Origanum vulgare','gracile','Oregano','herbs',1,10,'PLHXXX0010001',30.0,6,1,1,1),('Origanum vulgare','hirtum','Oregano','herbs',1,10,'PLHXXX0010002',30.0,6,1,1,1),('Rosmarinus officinalis','albus','Albus Rosemary','herbs',0,30,'PLHXXX0012001',23.0,6,1.5,2.5,1.5),('Rosmarinus officinalis','irene','Irene Rosemary','herbs',0,30,'PLHXXX0012002',23.0,6,2.5,3,3),('Trientalis latifolia','pink','Pink starflower','herbs',1,21,'PLHXXX0007002',40.0,6.5,0.5,1.6,1),('Trientalis latifolia','white','White starflower','herbs',1,21,'PLHXXX0007001',40.0,6.5,0.5,1.6,1),('Tulipa Ã— gesneriana','texas flame','Texas flame tulip','flowers',1,14,'PLFXXX0013002',26.0,6,1.5,2.5,1.5),('Tulipa Ã— gesneriana','yonina','Yonina tulip','flowers',1,14,'PLFXXX0013001',26.0,6,1.5,2.5,1.5);
/*!40000 ALTER TABLE `plants` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pots`
--

DROP TABLE IF EXISTS `pots`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `pots` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `barcode` varchar(13) NOT NULL,
  `height` decimal(3,1) NOT NULL,
  `volume` decimal(3,1) NOT NULL,
  `holding_species` varchar(255) DEFAULT NULL,
  `holding_cultivar` varchar(255) DEFAULT NULL,
  `holding_germination_date` date DEFAULT NULL,
  `holding_planting_date` date DEFAULT NULL,
  `on_tray` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `barcode` (`barcode`),
  KEY `holding_species` (`holding_species`,`holding_cultivar`),
  KEY `on_tray` (`on_tray`),
  CONSTRAINT `pots_ibfk_1` FOREIGN KEY (`holding_species`, `holding_cultivar`) REFERENCES `plants` (`species`, `cultivar`),
  CONSTRAINT `pots_ibfk_2` FOREIGN KEY (`on_tray`) REFERENCES `trays` (`id`),
  CONSTRAINT `pots_ibfk_3` FOREIGN KEY (`barcode`) REFERENCES `barcodes` (`barcode`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pots`
--

LOCK TABLES `pots` WRITE;
/*!40000 ALTER TABLE `pots` DISABLE KEYS */;
INSERT INTO `pots` VALUES (1,'PT03010000001',3.0,1.0,'Calendula officinalis','alpha','2019-04-03','2019-03-20',1),(2,'PT03010000002',3.0,1.0,'Calendula officinalis','alpha','2019-04-03','2019-03-20',1),(3,'PT03010000003',3.0,1.0,'Calendula officinalis','alpha','2019-04-04','2019-03-20',1),(4,'PT03050000004',3.0,5.0,'Calendula officinalis','lemon','2019-04-03','2019-03-20',1),(5,'PT03050000005',3.0,5.0,'Calendula officinalis','lemon','2019-04-03','2019-03-20',1),(6,'PT03050000006',3.0,5.0,'Calendula officinalis','lemon','2019-04-04','2019-03-20',1),(7,'PT03150000007',3.0,15.0,'Ismelia carinata','white','2019-04-10','2019-03-20',2),(8,'PT03150000008',3.0,15.0,'Ismelia carinata','red','2019-04-10','2019-03-20',2),(9,'PT03150000009',3.0,15.0,'Ismelia carinata','red','2019-04-11','2019-03-20',2),(10,'PT65010000010',6.5,1.0,'Nepeta cataria','spotted','2019-04-20','2019-04-06',3),(11,'PT65010000011',6.5,1.0,'Nepeta cataria','spotted','2019-04-20','2019-04-06',3),(12,'PT65010000012',6.5,1.0,'Nepeta cataria','pink','2019-04-20','2019-04-06',3),(13,'PT65050000013',6.5,5.0,'Ismelia carinata','red','2019-04-16','2019-04-02',2),(14,'PT65050000014',6.5,5.0,'Ismelia carinata','red','2019-04-16','2019-04-02',2),(15,'PT65050000015',6.5,5.0,'Ismelia carinata','red','2019-04-16','2019-04-02',2),(16,'PT65150000016',6.5,15.0,'Ismelia carinata','white','2019-04-17','2019-04-02',2),(17,'PT65150000017',6.5,15.0,'Nepeta cataria','pink','2019-04-20','2019-04-05',3),(18,'PT65150000018',6.5,15.0,'Nepeta cataria','pink','2019-04-20','2019-04-07',3),(19,'PT07010000019',7.0,1.0,NULL,NULL,NULL,NULL,NULL),(20,'PT07010000020',7.0,1.0,NULL,NULL,NULL,NULL,NULL),(21,'PT07010000021',7.0,1.0,NULL,NULL,NULL,NULL,NULL),(22,'PT07050000022',7.0,5.0,'Mentha Ã— piperita','Candymint','2019-02-20','2019-02-01',4),(23,'PT07050000023',7.0,5.0,'Mentha Ã— piperita','Candymint','2019-02-20','2019-02-01',4),(24,'PT07050000024',7.0,5.0,'Mentha Ã— piperita','Citrata','2019-02-20','2019-02-01',4),(25,'PT07150000025',7.0,15.0,'Cucurbita pepo','cylindrica',NULL,'2019-04-01',5),(26,'PT07150000026',7.0,15.0,'Cucurbita pepo','cylindrica',NULL,'2019-04-01',5),(27,'PT07150000027',7.0,15.0,'Cucurbita pepo','cylindrica',NULL,'2019-04-01',5),(28,'PT12040000028',12.0,4.0,'Brassica rapa','chinensis','2019-05-01','2019-04-01',7),(29,'PT12040000029',12.0,4.0,'Brassica rapa','chinensis','2019-05-01','2019-04-01',7),(30,'PT12040000030',12.0,4.0,'Brassica rapa','chinensis','2019-05-01','2019-04-01',7),(31,'PT12050000031',12.0,5.0,'Cucurbita pepo','pepo',NULL,'2019-04-01',6),(32,'PT12050000032',12.0,5.0,'Cucurbita pepo','pepo',NULL,'2019-04-01',6),(33,'PT12050000033',12.0,5.0,'Cucurbita pepo','pepo',NULL,'2019-04-01',6),(34,'PT12150000034',12.0,15.0,'Brassica rapa','rapa',NULL,'2019-05-01',7),(35,'PT12150000035',12.0,15.0,'Brassica rapa','rapa',NULL,'2019-05-01',7),(36,'PT12150000036',12.0,15.0,'Brassica rapa','rapa',NULL,'2019-05-01',7),(37,'PT12250000037',12.0,25.0,'Cucurbita pepo','pepo',NULL,'2019-04-01',6),(38,'PT12250000038',12.0,25.0,'Cucurbita pepo','pepo',NULL,'2019-04-01',6),(39,'PT12250000039',12.0,25.0,'Cucurbita pepo','pepo',NULL,'2019-04-01',6);
/*!40000 ALTER TABLE `pots` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `pots_view`
--

DROP TABLE IF EXISTS `pots_view`;
/*!50001 DROP VIEW IF EXISTS `pots_view`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8mb4;
/*!50001 CREATE VIEW `pots_view` AS SELECT 
 1 AS `id`,
 1 AS `barcode`,
 1 AS `height`,
 1 AS `volume`,
 1 AS `holding_species`,
 1 AS `holding_cultivar`,
 1 AS `holding_germination_date`,
 1 AS `holding_planting_date`,
 1 AS `on_tray`,
 1 AS `holding_age`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `trays`
--

DROP TABLE IF EXISTS `trays`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `trays` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `barcode` varchar(13) NOT NULL,
  `position` point NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `barcode` (`barcode`),
  CONSTRAINT `trays_ibfk_1` FOREIGN KEY (`barcode`) REFERENCES `barcodes` (`barcode`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trays`
--

LOCK TABLES `trays` WRITE;
/*!40000 ALTER TABLE `trays` DISABLE KEYS */;
INSERT INTO `trays` VALUES (1,'TRXXXX0000001',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0'),(2,'TRXXXX0000002',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0ð¿\0\0\0\0\0\0ð¿'),(3,'TRXXXX0000003',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0ð¿\0\0\0\0\0\0ð?'),(4,'TRXXXX0000004',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0À\0\0\0\0\0\0ð¿'),(5,'TRXXXX0000005',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0À\0\0\0\0\0\0ð?'),(6,'TRXXXX0000006',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0ð?\0\0\0\0\0\0ð¿'),(7,'TRXXXX0000007',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0ð?\0\0\0\0\0\0ð?');
/*!40000 ALTER TABLE `trays` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `weather_event`
--

DROP TABLE IF EXISTS `weather_event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `weather_event` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ambient_light` float NOT NULL,
  `air_moisture` float NOT NULL,
  `curr_pos` point NOT NULL,
  `curr_time` datetime NOT NULL,
  `temperature` decimal(4,1) NOT NULL,
  `station_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `station_id` (`station_id`),
  CONSTRAINT `weather_event_ibfk_1` FOREIGN KEY (`station_id`) REFERENCES `weather_station` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `weather_event`
--

LOCK TABLES `weather_event` WRITE;
/*!40000 ALTER TABLE `weather_event` DISABLE KEYS */;
INSERT INTO `weather_event` VALUES (1,2,2,_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0','2019-05-01 12:00:00',69.0,1),(2,2,2,_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0','2019-04-30 12:00:00',69.0,1),(3,2,2,_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0','2019-04-29 12:00:00',69.0,1),(4,2,2,_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0','2019-04-28 12:00:00',69.0,1),(5,2,2,_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0','2019-04-27 12:00:00',69.0,1),(6,2,2,_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0','2019-04-26 12:00:00',69.0,1),(7,2,2,_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0','2019-04-25 12:00:00',69.0,1),(8,2,2,_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0','2019-04-24 12:00:00',69.0,1),(9,2,2,_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0','2019-04-23 12:00:00',69.0,1),(10,2,2,_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0','2019-04-22 12:00:00',69.0,1),(11,2.5,2.1,_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0ð?\0\0\0\0\0\0ð?','2019-05-01 12:00:00',68.5,2),(12,2.5,2.1,_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0ð?\0\0\0\0\0\0ð?','2019-04-30 12:00:00',68.5,2),(13,2.5,2.1,_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0ð?\0\0\0\0\0\0ð?','2019-04-29 12:00:00',68.5,2),(14,2.5,2.1,_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0ð?\0\0\0\0\0\0ð?','2019-04-28 12:00:00',68.5,2),(15,2.5,2.1,_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0ð?\0\0\0\0\0\0ð?','2019-04-27 12:00:00',68.5,2),(16,2.5,2.1,_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0ð?\0\0\0\0\0\0ð?','2019-04-26 12:00:00',68.5,2),(17,2.5,2.1,_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0ð?\0\0\0\0\0\0ð?','2019-04-25 12:00:00',68.5,2),(18,2.5,2.1,_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0ð?\0\0\0\0\0\0ð?','2019-04-24 12:00:00',68.5,2),(19,2.5,2.1,_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0ð?\0\0\0\0\0\0ð?','2019-04-23 12:00:00',68.5,2),(20,2.5,2.1,_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0ð?\0\0\0\0\0\0ð?','2019-04-22 12:00:00',68.5,2),(21,2.1,2,_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0ð¿\0\0\0\0\0\0ð¿','2019-05-01 12:00:00',69.0,3),(22,2.1,2,_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0ð¿\0\0\0\0\0\0ð¿','2019-04-30 12:00:00',69.0,3),(23,2.1,2,_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0ð¿\0\0\0\0\0\0ð¿','2019-04-29 12:00:00',69.0,3),(24,2.1,2,_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0ð¿\0\0\0\0\0\0ð¿','2019-04-28 12:00:00',69.0,3),(25,2.1,2,_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0ð¿\0\0\0\0\0\0ð¿','2019-04-27 12:00:00',69.0,3),(26,2.1,2,_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0ð¿\0\0\0\0\0\0ð¿','2019-04-26 12:00:00',69.0,3),(27,2.1,2,_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0ð¿\0\0\0\0\0\0ð¿','2019-04-25 12:00:00',69.0,3),(28,2.1,2,_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0ð¿\0\0\0\0\0\0ð¿','2019-04-24 12:00:00',69.0,3),(29,2.1,2,_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0ð¿\0\0\0\0\0\0ð¿','2019-04-23 12:00:00',69.0,3),(30,2.1,2,_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0ð¿\0\0\0\0\0\0ð¿','2019-04-22 12:00:00',69.0,3),(31,2,2.1,_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0À\0\0\0\0\0\0\0À','2019-05-01 12:00:00',69.0,4),(32,2,2.1,_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0À\0\0\0\0\0\0\0À','2019-04-30 12:00:00',69.0,4),(33,2,2.1,_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0À\0\0\0\0\0\0\0À','2019-04-29 12:00:00',69.0,4),(34,2,2.1,_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0À\0\0\0\0\0\0\0À','2019-04-28 12:00:00',69.0,4),(35,2,2.1,_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0À\0\0\0\0\0\0\0À','2019-04-27 12:00:00',69.0,4),(36,2,2.1,_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0À\0\0\0\0\0\0\0À','2019-04-26 12:00:00',69.0,4),(37,2,2.1,_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0À\0\0\0\0\0\0\0À','2019-04-25 12:00:00',69.0,4),(38,2,2.1,_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0À\0\0\0\0\0\0\0À','2019-04-24 12:00:00',69.0,4),(39,2,2.1,_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0À\0\0\0\0\0\0\0À','2019-04-23 12:00:00',69.0,4),(40,2,2.1,_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0À\0\0\0\0\0\0\0À','2019-04-22 12:00:00',69.0,4),(41,2,2,_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0','2019-03-20 12:00:00',66.0,1),(42,2,2,_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0','2019-03-27 12:00:00',67.0,1),(43,2,2,_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0','2019-04-04 12:00:00',68.0,1),(44,2.1,2,_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0','2019-04-11 12:00:00',68.5,1),(45,2,2,_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0','2019-04-18 12:00:00',69.0,1);
/*!40000 ALTER TABLE `weather_event` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `weather_station`
--

DROP TABLE IF EXISTS `weather_station`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `weather_station` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `position` point NOT NULL,
  `station_name` varchar(32) NOT NULL,
  `barcode` varchar(13) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `station_name` (`station_name`),
  UNIQUE KEY `barcode` (`barcode`),
  CONSTRAINT `weather_station_ibfk_1` FOREIGN KEY (`barcode`) REFERENCES `barcodes` (`barcode`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `weather_station`
--

LOCK TABLES `weather_station` WRITE;
/*!40000 ALTER TABLE `weather_station` DISABLE KEYS */;
INSERT INTO `weather_station` VALUES (1,_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0','Artemis','WSXARTX000001'),(2,_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0ð?\0\0\0\0\0\0ð?','Hades','WSXHADX000002'),(3,_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0ð¿\0\0\0\0\0\0ð¿','Achiles','WSXACHX000003'),(4,_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0À\0\0\0\0\0\0\0À','Ganymede','WSXGANX000004');
/*!40000 ALTER TABLE `weather_station` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'project'
--

--
-- Dumping routines for database 'project'
--

--
-- Final view structure for view `activities_view`
--

/*!50001 DROP VIEW IF EXISTS `activities_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `activities_view` AS select `activity_log`.`ts` AS `ts`,`activity_log`.`pot_id` AS `pot_id`,`activity_log`.`food` AS `food`,`activity_log`.`water` AS `water`,`activity_log`.`starting_pos` AS `starting_pos`,`activity_log`.`ending_pos` AS `ending_pos`,`activity_log`.`starting_tray` AS `starting_tray`,`activity_log`.`ending_tray` AS `ending_tray`,`weather_event`.`ambient_light` AS `ambient_light`,`weather_event`.`air_moisture` AS `air_moisture`,`weather_event`.`temperature` AS `temperature` from (`activity_log` join `weather_event` on((`activity_log`.`weather_event_id` = `weather_event`.`id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `barcode_lookup_view`
--

/*!50001 DROP VIEW IF EXISTS `barcode_lookup_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `barcode_lookup_view` AS select `barcodes`.`barcode` AS `barcode`,`plants`.`species` AS `species`,`plants`.`cultivar` AS `cultivar`,`trays`.`id` AS `tray_id`,`pots`.`id` AS `pots_id`,`weather_station`.`id` AS `station_id` from ((((`barcodes` left join `plants` on((`plants`.`barcode` = `barcodes`.`barcode`))) left join `trays` on((`trays`.`barcode` = `barcodes`.`barcode`))) left join `pots` on((`pots`.`barcode` = `barcodes`.`barcode`))) left join `weather_station` on((`weather_station`.`barcode` = `barcodes`.`barcode`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `pots_view`
--

/*!50001 DROP VIEW IF EXISTS `pots_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `pots_view` AS select `pots`.`id` AS `id`,`pots`.`barcode` AS `barcode`,`pots`.`height` AS `height`,`pots`.`volume` AS `volume`,`pots`.`holding_species` AS `holding_species`,`pots`.`holding_cultivar` AS `holding_cultivar`,`pots`.`holding_germination_date` AS `holding_germination_date`,`pots`.`holding_planting_date` AS `holding_planting_date`,`pots`.`on_tray` AS `on_tray`,if((`pots`.`holding_germination_date` is not null),(to_days(now()) - to_days(`pots`.`holding_germination_date`)),NULL) AS `holding_age` from `pots` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-05-15 22:33:27
