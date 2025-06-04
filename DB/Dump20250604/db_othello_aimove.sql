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
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-06-04 23:10:38
