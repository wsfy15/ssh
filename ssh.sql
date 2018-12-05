/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50723
Source Host           : localhost:3306
Source Database       : ssh

Target Server Type    : MYSQL
Target Server Version : 50723
File Encoding         : 65001

Date: 2018-12-04 11:40:51
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for admin
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin` (
  `ad_id` varchar(255) NOT NULL,
  `ad_name` varchar(255) DEFAULT NULL,
  `ad_password` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ad_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES ('1010123456', '小白', '123456');

-- ----------------------------
-- Table structure for assignment
-- ----------------------------
DROP TABLE IF EXISTS `assignment`;
CREATE TABLE `assignment` (
  `as_id` varchar(255) NOT NULL,
  `as_name` varchar(255) DEFAULT NULL,
  `as_describe` varchar(255) DEFAULT NULL,
  `as_ddl` date DEFAULT NULL,
  `as_assigntime` time DEFAULT NULL,
  `as_co_id` varchar(255) DEFAULT NULL,
  `as_proportion` int(11) DEFAULT NULL,
  PRIMARY KEY (`as_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of assignment
-- ----------------------------

-- ----------------------------
-- Table structure for course
-- ----------------------------
DROP TABLE IF EXISTS `course`;
CREATE TABLE `course` (
  `co_id` varchar(255) NOT NULL,
  `co_name` varchar(255) DEFAULT NULL,
  `co_ro_num` int(11) DEFAULT NULL,
  `co_date` date DEFAULT NULL,
  `co_describe` varchar(255) DEFAULT NULL,
  `co_gr_max` int(11) DEFAULT NULL,
  `co_gr_min` int(11) DEFAULT NULL,
  `co_gr_preyear` int(11) DEFAULT NULL,
  `co_gr_preclass` int(11) DEFAULT NULL,
  `co_teacher` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`co_id`),
  KEY `FKjuk3287jofybfmuf7mplmbqck` (`co_teacher`),
  CONSTRAINT `FKjuk3287jofybfmuf7mplmbqck` FOREIGN KEY (`co_teacher`) REFERENCES `teacher` (`te_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of course
-- ----------------------------

-- ----------------------------
-- Table structure for homework
-- ----------------------------
DROP TABLE IF EXISTS `homework`;
CREATE TABLE `homework` (
  `ho_as_id` varchar(255) NOT NULL,
  `ho_gr_id` varchar(255) NOT NULL,
  `ho_time` date DEFAULT NULL,
  `ho_path` varchar(255) DEFAULT NULL,
  `ho_name` varchar(255) DEFAULT NULL,
  `ho_us_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ho_as_id`,`ho_gr_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of homework
-- ----------------------------

-- ----------------------------
-- Table structure for student
-- ----------------------------
DROP TABLE IF EXISTS `student`;
CREATE TABLE `student` (
  `st_id` varchar(255) NOT NULL,
  `st_name` varchar(255) DEFAULT NULL,
  `st_class` varchar(255) DEFAULT NULL,
  `st_password` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`st_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of student
-- ----------------------------
INSERT INTO `student` VALUES ('2015211360', '学生1', '22', '2015211362');

-- ----------------------------
-- Table structure for student_course
-- ----------------------------
DROP TABLE IF EXISTS `student_course`;
CREATE TABLE `student_course` (
  `co_id` varchar(255) NOT NULL,
  `id` varchar(255) NOT NULL,
  PRIMARY KEY (`id`,`co_id`),
  KEY `FKbkh2n7ypef6xfa8xn2lbn47fj` (`co_id`),
  CONSTRAINT `FKbkh2n7ypef6xfa8xn2lbn47fj` FOREIGN KEY (`co_id`) REFERENCES `course` (`co_id`),
  CONSTRAINT `FKi2p71h5ttuy358t8r1lcn84ih` FOREIGN KEY (`id`) REFERENCES `student` (`st_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of student_course
-- ----------------------------

-- ----------------------------
-- Table structure for teacher
-- ----------------------------
DROP TABLE IF EXISTS `teacher`;
CREATE TABLE `teacher` (
  `te_id` varchar(255) NOT NULL,
  `te_name` varchar(255) DEFAULT NULL,
  `te_password` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`te_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of teacher
-- ----------------------------
INSERT INTO `teacher` VALUES ('123456', '老师1', '123456');
