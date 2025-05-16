CREATE DATABASE  IF NOT EXISTS `sitin_db` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `sitin_db`;
-- MySQL dump 10.13  Distrib 8.0.41, for Win64 (x86_64)
--
-- Host: localhost    Database: sitin_db
-- ------------------------------------------------------
-- Server version	8.0.41

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
-- Table structure for table `accounts`
--

DROP TABLE IF EXISTS `accounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `accounts` (
  `user_id` varchar(50) NOT NULL,
  `user_name` varchar(50) NOT NULL,
  `user_password` varchar(255) NOT NULL,
  PRIMARY KEY (`user_id`),
  CONSTRAINT `accounts_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts`
--

LOCK TABLES `accounts` WRITE;
/*!40000 ALTER TABLE `accounts` DISABLE KEYS */;
INSERT INTO `accounts` VALUES ('2024020','ellak','$2b$12$B.ka.eevRhTI49B8l/OQteC0K8CXAPWF/wS1oGIkzDhRS0fJ6K60C'),('2024022','scarlettl','$2b$12$B5Xy1vbKnMqMIj.ZjqpTD.9ul2r8tUieoeLqni1ChYlI.R0P8REGS'),('2024024','lunas','$2b$12$vRh/81kulU0Gfc9TWjL87eWsTm0k4Td5ITIBtNVFrGa8r8hOKkYv2'),('20251234','admin','1234'),('202524','jonathan','$2b$12$eSL2khUQYlX0t4SiyUtfoefDbp0flGjUgBianQJTN0MZnOedhJLWm'),('21552294 ','clifford','$2b$12$qRy16Tf9Ujcslh8.wCZPSeMtoqpVXo1CJlseK5J1Beo/PE6IdmSHi');
/*!40000 ALTER TABLE `accounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `admin`
--

