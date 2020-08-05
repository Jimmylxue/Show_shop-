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
-- Table structure for table `video`
--

DROP TABLE IF EXISTS `video`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `video` (
  `videoId` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(45) NOT NULL,
  `img` text NOT NULL,
  `url` text NOT NULL,
  PRIMARY KEY (`videoId`)
) ENGINE=InnoDB AUTO_INCREMENT=1020 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `video`
--

LOCK TABLES `video` WRITE;
/*!40000 ALTER TABLE `video` DISABLE KEYS */;
INSERT INTO `video` VALUES (1001,'小米10 8K手机拍大片','http://127.0.0.1:666/goodimg/1596295742564.jpeg','https://cdn.cnbj1.fds.api.mi-img.com/mi-mall/e25d81c4922fca5ebe51877717ef9b76.mp4'),(1013,'小米电视5 创新背后的故事','http://127.0.0.1:666/videoImg/1596296410014.jpeg','https://cdn.cnbj1.fds.api.mi-img.com/mi-mall/efea1979661bac0d1704d761e5e89ded.mp4'),(1018,'小米手环4 改变从今开始','http://127.0.0.1:666/videoImg/1596379821724.jpeg','https://cdn.cnbj1.fds.api.mi-img.com/mi-mall/f2661b967a319f358fabe822aed708e6.mp4'),(1019,'Redmi 10X系列发布会','http://127.0.0.1:666/videoImg/1596379970824.jpeg','https://cdn.cnbj1.fds.api.mi-img.com/mi-mall/11c70c96529b6e6938567ec1aa0910e0.mp4');
/*!40000 ALTER TABLE `video` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-08-06  0:19:46
