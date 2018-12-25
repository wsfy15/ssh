/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50723
Source Host           : localhost:3306
Source Database       : ssh

Target Server Type    : MYSQL
Target Server Version : 50723
File Encoding         : 65001

Date: 2018-12-25 12:31:56
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for admin
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin` (
  `ad_id` varchar(255) NOT NULL,
  `ad_valid` int(11) DEFAULT NULL,
  `ad_name` varchar(255) DEFAULT NULL,
  `ad_password` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ad_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES ('1000000000', '1', '小白', 'e10adc3949ba59abbe56e057f20f883e');

-- ----------------------------
-- Table structure for assignment
-- ----------------------------
DROP TABLE IF EXISTS `assignment`;
CREATE TABLE `assignment` (
  `as_id` varchar(255) NOT NULL,
  `as_valid` int(11) DEFAULT NULL,
  `as_name` varchar(255) DEFAULT NULL,
  `as_describe` varchar(255) DEFAULT NULL,
  `as_ddl` datetime DEFAULT NULL,
  `as_assigntime` datetime DEFAULT NULL,
  `as_weight` int(11) DEFAULT NULL,
  `co_course` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`as_id`),
  KEY `FKtcd4v2cqpnv58bj3f6wt8ucc0` (`co_course`),
  CONSTRAINT `FKtcd4v2cqpnv58bj3f6wt8ucc0` FOREIGN KEY (`co_course`) REFERENCES `course` (`co_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of assignment
-- ----------------------------
INSERT INTO `assignment` VALUES ('000000', '1', '第一次', ' 第一次作业', '2018-12-22 00:00:00', '2018-12-21 17:11:34', '20', '000000');
INSERT INTO `assignment` VALUES ('000001', '1', '作业2', '123 ', '2018-12-24 00:00:00', '2018-12-21 21:03:20', '30', '000000');

