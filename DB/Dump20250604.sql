-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: localhost    Database: db_othello
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
INSERT INTO `aimodel` VALUES ('AIMODEL01','easy model','This is a model for easy match','EASY','2025-05-26 00:00:00','2025-05-26 00:00:00','http://localhost:8001'),('AIMODEL02','hard model','This is a model for hard match','HARD','2025-05-26 00:00:00','2025-05-26 00:00:00','http://localhost:8000');
/*!40000 ALTER TABLE `aimodel` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `aimove`
--

DROP TABLE IF EXISTS `aimove`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `aimove` (
  `id` varchar(10) NOT NULL,
  `positionX` int DEFAULT NULL,
  `positionY` int DEFAULT NULL,
  `aiParticipantId` varchar(10) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `aiParticipantId` (`aiParticipantId`),
  CONSTRAINT `aimove_ibfk_1` FOREIGN KEY (`aiParticipantId`) REFERENCES `aiparticipant` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aimove`
--

LOCK TABLES `aimove` WRITE;
/*!40000 ALTER TABLE `aimove` DISABLE KEYS */;
INSERT INTO `aimove` VALUES ('0f02c045-0',0,1,'f860f5b5-f'),('0f963b13-f',1,3,'905243e0-5'),('10692abc-c',NULL,NULL,'905243e0-5'),('133d5b23-d',0,6,'5bcb0c98-7'),('1657c558-6',NULL,NULL,'5bcb0c98-7'),('16c30fe6-2',6,0,'905243e0-5'),('202c1bcb-c',2,6,'f860f5b5-f'),('23b970b6-b',1,1,'8e31e11e-d'),('278f4ed1-c',6,1,'905243e0-5'),('2798f75b-d',0,2,'905243e0-5'),('2c0deb5e-7',6,6,'905243e0-5'),('2d2404c6-f',0,0,'905243e0-5'),('33f1b250-4',1,0,'f860f5b5-f'),('3899e2a6-2',0,6,'905243e0-5'),('3929f5e5-7',5,2,'5bcb0c98-7'),('3c1aaf55-d',2,4,'905243e0-5'),('3c553b63-1',5,0,'f860f5b5-f'),('3c8e58d0-1',3,1,'905243e0-5'),('3d3e9ca1-b',3,6,'905243e0-5'),('4015fe7f-7',1,2,'905243e0-5'),('428caba3-0',4,0,'905243e0-5'),('43656781-5',6,1,'f860f5b5-f'),('44538af3-4',0,4,'8e31e11e-d'),('450415c0-b',2,4,'8e31e11e-d'),('466263c1-c',2,4,'e87b0de9-c'),('4cc094ac-0',3,7,'f860f5b5-f'),('523da0a1-d',1,1,'905243e0-5'),('524eae3d-7',6,7,'f860f5b5-f'),('52a1ff0e-b',4,6,'905243e0-5'),('56443867-4',NULL,NULL,'905243e0-5'),('5775de12-e',1,5,'f860f5b5-f'),('57baf2d5-b',1,2,'f860f5b5-f'),('5a6e5246-6',1,0,'5bcb0c98-7'),('5caba5dd-2',6,4,'905243e0-5'),('63b6700a-a',2,4,'f860f5b5-f'),('6464ba92-d',6,5,'905243e0-5'),('656daf87-1',5,1,'905243e0-5'),('66f63d77-3',4,1,'5bcb0c98-7'),('68336c62-2',1,7,'f860f5b5-f'),('68eb40da-5',1,5,'5bcb0c98-7'),('6a33d32e-f',4,2,'f860f5b5-f'),('6e6b45f6-e',2,4,'01c92b79-a'),('6eaa9975-a',NULL,NULL,'5bcb0c98-7'),('6f520137-0',1,2,'8e31e11e-d'),('72f44cd6-f',0,4,'905243e0-5'),('7481f4ff-1',7,3,'f860f5b5-f'),('761acdc2-a',99999,99999,'f860f5b5-f'),('77ba0ea4-0',2,0,'905243e0-5'),('7a77080b-f',5,6,'905243e0-5'),('7aa2f4a1-4',0,2,'8e31e11e-d'),('7b33993a-7',2,1,'5bcb0c98-7'),('7d4ea9d7-d',1,3,'8e31e11e-d'),('7e925211-6',NULL,NULL,'5bcb0c98-7'),('7f1843bb-e',4,2,'905243e0-5'),('7fbd2a8b-c',0,4,'f860f5b5-f'),('85c66ffe-5',4,2,'8e31e11e-d'),('8cea7364-7',6,2,'905243e0-5'),('8e223bb4-5',5,4,'905243e0-5'),('95717e86-0',4,2,'5bcb0c98-7'),('96be9b3d-3',2,2,'01c92b79-a'),('96dbbb0f-2',5,3,'5bcb0c98-7'),('99b41417-a',2,4,'5bcb0c98-7'),('a174e6d8-d',0,0,'8e31e11e-d'),('a3f6d9d4-f',NULL,NULL,'905243e0-5'),('a42f86e2-1',5,4,'f860f5b5-f'),('a9676e9e-9',4,0,'5bcb0c98-7'),('b178dc85-4',3,6,'f860f5b5-f'),('b439e7df-9',0,3,'5bcb0c98-7'),('b6cf1176-6',4,5,'8e31e11e-d'),('b7e1566c-9',1,7,'905243e0-5'),('bafefe21-4',1,4,'f860f5b5-f'),('bc7605ca-b',6,6,'f860f5b5-f'),('bfb0fdf7-d',NULL,NULL,'5bcb0c98-7'),('c00b916e-e',5,6,'f860f5b5-f'),('c2bb2553-6',3,0,'f860f5b5-f'),('ca6935a3-9',1,6,'5bcb0c98-7'),('ca8ffff2-c',6,4,'f860f5b5-f'),('caeaebc6-f',0,1,'5bcb0c98-7'),('cb06bfff-d',1,1,'5bcb0c98-7'),('cc7327c1-d',5,5,'5bcb0c98-7'),('cd604417-c',1,4,'905243e0-5'),('cee752a1-c',2,6,'905243e0-5'),('d0522f06-c',6,7,'905243e0-5'),('d1d499ae-9',99999,99999,'905243e0-5'),('d5f5bd41-d',6,3,'f860f5b5-f'),('d634a0c4-d',3,1,'f860f5b5-f'),('db7eb41f-0',1,1,'f860f5b5-f'),('de83aec4-3',1,6,'8e31e11e-d'),('e0ef2aa8-e',99999,99999,'5bcb0c98-7'),('e3299bfa-7',3,6,'5bcb0c98-7'),('e4a90347-7',NULL,NULL,'f860f5b5-f'),('e6d0b785-2',1,5,'905243e0-5'),('ea0ca5b3-0',NULL,NULL,'f860f5b5-f'),('ea165284-2',1,7,'5bcb0c98-7'),('ec4cce0c-b',3,7,'5bcb0c98-7'),('ed533ede-e',1,3,'f860f5b5-f'),('edeca96f-e',1,6,'f860f5b5-f'),('eefa4dfc-c',3,5,'5bcb0c98-7'),('f248e18b-4',1,3,'5bcb0c98-7'),('f25c0361-d',4,2,'01c92b79-a'),('f39a61d6-5',4,5,'905243e0-5'),('f4119b80-4',4,5,'f860f5b5-f'),('f52f64aa-4',5,1,'f860f5b5-f'),('f73dcccb-0',6,3,'905243e0-5'),('fa2181bb-c',NULL,NULL,'f860f5b5-f'),('fc4104fd-6',7,1,'f860f5b5-f'),('fef961d3-b',NULL,NULL,'5bcb0c98-7');
/*!40000 ALTER TABLE `aimove` ENABLE KEYS */;
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
INSERT INTO `aiparticipant` VALUES ('01c92b79-a',NULL,'WHITE','AIMODEL02'),('1','LOSE','WHITE','AIMODEL02'),('10','LOSE','WHITE','AIMODEL01'),('11','LOSE','WHITE','AIMODEL01'),('12','LOSE','WHITE','AIMODEL01'),('13','LOSE','WHITE','AIMODEL01'),('14','LOSE','WHITE','AIMODEL01'),('15','LOSE','WHITE','AIMODEL01'),('16','LOSE','WHITE','AIMODEL01'),('17','LOSE','WHITE','AIMODEL01'),('2','LOSE','WHITE','AIMODEL02'),('3','LOSE','WHITE','AIMODEL02'),('3ef0fc91-9',NULL,'WHITE','AIMODEL02'),('4','LOSE','WHITE','AIMODEL02'),('5','LOSE','WHITE','AIMODEL02'),('5bcb0c98-7','LOSE','WHITE','AIMODEL02'),('6','LOSE','WHITE','AIMODEL01'),('7','LOSE','WHITE','AIMODEL01'),('8','LOSE','WHITE','AIMODEL01'),('8e31e11e-d','WIN','WHITE','AIMODEL02'),('9','LOSE','WHITE','AIMODEL01'),('905243e0-5','WIN','WHITE','AIMODEL02'),('e87b0de9-c','WIN','WHITE','AIMODEL02'),('f860f5b5-f','LOSE','WHITE','AIMODEL02');
/*!40000 ALTER TABLE `aiparticipant` ENABLE KEYS */;
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
  `aiParticipantId` varchar(10) DEFAULT NULL,
  `gameParticipantId` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `aiParticipantId` (`aiParticipantId`),
  KEY `gameParticipantId` (`gameParticipantId`),
  CONSTRAINT `game_ibfk_1` FOREIGN KEY (`aiParticipantId`) REFERENCES `aiparticipant` (`id`),
  CONSTRAINT `game_ibfk_2` FOREIGN KEY (`gameParticipantId`) REFERENCES `gameparticipant` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `game`
