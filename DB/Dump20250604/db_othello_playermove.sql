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
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-06-04 23:10:39
