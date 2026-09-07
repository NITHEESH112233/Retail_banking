-- MySQL dump 10.13  Distrib 8.0.45, for Win64 (x86_64)
--
-- Host: localhost    Database: banking
-- ------------------------------------------------------
-- Server version	8.0.45

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `beneficiary`
--

DROP TABLE IF EXISTS `beneficiary`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `beneficiary` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `account_number` varchar(255) DEFAULT NULL,
  `bank_name` varchar(255) DEFAULT NULL,
  `bene_name` varchar(255) DEFAULT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKmkfkbu9655qndvih6ffs35l3u` (`user_id`),
  CONSTRAINT `FKmkfkbu9655qndvih6ffs35l3u` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `beneficiary`
--

LOCK TABLES `beneficiary` WRITE;
/*!40000 ALTER TABLE `beneficiary` DISABLE KEYS */;
INSERT INTO `beneficiary` VALUES (1,'123456789','indian','sandeep',2),(2,'09876543','kotak','koushik',1),(3,'09876543','kotak','pravven',5),(4,'432435786970','fgfsh','koushik',5),(5,'31587209','hyper','pravven',6),(6,'28415818814','kotak','pravven',5),(7,'1323456789','kotak','koushik',8);
/*!40000 ALTER TABLE `beneficiary` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transaction`
--

DROP TABLE IF EXISTS `transaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transaction` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `amount` decimal(38,2) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `timestamp` datetime(6) DEFAULT NULL,
  `beneficiary_id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK5r0nx1xqrmc2xlovgmh8lpn5` (`beneficiary_id`),
  KEY `FKanjpo5tiapru7an6cw4cu37y4` (`user_id`),
  CONSTRAINT `FK5r0nx1xqrmc2xlovgmh8lpn5` FOREIGN KEY (`beneficiary_id`) REFERENCES `beneficiary` (`id`),
  CONSTRAINT `FKanjpo5tiapru7an6cw4cu37y4` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transaction`
--

LOCK TABLES `transaction` WRITE;
/*!40000 ALTER TABLE `transaction` DISABLE KEYS */;
INSERT INTO `transaction` VALUES (1,10000.00,'SUCCESS','2026-04-07 16:01:55.728250',1,2),(2,123.00,'FAILED (Insufficient Balance)','2026-04-07 16:02:15.274665',1,2),(3,1.00,'SUCCESS','2026-04-07 16:05:41.217437',2,1),(4,10001.00,'SUCCESS','2026-04-08 22:06:09.855042',3,5),(5,2000.00,'SUCCESS','2026-04-09 21:20:38.739130',4,5),(6,987.00,'SUCCESS','2026-04-10 16:30:12.410805',5,6),(7,234.00,'SUCCESS','2026-04-11 10:22:30.629400',4,5),(8,234.00,'SUCCESS','2026-04-28 09:46:15.549310',7,8);
/*!40000 ALTER TABLE `transaction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `balance` decimal(38,2) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `role` varchar(255) DEFAULT NULL,
  `username` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UKr43af9ap4edm43mmtq01oddj6` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,9999.00,'Nitheesh','123456','USER','nitheesh'),(2,0.00,'Nithish Reddem','1234567890','USER','bro'),(3,NULL,'Nitheesh','RCq5jQr9@','USER','bro12'),(4,NULL,'praveen','Hello@143','USER','praveen'),(5,87765.00,'koushik','kousi12','USER','koushik'),(6,99013.00,'jack','123456','USER','jack'),(7,100000.00,'ram','ram123','USER','ram'),(8,99766.00,'Nitheesh','bro1234','USER','brother');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-04-28 11:39:54
