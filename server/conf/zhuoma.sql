/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50717
Source Host           : localhost:3306
Source Database       : zhuoma

Target Server Type    : MYSQL
Target Server Version : 50717
File Encoding         : 65001

Date: 2017-04-03 00:04:41
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
  `desknum` int(3) DEFAULT NULL,
  PRIMARY KEY (`deskid`),
  KEY `rest_id` (`restid`),
  CONSTRAINT `desk_ibfk_1` FOREIGN KEY (`restid`) REFERENCES `rest` (`restid`)
) ENGINE=InnoDB AUTO_INCREMENT=10005 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of desk
-- ----------------------------
INSERT INTO `desk` VALUES ('10001', '10001', '1');
INSERT INTO `desk` VALUES ('10002', '10001', '2');
INSERT INTO `desk` VALUES ('10003', '10002', '1');
INSERT INTO `desk` VALUES ('10004', '10002', '2');

-- ----------------------------
-- Table structure for `food`
-- ----------------------------
DROP TABLE IF EXISTS `food`;
CREATE TABLE `food` (
  `foodid` int(20) NOT NULL AUTO_INCREMENT,
  `restid` int(20) NOT NULL,
  `foodname` varchar(100) DEFAULT NULL,
  `price` double DEFAULT NULL,
  `image` varchar(50) DEFAULT NULL,
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
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of food
-- ----------------------------
INSERT INTO `food` VALUES ('1', '10001', '秘制鸡翅', '8', '94cdec769272d1ec7cf', null, '1', '2', null);
INSERT INTO `food` VALUES ('2', '10001', '蜜汁鸡翅', '8', '9bd40b738702c89ce4', null, '1', '2', null);
INSERT INTO `food` VALUES ('3', '10001', '麻辣鸡翅2串', '15', '8aabcca226a70c788ba0e30', null, '2', null, null);
INSERT INTO `food` VALUES ('4', '10001', '板筋(5份起)', '3', '8c984499a7c98801b3eaa88813afeb75344542', null, '2', null, null);
INSERT INTO `food` VALUES ('5', '10001', '望京小腰(3份起)', '3', '0e7c614550c12d3b76f0a111a2fa1d1d1463576', null, '2', null, null);
INSERT INTO `food` VALUES ('6', '10001', '金牌豪华套餐', '188', '48013dfd64a910ca561fb2a78b4f1823124456', null, '3', null, null);
INSERT INTO `food` VALUES ('7', '10001', '双人套餐', '86', 'a83f74749d76837e3e81594d2e59d0ab493826', null, '3', null, null);
INSERT INTO `food` VALUES ('8', '10001', '夏日烤串套餐', '35', '670584be7c93e3a4476a20de2afb812284523', null, '3', null, null);
INSERT INTO `food` VALUES ('9', '10001', '白牛二(半斤装)', '17', '581ed47815738c4e157f233018a7cce590112', null, '4', null, null);
INSERT INTO `food` VALUES ('10', '10001', '燕京听啤', '5', '610d48c5467987d7d334ed16de888f65227328', null, '4', null, null);
INSERT INTO `food` VALUES ('11', '10001', '凉拌三丝', '18', 'aba809cc24f6b11d3f1494d6a9a75eb1577536', null, '5', null, null);
INSERT INTO `food` VALUES ('12', '10001', '拍黄瓜', '16', 'f9258d1704343a85abaf8fc0d12a0e50565248', null, '5', null, null);
INSERT INTO `food` VALUES ('13', '10001', '老干妈炒饭', '18', 'f37b4f6ea6e3b105e100bc7d45144ed1452608', null, '6', null, null);
INSERT INTO `food` VALUES ('14', '10001', '鸡蛋炒饼', '20', '4e629ced37f03a6044dd53bf0c29e538503808', null, '6', null, null);
INSERT INTO `food` VALUES ('15', '10002', '榨菜肉丝盖饭', '29', 'fa40afe9187c84bb500bc8d2d37239bc188107', null, '8', null, null);
INSERT INTO `food` VALUES ('16', '10002', '麻婆豆腐盖饭', '28', 'f7b1e52891a67953efaf23e4e5d9b8e878814', null, '8', null, null);
INSERT INTO `food` VALUES ('17', '10002', '鱼香肉丝盖饭', '29', 'cf2661f9bdf13a619e2ad3499637581c24576', null, '8', '7', null);
INSERT INTO `food` VALUES ('18', '10002', '麻辣烤乌江鱼', '128', '83d1948a5c932803ad50c78a59535f3a121112', null, '8', '7', null);
INSERT INTO `food` VALUES ('19', '10002', '香辣烤鸡翅', '88', '248bca4a4e9883fd98c8b91ced3820cf702464', null, '9', null, null);
INSERT INTO `food` VALUES ('20', '10002', '香辣烤乌江鱼', '128', '994e6fb2289560a0cee36825b952c98c320061', null, '9', null, null);
INSERT INTO `food` VALUES ('21', '10002', '酸菜烤草鱼', '78', '994e6fb2289560a0cee36825b952c98c320061', null, '9', null, null);
INSERT INTO `food` VALUES ('22', '10002', '微辣锅底（锅底必点）', '12', '5d24847a83f9fa0c0fb433aa5c9a45ba153574', null, '10', '7', null);
INSERT INTO `food` VALUES ('23', '10002', '中辣锅底（锅底必点）', '12', '5d24847a83f9fa0c0fb433aa5c9a45ba153574', null, '10', null, null);
INSERT INTO `food` VALUES ('24', '10002', '五花肉', '20', '47c18e8a7ac5c192e0f485d4565ac3ed452608', null, '10', null, null);
INSERT INTO `food` VALUES ('25', '10002', '千叶豆腐', '16', '69261594a8f92f431de402f4c554d8cd213943', null, '10', null, null);
INSERT INTO `food` VALUES ('27', '10002', '金针菇肥牛', '56', 'c82b43ae0aa68f20f7f5c9c5c6119b661630208', null, '11', '7', null);
INSERT INTO `food` VALUES ('28', '10002', '宫爆鸡丁', '24', '7ec9cb6e415d86e771c6c87a359c0a42346112', null, '11', '7', null);
INSERT INTO `food` VALUES ('29', '10002', '山城毛血旺', '46', 'be6b31f52922068cbac2e09dfaae382d198656', null, '11', null, null);

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
) ENGINE=InnoDB AUTO_INCREMENT=10003 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of rest
-- ----------------------------
INSERT INTO `rest` VALUES ('10001', '大龙烤串', '010-88433923', '18701322198', '来广营乡红军营村53号二层北侧');
INSERT INTO `rest` VALUES ('10002', '川渝小厨（家常菜）', '010-88676543', '13789889876', '西城区罗尔胡同8号');

