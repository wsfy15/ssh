-- MySQL dump 10.13  Distrib 5.7.24, for Linux (x86_64)
--
-- Host: localhost    Database: ssh
-- ------------------------------------------------------
-- Server version	5.7.24-0ubuntu0.16.04.1

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
-- Table structure for table `Admin`
--

DROP TABLE IF EXISTS `Admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Admin` (
  `ad_id` varchar(255) NOT NULL,
  `ad_name` varchar(255) DEFAULT NULL,
  `ad_password` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ad_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Admin`
--

LOCK TABLES `Admin` WRITE;
/*!40000 ALTER TABLE `Admin` DISABLE KEYS */;
INSERT INTO `Admin` VALUES ('1000000000','小白','e10adc3949ba59abbe56e057f20f883e');
/*!40000 ALTER TABLE `Admin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Assignment`
--

DROP TABLE IF EXISTS `Assignment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Assignment` (
  `as_id` varchar(255) NOT NULL,
  `as_name` varchar(255) DEFAULT NULL,
  `as_describe` varchar(255) DEFAULT NULL,
  `as_ddl` date DEFAULT NULL,
  `as_assigntime` time DEFAULT NULL,
  `as_co_id` varchar(255) DEFAULT NULL,
  `as_proportion` int(11) DEFAULT NULL,
  PRIMARY KEY (`as_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Assignment`
--

LOCK TABLES `Assignment` WRITE;
/*!40000 ALTER TABLE `Assignment` DISABLE KEYS */;
/*!40000 ALTER TABLE `Assignment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Course`
--

DROP TABLE IF EXISTS `Course`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Course` (
  `co_id` varchar(255) NOT NULL,
  `co_name` varchar(255) DEFAULT NULL,
  `co_ro_num` int(11) DEFAULT NULL,
  `co_date` date DEFAULT NULL,
  `co_describe` varchar(255) DEFAULT NULL,
  `co_teacher` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`co_id`),
  KEY `FKjuk3287jofybfmuf7mplmbqck` (`co_teacher`),
  CONSTRAINT `FKjuk3287jofybfmuf7mplmbqck` FOREIGN KEY (`co_teacher`) REFERENCES `Teacher` (`te_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Course`
--

LOCK TABLES `Course` WRITE;
/*!40000 ALTER TABLE `Course` DISABLE KEYS */;
INSERT INTO `Course` VALUES ('000000','test',2,'2018-01-27','test','1010000000'),('000001','test2',12,'2018-01-29','test2','1010000000');
/*!40000 ALTER TABLE `Course` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Homework`
--

DROP TABLE IF EXISTS `Homework`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Homework` (
  `ho_as_id` varchar(255) NOT NULL,
  `ho_gr_id` varchar(255) NOT NULL,
  `ho_time` date DEFAULT NULL,
  `ho_path` varchar(255) DEFAULT NULL,
  `ho_name` varchar(255) DEFAULT NULL,
  `ho_us_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ho_as_id`,`ho_gr_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Homework`
--

LOCK TABLES `Homework` WRITE;
/*!40000 ALTER TABLE `Homework` DISABLE KEYS */;
/*!40000 ALTER TABLE `Homework` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Student`
--

DROP TABLE IF EXISTS `Student`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Student` (
  `st_id` varchar(255) NOT NULL,
  `st_name` varchar(255) DEFAULT NULL,
  `st_class` varchar(255) DEFAULT NULL,
  `st_password` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`st_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Student`
--

LOCK TABLES `Student` WRITE;
/*!40000 ALTER TABLE `Student` DISABLE KEYS */;
INSERT INTO `Student` VALUES ('2015000001','aa','2015211301','202cb962ac59075b964b07152d234b70'),('2015000002','bb','2015211302','d81f9c1be2e08964bf9f24b15f0e4900'),('2015000003','cc','2015211304','250cf8b51c773f3f8dc8b4be867a9a02'),('2015000004','aa','2015211301','202cb962ac59075b964b07152d234b70'),('2015000005','bb','2015211302','d81f9c1be2e08964bf9f24b15f0e4900'),('2015000006','cc','2015211304','250cf8b51c773f3f8dc8b4be867a9a02'),('2015000007','aa','2015211301','202cb962ac59075b964b07152d234b70'),('2015000008','bb','2015211302','d81f9c1be2e08964bf9f24b15f0e4900'),('2015000009','cc','2015211304','250cf8b51c773f3f8dc8b4be867a9a02'),('2015211003','小黑','2015211002','e10adc3949ba59abbe56e057f20f883e');
/*!40000 ALTER TABLE `Student` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Teacher`
--

DROP TABLE IF EXISTS `Teacher`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Teacher` (
  `te_id` varchar(255) NOT NULL,
  `te_name` varchar(255) DEFAULT NULL,
  `te_password` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`te_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Teacher`
--

LOCK TABLES `Teacher` WRITE;
/*!40000 ALTER TABLE `Teacher` DISABLE KEYS */;
INSERT INTO `Teacher` VALUES ('1010000000','小王','e10adc3949ba59abbe56e057f20f883e');
/*!40000 ALTER TABLE `Teacher` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_course`
--

DROP TABLE IF EXISTS `student_course`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `student_course` (
  `co_id` varchar(255) NOT NULL,
  `id` varchar(255) NOT NULL,
  PRIMARY KEY (`id`,`co_id`),
  KEY `FKbkh2n7ypef6xfa8xn2lbn47fj` (`co_id`),
  CONSTRAINT `FKbkh2n7ypef6xfa8xn2lbn47fj` FOREIGN KEY (`co_id`) REFERENCES `Course` (`co_id`),
  CONSTRAINT `FKi2p71h5ttuy358t8r1lcn84ih` FOREIGN KEY (`id`) REFERENCES `Student` (`st_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_course`
--

LOCK TABLES `student_course` WRITE;
/*!40000 ALTER TABLE `student_course` DISABLE KEYS */;
INSERT INTO `student_course` VALUES ('000000','2015211003');
/*!40000 ALTER TABLE `student_course` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-12-01 13:52:50
