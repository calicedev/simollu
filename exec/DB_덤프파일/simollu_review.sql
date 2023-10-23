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
-- Table structure for table `review`
--

DROP TABLE IF EXISTS `review`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `review` (
  `review_seq` int NOT NULL AUTO_INCREMENT,
  `restaurant_seq` int DEFAULT NULL,
  `review_content` varchar(100) DEFAULT NULL,
  `review_rating` bit(1) DEFAULT NULL,
  `review_regist_date` datetime(6) DEFAULT NULL,
  `user_seq` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`review_seq`)
) ENGINE=InnoDB AUTO_INCREMENT=84 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `review`
--

LOCK TABLES `review` WRITE;
/*!40000 ALTER TABLE `review` DISABLE KEYS */;
INSERT INTO `review` VALUES (4,2,'ㅂㄹ,,,,',_binary '\0','2023-05-10 08:59:16.855120','76a3edfc-86c7-4d70-bf58-4e29f0874a64'),(5,2,'ㅂㄹ,,,,',_binary '\0','2023-05-10 09:00:57.180765','76a3edfc-86c7-4d70-bf58-4e29f0874a64'),(6,2,'ㅂㄹ,,,,',_binary '\0','2023-05-10 09:36:01.150269','76a3edfc-86c7-4d70-bf58-4e29f0874a64'),(7,2,'ssssssss',_binary '\0','2023-05-11 14:40:33.213662','9030f201-c3a3-4ff9-a411-2359392b65e0'),(8,2,'ssssssss',_binary '\0','2023-05-11 14:40:52.717029','9030f201-c3a3-4ff9-a411-2359392b65e0'),(9,2,'no',_binary '\0','2023-05-11 15:14:54.433403','9030f201-c3a3-4ff9-a411-2359392b65e0'),(10,2,'f',_binary '\0','2023-05-11 15:58:06.454233','9030f201-c3a3-4ff9-a411-2359392b65e0'),(11,2,'f',_binary '\0','2023-05-11 15:58:38.512378','9030f201-c3a3-4ff9-a411-2359392b65e0'),(12,2,'asdfgj',_binary '','2023-05-11 16:30:17.689426','9030f201-c3a3-4ff9-a411-2359392b65e0'),(13,2,'I wanna Review ',_binary '','2023-05-11 16:33:20.442638','9030f201-c3a3-4ff9-a411-2359392b65e0'),(14,2,'I wanna Review ',_binary '','2023-05-11 16:38:44.777477','9030f201-c3a3-4ff9-a411-2359392b65e0'),(16,2,'test2',_binary '\0','2023-05-12 15:36:00.468806','9030f201-c3a3-4ff9-a411-2359392b65e0'),(21,2,'맛있어요!!!',_binary '','2023-05-12 17:44:28.500483','04ba313a-70f2-48da-9bd4-052549817231'),(22,2,'맛있어요!!!',_binary '','2023-05-12 17:46:10.998840','04ba313a-70f2-48da-9bd4-052549817231'),(23,2,'맛있어요!!!',_binary '','2023-05-12 17:47:03.174135','04ba313a-70f2-48da-9bd4-052549817231'),(24,2,'맛있어요!!!',_binary '','2023-05-12 17:51:36.505710','04ba313a-70f2-48da-9bd4-052549817231'),(25,2,'맛있어요!!!',_binary '','2023-05-12 17:51:37.853432','04ba313a-70f2-48da-9bd4-052549817231'),(26,2,'너무너무너무너무너무 맛있어요!!!!!!!!!!!!!! 또 갈게요 !!! 아니 갈거에요!!!!!!!!!!!!!!!!',_binary '','2023-05-15 17:50:55.196935','43ccce9b-7210-4c7c-a43b-ded38a1fd1b5'),(27,2,'너무너무너무너무너무너무너무 맛있어요!!!!!!!!!!!!!!!!!!!!!!!!! 또 갈래요 !! 아니 또 갈게요!!!!!!!!!!!!!',_binary '','2023-05-16 10:51:05.571630','43ccce9b-7210-4c7c-a43b-ded38a1fd1b5'),(28,124,'전가브리살이 진짜 진짜 맛있어요... 진짜 맛있음 또 갈것 같습니다.',_binary '','2023-05-16 10:54:12.763435','9030f201-c3a3-4ff9-a411-2359392b65e0'),(29,124,'침구들이랑 같이 갔는데 다들 엄청 맛있다고 하더라구요. 다음에 또 갈게요!',_binary '','2023-05-16 10:57:09.426870','9030f201-c3a3-4ff9-a411-2359392b65e0'),(30,123,'bad',_binary '','2023-05-16 11:08:27.436863','9030f201-c3a3-4ff9-a411-2359392b65e0'),(31,2,'정말 너무나 미치게 맛있어요 >__<',_binary '','2023-05-16 11:24:51.040101','43ccce9b-7210-4c7c-a43b-ded38a1fd1b5'),(32,124,'1시간 반 웨이팅 다시는 안가요',_binary '\0','2023-05-18 08:52:05.000000','6f3c0699-19ce-4dcd-ba40-21dcc3785c11'),(33,125,'예시2',_binary '\0','2023-05-18 08:52:22.000000','6f3c0699-19ce-4dcd-ba40-21dcc3785c11'),(34,30,'예시3',_binary '\0','2023-05-18 08:52:33.000000','6f3c0699-19ce-4dcd-ba40-21dcc3785c11'),(35,207,'맛있어요! 또 올게요!',_binary '','2023-05-18 10:18:49.492185','8a5e742f-01ca-4fd0-8e17-27d7ed2e3112'),(36,207,'맛있어요! 또 올게요!',_binary '','2023-05-18 10:18:50.584441','8a5e742f-01ca-4fd0-8e17-27d7ed2e3112'),(37,207,'맛있어요! 또 올게요!',_binary '','2023-05-18 10:19:01.011765','8a5e742f-01ca-4fd0-8e17-27d7ed2e3112'),(38,207,'맛있어요! 또 올게요!',_binary '','2023-05-18 10:19:19.878624','8a5e742f-01ca-4fd0-8e17-27d7ed2e3112'),(39,207,'맛있어요! 또 올게요!',_binary '\0','2023-05-18 10:23:31.252605','8a5e742f-01ca-4fd0-8e17-27d7ed2e3112'),(40,207,'맛있어요! 또 올게요!',_binary '\0','2023-05-18 10:23:36.264212','8a5e742f-01ca-4fd0-8e17-27d7ed2e3112'),(41,207,'맛있어요! 또 올게요!',_binary '\0','2023-05-18 10:23:40.267552','8a5e742f-01ca-4fd0-8e17-27d7ed2e3112'),(42,207,'맛있어요! 또 올게요!',_binary '','2023-05-18 10:23:48.893430','8a5e742f-01ca-4fd0-8e17-27d7ed2e3112'),(43,207,'맛있어요! 또 올게요!',_binary '','2023-05-18 10:23:51.434047','8a5e742f-01ca-4fd0-8e17-27d7ed2e3112'),(44,207,'맛있어요! 또 올게요!',_binary '','2023-05-18 10:23:54.308136','8a5e742f-01ca-4fd0-8e17-27d7ed2e3112'),(45,207,'맛있어요! 또 올게요!',_binary '','2023-05-18 10:23:57.153917','8a5e742f-01ca-4fd0-8e17-27d7ed2e3112'),(46,207,'맛있어요! 또 올게요!',_binary '','2023-05-18 10:24:00.430355','8a5e742f-01ca-4fd0-8e17-27d7ed2e3112'),(47,207,'맛있어요! 또 올게요!',_binary '','2023-05-18 13:52:26.601816','8a5e742f-01ca-4fd0-8e17-27d7ed2e3112'),(48,124,'너무 맛있었어요!!!!',_binary '','2023-05-18 21:51:24.036949','2537e7bd-61db-49da-a4c8-d9ab360e05a6'),(69,124,'존맛탱',_binary '','2023-05-19 03:32:47.077900','2537e7bd-61db-49da-a4c8-d9ab360e05a6'),(70,29,'맛있어요! 맛있어요! 짱!!!',_binary '','2023-05-19 04:36:58.777335','8a5e742f-01ca-4fd0-8e17-27d7ed2e3112'),(71,124,'또또돗 갈래요',_binary '','2023-05-19 04:43:06.556991','8a5e742f-01ca-4fd0-8e17-27d7ed2e3112'),(73,207,'맛있어요! 맛있어요! 짱!!!',_binary '','2023-05-19 07:42:20.683250','8a5e742f-01ca-4fd0-8e17-27d7ed2e3112'),(74,207,'맛있어요! 짱!!!',_binary '\0','2023-05-19 07:44:10.996640','8a5e742f-01ca-4fd0-8e17-27d7ed2e3112'),(75,207,'맛있어요!!!',_binary '','2023-05-19 07:44:24.396828','8a5e742f-01ca-4fd0-8e17-27d7ed2e3112'),(76,207,'잘 먹고 가요!!!',_binary '','2023-05-19 07:44:32.476458','8a5e742f-01ca-4fd0-8e17-27d7ed2e3112'),(77,29,'추천합니다.!!!',_binary '','2023-05-19 07:44:58.787514','8a5e742f-01ca-4fd0-8e17-27d7ed2e3112'),(78,29,'또 올래요!',_binary '','2023-05-19 07:45:28.102428','8a5e742f-01ca-4fd0-8e17-27d7ed2e3112'),(79,29,'별루',_binary '\0','2023-05-19 07:45:47.124011','8a5e742f-01ca-4fd0-8e17-27d7ed2e3112'),(80,124,'맛있습니다',_binary '','2023-05-19 08:04:18.955933','8a5e742f-01ca-4fd0-8e17-27d7ed2e3112'),(81,124,'존맛탱',_binary '','2023-05-19 09:11:36.372808','2537e7bd-61db-49da-a4c8-d9ab360e05a6'),(82,124,'존맛탱',_binary '','2023-05-19 09:25:19.900387','2537e7bd-61db-49da-a4c8-d9ab360e05a6'),(83,124,'존맛탱',_binary '','2023-05-19 10:15:30.973717','2537e7bd-61db-49da-a4c8-d9ab360e05a6');
/*!40000 ALTER TABLE `review` ENABLE KEYS */;
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