DROP TABLE IF EXISTS `admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admin` (
  `admin_id` varchar(50) NOT NULL,
  PRIMARY KEY (`admin_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin`
--

LOCK TABLES `admin` WRITE;
/*!40000 ALTER TABLE `admin` DISABLE KEYS */;
INSERT INTO `admin` VALUES ('20251234'),('2356611');
/*!40000 ALTER TABLE `admin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `announcements`
--

DROP TABLE IF EXISTS `announcements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `announcements` (
  `announcement_id` int NOT NULL AUTO_INCREMENT,
  `admin_id` varchar(50) NOT NULL,
  `created_by` varchar(20) NOT NULL DEFAULT 'CCS Admin',
  `description` text NOT NULL,
  `date_created` date NOT NULL,
  `time_created` time NOT NULL,
  PRIMARY KEY (`announcement_id`),
  KEY `admin_id` (`admin_id`),
  CONSTRAINT `announcements_ibfk_1` FOREIGN KEY (`admin_id`) REFERENCES `admin` (`admin_id`) ON DELETE CASCADE,
  CONSTRAINT `announcements_chk_1` CHECK ((length(`description`) > 0))
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `announcements`
--

LOCK TABLES `announcements` WRITE;
/*!40000 ALTER TABLE `announcements` DISABLE KEYS */;
INSERT INTO `announcements` VALUES (26,'20251234','CCS Admin','test\r\n','2025-03-26','04:24:41'),(27,'20251234','CCS Admin','Test','2025-03-26','12:26:24'),(28,'20251234','CCS Admin','test','2025-04-04','04:55:01'),(29,'20251234','CCS Admin','TEST','2025-05-16','14:29:48');
/*!40000 ALTER TABLE `announcements` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `set_time` BEFORE INSERT ON `announcements` FOR EACH ROW BEGIN
    SET NEW.time_created = CURRENT_TIME();
    SET NEW.date_created = CURDATE();

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Temporary view structure for view `daily_report`
--

DROP TABLE IF EXISTS `daily_report`;
/*!50001 DROP VIEW IF EXISTS `daily_report`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `daily_report` AS SELECT 
 1 AS `session_id`,
 1 AS `student_id`,
 1 AS `Name`,
 1 AS `type_of_purpose`,
 1 AS `lab`,
 1 AS `Login`,
 1 AS `Logout`,
 1 AS `Date`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `debug_logs`
--

DROP TABLE IF EXISTS `debug_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `debug_logs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `student_id` varchar(50) DEFAULT NULL,
  `note` text,
  `log_time` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `debug_logs`
--

LOCK TABLES `debug_logs` WRITE;
/*!40000 ALTER TABLE `debug_logs` DISABLE KEYS */;
/*!40000 ALTER TABLE `debug_logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `deleted_user`
--

DROP TABLE IF EXISTS `deleted_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `deleted_user` (
  `user_id` varchar(50) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `middle_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `type_of_user` enum('Student','Admin') DEFAULT 'Student',
  `profile_picture` varchar(100) DEFAULT NULL,
  `COURSE` enum('BSIT','BSCPE','BSCS','BSHM','BSBA','BSCRIM') NOT NULL,
  `year` int NOT NULL,
  `student_session` int NOT NULL DEFAULT '30',
  `user_name` varchar(50) NOT NULL,
  `user_password` varchar(255) NOT NULL,
  `registered_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `deleted_user`
--

LOCK TABLES `deleted_user` WRITE;
/*!40000 ALTER TABLE `deleted_user` DISABLE KEYS */;
INSERT INTO `deleted_user` VALUES ('2024001','John','Doe','Alibaba','johndoe@example.com','Student',NULL,'BSIT',1,30,'johndoe','$2b$12$8VMtfTeWDG8tYZD685T3S.Sd6Hj5WXouIngzAIzpEJl2eOEaL.idK','2025-03-20 14:45:51','2025-03-20 15:53:43'),('2024002','Jane','Smith','Baliba','janesmith@example.com','Student',NULL,'BSCPE',2,30,'janesmith','$2b$12$YaW6YlbLy4PGKM6Bt941A.IRfoq23nxW5sfUSTpF.0p2y0NjVpfoe','2025-03-20 14:46:41','2025-03-20 16:14:56'),('2024003','Michael','hello','Capaning','michaelj@example.com','Student',NULL,'BSCS',3,29,'michaelj','$2b$12$EM/Ns1VwVWFEYh1/1t/UauTt6mGWz2r6o2puPW8K16jN1VU2jPhNK','2025-03-20 14:47:15','2025-03-20 22:59:14'),('2024004','Emily','Brown','Diane','emilybrown@example.com','Student',NULL,'BSBA',4,30,'emilyb','$2b$12$8zO4UsgJimCOnVQ6rlI4keTME3VzcL89NDDrM8HFxwnivOFhSUHE.','2025-03-20 14:48:11','2025-03-20 16:16:01'),('2024007','James','Anderson','Geor','jamesa@example.com','Student',NULL,'BSIT',3,29,'jamesa','$2b$12$.teZQgmZ.JxMx4T/cwfscOQYPi2467vdWSmbSwBbsDnFCaDh4K0Ou','2025-03-20 14:53:18','2025-03-23 18:41:04'),('2024008','Sophia','Thomas','Hander','sophiat@example.com','Student',NULL,'BSCPE',4,30,'sophiat','$2b$12$ETZfct53gkuct/zMyt35x.VDLxqi8ZtFeNQx91Y/ultybweCs9OK.','2025-03-20 14:53:57','2025-03-23 18:41:08'),('2024018','tes1234567899','sdfasdf','test','tesasdf','Student','../static/uploads/luisgonz.jpg','BSCRIM',2,29,'evelyny','$2b$12$YIriCJ82foaxGUE/W2drb.FVCWD40JozqPDh/6jn.6PgFeBXq26Iy','2025-03-20 15:12:49','2025-03-25 04:40:22'),('2024019','Jack','Hernandez','Seguisabal','jackh@example.com','Student',NULL,'BSIT',1,29,'jackh','$2b$12$hJizhOGfGhweTATbt8c46uBw6EV2z6vpgzbWhz3fcr5SFECQyPBMS','2025-03-20 15:12:07','2025-03-25 04:42:21'),('2024021','Matthew','Wright','Unlan','mattheww@example.com','Student',NULL,'BSCS',2,30,'mattheww','$2b$12$EzlTPMedUA2lDOANReXBKuqp0YiMxp6YpnZomy7YqiaGbkmpmiUGW','2025-03-20 15:10:44','2025-03-20 15:56:07'),('2024023','David','Hill','Will','davidh@example.com','Student',NULL,'BSBA',3,30,'davidh','$2b$12$BA1Fqul/sMtrHcTvbKJFVO/SFcnG.CAC1nYkhmt77hhjnBZLkxInW','2025-03-20 15:09:23','2025-03-20 16:17:31'),('2024025','teasdf','Green','Yss','josephg@example.com','Student','static/uploads/sofialim.jpg','BSIT',1,30,'josephg','$2b$12$7Rdv53DBWsEolInA4pwasuhlJmCSych6AGcJ4NPKXkZdgIU5yZC1i','2025-03-20 15:08:06','2025-03-25 04:42:51'),('2356611','camilla','Gonzaga','Canitan','alex@gmail.com','Student','../static/uploads/L8.png','BSIT',3,30,'alex321','$2b$12$kNPW9QHOgoCwjrRW1qWMXey5UVRmvoja/GOB89EeMlU5bp5hiycrK','2025-03-14 00:32:42','2025-03-25 04:36:17'),('2356621','alejandro','nojar','alin','alejar@gmail.com','Student',NULL,'BSIT',3,30,'dds1234','123456','2025-03-18 19:27:36','2025-03-25 04:00:10');
/*!40000 ALTER TABLE `deleted_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `display_announcements`
--

DROP TABLE IF EXISTS `display_announcements`;
/*!50001 DROP VIEW IF EXISTS `display_announcements`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `display_announcements` AS SELECT 
 1 AS `announcement_id`,
 1 AS `created_by`,
 1 AS `Date`,
 1 AS `description`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `display_feedabacks`
--

DROP TABLE IF EXISTS `display_feedabacks`;
/*!50001 DROP VIEW IF EXISTS `display_feedabacks`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `display_feedabacks` AS SELECT 
 1 AS `session_id`,
 1 AS `student_id`,
 1 AS `Name`,
 1 AS `course`,
 1 AS `lab`,
 1 AS `Login`,
 1 AS `Logout`,
 1 AS `Date`,
 1 AS `message`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `display_reservation`
--

DROP TABLE IF EXISTS `display_reservation`;
/*!50001 DROP VIEW IF EXISTS `display_reservation`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `display_reservation` AS SELECT 
 1 AS `reserv_id`,
 1 AS `idno`,
 1 AS `Name`,
 1 AS `type_of_purpose`,
 1 AS `lab_id`,
 1 AS `pc_id`,
 1 AS `res_date`,
 1 AS `reserv_time`,
 1 AS `status`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `feedback`
--

DROP TABLE IF EXISTS `feedback`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `feedback` (
  `feedback_id` int DEFAULT NULL,
  `message` text,
  `feedback_time` time DEFAULT NULL,
  `feedback_date` datetime DEFAULT NULL,
  `fbstatus` enum('Completed','Pending') DEFAULT 'Pending',
  `has_profanity` tinyint(1) DEFAULT '0',
  KEY `feedback_id` (`feedback_id`),
  CONSTRAINT `feedback_ibfk_1` FOREIGN KEY (`feedback_id`) REFERENCES `sessions` (`session_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `feedback`
--

LOCK TABLES `feedback` WRITE;
/*!40000 ALTER TABLE `feedback` DISABLE KEYS */;
INSERT INTO `feedback` VALUES (50,'bushet','09:24:48','2025-04-04 00:00:00','Completed',1),(51,NULL,NULL,NULL,'Pending',0),(52,NULL,NULL,NULL,'Pending',0),(53,'bushet','14:00:46','2025-05-16 00:00:00','Completed',1),(54,NULL,NULL,NULL,'Pending',0),(55,NULL,NULL,NULL,'Pending',0),(56,'shet','11:46:03','2025-04-04 00:00:00','Completed',1),(57,NULL,NULL,NULL,'Pending',0),(58,'putang ina mo','13:59:26','2025-05-16 00:00:00','Completed',1),(59,'asdfasdfasdf','13:58:47','2025-05-16 00:00:00','Completed',0),(60,'shet \r\n','12:11:11','2025-04-04 00:00:00','Completed',1),(61,NULL,NULL,NULL,'Pending',0),(62,NULL,NULL,NULL,'Pending',0),(63,NULL,NULL,NULL,'Pending',0),(64,NULL,NULL,NULL,'Pending',0),(65,NULL,NULL,NULL,'Pending',0),(66,NULL,NULL,NULL,'Pending',0),(67,NULL,NULL,NULL,'Pending',0),(68,NULL,NULL,NULL,'Pending',0),(69,NULL,NULL,NULL,'Pending',0),(70,NULL,NULL,NULL,'Pending',0),(71,NULL,NULL,NULL,'Pending',0),(72,NULL,NULL,NULL,'Pending',0),(73,NULL,NULL,NULL,'Pending',0),(74,NULL,NULL,NULL,'Pending',0),(75,NULL,NULL,NULL,'Pending',0),(76,NULL,NULL,NULL,'Pending',0),(77,NULL,NULL,NULL,'Pending',0),(78,NULL,NULL,NULL,'Pending',0),(79,NULL,NULL,NULL,'Pending',0),(80,NULL,NULL,NULL,'Pending',0),(81,NULL,NULL,NULL,'Pending',0),(82,NULL,NULL,NULL,'Pending',0),(83,'shet','14:01:18','2025-05-16 00:00:00','Completed',1),(84,'shet','14:01:12','2025-05-16 00:00:00','Completed',1),(86,'shet','14:01:06','2025-05-16 00:00:00','Completed',1),(87,'ka','14:00:55','2025-05-16 00:00:00','Completed',0),(88,'test','13:56:40','2025-05-16 00:00:00','Completed',0),(89,'test','13:35:51','2025-05-16 00:00:00','Completed',0),(90,NULL,NULL,NULL,'Pending',0),(91,NULL,NULL,NULL,'Pending',0),(92,NULL,NULL,NULL,'Pending',0),(93,NULL,NULL,NULL,'Pending',0);
/*!40000 ALTER TABLE `feedback` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_update_feedback` AFTER UPDATE ON `feedback` FOR EACH ROW BEGIN 
	
	SET @user_id = (SELECT student_id FROM sessions WHERE session_id = NEW.feedback_id);
    SET @message = CONCAT ('Student ',@user_id, ' uses profanity. Please check.');
	IF NEW.has_profanity = TRUE THEN 
		CALL create_notification(@user_id, @message, 'Feedback');
	END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Temporary view structure for view `full_student_information`
--

DROP TABLE IF EXISTS `full_student_information`;
/*!50001 DROP VIEW IF EXISTS `full_student_information`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `full_student_information` AS SELECT 
 1 AS `idno`,
 1 AS `First Name,`,
 1 AS `Middle Name`,
 1 AS `Last Name`,
 1 AS `email`,
 1 AS `course`,
 1 AS `year`,
 1 AS `student_session`,
 1 AS `user_name`,
 1 AS `user_password`,
 1 AS `profile_picture`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `labs`
--

DROP TABLE IF EXISTS `labs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `labs` (
  `lab_id` int NOT NULL,
  PRIMARY KEY (`lab_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `labs`
--

LOCK TABLES `labs` WRITE;
/*!40000 ALTER TABLE `labs` DISABLE KEYS */;
INSERT INTO `labs` VALUES (517),(524),(526),(528),(530),(542),(544);
/*!40000 ALTER TABLE `labs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `leaderboard`
--

DROP TABLE IF EXISTS `leaderboard`;
/*!50001 DROP VIEW IF EXISTS `leaderboard`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `leaderboard` AS SELECT 
 1 AS `user_id`,
 1 AS `Full Name`,
 1 AS `course`,
 1 AS `points`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `logout_records`
--

DROP TABLE IF EXISTS `logout_records`;
/*!50001 DROP VIEW IF EXISTS `logout_records`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `logout_records` AS SELECT 
 1 AS `session_id`,
 1 AS `student_id`,
 1 AS `Name`,
 1 AS `type_of_purpose`,
 1 AS `lab`,
 1 AS `Login`,
 1 AS `Logout`,
 1 AS `Date`,
 1 AS `fbstatus`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `notifications`
--

DROP TABLE IF EXISTS `notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notifications` (
  `notification_id` int NOT NULL AUTO_INCREMENT,
  `user_id` varchar(50) DEFAULT NULL,
  `message` text NOT NULL,
  `notification_type` enum('Feedback','System','Admin','Reservation') DEFAULT NULL,
  `status` varchar(20) DEFAULT 'unread',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`notification_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `notifications_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notifications`
--

LOCK TABLES `notifications` WRITE;
/*!40000 ALTER TABLE `notifications` DISABLE KEYS */;
INSERT INTO `notifications` VALUES (32,'2024024','Your reservation for May 16 at 03:08 PM has been submitted. Please wait for approval.','Reservation','read','2025-05-16 07:06:58','2025-05-16 07:28:50'),(33,'2024024','New reservation request from 2024024 for Lab 517, PC 1 on May 16 at 03:08 PM','Admin','read','2025-05-16 07:06:58','2025-05-16 07:28:50'),(34,'2024024','Your reservation for Lab 517 (PC 1) on May 16, 2025 at 03:08 PM has been approved.','Reservation','read','2025-05-16 07:07:09','2025-05-16 07:28:50'),(35,'2024024','You have updated reservation #44 (Lab 517, PC 1) to status: Approved','Admin','read','2025-05-16 07:07:09','2025-05-16 07:28:50'),(36,'2024024','Your reservation for May 16 at 03:32 PM has been submitted. Please wait for approval.','Reservation','read','2025-05-16 07:31:58','2025-05-16 07:36:46'),(37,'2024024','New reservation request from 2024024 for Lab 517, PC 1 on May 16 at 03:32 PM','Admin','read','2025-05-16 07:31:58','2025-05-16 07:36:46'),(38,'2024024','Your reservation for Lab 517 (PC 1) on May 16, 2025 at 03:32 PM has been approved.','Reservation','read','2025-05-16 07:32:13','2025-05-16 07:36:46'),(39,'2024024','You have updated reservation #45 (Lab 517, PC 1) to status: Approved','Admin','read','2025-05-16 07:32:13','2025-05-16 07:36:46'),(40,'2024024','Your reservation for May 16 at 03:34 PM has been submitted. Please wait for approval.','Reservation','read','2025-05-16 07:32:54','2025-05-16 07:36:46'),(41,'2024024','New reservation request from 2024024 for Lab 526, PC 1 on May 16 at 03:34 PM','Admin','read','2025-05-16 07:32:54','2025-05-16 07:36:46'),(42,'2024024','Your reservation for Lab 526 (PC 1) on May 16, 2025 at 03:34 PM has been approved.','Reservation','read','2025-05-16 07:33:01','2025-05-16 07:36:46'),(43,'2024024','You have updated reservation #46 (Lab 526, PC 1) to status: Approved','Admin','read','2025-05-16 07:33:01','2025-05-16 07:36:46'),(44,'2024024','Your reservation for May 16 at 04:35 PM has been submitted. Please wait for approval.','Reservation','read','2025-05-16 08:33:06','2025-05-16 08:35:43'),(45,'2024024','New reservation request from 2024024 for Lab 526, PC 8 on May 16 at 04:35 PM','Admin','read','2025-05-16 08:33:06','2025-05-16 08:35:43'),(46,'2024024','Your reservation for Lab 526 (PC 8) on May 16, 2025 at 04:35 PM has been approved.','Reservation','read','2025-05-16 08:33:20','2025-05-16 08:35:43'),(47,'2024024','You have updated reservation #47 (Lab 526, PC 8) to status: Approved','Admin','read','2025-05-16 08:33:20','2025-05-16 08:35:43'),(48,'2024024','Your reservation for May 16 at 06:11 PM has been submitted. Please wait for approval.','Reservation','unread','2025-05-16 10:10:07','2025-05-16 10:10:07'),(49,'2024024','New reservation request from 2024024 for Lab 517, PC 1 on May 16 at 06:11 PM','Admin','unread','2025-05-16 10:10:07','2025-05-16 10:10:07'),(50,'2024024','Your reservation for Lab 517 (PC 1) on May 16, 2025 at 06:11 PM has been approved.','Reservation','unread','2025-05-16 10:10:29','2025-05-16 10:10:29'),(51,'2024024','You have updated reservation #48 (Lab 517, PC 1) to status: Approved','Admin','unread','2025-05-16 10:10:29','2025-05-16 10:10:29');
/*!40000 ALTER TABLE `notifications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pcs`
--

DROP TABLE IF EXISTS `pcs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pcs` (
  `pc_id` int NOT NULL,
  `lab_id` int NOT NULL,
  `status` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`lab_id`,`pc_id`),
  CONSTRAINT `pcs_ibfk_1` FOREIGN KEY (`lab_id`) REFERENCES `labs` (`lab_id`),
  CONSTRAINT `pcs_chk_1` CHECK ((`status` in (_utf8mb4'Available',_utf8mb4'Not Available')))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pcs`
--

LOCK TABLES `pcs` WRITE;
/*!40000 ALTER TABLE `pcs` DISABLE KEYS */;
INSERT INTO `pcs` VALUES (1,517,'Available'),(2,517,'Available'),(3,517,'Available'),(4,517,'Available'),(5,517,'Available'),(6,517,'Available'),(7,517,'Available'),(8,517,'Available'),(9,517,'Available'),(10,517,'Available'),(11,517,'Available'),(12,517,'Available'),(13,517,'Available'),(14,517,'Available'),(15,517,'Available'),(16,517,'Available'),(17,517,'Available'),(18,517,'Available'),(19,517,'Available'),(20,517,'Available'),(21,517,'Available'),(22,517,'Available'),(23,517,'Available'),(24,517,'Available'),(25,517,'Available'),(26,517,'Available'),(27,517,'Available'),(28,517,'Available'),(29,517,'Available'),(30,517,'Available'),(31,517,'Available'),(32,517,'Available'),(33,517,'Available'),(34,517,'Available'),(35,517,'Available'),(36,517,'Available'),(37,517,'Available'),(38,517,'Available'),(39,517,'Available'),(40,517,'Available'),(41,517,'Available'),(42,517,'Available'),(43,517,'Available'),(44,517,'Available'),(45,517,'Available'),(46,517,'Available'),(47,517,'Available'),(48,517,'Available'),(49,517,'Available'),(50,517,'Available'),(1,524,'Available'),(2,524,'Available'),(3,524,'Available'),(4,524,'Available'),(5,524,'Available'),(6,524,'Available'),(7,524,'Available'),(8,524,'Available'),(9,524,'Available'),(10,524,'Available'),(11,524,'Available'),(12,524,'Available'),(13,524,'Available'),(14,524,'Available'),(15,524,'Available'),(16,524,'Available'),(17,524,'Available'),(18,524,'Available'),(19,524,'Available'),(20,524,'Available'),(21,524,'Available'),(22,524,'Available'),(23,524,'Available'),(24,524,'Available'),(25,524,'Available'),(26,524,'Available'),(27,524,'Available'),(28,524,'Available'),(29,524,'Available'),(30,524,'Available'),(31,524,'Available'),(32,524,'Available'),(33,524,'Available'),(34,524,'Available'),(35,524,'Available'),(36,524,'Available'),(37,524,'Available'),(38,524,'Available'),(39,524,'Available'),(40,524,'Available'),(41,524,'Available'),(42,524,'Available'),(43,524,'Available'),(44,524,'Available'),(45,524,'Available'),(46,524,'Available'),(47,524,'Available'),(48,524,'Available'),(49,524,'Available'),(50,524,'Available'),(1,526,'Not Available'),(2,526,'Not Available'),(3,526,'Not Available'),(4,526,'Not Available'),(5,526,'Not Available'),(6,526,'Not Available'),(7,526,'Not Available'),(8,526,'Available'),(9,526,'Available'),(10,526,'Available'),(11,526,'Available'),(12,526,'Available'),(13,526,'Available'),(14,526,'Available'),(15,526,'Available'),(16,526,'Available'),(17,526,'Available'),(18,526,'Available'),(19,526,'Available'),(20,526,'Available'),(21,526,'Available'),(22,526,'Available'),(23,526,'Available'),(24,526,'Available'),(25,526,'Available'),(26,526,'Available'),(27,526,'Available'),(28,526,'Available'),(29,526,'Available'),(30,526,'Available'),(31,526,'Available'),(32,526,'Available'),(33,526,'Available'),(34,526,'Available'),(35,526,'Available'),(36,526,'Available'),(37,526,'Available'),(38,526,'Available'),(39,526,'Available'),(40,526,'Available'),(41,526,'Available'),(42,526,'Available'),(43,526,'Available'),(44,526,'Available'),(45,526,'Available'),(46,526,'Available'),(47,526,'Available'),(48,526,'Available'),(49,526,'Available'),(50,526,'Available'),(1,528,'Available'),(2,528,'Available'),(3,528,'Available'),(4,528,'Available'),(5,528,'Available'),(6,528,'Available'),(7,528,'Available'),(8,528,'Available'),(9,528,'Available'),(10,528,'Available'),(11,528,'Available'),(12,528,'Available'),(13,528,'Available'),(14,528,'Available'),(15,528,'Available'),(16,528,'Available'),(17,528,'Available'),(18,528,'Available'),(19,528,'Available'),(20,528,'Available'),(21,528,'Available'),(22,528,'Available'),(23,528,'Available'),(24,528,'Available'),(25,528,'Available'),(26,528,'Available'),(27,528,'Available'),(28,528,'Available'),(29,528,'Available'),(30,528,'Available'),(31,528,'Available'),(32,528,'Available'),(33,528,'Available'),(34,528,'Available'),(35,528,'Available'),(36,528,'Available'),(37,528,'Available'),(38,528,'Available'),(39,528,'Available'),(40,528,'Available'),(41,528,'Available'),(42,528,'Available'),(43,528,'Available'),(44,528,'Available'),(45,528,'Available'),(46,528,'Available'),(47,528,'Available'),(48,528,'Available'),(49,528,'Available'),(50,528,'Available'),(1,530,'Available'),(2,530,'Available'),(3,530,'Available'),(4,530,'Available'),(5,530,'Available'),(6,530,'Available'),(7,530,'Available'),(8,530,'Available'),(9,530,'Available'),(10,530,'Available'),(11,530,'Available'),(12,530,'Available'),(13,530,'Available'),(14,530,'Available'),(15,530,'Available'),(16,530,'Available'),(17,530,'Available'),(18,530,'Available'),(19,530,'Available'),(20,530,'Available'),(21,530,'Available'),(22,530,'Available'),(23,530,'Available'),(24,530,'Available'),(25,530,'Available'),(26,530,'Available'),(27,530,'Available'),(28,530,'Available'),(29,530,'Available'),(30,530,'Available'),(31,530,'Available'),(32,530,'Available'),(33,530,'Available'),(34,530,'Available'),(35,530,'Available'),(36,530,'Available'),(37,530,'Available'),(38,530,'Available'),(39,530,'Available'),(40,530,'Available'),(41,530,'Available'),(42,530,'Available'),(43,530,'Available'),(44,530,'Available'),(45,530,'Available'),(46,530,'Available'),(47,530,'Available'),(48,530,'Available'),(49,530,'Available'),(50,530,'Available'),(1,542,'Available'),(2,542,'Available'),(3,542,'Available'),(4,542,'Available'),(5,542,'Available'),(6,542,'Available'),(7,542,'Available'),(8,542,'Available'),(9,542,'Available'),(10,542,'Available'),(11,542,'Available'),(12,542,'Available'),(13,542,'Available'),(14,542,'Available'),(15,542,'Available'),(16,542,'Available'),(17,542,'Available'),(18,542,'Available'),(19,542,'Available'),(20,542,'Available'),(21,542,'Available'),(22,542,'Available'),(23,542,'Available'),(24,542,'Available'),(25,542,'Available'),(26,542,'Available'),(27,542,'Available'),(28,542,'Available'),(29,542,'Available'),(30,542,'Available'),(31,542,'Available'),(32,542,'Available'),(33,542,'Available'),(34,542,'Available'),(35,542,'Available'),(36,542,'Available'),(37,542,'Available'),(38,542,'Available'),(39,542,'Available'),(40,542,'Available'),(41,542,'Available'),(42,542,'Available'),(43,542,'Available'),(44,542,'Available'),(45,542,'Available'),(46,542,'Available'),(47,542,'Available'),(48,542,'Available'),(49,542,'Available'),(50,542,'Available'),(1,544,'Available'),(2,544,'Available'),(3,544,'Available'),(4,544,'Available'),(5,544,'Available'),(6,544,'Available'),(7,544,'Available'),(8,544,'Available'),(9,544,'Available'),(10,544,'Available'),(11,544,'Available'),(12,544,'Available'),(13,544,'Available'),(14,544,'Available'),(15,544,'Available'),(16,544,'Available'),(17,544,'Available'),(18,544,'Available'),(19,544,'Available'),(20,544,'Available'),(21,544,'Available'),(22,544,'Available'),(23,544,'Available'),(24,544,'Available'),(25,544,'Available'),(26,544,'Available'),(27,544,'Available'),(28,544,'Available'),(29,544,'Available'),(30,544,'Available'),(31,544,'Available'),(32,544,'Available'),(33,544,'Available'),(34,544,'Available'),(35,544,'Available'),(36,544,'Available'),(37,544,'Available'),(38,544,'Available'),(39,544,'Available'),(40,544,'Available'),(41,544,'Available'),(42,544,'Available'),(43,544,'Available'),(44,544,'Available'),(45,544,'Available'),(46,544,'Available'),(47,544,'Available'),(48,544,'Available'),(49,544,'Available'),(50,544,'Available');
/*!40000 ALTER TABLE `pcs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `profile_view`
--

DROP TABLE IF EXISTS `profile_view`;
/*!50001 DROP VIEW IF EXISTS `profile_view`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `profile_view` AS SELECT 
 1 AS `user_id`,
 1 AS `profile_picture`,
 1 AS `first_name`,
 1 AS `middle_name`,
 1 AS `last_name`,
 1 AS `email`,
 1 AS `user_name`,
 1 AS `user_password`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `purpose`
--

DROP TABLE IF EXISTS `purpose`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `purpose` (
  `purpose_id` int NOT NULL AUTO_INCREMENT,
  `type_of_purpose` varchar(50) NOT NULL,
  PRIMARY KEY (`purpose_id`),
  UNIQUE KEY `type_of_purpose` (`type_of_purpose`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `purpose`
--

LOCK TABLES `purpose` WRITE;
/*!40000 ALTER TABLE `purpose` DISABLE KEYS */;
INSERT INTO `purpose` VALUES (2,'C# Programming'),(7,'Computer Application'),(8,'Database'),(6,'Digital Logic and Design'),(5,'Embedded Systems and Iot'),(1,'Java Programming'),(9,'Mobile Application'),(10,'Others...'),(3,'Python Programming'),(4,'Systems Integration and Architecture');
/*!40000 ALTER TABLE `purpose` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reservation`
--

DROP TABLE IF EXISTS `reservation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reservation` (
  `reserv_id` int NOT NULL AUTO_INCREMENT,
  `student_id` varchar(50) NOT NULL,
  `purpose_id` int NOT NULL,
  `lab_id` int NOT NULL,
  `pc_id` int NOT NULL,
  `res_date` date NOT NULL,
  `res_time` time NOT NULL,
  `status` enum('Pending','Approved','Disapproved') DEFAULT 'Pending',
  PRIMARY KEY (`reserv_id`),
  KEY `purpose_id` (`purpose_id`),
  KEY `student_id` (`student_id`),
  KEY `lab_id` (`lab_id`,`pc_id`),
  CONSTRAINT `reservation_ibfk_1` FOREIGN KEY (`purpose_id`) REFERENCES `purpose` (`purpose_id`) ON DELETE CASCADE,
  CONSTRAINT `reservation_ibfk_2` FOREIGN KEY (`student_id`) REFERENCES `students` (`idno`) ON DELETE CASCADE,
  CONSTRAINT `reservation_ibfk_3` FOREIGN KEY (`lab_id`, `pc_id`) REFERENCES `pcs` (`lab_id`, `pc_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reservation`
--

LOCK TABLES `reservation` WRITE;
/*!40000 ALTER TABLE `reservation` DISABLE KEYS */;
INSERT INTO `reservation` VALUES (48,'2024024',2,517,1,'2025-05-16','18:11:00','Approved');
/*!40000 ALTER TABLE `reservation` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_currently_sitin_update` AFTER UPDATE ON `reservation` FOR EACH ROW BEGIN 
	IF NEW.status = 'Currently Sitin' THEN 
		CALL sitin(OLD.student_id, NULL, OLD.purpose_id, OLD.lab_id);
	END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `resources`
--

DROP TABLE IF EXISTS `resources`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `resources` (
  `resource_id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `resc_description` text,
  `file_path` varchar(255) NOT NULL,
  `typeof_resc` enum('File','Link') DEFAULT NULL,
  PRIMARY KEY (`resource_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `resources`
--

LOCK TABLES `resources` WRITE;
/*!40000 ALTER TABLE `resources` DISABLE KEYS */;
INSERT INTO `resources` VALUES (10,'This is docs','docs','Week_6_Lecture_in_Info_sec.docx','File');
/*!40000 ALTER TABLE `resources` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sessions` (
  `session_id` int NOT NULL AUTO_INCREMENT,
  `student_id` varchar(50) NOT NULL,
  `sitin_by` varchar(50) DEFAULT NULL,
  `purpose_id` int NOT NULL,
  `lab` int NOT NULL,
  `time_in` timestamp NOT NULL,
  `time_out` datetime DEFAULT NULL,
  `sitin_date` date NOT NULL,
  `isActive` tinyint(1) DEFAULT '1',
  `status` enum('Active','Inactive') NOT NULL DEFAULT 'Active',
  PRIMARY KEY (`session_id`),
  KEY `student_id` (`student_id`),
  KEY `sitin_by` (`sitin_by`),
  KEY `purpose_id` (`purpose_id`),
  KEY `lab` (`lab`),
  CONSTRAINT `sessions_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `students` (`idno`) ON DELETE CASCADE,
  CONSTRAINT `sessions_ibfk_2` FOREIGN KEY (`sitin_by`) REFERENCES `admin` (`admin_id`) ON DELETE CASCADE,
  CONSTRAINT `sessions_ibfk_4` FOREIGN KEY (`lab`) REFERENCES `labs` (`lab_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=94 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sessions`
--

LOCK TABLES `sessions` WRITE;
/*!40000 ALTER TABLE `sessions` DISABLE KEYS */;
INSERT INTO `sessions` VALUES (50,'2024020','20251234',1,517,'2025-04-04 00:51:11','2025-04-04 08:51:17','2025-04-04',0,'Inactive'),(51,'2024020','20251234',1,517,'2025-04-04 03:09:26','2025-04-04 11:09:34','2025-04-04',0,'Inactive'),(52,'2024022','20251234',2,517,'2025-04-04 03:10:08','2025-04-04 11:10:59','2025-04-04',0,'Inactive'),(53,'2024024','20251234',3,517,'2025-04-04 03:10:22','2025-04-04 11:10:56','2025-04-04',0,'Inactive'),(54,'202524','20251234',7,517,'2025-04-04 03:10:35','2025-04-04 11:10:54','2025-04-04',0,'Inactive'),(55,'21552294 ','20251234',5,517,'2025-04-04 03:10:49','2025-04-04 11:10:52','2025-04-04',0,'Inactive'),(56,'2024020','20251234',1,517,'2025-04-04 03:11:08','2025-04-04 11:11:11','2025-04-04',0,'Inactive'),(57,'2024022','20251234',2,517,'2025-04-04 03:11:24','2025-04-04 11:11:29','2025-04-04',0,'Inactive'),(58,'2024024','20251234',3,524,'2025-04-04 03:11:43','2025-04-04 11:11:45','2025-04-04',0,'Inactive'),(59,'2024024','20251234',1,524,'2025-04-04 03:12:00','2025-04-04 11:12:03','2025-04-04',0,'Inactive'),(60,'2024020','20251234',1,517,'2025-04-04 04:10:44','2025-04-04 12:10:48','2025-04-04',0,'Inactive'),(61,'2024020','20251234',2,526,'2025-04-23 17:08:00','2025-04-25 08:20:39','2025-04-24',0,'Inactive'),(62,'2024020','20251234',1,517,'2025-04-25 00:24:31','2025-04-25 08:24:34','2025-04-25',0,'Inactive'),(63,'2024020','20251234',1,517,'2025-04-25 01:06:26','2025-04-25 09:06:35','2025-04-25',0,'Inactive'),(64,'2024020','20251234',1,517,'2025-04-25 01:07:38','2025-04-25 09:07:42','2025-04-25',0,'Inactive'),(65,'2024020','20251234',1,517,'2025-04-28 05:27:33','2025-04-28 13:27:44','2025-04-28',0,'Inactive'),(66,'2024020','20251234',1,517,'2025-04-28 05:32:14','2025-04-28 13:32:19','2025-04-28',0,'Inactive'),(67,'2024020','20251234',1,517,'2025-04-29 05:48:03','2025-04-29 13:48:14','2025-04-29',0,'Inactive'),(68,'2024020','20251234',1,517,'2025-04-29 05:48:42','2025-04-29 13:48:47','2025-04-29',0,'Inactive'),(69,'2024020','20251234',1,517,'2025-04-29 05:49:10','2025-04-29 13:49:16','2025-04-29',0,'Inactive'),(70,'2024020','20251234',1,517,'2025-04-29 05:50:12','2025-04-29 13:50:17','2025-04-29',0,'Inactive'),(71,'2024020','20251234',1,517,'2025-04-29 05:50:34','2025-04-29 13:50:38','2025-04-29',0,'Inactive'),(72,'2024020','20251234',1,517,'2025-04-29 05:51:19','2025-04-29 13:51:25','2025-04-29',0,'Inactive'),(73,'2024022','20251234',1,517,'2025-04-29 05:51:55','2025-04-29 13:51:59','2025-04-29',0,'Inactive'),(74,'2024022','20251234',1,517,'2025-04-29 05:52:07','2025-04-29 13:52:17','2025-04-29',0,'Inactive'),(75,'2024022','20251234',1,517,'2025-04-29 05:52:34','2025-04-29 13:52:38','2025-04-29',0,'Inactive'),(76,'2024020','20251234',1,517,'2025-04-29 05:53:45','2025-04-29 13:53:53','2025-04-29',0,'Inactive'),(77,'2024020','20251234',1,517,'2025-04-29 05:54:00','2025-04-29 13:54:05','2025-04-29',0,'Inactive'),(78,'2024020','20251234',1,517,'2025-04-29 05:54:22','2025-04-29 13:54:27','2025-04-29',0,'Inactive'),(79,'2024020','20251234',1,517,'2025-04-29 05:54:34','2025-04-29 14:48:36','2025-04-29',0,'Inactive'),(80,'2024020','20251234',1,517,'2025-04-29 06:48:51','2025-04-29 14:48:57','2025-04-29',0,'Inactive'),(81,'2024020','20251234',1,517,'2025-04-29 06:49:09','2025-04-29 14:49:16','2025-04-29',0,'Inactive'),(82,'2024020','20251234',3,526,'2025-05-16 00:09:25','2025-05-16 08:33:48','2025-05-16',0,'Inactive'),(83,'2024024',NULL,1,517,'2025-05-16 02:19:00','2025-05-16 10:21:54','2025-05-16',0,'Inactive'),(84,'2024024',NULL,1,526,'2025-05-16 02:24:00','2025-05-16 10:30:39','2025-05-16',0,'Inactive'),(86,'2024024',NULL,1,526,'2025-05-16 02:54:00','2025-05-16 10:59:28','2025-05-16',0,'Inactive'),(87,'2024024',NULL,2,517,'2025-05-16 03:01:00','2025-05-16 11:13:20','2025-05-16',0,'Inactive'),(88,'2024024',NULL,1,517,'2025-05-16 03:38:00','2025-05-16 11:52:05','2025-05-16',0,'Inactive'),(89,'2024024',NULL,1,517,'2025-05-16 03:54:00','2025-05-16 11:54:18','2025-05-16',0,'Inactive'),(90,'2024024',NULL,3,517,'2025-05-16 07:08:00','2025-05-16 15:32:09','2025-05-16',0,'Inactive'),(91,'2024024',NULL,2,526,'2025-05-16 07:34:00','2025-05-16 15:34:13','2025-05-16',0,'Inactive'),(92,'2024024',NULL,1,526,'2025-05-16 08:35:00','2025-05-16 16:35:15','2025-05-16',0,'Inactive'),(93,'2024024',NULL,2,517,'2025-05-16 10:11:00',NULL,'2025-05-16',1,'Active');
/*!40000 ALTER TABLE `sessions` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `set_time_in` BEFORE INSERT ON `sessions` FOR EACH ROW BEGIN
    SET NEW.time_in = CURRENT_TIME();
    SET NEW.sitin_date = CURDATE();
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_student_logout` AFTER UPDATE ON `sessions` FOR EACH ROW BEGIN 
    IF OLD.time_out IS NULL AND NEW.time_out IS NOT NULL THEN
        
        IF (SELECT student_session FROM students WHERE idno = NEW.student_id) > 0 THEN 
            UPDATE students
            SET student_session = student_session - 1
            WHERE idno = NEW.student_id;
        END IF;
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Temporary view structure for view `sitin_reports`
--

DROP TABLE IF EXISTS `sitin_reports`;
/*!50001 DROP VIEW IF EXISTS `sitin_reports`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `sitin_reports` AS SELECT 
 1 AS `session_id`,
 1 AS `student_id`,
 1 AS `Name`,
 1 AS `type_of_purpose`,
 1 AS `lab`,
 1 AS `Login`,
 1 AS `Logout`,
 1 AS `Date`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `student_information`
--

DROP TABLE IF EXISTS `student_information`;
/*!50001 DROP VIEW IF EXISTS `student_information`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `student_information` AS SELECT 
 1 AS `idno`,
 1 AS `name`,
 1 AS `course`,
 1 AS `year`,
 1 AS `student_session`,
 1 AS `points`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `students`
--

DROP TABLE IF EXISTS `students`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `students` (
  `idno` varchar(50) NOT NULL,
  `COURSE` enum('BSIT','BSCPE','BSCS','BSHM','BSBA','BSCRIM') NOT NULL,
  `year` int NOT NULL,
  `student_session` int NOT NULL DEFAULT '30',
  `points` int DEFAULT '0',
  PRIMARY KEY (`idno`),
  CONSTRAINT `students_ibfk_1` FOREIGN KEY (`idno`) REFERENCES `users` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `students`
--

LOCK TABLES `students` WRITE;
/*!40000 ALTER TABLE `students` DISABLE KEYS */;
INSERT INTO `students` VALUES ('2024020','BSCPE',2,23,1075),('2024022','BSHM',2,28,162),('2024024','BSCRIM',4,24,1537),('202524','BSCS',2,30,500),('21552294 ','BSBA',2,30,725);
/*!40000 ALTER TABLE `students` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `before_update_points` BEFORE UPDATE ON `students` FOR EACH ROW BEGIN
    -- Only update visibility_status if:
    -- 1. Points were actually changed (OLD.points ≠ NEW.points)
    -- 2. New points are divisible by 3
    IF NEW.points <> OLD.points AND MOD(NEW.points, 3) = 0 THEN
        SET NEW.student_session = NEW.student_session +  1;
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `user_id` varchar(50) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `middle_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `type_of_user` enum('Student','Admin') DEFAULT 'Student',
  `profile_picture` varchar(100) DEFAULT NULL,
  `registered_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES ('2024020','Ella','King','Titi','ellak@example.com','Student','static/uploads/markvilla.jpg','2025-03-20 15:11:23'),('2024022','Scarlett','Lopez','Ves','scarlettl@example.com','Student',NULL,'2025-03-20 15:09:59'),('2024024','Lunas','X.','Scott','lunas@example.com','Student','static/uploads/markvilla.jpg','2025-03-20 15:08:44'),('20251234','clifford','seguisabal','alferez','clifford@gmail.com','Admin','../static/uploads/asasasasa.jpg','2025-03-13 21:50:26'),('202524','Jonathan','Pabuaya','Alejandro','jonathan@gmail.com','Student','static/uploads/markvilla.jpg','2025-03-26 04:25:06'),('21552294 ','Clifford','Alferez','Seguisabal','clifford@gmail.com','Student','static/uploads/markvilla.jpg','2025-03-26 04:09:06');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_delete_user` BEFORE DELETE ON `users` FOR EACH ROW BEGIN 
	  SET @course = (SELECT course FROM students WHERE idno = OLD.user_id);
      SET @year = (SELECT year FROM students WHERE idno = OLD.user_id);
      SET @student_session = (SELECT student_session FROM students WHERE idno = OLD.user_id);
      set @user_name = (SELECT user_name FROM accounts WHERE user_id = OLD.user_id);
      set @user_password = (SELECT user_password FROM accounts WHERE user_id = OLD.user_id);
	  INSERT INTO deleted_user (user_id, first_name, middle_name, last_name, email, 
                               type_of_user, profile_picture, course, year,  student_session, user_name, user_password, registered_at, deleted_at)
	VALUES (OLD.user_id, OLD.first_name, OLD.middle_name, OLD.last_name, OLD.email, 
	OLD.type_of_user, OLD.profile_picture, @course ,  @year , @student_session, @user_name, @user_password,OLD.registered_at,NOW());
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Dumping events for database 'sitin_db'
--
/*!50106 SET @save_time_zone= @@TIME_ZONE */ ;
/*!50106 DROP EVENT IF EXISTS `auto_update_reservations` */;
DELIMITER ;;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;;
/*!50003 SET character_set_client  = utf8mb4 */ ;;
/*!50003 SET character_set_results = utf8mb4 */ ;;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;;
/*!50003 SET @saved_time_zone      = @@time_zone */ ;;
/*!50003 SET time_zone             = 'SYSTEM' */ ;;
/*!50106 CREATE*/ /*!50117 DEFINER=`root`@`localhost`*/ /*!50106 EVENT `auto_update_reservations` ON SCHEDULE EVERY 1 MINUTE STARTS '2025-05-16 11:50:00' ON COMPLETION NOT PRESERVE ENABLE DO BEGIN
  DECLARE done INT DEFAULT FALSE;
  DECLARE v_reserv_id INT;
  DECLARE v_student_id VARCHAR(50);
  DECLARE v_purpose_id INT;
  DECLARE v_lab_id INT;

  DECLARE cur CURSOR FOR
    SELECT reserv_id, student_id, purpose_id, lab_id
    FROM reservation
    WHERE res_date = CURDATE()
      AND TIME_FORMAT(res_time, '%H:%i') = TIME_FORMAT(NOW(), '%H:%i')
      AND status = 'Approved';

  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

  OPEN cur;

  read_loop: LOOP
    FETCH cur INTO v_reserv_id, v_student_id, v_purpose_id, v_lab_id;
    IF done THEN
      LEAVE read_loop;
    END IF;

    -- ✅ Just call sitin
    CALL sitin(v_student_id, NULL, v_purpose_id, v_lab_id);

  END LOOP;

  CLOSE cur;
END */ ;;
/*!50003 SET time_zone             = @saved_time_zone */ ;;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;;
/*!50003 SET character_set_client  = @saved_cs_client */ ;;
/*!50003 SET character_set_results = @saved_cs_results */ ;;
/*!50003 SET collation_connection  = @saved_col_connection */ ;;
/*!50106 DROP EVENT IF EXISTS `auto_update_reservations_debug` */;;
DELIMITER ;;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;;
/*!50003 SET character_set_client  = utf8mb4 */ ;;
/*!50003 SET character_set_results = utf8mb4 */ ;;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;;
/*!50003 SET @saved_time_zone      = @@time_zone */ ;;
/*!50003 SET time_zone             = 'SYSTEM' */ ;;
/*!50106 CREATE*/ /*!50117 DEFINER=`root`@`localhost`*/ /*!50106 EVENT `auto_update_reservations_debug` ON SCHEDULE EVERY 1 MINUTE STARTS '2025-05-16 11:25:00' ON COMPLETION NOT PRESERVE ENABLE DO BEGIN
  DECLARE done INT DEFAULT FALSE;
  DECLARE v_reservation_pk_id INT; -- PRIMARY KEY
  DECLARE v_student_id_fetched VARCHAR(50); -- For logging
  DECLARE v_target_date DATE;
  DECLARE v_target_time_str VARCHAR(5);
  DECLARE v_status_before_update VARCHAR(50);
  DECLARE v_rows_affected INT;

  -- Log table (ensure it exists)
  -- CREATE TABLE event_debug_log (log_id INT AUTO_INCREMENT PRIMARY KEY, log_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP, pk_id_val INT, student_id_val VARCHAR(50), status_val VARCHAR(50), action_taken VARCHAR(255), rows_val INT, message TEXT);

  DECLARE cur CURSOR FOR
    SELECT reservation_pk_id, student_id -- Fetch the PK and student_id for logging
    FROM reservation
    WHERE res_date = v_target_date
      AND TIME_FORMAT(res_time, '%H:%i') = v_target_time_str
      AND status = 'Approved';

  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

  SET v_target_date = CURDATE();
  SET v_target_time_str = TIME_FORMAT(NOW(), '%H:%i');

  OPEN cur;

  read_loop: LOOP
    FETCH cur INTO v_reservation_pk_id, v_student_id_fetched;
    IF done THEN
      LEAVE read_loop;
    END IF;

    -- Log what we are about to do
    INSERT INTO event_debug_log (pk_id_val, student_id_val, action_taken, message)
    VALUES (v_reservation_pk_id, v_student_id_fetched, 'ATTEMPTING_UPDATE', CONCAT('PK: ', v_reservation_pk_id, ', Target Time: ', v_target_time_str));

    -- Direct UPDATE using PK and original status condition
    UPDATE reservation
    SET status = 'Currently Sitin'
    WHERE reservation_pk_id = v_reservation_pk_id
      AND status = 'Approved'; -- Still important: only update if it's still 'Approved'

    SET v_rows_affected = ROW_COUNT();

    IF v_rows_affected > 0 THEN
      -- UPDATE SUCCEEDED
      INSERT INTO event_debug_log (pk_id_val, student_id_val, action_taken, rows_val, message)
      VALUES (v_reservation_pk_id, v_student_id_fetched, 'UPDATE_SUCCESS', v_rows_affected, 'Status set to Currently Sitin. Now calling sitin.');

      -- NOW CALL SITIN (only if update was successful)
      CALL sitin(v_student_id_fetched, NULL, (SELECT purpose_id FROM reservation WHERE reservation_pk_id = v_reservation_pk_id), (SELECT lab_id FROM reservation WHERE reservation_pk_id = v_reservation_pk_id));
      -- Note: Re-fetching purpose_id and lab_id here. You could also fetch them in the cursor.

    ELSE
      -- UPDATE FAILED. Why?
      -- Fetch the current status to see why it failed
      SELECT status INTO v_status_before_update FROM reservation WHERE reservation_pk_id = v_reservation_pk_id;

      INSERT INTO event_debug_log (pk_id_val, student_id_val, action_taken, rows_val, status_val, message)
      VALUES (v_reservation_pk_id, v_student_id_fetched, 'UPDATE_FAILED', v_rows_affected, v_status_before_update, 'Status NOT set to Currently Sitin. Sitin NOT called. Current status logged.');
    END IF;

  END LOOP;

  CLOSE cur;
END */ ;;
/*!50003 SET time_zone             = @saved_time_zone */ ;;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;;
/*!50003 SET character_set_client  = @saved_cs_client */ ;;
/*!50003 SET character_set_results = @saved_cs_results */ ;;
/*!50003 SET collation_connection  = @saved_col_connection */ ;;
DELIMITER ;
/*!50106 SET TIME_ZONE= @save_time_zone */ ;

--
-- Dumping routines for database 'sitin_db'
--
/*!50003 DROP FUNCTION IF EXISTS `TitleCase` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `TitleCase`(str TEXT) RETURNS text CHARSET utf8mb4
    DETERMINISTIC
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE result TEXT DEFAULT '';
    DECLARE current_word VARCHAR(255);
    
    WHILE LENGTH(str) > 0 DO
        SET current_word = SUBSTRING_INDEX(str, ' ', 1);
        SET result = CONCAT(result, ' ', UPPER(LEFT(current_word, 1)), LOWER(SUBSTRING(current_word, 2)));
        SET str = SUBSTRING(str FROM LENGTH(current_word) + 2);
        
        IF LENGTH(str) = 0 THEN
            RETURN TRIM(result);
        END IF;
    END WHILE;
    
    RETURN TRIM(result);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_reservation` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_reservation`(
    IN p_student_id VARCHAR(50),
    IN p_purpose_id INT,
    IN p_lab_id INT,
    IN p_pc_id INT,
    IN p_res_date DATE,
    IN p_res_time TIME
)
BEGIN
    -- Declare message variable
    DECLARE v_message TEXT;
	DECLARE v2_messgae TEXT;
    -- Check for existing reservation
    IF EXISTS (
        SELECT 1 FROM reservation
        WHERE lab_id = p_lab_id
          AND pc_id = p_pc_id
          AND res_date = p_res_date
          AND res_time = p_res_time
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'PC is already reserved at this date and time';
    ELSE
        -- Insert reservation
        INSERT INTO reservation (
            student_id, purpose_id, lab_id, pc_id, res_date, res_time
        ) VALUES (
            p_student_id, p_purpose_id, p_lab_id, p_pc_id, p_res_date, p_res_time
        );

        -- Construct the message
        SET v_message = CONCAT(
            'Your reservation for ',
            DATE_FORMAT(p_res_date, '%M %d'),
            ' at ',
            TIME_FORMAT(p_res_time, '%h:%i %p'),
            ' has been submitted. Please wait for approval.'
        );
         SET v2_messgae = CONCAT(
            'New reservation request from ', 
            p_student_id, 
            ' for Lab ', p_lab_id, 
            ', PC ', p_pc_id, 
            ' on ', DATE_FORMAT(p_res_date, '%M %d'), 
            ' at ', TIME_FORMAT(p_res_time, '%h:%i %p')
        );
        -- Store notification
        CALL create_notification(p_student_id, v_message, 'Reservation');
        CALL create_notification(p_student_id, v2_messgae, 'Admin');
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_resources` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_resources`(
	IN res_title VARCHAR (255), 
    IN res_descript TEXT, 
    IN res_path VARCHAR (255),
    IN res_type ENUM ('File', 'Link')
)
BEGIN 
	INSERT INTO resources (title, resc_description, file_path, typeof_resc)
    VALUES (res_title, res_descript, res_path, res_type);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_student` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_student`(
	IN u_idno VARCHAR (50),
	IN u_firstname VARCHAR (50), 
    IN u_middlename VARCHAR (50),
    IN u_lastname VARCHAR (50), 
    IN u_email VARCHAR (50), 
    IN u_course ENUM ('BSIT', 'BSCPE', 'BSCS', 'BSHM', 'BSBA', 'BSCRIM'), 
    IN u_year INT,
    IN u_username VARCHAR(50),
    IN u_password VARCHAR (255)
)
BEGIN 
	START TRANSACTION;
	INSERT INTO users (user_id, first_name, middle_name, last_name, email) 
	VALUES( u_idno, u_firstname, u_middlename, u_lastname, u_email);

	INSERT INTO students (idno, course, year) 
	VALUES (u_idno, u_course, u_year);
    
	INSERT INTO accounts (user_id, user_name, user_password) 
	VALUES (u_idno, u_username, u_password);
	COMMIT; 
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `create_announcement` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `create_announcement`(
	IN admin_ VARCHAR(50),
    IN content TEXT
)
BEGIN 
	INSERT INTO announcements(admin_id, description) VALUES (admin_,content);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `create_feedback` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `create_feedback`(
	IN s_id INT, 
    IN fb_message TEXT,
    IN cons_profanity BOOLEAN
)
BEGIN 
	START TRANSACTION;
	UPDATE feedback
    SET message = fb_message, feedback_time = NOW(),  
		feedback_date = CURDATE(), 
        fbstatus = 'Completed',
        has_profanity = cons_profanity
    WHERE feedback_id = s_id;
    COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `create_notification` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `create_notification`(
	IN user_id VARCHAR(50), 
    IN c_message TEXT, 
    IN notif_type ENUM('Feedback', 'System', 'Admin','Reservation')
)
BEGIN 
	INSERT INTO notifications (user_id, message, notification_type) 
    VALUES (user_id, c_message, notif_type);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `current_sitin` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `current_sitin`()
BEGIN 
	SELECT student_id, TITLECASE(CONCAT(u.first_name,' ' ,u.last_name)) AS "Name", p.type_of_purpose AS "purpose", lab, st.student_session, status
	FROM sessions s INNER JOIN students st ON s.student_id = st.idno INNER JOIN users u ON u.user_id = st.idno
	INNER JOIN purpose p ON s.purpose_id = p.purpose_id
	WHERE isActive = TRUE AND STATUS = 'Active'
	ORDER BY time_in DESC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `end_session` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `end_session`(
	IN std_idno VARCHAR (50), 
    IN std_points INT,
    IN s_timeout DATETIME
    
)
BEGIN 
	UPDATE sessions 
    SET time_out = s_timeout, isActive = FALSE , status = 'Inactive'
    WHERE student_id = std_idno AND isActive = TRUE ;
    
    UPDATE students 
    SET points = points + std_points
    WHERE idno = std_idno;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insert_pcs_for_lab` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_pcs_for_lab`(IN lab INT)
BEGIN
    DECLARE i INT DEFAULT 1;

    WHILE i <= 50 DO
        INSERT INTO pcs (pc_id, lab_id, status)
        VALUES (i, lab, 'Available');
        SET i = i + 1;
    END WHILE;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `search_student` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `search_student`(IN st_idno VARCHAR (50))
BEGIN 
	DECLARE count_active INT;
	SELECT COUNT(*) INTO count_active FROM sessions WHERE student_id = st_idno AND status = 'Active';
    IF count_active = 0 THEN
		SELECT u.user_id, TitleCase(CONCAT(u.first_name, ' ', u.last_name)) AS "Full Name", st.student_session FROM users u INNER JOIN students st ON u.user_id = st.idno
         WHERE st.idno = st_idno ;
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sitin` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sitin`(
	IN s_idno VARCHAR(50),
	IN a_idno VARCHAR(50),
	IN purpose_id INT, 
	IN lab INT
)
BEGIN
	DECLARE active_count INT; -- check if user is active
	START TRANSACTION;
    
	SELECT COUNT(*) INTO active_count 
	FROM sessions 
	WHERE student_id = s_idno AND isActive = TRUE AND status = 'Active';
	
	IF active_count = 0 THEN 
		INSERT INTO sessions (student_id, sitin_by, purpose_id, lab, isActive)
		VALUES (s_idno, NULLIF(a_idno, ''), purpose_id, lab, TRUE);
		
		INSERT INTO feedback(feedback_id) VALUES(LAST_INSERT_ID());
		COMMIT;
	ELSE 
		ROLLBACK;
	END IF;
   
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `student_account` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `student_account`( IN a_username VARCHAR (50) )
BEGIN 
	DECLARE user_exist INT; 
    DECLARE isRole ENUM('Admin','Student');
    SELECT COUNT(*) INTO user_exist FROM accounts WHERE user_name = a_username;
	SELECT type_of_user INTO isRole FROM users u INNER JOIN accounts act ON u.user_id = act.user_id WHERE act.user_name = a_username;
    
	IF  user_exist > 0 AND isRole = 'Student' THEN 
		SELECT a.user_id,a.user_name, a.user_password,type_of_user, st.student_session
		FROM accounts a INNER JOIN users u ON a.user_id = u.user_id INNER JOIN students st ON st.idno = a.user_id
        WHERE a.user_name = a_username;
	ELSE
		SELECT u.user_id, u.first_name, ats.user_name, ats.user_password  ,u.type_of_user  FROM accounts ats INNER JOIN users u ON u.user_id = ats.user_id WHERE ats.user_name = a_username;
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `updatestatus` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `updatestatus`(
    IN in_lab_id INT,
    IN in_pc_ids TEXT,         -- Comma-separated list, e.g. '1,2,5'
    IN in_status VARCHAR(20)
)
BEGIN
    SET @sql = CONCAT(
        'UPDATE pcs SET status = ? WHERE lab_id = ? AND pc_id IN (', in_pc_ids, ')'
    );
    PREPARE stmt FROM @sql;
    SET @status = in_status;
    SET @lab = in_lab_id;
    EXECUTE stmt USING @status, @lab;
    DEALLOCATE PREPARE stmt;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_reservation` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_reservation`(
    IN v_reservation_id INT,
    IN v_status ENUM ('Pending', 'Approved', 'Disapproved')
)
BEGIN 
    DECLARE v_student_id VARCHAR(50);
    DECLARE v_res_date DATE;
    DECLARE v_res_time TIME;
    DECLARE v_lab_id INT;
    DECLARE v_pc_number INT;
    DECLARE v_message TEXT;
    DECLARE v_admin_message TEXT;
    
    -- Get reservation details
    SELECT 
        student_id, 
        res_date, 
        res_time, 
        lab_id, 
        pc_id
    INTO 
        v_student_id, 
        v_res_date, 
        v_res_time, 
        v_lab_id, 
        v_pc_number
    FROM reservation 
    WHERE reserv_id = v_reservation_id;
    
    -- Update the reservation status
    UPDATE reservation 
    SET 
        status = v_status
		WHERE reserv_id = v_reservation_id;
    
    -- Create appropriate message based on status
    CASE v_status
        WHEN 'Approved' THEN
            SET v_message = CONCAT(
                'Your reservation for Lab ', v_lab_id, ' (PC ', v_pc_number, ') on ',
                DATE_FORMAT(v_res_date, '%M %e, %Y'), ' at ',
                TIME_FORMAT(v_res_time, '%h:%i %p'), ' has been approved.'
            );
        WHEN 'Disapproved' THEN
            SET v_message = CONCAT(
                'Your reservation for Lab ', v_lab_id, ' (PC ', v_pc_number, ') on ',
                DATE_FORMAT(v_res_date, '%M %e, %Y'), ' at ',
                TIME_FORMAT(v_res_time, '%h:%i %p'), ' has been disapproved.'
            );
    END CASE;
    
    -- Create admin notification message
    SET v_admin_message = CONCAT(
        'You have updated reservation #', v_reservation_id,
        ' (Lab ', v_lab_id, ', PC ', v_pc_number, ') to status: ', v_status
    );
    
    -- Send notifications
    CALL create_notification(v_student_id, v_message, 'Reservation');
    CALL create_notification(v_student_id, v_admin_message, 'Admin');
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_user` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_user`(
    IN p_user_id VARCHAR (50),
    IN p_first_name VARCHAR(50),
    IN p_middle_name VARCHAR(50),
    IN p_last_name VARCHAR(50),
    IN p_email VARCHAR(50),
    IN p_username VARCHAR(50),
    IN p_password VARCHAR(255),
    IN p_profile_image VARCHAR(100)
)
BEGIN
    -- Update the user_accounts table (excluding username and password)
    UPDATE users
    SET 
        first_name = COALESCE(NULLIF(p_first_name, ''), first_name),
        middle_name = COALESCE(NULLIF(p_middle_name, ''), middle_name),
        last_name = COALESCE(NULLIF(p_last_name, ''), last_name),
        email = COALESCE(NULLIF(p_email, ''), email),
        profile_picture = COALESCE(NULLIF(p_profile_image, ''), profile_picture)
    WHERE user_id = p_user_id;

    UPDATE accounts
    SET 
        user_name = COALESCE(NULLIF(p_username, ''), user_name),
        user_password = COALESCE(NULLIF(p_password, ''), user_password)
    WHERE user_id = p_user_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_user_profile` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_user_profile`(
    IN p_user_id VARCHAR (50),
    IN p_first_name VARCHAR(50),
    IN p_middle_name VARCHAR(50),
    IN p_last_name VARCHAR(50),
    IN p_email VARCHAR(50),
	IN p_course ENUM ('BSIT', 'BSCPE', 'BSCS', 'BSHM', 'BSBA', 'BSCRIM'),
    IN p_year INT,
    IN p_st_session INT,
    IN p_username VARCHAR(50),
    IN p_password VARCHAR(255),
    IN p_profile_image VARCHAR(100)
)
BEGIN
    -- Update the user_accounts table (excluding username and password)
    UPDATE users
    SET 
        first_name = COALESCE(NULLIF(p_first_name, ''), first_name),
        middle_name = COALESCE(NULLIF(p_middle_name, ''), middle_name),
        last_name = COALESCE(NULLIF(p_last_name, ''), last_name),
        email = COALESCE(NULLIF(p_email, ''), email),
        profile_picture = COALESCE(NULLIF(p_profile_image, ''), profile_picture)
    WHERE user_id = p_user_id;
	
    UPDATE students 
    SET 
		course = COALESCE(NULLIF(p_course,''), course),
        year = COALESCE(NULLIF(p_year, ''), year),
        student_session = COALESCE(NULLIF(p_st_session,''), student_session)
	WHERE idno = p_user_id;
    -- Update the authentication table (assuming it's named 'user_credentials')
    UPDATE accounts
    SET 
        user_name = COALESCE(NULLIF(p_username, ''), user_name),
        user_password = COALESCE(NULLIF(p_password, ''), user_password)
    WHERE user_id = p_user_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `daily_report`
--

/*!50001 DROP VIEW IF EXISTS `daily_report`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `daily_report` AS select `s`.`session_id` AS `session_id`,`s`.`student_id` AS `student_id`,`TITLECASE`(concat(`u`.`first_name`,' ',`u`.`last_name`)) AS `Name`,`p`.`type_of_purpose` AS `type_of_purpose`,`s`.`lab` AS `lab`,date_format(`s`.`time_in`,' %I:%i %p ') AS `Login`,date_format(`s`.`time_out`,'%I:%i %p') AS `Logout`,date_format(`s`.`sitin_date`,'%Y-%m-%d') AS `Date` from (((`sessions` `s` join `students` `st` on((`s`.`student_id` = `st`.`idno`))) join `users` `u` on((`st`.`idno` = `u`.`user_id`))) join `purpose` `p` on((`p`.`purpose_id` = `s`.`purpose_id`))) where (`s`.`sitin_date` = curdate()) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `display_announcements`
--

/*!50001 DROP VIEW IF EXISTS `display_announcements`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `display_announcements` AS select `announcements`.`announcement_id` AS `announcement_id`,`announcements`.`created_by` AS `created_by`,date_format(`announcements`.`date_created`,'%Y-%b-%d') AS `Date`,`announcements`.`description` AS `description` from `announcements` order by `announcements`.`announcement_id` desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `display_feedabacks`
--

/*!50001 DROP VIEW IF EXISTS `display_feedabacks`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `display_feedabacks` AS select `s`.`session_id` AS `session_id`,`s`.`student_id` AS `student_id`,`TITLECASE`(concat(`u`.`first_name`,' ',`u`.`last_name`)) AS `Name`,`st`.`COURSE` AS `course`,`s`.`lab` AS `lab`,date_format(`s`.`time_in`,' %I:%i %p ') AS `Login`,date_format(`s`.`time_out`,'%I:%i %p') AS `Logout`,date_format(`s`.`sitin_date`,'%Y-%m-%d') AS `Date`,`fb`.`message` AS `message` from ((((`sessions` `s` join `students` `st` on((`s`.`student_id` = `st`.`idno`))) join `users` `u` on((`st`.`idno` = `u`.`user_id`))) join `purpose` `p` on((`p`.`purpose_id` = `s`.`purpose_id`))) join `feedback` `fb` on((`s`.`session_id` = `fb`.`feedback_id`))) where (`s`.`isActive` = false) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `display_reservation`
--

/*!50001 DROP VIEW IF EXISTS `display_reservation`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `display_reservation` AS select `r`.`reserv_id` AS `reserv_id`,`st`.`idno` AS `idno`,`TITLECASE`(concat(`u`.`first_name`,' ',`u`.`last_name`)) AS `Name`,`p`.`type_of_purpose` AS `type_of_purpose`,`r`.`lab_id` AS `lab_id`,`r`.`pc_id` AS `pc_id`,`r`.`res_date` AS `res_date`,date_format(`r`.`res_time`,'%h:%i %p') AS `reserv_time`,`r`.`status` AS `status` from (((`reservation` `r` join `purpose` `p` on((`p`.`purpose_id` = `r`.`purpose_id`))) join `students` `st` on((`r`.`student_id` = `st`.`idno`))) join `users` `u` on((`st`.`idno` = `u`.`user_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `full_student_information`
--

/*!50001 DROP VIEW IF EXISTS `full_student_information`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `full_student_information` AS select `st`.`idno` AS `idno`,`TITLECASE`(`u`.`first_name`) AS `First Name,`,`TITLECASE`(`u`.`middle_name`) AS `Middle Name`,`TITLECASE`(`u`.`last_name`) AS `Last Name`,`u`.`email` AS `email`,`st`.`COURSE` AS `course`,`st`.`year` AS `year`,`st`.`student_session` AS `student_session`,`act`.`user_name` AS `user_name`,`act`.`user_password` AS `user_password`,`u`.`profile_picture` AS `profile_picture` from ((`students` `st` join `users` `u` on((`st`.`idno` = `u`.`user_id`))) join `accounts` `act` on((`act`.`user_id` = `u`.`user_id`))) where (`u`.`type_of_user` = 'Student') */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `leaderboard`
--

/*!50001 DROP VIEW IF EXISTS `leaderboard`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `leaderboard` AS select `u`.`user_id` AS `user_id`,concat(`TITLECASE`(`u`.`first_name`),' ',`TITLECASE`(`u`.`middle_name`),' ',`TITLECASE`(`u`.`last_name`)) AS `Full Name`,`st`.`COURSE` AS `course`,`st`.`points` AS `points` from (`users` `u` join `students` `st` on((`u`.`user_id` = `st`.`idno`))) order by `st`.`points` desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `logout_records`
--

/*!50001 DROP VIEW IF EXISTS `logout_records`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `logout_records` AS select `s`.`session_id` AS `session_id`,`s`.`student_id` AS `student_id`,`TITLECASE`(concat(`u`.`first_name`,' ',`u`.`last_name`)) AS `Name`,`p`.`type_of_purpose` AS `type_of_purpose`,`s`.`lab` AS `lab`,date_format(`s`.`time_in`,' %I:%i %p ') AS `Login`,date_format(`s`.`time_out`,'%I:%i %p') AS `Logout`,date_format(`s`.`sitin_date`,'%Y-%m-%d') AS `Date`,`fb`.`fbstatus` AS `fbstatus` from ((((`sessions` `s` join `students` `st` on((`s`.`student_id` = `st`.`idno`))) join `users` `u` on((`st`.`idno` = `u`.`user_id`))) join `purpose` `p` on((`p`.`purpose_id` = `s`.`purpose_id`))) join `feedback` `fb` on((`s`.`session_id` = `fb`.`feedback_id`))) where (`s`.`isActive` = false) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `profile_view`
--

/*!50001 DROP VIEW IF EXISTS `profile_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `profile_view` AS select `u`.`user_id` AS `user_id`,`u`.`profile_picture` AS `profile_picture`,`u`.`first_name` AS `first_name`,`u`.`middle_name` AS `middle_name`,`u`.`last_name` AS `last_name`,`u`.`email` AS `email`,`act`.`user_name` AS `user_name`,`act`.`user_password` AS `user_password` from (`users` `u` join `accounts` `act` on((`u`.`user_id` = `act`.`user_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `sitin_reports`
--

/*!50001 DROP VIEW IF EXISTS `sitin_reports`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `sitin_reports` AS select `s`.`session_id` AS `session_id`,`s`.`student_id` AS `student_id`,`TITLECASE`(concat(`u`.`first_name`,' ',`u`.`last_name`)) AS `Name`,`p`.`type_of_purpose` AS `type_of_purpose`,`s`.`lab` AS `lab`,date_format(`s`.`time_in`,' %I:%i %p ') AS `Login`,date_format(`s`.`time_out`,'%I:%i %p') AS `Logout`,date_format(`s`.`sitin_date`,'%Y-%m-%d') AS `Date` from (((`sessions` `s` join `students` `st` on((`s`.`student_id` = `st`.`idno`))) join `users` `u` on((`st`.`idno` = `u`.`user_id`))) join `purpose` `p` on((`p`.`purpose_id` = `s`.`purpose_id`))) order by date_format(`s`.`time_out`,'%I:%i %p') desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `student_information`
--

/*!50001 DROP VIEW IF EXISTS `student_information`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `student_information` AS select `st`.`idno` AS `idno`,`TITLECASE`(concat(`u`.`first_name`,' ',`u`.`middle_name`,' ',`u`.`last_name`)) AS `name`,`st`.`COURSE` AS `course`,`st`.`year` AS `year`,`st`.`student_session` AS `student_session`,`st`.`points` AS `points` from (`students` `st` join `users` `u` on((`st`.`idno` = `u`.`user_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-05-17  1:39:30
