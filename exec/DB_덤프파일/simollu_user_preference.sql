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
-- Table structure for table `user_preference`
--

DROP TABLE IF EXISTS `user_preference`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_preference` (
  `user_prefrence_seq` bigint NOT NULL AUTO_INCREMENT,
  `user_preference_type` varchar(255) DEFAULT NULL,
  `user_seq` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`user_prefrence_seq`)
) ENGINE=InnoDB AUTO_INCREMENT=170 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_preference`
--

LOCK TABLES `user_preference` WRITE;
/*!40000 ALTER TABLE `user_preference` DISABLE KEYS */;
INSERT INTO `user_preference` VALUES (65,'독서','2b804e99-1a97-4c94-a63d-21bdbbc0d91a'),(66,'휴식','2b804e99-1a97-4c94-a63d-21bdbbc0d91a'),(67,'사진','2b804e99-1a97-4c94-a63d-21bdbbc0d91a'),(71,'오락&게임','9b5be44a-3ddf-4d09-9479-0aea43da907f'),(72,'노래','9b5be44a-3ddf-4d09-9479-0aea43da907f'),(73,'걷기','9b5be44a-3ddf-4d09-9479-0aea43da907f'),(77,'독서','9030f201-c3a3-4ff9-a411-2359392b65e0'),(78,'걷기','9030f201-c3a3-4ff9-a411-2359392b65e0'),(79,'휴식','9030f201-c3a3-4ff9-a411-2359392b65e0'),(86,'독서','8a5e742f-01ca-4fd0-8e17-27d7ed2e3112'),(87,'음악','8a5e742f-01ca-4fd0-8e17-27d7ed2e3112'),(88,'사진','8a5e742f-01ca-4fd0-8e17-27d7ed2e3112'),(89,'노래','8a5e742f-01ca-4fd0-8e17-27d7ed2e3112'),(129,'독서','7f4da6a4-cc59-4eef-a9ab-ce91f88ad82e'),(130,'음악','7f4da6a4-cc59-4eef-a9ab-ce91f88ad82e'),(131,'사진','7f4da6a4-cc59-4eef-a9ab-ce91f88ad82e'),(155,'오락&게임','2537e7bd-61db-49da-a4c8-d9ab360e05a6'),(156,'노래','2537e7bd-61db-49da-a4c8-d9ab360e05a6'),(157,'독서','2537e7bd-61db-49da-a4c8-d9ab360e05a6'),(158,'독서','43ccce9b-7210-4c7c-a43b-ded38a1fd1b5'),(159,'걷기','43ccce9b-7210-4c7c-a43b-ded38a1fd1b5'),(160,'사진','43ccce9b-7210-4c7c-a43b-ded38a1fd1b5'),(161,'쇼핑','43ccce9b-7210-4c7c-a43b-ded38a1fd1b5'),(162,'휴식','43ccce9b-7210-4c7c-a43b-ded38a1fd1b5'),(163,'오락&게임','43ccce9b-7210-4c7c-a43b-ded38a1fd1b5'),(167,'사진','6f3c0699-19ce-4dcd-ba40-21dcc3785c11'),(168,'쇼핑','6f3c0699-19ce-4dcd-ba40-21dcc3785c11'),(169,'오락&게임','6f3c0699-19ce-4dcd-ba40-21dcc3785c11');
/*!40000 ALTER TABLE `user_preference` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-05-19 10:55:58
