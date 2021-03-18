# ************************************************************
# Sequel Pro SQL dump
# Versão 4541
#
# http://www.sequelpro.com/
# https://github.com/sequelpro/sequelpro
#
# Host: 127.0.0.1 (MySQL 5.7.19)
# Base de Dados: festcard_development
# Tempo de Geração: 2018-04-24 12:35:51 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump da tabela states
# ------------------------------------------------------------

DROP TABLE IF EXISTS `states`;

CREATE TABLE `states` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `uf` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `states` WRITE;
/*!40000 ALTER TABLE `states` DISABLE KEYS */;

INSERT INTO `states` (`id`, `name`, `uf`, `created_at`, `updated_at`)
VALUES
	(1,'Acre','AC','2016-04-05 02:51:23','2016-04-05 02:51:23'),
	(2,'Alagoas','AL','2016-04-05 02:51:23','2016-04-05 02:51:23'),
	(3,'Amazonas','AM','2016-04-05 02:51:24','2016-04-05 02:51:24'),
	(4,'Amapá','AP','2016-04-05 02:51:24','2016-04-05 02:51:24'),
	(5,'Bahia','BA','2016-04-05 02:51:24','2016-04-05 02:51:24'),
	(6,'Ceará','CE','2016-04-05 02:51:26','2016-04-05 02:51:26'),
	(7,'Distrito Federal','DF','2016-04-05 02:51:27','2016-04-05 02:51:27'),
	(8,'Espírito Santo','ES','2016-04-05 02:51:27','2016-04-05 02:51:27'),
	(9,'Goiás','GO','2016-04-05 02:51:27','2016-04-05 02:51:27'),
	(10,'Maranhão','MA','2016-04-05 02:51:28','2016-04-05 02:51:28'),
	(11,'Minas Gerais','MG','2016-04-05 02:51:29','2016-04-05 02:51:29'),
	(12,'Mato Grosso do Sul','MS','2016-04-05 02:51:34','2016-04-05 02:51:34'),
	(13,'Mato Grosso','MT','2016-04-05 02:51:34','2016-04-05 02:51:34'),
	(14,'Pará','PA','2016-04-05 02:51:35','2016-04-05 02:51:35'),
	(15,'Paraíba','PB','2016-04-05 02:51:35','2016-04-05 02:51:35'),
	(16,'Pernambuco','PE','2016-04-05 02:51:37','2016-04-05 02:51:37'),
	(17,'Piauí','PI','2016-04-05 02:51:37','2016-04-05 02:51:37'),
	(18,'Paraná','PR','2016-04-05 02:51:38','2016-04-05 02:51:38'),
	(19,'Rio de Janeiro','RJ','2016-04-05 02:51:40','2016-04-05 02:51:40'),
	(20,'Rio Grande do Norte','RN','2016-04-05 02:51:41','2016-04-05 02:51:41'),
	(21,'Rondônia','RO','2016-04-05 02:51:42','2016-04-05 02:51:42'),
	(22,'Roraima','RR','2016-04-05 02:51:42','2016-04-05 02:51:42'),
	(23,'Rio Grande do Sul','RS','2016-04-05 02:51:42','2016-04-05 02:51:42'),
	(24,'Santa Catarina','SC','2016-04-05 02:51:44','2016-04-05 02:51:44'),
	(25,'Sergipe','SE','2016-04-05 02:51:46','2016-04-05 02:51:46'),
	(26,'São Paulo','SP','2016-04-05 02:51:46','2016-04-05 02:51:46'),
	(27,'Tocantins','TO','2016-04-05 02:51:49','2016-04-05 02:51:49');

/*!40000 ALTER TABLE `states` ENABLE KEYS */;
UNLOCK TABLES;



/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
