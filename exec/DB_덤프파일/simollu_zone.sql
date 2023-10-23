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
-- Table structure for table `zone`
--

DROP TABLE IF EXISTS `zone`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `zone` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `main_zone` varchar(255) DEFAULT NULL,
  `sub_zone` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zone`
--

LOCK TABLES `zone` WRITE;
/*!40000 ALTER TABLE `zone` DISABLE KEYS */;
INSERT INTO `zone` VALUES (1,'경기도','안양시'),(2,'경기도','안양시'),(3,'경기도','안양시'),(4,'경기도','안양시'),(5,'경기도','안양시'),(6,'경기도','안양시'),(7,'경기도','안양시'),(8,'경기도','안양시'),(9,'경기도','안양시'),(10,'경기도','안양시'),(11,'경기도','안양시'),(12,'경기도','안양시'),(13,'경기도','안양시'),(14,'경기도','안양시'),(15,'경기도','안양시'),(16,'경기도','안양시'),(17,'경기도','안양시'),(18,'경기도','안양시'),(19,'경기도','안양시'),(20,'경기도','안양시'),(21,'경기도','안양시'),(22,'경기도','안양시'),(23,'경기도','안양시'),(24,'경기도','안양시'),(25,'경기도','안양시'),(26,'경기도','안양시'),(27,'경기도','안양시'),(28,'경기도','안양시'),(29,'경기도','안양시'),(30,'경기도','안양시'),(31,'경기도','안양시'),(32,'경기도','안양시'),(33,'경기도','안양시'),(34,'경기도','안양시'),(35,'경기도','안양시'),(36,'경기도','안양시'),(37,'경기도','안양시'),(38,'경기도','안양시'),(39,'경기도','안양시'),(40,'경기도','안양시'),(41,'경기도','안양시'),(42,'경기도','안양시'),(43,'경기도','안양시'),(44,'경기도','안양시'),(45,'경기도','안양시'),(46,'경기도','안양시'),(47,'경기도','안양시'),(48,'경기도','안양시'),(49,'경기도','안양시'),(50,'경기도','안양시'),(51,'경기도','안양시'),(52,'경기도','안양시'),(53,'경기도','안양시'),(54,'경기도','안양시'),(55,'경기도','안양시'),(56,'경기도','안양시'),(57,'경기도','안양시');
/*!40000 ALTER TABLE `zone` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-05-19 10:56:00
