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
-- Table structure for table `user_profile`
--

DROP TABLE IF EXISTS `user_profile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_profile` (
  `user_profile_seq` bigint NOT NULL AUTO_INCREMENT,
  `user_profile_register_date` datetime(6) DEFAULT NULL,
  `user_profile_url` varchar(255) DEFAULT NULL,
  `user_seq` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`user_profile_seq`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_profile`
--

LOCK TABLES `user_profile` WRITE;
/*!40000 ALTER TABLE `user_profile` DISABLE KEYS */;
INSERT INTO `user_profile` VALUES (1,'2023-05-10 01:35:31.372596','http://k.kakaocdn.net/dn/dpk9l1/btqmGhA2lKL/Oz0wDuJn1YV2DIn92f6DVK/img_640x640.jpg','a186dfd5-5e55-4978-bbb3-ea7322577152'),(2,'2023-05-10 02:07:11.720214','http://k.kakaocdn.net/dn/dpk9l1/btqmGhA2lKL/Oz0wDuJn1YV2DIn92f6DVK/img_640x640.jpg','2b804e99-1a97-4c94-a63d-21bdbbc0d91a'),(3,'2023-05-10 02:14:20.094650','http://k.kakaocdn.net/dn/qoks2/btsbTpnTABa/t6e8wIHOXpdaJjISIEubb1/img_640x640.jpg','2537e7bd-61db-49da-a4c8-d9ab360e05a6'),(4,'2023-05-10 03:53:31.726770','http://k.kakaocdn.net/dn/dpk9l1/btqmGhA2lKL/Oz0wDuJn1YV2DIn92f6DVK/img_640x640.jpg','43ccce9b-7210-4c7c-a43b-ded38a1fd1b5'),(5,'2023-05-10 04:21:05.007602','http://k.kakaocdn.net/dn/dpk9l1/btqmGhA2lKL/Oz0wDuJn1YV2DIn92f6DVK/img_640x640.jpg','8a5e742f-01ca-4fd0-8e17-27d7ed2e3112'),(6,'2023-05-10 04:22:03.809537','http://k.kakaocdn.net/dn/dpk9l1/btqmGhA2lKL/Oz0wDuJn1YV2DIn92f6DVK/img_640x640.jpg','6f3c0699-19ce-4dcd-ba40-21dcc3785c11'),(7,'2023-05-11 00:22:44.339790','http://k.kakaocdn.net/dn/dpk9l1/btqmGhA2lKL/Oz0wDuJn1YV2DIn92f6DVK/img_640x640.jpg','9b5be44a-3ddf-4d09-9479-0aea43da907f'),(8,'2023-05-11 00:59:14.047649','http://k.kakaocdn.net/dn/dpk9l1/btqmGhA2lKL/Oz0wDuJn1YV2DIn92f6DVK/img_640x640.jpg','9030f201-c3a3-4ff9-a411-2359392b65e0'),(9,'2023-05-15 07:29:31.488762','http://k.kakaocdn.net/dn/dpk9l1/btqmGhA2lKL/Oz0wDuJn1YV2DIn92f6DVK/img_640x640.jpg','7f4da6a4-cc59-4eef-a9ab-ce91f88ad82e'),(10,'2023-05-15 22:56:40.784728','profile/Golde33443.jpg','2537e7bd-61db-49da-a4c8-d9ab360e05a6'),(11,'2023-05-15 22:58:48.710894','profile/Golde33443.jpg','9030f201-c3a3-4ff9-a411-2359392b65e0'),(12,'2023-05-16 06:17:26.425079','profile/29939e22-ace8-4bb9-98ba-10686e8c9ed8.jpg','8a5e742f-01ca-4fd0-8e17-27d7ed2e3112'),(13,'2023-05-16 06:31:24.227503','profile/profile','6f3c0699-19ce-4dcd-ba40-21dcc3785c11'),(14,'2023-05-16 06:37:18.954279','profile/cat-7762887_960_720.jpg','6f3c0699-19ce-4dcd-ba40-21dcc3785c11'),(15,'2023-05-16 06:51:19.415239','profile/111500268.2.jpg','6f3c0699-19ce-4dcd-ba40-21dcc3785c11'),(16,'2023-05-16 07:30:34.220622','profile/111500268.2.jpg','6f3c0699-19ce-4dcd-ba40-21dcc3785c11'),(17,'2023-05-16 07:32:05.051562','profile/111500268.2.jpg','6f3c0699-19ce-4dcd-ba40-21dcc3785c11'),(18,'2023-05-16 07:33:05.808322','profile/Golde33443.jpg','6f3c0699-19ce-4dcd-ba40-21dcc3785c11'),(19,'2023-05-16 08:02:04.540975','profile/111500268.2.jpg','6f3c0699-19ce-4dcd-ba40-21dcc3785c11');
/*!40000 ALTER TABLE `user_profile` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-05-19 10:55:57