-- ----------------------------
-- Table structure for `sale`
-- ----------------------------
DROP TABLE IF EXISTS `sale`;
CREATE TABLE `sale` (
  `saleid` int(20) NOT NULL AUTO_INCREMENT,
  `foodid` int(20) NOT NULL,
  `zorderid` int(20) NOT NULL,
  `price` double DEFAULT NULL,
  `salestatus` int(2) DEFAULT NULL,
  `num` int(3) DEFAULT NULL,
  PRIMARY KEY (`saleid`),
  KEY `food_id` (`foodid`),
  KEY `order_id` (`zorderid`),
  CONSTRAINT `sale_ibfk_1` FOREIGN KEY (`foodid`) REFERENCES `food` (`foodid`),
  CONSTRAINT `sale_ibfk_2` FOREIGN KEY (`zorderid`) REFERENCES `zorder` (`zorderid`)
) ENGINE=InnoDB AUTO_INCREMENT=67 DEFAULT CHARSET=utf8;

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
INSERT INTO `tag` VALUES ('2', '烧烤', '1');
INSERT INTO `tag` VALUES ('3', '套餐', '2');
INSERT INTO `tag` VALUES ('4', '酒水', '3');
INSERT INTO `tag` VALUES ('5', '凉菜', '4');
INSERT INTO `tag` VALUES ('6', '主食', '5');
INSERT INTO `tag` VALUES ('7', '热销', '0');
INSERT INTO `tag` VALUES ('8', '精品盖浇饭', '1');
INSERT INTO `tag` VALUES ('9', '重庆特色烤鱼', '2');
INSERT INTO `tag` VALUES ('10', '重庆特色麻辣香锅', '3');
INSERT INTO `tag` VALUES ('11', '精品家常菜', '4');

-- ----------------------------
-- Table structure for `zorder`
-- ----------------------------
DROP TABLE IF EXISTS `zorder`;
CREATE TABLE `zorder` (
  `zorderid` int(20) NOT NULL AUTO_INCREMENT,
  `restid` int(20) NOT NULL,
  `deskid` int(20) NOT NULL,
  `customerid` varchar(20) DEFAULT NULL,
  `zordersaletime` datetime DEFAULT NULL,
  `totalprice` double DEFAULT NULL,
  `zorderstatus` int(2) DEFAULT NULL,
  PRIMARY KEY (`zorderid`),
  KEY `desk_id` (`deskid`),
  KEY `restid` (`restid`),
  CONSTRAINT `zorder_ibfk_1` FOREIGN KEY (`deskid`) REFERENCES `desk` (`deskid`),
  CONSTRAINT `zorder_ibfk_2` FOREIGN KEY (`restid`) REFERENCES `rest` (`restid`)
) ENGINE=InnoDB AUTO_INCREMENT=78 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of zorder
-- ----------------------------
