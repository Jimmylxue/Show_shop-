-- MySQL dump 10.13  Distrib 5.7.12, for Win64 (x86_64)
--
-- Host: localhost    Database: show_shop
-- ------------------------------------------------------
-- Server version	5.7.17-log

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

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `orders` (
  `orderid` int(11) NOT NULL AUTO_INCREMENT,
  `userid` int(11) NOT NULL,
  `buyname` varchar(45) NOT NULL,
  `username` varchar(45) NOT NULL,
  `orderprice` int(11) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `goodid` varchar(50) NOT NULL,
  `goodcount` int(11) NOT NULL,
  `province` varchar(45) NOT NULL,
  `city` varchar(45) NOT NULL,
  `area` varchar(45) NOT NULL,
  `detail` varchar(200) NOT NULL,
  `createtime` varchar(50) NOT NULL,
  `paystatus` int(11) NOT NULL DEFAULT '0',
  `send` int(11) NOT NULL DEFAULT '0',
  `payWay` int(11) DEFAULT '0',
  PRIMARY KEY (`orderid`)
) ENGINE=InnoDB AUTO_INCREMENT=1007 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1001,173117030,'jimmy','Jimmy',6999,'19905076109','-1001',1,'福建省','福州市','晋安区','双翔新村3座301','555',0,0,0),(1002,173117031,'Jimmy','123',4999,'123','-1001',1,'天津市','天津市','河东区','13','1593013718858',1,0,0),(1003,173117031,'Jimmy','123',4999,'123','-1001',1,'天津市','天津市','河东区','13','1593014158816',1,0,0),(1004,173117031,'Jimmy','123',4999,'123','-1001',1,'天津市','天津市','河东区','13','1593014581899',1,0,1),(1005,173117031,'Jimmy','123',4999,'123','-1001',1,'天津市','天津市','河东区','13','1593014615453',1,0,1),(1006,173117031,'Jimmy','123',1819,'123','-1004',1,'天津市','天津市','河东区','13','1595851784762',1,0,0);
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-08-06  0:19:47
