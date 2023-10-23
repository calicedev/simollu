-- MySQL dump 10.13  Distrib 8.0.31, for Win64 (x86_64)
--
-- Host: 43.200.152.213    Database: simollu
-- ------------------------------------------------------
-- Server version	8.0.31

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
-- Table structure for table `user_restaurant`
--

DROP TABLE IF EXISTS `user_restaurant`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_restaurant` (
  `user_restaurant_seq` bigint NOT NULL AUTO_INCREMENT,
  `restaurant_seq` bigint DEFAULT NULL,
  `user_seq` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`user_restaurant_seq`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_restaurant`
--

LOCK TABLES `user_restaurant` WRITE;
/*!40000 ALTER TABLE `user_restaurant` DISABLE KEYS */;
INSERT INTO `user_restaurant` VALUES (4,125,'2537e7bd-61db-49da-a4c8-d9ab360e05a6'),(6,126,'8a5e742f-01ca-4fd0-8e17-27d7ed2e3112'),(7,127,'8a5e742f-01ca-4fd0-8e17-27d7ed2e3112'),(9,124,'8a5e742f-01ca-4fd0-8e17-27d7ed2e3112'),(13,295,'6f3c0699-19ce-4dcd-ba40-21dcc3785c11'),(34,161,'6f3c0699-19ce-4dcd-ba40-21dcc3785c11'),(35,238,'6f3c0699-19ce-4dcd-ba40-21dcc3785c11'),(36,243,'6f3c0699-19ce-4dcd-ba40-21dcc3785c11'),(38,124,'2537e7bd-61db-49da-a4c8-d9ab360e05a6'),(40,4,'2537e7bd-61db-49da-a4c8-d9ab360e05a6');
/*!40000 ALTER TABLE `user_restaurant` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-05-19 10:55:56
