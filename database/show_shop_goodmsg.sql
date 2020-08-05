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
-- Table structure for table `goodmsg`
--

DROP TABLE IF EXISTS `goodmsg`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `goodmsg` (
  `goodid` int(11) NOT NULL AUTO_INCREMENT,
  `goodname` varchar(45) NOT NULL,
  `gooddesc` text,
  `goodimg` varchar(150) DEFAULT NULL,
  `freight` int(11) DEFAULT NULL,
  `type` varchar(45) DEFAULT NULL,
  `capacity` varchar(45) DEFAULT NULL,
  `classify` varchar(45) DEFAULT NULL,
  `brand` varchar(45) DEFAULT NULL,
  `price` int(11) DEFAULT NULL,
  `sale` int(11) DEFAULT '0',
  `count` int(11) DEFAULT '1',
  `tag` varchar(45) NOT NULL DEFAULT 'recommand',
  `nowPrice` int(11) NOT NULL DEFAULT '0',
  `imgs` text,
  PRIMARY KEY (`goodid`)
) ENGINE=InnoDB AUTO_INCREMENT=1040 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `goodmsg`
--

LOCK TABLES `goodmsg` WRITE;
/*!40000 ALTER TABLE `goodmsg` DISABLE KEYS */;
INSERT INTO `goodmsg` VALUES (1001,'小米10 Pro','【限时享24期免息向往的生活同款】小米10Pro5g手机骁龙865处理器5G手机学生拍照小米官方旗舰店官网正品米10','http://127.0.0.1:666/goodimg/10Pro.jpg',0,'官方标配  全新','6+128','手机','小米',4999,41,71,'discount',4899,'http://127.0.0.1:666/goodimgs/1593940920397.jpeg@http://127.0.0.1:666/goodimgs/1593940970859.jpeg@http://127.0.0.1:666/goodimgs/1593940992446.jpeg@http://127.0.0.1:666/goodimgs/1593941048794.jpeg'),(1002,'小米10 Pro','【限时享24期免息向往的生活同款】小米10Pro5g手机骁龙865处理器5G手机学生拍照小米官方旗舰店官网正品米10','http://127.0.0.1:666/goodimg/10Pro.jpg',0,'二手','8+256','手机','小米',4500,24,96,'discount',4300,'http://127.0.0.1:666/goodimgs/1593940920397.jpeg@http://127.0.0.1:666/goodimgs/1593940970859.jpeg@http://127.0.0.1:666/goodimgs/1593940992446.jpeg@http://127.0.0.1:666/goodimgs/1593941048794.jpeg'),(1003,'Redmi Note 8 Pro','官方Xiaomi/小米 Redmi Note8 Pro旗舰红米note8pro手机正note7 9','http://127.0.0.1:666/goodimg/redmi.png',0,'全新','8+128','手机','小米',1799,0,50,'discount',1699,'http://127.0.0.1:666/goodimgs/1593953918298.jpeg@http://127.0.0.1:666/goodimgs/1593953927990.jpeg@http://127.0.0.1:666/goodimgs/1593953937479.jpeg'),(1004,'苹果AirPods Pro','主动降噪、抗汗抗水，妙得不同凡响！','http://127.0.0.1:666/goodimg/airpodPro.jpg',0,'全新','AirPod+保护壳','耳机','苹果',1819,0,300,'recommand',1819,NULL),(1016,'红米10X 4G版','【当天发货+送小米耳机】红米10X 4G版 Xiaomi/小米 Redmi 10X手机 新品官方旗舰店9红米10pro小米手机10xpro','http://127.0.0.1:666/goodimg/红米10X 4G版1592063126900.jpeg',0,'否','4+128','手机','电脑',999,0,1,'discount',899,NULL),(1017,'小米E55A 电视','小米全面屏电视E55A 55英寸 网络人工智能4K高清液晶平板电视机4X','http://127.0.0.1:666/goodimg/小米E55A 电视1592063465010.png',20,'否','2+8','电视','电脑',1649,0,1,'recommand',0,NULL),(1019,'小莫AIR2S 耳机','Xiaomi/小米小米蓝牙耳机Air2S真无线降噪跑步双耳触控入耳式迷你','http://127.0.0.1:666/goodimg/小莫AIR2S 耳机1592063771899.jpeg',0,'否','半入耳式','耳机','电脑',309,0,1,'discount',299,'http://127.0.0.1:666/goodimgs/1593954808606.jpeg@http://127.0.0.1:666/goodimgs/1593954817183.jpeg@http://127.0.0.1:666/goodimgs/1593954826084.jpeg@http://127.0.0.1:666/goodimgs/1593954834277.jpeg'),(1020,'HUAWEI MATEBOOK 13','Huawei/华为 MateBook 13 锐龙版 R5+8GB/16GB+512GB SSD 集显 Windows系统 笔记本电脑','http://127.0.0.1:666/goodimg/HUAWEI MATEBOOK 131592064063698.jpeg',0,'否','12+512','电脑','手机',4499,0,1,'recommand',0,NULL),(1021,'荣耀30 PRO','荣耀30pro 华为honor/荣耀 荣耀30 5G手机荣耀30pro+官方荣耀30s','http://127.0.0.1:666/goodimg/荣耀30 PRO1592064234632.jpeg',0,'否','6+128','手机','手机',2408,0,1,'discount',2100,NULL),(1022,'iPhone XR','Apple/苹果 iPhone XR 苹果xr全新Plus苹果8x xs max国行双卡手机','http://127.0.0.1:666/goodimg/iPhone XR1592064549966.jpeg',0,'否','64G','手机','耳机',3130,0,1,'recommand',0,NULL),(1023,'MacBook Pro','[新品减600元 24期免息]Apple/苹果MacBook Pro 13.3英寸2020新款苹果笔记本电脑八代i5四核处理器256G/512G','http://127.0.0.1:666/goodimg/MacBook Pro1592065284810.jpeg',0,'否','8+256','电脑','耳机',10588,0,1,'recommand',0,NULL),(1024,'华为智慧屏','华为智慧屏 V55i-A星际黑 55吋 4K LCD全面屏 开机无广告4GB+64GB','http://127.0.0.1:666/goodimg/华为智慧屏1592065944970.jpeg',0,'否','4+64','电视','手机',3999,0,1,'recommand',0,NULL),(1025,'小米手环4 NFC版本','小米手环4智能手表心率监测蓝牙男女款运动计步器微信支付宝天气心率睡眠手环5','http://127.0.0.1:666/goodimg/小米手环4 NFC版本1592066372543.jpeg',0,'否','NFC版本','手表/手环','电脑',199,0,1,'recommand',0,'http://127.0.0.1:666/goodimgs/1593954396889.jpeg@http://127.0.0.1:666/goodimgs/1593954404679.jpeg@http://127.0.0.1:666/goodimgs/1593954412406.jpeg@http://127.0.0.1:666/goodimgs/1593954419370.jpeg'),(1026,'测试测试','测试测试测试测试测试测试测试测试测试测试','http://127.0.0.1:666/goodimg/测试测试1592113726296.jpeg',0,'否','128','手机','耳机',6999,0,1,'recommand',0,NULL),(1027,'测试手机','按实际dkansLDKNSldQASDKL按时d','http://127.0.0.1:666/goodimg/测试手机1592113796330.jpeg',0,'否','5999','手机','电脑',8888,0,1,'recommand',0,NULL),(1028,'测试iPhone','asjdnsA 安马德里\nASDsad\n','http://127.0.0.1:666/goodimg/测试iPhone1592113940510.jpeg',0,'否','158','电脑','耳机',7999,0,1,'recommand',0,NULL),(1035,'专业测试','测试测试测试测试99999999999999999','http://127.0.0.1:666/goodimg/专业测试1593856455286.jpeg',0,'否','896','电脑','电脑',885,0,1,'recommand',0,'http://127.0.0.1:666/goodimgs/专业测试1593856455287.png@http://127.0.0.1:666/goodimgs/专业测试1593856455288.jpeg'),(1036,'测试二号','987546216851458641123','http://127.0.0.1:666/goodimg/测试二号1593856545674.png',0,'否','89416','耳机','电脑',155555,0,1,'recommand',0,'http://127.0.0.1:666/goodimgs/测试二号1593856545674.jpeg@http://127.0.0.1:666/goodimgs/测试二号1593856545675.png'),(1039,'新欢耳机','8888888888888888888888888888888888888888888888','http://127.0.0.1:666/goodimg/小莫AIR2S 耳机1592063771899.jpeg',0,'否','8+56','电视','手机',296,0,1,'recommand',0,'http://127.0.0.1:666/goodimg/10Pro.jpg@http://127.0.0.1:666/goodimg/HUAWEI MATEBOOK 131592064063698.jpeg@http://127.0.0.1:666/goodimg/airpodPro.jpg');
/*!40000 ALTER TABLE `goodmsg` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-08-06  0:19:44
