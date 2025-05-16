-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: localhost    Database: othello
-- ------------------------------------------------------
-- Server version	8.0.35

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `aimodel`
--

DROP TABLE IF EXISTS `aimodel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `aimodel` (
  `id` varchar(10) NOT NULL,
  `name` varchar(20) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `difficulty` varchar(10) NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `serviceUrl` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aimodel`
--

LOCK TABLES `aimodel` WRITE;
/*!40000 ALTER TABLE `aimodel` DISABLE KEYS */;
INSERT INTO `aimodel` VALUES ('AIMODEL01','easy model','This is a model for easy match','EASY','2025-05-15 00:00:00','2025-05-15 00:00:00','http://localhost:8001'),('AIMODEL02','hard model','This is a model for hard match','HARD','2025-05-15 00:00:00','2025-05-15 00:00:00','http://localhost:8000');
/*!40000 ALTER TABLE `aimodel` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `aiparticipant`
--

DROP TABLE IF EXISTS `aiparticipant`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `aiparticipant` (
  `id` varchar(10) NOT NULL,
  `result` varchar(10) DEFAULT NULL,
  `color` varchar(10) NOT NULL,
  `AIModelId` varchar(10) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `AIModelId` (`AIModelId`),
  CONSTRAINT `aiparticipant_ibfk_1` FOREIGN KEY (`AIModelId`) REFERENCES `aimodel` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aiparticipant`
--

LOCK TABLES `aiparticipant` WRITE;
/*!40000 ALTER TABLE `aiparticipant` DISABLE KEYS */;
INSERT INTO `aiparticipant` VALUES ('02f59c35-d','WIN','WHITE','AIMODEL02'),('11','LOSE','WHITE','AIMODEL01'),('12','LOSE','WHITE','AIMODEL01'),('13','LOSE','WHITE','AIMODEL01'),('14','LOSE','WHITE','AIMODEL01'),('15','LOSE','WHITE','AIMODEL01'),('16','LOSE','WHITE','AIMODEL01'),('17','LOSE','WHITE','AIMODEL01'),('1714d763-f','WIN','WHITE','AIMODEL02'),('18','LOSE','WHITE','AIMODEL01'),('19','LOSE','WHITE','AIMODEL01'),('20','LOSE','WHITE','AIMODEL01'),('20ac8267-c',NULL,'WHITE','AIMODEL02'),('21','LOSE','WHITE','AIMODEL02'),('22','LOSE','WHITE','AIMODEL02'),('23','LOSE','WHITE','AIMODEL02'),('24','LOSE','WHITE','AIMODEL02'),('25','LOSE','WHITE','AIMODEL02'),('26','LOSE','WHITE','AIMODEL02'),('7432ed81-f','LOSE','WHITE','AIMODEL02'),('88e65267-6','WIN','WHITE','AIMODEL02'),('9b037986-0','LOSE','WHITE','AIMODEL02'),('9d207358-7','WIN','WHITE','AIMODEL02'),('9da3c3e3-c','LOSE','WHITE','AIMODEL02'),('aedc7648-9','WIN','WHITE','AIMODEL02'),('af0badad-b',NULL,'WHITE','AIMODEL02'),('d02230d1-7','WIN','WHITE','AIMODEL02'),('fed816d3-9','LOSE','WHITE','AIMODEL02');
/*!40000 ALTER TABLE `aiparticipant` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `competition`
--

DROP TABLE IF EXISTS `competition`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `competition` (
  `id` varchar(10) NOT NULL,
  `name` varchar(20) NOT NULL,
  `roundId` varchar(10) NOT NULL,
  `gameId` varchar(10) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `roundId` (`roundId`),
  KEY `gameId` (`gameId`),
  CONSTRAINT `competition_ibfk_1` FOREIGN KEY (`roundId`) REFERENCES `round` (`id`),
  CONSTRAINT `competition_ibfk_2` FOREIGN KEY (`gameId`) REFERENCES `game` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `competition`
--

LOCK TABLES `competition` WRITE;
/*!40000 ALTER TABLE `competition` DISABLE KEYS */;
/*!40000 ALTER TABLE `competition` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `game`
--

DROP TABLE IF EXISTS `game`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `game` (
  `id` varchar(10) NOT NULL,
  `startDateTime` datetime NOT NULL,
  `endDateTime` datetime DEFAULT NULL,
  `scoreBlack` int DEFAULT NULL,
  `scoreWhite` int DEFAULT NULL,
  `gameType` varchar(10) NOT NULL,
  `AIParticipantId` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `AIParticipantId` (`AIParticipantId`),
  CONSTRAINT `game_ibfk_1` FOREIGN KEY (`AIParticipantId`) REFERENCES `aiparticipant` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `game`
--

LOCK TABLES `game` WRITE;
/*!40000 ALTER TABLE `game` DISABLE KEYS */;
INSERT INTO `game` VALUES ('1','2025-05-15 00:00:00','2025-05-15 00:00:00',40,20,'PvE_EASY','11'),('10','2025-05-15 00:00:00','2025-05-15 00:00:00',40,20,'PvE_EASY','20'),('11','2025-05-15 00:00:00','2025-05-15 00:00:00',40,20,'PvE_HARD','21'),('12','2025-05-15 00:00:00','2025-05-15 00:00:00',40,20,'PvE_HARD','22'),('13','2025-05-15 00:00:00','2025-05-15 00:00:00',40,20,'PvE_HARD','23'),('14','2025-05-15 00:00:00','2025-05-15 00:00:00',40,20,'PvE_HARD','24'),('15','2025-05-15 00:00:00','2025-05-15 00:00:00',40,20,'PvE_HARD','25'),('16','2025-05-15 00:00:00','2025-05-15 00:00:00',40,20,'PvE_HARD','26'),('17','2025-05-15 00:00:00','2025-05-15 00:00:00',40,20,'PvP',NULL),('18','2025-05-15 00:00:00','2025-05-15 00:00:00',40,20,'PvP',NULL),('19','2025-05-15 00:00:00','2025-05-15 00:00:00',40,20,'PvP',NULL),('1aeb22cb-7','2025-05-15 00:47:21','2025-05-15 00:51:29',22,41,'PvE_HARD','02f59c35-d'),('2','2025-05-15 00:00:00','2025-05-15 00:00:00',40,20,'PvE_EASY','12'),('20','2025-05-15 00:00:00','2025-05-15 00:00:00',40,20,'PvP',NULL),('21','2025-05-15 00:00:00','2025-05-15 00:00:00',40,20,'PvP',NULL),('3','2025-05-15 00:00:00','2025-05-15 00:00:00',40,20,'PvE_EASY','13'),('4','2025-05-15 00:00:00','2025-05-15 00:00:00',40,20,'PvE_EASY','14'),('45f13a69-2','2025-05-15 01:01:21',NULL,2,2,'PvE_HARD','aedc7648-9'),('5','2025-05-15 00:00:00','2025-05-15 00:00:00',40,20,'PvE_EASY','15'),('5683475e-a','2025-05-15 00:26:14',NULL,2,2,'PvE_HARD','af0badad-b'),('6','2025-05-15 00:00:00','2025-05-15 00:00:00',40,20,'PvE_EASY','16'),('7','2025-05-15 00:00:00','2025-05-15 00:00:00',40,20,'PvE_EASY','17'),('7ebc7bbb-c','2025-05-15 01:05:30',NULL,2,2,'PvE_HARD','88e65267-6'),('8','2025-05-15 00:00:00','2025-05-15 00:00:00',40,20,'PvE_EASY','18'),('8a67ca18-7','2025-05-15 00:59:33',NULL,2,2,'PvE_HARD','9d207358-7'),('9','2025-05-15 00:00:00','2025-05-15 00:00:00',40,20,'PvE_EASY','19'),('948228c7-8','2025-05-15 23:57:36','2025-05-16 00:01:44',2,2,'PvE_HARD','20ac8267-c'),('9d8cd894-a','2025-05-15 23:48:05','2025-05-15 23:53:28',49,13,'PvE_HARD','9b037986-0'),('aaa69aff-f','2025-05-15 00:33:04','2025-05-15 00:40:41',50,14,'PvE_HARD','1714d763-f'),('d6e73f1a-a','2025-05-15 01:01:25','2025-05-15 01:05:15',42,20,'PvE_HARD','9da3c3e3-c'),('f4d4c329-a','2025-05-16 00:21:08','2025-05-16 00:26:22',33,31,'PvE_HARD','7432ed81-f'),('fe11b99b-5','2025-05-16 00:05:31','2025-05-16 00:10:45',47,16,'PvE_HARD','fed816d3-9'),('ffabe598-9','2025-05-16 00:13:41','2025-05-16 00:17:10',18,45,'PvE_HARD','d02230d1-7');
/*!40000 ALTER TABLE `game` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gameparticipant`
--

DROP TABLE IF EXISTS `gameparticipant`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gameparticipant` (
  `id` varchar(10) NOT NULL,
  `result` varchar(10) DEFAULT NULL,
  `color` varchar(10) NOT NULL,
  `gameId` varchar(10) NOT NULL,
  `userId` varchar(10) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `gameId` (`gameId`),
  KEY `userId` (`userId`),
  CONSTRAINT `gameparticipant_ibfk_1` FOREIGN KEY (`gameId`) REFERENCES `game` (`id`),
  CONSTRAINT `gameparticipant_ibfk_2` FOREIGN KEY (`userId`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gameparticipant`
--

LOCK TABLES `gameparticipant` WRITE;
/*!40000 ALTER TABLE `gameparticipant` DISABLE KEYS */;
INSERT INTO `gameparticipant` VALUES ('1','WIN','BLACK','1','USER01'),('10','WIN','BLACK','10','4ab3de23-0'),('11','WIN','BLACK','11','4ab3de23-0'),('12','WIN','BLACK','12','4ab3de23-0'),('13','WIN','BLACK','13','4ab3de23-0'),('14','WIN','BLACK','14','4ab3de23-0'),('15','WIN','BLACK','15','4ab3de23-0'),('16','WIN','BLACK','16','4ab3de23-0'),('17','WIN','BLACK','17','4ab3de23-0'),('18','LOSE','WHITE','17','USER01'),('19','WIN','BLACK','18','4ab3de23-0'),('2','WIN','BLACK','2','USER01'),('20','LOSE','WHITE','18','USER01'),('21','WIN','BLACK','19','4ab3de23-0'),('22','LOSE','WHITE','19','USER01'),('23','WIN','BLACK','20','4ab3de23-0'),('24','LOSE','WHITE','20','USER01'),('25','WIN','BLACK','21','4ab3de23-0'),('26','LOSE','WHITE','21','USER01'),('26df0f12-7','WIN','BLACK','9d8cd894-a','USER01'),('2d7714a8-8','WIN','BLACK','f4d4c329-a','USER01'),('3','WIN','BLACK','3','USER01'),('4','WIN','BLACK','3','4ab3de23-0'),('40dece1c-e','LOSE','BLACK','1aeb22cb-7','4ab3de23-0'),('5','WIN','BLACK','5','4ab3de23-0'),('6','WIN','BLACK','6','4ab3de23-0'),('7','WIN','BLACK','7','4ab3de23-0'),('8','WIN','BLACK','8','4ab3de23-0'),('8b0d4eed-c','LOSE','BLACK','aaa69aff-f','4ab3de23-0'),('9','WIN','BLACK','9','4ab3de23-0'),('9150f90f-a','LOSE','BLACK','7ebc7bbb-c','4ab3de23-0'),('9347450a-9','LOSE','BLACK','ffabe598-9','USER01'),('c5987674-c',NULL,'BLACK','5683475e-a','4ab3de23-0'),('cf9dd58b-3','LOSE','BLACK','45f13a69-2','4ab3de23-0'),('d91ee25f-4','WIN','BLACK','fe11b99b-5','USER01'),('e1280be4-7','LOSE','BLACK','8a67ca18-7','4ab3de23-0'),('e371694e-6',NULL,'BLACK','948228c7-8','USER01'),('eb6747bf-9','WIN','BLACK','d6e73f1a-a','4ab3de23-0');
/*!40000 ALTER TABLE `gameparticipant` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `move`
--

DROP TABLE IF EXISTS `move`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `move` (
  `id` varchar(10) NOT NULL,
  `positionX` int DEFAULT NULL,
  `positionY` int DEFAULT NULL,
  `color` varchar(10) NOT NULL,
  `gameId` varchar(10) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `gameId` (`gameId`),
  CONSTRAINT `move_ibfk_1` FOREIGN KEY (`gameId`) REFERENCES `game` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `move`
--

LOCK TABLES `move` WRITE;
/*!40000 ALTER TABLE `move` DISABLE KEYS */;
INSERT INTO `move` VALUES ('000adacd-d',1,3,'WHITE','1aeb22cb-7'),('001cada2-0',5,2,'WHITE','ffabe598-9'),('009bb3e6-b',2,2,'BLACK','f4d4c329-a'),('00b8e4b9-f',7,3,'BLACK','5683475e-a'),('0155a37f-7',2,5,'BLACK','f4d4c329-a'),('023a8b65-9',0,7,'BLACK','d6e73f1a-a'),('02da60e2-5',2,1,'WHITE','aaa69aff-f'),('030edcdb-2',0,1,'WHITE','d6e73f1a-a'),('031e7f79-9',6,4,'WHITE','5683475e-a'),('03868490-1',0,7,'BLACK','ffabe598-9'),('0592feb7-1',7,2,'BLACK','aaa69aff-f'),('059bc77b-3',3,7,'WHITE','aaa69aff-f'),('061f6f6d-8',5,1,'WHITE','1aeb22cb-7'),('06372456-8',5,2,'WHITE','fe11b99b-5'),('064c1a3a-f',2,4,'WHITE','aaa69aff-f'),('0660811c-5',5,3,'BLACK','948228c7-8'),('07316b6c-3',6,3,'WHITE','5683475e-a'),('08cc18d2-f',2,2,'BLACK','9d8cd894-a'),('08ce3d78-9',6,4,'WHITE','aaa69aff-f'),('09335f55-a',0,2,'BLACK','d6e73f1a-a'),('09b23e97-f',1,2,'WHITE','f4d4c329-a'),('09efeb96-c',2,0,'BLACK','5683475e-a'),('0a723ca7-0',5,6,'WHITE','d6e73f1a-a'),('0acd4abf-c',6,3,'WHITE','aaa69aff-f'),('0ae52e73-c',0,6,'WHITE','ffabe598-9'),('0b03bbef-9',4,7,'BLACK','fe11b99b-5'),('0b245188-a',7,5,'BLACK','1aeb22cb-7'),('0ba9d8e3-9',7,3,'BLACK','d6e73f1a-a'),('0bddcee2-d',0,7,'BLACK','f4d4c329-a'),('0c355524-5',0,1,'WHITE','5683475e-a'),('0c6f6133-2',NULL,NULL,'WHITE','aaa69aff-f'),('0cc4dd9e-f',4,7,'BLACK','ffabe598-9'),('0da37abe-4',1,5,'WHITE','9d8cd894-a'),('0dd387d9-4',5,0,'BLACK','fe11b99b-5'),('0e139772-c',5,3,'BLACK','f4d4c329-a'),('0e679584-1',5,3,'BLACK','1aeb22cb-7'),('0e7ece0e-a',NULL,NULL,'WHITE','aaa69aff-f'),('0e82dbb1-b',0,3,'WHITE','948228c7-8'),('0fb74903-8',6,1,'BLACK','ffabe598-9'),('0ffaeab6-1',4,7,'BLACK','5683475e-a'),('107dc23c-f',5,7,'BLACK','1aeb22cb-7'),('108861cb-1',2,7,'BLACK','ffabe598-9'),('10b1e5a1-3',5,5,'WHITE','948228c7-8'),('10e73544-a',3,6,'BLACK','ffabe598-9'),('119d1b24-b',4,1,'WHITE','f4d4c329-a'),('11de19fd-f',4,2,'WHITE','ffabe598-9'),('126527de-b',0,0,'BLACK','fe11b99b-5'),('12f776ed-c',2,6,'BLACK','9d8cd894-a'),('137b2888-4',1,4,'WHITE','d6e73f1a-a'),('139c3b90-6',1,7,'WHITE','fe11b99b-5'),('15d87518-2',4,0,'BLACK','948228c7-8'),('16fa7f74-d',1,7,'WHITE','9d8cd894-a'),('170142a0-8',0,7,'BLACK','9d8cd894-a'),('1788d6e9-5',1,5,'BLACK','5683475e-a'),('184f4f65-b',2,0,'WHITE','aaa69aff-f'),('19340b63-a',1,0,'BLACK','ffabe598-9'),('1940a7f7-9',2,5,'BLACK','9d8cd894-a'),('1985a40e-3',1,1,'BLACK','d6e73f1a-a'),('1b395314-6',6,4,'WHITE','ffabe598-9'),('1c23c332-d',6,2,'BLACK','9d8cd894-a'),('1c31fa08-9',4,7,'BLACK','aaa69aff-f'),('1c38b0d9-1',3,5,'BLACK','fe11b99b-5'),('1dda7bfb-d',5,4,'WHITE','5683475e-a'),('1ddc2748-c',0,6,'WHITE','9d8cd894-a'),('1e19096d-e',NULL,NULL,'WHITE','aaa69aff-f'),('1e4e2b56-5',7,2,'BLACK','fe11b99b-5'),('1eb0f013-0',4,0,'BLACK','9d8cd894-a'),('1f53f650-0',2,7,'BLACK','aaa69aff-f'),('202b39e5-5',3,1,'WHITE','f4d4c329-a'),('20c9ef58-e',2,2,'WHITE','ffabe598-9'),('20e50dda-0',6,2,'WHITE','fe11b99b-5'),('217dfcc0-6',3,1,'BLACK','ffabe598-9'),('233046d5-4',6,0,'WHITE','ffabe598-9'),('23ec1d5e-d',2,7,'BLACK','948228c7-8'),('244d78cc-5',6,2,'WHITE','f4d4c329-a'),('246290b4-c',5,0,'BLACK','1aeb22cb-7'),('24ee6a86-2',6,0,'BLACK','9d8cd894-a'),('250f60bc-8',4,0,'BLACK','5683475e-a'),('25586971-a',1,5,'WHITE','1aeb22cb-7'),('259eba35-b',4,2,'WHITE','1aeb22cb-7'),('260da9b7-d',3,6,'WHITE','fe11b99b-5'),('2636d328-0',6,0,'BLACK','d6e73f1a-a'),('26ca3757-a',1,2,'WHITE','1aeb22cb-7'),('2874c7be-3',2,0,'BLACK','fe11b99b-5'),('28b0d160-7',1,2,'WHITE','fe11b99b-5'),('28e3ee33-0',2,5,'BLACK','5683475e-a'),('29382846-6',2,4,'WHITE','fe11b99b-5'),('29b7155b-4',6,5,'BLACK','f4d4c329-a'),('2a0e27f7-e',6,7,'BLACK','9d8cd894-a'),('2abd464c-1',6,3,'WHITE','9d8cd894-a'),('2bcd985a-8',5,2,'WHITE','d6e73f1a-a'),('2c901af3-0',7,7,'BLACK','9d8cd894-a'),('2cebbe57-f',0,2,'BLACK','f4d4c329-a'),('2d96977e-f',4,6,'WHITE','aaa69aff-f'),('2dbda228-c',6,1,'WHITE','9d8cd894-a'),('2dbefd71-9',0,1,'WHITE','948228c7-8'),('2dc515cd-a',3,2,'WHITE','aaa69aff-f'),('2e2d63eb-d',2,1,'WHITE','f4d4c329-a'),('2e4ec114-5',4,1,'BLACK','d6e73f1a-a'),('2fa55afc-1',1,4,'WHITE','9d8cd894-a'),('2fae3fd1-8',3,7,'BLACK','1aeb22cb-7'),('303dbe32-e',7,6,'BLACK','aaa69aff-f'),('30df0d42-f',1,3,'WHITE','5683475e-a'),('311ee5d2-e',7,7,'BLACK','948228c7-8'),('312106d9-b',0,6,'WHITE','fe11b99b-5'),('314482b1-6',3,5,'WHITE','5683475e-a'),('3170a8f1-f',0,6,'WHITE','aaa69aff-f'),('31ba9970-3',3,7,'BLACK','9d8cd894-a'),('32cc35e0-f',3,0,'BLACK','ffabe598-9'),('333f89fa-9',4,7,'BLACK','948228c7-8'),('33638368-9',3,1,'WHITE','1aeb22cb-7'),('33e18bf2-8',7,0,'BLACK','9d8cd894-a'),('33ef71f1-9',2,7,'BLACK','9d8cd894-a'),('3487df03-2',7,2,'BLACK','948228c7-8'),('34893b2f-3',3,6,'WHITE','aaa69aff-f'),('364188a2-e',3,1,'BLACK','aaa69aff-f'),('36a17e92-1',0,4,'WHITE','ffabe598-9'),('3733d6f1-f',4,6,'WHITE','9d8cd894-a'),('37784801-9',2,2,'BLACK','d6e73f1a-a'),('37a5ba21-d',1,2,'WHITE','948228c7-8'),('37e72020-e',3,7,'BLACK','948228c7-8'),('37ec6601-8',5,2,'WHITE','5683475e-a'),('38b15659-6',7,5,'BLACK','fe11b99b-5'),('39070a82-d',6,6,'WHITE','1aeb22cb-7'),('39e95f84-5',1,5,'WHITE','f4d4c329-a'),('39fab761-1',2,4,'WHITE','d6e73f1a-a'),('3a5ee5ee-6',2,1,'WHITE','d6e73f1a-a'),('3bb862b6-b',1,0,'BLACK','d6e73f1a-a'),('3beaac3a-8',3,7,'WHITE','ffabe598-9'),('3c672a71-c',6,1,'WHITE','948228c7-8'),('3cca3c96-3',0,2,'BLACK','5683475e-a'),('3dafb2cd-4',7,4,'BLACK','9d8cd894-a'),('3dcdd146-8',5,5,'WHITE','ffabe598-9'),('3e2c52d3-c',2,3,'BLACK','fe11b99b-5'),('3f45ec70-e',0,7,'BLACK','5683475e-a'),('3fdc1174-5',6,4,'WHITE','d6e73f1a-a'),('40238517-8',1,0,'BLACK','948228c7-8'),('41821750-c',6,1,'WHITE','f4d4c329-a'),('418bad9a-2',7,1,'BLACK','fe11b99b-5'),('4196bbcb-2',1,0,'WHITE','5683475e-a'),('419ea7fd-d',7,1,'BLACK','1aeb22cb-7'),('41b7ea77-a',3,0,'BLACK','aaa69aff-f'),('421bebfa-6',0,2,'WHITE','1aeb22cb-7'),('4223b345-2',7,7,'BLACK','fe11b99b-5'),('429ab763-4',5,1,'WHITE','f4d4c329-a'),('42ec0cbc-c',2,2,'BLACK','aaa69aff-f'),('435fd196-7',4,0,'BLACK','fe11b99b-5'),('43bdd9ca-1',0,3,'WHITE','fe11b99b-5'),('43ee3d9b-4',1,1,'WHITE','aaa69aff-f'),('440728ee-7',0,4,'BLACK','f4d4c329-a'),('440c5dce-6',5,4,'BLACK','9d8cd894-a'),('4454e2e2-6',7,3,'WHITE','948228c7-8'),('446dd343-6',1,7,'WHITE','ffabe598-9'),('44b42f59-2',2,7,'BLACK','d6e73f1a-a'),('459c10bf-7',1,0,'BLACK','fe11b99b-5'),('45b6fe6d-4',6,3,'BLACK','948228c7-8'),('46d153a2-e',0,6,'WHITE','f4d4c329-a'),('47047372-f',0,5,'BLACK','f4d4c329-a'),('47a1c2da-0',0,1,'BLACK','1aeb22cb-7'),('48349b8a-1',6,7,'BLACK','d6e73f1a-a'),('488db994-8',1,6,'WHITE','ffabe598-9'),('4984c857-a',7,7,'BLACK','aaa69aff-f'),('49957e47-9',2,6,'WHITE','ffabe598-9'),('49b2242b-8',6,6,'WHITE','ffabe598-9'),('4a560743-4',1,2,'BLACK','5683475e-a'),('4a97678f-9',3,1,'WHITE','d6e73f1a-a'),('4b79cc0c-5',3,2,'WHITE','9d8cd894-a'),('4b871fa7-2',6,5,'BLACK','5683475e-a'),('4be07c3c-6',0,4,'WHITE','1aeb22cb-7'),('4c361a8a-8',6,4,'WHITE','1aeb22cb-7'),('4cbb370d-6',6,7,'BLACK','5683475e-a'),('4cd0445a-5',6,6,'WHITE','f4d4c329-a'),('4d58ab66-9',7,6,'BLACK','1aeb22cb-7'),('4d858cfa-4',3,0,'WHITE','9d8cd894-a'),('4db03c3b-e',6,6,'WHITE','9d8cd894-a'),('4e6e23fe-6',6,6,'BLACK','aaa69aff-f'),('4f2ea35f-3',1,5,'BLACK','ffabe598-9'),('5045fd0a-b',7,7,'BLACK','d6e73f1a-a'),('505b4ede-7',3,0,'WHITE','fe11b99b-5'),('511b33ae-4',1,0,'BLACK','f4d4c329-a'),('513c1a58-0',6,2,'BLACK','d6e73f1a-a'),('5222ac6a-2',7,4,'BLACK','1aeb22cb-7'),('52c70ae4-a',5,4,'BLACK','aaa69aff-f'),('532577cd-c',0,4,'BLACK','948228c7-8'),('53d840e8-f',7,5,'WHITE','d6e73f1a-a'),('54af74f9-0',5,0,'WHITE','f4d4c329-a'),('54ddd1e8-4',2,7,'BLACK','fe11b99b-5'),('54f7a24c-e',1,1,'WHITE','5683475e-a'),('55741e7e-3',4,5,'BLACK','ffabe598-9'),('55dc7f2b-3',5,5,'BLACK','fe11b99b-5'),('56c8097d-5',5,5,'BLACK','5683475e-a'),('56e4a0ca-c',NULL,NULL,'WHITE','aaa69aff-f'),('588096c9-9',2,5,'BLACK','ffabe598-9'),('58abf7aa-7',1,3,'WHITE','f4d4c329-a'),('59185374-1',2,6,'BLACK','fe11b99b-5'),('594b2faa-8',1,3,'WHITE','9d8cd894-a'),('59701fe1-3',1,7,'WHITE','f4d4c329-a'),('5b65d239-1',0,1,'WHITE','9d8cd894-a'),('5c1af53e-7',0,3,'BLACK','1aeb22cb-7'),('5c3fd4b7-8',3,2,'BLACK','ffabe598-9'),('5c5c2954-8',7,2,'WHITE','d6e73f1a-a'),('5e36be53-0',6,4,'BLACK','fe11b99b-5'),('5ecbff07-7',0,2,'WHITE','ffabe598-9'),('5f07056e-9',99999,99999,'WHITE','f4d4c329-a'),('5f0dccd6-1',2,5,'BLACK','fe11b99b-5'),('6142ea2e-2',4,1,'BLACK','5683475e-a'),('6159af72-d',4,1,'WHITE','9d8cd894-a'),('6170e8af-d',6,3,'WHITE','f4d4c329-a'),('61b48d20-d',4,2,'WHITE','948228c7-8'),('62259d75-4',2,4,'WHITE','9d8cd894-a'),('62da8f82-8',2,2,'BLACK','5683475e-a'),('63bf03f5-5',0,5,'BLACK','d6e73f1a-a'),('6404544c-5',0,6,'WHITE','1aeb22cb-7'),('6428f05a-6',1,6,'WHITE','948228c7-8'),('64d01efc-b',3,6,'WHITE','5683475e-a'),('67c77f3f-6',1,3,'WHITE','948228c7-8'),('689510f0-4',4,5,'WHITE','9d8cd894-a'),('68b1a044-4',0,6,'WHITE','948228c7-8'),('68d95269-1',7,1,'WHITE','9d8cd894-a'),('68fdbb19-e',5,3,'BLACK','5683475e-a'),('69374757-3',7,1,'WHITE','aaa69aff-f'),('6ac85b66-b',3,0,'WHITE','d6e73f1a-a'),('6b73b01e-3',6,7,'WHITE','ffabe598-9'),('6bc136b6-b',7,4,'BLACK','948228c7-8'),('6bcd2279-a',4,1,'BLACK','1aeb22cb-7'),('6c0729b5-b',6,1,'WHITE','aaa69aff-f'),('6c2ce2d7-8',1,7,'WHITE','5683475e-a'),('6d181365-e',6,2,'WHITE','aaa69aff-f'),('6d3bd461-c',4,1,'WHITE','aaa69aff-f'),('6e63418e-c',1,6,'WHITE','5683475e-a'),('6e84d413-e',5,0,'WHITE','aaa69aff-f'),('6e8a798b-d',7,6,'WHITE','d6e73f1a-a'),('6e96629b-f',1,2,'WHITE','d6e73f1a-a'),('6ee5418b-a',5,6,'WHITE','948228c7-8'),('6f21dd80-a',6,2,'BLACK','948228c7-8'),('6f41727b-3',1,6,'WHITE','d6e73f1a-a'),('713d8afb-c',5,4,'BLACK','d6e73f1a-a'),('71517433-f',4,7,'BLACK','9d8cd894-a'),('719aa258-8',4,7,'BLACK','f4d4c329-a'),('71f904b9-6',5,4,'WHITE','1aeb22cb-7'),('725698c4-3',7,6,'BLACK','9d8cd894-a'),('72662ffd-f',5,2,'BLACK','f4d4c329-a'),('72cc3be2-6',2,4,'WHITE','948228c7-8'),('732b21a2-3',3,7,'BLACK','d6e73f1a-a'),('734b9466-1',6,2,'WHITE','ffabe598-9'),('74a12035-0',5,6,'WHITE','5683475e-a'),('75ef5c3c-2',0,7,'BLACK','1aeb22cb-7'),('76ff8e72-6',7,3,'BLACK','ffabe598-9'),('771fffd6-0',2,6,'BLACK','d6e73f1a-a'),('77c43915-f',1,0,'BLACK','9d8cd894-a'),('782f5780-b',6,2,'WHITE','1aeb22cb-7'),('782f6f1f-c',1,7,'WHITE','1aeb22cb-7'),('78303f5e-b',0,7,'BLACK','aaa69aff-f'),('79af673c-4',4,6,'BLACK','ffabe598-9'),('7ae22741-9',2,1,'WHITE','5683475e-a'),('7af169c8-b',0,7,'BLACK','fe11b99b-5'),('7b8d5deb-3',7,7,'BLACK','1aeb22cb-7'),('7bd09ec1-4',7,3,'BLACK','f4d4c329-a'),('7cbc202e-c',7,5,'WHITE','9d8cd894-a'),('7d42c9f6-c',1,7,'WHITE','948228c7-8'),('7d770e14-4',1,5,'WHITE','948228c7-8'),('7e7e7938-c',3,5,'BLACK','d6e73f1a-a'),('7f138c2b-7',2,5,'BLACK','aaa69aff-f'),('7f240bc8-6',7,0,'BLACK','fe11b99b-5'),('7f4f03a6-e',6,6,'WHITE','948228c7-8'),('7fd80046-e',2,3,'BLACK','f4d4c329-a'),('80670ca8-3',1,3,'BLACK','ffabe598-9'),('80ff6994-4',2,0,'BLACK','d6e73f1a-a'),('8147a3f7-3',7,0,'BLACK','d6e73f1a-a'),('81e292ea-7',2,4,'WHITE','5683475e-a'),('8285db52-c',7,3,'WHITE','9d8cd894-a'),('83215800-0',4,0,'BLACK','aaa69aff-f'),('8401aa2f-3',2,2,'BLACK','fe11b99b-5'),('840207c8-1',5,3,'WHITE','d6e73f1a-a'),('8437cefa-f',7,2,'BLACK','ffabe598-9'),('84a981d6-3',0,0,'BLACK','f4d4c329-a'),('8514d962-4',5,2,'BLACK','9d8cd894-a'),('8553377a-5',7,5,'BLACK','f4d4c329-a'),('8576f99c-4',4,0,'WHITE','1aeb22cb-7'),('863135e9-3',0,0,'BLACK','5683475e-a'),('87610b02-c',2,4,'WHITE','1aeb22cb-7'),('876bc014-b',5,2,'BLACK','1aeb22cb-7'),('88830f7a-a',6,3,'WHITE','1aeb22cb-7'),('88c35028-1',0,5,'BLACK','5683475e-a'),('88e48a28-c',6,1,'BLACK','5683475e-a'),('89390742-6',2,0,'BLACK','9d8cd894-a'),('8a6c77ee-7',6,4,'WHITE','9d8cd894-a'),('8c897bf8-4',2,3,'BLACK','948228c7-8'),('8d004e95-9',4,2,'WHITE','fe11b99b-5'),('8dbce751-a',3,1,'BLACK','5683475e-a'),('8e03dd39-7',7,4,'BLACK','5683475e-a'),('8e0c7329-2',4,5,'WHITE','948228c7-8'),('8e281ccb-4',0,2,'BLACK','948228c7-8'),('8f1f3356-3',4,6,'BLACK','f4d4c329-a'),('9067f4a1-5',2,3,'BLACK','9d8cd894-a'),('9084247f-a',6,5,'WHITE','aaa69aff-f'),('91334787-2',7,1,'WHITE','948228c7-8'),('91f42309-c',7,7,'WHITE','f4d4c329-a'),('930d1d7a-5',0,4,'BLACK','9d8cd894-a'),('94a96599-4',5,1,'WHITE','948228c7-8'),('94db1ba4-1',7,6,'WHITE','948228c7-8'),('9520eb74-0',1,6,'WHITE','9d8cd894-a'),('9537cc77-b',1,3,'WHITE','d6e73f1a-a'),('95a631f3-c',0,5,'BLACK','1aeb22cb-7'),('96566995-c',6,5,'WHITE','1aeb22cb-7'),('972076cb-e',1,5,'WHITE','aaa69aff-f'),('973e828d-f',6,3,'WHITE','ffabe598-9'),('9781cb1d-5',7,1,'WHITE','f4d4c329-a'),('9792ad90-4',6,7,'BLACK','948228c7-8'),('97da8ae2-2',7,2,'BLACK','9d8cd894-a'),('97fd8ea8-e',6,6,'WHITE','fe11b99b-5'),('9865f14f-2',6,5,'WHITE','fe11b99b-5'),('988fb5bb-3',4,2,'WHITE','d6e73f1a-a'),('98bce587-0',7,3,'WHITE','1aeb22cb-7'),('98c80069-4',3,2,'WHITE','f4d4c329-a'),('98df3174-6',3,6,'WHITE','d6e73f1a-a'),('99484653-e',6,0,'BLACK','aaa69aff-f'),('9982cae1-6',6,0,'WHITE','fe11b99b-5'),('9a3686d8-b',5,5,'BLACK','1aeb22cb-7'),('9a3a9733-3',7,4,'BLACK','d6e73f1a-a'),('9afda5c3-9',1,4,'WHITE','948228c7-8'),('9b580833-a',5,3,'BLACK','aaa69aff-f'),('9c0f76c6-c',7,4,'BLACK','aaa69aff-f'),('9c67ed58-c',5,6,'WHITE','ffabe598-9'),('9d3793a4-b',1,1,'WHITE','fe11b99b-5'),('9d5e90a6-3',3,0,'WHITE','5683475e-a'),('9dc27091-e',0,2,'BLACK','aaa69aff-f'),('9de8deae-0',1,0,'BLACK','1aeb22cb-7'),('9ec4ee0f-7',5,1,'BLACK','fe11b99b-5'),('9fb027bc-f',0,2,'BLACK','fe11b99b-5'),('9fcc0053-7',1,2,'WHITE','9d8cd894-a'),('a08617d0-e',4,2,'WHITE','5683475e-a'),('a1a55260-3',99999,99999,'WHITE','9d8cd894-a'),('a1d96dc5-3',7,0,'BLACK','ffabe598-9'),('a1e4d153-c',5,5,'BLACK','f4d4c329-a'),('a258b7a7-4',0,4,'BLACK','d6e73f1a-a'),('a26f971e-1',3,6,'WHITE','1aeb22cb-7'),('a27689b9-a',6,7,'WHITE','1aeb22cb-7'),('a2ddab0b-5',5,7,'BLACK','f4d4c329-a'),('a2df6959-5',1,2,'WHITE','aaa69aff-f'),('a2e56d1e-4',2,2,'BLACK','948228c7-8'),('a304ec3d-d',4,5,'WHITE','f4d4c329-a'),('a34c1691-3',3,6,'WHITE','9d8cd894-a'),('a35acb96-b',0,5,'BLACK','aaa69aff-f'),('a37287f8-9',1,0,'BLACK','aaa69aff-f'),('a3ec57fc-f',4,1,'WHITE','ffabe598-9'),('a3f93e5a-2',99999,99999,'WHITE','fe11b99b-5'),('a46e6e09-e',0,7,'BLACK','948228c7-8'),('a4a4bfcb-a',2,3,'BLACK','ffabe598-9'),('a64976f3-8',5,7,'BLACK','aaa69aff-f'),('a7a7e80c-1',7,2,'BLACK','1aeb22cb-7'),('a8ad5c6b-2',3,1,'WHITE','948228c7-8'),('a92b1b59-0',3,5,'WHITE','f4d4c329-a'),('aa28710c-0',5,6,'WHITE','fe11b99b-5'),('aada8dc4-d',1,7,'WHITE','d6e73f1a-a'),('ab5a2a97-3',1,4,'WHITE','ffabe598-9'),('abf50b55-5',6,1,'WHITE','fe11b99b-5'),('ac838b6d-e',5,1,'WHITE','9d8cd894-a'),('ad14e01e-a',0,3,'WHITE','5683475e-a'),('ada232d9-1',7,5,'WHITE','5683475e-a'),('ade318df-0',7,0,'BLACK','1aeb22cb-7'),('ade625d7-4',6,5,'WHITE','ffabe598-9'),('aec98ffa-9',1,5,'WHITE','d6e73f1a-a'),('aeed6269-3',6,0,'BLACK','f4d4c329-a'),('af0ca9d8-6',5,4,'BLACK','fe11b99b-5'),('af50340c-1',2,3,'BLACK','aaa69aff-f'),('af6b458d-9',2,3,'BLACK','1aeb22cb-7'),('b048ad14-4',7,5,'BLACK','aaa69aff-f'),('b0bd763e-0',99999,99999,'WHITE','ffabe598-9'),('b0cbf1ac-9',1,7,'WHITE','aaa69aff-f'),('b16342e9-d',3,7,'WHITE','f4d4c329-a'),('b24814c1-3',1,1,'BLACK','f4d4c329-a'),('b34fa461-6',3,6,'WHITE','948228c7-8'),('b3af1e45-9',7,7,'BLACK','5683475e-a'),('b3f856ba-5',2,1,'WHITE','9d8cd894-a'),('b40d7fb6-4',7,3,'BLACK','fe11b99b-5'),('b45420b1-7',2,4,'WHITE','f4d4c329-a'),('b469acc3-a',5,0,'WHITE','948228c7-8'),('b474fa35-d',4,6,'WHITE','948228c7-8'),('b4b8b19b-f',5,3,'BLACK','fe11b99b-5'),('b5463f94-d',5,7,'BLACK','fe11b99b-5'),('b5a77635-b',0,0,'BLACK','9d8cd894-a'),('b5e77376-2',5,1,'WHITE','aaa69aff-f'),('b5f7b496-4',2,7,'BLACK','5683475e-a'),('b674d2f8-2',1,1,'BLACK','ffabe598-9'),('b6d5a26c-b',5,4,'BLACK','ffabe598-9'),('b7da5665-0',2,3,'BLACK','d6e73f1a-a'),('b82121b7-d',1,1,'BLACK','948228c7-8'),('b8fcf432-8',1,4,'BLACK','f4d4c329-a'),('b9c75f0f-6',2,3,'BLACK','5683475e-a'),('ba99e920-a',1,5,'WHITE','fe11b99b-5'),('bc1775dd-d',2,6,'WHITE','1aeb22cb-7'),('bc2dd415-c',6,7,'WHITE','f4d4c329-a'),('bcc58d6d-e',7,0,'BLACK','948228c7-8'),('bd3a8532-a',6,0,'BLACK','948228c7-8'),('bd751cef-2',0,1,'BLACK','ffabe598-9'),('bd75a686-2',1,2,'WHITE','ffabe598-9'),('bd96e303-7',2,6,'BLACK','f4d4c329-a'),('bda42d80-e',7,0,'BLACK','5683475e-a'),('bedae59b-5',5,3,'WHITE','9d8cd894-a'),('beff4f98-6',3,2,'WHITE','d6e73f1a-a'),('bfcfb686-1',0,2,'BLACK','9d8cd894-a'),('c05ecfda-6',3,2,'BLACK','5683475e-a'),('c063393e-6',7,6,'BLACK','5683475e-a'),('c08c2f16-1',3,5,'BLACK','948228c7-8'),('c16c3f95-9',6,2,'WHITE','5683475e-a'),('c1bd85b0-f',3,6,'WHITE','f4d4c329-a'),('c2608cf5-e',5,1,'BLACK','d6e73f1a-a'),('c282a767-d',2,1,'WHITE','fe11b99b-5'),('c285c438-a',5,2,'WHITE','948228c7-8'),('c2aa735b-6',2,1,'WHITE','948228c7-8'),('c2e6d623-7',2,0,'WHITE','ffabe598-9'),('c313f19d-e',7,5,'BLACK','948228c7-8'),('c39b2cc2-a',6,4,'WHITE','948228c7-8'),('c41b1557-2',0,3,'WHITE','d6e73f1a-a'),('c4af95fc-d',5,0,'WHITE','d6e73f1a-a'),('c4d61160-f',4,5,'WHITE','d6e73f1a-a'),('c4ec9c5d-a',0,6,'WHITE','d6e73f1a-a'),('c50316a8-1',1,4,'BLACK','aaa69aff-f'),('c5280988-e',1,6,'WHITE','f4d4c329-a'),('c5581143-5',4,5,'WHITE','1aeb22cb-7'),('c5916fcb-9',2,2,'BLACK','1aeb22cb-7'),('c5c9dbbd-6',3,7,'WHITE','5683475e-a'),('c5e00b8b-2',4,1,'BLACK','948228c7-8'),('c6787b26-7',5,0,'WHITE','5683475e-a'),('c6b85724-f',1,6,'WHITE','aaa69aff-f'),('c7c0d412-2',2,0,'BLACK','f4d4c329-a'),('c983380d-f',7,1,'BLACK','ffabe598-9'),('c98f838a-b',0,4,'BLACK','fe11b99b-5'),('c99bfa0f-d',3,1,'WHITE','fe11b99b-5'),('ca131aa3-8',5,1,'WHITE','5683475e-a'),('ca416875-3',0,4,'BLACK','5683475e-a'),('ca4526d6-a',1,1,'WHITE','1aeb22cb-7'),('ca4e7556-b',6,1,'BLACK','1aeb22cb-7'),('ca616310-a',5,5,'BLACK','9d8cd894-a'),('cac5f9b3-1',4,6,'WHITE','5683475e-a'),('cb239d3e-6',0,3,'WHITE','f4d4c329-a'),('cc8f2950-0',7,4,'BLACK','ffabe598-9'),('ccc75452-6',5,7,'BLACK','ffabe598-9'),('cce1cf57-5',4,2,'WHITE','aaa69aff-f'),('ccf081a2-f',6,3,'WHITE','d6e73f1a-a'),('cd501a04-f',4,7,'WHITE','1aeb22cb-7'),('cd6386b4-b',0,3,'WHITE','aaa69aff-f'),('cdaf0a60-8',5,2,'BLACK','aaa69aff-f'),('cee1305c-2',NULL,NULL,'WHITE','1aeb22cb-7'),('cf7cb36c-8',2,5,'BLACK','1aeb22cb-7'),('d098cae9-8',3,2,'BLACK','1aeb22cb-7'),('d11b12f4-8',0,5,'BLACK','fe11b99b-5'),('d2671ab8-7',5,5,'BLACK','d6e73f1a-a'),('d3b1652b-6',6,6,'WHITE','5683475e-a'),('d3d0e332-8',0,3,'BLACK','ffabe598-9'),('d45d1f59-1',2,6,'BLACK','aaa69aff-f'),('d56e58d6-7',1,6,'WHITE','fe11b99b-5'),('d63e092e-d',5,6,'WHITE','1aeb22cb-7'),('d699f7e0-2',6,7,'WHITE','aaa69aff-f'),('d7070ca7-4',5,0,'BLACK','ffabe598-9'),('d7ce11ce-a',6,4,'WHITE','f4d4c329-a'),('d7e2d81a-0',0,1,'WHITE','f4d4c329-a'),('d844c4e8-2',6,7,'WHITE','fe11b99b-5'),('d8c22422-b',0,0,'BLACK','aaa69aff-f'),('d8cd5858-2',5,6,'WHITE','f4d4c329-a'),('d956352e-a',3,0,'BLACK','1aeb22cb-7'),('da9a8361-9',1,3,'WHITE','aaa69aff-f'),('db11721a-c',7,7,'BLACK','ffabe598-9'),('db6cc4de-0',7,3,'BLACK','aaa69aff-f'),('db71f331-d',4,0,'WHITE','ffabe598-9'),('dbb12be4-1',6,6,'WHITE','d6e73f1a-a'),('dc7e91c2-0',4,0,'BLACK','f4d4c329-a'),('dc973fc8-f',4,5,'WHITE','fe11b99b-5'),('dcd515bc-d',4,5,'BLACK','5683475e-a'),('dda88e06-b',7,1,'WHITE','5683475e-a'),('de06c3d5-4',4,1,'WHITE','fe11b99b-5'),('de6fc6ed-f',4,2,'WHITE','9d8cd894-a'),('de843c56-c',5,7,'WHITE','9d8cd894-a'),('df174c9d-8',1,6,'BLACK','1aeb22cb-7'),('df1da0cd-4',5,7,'WHITE','d6e73f1a-a'),('df8519c0-a',5,4,'BLACK','948228c7-8'),('e0db3d49-8',5,3,'WHITE','ffabe598-9'),('e0dc18ae-6',0,0,'WHITE','ffabe598-9'),('e1043a98-e',6,0,'BLACK','5683475e-a'),('e11a14e0-f',2,1,'BLACK','1aeb22cb-7'),('e11c5594-b',0,6,'WHITE','5683475e-a'),('e1345a66-4',2,7,'BLACK','1aeb22cb-7'),('e17f503d-5',3,7,'BLACK','fe11b99b-5'),('e1e40a62-d',4,2,'WHITE','f4d4c329-a'),('e3480c40-5',0,0,'BLACK','948228c7-8'),('e43a5d4a-9',0,5,'BLACK','9d8cd894-a'),('e44a488f-9',7,4,'BLACK','f4d4c329-a'),('e560cab8-7',7,6,'BLACK','ffabe598-9'),('e5d4361e-4',7,0,'BLACK','f4d4c329-a'),('e6adae2e-7',2,4,'BLACK','ffabe598-9'),('e6bf0727-8',3,0,'WHITE','f4d4c329-a'),('e70e6299-c',7,4,'WHITE','fe11b99b-5'),('e75150c9-4',3,2,'BLACK','fe11b99b-5'),('e7b392e4-6',4,5,'BLACK','aaa69aff-f'),('e8f46165-3',5,5,'WHITE','aaa69aff-f'),('e912b23f-a',3,5,'WHITE','ffabe598-9'),('e93d1a32-2',4,6,'WHITE','fe11b99b-5'),('e93d6739-b',7,6,'BLACK','fe11b99b-5'),('e9caea9d-2',7,0,'BLACK','aaa69aff-f'),('eaa2c310-d',4,6,'WHITE','d6e73f1a-a'),('eb61e84b-1',3,5,'BLACK','9d8cd894-a'),('eb6ad470-2',1,4,'WHITE','1aeb22cb-7'),('ee40e77f-1',6,3,'WHITE','fe11b99b-5'),('ee57a592-1',6,5,'WHITE','948228c7-8'),('ee6cadbc-2',5,7,'BLACK','948228c7-8'),('ef11e136-5',NULL,NULL,'WHITE','fe11b99b-5'),('efcb3bf9-7',1,1,'BLACK','9d8cd894-a'),('f02dd447-8',6,1,'BLACK','d6e73f1a-a'),('f0609b65-6',2,5,'BLACK','948228c7-8'),('f0869fc2-1',1,4,'WHITE','fe11b99b-5'),('f1a40f81-d',4,7,'BLACK','d6e73f1a-a'),('f2392dfe-2',0,0,'BLACK','d6e73f1a-a'),('f2e504ce-0',1,3,'WHITE','fe11b99b-5'),('f33d296e-b',2,7,'BLACK','f4d4c329-a'),('f3689a8d-e',0,4,'BLACK','aaa69aff-f'),('f4180e93-2',3,2,'WHITE','948228c7-8'),('f48185a1-1',1,4,'WHITE','5683475e-a'),('f51a73cb-e',5,7,'WHITE','5683475e-a'),('f5b6363c-7',3,5,'WHITE','aaa69aff-f'),('f5cdf552-f',5,4,'BLACK','f4d4c329-a'),('f6258927-8',7,5,'WHITE','aaa69aff-f'),('f66d3ca3-1',5,6,'BLACK','9d8cd894-a'),('f6bb93f7-3',3,5,'BLACK','1aeb22cb-7'),('f6c401d6-7',6,5,'BLACK','d6e73f1a-a'),('f6ef8b76-9',0,3,'WHITE','9d8cd894-a'),('f7db65e2-3',2,6,'BLACK','5683475e-a'),('f84d9e51-0',7,1,'WHITE','d6e73f1a-a'),('f90d5f8d-9',2,5,'BLACK','d6e73f1a-a'),('f917f37d-a',4,6,'BLACK','1aeb22cb-7'),('f9914663-5',2,0,'WHITE','1aeb22cb-7'),('f9a6b36c-5',4,0,'BLACK','d6e73f1a-a'),('f9ca7af1-7',7,6,'BLACK','f4d4c329-a'),('fb3b7c28-4',5,1,'WHITE','ffabe598-9'),('fb502c0c-2',7,5,'WHITE','ffabe598-9'),('fb84fe6a-a',0,1,'WHITE','fe11b99b-5'),('fbb6e41f-0',0,1,'WHITE','aaa69aff-f'),('fc39c7eb-5',2,6,'BLACK','948228c7-8'),('fc54a52e-4',3,0,'WHITE','948228c7-8'),('fc61319d-b',0,5,'BLACK','948228c7-8'),('fc71c62a-c',0,0,'WHITE','1aeb22cb-7'),('fcd69207-e',6,0,'WHITE','1aeb22cb-7'),('fcf68c3b-4',0,5,'BLACK','ffabe598-9'),('fd182a37-0',2,1,'WHITE','ffabe598-9'),('fd212287-0',5,0,'BLACK','9d8cd894-a'),('fd22943b-3',2,0,'BLACK','948228c7-8'),('fd529f80-2',3,1,'WHITE','9d8cd894-a'),('fea21a1b-b',7,2,'BLACK','5683475e-a'),('ffa419c0-3',5,6,'BLACK','aaa69aff-f'),('ffbf94c0-2',7,2,'BLACK','f4d4c329-a');
/*!40000 ALTER TABLE `move` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `round`
--

DROP TABLE IF EXISTS `round`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `round` (
  `id` varchar(10) NOT NULL,
  `roundNumber` int NOT NULL,
  `startDate` datetime NOT NULL,
  `endDate` datetime DEFAULT NULL,
  `tournamentId` varchar(10) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `tournamentId` (`tournamentId`),
  CONSTRAINT `round_ibfk_1` FOREIGN KEY (`tournamentId`) REFERENCES `tournament` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `round`
--

LOCK TABLES `round` WRITE;
/*!40000 ALTER TABLE `round` DISABLE KEYS */;
/*!40000 ALTER TABLE `round` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tournament`
--

DROP TABLE IF EXISTS `tournament`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tournament` (
  `id` varchar(10) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `createAt` datetime NOT NULL,
  `startDate` datetime NOT NULL,
  `endDate` datetime DEFAULT NULL,
  `maxParticipants` int NOT NULL,
  `currentParticipants` int NOT NULL,
  `rules` varchar(255) NOT NULL,
  `status` varchar(10) NOT NULL,
  `numberOfRound` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tournament`
--

LOCK TABLES `tournament` WRITE;
/*!40000 ALTER TABLE `tournament` DISABLE KEYS */;
/*!40000 ALTER TABLE `tournament` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tournamentparticipant`
--

DROP TABLE IF EXISTS `tournamentparticipant`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tournamentparticipant` (
  `id` varchar(10) NOT NULL,
  `registrationDate` datetime NOT NULL,
  `matchesPlayed` int NOT NULL,
  `tournamentId` varchar(10) NOT NULL,
  `userId` varchar(10) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `tournamentId` (`tournamentId`),
  KEY `userId` (`userId`),
  CONSTRAINT `tournamentparticipant_ibfk_1` FOREIGN KEY (`tournamentId`) REFERENCES `tournament` (`id`),
  CONSTRAINT `tournamentparticipant_ibfk_2` FOREIGN KEY (`userId`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tournamentparticipant`
--

LOCK TABLES `tournamentparticipant` WRITE;
/*!40000 ALTER TABLE `tournamentparticipant` DISABLE KEYS */;
/*!40000 ALTER TABLE `tournamentparticipant` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id` varchar(10) NOT NULL,
  `userName` varchar(50) NOT NULL,
  `passWord` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `role` varchar(10) NOT NULL,
  `isActive` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES ('4ab3de23-0','nam_le','123','le@gmail.com','PLAYER',1),('ADMIN01','admin','admin','admin@gmail.com','admin',1),('USER01','nam','123','nam@gmail.com','user',1);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-05-16 22:33:43