-- ----------------------------
-- Table structure for class
-- ----------------------------
DROP TABLE IF EXISTS `class`;
CREATE TABLE `class` (
  `cl_id` varchar(255) NOT NULL,
  `cl_valid` int(11) DEFAULT NULL,
  PRIMARY KEY (`cl_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of class
-- ----------------------------
INSERT INTO `class` VALUES ('2018000001', '1');

-- ----------------------------
-- Table structure for classcourse
-- ----------------------------
DROP TABLE IF EXISTS `classcourse`;
CREATE TABLE `classcourse` (
  `id` varchar(255) NOT NULL,
  `clcourse_id` varchar(255) DEFAULT NULL,
  `clclass_id` varchar(255) DEFAULT NULL,
  `ho_valid` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKnhv4fr5e1dmtmy9kbv01wu7vc` (`clcourse_id`),
  KEY `FKp59sjkhnkksjsrdj8stpgrj7u` (`clclass_id`),
  CONSTRAINT `FKnhv4fr5e1dmtmy9kbv01wu7vc` FOREIGN KEY (`clcourse_id`) REFERENCES `course` (`co_id`),
  CONSTRAINT `FKp59sjkhnkksjsrdj8stpgrj7u` FOREIGN KEY (`clclass_id`) REFERENCES `class` (`cl_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of classcourse
-- ----------------------------

-- ----------------------------
-- Table structure for course
-- ----------------------------
DROP TABLE IF EXISTS `course`;
CREATE TABLE `course` (
  `co_id` varchar(255) NOT NULL,
  `co_valid` int(11) DEFAULT NULL,
  `co_name` varchar(255) DEFAULT NULL,
  `co_ro_num` int(11) DEFAULT NULL,
  `co_ro_num_complete` int(11) DEFAULT NULL,
  `co_date` date DEFAULT NULL,
  `co_describe` varchar(255) DEFAULT NULL,
  `co_peacetimeProportion` int(11) DEFAULT NULL,
  `co_gr_max` int(11) DEFAULT NULL,
  `co_gr_min` int(11) DEFAULT NULL,
  `co_gr_prefix` varchar(255) DEFAULT NULL,
  `co_teacher` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`co_id`),
  KEY `FKjuk3287jofybfmuf7mplmbqck` (`co_teacher`),
  CONSTRAINT `FKjuk3287jofybfmuf7mplmbqck` FOREIGN KEY (`co_teacher`) REFERENCES `teacher` (`te_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of course
-- ----------------------------
INSERT INTO `course` VALUES ('000000', '1', '软工', '4', '0', '2018-12-20', ' 123', '20', '4', '2', '1234567', '1010000000');

-- ----------------------------
-- Table structure for groupmember
-- ----------------------------
DROP TABLE IF EXISTS `groupmember`;
CREATE TABLE `groupmember` (
  `groupmember_id` varchar(255) NOT NULL,
  `gm_gr_id` varchar(255) DEFAULT NULL,
  `gm_st_id` varchar(255) DEFAULT NULL,
  `ho_valid` int(11) DEFAULT NULL,
  PRIMARY KEY (`groupmember_id`),
  KEY `FKc9rbdy8bh8f2avukb1q5w8qon` (`gm_gr_id`),
  KEY `FKf2c74gnd8x3v9n2nfd51s9gnk` (`gm_st_id`),
  CONSTRAINT `FKc9rbdy8bh8f2avukb1q5w8qon` FOREIGN KEY (`gm_gr_id`) REFERENCES `groupp` (`gr_id`),
  CONSTRAINT `FKf2c74gnd8x3v9n2nfd51s9gnk` FOREIGN KEY (`gm_st_id`) REFERENCES `student` (`st_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of groupmember
-- ----------------------------
INSERT INTO `groupmember` VALUES ('8a4ea34367ce96960167ce98c9730000', '12345671', '2015000000', '1');
INSERT INTO `groupmember` VALUES ('8a4ea34367ce96960167ce98c9760001', '12345671', '2015000001', '1');

-- ----------------------------
-- Table structure for groupp
-- ----------------------------
DROP TABLE IF EXISTS `groupp`;
CREATE TABLE `groupp` (
  `gr_id` varchar(255) NOT NULL,
  `valid` int(11) DEFAULT NULL,
  `gr_cheif` varchar(255) DEFAULT NULL,
  `gr_email` varchar(255) DEFAULT NULL,
  `gr_qq` varchar(255) DEFAULT NULL,
  `gr_phone` varchar(255) DEFAULT NULL,
  `gr_num` int(11) DEFAULT NULL,
  `gr_co_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`gr_id`),
  KEY `FKtdquaowdk0gluv846fmhdjrpo` (`gr_co_id`),
  CONSTRAINT `FKtdquaowdk0gluv846fmhdjrpo` FOREIGN KEY (`gr_co_id`) REFERENCES `course` (`co_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of groupp
-- ----------------------------
INSERT INTO `groupp` VALUES ('12345671', '1', '2015000000', '789', '456', '123', '2', '000000');

-- ----------------------------
-- Table structure for homework
-- ----------------------------
DROP TABLE IF EXISTS `homework`;
CREATE TABLE `homework` (
  `id` varchar(255) NOT NULL,
  `ho_valid` int(11) DEFAULT NULL,
  `ho_time` datetime DEFAULT NULL,
  `ho_path` varchar(255) DEFAULT NULL,
  `ho_name` varchar(255) DEFAULT NULL,
  `ho_gr_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK4ccgs7or485dexygncumbsy1q` (`ho_gr_id`),
  CONSTRAINT `FK4ccgs7or485dexygncumbsy1q` FOREIGN KEY (`ho_gr_id`) REFERENCES `groupp` (`gr_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of homework
-- ----------------------------
INSERT INTO `homework` VALUES ('8a007aa967e35bd30167e35cb2bc0000', '1', '2018-12-25 12:25:25', '/000000/12345671/', '1.txt', '12345671');
INSERT INTO `homework` VALUES ('8a007aa967e397960167e39891380000', '1', '2018-12-25 12:21:26', '/000000/12345671/', 'niki_jquery模糊搜索下拉选择框_v1.0.zip', '12345671');

-- ----------------------------
-- Table structure for rollcall
-- ----------------------------
DROP TABLE IF EXISTS `rollcall`;
CREATE TABLE `rollcall` (
  `id` varchar(255) NOT NULL,
  `ro_us_id` varchar(255) DEFAULT NULL,
  `ro_co_id` varchar(255) DEFAULT NULL,
  `ro_date` datetime DEFAULT NULL,
  `valid` int(11) DEFAULT NULL,
  `count` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKaby00stih2i5177shh7xsqtl6` (`ro_us_id`),
  KEY `FKsdos5irbw3yk9h7pgqd8d47p5` (`ro_co_id`),
  CONSTRAINT `FKaby00stih2i5177shh7xsqtl6` FOREIGN KEY (`ro_us_id`) REFERENCES `student` (`st_id`),
  CONSTRAINT `FKsdos5irbw3yk9h7pgqd8d47p5` FOREIGN KEY (`ro_co_id`) REFERENCES `course` (`co_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of rollcall
-- ----------------------------

-- ----------------------------
-- Table structure for student
-- ----------------------------
DROP TABLE IF EXISTS `student`;
CREATE TABLE `student` (
  `st_id` varchar(255) NOT NULL,
  `st_valid` int(11) DEFAULT NULL,
  `st_name` varchar(255) DEFAULT NULL,
  `st_class` varchar(255) DEFAULT NULL,
  `st_password` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`st_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of student
-- ----------------------------
INSERT INTO `student` VALUES ('2015000000', '1', '学生1', '2018000001', 'e10adc3949ba59abbe56e057f20f883e');
INSERT INTO `student` VALUES ('2015000001', '1', '学生2', '2018000001', 'e10adc3949ba59abbe56e057f20f883e');
INSERT INTO `student` VALUES ('2015000002', '1', '学生3', '2018000001', 'e10adc3949ba59abbe56e057f20f883e');
INSERT INTO `student` VALUES ('2015000003', '1', '学生4', '2018000001', 'e10adc3949ba59abbe56e057f20f883e');

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
INSERT INTO `student_course` VALUES ('000000', '2015000000');

-- ----------------------------
-- Table structure for teacher
-- ----------------------------
DROP TABLE IF EXISTS `teacher`;
CREATE TABLE `teacher` (
  `te_id` varchar(255) NOT NULL,
  `te_valid` int(11) DEFAULT NULL,
  `te_name` varchar(255) DEFAULT NULL,
  `te_password` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`te_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of teacher
-- ----------------------------
INSERT INTO `teacher` VALUES ('1010000000', '1', '老师1', 'e10adc3949ba59abbe56e057f20f883e');
