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
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-06-04 23:10:39
