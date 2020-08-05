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
-- Table structure for table `cart`
--

DROP TABLE IF EXISTS `cart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cart` (
  `cartid` int(11) NOT NULL AUTO_INCREMENT,
  `userid` int(11) NOT NULL,
  `goodid` int(11) NOT NULL,
  `goodname` varchar(45) NOT NULL,
  `gooddesc` text NOT NULL,
  `goodcount` int(11) NOT NULL,
  `goodprice` int(11) NOT NULL,
  `goodfreight` int(11) NOT NULL,
  `goodimg` text NOT NULL,
  PRIMARY KEY (`cartid`)
) ENGINE=InnoDB AUTO_INCREMENT=1018 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart`
--

LOCK TABLES `cart` WRITE;
/*!40000 ALTER TABLE `cart` DISABLE KEYS */;
INSERT INTO `cart` VALUES (1005,173117030,1003,'Redmi Note 8 Pro','官方Xiaomi/小米 Redmi Note8 Pro旗舰红米note8pro手机正note7 9',1,1799,0,'http://127.0.0.1:666/goodimg/redmi.png'),(1007,173117030,1023,'MacBook Pro','[新品减600元 24期免息]Apple/苹果MacBook Pro 13.3英寸2020新款苹果笔记本电脑八代i5四核处理器256G/512G',1,10588,0,'http://127.0.0.1:666/goodimg/MacBook Pro1592065284810.jpeg'),(1009,173117030,1004,'苹果AirPods Pro','主动降噪、抗汗抗水，妙得不同凡响！',1,1819,0,'http://127.0.0.1:666/goodimg/airpodPro.jpg'),(1010,173117030,1024,'华为智慧屏','华为智慧屏 V55i-A星际黑 55吋 4K LCD全面屏 开机无广告4GB+64GB',3,3999,0,'http://127.0.0.1:666/goodimg/华为智慧屏1592065944970.jpeg'),(1011,173117030,1017,'小米E55A 电视','小米全面屏电视E55A 55英寸 网络人工智能4K高清液晶平板电视机4X',1,1649,20,'http://127.0.0.1:666/goodimg/小米E55A 电视1592063465010.png'),(1012,173117030,1003,'Redmi Note 8 Pro','官方Xiaomi/小米 Redmi Note8 Pro旗舰红米note8pro手机正note7 9',1,1799,0,'http://127.0.0.1:666/goodimg/redmi.png'),(1013,173117030,1001,'小米10 Pro','【限时享24期免息向往的生活同款】小米10Pro5g手机骁龙865处理器5G手机学生拍照小米官方旗舰店官网正品米10',1,4999,0,'http://127.0.0.1:666/goodimg/10Pro.jpg'),(1016,173117031,1003,'Redmi Note 8 Pro','官方Xiaomi/小米 Redmi Note8 Pro旗舰红米note8pro手机正note7 9',1,1799,0,'http://127.0.0.1:666/goodimg/redmi.png'),(1017,173117031,1004,'苹果AirPods Pro','主动降噪、抗汗抗水，妙得不同凡响！',1,1819,0,'http://127.0.0.1:666/goodimg/airpodPro.jpg');
/*!40000 ALTER TABLE `cart` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-08-06  0:19:45