--

LOCK TABLES `game` WRITE;
/*!40000 ALTER TABLE `game` DISABLE KEYS */;
INSERT INTO `game` VALUES ('00f4e775-8','2025-05-30 17:47:48',NULL,3,3,'PvE_HARD','e87b0de9-c','522b6842-4'),('0b217712-0','2025-05-26 01:54:51','2025-05-26 01:58:44',47,0,'PvE_HARD','5bcb0c98-7','d81ce1e8-a'),('1','2025-05-26 00:00:00','2025-05-26 00:00:00',44,20,'PvE_HARD','1','1'),('10','2025-05-20 00:00:00','2025-05-20 00:00:00',44,20,'PvE_EASY','10','10'),('11','2025-05-20 00:00:00','2025-05-20 00:00:00',44,20,'PvE_EASY','11','11'),('12','2025-05-26 00:00:00','2025-05-26 00:00:00',44,20,'PvE_EASY','12','12'),('13','2025-05-26 00:00:00','2025-05-26 00:00:00',44,20,'PvE_EASY','13','13'),('14','2025-05-26 00:00:00','2025-05-26 00:00:00',44,20,'PvE_EASY','14','14'),('15','2025-03-20 00:00:00','2025-03-20 00:00:00',44,20,'PvE_EASY','15','15'),('16','2025-03-20 00:00:00','2025-03-20 00:00:00',44,20,'PvE_EASY','16','16'),('17','2025-03-20 00:00:00','2025-03-20 00:00:00',44,20,'PvE_EASY','17','17'),('2','2025-05-26 00:00:00','2025-05-26 00:00:00',44,20,'PvE_HARD','2','2'),('20623aa2-a','2025-05-27 09:40:09',NULL,2,2,'PvE_HARD','01c92b79-a','6ee2de69-f'),('3','2025-05-26 00:00:00','2025-05-26 00:00:00',44,20,'PvE_HARD','3','3'),('4','2025-05-20 00:00:00','2025-05-20 00:00:00',44,20,'PvE_HARD','4','4'),('5','2025-05-20 00:00:00','2025-05-20 00:00:00',44,20,'PvE_HARD','5','5'),('557b3170-2','2025-05-26 02:07:16','2025-05-26 02:11:20',60,3,'PvE_HARD','f860f5b5-f','6ff2c760-d'),('6','2025-05-20 00:00:00','2025-05-20 00:00:00',44,20,'PvE_EASY','6','6'),('65784c60-6','2025-05-26 01:51:08','2025-05-26 01:54:47',14,49,'PvE_HARD','905243e0-5','f1c618f0-2'),('7','2025-05-20 00:00:00','2025-05-20 00:00:00',44,20,'PvE_EASY','7','7'),('8','2025-05-20 00:00:00','2025-05-20 00:00:00',44,20,'PvE_EASY','8','8'),('9','2025-05-20 00:00:00','2025-05-20 00:00:00',44,20,'PvE_EASY','9','9'),('dab5c457-c','2025-05-30 17:47:26',NULL,2,2,'PvE_HARD','3ef0fc91-9','f93a3a9c-3'),('fc9a0130-1','2025-05-30 16:33:05',NULL,15,9,'PvE_HARD','8e31e11e-d','228d05ec-c');
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
  `userId` varchar(10) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `userId` (`userId`),
  CONSTRAINT `gameparticipant_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gameparticipant`
