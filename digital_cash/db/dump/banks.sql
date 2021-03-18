/*
 Navicat MySQL Data Transfer

 Source Server         : OnpaxProduction - Cluster
 Source Server Type    : MySQL
 Source Server Version : 50726
 Source Host           : 165.22.176.31
 Source Database       : onpax

 Target Server Type    : MySQL
 Target Server Version : 50726
 File Encoding         : utf-8

 Date: 03/19/2020 16:05:22 PM
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
--  Table structure for `banks`
-- ----------------------------
DROP TABLE IF EXISTS `banks`;
CREATE TABLE `banks` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `code` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `banks`
-- ----------------------------
BEGIN;
INSERT INTO `banks` VALUES ('3', 'Caixa Econômica', '104', '2017-03-01 13:42:52', '2017-03-01 13:42:52'), ('4', 'Brasil', '001', '2017-03-01 13:43:02', '2017-03-01 13:43:05'), ('5', 'Bradesco', '237', '2017-03-01 13:43:18', '2017-03-01 13:43:07'), ('6', 'Santander', '033', '2017-03-01 13:43:21', '2017-03-01 13:43:10'), ('7', 'Itaú', '341', '2017-03-01 13:43:24', '2017-03-01 13:43:12'), ('8', 'Safra', '422', '2017-03-01 13:43:27', '2017-03-01 13:43:16'), ('9', 'Tribanco', '634', '2016-11-29 10:37:14', '2016-11-29 10:37:17'), ('10', 'Sincred', null, '2017-04-14 11:34:40', '2017-04-14 11:34:40'), ('11', 'Citibank', '745', '2017-06-17 00:04:21', '2017-06-17 00:04:25'), ('12', 'Banese', '047', '2017-07-25 15:31:38', '2017-07-25 15:31:40'), ('13', 'Banrisul', '041', '2017-07-25 15:31:38', '2017-07-25 15:31:38'), ('15', 'Banco do Nordeste', '004', '2016-11-29 17:06:22', '2016-11-29 17:06:26'), ('16', 'BRB', '070', '2018-01-12 15:27:42', '2018-01-12 15:27:42'), ('17', 'SICOOB', '756', '2018-01-12 15:27:42', '2018-01-12 15:27:42'), ('18', 'Inter', '077', '2018-01-12 15:27:42', '2018-01-12 15:27:42'), ('19', 'Nu Pagamentos S.A.', '260', '2020-01-18 08:24:22', '2020-01-18 08:24:25');
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
