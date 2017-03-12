/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50717
Source Host           : localhost:3306
Source Database       : zhuoma

Target Server Type    : MYSQL
Target Server Version : 50717
File Encoding         : 65001

Date: 2017-03-12 23:38:29
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `cooker`
-- ----------------------------
DROP TABLE IF EXISTS `cooker`;
CREATE TABLE `cooker` (
  `id` varchar(20) NOT NULL,
  `rest_id` varchar(20) DEFAULT NULL,
  `goodat` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `rest_id` (`rest_id`),
  CONSTRAINT `cooker_ibfk_1` FOREIGN KEY (`rest_id`) REFERENCES `rest` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cooker
-- ----------------------------

-- ----------------------------
-- Table structure for `desk`
-- ----------------------------
DROP TABLE IF EXISTS `desk`;
CREATE TABLE `desk` (
  `id` varchar(20) NOT NULL,
  `rest_id` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `rest_id` (`rest_id`),
  CONSTRAINT `desk_ibfk_1` FOREIGN KEY (`rest_id`) REFERENCES `rest` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of desk
-- ----------------------------
INSERT INTO `desk` VALUES ('mervy82xk6osg4ccks', '1p479g3vqcgwogko4s');

-- ----------------------------
-- Table structure for `food`
-- ----------------------------
DROP TABLE IF EXISTS `food`;
CREATE TABLE `food` (
  `id` varchar(20) NOT NULL,
  `rest_id` varchar(20) NOT NULL,
  `price` double DEFAULT NULL,
  `des` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `food_ibfk_1` (`rest_id`),
  CONSTRAINT `food_ibfk_1` FOREIGN KEY (`rest_id`) REFERENCES `rest` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of food
-- ----------------------------

-- ----------------------------
-- Table structure for `order`
-- ----------------------------
DROP TABLE IF EXISTS `order`;
CREATE TABLE `order` (
  `id` varchar(20) NOT NULL,
  `desk_id` varchar(20) NOT NULL,
  `sale_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `total_price` double DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `desk_id` (`desk_id`),
  CONSTRAINT `order_ibfk_1` FOREIGN KEY (`desk_id`) REFERENCES `desk` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of order
-- ----------------------------

-- ----------------------------
-- Table structure for `rest`
-- ----------------------------
DROP TABLE IF EXISTS `rest`;
CREATE TABLE `rest` (
  `id` varchar(20) NOT NULL,
  `name` varchar(50) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `mobile` varchar(20) DEFAULT NULL,
  `address` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of rest
-- ----------------------------
INSERT INTO `rest` VALUES ('1p479g3vqcgwogko4s', '渔火渔夫（北苑店）', '010-88433923', '18701322198', '来广营乡红军营村53号二层北侧\r\n');

-- ----------------------------
-- Table structure for `sale`
-- ----------------------------
DROP TABLE IF EXISTS `sale`;
CREATE TABLE `sale` (
  `id` varchar(20) NOT NULL,
  `food_id` varchar(20) NOT NULL,
  `order_id` varchar(20) NOT NULL,
  `customer_id` varchar(20) NOT NULL,
  `sale_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `price` double DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `food_id` (`food_id`),
  KEY `order_id` (`order_id`),
  CONSTRAINT `sale_ibfk_1` FOREIGN KEY (`food_id`) REFERENCES `food` (`id`),
  CONSTRAINT `sale_ibfk_2` FOREIGN KEY (`order_id`) REFERENCES `order` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sale
-- ----------------------------
