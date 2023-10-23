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
-- Table structure for table `waiting`
--

DROP TABLE IF EXISTS `waiting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `waiting` (
  `waiting_seq` int NOT NULL AUTO_INCREMENT,
  `restaurant_name` varchar(20) NOT NULL,
  `restaurant_seq` int NOT NULL,
  `user_seq` varchar(255) NOT NULL,
  `waiting_no` int NOT NULL,
  `waiting_person_cnt` int NOT NULL,
  PRIMARY KEY (`waiting_seq`)
) ENGINE=InnoDB AUTO_INCREMENT=206 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `waiting`
--

LOCK TABLES `waiting` WRITE;
/*!40000 ALTER TABLE `waiting` DISABLE KEYS */;
INSERT INTO `waiting` VALUES (101,'동래정 선릉직영점',124,'6f3c0699-19ce-4dcd-ba40-21dcc3785c11',1,0),(102,'동래정 선릉직영점',124,'6f3c0699-19ce-4dcd-ba40-21dcc3785c11',2,0),(103,'동래정 선릉직영점',124,'7f4da6a4-cc59-4eef-a9ab-ce91f88ad82e',3,5),(104,'동래정 선릉직영점',124,'6f3c0699-19ce-4dcd-ba40-21dcc3785c11',4,2),(105,'동래정 선릉직영점',124,'6f3c0699-19ce-4dcd-ba40-21dcc3785c11',4,2),(106,'동래정 선릉직영점',124,'6f3c0699-19ce-4dcd-ba40-21dcc3785c11',4,2),(107,'동래정 선릉직영점',124,'6f3c0699-19ce-4dcd-ba40-21dcc3785c11',4,2),(108,'동래정 선릉직영점',124,'6f3c0699-19ce-4dcd-ba40-21dcc3785c11',4,2),(109,'동래정 선릉직영점',124,'6f3c0699-19ce-4dcd-ba40-21dcc3785c11',7,0),(110,'동래정 선릉직영점',124,'43ccce9b-7210-4c7c-a43b-ded38a1fd1b5',5,1),(111,'동래정 선릉직영점',124,'7f4da6a4-cc59-4eef-a9ab-ce91f88ad82e',6,4),(112,'동래정 선릉직영점',124,'6f3c0699-19ce-4dcd-ba40-21dcc3785c11',7,1),(113,'동래정 선릉직영점',124,'6f3c0699-19ce-4dcd-ba40-21dcc3785c11',7,2),(114,'야키토리 나루토 강남',66,'6f3c0699-19ce-4dcd-ba40-21dcc3785c11',1,1),(115,'동래정 선릉직영점',124,'43ccce9b-7210-4c7c-a43b-ded38a1fd1b5',8,0),(116,'동래정 선릉직영점',124,'43ccce9b-7210-4c7c-a43b-ded38a1fd1b5',9,0),(117,'동래정 선릉직영점',124,'43ccce9b-7210-4c7c-a43b-ded38a1fd1b5',10,0),(118,'동래정 선릉직영점',124,'7f4da6a4-cc59-4eef-a9ab-ce91f88ad82e',11,6),(119,'갓덴스시 강남점',42,'9030f201-c3a3-4ff9-a411-2359392b65e0',1,0),(120,'야키토리 나루토 강남',66,'6f3c0699-19ce-4dcd-ba40-21dcc3785c11',2,1),(121,'바스버거 역삼점',161,'6f3c0699-19ce-4dcd-ba40-21dcc3785c11',1,1),(122,'바스버거 역삼점',161,'6f3c0699-19ce-4dcd-ba40-21dcc3785c11',2,1),(123,'야키토리 나루토 강남',66,'6f3c0699-19ce-4dcd-ba40-21dcc3785c11',3,1),(124,'야키토리 나루토 강남',66,'6f3c0699-19ce-4dcd-ba40-21dcc3785c11',4,1),(125,'야키토리 나루토 강남',66,'6f3c0699-19ce-4dcd-ba40-21dcc3785c11',5,1),(126,'동래정 선릉직영점',124,'6f3c0699-19ce-4dcd-ba40-21dcc3785c11',12,1),(127,'바스버거 역삼점',161,'6f3c0699-19ce-4dcd-ba40-21dcc3785c11',3,1),(128,'동래정 선릉직영점',124,'6f3c0699-19ce-4dcd-ba40-21dcc3785c11',12,1),(129,'바스버거 역삼점',161,'6f3c0699-19ce-4dcd-ba40-21dcc3785c11',4,1),(130,'갓덴스시 강남점',42,'6f3c0699-19ce-4dcd-ba40-21dcc3785c11',2,1),(131,'동래정 선릉직영점',124,'6f3c0699-19ce-4dcd-ba40-21dcc3785c11',12,1),(132,'동래정 선릉직영점',124,'6f3c0699-19ce-4dcd-ba40-21dcc3785c11',13,0),(133,'동래정 선릉직영점',124,'6f3c0699-19ce-4dcd-ba40-21dcc3785c11',12,1),(134,'동래정 선릉직영점',124,'6f3c0699-19ce-4dcd-ba40-21dcc3785c11',13,1),(135,'동래정 선릉직영점',124,'2537e7bd-61db-49da-a4c8-d9ab360e05a6',14,1),(136,'동래정 선릉직영점',124,'6f3c0699-19ce-4dcd-ba40-21dcc3785c11',15,1),(137,'동래정 선릉직영점',124,'2537e7bd-61db-49da-a4c8-d9ab360e05a6',16,1),(138,'동래정 선릉직영점',124,'6f3c0699-19ce-4dcd-ba40-21dcc3785c11',17,1),(139,'동래정 선릉직영점',124,'6f3c0699-19ce-4dcd-ba40-21dcc3785c11',17,1),(140,'동래정 선릉직영점',124,'2537e7bd-61db-49da-a4c8-d9ab360e05a6',17,6),(141,'동래정 선릉직영점',124,'2537e7bd-61db-49da-a4c8-d9ab360e05a6',19,0),(142,'동래정 선릉직영점',124,'6f3c0699-19ce-4dcd-ba40-21dcc3785c11',20,1),(143,'동래정 선릉직영점',124,'6f3c0699-19ce-4dcd-ba40-21dcc3785c11',21,1),(144,'갓덴스시 강남점',42,'9030f201-c3a3-4ff9-a411-2359392b65e0',2,1),(145,'동래정 선릉직영점',124,'6f3c0699-19ce-4dcd-ba40-21dcc3785c11',22,1),(146,'동래정 선릉직영점',124,'2537e7bd-61db-49da-a4c8-d9ab360e05a6',23,1),(147,'동래정 선릉직영점',124,'9030f201-c3a3-4ff9-a411-2359392b65e0',24,1),(148,'동래정 선릉직영점',124,'6f3c0699-19ce-4dcd-ba40-21dcc3785c11',24,1),(149,'동래정 선릉직영점',124,'7f4da6a4-cc59-4eef-a9ab-ce91f88ad82e',25,2),(150,'동래정 선릉직영점',124,'43ccce9b-7210-4c7c-a43b-ded38a1fd1b5',26,2),(151,'동래정 선릉직영점',124,'2537e7bd-61db-49da-a4c8-d9ab360e05a6',29,0),(152,'동래정 선릉직영점',124,'9030f201-c3a3-4ff9-a411-2359392b65e0',28,2),(153,'동래정 선릉직영점',124,'6f3c0699-19ce-4dcd-ba40-21dcc3785c11',25,5),(154,'동래정 선릉직영점',124,'43ccce9b-7210-4c7c-a43b-ded38a1fd1b5',26,5),(155,'동래정 선릉직영점',124,'2537e7bd-61db-49da-a4c8-d9ab360e05a6',29,0),(156,'동래정 선릉직영점',124,'9030f201-c3a3-4ff9-a411-2359392b65e0',28,5),(157,'동래정 선릉직영점',124,'8a5e742f-01ca-4fd0-8e17-27d7ed2e3112',30,5),(158,'동래정 선릉직영점',124,'43ccce9b-7210-4c7c-a43b-ded38a1fd1b5',26,5),(159,'동래정 선릉직영점',124,'6f3c0699-19ce-4dcd-ba40-21dcc3785c11',27,5),(160,'동래정 선릉직영점',124,'7f4da6a4-cc59-4eef-a9ab-ce91f88ad82e',28,5),(161,'동래정 선릉직영점',124,'2537e7bd-61db-49da-a4c8-d9ab360e05a6',32,0),(162,'동래정 선릉직영점',124,'9030f201-c3a3-4ff9-a411-2359392b65e0',30,5),(163,'동래정 선릉직영점',124,'2537e7bd-61db-49da-a4c8-d9ab360e05a6',29,1),(164,'동래정 선릉직영점',124,'9030f201-c3a3-4ff9-a411-2359392b65e0',30,1),(165,'동래정 선릉직영점',124,'2537e7bd-61db-49da-a4c8-d9ab360e05a6',29,1),(166,'동래정 선릉직영점',124,'2537e7bd-61db-49da-a4c8-d9ab360e05a6',29,1),(167,'동래정 선릉직영점',124,'2537e7bd-61db-49da-a4c8-d9ab360e05a6',29,1),(168,'동래정 선릉직영점',124,'2537e7bd-61db-49da-a4c8-d9ab360e05a6',29,1),(169,'동래정 선릉직영점',124,'2537e7bd-61db-49da-a4c8-d9ab360e05a6',29,1),(170,'동래정 선릉직영점',124,'2537e7bd-61db-49da-a4c8-d9ab360e05a6',29,1),(171,'동래정 선릉직영점',124,'2537e7bd-61db-49da-a4c8-d9ab360e05a6',29,1),(172,'스시마이우 선릉역점',159,'9030f201-c3a3-4ff9-a411-2359392b65e0',1,1),(173,'동래정 선릉직영점',124,'2537e7bd-61db-49da-a4c8-d9ab360e05a6',29,1),(174,'동래정 선릉직영점',124,'2537e7bd-61db-49da-a4c8-d9ab360e05a6',29,1),(175,'동래정 선릉직영점',124,'2537e7bd-61db-49da-a4c8-d9ab360e05a6',29,1),(176,'동래정 선릉직영점',124,'2537e7bd-61db-49da-a4c8-d9ab360e05a6',29,1),(177,'동래정 선릉직영점',124,'2537e7bd-61db-49da-a4c8-d9ab360e05a6',29,1),(178,'동래정 선릉직영점',124,'2537e7bd-61db-49da-a4c8-d9ab360e05a6',29,1),(179,'동래정 선릉직영점',124,'2537e7bd-61db-49da-a4c8-d9ab360e05a6',29,1),(180,'동래정 선릉직영점',124,'2537e7bd-61db-49da-a4c8-d9ab360e05a6',29,1),(181,'바게트케이',67,'9030f201-c3a3-4ff9-a411-2359392b65e0',1,1),(182,'바게트케이',67,'9030f201-c3a3-4ff9-a411-2359392b65e0',2,5),(183,'동래정 선릉직영점',124,'2537e7bd-61db-49da-a4c8-d9ab360e05a6',27,1),(184,'동래정 선릉직영점',124,'7f4da6a4-cc59-4eef-a9ab-ce91f88ad82e',28,4),(185,'동래정 선릉직영점',124,'8a5e742f-01ca-4fd0-8e17-27d7ed2e3112',27,5),(186,'동래정 선릉직영점',124,'2537e7bd-61db-49da-a4c8-d9ab360e05a6',28,1),(187,'동래정 선릉직영점',124,'6f3c0699-19ce-4dcd-ba40-21dcc3785c11',29,1),(188,'동래정 선릉직영점',124,'6f3c0699-19ce-4dcd-ba40-21dcc3785c11',29,1),(189,'동래정 선릉직영점',124,'2537e7bd-61db-49da-a4c8-d9ab360e05a6',28,1),(190,'동래정 선릉직영점',124,'2537e7bd-61db-49da-a4c8-d9ab360e05a6',28,1),(191,'동래정 선릉직영점',124,'2537e7bd-61db-49da-a4c8-d9ab360e05a6',27,1),(192,'동래정 선릉직영점',124,'8a5e742f-01ca-4fd0-8e17-27d7ed2e3112',28,2),(193,'동래정 선릉직영점',124,'2537e7bd-61db-49da-a4c8-d9ab360e05a6',29,1),(194,'동래정 선릉직영점',124,'6f3c0699-19ce-4dcd-ba40-21dcc3785c11',30,1),(195,'동래정 선릉직영점',124,'2537e7bd-61db-49da-a4c8-d9ab360e05a6',29,1),(196,'동래정 선릉직영점',124,'2537e7bd-61db-49da-a4c8-d9ab360e05a6',29,1),(197,'동래정 선릉직영점',124,'2537e7bd-61db-49da-a4c8-d9ab360e05a6',29,1),(198,'동래정 선릉직영점',124,'2537e7bd-61db-49da-a4c8-d9ab360e05a6',30,1),(199,'동래정 선릉직영점',124,'8a5e742f-01ca-4fd0-8e17-27d7ed2e3112',31,5),(200,'동래정 선릉직영점',124,'2537e7bd-61db-49da-a4c8-d9ab360e05a6',32,1),(201,'동래정 선릉직영점',124,'2537e7bd-61db-49da-a4c8-d9ab360e05a6',32,1),(202,'동래정 선릉직영점',124,'2537e7bd-61db-49da-a4c8-d9ab360e05a6',33,1),(203,'동래정 선릉직영점',124,'2537e7bd-61db-49da-a4c8-d9ab360e05a6',34,1),(204,'동래정 선릉직영점',124,'6f3c0699-19ce-4dcd-ba40-21dcc3785c11',35,1),(205,'동래정 선릉직영점',124,'2537e7bd-61db-49da-a4c8-d9ab360e05a6',36,1);
/*!40000 ALTER TABLE `waiting` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-05-19 10:55:55
