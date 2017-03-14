/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50717
Source Host           : localhost:3306
Source Database       : zhuoma

Target Server Type    : MYSQL
Target Server Version : 50717
File Encoding         : 65001

Date: 2017-03-14 21:53:55
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `cooker`
-- ----------------------------
DROP TABLE IF EXISTS `cooker`;
CREATE TABLE `cooker` (
  `cookerid` varchar(20) NOT NULL,
  `restid` int(20) DEFAULT NULL,
  `goodat` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`cookerid`),
  KEY `rest_id` (`restid`),
  CONSTRAINT `cooker_ibfk_1` FOREIGN KEY (`restid`) REFERENCES `rest` (`restid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cooker
-- ----------------------------

-- ----------------------------
-- Table structure for `desk`
-- ----------------------------
DROP TABLE IF EXISTS `desk`;
CREATE TABLE `desk` (
  `deskid` int(20) NOT NULL AUTO_INCREMENT,
  `restid` int(20) DEFAULT NULL,
  PRIMARY KEY (`deskid`),
  KEY `rest_id` (`restid`),
  CONSTRAINT `desk_ibfk_1` FOREIGN KEY (`restid`) REFERENCES `rest` (`restid`)
) ENGINE=InnoDB AUTO_INCREMENT=10002 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of desk
-- ----------------------------
INSERT INTO `desk` VALUES ('10001', '10001');

-- ----------------------------
-- Table structure for `food`
-- ----------------------------
DROP TABLE IF EXISTS `food`;
CREATE TABLE `food` (
  `foodid` int(20) NOT NULL AUTO_INCREMENT,
  `restid` int(20) NOT NULL,
  `foodname` varchar(100) DEFAULT NULL,
  `price` double DEFAULT NULL,
  `des` varchar(100) DEFAULT NULL,
  `tag1` int(20) DEFAULT NULL,
  `tag2` int(20) DEFAULT NULL,
  `tag3` int(20) DEFAULT NULL,
  PRIMARY KEY (`foodid`),
  KEY `rest_id` (`restid`),
  KEY `tag1` (`tag1`),
  KEY `tag2` (`tag2`),
  KEY `tag3` (`tag3`),
  CONSTRAINT `food_ibfk_1` FOREIGN KEY (`restid`) REFERENCES `rest` (`restid`),
  CONSTRAINT `food_ibfk_2` FOREIGN KEY (`tag1`) REFERENCES `tag` (`tagid`),
  CONSTRAINT `food_ibfk_3` FOREIGN KEY (`tag2`) REFERENCES `tag` (`tagid`),
  CONSTRAINT `food_ibfk_4` FOREIGN KEY (`tag3`) REFERENCES `tag` (`tagid`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of food
-- ----------------------------
INSERT INTO `food` VALUES ('1', '10001', '鸡蛋馒头片', '15', null, '1', '4', null);
INSERT INTO `food` VALUES ('2', '10001', '秘制啤酒蛙（小份）', '108', null, '1', '3', null);

-- ----------------------------
-- Table structure for `rest`
-- ----------------------------
DROP TABLE IF EXISTS `rest`;
CREATE TABLE `rest` (
  `restid` int(20) NOT NULL AUTO_INCREMENT,
  `restname` varchar(50) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `mobile` varchar(20) DEFAULT NULL,
  `address` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`restid`)
) ENGINE=InnoDB AUTO_INCREMENT=10002 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of rest
-- ----------------------------
INSERT INTO `rest` VALUES ('10001', '渔火渔夫（北苑店）', '010-88433923', '18701322198', '来广营乡红军营村53号二层北侧');

-- ----------------------------
-- Table structure for `sale`
-- ----------------------------
DROP TABLE IF EXISTS `sale`;
CREATE TABLE `sale` (
  `saleid` int(20) NOT NULL AUTO_INCREMENT,
  `foodid` int(20) NOT NULL,
  `zorderid` int(20) NOT NULL,
  `customerid` varchar(20) NOT NULL,
  `saletime` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `price` double DEFAULT NULL,
  PRIMARY KEY (`saleid`),
  KEY `food_id` (`foodid`),
  KEY `order_id` (`zorderid`),
  CONSTRAINT `sale_ibfk_1` FOREIGN KEY (`foodid`) REFERENCES `food` (`foodid`),
  CONSTRAINT `sale_ibfk_2` FOREIGN KEY (`zorderid`) REFERENCES `zorder` (`zorderid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sale
-- ----------------------------

-- ----------------------------
-- Table structure for `tag`
-- ----------------------------
DROP TABLE IF EXISTS `tag`;
CREATE TABLE `tag` (
  `tagid` int(20) NOT NULL,
  `tagname` varchar(100) DEFAULT NULL,
  `tagord` int(11) DEFAULT NULL,
  PRIMARY KEY (`tagid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tag
-- ----------------------------
INSERT INTO `tag` VALUES ('1', '热销', '0');
INSERT INTO `tag` VALUES ('2', '热卖菜品', '1');
INSERT INTO `tag` VALUES ('3', '妙木村秘制牛蛙', '2');
INSERT INTO `tag` VALUES ('4', '主食', '3');

-- ----------------------------
-- Table structure for `zorder`
-- ----------------------------
DROP TABLE IF EXISTS `zorder`;
CREATE TABLE `zorder` (
  `zorderid` int(20) NOT NULL AUTO_INCREMENT,
  `deskid` int(20) NOT NULL,
  `zordersaletime` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `totalprice` double DEFAULT NULL,
  PRIMARY KEY (`zorderid`),
  KEY `desk_id` (`deskid`),
  CONSTRAINT `zorder_ibfk_1` FOREIGN KEY (`deskid`) REFERENCES `desk` (`deskid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of zorder
-- ----------------------------