--

LOCK TABLES `gameparticipant` WRITE;
/*!40000 ALTER TABLE `gameparticipant` DISABLE KEYS */;
INSERT INTO `gameparticipant` VALUES ('1','WIN','BLACK','USER01'),('10','WIN','BLACK','USER01'),('11','WIN','BLACK','USER01'),('12','WIN','BLACK','USER01'),('13','WIN','BLACK','USER01'),('14','WIN','BLACK','USER01'),('15','WIN','BLACK','USER01'),('16','WIN','BLACK','USER01'),('17','WIN','BLACK','USER01'),('2','WIN','BLACK','USER01'),('228d05ec-c','LOSE','BLACK','USER01'),('3','WIN','BLACK','ADMIN01'),('4','WIN','BLACK','ADMIN01'),('5','WIN','BLACK','ADMIN01'),('522b6842-4','LOSE','BLACK','USER01'),('6','WIN','BLACK','ADMIN01'),('6ee2de69-f',NULL,'BLACK','USER01'),('6ff2c760-d','WIN','BLACK','USER01'),('7','WIN','BLACK','ADMIN01'),('8','WIN','BLACK','ADMIN01'),('9','WIN','BLACK','USER01'),('d81ce1e8-a','WIN','BLACK','USER01'),('f1c618f0-2','LOSE','BLACK','USER01'),('f93a3a9c-3',NULL,'BLACK','USER01');
/*!40000 ALTER TABLE `gameparticipant` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `playermove`
--

DROP TABLE IF EXISTS `playermove`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `playermove` (
  `id` varchar(10) NOT NULL,
  `positionX` int DEFAULT NULL,
  `positionY` int DEFAULT NULL,
  `gameParticipantId` varchar(10) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `gameParticipantId` (`gameParticipantId`),
  CONSTRAINT `playermove_ibfk_1` FOREIGN KEY (`gameParticipantId`) REFERENCES `gameparticipant` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `playermove`
--

LOCK TABLES `playermove` WRITE;
/*!40000 ALTER TABLE `playermove` DISABLE KEYS */;
INSERT INTO `playermove` VALUES ('020bde84-3',6,0,'6ff2c760-d'),('020cdcce-5',5,3,'f1c618f0-2'),('0394247b-b',2,3,'f1c618f0-2'),('05549426-0',NULL,NULL,'f1c618f0-2'),('06108b9a-1',NULL,NULL,'6ff2c760-d'),('0a40da49-f',3,5,'f1c618f0-2'),('0a919dc8-2',5,7,'6ff2c760-d'),('11b85119-f',NULL,NULL,'f1c618f0-2'),('1428aa6e-2',5,2,'f1c618f0-2'),('18740782-9',0,5,'d81ce1e8-a'),('1b14e7a0-0',NULL,NULL,'f1c618f0-2'),('2336ab22-b',3,0,'f1c618f0-2'),('24a7ff0f-f',7,4,'f1c618f0-2'),('2563c94c-f',0,7,'6ff2c760-d'),('26217aa5-8',7,5,'f1c618f0-2'),('297fd7c2-9',NULL,NULL,'d81ce1e8-a'),('2b16c4da-f',2,6,'d81ce1e8-a'),('2d7a6417-0',2,7,'6ff2c760-d'),('32f5a0ed-c',NULL,NULL,'d81ce1e8-a'),('34494b11-f',2,2,'d81ce1e8-a'),('347ede64-c',4,1,'6ff2c760-d'),('39dc28ae-2',7,6,'6ff2c760-d'),('3c7f5677-2',7,7,'f1c618f0-2'),('3d4f1187-3',NULL,NULL,'6ff2c760-d'),('3fdef731-6',0,7,'f1c618f0-2'),('4182319b-e',4,6,'6ff2c760-d'),('446e4ee2-8',5,5,'6ff2c760-d'),('4d60315e-7',0,2,'6ff2c760-d'),('4d7ac13c-f',2,2,'6ff2c760-d'),('550b8dcf-d',3,5,'228d05ec-c'),('5a564162-7',7,2,'6ff2c760-d'),('5f6760f9-5',1,0,'f1c618f0-2'),('618a4b1c-8',2,5,'6ee2de69-f'),('657ca3f6-c',3,5,'6ff2c760-d'),('66831839-4',4,7,'f1c618f0-2'),('676b3e7a-c',4,7,'d81ce1e8-a'),('67b8bb0e-e',2,3,'6ee2de69-f'),('6c18e76e-2',6,5,'6ff2c760-d'),('7057c2d4-c',0,2,'d81ce1e8-a'),('70bff439-3',0,0,'6ff2c760-d'),('71549085-0',1,4,'d81ce1e8-a'),('71b58260-e',5,6,'d81ce1e8-a'),('7369e9bc-c',2,3,'228d05ec-c'),('73b683cb-e',6,2,'d81ce1e8-a'),('741a03e2-4',0,1,'f1c618f0-2'),('749b9905-8',4,5,'d81ce1e8-a'),('756fa536-c',1,2,'d81ce1e8-a'),('77d8cbef-1',2,1,'f1c618f0-2'),('7881028a-f',4,7,'6ff2c760-d'),('79bcb2a1-c',2,0,'6ff2c760-d'),('7b332d38-3',2,7,'d81ce1e8-a'),('7f422605-e',5,0,'d81ce1e8-a'),('854d01fb-8',3,0,'d81ce1e8-a'),('8736ecb5-a',2,5,'6ff2c760-d'),('8a416bcc-5',5,3,'6ff2c760-d'),('8c9345ab-7',1,0,'228d05ec-c'),('8e012ba0-0',2,7,'f1c618f0-2'),('8f64cbf4-c',5,2,'6ff2c760-d'),('99b3c477-1',3,2,'f1c618f0-2'),('9b240c3c-8',4,0,'6ff2c760-d'),('9bffd8ca-f',3,2,'6ff2c760-d'),('9c3897d1-9',5,0,'f1c618f0-2'),('a273c309-8',2,0,'d81ce1e8-a'),('a3999bc3-5',NULL,NULL,'f1c618f0-2'),('a49537e9-8',3,1,'d81ce1e8-a'),('a55a7ddc-6',4,1,'f1c618f0-2'),('abb98ee3-9',2,3,'522b6842-4'),('ad87dc9a-c',2,2,'f1c618f0-2'),('b48219f6-7',1,6,'f1c618f0-2'),('b4a80925-8',2,5,'228d05ec-c'),('b7166543-5',0,3,'6ff2c760-d'),('b7d9a7d8-1',7,5,'6ff2c760-d'),('b93f5a3d-c',7,0,'6ff2c760-d'),('ba77580b-c',3,2,'d81ce1e8-a'),('bd808464-a',7,4,'6ff2c760-d'),('c1a5efe2-2',2,3,'6ff2c760-d'),('c34b7ccb-0',0,5,'6ff2c760-d'),('c3d12ec8-c',5,5,'228d05ec-c'),('c603c0b1-c',0,1,'228d05ec-c'),('c757dca5-f',0,3,'f1c618f0-2'),('c766f908-3',5,4,'d81ce1e8-a'),('c78355e5-1',0,5,'f1c618f0-2'),('c91ffcbb-3',7,7,'6ff2c760-d'),('ca6a4239-3',5,7,'f1c618f0-2'),('ca99dac9-c',0,7,'d81ce1e8-a'),('cafd85c8-a',0,7,'228d05ec-c'),('cfecd29c-b',5,5,'f1c618f0-2'),('d12d318a-2',NULL,NULL,'f1c618f0-2'),('d74b18f9-d',5,2,'6ee2de69-f'),('daed8a1d-3',7,2,'f1c618f0-2'),('e29224ca-8',7,3,'f1c618f0-2'),('e3a879de-9',2,5,'f1c618f0-2'),('e4df92b8-9',0,6,'6ff2c760-d'),('e61d2224-4',3,7,'f1c618f0-2'),('e62a2932-a',2,3,'d81ce1e8-a'),('e66e7263-3',0,4,'d81ce1e8-a'),('e9b400a1-e',7,0,'f1c618f0-2'),('e9dc81df-b',NULL,NULL,'d81ce1e8-a'),('edb41a07-3',NULL,NULL,'6ff2c760-d'),('efbe59d5-8',0,0,'d81ce1e8-a'),('f074880d-a',5,4,'228d05ec-c'),('f08f1df9-3',2,1,'6ff2c760-d'),('f334ff45-7',2,5,'d81ce1e8-a'),('f59b30f0-8',1,4,'228d05ec-c'),('f778f340-0',7,1,'f1c618f0-2'),('f8e54e67-f',5,1,'d81ce1e8-a'),('fe40b94b-5',0,3,'228d05ec-c');
/*!40000 ALTER TABLE `playermove` ENABLE KEYS */;
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
INSERT INTO `user` VALUES ('ADMIN01','admin','admin','admin@gmail.com','admin',1),('USER01','nam','123','nam@gmail.com','user',1);
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

-- Dump completed on 2025-06-04 23:07:33
