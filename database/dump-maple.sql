-- MySQL dump 10.13  Distrib 5.5.62, for Win64 (AMD64)
--
-- Database: maple
-- ------------------------------------------------------
-- Server version	5.7.27

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

CREATE DATABASE maple;
USE maple;
--
-- Table structure for table `CheckOut`
--

DROP TABLE IF EXISTS `CheckOut`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CheckOut` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `price_total` decimal(13,2) DEFAULT NULL,
  `delivery_charge` decimal(13,2) DEFAULT NULL,
  `grand_total` decimal(13,2) DEFAULT NULL,
  `paid_amt` decimal(13,2) DEFAULT NULL,
  `payment_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `CheckOut_FK` (`user_id`),
  CONSTRAINT `CheckOut_FK` FOREIGN KEY (`user_id`) REFERENCES `Users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CheckOut`
--

LOCK TABLES `CheckOut` WRITE;
/*!40000 ALTER TABLE `CheckOut` DISABLE KEYS */;
INSERT INTO `CheckOut` VALUES (1,1,700.00,0.00,700.00,700.00,NULL);
/*!40000 ALTER TABLE `CheckOut` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CheckOutDet`
--

DROP TABLE IF EXISTS `CheckOutDet`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CheckOutDet` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `checkout_Id` int(11) NOT NULL,
  `product_id` int(11) DEFAULT NULL,
  `qty` int(11) DEFAULT NULL,
  `price` decimal(13,2) NOT NULL,
  `price_total` decimal(13,2) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `CheckOutDet_FK` (`checkout_Id`),
  KEY `CheckOutDet_FK_1` (`product_id`),
  CONSTRAINT `CheckOutDet_FK` FOREIGN KEY (`checkout_Id`) REFERENCES `CheckOut` (`id`),
  CONSTRAINT `CheckOutDet_FK_1` FOREIGN KEY (`product_id`) REFERENCES `Products` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CheckOutDet`
--

LOCK TABLES `CheckOutDet` WRITE;
/*!40000 ALTER TABLE `CheckOutDet` DISABLE KEYS */;
/*!40000 ALTER TABLE `CheckOutDet` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Payments`
--

DROP TABLE IF EXISTS `Payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Payments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `checkout_id` int(11) DEFAULT NULL,
  `payment_amt` decimal(13,2) DEFAULT NULL,
  `bank_id` int(11) DEFAULT NULL,
  `payment_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Payments`
--

LOCK TABLES `Payments` WRITE;
/*!40000 ALTER TABLE `Payments` DISABLE KEYS */;
/*!40000 ALTER TABLE `Payments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ProductCategory`
--

DROP TABLE IF EXISTS `ProductCategory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ProductCategory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category_name` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ProductCategory`
--

LOCK TABLES `ProductCategory` WRITE;
/*!40000 ALTER TABLE `ProductCategory` DISABLE KEYS */;
INSERT INTO `ProductCategory` VALUES (1,'Electronics'),(2,'Others');
/*!40000 ALTER TABLE `ProductCategory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Products`
--

DROP TABLE IF EXISTS `Products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Products` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `product_name` varchar(100) DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL,
  `img_url` varchar(500) DEFAULT NULL,
  `price` decimal(13,2) DEFAULT NULL,
  `QtyOnHand` int(11) DEFAULT NULL,
  `store_id` int(11) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `Products_FK` (`category_id`),
  KEY `Products_FK_1` (`store_id`),
  CONSTRAINT `Products_FK` FOREIGN KEY (`category_id`) REFERENCES `ProductCategory` (`id`),
  CONSTRAINT `Products_FK_1` FOREIGN KEY (`store_id`) REFERENCES `Stores` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Products`
--

LOCK TABLES `Products` WRITE;
/*!40000 ALTER TABLE `Products` DISABLE KEYS */;
INSERT INTO `Products` VALUES (1,'TV 42\"',1,'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ftse1.mm.bing.net%2Fth%3Fid%3DOIP.h4izqKuim5L4HoSltwKHugHaEw%26pid%3DApi&f=1',400.00,5,1,'2020-08-17 03:08:04'),(2,'Phone',1,'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ftse1.mm.bing.net%2Fth%3Fid%3DOIP.2acY5XNFXbQWUTuz9EjMowHaGc%26pid%3DApi&f=1',300.00,3,1,'2020-08-17 03:08:53');
/*!40000 ALTER TABLE `Products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Stores`
--

DROP TABLE IF EXISTS `Stores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Stores` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `store_name` varchar(100) DEFAULT NULL,
  `location_lat` double DEFAULT NULL,
  `location_lon` double DEFAULT NULL,
  `verifiedDate` datetime DEFAULT NULL,
  `createdDate` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Stores`
--

LOCK TABLES `Stores` WRITE;
/*!40000 ALTER TABLE `Stores` DISABLE KEYS */;
INSERT INTO `Stores` VALUES (1,'Sample Store',NULL,NULL,'2020-08-18 02:33:54','2020-08-18 02:33:56');
/*!40000 ALTER TABLE `Stores` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `UserCart`
--

DROP TABLE IF EXISTS `UserCart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `UserCart` (
  `user_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `qty` int(11) DEFAULT NULL,
  `price` decimal(13,2) DEFAULT NULL,
  `added_date` datetime DEFAULT NULL,
  PRIMARY KEY (`user_id`,`product_id`),
  KEY `UserCart_FK_1` (`product_id`),
  CONSTRAINT `UserCart_FK` FOREIGN KEY (`user_id`) REFERENCES `Users` (`id`),
  CONSTRAINT `UserCart_FK_1` FOREIGN KEY (`product_id`) REFERENCES `Products` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `Users`
--

DROP TABLE IF EXISTS `Users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(100) DEFAULT NULL,
  `password` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `registeredDate` datetime DEFAULT NULL,
  `verifiedDate` datetime DEFAULT NULL,
  `store_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `Users_FK` (`store_id`),
  CONSTRAINT `Users_FK` FOREIGN KEY (`store_id`) REFERENCES `Stores` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Users`
--

LOCK TABLES `Users` WRITE;
/*!40000 ALTER TABLE `Users` DISABLE KEYS */;
INSERT INTO `Users` VALUES (1,'admin','@dmin','admin@admin.com',NULL,NULL,NULL),(2,'store','st0re','store@store.com',NULL,NULL,1);
/*!40000 ALTER TABLE `Users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'maple'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-08-18 10:00:38
