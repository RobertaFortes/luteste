# ************************************************************
# Sequel Pro SQL dump
# Version 4096
#
# http://www.sequelpro.com/
# http://code.google.com/p/sequel-pro/
#
# Host: 127.0.0.1 (MySQL 5.6.19-0ubuntu0.14.04.1)
# Database: lutestefim
# Generation Time: 2015-10-02 19:38:38 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table admin_assert
# ------------------------------------------------------------

DROP TABLE IF EXISTS `admin_assert`;

CREATE TABLE `admin_assert` (
  `assert_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Assert ID',
  `assert_type` varchar(20) DEFAULT NULL COMMENT 'Assert Type',
  `assert_data` text COMMENT 'Assert Data',
  PRIMARY KEY (`assert_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Admin Assert Table';



# Dump of table admin_role
# ------------------------------------------------------------

DROP TABLE IF EXISTS `admin_role`;

CREATE TABLE `admin_role` (
  `role_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Role ID',
  `parent_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Parent Role ID',
  `tree_level` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Role Tree Level',
  `sort_order` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Role Sort Order',
  `role_type` varchar(1) NOT NULL DEFAULT '0' COMMENT 'Role Type',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'User ID',
  `role_name` varchar(50) DEFAULT NULL COMMENT 'Role Name',
  PRIMARY KEY (`role_id`),
  KEY `IDX_ADMIN_ROLE_PARENT_ID_SORT_ORDER` (`parent_id`,`sort_order`),
  KEY `IDX_ADMIN_ROLE_TREE_LEVEL` (`tree_level`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Admin Role Table';

LOCK TABLES `admin_role` WRITE;
/*!40000 ALTER TABLE `admin_role` DISABLE KEYS */;

INSERT INTO `admin_role` (`role_id`, `parent_id`, `tree_level`, `sort_order`, `role_type`, `user_id`, `role_name`)
VALUES
	(1,0,1,1,'G',0,'Administrators'),
	(2,1,2,0,'U',1,'Marcia ');

/*!40000 ALTER TABLE `admin_role` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table admin_rule
# ------------------------------------------------------------

DROP TABLE IF EXISTS `admin_rule`;

CREATE TABLE `admin_rule` (
  `rule_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Rule ID',
  `role_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Role ID',
  `resource_id` varchar(255) DEFAULT NULL COMMENT 'Resource ID',
  `privileges` varchar(20) DEFAULT NULL COMMENT 'Privileges',
  `assert_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Assert ID',
  `role_type` varchar(1) DEFAULT NULL COMMENT 'Role Type',
  `permission` varchar(10) DEFAULT NULL COMMENT 'Permission',
  PRIMARY KEY (`rule_id`),
  KEY `IDX_ADMIN_RULE_RESOURCE_ID_ROLE_ID` (`resource_id`,`role_id`),
  KEY `IDX_ADMIN_RULE_ROLE_ID_RESOURCE_ID` (`role_id`,`resource_id`),
  CONSTRAINT `FK_ADMIN_RULE_ROLE_ID_ADMIN_ROLE_ROLE_ID` FOREIGN KEY (`role_id`) REFERENCES `admin_role` (`role_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Admin Rule Table';

LOCK TABLES `admin_rule` WRITE;
/*!40000 ALTER TABLE `admin_rule` DISABLE KEYS */;

INSERT INTO `admin_rule` (`rule_id`, `role_id`, `resource_id`, `privileges`, `assert_id`, `role_type`, `permission`)
VALUES
	(1,1,'all',NULL,0,'G','allow');

/*!40000 ALTER TABLE `admin_rule` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table admin_user
# ------------------------------------------------------------

DROP TABLE IF EXISTS `admin_user`;

CREATE TABLE `admin_user` (
  `user_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'User ID',
  `firstname` varchar(32) DEFAULT NULL COMMENT 'User First Name',
  `lastname` varchar(32) DEFAULT NULL COMMENT 'User Last Name',
  `email` varchar(128) DEFAULT NULL COMMENT 'User Email',
  `username` varchar(40) DEFAULT NULL COMMENT 'User Login',
  `password` varchar(100) DEFAULT NULL COMMENT 'User Password',
  `created` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'User Created Time',
  `modified` timestamp NULL DEFAULT NULL COMMENT 'User Modified Time',
  `logdate` timestamp NULL DEFAULT NULL COMMENT 'User Last Login Time',
  `lognum` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'User Login Number',
  `reload_acl_flag` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Reload ACL',
  `is_active` smallint(6) NOT NULL DEFAULT '1' COMMENT 'User Is Active',
  `extra` text COMMENT 'User Extra Data',
  `rp_token` text COMMENT 'Reset Password Link Token',
  `rp_token_created_at` timestamp NULL DEFAULT NULL COMMENT 'Reset Password Link Token Creation Date',
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `UNQ_ADMIN_USER_USERNAME` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Admin User Table';

LOCK TABLES `admin_user` WRITE;
/*!40000 ALTER TABLE `admin_user` DISABLE KEYS */;

INSERT INTO `admin_user` (`user_id`, `firstname`, `lastname`, `email`, `username`, `password`, `created`, `modified`, `logdate`, `lognum`, `reload_acl_flag`, `is_active`, `extra`, `rp_token`, `rp_token_created_at`)
VALUES
	(1,'Marcia ','Gonclaves','betanickf@gmail.com','luteste','8733ffc030e96eff9350f599fdded5a0:OEwJogY61bNSFXrhlJ9ckXIjjNDPtrjW','2015-10-02 19:26:33','2015-10-02 19:26:33','2015-10-02 19:32:35',3,0,1,'N;',NULL,NULL);

/*!40000 ALTER TABLE `admin_user` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table adminnotification_inbox
# ------------------------------------------------------------

DROP TABLE IF EXISTS `adminnotification_inbox`;

CREATE TABLE `adminnotification_inbox` (
  `notification_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Notification id',
  `severity` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Problem type',
  `date_added` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Create date',
  `title` varchar(255) NOT NULL COMMENT 'Title',
  `description` text COMMENT 'Description',
  `url` varchar(255) DEFAULT NULL COMMENT 'Url',
  `is_read` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Flag if notification read',
  `is_remove` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Flag if notification might be removed',
  PRIMARY KEY (`notification_id`),
  KEY `IDX_ADMINNOTIFICATION_INBOX_SEVERITY` (`severity`),
  KEY `IDX_ADMINNOTIFICATION_INBOX_IS_READ` (`is_read`),
  KEY `IDX_ADMINNOTIFICATION_INBOX_IS_REMOVE` (`is_remove`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Adminnotification Inbox';



# Dump of table api_assert
# ------------------------------------------------------------

DROP TABLE IF EXISTS `api_assert`;

CREATE TABLE `api_assert` (
  `assert_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Assert id',
  `assert_type` varchar(20) DEFAULT NULL COMMENT 'Assert type',
  `assert_data` text COMMENT 'Assert additional data',
  PRIMARY KEY (`assert_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Api ACL Asserts';



# Dump of table api_role
# ------------------------------------------------------------

DROP TABLE IF EXISTS `api_role`;

CREATE TABLE `api_role` (
  `role_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Role id',
  `parent_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Parent role id',
  `tree_level` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Role level in tree',
  `sort_order` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Sort order to display on admin area',
  `role_type` varchar(1) NOT NULL DEFAULT '0' COMMENT 'Role type',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'User id',
  `role_name` varchar(50) DEFAULT NULL COMMENT 'Role name',
  PRIMARY KEY (`role_id`),
  KEY `IDX_API_ROLE_PARENT_ID_SORT_ORDER` (`parent_id`,`sort_order`),
  KEY `IDX_API_ROLE_TREE_LEVEL` (`tree_level`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Api ACL Roles';



# Dump of table api_rule
# ------------------------------------------------------------

DROP TABLE IF EXISTS `api_rule`;

CREATE TABLE `api_rule` (
  `rule_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Api rule Id',
  `role_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Api role Id',
  `resource_id` varchar(255) DEFAULT NULL COMMENT 'Module code',
  `api_privileges` varchar(20) DEFAULT NULL COMMENT 'Privileges',
  `assert_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Assert id',
  `role_type` varchar(1) DEFAULT NULL COMMENT 'Role type',
  `api_permission` varchar(10) DEFAULT NULL COMMENT 'Permission',
  PRIMARY KEY (`rule_id`),
  KEY `IDX_API_RULE_RESOURCE_ID_ROLE_ID` (`resource_id`,`role_id`),
  KEY `IDX_API_RULE_ROLE_ID_RESOURCE_ID` (`role_id`,`resource_id`),
  CONSTRAINT `FK_API_RULE_ROLE_ID_API_ROLE_ROLE_ID` FOREIGN KEY (`role_id`) REFERENCES `api_role` (`role_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Api ACL Rules';



# Dump of table api_session
# ------------------------------------------------------------

DROP TABLE IF EXISTS `api_session`;

CREATE TABLE `api_session` (
  `user_id` int(10) unsigned NOT NULL COMMENT 'User id',
  `logdate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Login date',
  `sessid` varchar(40) DEFAULT NULL COMMENT 'Sessioin id',
  KEY `IDX_API_SESSION_USER_ID` (`user_id`),
  KEY `IDX_API_SESSION_SESSID` (`sessid`),
  CONSTRAINT `FK_API_SESSION_USER_ID_API_USER_USER_ID` FOREIGN KEY (`user_id`) REFERENCES `api_user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Api Sessions';



# Dump of table api_user
# ------------------------------------------------------------

DROP TABLE IF EXISTS `api_user`;

CREATE TABLE `api_user` (
  `user_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'User id',
  `firstname` varchar(32) DEFAULT NULL COMMENT 'First name',
  `lastname` varchar(32) DEFAULT NULL COMMENT 'Last name',
  `email` varchar(128) DEFAULT NULL COMMENT 'Email',
  `username` varchar(40) DEFAULT NULL COMMENT 'Nickname',
  `api_key` varchar(100) DEFAULT NULL COMMENT 'Api key',
  `created` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'User record create date',
  `modified` timestamp NULL DEFAULT NULL COMMENT 'User record modify date',
  `lognum` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Quantity of log ins',
  `reload_acl_flag` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Refresh ACL flag',
  `is_active` smallint(6) NOT NULL DEFAULT '1' COMMENT 'Account status',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Api Users';



# Dump of table api2_acl_attribute
# ------------------------------------------------------------

DROP TABLE IF EXISTS `api2_acl_attribute`;

CREATE TABLE `api2_acl_attribute` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity ID',
  `user_type` varchar(20) NOT NULL COMMENT 'Type of user',
  `resource_id` varchar(255) NOT NULL COMMENT 'Resource ID',
  `operation` varchar(20) NOT NULL COMMENT 'Operation',
  `allowed_attributes` text COMMENT 'Allowed attributes',
  PRIMARY KEY (`entity_id`),
  UNIQUE KEY `UNQ_API2_ACL_ATTRIBUTE_USER_TYPE_RESOURCE_ID_OPERATION` (`user_type`,`resource_id`,`operation`),
  KEY `IDX_API2_ACL_ATTRIBUTE_USER_TYPE` (`user_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Api2 Filter ACL Attributes';



# Dump of table api2_acl_role
# ------------------------------------------------------------

DROP TABLE IF EXISTS `api2_acl_role`;

CREATE TABLE `api2_acl_role` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity ID',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Created At',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'Updated At',
  `role_name` varchar(255) NOT NULL COMMENT 'Name of role',
  PRIMARY KEY (`entity_id`),
  KEY `IDX_API2_ACL_ROLE_CREATED_AT` (`created_at`),
  KEY `IDX_API2_ACL_ROLE_UPDATED_AT` (`updated_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Api2 Global ACL Roles';

LOCK TABLES `api2_acl_role` WRITE;
/*!40000 ALTER TABLE `api2_acl_role` DISABLE KEYS */;

INSERT INTO `api2_acl_role` (`entity_id`, `created_at`, `updated_at`, `role_name`)
VALUES
	(1,'2015-10-02 19:23:28',NULL,'Guest'),
	(2,'2015-10-02 19:23:28',NULL,'Customer');

/*!40000 ALTER TABLE `api2_acl_role` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table api2_acl_rule
# ------------------------------------------------------------

DROP TABLE IF EXISTS `api2_acl_rule`;

CREATE TABLE `api2_acl_rule` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity ID',
  `role_id` int(10) unsigned NOT NULL COMMENT 'Role ID',
  `resource_id` varchar(255) NOT NULL COMMENT 'Resource ID',
  `privilege` varchar(20) DEFAULT NULL COMMENT 'ACL Privilege',
  PRIMARY KEY (`entity_id`),
  UNIQUE KEY `UNQ_API2_ACL_RULE_ROLE_ID_RESOURCE_ID_PRIVILEGE` (`role_id`,`resource_id`,`privilege`),
  CONSTRAINT `FK_API2_ACL_RULE_ROLE_ID_API2_ACL_ROLE_ENTITY_ID` FOREIGN KEY (`role_id`) REFERENCES `api2_acl_role` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Api2 Global ACL Rules';



# Dump of table api2_acl_user
# ------------------------------------------------------------

DROP TABLE IF EXISTS `api2_acl_user`;

CREATE TABLE `api2_acl_user` (
  `admin_id` int(10) unsigned NOT NULL COMMENT 'Admin ID',
  `role_id` int(10) unsigned NOT NULL COMMENT 'Role ID',
  UNIQUE KEY `UNQ_API2_ACL_USER_ADMIN_ID` (`admin_id`),
  KEY `FK_API2_ACL_USER_ROLE_ID_API2_ACL_ROLE_ENTITY_ID` (`role_id`),
  CONSTRAINT `FK_API2_ACL_USER_ADMIN_ID_ADMIN_USER_USER_ID` FOREIGN KEY (`admin_id`) REFERENCES `admin_user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_API2_ACL_USER_ROLE_ID_API2_ACL_ROLE_ENTITY_ID` FOREIGN KEY (`role_id`) REFERENCES `api2_acl_role` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Api2 Global ACL Users';



# Dump of table captcha_log
# ------------------------------------------------------------

DROP TABLE IF EXISTS `captcha_log`;

CREATE TABLE `captcha_log` (
  `type` varchar(32) NOT NULL COMMENT 'Type',
  `value` varchar(32) NOT NULL COMMENT 'Value',
  `count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Count',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'Update Time',
  PRIMARY KEY (`type`,`value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Count Login Attempts';



# Dump of table catalog_category_anc_categs_index_idx
# ------------------------------------------------------------

DROP TABLE IF EXISTS `catalog_category_anc_categs_index_idx`;

CREATE TABLE `catalog_category_anc_categs_index_idx` (
  `category_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Category ID',
  `path` varchar(255) DEFAULT NULL COMMENT 'Path',
  KEY `IDX_CATALOG_CATEGORY_ANC_CATEGS_INDEX_IDX_CATEGORY_ID` (`category_id`),
  KEY `IDX_CATALOG_CATEGORY_ANC_CATEGS_INDEX_IDX_PATH_CATEGORY_ID` (`path`,`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Category Anchor Indexer Index Table';



# Dump of table catalog_category_anc_categs_index_tmp
# ------------------------------------------------------------

DROP TABLE IF EXISTS `catalog_category_anc_categs_index_tmp`;

CREATE TABLE `catalog_category_anc_categs_index_tmp` (
  `category_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Category ID',
  `path` varchar(255) DEFAULT NULL COMMENT 'Path',
  KEY `IDX_CATALOG_CATEGORY_ANC_CATEGS_INDEX_TMP_CATEGORY_ID` (`category_id`),
  KEY `IDX_CATALOG_CATEGORY_ANC_CATEGS_INDEX_TMP_PATH_CATEGORY_ID` (`path`,`category_id`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8 COMMENT='Catalog Category Anchor Indexer Temp Table';



# Dump of table catalog_category_anc_products_index_idx
# ------------------------------------------------------------

DROP TABLE IF EXISTS `catalog_category_anc_products_index_idx`;

CREATE TABLE `catalog_category_anc_products_index_idx` (
  `category_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Category ID',
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product ID',
  `position` int(10) unsigned DEFAULT NULL COMMENT 'Position',
  KEY `IDX_CAT_CTGR_ANC_PRDS_IDX_IDX_CTGR_ID_PRD_ID_POSITION` (`category_id`,`product_id`,`position`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Category Anchor Product Indexer Index Table';



# Dump of table catalog_category_anc_products_index_tmp
# ------------------------------------------------------------

DROP TABLE IF EXISTS `catalog_category_anc_products_index_tmp`;

CREATE TABLE `catalog_category_anc_products_index_tmp` (
  `category_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Category ID',
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product ID',
  `position` int(10) unsigned DEFAULT NULL COMMENT 'Position',
  KEY `IDX_CAT_CTGR_ANC_PRDS_IDX_TMP_CTGR_ID_PRD_ID_POSITION` (`category_id`,`product_id`,`position`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8 COMMENT='Catalog Category Anchor Product Indexer Temp Table';



# Dump of table catalog_category_entity
# ------------------------------------------------------------

DROP TABLE IF EXISTS `catalog_category_entity`;

CREATE TABLE `catalog_category_entity` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity ID',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type ID',
  `attribute_set_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attriute Set ID',
  `parent_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Parent Category ID',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Creation Time',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'Update Time',
  `path` varchar(255) NOT NULL COMMENT 'Tree Path',
  `position` int(11) NOT NULL COMMENT 'Position',
  `level` int(11) NOT NULL DEFAULT '0' COMMENT 'Tree Level',
  `children_count` int(11) NOT NULL COMMENT 'Child Count',
  PRIMARY KEY (`entity_id`),
  KEY `IDX_CATALOG_CATEGORY_ENTITY_LEVEL` (`level`),
  KEY `IDX_CATALOG_CATEGORY_ENTITY_PATH_ENTITY_ID` (`path`,`entity_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Category Table';

LOCK TABLES `catalog_category_entity` WRITE;
/*!40000 ALTER TABLE `catalog_category_entity` DISABLE KEYS */;

INSERT INTO `catalog_category_entity` (`entity_id`, `entity_type_id`, `attribute_set_id`, `parent_id`, `created_at`, `updated_at`, `path`, `position`, `level`, `children_count`)
VALUES
	(1,3,0,0,'2015-10-02 19:24:38','2015-10-02 19:24:38','1',0,0,1),
	(2,3,3,1,'2015-10-02 19:24:40','2015-10-02 19:24:40','1/2',1,1,0);

/*!40000 ALTER TABLE `catalog_category_entity` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table catalog_category_entity_datetime
# ------------------------------------------------------------

DROP TABLE IF EXISTS `catalog_category_entity_datetime`;

CREATE TABLE `catalog_category_entity_datetime` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value ID',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type ID',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity ID',
  `value` datetime DEFAULT NULL COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_CAT_CTGR_ENTT_DTIME_ENTT_TYPE_ID_ENTT_ID_ATTR_ID_STORE_ID` (`entity_type_id`,`entity_id`,`attribute_id`,`store_id`),
  KEY `IDX_CATALOG_CATEGORY_ENTITY_DATETIME_ENTITY_ID` (`entity_id`),
  KEY `IDX_CATALOG_CATEGORY_ENTITY_DATETIME_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_CATALOG_CATEGORY_ENTITY_DATETIME_STORE_ID` (`store_id`),
  CONSTRAINT `FK_CAT_CTGR_ENTT_DTIME_ATTR_ID_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CAT_CTGR_ENTT_DTIME_ENTT_ID_CAT_CTGR_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `catalog_category_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CATALOG_CATEGORY_ENTITY_DATETIME_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Category Datetime Attribute Backend Table';



# Dump of table catalog_category_entity_decimal
# ------------------------------------------------------------

DROP TABLE IF EXISTS `catalog_category_entity_decimal`;

CREATE TABLE `catalog_category_entity_decimal` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value ID',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type ID',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity ID',
  `value` decimal(12,4) DEFAULT NULL COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_CAT_CTGR_ENTT_DEC_ENTT_TYPE_ID_ENTT_ID_ATTR_ID_STORE_ID` (`entity_type_id`,`entity_id`,`attribute_id`,`store_id`),
  KEY `IDX_CATALOG_CATEGORY_ENTITY_DECIMAL_ENTITY_ID` (`entity_id`),
  KEY `IDX_CATALOG_CATEGORY_ENTITY_DECIMAL_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_CATALOG_CATEGORY_ENTITY_DECIMAL_STORE_ID` (`store_id`),
  CONSTRAINT `FK_CAT_CTGR_ENTT_DEC_ATTR_ID_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CAT_CTGR_ENTT_DEC_ENTT_ID_CAT_CTGR_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `catalog_category_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CATALOG_CATEGORY_ENTITY_DECIMAL_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Category Decimal Attribute Backend Table';



# Dump of table catalog_category_entity_int
# ------------------------------------------------------------

DROP TABLE IF EXISTS `catalog_category_entity_int`;

CREATE TABLE `catalog_category_entity_int` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value ID',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type ID',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity ID',
  `value` int(11) DEFAULT NULL COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_CAT_CTGR_ENTT_INT_ENTT_TYPE_ID_ENTT_ID_ATTR_ID_STORE_ID` (`entity_type_id`,`entity_id`,`attribute_id`,`store_id`),
  KEY `IDX_CATALOG_CATEGORY_ENTITY_INT_ENTITY_ID` (`entity_id`),
  KEY `IDX_CATALOG_CATEGORY_ENTITY_INT_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_CATALOG_CATEGORY_ENTITY_INT_STORE_ID` (`store_id`),
  CONSTRAINT `FK_CAT_CTGR_ENTT_INT_ATTR_ID_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CAT_CTGR_ENTT_INT_ENTT_ID_CAT_CTGR_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `catalog_category_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CATALOG_CATEGORY_ENTITY_INT_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Category Integer Attribute Backend Table';

LOCK TABLES `catalog_category_entity_int` WRITE;
/*!40000 ALTER TABLE `catalog_category_entity_int` DISABLE KEYS */;

INSERT INTO `catalog_category_entity_int` (`value_id`, `entity_type_id`, `attribute_id`, `store_id`, `entity_id`, `value`)
VALUES
	(1,3,67,0,1,1),
	(2,3,67,1,1,1),
	(3,3,42,0,2,1),
	(4,3,67,0,2,1),
	(5,3,42,1,2,1),
	(6,3,67,1,2,1);

/*!40000 ALTER TABLE `catalog_category_entity_int` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table catalog_category_entity_text
# ------------------------------------------------------------

DROP TABLE IF EXISTS `catalog_category_entity_text`;

CREATE TABLE `catalog_category_entity_text` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value ID',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type ID',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity ID',
  `value` text COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_CAT_CTGR_ENTT_TEXT_ENTT_TYPE_ID_ENTT_ID_ATTR_ID_STORE_ID` (`entity_type_id`,`entity_id`,`attribute_id`,`store_id`),
  KEY `IDX_CATALOG_CATEGORY_ENTITY_TEXT_ENTITY_ID` (`entity_id`),
  KEY `IDX_CATALOG_CATEGORY_ENTITY_TEXT_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_CATALOG_CATEGORY_ENTITY_TEXT_STORE_ID` (`store_id`),
  CONSTRAINT `FK_CAT_CTGR_ENTT_TEXT_ATTR_ID_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CAT_CTGR_ENTT_TEXT_ENTT_ID_CAT_CTGR_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `catalog_category_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CATALOG_CATEGORY_ENTITY_TEXT_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Category Text Attribute Backend Table';

LOCK TABLES `catalog_category_entity_text` WRITE;
/*!40000 ALTER TABLE `catalog_category_entity_text` DISABLE KEYS */;

INSERT INTO `catalog_category_entity_text` (`value_id`, `entity_type_id`, `attribute_id`, `store_id`, `entity_id`, `value`)
VALUES
	(1,3,65,0,1,NULL),
	(2,3,65,1,1,NULL),
	(3,3,65,0,2,NULL),
	(4,3,65,1,2,NULL);

/*!40000 ALTER TABLE `catalog_category_entity_text` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table catalog_category_entity_varchar
# ------------------------------------------------------------

DROP TABLE IF EXISTS `catalog_category_entity_varchar`;

CREATE TABLE `catalog_category_entity_varchar` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value ID',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type ID',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity ID',
  `value` varchar(255) DEFAULT NULL COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_CAT_CTGR_ENTT_VCHR_ENTT_TYPE_ID_ENTT_ID_ATTR_ID_STORE_ID` (`entity_type_id`,`entity_id`,`attribute_id`,`store_id`),
  KEY `IDX_CATALOG_CATEGORY_ENTITY_VARCHAR_ENTITY_ID` (`entity_id`),
  KEY `IDX_CATALOG_CATEGORY_ENTITY_VARCHAR_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_CATALOG_CATEGORY_ENTITY_VARCHAR_STORE_ID` (`store_id`),
  CONSTRAINT `FK_CAT_CTGR_ENTT_VCHR_ATTR_ID_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CAT_CTGR_ENTT_VCHR_ENTT_ID_CAT_CTGR_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `catalog_category_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CATALOG_CATEGORY_ENTITY_VARCHAR_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Category Varchar Attribute Backend Table';

LOCK TABLES `catalog_category_entity_varchar` WRITE;
/*!40000 ALTER TABLE `catalog_category_entity_varchar` DISABLE KEYS */;

INSERT INTO `catalog_category_entity_varchar` (`value_id`, `entity_type_id`, `attribute_id`, `store_id`, `entity_id`, `value`)
VALUES
	(1,3,41,0,1,'Root Catalog'),
	(2,3,41,1,1,'Root Catalog'),
	(3,3,43,1,1,'root-catalog'),
	(4,3,41,0,2,'Default Category'),
	(5,3,41,1,2,'Default Category'),
	(6,3,49,1,2,'PRODUCTS'),
	(7,3,43,1,2,'default-category');

/*!40000 ALTER TABLE `catalog_category_entity_varchar` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table catalog_category_product
# ------------------------------------------------------------

DROP TABLE IF EXISTS `catalog_category_product`;

CREATE TABLE `catalog_category_product` (
  `category_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Category ID',
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product ID',
  `position` int(11) NOT NULL DEFAULT '0' COMMENT 'Position',
  PRIMARY KEY (`category_id`,`product_id`),
  KEY `IDX_CATALOG_CATEGORY_PRODUCT_PRODUCT_ID` (`product_id`),
  CONSTRAINT `FK_CAT_CTGR_PRD_CTGR_ID_CAT_CTGR_ENTT_ENTT_ID` FOREIGN KEY (`category_id`) REFERENCES `catalog_category_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CAT_CTGR_PRD_PRD_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product To Category Linkage Table';



# Dump of table catalog_category_product_index
# ------------------------------------------------------------

DROP TABLE IF EXISTS `catalog_category_product_index`;

CREATE TABLE `catalog_category_product_index` (
  `category_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Category ID',
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product ID',
  `position` int(11) DEFAULT NULL COMMENT 'Position',
  `is_parent` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Parent',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `visibility` smallint(5) unsigned NOT NULL COMMENT 'Visibility',
  PRIMARY KEY (`category_id`,`product_id`,`store_id`),
  KEY `IDX_CAT_CTGR_PRD_IDX_PRD_ID_STORE_ID_CTGR_ID_VISIBILITY` (`product_id`,`store_id`,`category_id`,`visibility`),
  KEY `15D3C269665C74C2219037D534F4B0DC` (`store_id`,`category_id`,`visibility`,`is_parent`,`position`),
  CONSTRAINT `FK_CATALOG_CATEGORY_PRODUCT_INDEX_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CAT_CTGR_PRD_IDX_CTGR_ID_CAT_CTGR_ENTT_ENTT_ID` FOREIGN KEY (`category_id`) REFERENCES `catalog_category_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CAT_CTGR_PRD_IDX_PRD_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Category Product Index';



# Dump of table catalog_category_product_index_enbl_idx
# ------------------------------------------------------------

DROP TABLE IF EXISTS `catalog_category_product_index_enbl_idx`;

CREATE TABLE `catalog_category_product_index_enbl_idx` (
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product ID',
  `visibility` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Visibility',
  KEY `IDX_CAT_CTGR_PRD_IDX_ENBL_IDX_PRD_ID_VISIBILITY` (`product_id`,`visibility`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Category Product Enabled Indexer Index Table';



# Dump of table catalog_category_product_index_enbl_tmp
# ------------------------------------------------------------

DROP TABLE IF EXISTS `catalog_category_product_index_enbl_tmp`;

CREATE TABLE `catalog_category_product_index_enbl_tmp` (
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product ID',
  `visibility` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Visibility',
  KEY `IDX_CAT_CTGR_PRD_IDX_ENBL_TMP_PRD_ID_VISIBILITY` (`product_id`,`visibility`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8 COMMENT='Catalog Category Product Enabled Indexer Temp Table';



# Dump of table catalog_category_product_index_idx
# ------------------------------------------------------------

DROP TABLE IF EXISTS `catalog_category_product_index_idx`;

CREATE TABLE `catalog_category_product_index_idx` (
  `category_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Category ID',
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product ID',
  `position` int(11) NOT NULL DEFAULT '0' COMMENT 'Position',
  `is_parent` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Parent',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `visibility` smallint(5) unsigned NOT NULL COMMENT 'Visibility',
  KEY `IDX_CAT_CTGR_PRD_IDX_IDX_PRD_ID_CTGR_ID_STORE_ID` (`product_id`,`category_id`,`store_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Category Product Indexer Index Table';



# Dump of table catalog_category_product_index_tmp
# ------------------------------------------------------------

DROP TABLE IF EXISTS `catalog_category_product_index_tmp`;

CREATE TABLE `catalog_category_product_index_tmp` (
  `category_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Category ID',
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product ID',
  `position` int(11) NOT NULL DEFAULT '0' COMMENT 'Position',
  `is_parent` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Parent',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `visibility` smallint(5) unsigned NOT NULL COMMENT 'Visibility',
  KEY `IDX_CAT_CTGR_PRD_IDX_TMP_PRD_ID_CTGR_ID_STORE_ID` (`product_id`,`category_id`,`store_id`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8 COMMENT='Catalog Category Product Indexer Temp Table';



# Dump of table catalog_compare_item
# ------------------------------------------------------------

DROP TABLE IF EXISTS `catalog_compare_item`;

CREATE TABLE `catalog_compare_item` (
  `catalog_compare_item_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Compare Item ID',
  `visitor_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Visitor ID',
  `customer_id` int(10) unsigned DEFAULT NULL COMMENT 'Customer ID',
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product ID',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store ID',
  PRIMARY KEY (`catalog_compare_item_id`),
  KEY `IDX_CATALOG_COMPARE_ITEM_CUSTOMER_ID` (`customer_id`),
  KEY `IDX_CATALOG_COMPARE_ITEM_PRODUCT_ID` (`product_id`),
  KEY `IDX_CATALOG_COMPARE_ITEM_VISITOR_ID_PRODUCT_ID` (`visitor_id`,`product_id`),
  KEY `IDX_CATALOG_COMPARE_ITEM_CUSTOMER_ID_PRODUCT_ID` (`customer_id`,`product_id`),
  KEY `IDX_CATALOG_COMPARE_ITEM_STORE_ID` (`store_id`),
  CONSTRAINT `FK_CATALOG_COMPARE_ITEM_CUSTOMER_ID_CUSTOMER_ENTITY_ENTITY_ID` FOREIGN KEY (`customer_id`) REFERENCES `customer_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CAT_CMP_ITEM_PRD_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CATALOG_COMPARE_ITEM_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Compare Table';



# Dump of table catalog_eav_attribute
# ------------------------------------------------------------

DROP TABLE IF EXISTS `catalog_eav_attribute`;

CREATE TABLE `catalog_eav_attribute` (
  `attribute_id` smallint(5) unsigned NOT NULL COMMENT 'Attribute ID',
  `frontend_input_renderer` varchar(255) DEFAULT NULL COMMENT 'Frontend Input Renderer',
  `is_global` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Is Global',
  `is_visible` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Is Visible',
  `is_searchable` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Searchable',
  `is_filterable` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Filterable',
  `is_comparable` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Comparable',
  `is_visible_on_front` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Visible On Front',
  `is_html_allowed_on_front` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is HTML Allowed On Front',
  `is_used_for_price_rules` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Used For Price Rules',
  `is_filterable_in_search` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Filterable In Search',
  `used_in_product_listing` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Used In Product Listing',
  `used_for_sort_by` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Used For Sorting',
  `is_configurable` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Is Configurable',
  `apply_to` varchar(255) DEFAULT NULL COMMENT 'Apply To',
  `is_visible_in_advanced_search` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Visible In Advanced Search',
  `position` int(11) NOT NULL DEFAULT '0' COMMENT 'Position',
  `is_wysiwyg_enabled` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is WYSIWYG Enabled',
  `is_used_for_promo_rules` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Used For Promo Rules',
  PRIMARY KEY (`attribute_id`),
  KEY `IDX_CATALOG_EAV_ATTRIBUTE_USED_FOR_SORT_BY` (`used_for_sort_by`),
  KEY `IDX_CATALOG_EAV_ATTRIBUTE_USED_IN_PRODUCT_LISTING` (`used_in_product_listing`),
  CONSTRAINT `FK_CATALOG_EAV_ATTRIBUTE_ATTRIBUTE_ID_EAV_ATTRIBUTE_ATTRIBUTE_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog EAV Attribute Table';

LOCK TABLES `catalog_eav_attribute` WRITE;
/*!40000 ALTER TABLE `catalog_eav_attribute` DISABLE KEYS */;

INSERT INTO `catalog_eav_attribute` (`attribute_id`, `frontend_input_renderer`, `is_global`, `is_visible`, `is_searchable`, `is_filterable`, `is_comparable`, `is_visible_on_front`, `is_html_allowed_on_front`, `is_used_for_price_rules`, `is_filterable_in_search`, `used_in_product_listing`, `used_for_sort_by`, `is_configurable`, `apply_to`, `is_visible_in_advanced_search`, `position`, `is_wysiwyg_enabled`, `is_used_for_promo_rules`)
VALUES
	(41,NULL,0,1,0,0,0,0,0,0,0,0,0,1,NULL,0,0,0,0),
	(42,NULL,0,1,0,0,0,0,0,0,0,0,0,1,NULL,0,0,0,0),
	(43,NULL,0,1,0,0,0,0,0,0,0,0,0,1,NULL,0,0,0,0),
	(44,NULL,0,1,0,0,0,0,1,0,0,0,0,1,NULL,0,0,1,0),
	(45,NULL,0,1,0,0,0,0,0,0,0,0,0,1,NULL,0,0,0,0),
	(46,NULL,0,1,0,0,0,0,0,0,0,0,0,1,NULL,0,0,0,0),
	(47,NULL,0,1,0,0,0,0,0,0,0,0,0,1,NULL,0,0,0,0),
	(48,NULL,0,1,0,0,0,0,0,0,0,0,0,1,NULL,0,0,0,0),
	(49,NULL,0,1,0,0,0,0,0,0,0,0,0,1,NULL,0,0,0,0),
	(50,NULL,0,1,0,0,0,0,0,0,0,0,0,1,NULL,0,0,0,0),
	(51,NULL,1,1,0,0,0,0,0,0,0,0,0,1,NULL,0,0,0,0),
	(52,NULL,1,0,0,0,0,0,0,0,0,0,0,1,NULL,0,0,0,0),
	(53,NULL,1,0,0,0,0,0,0,0,0,0,0,1,NULL,0,0,0,0),
	(54,NULL,1,0,0,0,0,0,0,0,0,0,0,1,NULL,0,0,0,0),
	(55,NULL,1,0,0,0,0,0,0,0,0,0,0,1,NULL,0,0,0,0),
	(56,NULL,1,0,0,0,0,0,0,0,0,0,0,1,NULL,0,0,0,0),
	(57,NULL,0,0,0,0,0,0,0,0,0,0,0,1,NULL,0,0,0,0),
	(58,NULL,0,1,0,0,0,0,0,0,0,0,0,1,NULL,0,0,0,0),
	(59,NULL,0,1,0,0,0,0,0,0,0,0,0,1,NULL,0,0,0,0),
	(60,NULL,0,1,0,0,0,0,0,0,0,0,0,1,NULL,0,0,0,0),
	(61,NULL,0,1,0,0,0,0,0,0,0,0,0,1,NULL,0,0,0,0),
	(62,NULL,0,1,0,0,0,0,0,0,0,0,0,1,NULL,0,0,0,0),
	(63,NULL,1,0,0,0,0,0,0,0,0,0,0,1,NULL,0,0,0,0),
	(64,NULL,1,0,0,0,0,0,0,0,0,0,0,1,NULL,0,0,0,0),
	(65,'adminhtml/catalog_category_helper_sortby_available',0,1,0,0,0,0,0,0,0,0,0,1,NULL,0,0,0,0),
	(66,'adminhtml/catalog_category_helper_sortby_default',0,1,0,0,0,0,0,0,0,0,0,1,NULL,0,0,0,0),
	(67,NULL,0,1,0,0,0,0,0,0,0,0,0,1,NULL,0,0,0,0),
	(68,NULL,0,1,0,0,0,0,0,0,0,0,0,1,NULL,0,0,0,0),
	(69,NULL,0,1,0,0,0,0,0,0,0,0,0,1,NULL,0,0,0,0),
	(70,'adminhtml/catalog_category_helper_pricestep',0,1,0,0,0,0,0,0,0,0,0,1,NULL,0,0,0,0),
	(71,NULL,0,1,1,0,0,0,0,0,0,1,1,1,NULL,1,0,0,0),
	(72,NULL,0,1,1,0,1,0,1,0,0,0,0,1,NULL,1,0,1,0),
	(73,NULL,0,1,1,0,1,0,1,0,0,1,0,1,NULL,1,0,1,0),
	(74,NULL,1,1,1,0,1,0,0,0,0,0,0,1,NULL,1,0,0,0),
	(75,NULL,2,1,1,1,0,0,0,0,0,1,1,1,'simple,configurable,virtual,bundle,downloadable',1,0,0,0),
	(76,NULL,2,1,0,0,0,0,0,0,0,1,0,1,'simple,configurable,virtual,bundle,downloadable',0,0,0,0),
	(77,NULL,2,1,0,0,0,0,0,0,0,1,0,1,'simple,configurable,virtual,bundle,downloadable',0,0,0,0),
	(78,NULL,2,1,0,0,0,0,0,0,0,1,0,1,'simple,configurable,virtual,bundle,downloadable',0,0,0,0),
	(79,NULL,2,1,0,0,0,0,0,0,0,0,0,1,'virtual,downloadable',0,0,0,0),
	(80,NULL,1,1,0,0,0,0,0,0,0,0,0,1,'simple,bundle',0,0,0,0),
	(81,NULL,1,1,1,1,1,0,0,0,0,0,0,1,'simple',1,0,0,0),
	(82,NULL,0,1,0,0,0,0,0,0,0,0,0,1,NULL,0,0,0,0),
	(83,NULL,0,1,0,0,0,0,0,0,0,0,0,1,NULL,0,0,0,0),
	(84,NULL,0,1,0,0,0,0,0,0,0,0,0,1,NULL,0,0,0,0),
	(85,NULL,0,1,0,0,0,0,0,0,0,0,0,1,NULL,0,0,0,0),
	(86,NULL,0,1,0,0,0,0,0,0,0,1,0,1,NULL,0,0,0,0),
	(87,NULL,0,1,0,0,0,0,0,0,0,1,0,1,NULL,0,0,0,0),
	(88,NULL,1,1,0,0,0,0,0,0,0,0,0,1,NULL,0,0,0,0),
	(89,NULL,1,0,0,0,0,0,0,0,0,0,0,1,NULL,0,0,0,0),
	(90,NULL,2,1,0,0,0,0,0,0,0,0,0,1,'simple,configurable,virtual,bundle,downloadable',0,0,0,0),
	(91,NULL,2,1,0,0,0,0,0,0,0,0,0,1,'simple,configurable,virtual,bundle,downloadable',0,0,0,0),
	(92,NULL,1,1,1,1,1,0,0,0,0,0,0,1,'simple',1,0,0,0),
	(93,NULL,2,1,0,0,0,0,0,0,0,1,0,1,NULL,0,0,0,0),
	(94,NULL,2,1,0,0,0,0,0,0,0,1,0,1,NULL,0,0,0,0),
	(95,NULL,1,1,0,0,0,0,0,0,0,0,0,1,NULL,0,0,0,0),
	(96,NULL,2,1,1,0,0,0,0,0,0,1,0,1,NULL,0,0,0,0),
	(97,NULL,0,1,0,0,0,0,0,0,0,1,0,1,NULL,0,0,0,0),
	(98,NULL,0,0,0,0,0,0,0,0,0,0,0,1,NULL,0,0,0,0),
	(99,NULL,0,0,0,0,0,0,0,0,0,0,0,1,'simple,configurable,virtual,bundle,downloadable',0,0,0,0),
	(100,NULL,1,1,0,0,0,0,0,0,0,0,0,0,'simple,virtual',0,0,0,0),
	(101,NULL,1,1,0,0,0,0,0,0,0,0,0,0,'simple,virtual',0,0,0,0),
	(102,NULL,0,1,0,0,0,0,0,0,0,0,0,1,NULL,0,0,0,0),
	(103,NULL,0,1,0,0,0,0,0,0,0,0,0,1,NULL,0,0,0,0),
	(104,NULL,0,1,0,0,0,0,0,0,0,0,0,1,NULL,0,0,0,0),
	(105,NULL,0,1,0,0,0,0,0,0,0,0,0,1,NULL,0,0,0,0),
	(106,NULL,0,1,0,0,0,0,0,0,0,0,0,1,NULL,0,0,0,0),
	(107,NULL,0,1,0,0,0,0,0,0,0,0,0,1,NULL,0,0,0,0),
	(108,NULL,1,0,0,0,0,0,0,0,0,0,0,1,NULL,0,0,0,0),
	(109,NULL,0,1,0,0,0,0,0,0,0,0,0,1,NULL,0,0,0,0),
	(110,NULL,1,0,0,0,0,0,0,0,0,1,0,1,NULL,0,0,0,0),
	(111,NULL,1,0,0,0,0,0,0,0,0,0,0,1,NULL,0,0,0,0),
	(112,NULL,0,0,0,0,0,0,0,0,0,1,0,0,NULL,0,0,0,0),
	(113,NULL,0,0,0,0,0,0,0,0,0,1,0,0,NULL,0,0,0,0),
	(114,NULL,0,0,0,0,0,0,0,0,0,1,0,0,NULL,0,0,0,0),
	(115,NULL,1,0,0,0,0,0,0,0,0,0,0,1,NULL,0,0,0,0),
	(116,NULL,1,0,0,0,0,0,0,0,0,0,0,1,NULL,0,0,0,0),
	(117,NULL,2,1,0,0,0,0,0,0,0,0,0,0,'simple,configurable,bundle,grouped',0,0,0,0),
	(118,'adminhtml/catalog_product_helper_form_msrp_enabled',2,1,0,0,0,0,0,0,0,1,0,1,'simple,bundle,configurable,virtual,downloadable',0,0,0,0),
	(119,'adminhtml/catalog_product_helper_form_msrp_price',2,1,0,0,0,0,0,0,0,1,0,1,'simple,bundle,configurable,virtual,downloadable',0,0,0,0),
	(120,NULL,2,1,0,0,0,0,0,0,0,1,0,1,'simple,bundle,configurable,virtual,downloadable',0,0,0,0),
	(121,NULL,2,1,1,0,0,0,0,0,0,1,0,1,'simple,configurable,virtual,downloadable,bundle',1,0,0,0),
	(122,'giftmessage/adminhtml_product_helper_form_config',1,1,0,0,0,0,0,0,0,0,0,0,NULL,0,0,0,0),
	(123,NULL,1,0,0,0,0,0,0,0,0,1,0,0,'bundle',0,0,0,0),
	(124,NULL,1,0,0,0,0,0,0,0,0,0,0,0,'bundle',0,0,0,0),
	(125,NULL,1,0,0,0,0,0,0,0,0,1,0,0,'bundle',0,0,0,0),
	(126,NULL,1,1,0,0,0,0,0,0,0,1,0,0,'bundle',0,0,0,0),
	(127,NULL,1,0,0,0,0,0,0,0,0,1,0,0,'bundle',0,0,0,0),
	(128,NULL,1,0,0,0,0,0,0,0,0,1,0,0,'downloadable',0,0,0,0),
	(129,NULL,0,0,0,0,0,0,0,0,0,0,0,0,'downloadable',0,0,0,0),
	(130,NULL,0,0,0,0,0,0,0,0,0,0,0,0,'downloadable',0,0,0,0),
	(131,NULL,1,0,0,0,0,0,0,0,0,1,0,0,'downloadable',0,0,0,0),
	(132,NULL,0,1,0,0,0,0,0,0,0,0,0,1,NULL,0,0,0,0),
	(133,NULL,0,1,0,0,0,0,0,0,0,0,0,1,NULL,0,0,0,0),
	(134,NULL,0,1,0,0,0,0,0,0,0,0,0,1,NULL,0,0,0,0);

/*!40000 ALTER TABLE `catalog_eav_attribute` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table catalog_product_bundle_option
# ------------------------------------------------------------

DROP TABLE IF EXISTS `catalog_product_bundle_option`;

CREATE TABLE `catalog_product_bundle_option` (
  `option_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Option Id',
  `parent_id` int(10) unsigned NOT NULL COMMENT 'Parent Id',
  `required` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Required',
  `position` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Position',
  `type` varchar(255) DEFAULT NULL COMMENT 'Type',
  PRIMARY KEY (`option_id`),
  KEY `IDX_CATALOG_PRODUCT_BUNDLE_OPTION_PARENT_ID` (`parent_id`),
  CONSTRAINT `FK_CAT_PRD_BNDL_OPT_PARENT_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`parent_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Bundle Option';



# Dump of table catalog_product_bundle_option_value
# ------------------------------------------------------------

DROP TABLE IF EXISTS `catalog_product_bundle_option_value`;

CREATE TABLE `catalog_product_bundle_option_value` (
  `value_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Value Id',
  `option_id` int(10) unsigned NOT NULL COMMENT 'Option Id',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store Id',
  `title` varchar(255) DEFAULT NULL COMMENT 'Title',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_CATALOG_PRODUCT_BUNDLE_OPTION_VALUE_OPTION_ID_STORE_ID` (`option_id`,`store_id`),
  CONSTRAINT `FK_CAT_PRD_BNDL_OPT_VAL_OPT_ID_CAT_PRD_BNDL_OPT_OPT_ID` FOREIGN KEY (`option_id`) REFERENCES `catalog_product_bundle_option` (`option_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Bundle Option Value';



# Dump of table catalog_product_bundle_price_index
# ------------------------------------------------------------

DROP TABLE IF EXISTS `catalog_product_bundle_price_index`;

CREATE TABLE `catalog_product_bundle_price_index` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity Id',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website Id',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group Id',
  `min_price` decimal(12,4) NOT NULL COMMENT 'Min Price',
  `max_price` decimal(12,4) NOT NULL COMMENT 'Max Price',
  PRIMARY KEY (`entity_id`,`website_id`,`customer_group_id`),
  KEY `IDX_CATALOG_PRODUCT_BUNDLE_PRICE_INDEX_WEBSITE_ID` (`website_id`),
  KEY `IDX_CATALOG_PRODUCT_BUNDLE_PRICE_INDEX_CUSTOMER_GROUP_ID` (`customer_group_id`),
  CONSTRAINT `FK_CAT_PRD_BNDL_PRICE_IDX_CSTR_GROUP_ID_CSTR_GROUP_CSTR_GROUP_ID` FOREIGN KEY (`customer_group_id`) REFERENCES `customer_group` (`customer_group_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CAT_PRD_BNDL_PRICE_IDX_ENTT_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CAT_PRD_BNDL_PRICE_IDX_WS_ID_CORE_WS_WS_ID` FOREIGN KEY (`website_id`) REFERENCES `core_website` (`website_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Bundle Price Index';



# Dump of table catalog_product_bundle_selection
# ------------------------------------------------------------

DROP TABLE IF EXISTS `catalog_product_bundle_selection`;

CREATE TABLE `catalog_product_bundle_selection` (
  `selection_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Selection Id',
  `option_id` int(10) unsigned NOT NULL COMMENT 'Option Id',
  `parent_product_id` int(10) unsigned NOT NULL COMMENT 'Parent Product Id',
  `product_id` int(10) unsigned NOT NULL COMMENT 'Product Id',
  `position` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Position',
  `is_default` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Default',
  `selection_price_type` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Selection Price Type',
  `selection_price_value` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Selection Price Value',
  `selection_qty` decimal(12,4) DEFAULT NULL COMMENT 'Selection Qty',
  `selection_can_change_qty` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Selection Can Change Qty',
  PRIMARY KEY (`selection_id`),
  KEY `IDX_CATALOG_PRODUCT_BUNDLE_SELECTION_OPTION_ID` (`option_id`),
  KEY `IDX_CATALOG_PRODUCT_BUNDLE_SELECTION_PRODUCT_ID` (`product_id`),
  CONSTRAINT `FK_CAT_PRD_BNDL_SELECTION_OPT_ID_CAT_PRD_BNDL_OPT_OPT_ID` FOREIGN KEY (`option_id`) REFERENCES `catalog_product_bundle_option` (`option_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CAT_PRD_BNDL_SELECTION_PRD_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Bundle Selection';



# Dump of table catalog_product_bundle_selection_price
# ------------------------------------------------------------

DROP TABLE IF EXISTS `catalog_product_bundle_selection_price`;

CREATE TABLE `catalog_product_bundle_selection_price` (
  `selection_id` int(10) unsigned NOT NULL COMMENT 'Selection Id',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website Id',
  `selection_price_type` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Selection Price Type',
  `selection_price_value` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Selection Price Value',
  PRIMARY KEY (`selection_id`,`website_id`),
  KEY `IDX_CATALOG_PRODUCT_BUNDLE_SELECTION_PRICE_WEBSITE_ID` (`website_id`),
  CONSTRAINT `FK_CAT_PRD_BNDL_SELECTION_PRICE_WS_ID_CORE_WS_WS_ID` FOREIGN KEY (`website_id`) REFERENCES `core_website` (`website_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_DCF37523AA05D770A70AA4ED7C2616E4` FOREIGN KEY (`selection_id`) REFERENCES `catalog_product_bundle_selection` (`selection_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Bundle Selection Price';



# Dump of table catalog_product_bundle_stock_index
# ------------------------------------------------------------

DROP TABLE IF EXISTS `catalog_product_bundle_stock_index`;

CREATE TABLE `catalog_product_bundle_stock_index` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity Id',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website Id',
  `stock_id` smallint(5) unsigned NOT NULL COMMENT 'Stock Id',
  `option_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Option Id',
  `stock_status` smallint(6) DEFAULT '0' COMMENT 'Stock Status',
  PRIMARY KEY (`entity_id`,`website_id`,`stock_id`,`option_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Bundle Stock Index';



# Dump of table catalog_product_enabled_index
# ------------------------------------------------------------

DROP TABLE IF EXISTS `catalog_product_enabled_index`;

CREATE TABLE `catalog_product_enabled_index` (
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `visibility` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Visibility',
  PRIMARY KEY (`product_id`,`store_id`),
  KEY `IDX_CATALOG_PRODUCT_ENABLED_INDEX_STORE_ID` (`store_id`),
  CONSTRAINT `FK_CAT_PRD_ENABLED_IDX_PRD_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CATALOG_PRODUCT_ENABLED_INDEX_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Visibility Index Table';



# Dump of table catalog_product_entity
# ------------------------------------------------------------

DROP TABLE IF EXISTS `catalog_product_entity`;

CREATE TABLE `catalog_product_entity` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity ID',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type ID',
  `attribute_set_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Set ID',
  `type_id` varchar(32) NOT NULL DEFAULT 'simple' COMMENT 'Type ID',
  `sku` varchar(64) DEFAULT NULL COMMENT 'SKU',
  `has_options` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Has Options',
  `required_options` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Required Options',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Creation Time',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'Update Time',
  PRIMARY KEY (`entity_id`),
  KEY `IDX_CATALOG_PRODUCT_ENTITY_ENTITY_TYPE_ID` (`entity_type_id`),
  KEY `IDX_CATALOG_PRODUCT_ENTITY_ATTRIBUTE_SET_ID` (`attribute_set_id`),
  KEY `IDX_CATALOG_PRODUCT_ENTITY_SKU` (`sku`),
  CONSTRAINT `FK_CAT_PRD_ENTT_ATTR_SET_ID_EAV_ATTR_SET_ATTR_SET_ID` FOREIGN KEY (`attribute_set_id`) REFERENCES `eav_attribute_set` (`attribute_set_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CAT_PRD_ENTT_ENTT_TYPE_ID_EAV_ENTT_TYPE_ENTT_TYPE_ID` FOREIGN KEY (`entity_type_id`) REFERENCES `eav_entity_type` (`entity_type_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Table';



# Dump of table catalog_product_entity_datetime
# ------------------------------------------------------------

DROP TABLE IF EXISTS `catalog_product_entity_datetime`;

CREATE TABLE `catalog_product_entity_datetime` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value ID',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type ID',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity ID',
  `value` datetime DEFAULT NULL COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_CAT_PRD_ENTT_DTIME_ENTT_ID_ATTR_ID_STORE_ID` (`entity_id`,`attribute_id`,`store_id`),
  KEY `IDX_CATALOG_PRODUCT_ENTITY_DATETIME_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_CATALOG_PRODUCT_ENTITY_DATETIME_STORE_ID` (`store_id`),
  KEY `IDX_CATALOG_PRODUCT_ENTITY_DATETIME_ENTITY_ID` (`entity_id`),
  CONSTRAINT `FK_CAT_PRD_ENTT_DTIME_ATTR_ID_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CAT_PRD_ENTT_DTIME_ENTT_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CATALOG_PRODUCT_ENTITY_DATETIME_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Datetime Attribute Backend Table';



# Dump of table catalog_product_entity_decimal
# ------------------------------------------------------------

DROP TABLE IF EXISTS `catalog_product_entity_decimal`;

CREATE TABLE `catalog_product_entity_decimal` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value ID',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type ID',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity ID',
  `value` decimal(12,4) DEFAULT NULL COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_CAT_PRD_ENTT_DEC_ENTT_ID_ATTR_ID_STORE_ID` (`entity_id`,`attribute_id`,`store_id`),
  KEY `IDX_CATALOG_PRODUCT_ENTITY_DECIMAL_STORE_ID` (`store_id`),
  KEY `IDX_CATALOG_PRODUCT_ENTITY_DECIMAL_ENTITY_ID` (`entity_id`),
  KEY `IDX_CATALOG_PRODUCT_ENTITY_DECIMAL_ATTRIBUTE_ID` (`attribute_id`),
  CONSTRAINT `FK_CAT_PRD_ENTT_DEC_ATTR_ID_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CAT_PRD_ENTT_DEC_ENTT_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CATALOG_PRODUCT_ENTITY_DECIMAL_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Decimal Attribute Backend Table';



# Dump of table catalog_product_entity_gallery
# ------------------------------------------------------------

DROP TABLE IF EXISTS `catalog_product_entity_gallery`;

CREATE TABLE `catalog_product_entity_gallery` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value ID',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type ID',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity ID',
  `position` int(11) NOT NULL DEFAULT '0' COMMENT 'Position',
  `value` varchar(255) DEFAULT NULL COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_CAT_PRD_ENTT_GLR_ENTT_TYPE_ID_ENTT_ID_ATTR_ID_STORE_ID` (`entity_type_id`,`entity_id`,`attribute_id`,`store_id`),
  KEY `IDX_CATALOG_PRODUCT_ENTITY_GALLERY_ENTITY_ID` (`entity_id`),
  KEY `IDX_CATALOG_PRODUCT_ENTITY_GALLERY_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_CATALOG_PRODUCT_ENTITY_GALLERY_STORE_ID` (`store_id`),
  CONSTRAINT `FK_CAT_PRD_ENTT_GLR_ATTR_ID_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CAT_PRD_ENTT_GLR_ENTT_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CATALOG_PRODUCT_ENTITY_GALLERY_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Gallery Attribute Backend Table';



# Dump of table catalog_product_entity_group_price
# ------------------------------------------------------------

DROP TABLE IF EXISTS `catalog_product_entity_group_price`;

CREATE TABLE `catalog_product_entity_group_price` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value ID',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity ID',
  `all_groups` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Is Applicable To All Customer Groups',
  `customer_group_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Customer Group ID',
  `value` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Value',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `CC12C83765B562314470A24F2BDD0F36` (`entity_id`,`all_groups`,`customer_group_id`,`website_id`),
  KEY `IDX_CATALOG_PRODUCT_ENTITY_GROUP_PRICE_ENTITY_ID` (`entity_id`),
  KEY `IDX_CATALOG_PRODUCT_ENTITY_GROUP_PRICE_CUSTOMER_GROUP_ID` (`customer_group_id`),
  KEY `IDX_CATALOG_PRODUCT_ENTITY_GROUP_PRICE_WEBSITE_ID` (`website_id`),
  CONSTRAINT `FK_DF909D22C11B60B1E5E3EE64AB220ECE` FOREIGN KEY (`customer_group_id`) REFERENCES `customer_group` (`customer_group_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CAT_PRD_ENTT_GROUP_PRICE_ENTT_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CAT_PRD_ENTT_GROUP_PRICE_WS_ID_CORE_WS_WS_ID` FOREIGN KEY (`website_id`) REFERENCES `core_website` (`website_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Group Price Attribute Backend Table';



# Dump of table catalog_product_entity_int
# ------------------------------------------------------------

DROP TABLE IF EXISTS `catalog_product_entity_int`;

CREATE TABLE `catalog_product_entity_int` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value ID',
  `entity_type_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type ID',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity ID',
  `value` int(11) DEFAULT NULL COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_CATALOG_PRODUCT_ENTITY_INT_ENTITY_ID_ATTRIBUTE_ID_STORE_ID` (`entity_id`,`attribute_id`,`store_id`),
  KEY `IDX_CATALOG_PRODUCT_ENTITY_INT_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_CATALOG_PRODUCT_ENTITY_INT_STORE_ID` (`store_id`),
  KEY `IDX_CATALOG_PRODUCT_ENTITY_INT_ENTITY_ID` (`entity_id`),
  CONSTRAINT `FK_CAT_PRD_ENTT_INT_ATTR_ID_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CAT_PRD_ENTT_INT_ENTT_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CATALOG_PRODUCT_ENTITY_INT_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Integer Attribute Backend Table';



# Dump of table catalog_product_entity_media_gallery
# ------------------------------------------------------------

DROP TABLE IF EXISTS `catalog_product_entity_media_gallery`;

CREATE TABLE `catalog_product_entity_media_gallery` (
  `value_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Value ID',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute ID',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity ID',
  `value` varchar(255) DEFAULT NULL COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  KEY `IDX_CATALOG_PRODUCT_ENTITY_MEDIA_GALLERY_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_CATALOG_PRODUCT_ENTITY_MEDIA_GALLERY_ENTITY_ID` (`entity_id`),
  CONSTRAINT `FK_CAT_PRD_ENTT_MDA_GLR_ATTR_ID_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CAT_PRD_ENTT_MDA_GLR_ENTT_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Media Gallery Attribute Backend Table';



# Dump of table catalog_product_entity_media_gallery_value
# ------------------------------------------------------------

DROP TABLE IF EXISTS `catalog_product_entity_media_gallery_value`;

CREATE TABLE `catalog_product_entity_media_gallery_value` (
  `value_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Value ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `label` varchar(255) DEFAULT NULL COMMENT 'Label',
  `position` int(10) unsigned DEFAULT NULL COMMENT 'Position',
  `disabled` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Disabled',
  PRIMARY KEY (`value_id`,`store_id`),
  KEY `IDX_CATALOG_PRODUCT_ENTITY_MEDIA_GALLERY_VALUE_STORE_ID` (`store_id`),
  CONSTRAINT `FK_CAT_PRD_ENTT_MDA_GLR_VAL_VAL_ID_CAT_PRD_ENTT_MDA_GLR_VAL_ID` FOREIGN KEY (`value_id`) REFERENCES `catalog_product_entity_media_gallery` (`value_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CAT_PRD_ENTT_MDA_GLR_VAL_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Media Gallery Attribute Value Table';



# Dump of table catalog_product_entity_text
# ------------------------------------------------------------

DROP TABLE IF EXISTS `catalog_product_entity_text`;

CREATE TABLE `catalog_product_entity_text` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value ID',
  `entity_type_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type ID',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity ID',
  `value` text COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_CATALOG_PRODUCT_ENTITY_TEXT_ENTITY_ID_ATTRIBUTE_ID_STORE_ID` (`entity_id`,`attribute_id`,`store_id`),
  KEY `IDX_CATALOG_PRODUCT_ENTITY_TEXT_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_CATALOG_PRODUCT_ENTITY_TEXT_STORE_ID` (`store_id`),
  KEY `IDX_CATALOG_PRODUCT_ENTITY_TEXT_ENTITY_ID` (`entity_id`),
  CONSTRAINT `FK_CAT_PRD_ENTT_TEXT_ATTR_ID_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CAT_PRD_ENTT_TEXT_ENTT_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CATALOG_PRODUCT_ENTITY_TEXT_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Text Attribute Backend Table';



# Dump of table catalog_product_entity_tier_price
# ------------------------------------------------------------

DROP TABLE IF EXISTS `catalog_product_entity_tier_price`;

CREATE TABLE `catalog_product_entity_tier_price` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value ID',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity ID',
  `all_groups` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Is Applicable To All Customer Groups',
  `customer_group_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Customer Group ID',
  `qty` decimal(12,4) NOT NULL DEFAULT '1.0000' COMMENT 'QTY',
  `value` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Value',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `E8AB433B9ACB00343ABB312AD2FAB087` (`entity_id`,`all_groups`,`customer_group_id`,`qty`,`website_id`),
  KEY `IDX_CATALOG_PRODUCT_ENTITY_TIER_PRICE_ENTITY_ID` (`entity_id`),
  KEY `IDX_CATALOG_PRODUCT_ENTITY_TIER_PRICE_CUSTOMER_GROUP_ID` (`customer_group_id`),
  KEY `IDX_CATALOG_PRODUCT_ENTITY_TIER_PRICE_WEBSITE_ID` (`website_id`),
  CONSTRAINT `FK_6E08D719F0501DD1D8E6D4EFF2511C85` FOREIGN KEY (`customer_group_id`) REFERENCES `customer_group` (`customer_group_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CAT_PRD_ENTT_TIER_PRICE_ENTT_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CAT_PRD_ENTT_TIER_PRICE_WS_ID_CORE_WS_WS_ID` FOREIGN KEY (`website_id`) REFERENCES `core_website` (`website_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Tier Price Attribute Backend Table';



# Dump of table catalog_product_entity_varchar
# ------------------------------------------------------------

DROP TABLE IF EXISTS `catalog_product_entity_varchar`;

CREATE TABLE `catalog_product_entity_varchar` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value ID',
  `entity_type_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type ID',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity ID',
  `value` varchar(255) DEFAULT NULL COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_CAT_PRD_ENTT_VCHR_ENTT_ID_ATTR_ID_STORE_ID` (`entity_id`,`attribute_id`,`store_id`),
  KEY `IDX_CATALOG_PRODUCT_ENTITY_VARCHAR_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_CATALOG_PRODUCT_ENTITY_VARCHAR_STORE_ID` (`store_id`),
  KEY `IDX_CATALOG_PRODUCT_ENTITY_VARCHAR_ENTITY_ID` (`entity_id`),
  CONSTRAINT `FK_CAT_PRD_ENTT_VCHR_ATTR_ID_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CAT_PRD_ENTT_VCHR_ENTT_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CATALOG_PRODUCT_ENTITY_VARCHAR_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Varchar Attribute Backend Table';



# Dump of table catalog_product_index_eav
# ------------------------------------------------------------

DROP TABLE IF EXISTS `catalog_product_index_eav`;

CREATE TABLE `catalog_product_index_eav` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `attribute_id` smallint(5) unsigned NOT NULL COMMENT 'Attribute ID',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store ID',
  `value` int(10) unsigned NOT NULL COMMENT 'Value',
  PRIMARY KEY (`entity_id`,`attribute_id`,`store_id`,`value`),
  KEY `IDX_CATALOG_PRODUCT_INDEX_EAV_ENTITY_ID` (`entity_id`),
  KEY `IDX_CATALOG_PRODUCT_INDEX_EAV_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_CATALOG_PRODUCT_INDEX_EAV_STORE_ID` (`store_id`),
  KEY `IDX_CATALOG_PRODUCT_INDEX_EAV_VALUE` (`value`),
  CONSTRAINT `FK_CAT_PRD_IDX_EAV_ATTR_ID_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CAT_PRD_IDX_EAV_ENTT_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CATALOG_PRODUCT_INDEX_EAV_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product EAV Index Table';



# Dump of table catalog_product_index_eav_decimal
# ------------------------------------------------------------

DROP TABLE IF EXISTS `catalog_product_index_eav_decimal`;

CREATE TABLE `catalog_product_index_eav_decimal` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `attribute_id` smallint(5) unsigned NOT NULL COMMENT 'Attribute ID',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store ID',
  `value` decimal(12,4) NOT NULL COMMENT 'Value',
  PRIMARY KEY (`entity_id`,`attribute_id`,`store_id`),
  KEY `IDX_CATALOG_PRODUCT_INDEX_EAV_DECIMAL_ENTITY_ID` (`entity_id`),
  KEY `IDX_CATALOG_PRODUCT_INDEX_EAV_DECIMAL_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_CATALOG_PRODUCT_INDEX_EAV_DECIMAL_STORE_ID` (`store_id`),
  KEY `IDX_CATALOG_PRODUCT_INDEX_EAV_DECIMAL_VALUE` (`value`),
  CONSTRAINT `FK_CAT_PRD_IDX_EAV_DEC_ATTR_ID_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CAT_PRD_IDX_EAV_DEC_ENTT_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CAT_PRD_IDX_EAV_DEC_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product EAV Decimal Index Table';



# Dump of table catalog_product_index_eav_decimal_idx
# ------------------------------------------------------------

DROP TABLE IF EXISTS `catalog_product_index_eav_decimal_idx`;

CREATE TABLE `catalog_product_index_eav_decimal_idx` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `attribute_id` smallint(5) unsigned NOT NULL COMMENT 'Attribute ID',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store ID',
  `value` decimal(12,4) NOT NULL COMMENT 'Value',
  PRIMARY KEY (`entity_id`,`attribute_id`,`store_id`,`value`),
  KEY `IDX_CATALOG_PRODUCT_INDEX_EAV_DECIMAL_IDX_ENTITY_ID` (`entity_id`),
  KEY `IDX_CATALOG_PRODUCT_INDEX_EAV_DECIMAL_IDX_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_CATALOG_PRODUCT_INDEX_EAV_DECIMAL_IDX_STORE_ID` (`store_id`),
  KEY `IDX_CATALOG_PRODUCT_INDEX_EAV_DECIMAL_IDX_VALUE` (`value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product EAV Decimal Indexer Index Table';



# Dump of table catalog_product_index_eav_decimal_tmp
# ------------------------------------------------------------

DROP TABLE IF EXISTS `catalog_product_index_eav_decimal_tmp`;

CREATE TABLE `catalog_product_index_eav_decimal_tmp` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `attribute_id` smallint(5) unsigned NOT NULL COMMENT 'Attribute ID',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store ID',
  `value` decimal(12,4) NOT NULL COMMENT 'Value',
  PRIMARY KEY (`entity_id`,`attribute_id`,`store_id`),
  KEY `IDX_CATALOG_PRODUCT_INDEX_EAV_DECIMAL_TMP_ENTITY_ID` (`entity_id`),
  KEY `IDX_CATALOG_PRODUCT_INDEX_EAV_DECIMAL_TMP_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_CATALOG_PRODUCT_INDEX_EAV_DECIMAL_TMP_STORE_ID` (`store_id`),
  KEY `IDX_CATALOG_PRODUCT_INDEX_EAV_DECIMAL_TMP_VALUE` (`value`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8 COMMENT='Catalog Product EAV Decimal Indexer Temp Table';



# Dump of table catalog_product_index_eav_idx
# ------------------------------------------------------------

DROP TABLE IF EXISTS `catalog_product_index_eav_idx`;

CREATE TABLE `catalog_product_index_eav_idx` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `attribute_id` smallint(5) unsigned NOT NULL COMMENT 'Attribute ID',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store ID',
  `value` int(10) unsigned NOT NULL COMMENT 'Value',
  PRIMARY KEY (`entity_id`,`attribute_id`,`store_id`,`value`),
  KEY `IDX_CATALOG_PRODUCT_INDEX_EAV_IDX_ENTITY_ID` (`entity_id`),
  KEY `IDX_CATALOG_PRODUCT_INDEX_EAV_IDX_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_CATALOG_PRODUCT_INDEX_EAV_IDX_STORE_ID` (`store_id`),
  KEY `IDX_CATALOG_PRODUCT_INDEX_EAV_IDX_VALUE` (`value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product EAV Indexer Index Table';



# Dump of table catalog_product_index_eav_tmp
# ------------------------------------------------------------

DROP TABLE IF EXISTS `catalog_product_index_eav_tmp`;

CREATE TABLE `catalog_product_index_eav_tmp` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `attribute_id` smallint(5) unsigned NOT NULL COMMENT 'Attribute ID',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store ID',
  `value` int(10) unsigned NOT NULL COMMENT 'Value',
  PRIMARY KEY (`entity_id`,`attribute_id`,`store_id`,`value`),
  KEY `IDX_CATALOG_PRODUCT_INDEX_EAV_TMP_ENTITY_ID` (`entity_id`),
  KEY `IDX_CATALOG_PRODUCT_INDEX_EAV_TMP_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_CATALOG_PRODUCT_INDEX_EAV_TMP_STORE_ID` (`store_id`),
  KEY `IDX_CATALOG_PRODUCT_INDEX_EAV_TMP_VALUE` (`value`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8 COMMENT='Catalog Product EAV Indexer Temp Table';



# Dump of table catalog_product_index_group_price
# ------------------------------------------------------------

DROP TABLE IF EXISTS `catalog_product_index_group_price`;

CREATE TABLE `catalog_product_index_group_price` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group ID',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  `price` decimal(12,4) DEFAULT NULL COMMENT 'Min Price',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`),
  KEY `IDX_CATALOG_PRODUCT_INDEX_GROUP_PRICE_CUSTOMER_GROUP_ID` (`customer_group_id`),
  KEY `IDX_CATALOG_PRODUCT_INDEX_GROUP_PRICE_WEBSITE_ID` (`website_id`),
  CONSTRAINT `FK_195DF97C81B0BDD6A2EEC50F870E16D1` FOREIGN KEY (`customer_group_id`) REFERENCES `customer_group` (`customer_group_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CAT_PRD_IDX_GROUP_PRICE_ENTT_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CAT_PRD_IDX_GROUP_PRICE_WS_ID_CORE_WS_WS_ID` FOREIGN KEY (`website_id`) REFERENCES `core_website` (`website_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Group Price Index Table';



# Dump of table catalog_product_index_price
# ------------------------------------------------------------

DROP TABLE IF EXISTS `catalog_product_index_price`;

CREATE TABLE `catalog_product_index_price` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group ID',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  `tax_class_id` smallint(5) unsigned DEFAULT '0' COMMENT 'Tax Class ID',
  `price` decimal(12,4) DEFAULT NULL COMMENT 'Price',
  `final_price` decimal(12,4) DEFAULT NULL COMMENT 'Final Price',
  `min_price` decimal(12,4) DEFAULT NULL COMMENT 'Min Price',
  `max_price` decimal(12,4) DEFAULT NULL COMMENT 'Max Price',
  `tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Tier Price',
  `group_price` decimal(12,4) DEFAULT NULL COMMENT 'Group price',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`),
  KEY `IDX_CATALOG_PRODUCT_INDEX_PRICE_CUSTOMER_GROUP_ID` (`customer_group_id`),
  KEY `IDX_CATALOG_PRODUCT_INDEX_PRICE_WEBSITE_ID` (`website_id`),
  KEY `IDX_CATALOG_PRODUCT_INDEX_PRICE_MIN_PRICE` (`min_price`),
  KEY `IDX_CAT_PRD_IDX_PRICE_WS_ID_CSTR_GROUP_ID_MIN_PRICE` (`website_id`,`customer_group_id`,`min_price`),
  CONSTRAINT `FK_CAT_PRD_IDX_PRICE_CSTR_GROUP_ID_CSTR_GROUP_CSTR_GROUP_ID` FOREIGN KEY (`customer_group_id`) REFERENCES `customer_group` (`customer_group_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CAT_PRD_IDX_PRICE_ENTT_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CAT_PRD_IDX_PRICE_WS_ID_CORE_WS_WS_ID` FOREIGN KEY (`website_id`) REFERENCES `core_website` (`website_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Price Index Table';



# Dump of table catalog_product_index_price_bundle_idx
# ------------------------------------------------------------

DROP TABLE IF EXISTS `catalog_product_index_price_bundle_idx`;

CREATE TABLE `catalog_product_index_price_bundle_idx` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity Id',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group Id',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website Id',
  `tax_class_id` smallint(5) unsigned DEFAULT '0' COMMENT 'Tax Class Id',
  `price_type` smallint(5) unsigned NOT NULL COMMENT 'Price Type',
  `special_price` decimal(12,4) DEFAULT NULL COMMENT 'Special Price',
  `tier_percent` decimal(12,4) DEFAULT NULL COMMENT 'Tier Percent',
  `orig_price` decimal(12,4) DEFAULT NULL COMMENT 'Orig Price',
  `price` decimal(12,4) DEFAULT NULL COMMENT 'Price',
  `min_price` decimal(12,4) DEFAULT NULL COMMENT 'Min Price',
  `max_price` decimal(12,4) DEFAULT NULL COMMENT 'Max Price',
  `tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Tier Price',
  `base_tier` decimal(12,4) DEFAULT NULL COMMENT 'Base Tier',
  `group_price` decimal(12,4) DEFAULT NULL COMMENT 'Group price',
  `base_group_price` decimal(12,4) DEFAULT NULL COMMENT 'Base Group Price',
  `group_price_percent` decimal(12,4) DEFAULT NULL COMMENT 'Group Price Percent',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Index Price Bundle Idx';



# Dump of table catalog_product_index_price_bundle_opt_idx
# ------------------------------------------------------------

DROP TABLE IF EXISTS `catalog_product_index_price_bundle_opt_idx`;

CREATE TABLE `catalog_product_index_price_bundle_opt_idx` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity Id',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group Id',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website Id',
  `option_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Option Id',
  `min_price` decimal(12,4) DEFAULT NULL COMMENT 'Min Price',
  `alt_price` decimal(12,4) DEFAULT NULL COMMENT 'Alt Price',
  `max_price` decimal(12,4) DEFAULT NULL COMMENT 'Max Price',
  `tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Tier Price',
  `alt_tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Alt Tier Price',
  `group_price` decimal(12,4) DEFAULT NULL COMMENT 'Group price',
  `alt_group_price` decimal(12,4) DEFAULT NULL COMMENT 'Alt Group Price',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`,`option_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Index Price Bundle Opt Idx';



# Dump of table catalog_product_index_price_bundle_opt_tmp
# ------------------------------------------------------------

DROP TABLE IF EXISTS `catalog_product_index_price_bundle_opt_tmp`;

CREATE TABLE `catalog_product_index_price_bundle_opt_tmp` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity Id',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group Id',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website Id',
  `option_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Option Id',
  `min_price` decimal(12,4) DEFAULT NULL COMMENT 'Min Price',
  `alt_price` decimal(12,4) DEFAULT NULL COMMENT 'Alt Price',
  `max_price` decimal(12,4) DEFAULT NULL COMMENT 'Max Price',
  `tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Tier Price',
  `alt_tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Alt Tier Price',
  `group_price` decimal(12,4) DEFAULT NULL COMMENT 'Group price',
  `alt_group_price` decimal(12,4) DEFAULT NULL COMMENT 'Alt Group Price',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`,`option_id`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8 COMMENT='Catalog Product Index Price Bundle Opt Tmp';



# Dump of table catalog_product_index_price_bundle_sel_idx
# ------------------------------------------------------------

DROP TABLE IF EXISTS `catalog_product_index_price_bundle_sel_idx`;

CREATE TABLE `catalog_product_index_price_bundle_sel_idx` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity Id',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group Id',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website Id',
  `option_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Option Id',
  `selection_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Selection Id',
  `group_type` smallint(5) unsigned DEFAULT '0' COMMENT 'Group Type',
  `is_required` smallint(5) unsigned DEFAULT '0' COMMENT 'Is Required',
  `price` decimal(12,4) DEFAULT NULL COMMENT 'Price',
  `tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Tier Price',
  `group_price` decimal(12,4) DEFAULT NULL COMMENT 'Group price',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`,`option_id`,`selection_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Index Price Bundle Sel Idx';



# Dump of table catalog_product_index_price_bundle_sel_tmp
# ------------------------------------------------------------

DROP TABLE IF EXISTS `catalog_product_index_price_bundle_sel_tmp`;

CREATE TABLE `catalog_product_index_price_bundle_sel_tmp` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity Id',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group Id',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website Id',
  `option_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Option Id',
  `selection_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Selection Id',
  `group_type` smallint(5) unsigned DEFAULT '0' COMMENT 'Group Type',
  `is_required` smallint(5) unsigned DEFAULT '0' COMMENT 'Is Required',
  `price` decimal(12,4) DEFAULT NULL COMMENT 'Price',
  `tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Tier Price',
  `group_price` decimal(12,4) DEFAULT NULL COMMENT 'Group price',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`,`option_id`,`selection_id`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8 COMMENT='Catalog Product Index Price Bundle Sel Tmp';



# Dump of table catalog_product_index_price_bundle_tmp
# ------------------------------------------------------------

DROP TABLE IF EXISTS `catalog_product_index_price_bundle_tmp`;

CREATE TABLE `catalog_product_index_price_bundle_tmp` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity Id',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group Id',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website Id',
  `tax_class_id` smallint(5) unsigned DEFAULT '0' COMMENT 'Tax Class Id',
  `price_type` smallint(5) unsigned NOT NULL COMMENT 'Price Type',
  `special_price` decimal(12,4) DEFAULT NULL COMMENT 'Special Price',
  `tier_percent` decimal(12,4) DEFAULT NULL COMMENT 'Tier Percent',
  `orig_price` decimal(12,4) DEFAULT NULL COMMENT 'Orig Price',
  `price` decimal(12,4) DEFAULT NULL COMMENT 'Price',
  `min_price` decimal(12,4) DEFAULT NULL COMMENT 'Min Price',
  `max_price` decimal(12,4) DEFAULT NULL COMMENT 'Max Price',
  `tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Tier Price',
  `base_tier` decimal(12,4) DEFAULT NULL COMMENT 'Base Tier',
  `group_price` decimal(12,4) DEFAULT NULL COMMENT 'Group price',
  `base_group_price` decimal(12,4) DEFAULT NULL COMMENT 'Base Group Price',
  `group_price_percent` decimal(12,4) DEFAULT NULL COMMENT 'Group Price Percent',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8 COMMENT='Catalog Product Index Price Bundle Tmp';



# Dump of table catalog_product_index_price_cfg_opt_agr_idx
# ------------------------------------------------------------

DROP TABLE IF EXISTS `catalog_product_index_price_cfg_opt_agr_idx`;

CREATE TABLE `catalog_product_index_price_cfg_opt_agr_idx` (
  `parent_id` int(10) unsigned NOT NULL COMMENT 'Parent ID',
  `child_id` int(10) unsigned NOT NULL COMMENT 'Child ID',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group ID',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  `price` decimal(12,4) DEFAULT NULL COMMENT 'Price',
  `tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Tier Price',
  `group_price` decimal(12,4) DEFAULT NULL COMMENT 'Group price',
  PRIMARY KEY (`parent_id`,`child_id`,`customer_group_id`,`website_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Price Indexer Config Option Aggregate Index Table';



# Dump of table catalog_product_index_price_cfg_opt_agr_tmp
# ------------------------------------------------------------

DROP TABLE IF EXISTS `catalog_product_index_price_cfg_opt_agr_tmp`;

CREATE TABLE `catalog_product_index_price_cfg_opt_agr_tmp` (
  `parent_id` int(10) unsigned NOT NULL COMMENT 'Parent ID',
  `child_id` int(10) unsigned NOT NULL COMMENT 'Child ID',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group ID',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  `price` decimal(12,4) DEFAULT NULL COMMENT 'Price',
  `tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Tier Price',
  `group_price` decimal(12,4) DEFAULT NULL COMMENT 'Group price',
  PRIMARY KEY (`parent_id`,`child_id`,`customer_group_id`,`website_id`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8 COMMENT='Catalog Product Price Indexer Config Option Aggregate Temp Table';



# Dump of table catalog_product_index_price_cfg_opt_idx
# ------------------------------------------------------------

DROP TABLE IF EXISTS `catalog_product_index_price_cfg_opt_idx`;

CREATE TABLE `catalog_product_index_price_cfg_opt_idx` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group ID',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  `min_price` decimal(12,4) DEFAULT NULL COMMENT 'Min Price',
  `max_price` decimal(12,4) DEFAULT NULL COMMENT 'Max Price',
  `tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Tier Price',
  `group_price` decimal(12,4) DEFAULT NULL COMMENT 'Group price',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Price Indexer Config Option Index Table';



# Dump of table catalog_product_index_price_cfg_opt_tmp
# ------------------------------------------------------------

DROP TABLE IF EXISTS `catalog_product_index_price_cfg_opt_tmp`;

CREATE TABLE `catalog_product_index_price_cfg_opt_tmp` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group ID',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  `min_price` decimal(12,4) DEFAULT NULL COMMENT 'Min Price',
  `max_price` decimal(12,4) DEFAULT NULL COMMENT 'Max Price',
  `tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Tier Price',
  `group_price` decimal(12,4) DEFAULT NULL COMMENT 'Group price',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8 COMMENT='Catalog Product Price Indexer Config Option Temp Table';



# Dump of table catalog_product_index_price_downlod_idx
# ------------------------------------------------------------

DROP TABLE IF EXISTS `catalog_product_index_price_downlod_idx`;

CREATE TABLE `catalog_product_index_price_downlod_idx` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group ID',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  `min_price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Minimum price',
  `max_price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Maximum price',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Indexer Table for price of downloadable products';



# Dump of table catalog_product_index_price_downlod_tmp
# ------------------------------------------------------------

DROP TABLE IF EXISTS `catalog_product_index_price_downlod_tmp`;

CREATE TABLE `catalog_product_index_price_downlod_tmp` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group ID',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  `min_price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Minimum price',
  `max_price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Maximum price',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8 COMMENT='Temporary Indexer Table for price of downloadable products';



# Dump of table catalog_product_index_price_final_idx
# ------------------------------------------------------------

DROP TABLE IF EXISTS `catalog_product_index_price_final_idx`;

CREATE TABLE `catalog_product_index_price_final_idx` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group ID',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  `tax_class_id` smallint(5) unsigned DEFAULT '0' COMMENT 'Tax Class ID',
  `orig_price` decimal(12,4) DEFAULT NULL COMMENT 'Original Price',
  `price` decimal(12,4) DEFAULT NULL COMMENT 'Price',
  `min_price` decimal(12,4) DEFAULT NULL COMMENT 'Min Price',
  `max_price` decimal(12,4) DEFAULT NULL COMMENT 'Max Price',
  `tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Tier Price',
  `base_tier` decimal(12,4) DEFAULT NULL COMMENT 'Base Tier',
  `group_price` decimal(12,4) DEFAULT NULL COMMENT 'Group price',
  `base_group_price` decimal(12,4) DEFAULT NULL COMMENT 'Base Group Price',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Price Indexer Final Index Table';



# Dump of table catalog_product_index_price_final_tmp
# ------------------------------------------------------------

DROP TABLE IF EXISTS `catalog_product_index_price_final_tmp`;

CREATE TABLE `catalog_product_index_price_final_tmp` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group ID',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  `tax_class_id` smallint(5) unsigned DEFAULT '0' COMMENT 'Tax Class ID',
  `orig_price` decimal(12,4) DEFAULT NULL COMMENT 'Original Price',
  `price` decimal(12,4) DEFAULT NULL COMMENT 'Price',
  `min_price` decimal(12,4) DEFAULT NULL COMMENT 'Min Price',
  `max_price` decimal(12,4) DEFAULT NULL COMMENT 'Max Price',
  `tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Tier Price',
  `base_tier` decimal(12,4) DEFAULT NULL COMMENT 'Base Tier',
  `group_price` decimal(12,4) DEFAULT NULL COMMENT 'Group price',
  `base_group_price` decimal(12,4) DEFAULT NULL COMMENT 'Base Group Price',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8 COMMENT='Catalog Product Price Indexer Final Temp Table';



# Dump of table catalog_product_index_price_idx
# ------------------------------------------------------------

DROP TABLE IF EXISTS `catalog_product_index_price_idx`;

CREATE TABLE `catalog_product_index_price_idx` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group ID',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  `tax_class_id` smallint(5) unsigned DEFAULT '0' COMMENT 'Tax Class ID',
  `price` decimal(12,4) DEFAULT NULL COMMENT 'Price',
  `final_price` decimal(12,4) DEFAULT NULL COMMENT 'Final Price',
  `min_price` decimal(12,4) DEFAULT NULL COMMENT 'Min Price',
  `max_price` decimal(12,4) DEFAULT NULL COMMENT 'Max Price',
  `tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Tier Price',
  `group_price` decimal(12,4) DEFAULT NULL COMMENT 'Group price',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`),
  KEY `IDX_CATALOG_PRODUCT_INDEX_PRICE_IDX_CUSTOMER_GROUP_ID` (`customer_group_id`),
  KEY `IDX_CATALOG_PRODUCT_INDEX_PRICE_IDX_WEBSITE_ID` (`website_id`),
  KEY `IDX_CATALOG_PRODUCT_INDEX_PRICE_IDX_MIN_PRICE` (`min_price`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Price Indexer Index Table';



# Dump of table catalog_product_index_price_opt_agr_idx
# ------------------------------------------------------------

DROP TABLE IF EXISTS `catalog_product_index_price_opt_agr_idx`;

CREATE TABLE `catalog_product_index_price_opt_agr_idx` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group ID',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  `option_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Option ID',
  `min_price` decimal(12,4) DEFAULT NULL COMMENT 'Min Price',
  `max_price` decimal(12,4) DEFAULT NULL COMMENT 'Max Price',
  `tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Tier Price',
  `group_price` decimal(12,4) DEFAULT NULL COMMENT 'Group price',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`,`option_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Price Indexer Option Aggregate Index Table';



# Dump of table catalog_product_index_price_opt_agr_tmp
# ------------------------------------------------------------

DROP TABLE IF EXISTS `catalog_product_index_price_opt_agr_tmp`;

CREATE TABLE `catalog_product_index_price_opt_agr_tmp` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group ID',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  `option_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Option ID',
  `min_price` decimal(12,4) DEFAULT NULL COMMENT 'Min Price',
  `max_price` decimal(12,4) DEFAULT NULL COMMENT 'Max Price',
  `tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Tier Price',
  `group_price` decimal(12,4) DEFAULT NULL COMMENT 'Group price',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`,`option_id`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8 COMMENT='Catalog Product Price Indexer Option Aggregate Temp Table';



# Dump of table catalog_product_index_price_opt_idx
# ------------------------------------------------------------

DROP TABLE IF EXISTS `catalog_product_index_price_opt_idx`;

CREATE TABLE `catalog_product_index_price_opt_idx` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group ID',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  `min_price` decimal(12,4) DEFAULT NULL COMMENT 'Min Price',
  `max_price` decimal(12,4) DEFAULT NULL COMMENT 'Max Price',
  `tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Tier Price',
  `group_price` decimal(12,4) DEFAULT NULL COMMENT 'Group price',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Price Indexer Option Index Table';



# Dump of table catalog_product_index_price_opt_tmp
# ------------------------------------------------------------

DROP TABLE IF EXISTS `catalog_product_index_price_opt_tmp`;

CREATE TABLE `catalog_product_index_price_opt_tmp` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group ID',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  `min_price` decimal(12,4) DEFAULT NULL COMMENT 'Min Price',
  `max_price` decimal(12,4) DEFAULT NULL COMMENT 'Max Price',
  `tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Tier Price',
  `group_price` decimal(12,4) DEFAULT NULL COMMENT 'Group price',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8 COMMENT='Catalog Product Price Indexer Option Temp Table';



# Dump of table catalog_product_index_price_tmp
# ------------------------------------------------------------

DROP TABLE IF EXISTS `catalog_product_index_price_tmp`;

CREATE TABLE `catalog_product_index_price_tmp` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group ID',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  `tax_class_id` smallint(5) unsigned DEFAULT '0' COMMENT 'Tax Class ID',
  `price` decimal(12,4) DEFAULT NULL COMMENT 'Price',
  `final_price` decimal(12,4) DEFAULT NULL COMMENT 'Final Price',
  `min_price` decimal(12,4) DEFAULT NULL COMMENT 'Min Price',
  `max_price` decimal(12,4) DEFAULT NULL COMMENT 'Max Price',
  `tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Tier Price',
  `group_price` decimal(12,4) DEFAULT NULL COMMENT 'Group price',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`),
  KEY `IDX_CATALOG_PRODUCT_INDEX_PRICE_TMP_CUSTOMER_GROUP_ID` (`customer_group_id`),
  KEY `IDX_CATALOG_PRODUCT_INDEX_PRICE_TMP_WEBSITE_ID` (`website_id`),
  KEY `IDX_CATALOG_PRODUCT_INDEX_PRICE_TMP_MIN_PRICE` (`min_price`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8 COMMENT='Catalog Product Price Indexer Temp Table';



# Dump of table catalog_product_index_tier_price
# ------------------------------------------------------------

DROP TABLE IF EXISTS `catalog_product_index_tier_price`;

CREATE TABLE `catalog_product_index_tier_price` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group ID',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  `min_price` decimal(12,4) DEFAULT NULL COMMENT 'Min Price',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`),
  KEY `IDX_CATALOG_PRODUCT_INDEX_TIER_PRICE_CUSTOMER_GROUP_ID` (`customer_group_id`),
  KEY `IDX_CATALOG_PRODUCT_INDEX_TIER_PRICE_WEBSITE_ID` (`website_id`),
  CONSTRAINT `FK_CAT_PRD_IDX_TIER_PRICE_CSTR_GROUP_ID_CSTR_GROUP_CSTR_GROUP_ID` FOREIGN KEY (`customer_group_id`) REFERENCES `customer_group` (`customer_group_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CAT_PRD_IDX_TIER_PRICE_ENTT_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CAT_PRD_IDX_TIER_PRICE_WS_ID_CORE_WS_WS_ID` FOREIGN KEY (`website_id`) REFERENCES `core_website` (`website_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Tier Price Index Table';



# Dump of table catalog_product_index_website
# ------------------------------------------------------------

DROP TABLE IF EXISTS `catalog_product_index_website`;

CREATE TABLE `catalog_product_index_website` (
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  `website_date` date DEFAULT NULL COMMENT 'Website Date',
  `rate` float DEFAULT '1' COMMENT 'Rate',
  PRIMARY KEY (`website_id`),
  KEY `IDX_CATALOG_PRODUCT_INDEX_WEBSITE_WEBSITE_DATE` (`website_date`),
  CONSTRAINT `FK_CAT_PRD_IDX_WS_WS_ID_CORE_WS_WS_ID` FOREIGN KEY (`website_id`) REFERENCES `core_website` (`website_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Website Index Table';



# Dump of table catalog_product_link
# ------------------------------------------------------------

DROP TABLE IF EXISTS `catalog_product_link`;

CREATE TABLE `catalog_product_link` (
  `link_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Link ID',
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product ID',
  `linked_product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Linked Product ID',
  `link_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Link Type ID',
  PRIMARY KEY (`link_id`),
  UNIQUE KEY `UNQ_CAT_PRD_LNK_LNK_TYPE_ID_PRD_ID_LNKED_PRD_ID` (`link_type_id`,`product_id`,`linked_product_id`),
  KEY `IDX_CATALOG_PRODUCT_LINK_PRODUCT_ID` (`product_id`),
  KEY `IDX_CATALOG_PRODUCT_LINK_LINKED_PRODUCT_ID` (`linked_product_id`),
  KEY `IDX_CATALOG_PRODUCT_LINK_LINK_TYPE_ID` (`link_type_id`),
  CONSTRAINT `FK_CAT_PRD_LNK_LNKED_PRD_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`linked_product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CAT_PRD_LNK_PRD_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CAT_PRD_LNK_LNK_TYPE_ID_CAT_PRD_LNK_TYPE_LNK_TYPE_ID` FOREIGN KEY (`link_type_id`) REFERENCES `catalog_product_link_type` (`link_type_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product To Product Linkage Table';



# Dump of table catalog_product_link_attribute
# ------------------------------------------------------------

DROP TABLE IF EXISTS `catalog_product_link_attribute`;

CREATE TABLE `catalog_product_link_attribute` (
  `product_link_attribute_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Product Link Attribute ID',
  `link_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Link Type ID',
  `product_link_attribute_code` varchar(32) DEFAULT NULL COMMENT 'Product Link Attribute Code',
  `data_type` varchar(32) DEFAULT NULL COMMENT 'Data Type',
  PRIMARY KEY (`product_link_attribute_id`),
  KEY `IDX_CATALOG_PRODUCT_LINK_ATTRIBUTE_LINK_TYPE_ID` (`link_type_id`),
  CONSTRAINT `FK_CAT_PRD_LNK_ATTR_LNK_TYPE_ID_CAT_PRD_LNK_TYPE_LNK_TYPE_ID` FOREIGN KEY (`link_type_id`) REFERENCES `catalog_product_link_type` (`link_type_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Link Attribute Table';

LOCK TABLES `catalog_product_link_attribute` WRITE;
/*!40000 ALTER TABLE `catalog_product_link_attribute` DISABLE KEYS */;

INSERT INTO `catalog_product_link_attribute` (`product_link_attribute_id`, `link_type_id`, `product_link_attribute_code`, `data_type`)
VALUES
	(1,1,'position','int'),
	(2,3,'position','int'),
	(3,3,'qty','decimal'),
	(4,4,'position','int'),
	(5,5,'position','int');

/*!40000 ALTER TABLE `catalog_product_link_attribute` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table catalog_product_link_attribute_decimal
# ------------------------------------------------------------

DROP TABLE IF EXISTS `catalog_product_link_attribute_decimal`;

CREATE TABLE `catalog_product_link_attribute_decimal` (
  `value_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Value ID',
  `product_link_attribute_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Product Link Attribute ID',
  `link_id` int(10) unsigned NOT NULL COMMENT 'Link ID',
  `value` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_CAT_PRD_LNK_ATTR_DEC_PRD_LNK_ATTR_ID_LNK_ID` (`product_link_attribute_id`,`link_id`),
  KEY `IDX_CAT_PRD_LNK_ATTR_DEC_PRD_LNK_ATTR_ID` (`product_link_attribute_id`),
  KEY `IDX_CATALOG_PRODUCT_LINK_ATTRIBUTE_DECIMAL_LINK_ID` (`link_id`),
  CONSTRAINT `FK_CAT_PRD_LNK_ATTR_DEC_LNK_ID_CAT_PRD_LNK_LNK_ID` FOREIGN KEY (`link_id`) REFERENCES `catalog_product_link` (`link_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_AB2EFA9A14F7BCF1D5400056203D14B6` FOREIGN KEY (`product_link_attribute_id`) REFERENCES `catalog_product_link_attribute` (`product_link_attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Link Decimal Attribute Table';



# Dump of table catalog_product_link_attribute_int
# ------------------------------------------------------------

DROP TABLE IF EXISTS `catalog_product_link_attribute_int`;

CREATE TABLE `catalog_product_link_attribute_int` (
  `value_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Value ID',
  `product_link_attribute_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Product Link Attribute ID',
  `link_id` int(10) unsigned NOT NULL COMMENT 'Link ID',
  `value` int(11) NOT NULL DEFAULT '0' COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_CAT_PRD_LNK_ATTR_INT_PRD_LNK_ATTR_ID_LNK_ID` (`product_link_attribute_id`,`link_id`),
  KEY `IDX_CATALOG_PRODUCT_LINK_ATTRIBUTE_INT_PRODUCT_LINK_ATTRIBUTE_ID` (`product_link_attribute_id`),
  KEY `IDX_CATALOG_PRODUCT_LINK_ATTRIBUTE_INT_LINK_ID` (`link_id`),
  CONSTRAINT `FK_CAT_PRD_LNK_ATTR_INT_LNK_ID_CAT_PRD_LNK_LNK_ID` FOREIGN KEY (`link_id`) REFERENCES `catalog_product_link` (`link_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_D6D878F8BA2A4282F8DDED7E6E3DE35C` FOREIGN KEY (`product_link_attribute_id`) REFERENCES `catalog_product_link_attribute` (`product_link_attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Link Integer Attribute Table';



# Dump of table catalog_product_link_attribute_varchar
# ------------------------------------------------------------

DROP TABLE IF EXISTS `catalog_product_link_attribute_varchar`;

CREATE TABLE `catalog_product_link_attribute_varchar` (
  `value_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Value ID',
  `product_link_attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Product Link Attribute ID',
  `link_id` int(10) unsigned NOT NULL COMMENT 'Link ID',
  `value` varchar(255) DEFAULT NULL COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_CAT_PRD_LNK_ATTR_VCHR_PRD_LNK_ATTR_ID_LNK_ID` (`product_link_attribute_id`,`link_id`),
  KEY `IDX_CAT_PRD_LNK_ATTR_VCHR_PRD_LNK_ATTR_ID` (`product_link_attribute_id`),
  KEY `IDX_CATALOG_PRODUCT_LINK_ATTRIBUTE_VARCHAR_LINK_ID` (`link_id`),
  CONSTRAINT `FK_CAT_PRD_LNK_ATTR_VCHR_LNK_ID_CAT_PRD_LNK_LNK_ID` FOREIGN KEY (`link_id`) REFERENCES `catalog_product_link` (`link_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_DEE9C4DA61CFCC01DFCF50F0D79CEA51` FOREIGN KEY (`product_link_attribute_id`) REFERENCES `catalog_product_link_attribute` (`product_link_attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Link Varchar Attribute Table';



# Dump of table catalog_product_link_type
# ------------------------------------------------------------

DROP TABLE IF EXISTS `catalog_product_link_type`;

CREATE TABLE `catalog_product_link_type` (
  `link_type_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Link Type ID',
  `code` varchar(32) DEFAULT NULL COMMENT 'Code',
  PRIMARY KEY (`link_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Link Type Table';

LOCK TABLES `catalog_product_link_type` WRITE;
/*!40000 ALTER TABLE `catalog_product_link_type` DISABLE KEYS */;

INSERT INTO `catalog_product_link_type` (`link_type_id`, `code`)
VALUES
	(1,'relation'),
	(3,'super'),
	(4,'up_sell'),
	(5,'cross_sell');

/*!40000 ALTER TABLE `catalog_product_link_type` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table catalog_product_option
# ------------------------------------------------------------

DROP TABLE IF EXISTS `catalog_product_option`;

CREATE TABLE `catalog_product_option` (
  `option_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Option ID',
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product ID',
  `type` varchar(50) DEFAULT NULL COMMENT 'Type',
  `is_require` smallint(6) NOT NULL DEFAULT '1' COMMENT 'Is Required',
  `sku` varchar(64) DEFAULT NULL COMMENT 'SKU',
  `max_characters` int(10) unsigned DEFAULT NULL COMMENT 'Max Characters',
  `file_extension` varchar(50) DEFAULT NULL COMMENT 'File Extension',
  `image_size_x` smallint(5) unsigned DEFAULT NULL COMMENT 'Image Size X',
  `image_size_y` smallint(5) unsigned DEFAULT NULL COMMENT 'Image Size Y',
  `sort_order` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Sort Order',
  PRIMARY KEY (`option_id`),
  KEY `IDX_CATALOG_PRODUCT_OPTION_PRODUCT_ID` (`product_id`),
  CONSTRAINT `FK_CAT_PRD_OPT_PRD_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Option Table';



# Dump of table catalog_product_option_price
# ------------------------------------------------------------

DROP TABLE IF EXISTS `catalog_product_option_price`;

CREATE TABLE `catalog_product_option_price` (
  `option_price_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Option Price ID',
  `option_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Option ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Price',
  `price_type` varchar(7) NOT NULL DEFAULT 'fixed' COMMENT 'Price Type',
  PRIMARY KEY (`option_price_id`),
  UNIQUE KEY `UNQ_CATALOG_PRODUCT_OPTION_PRICE_OPTION_ID_STORE_ID` (`option_id`,`store_id`),
  KEY `IDX_CATALOG_PRODUCT_OPTION_PRICE_OPTION_ID` (`option_id`),
  KEY `IDX_CATALOG_PRODUCT_OPTION_PRICE_STORE_ID` (`store_id`),
  CONSTRAINT `FK_CAT_PRD_OPT_PRICE_OPT_ID_CAT_PRD_OPT_OPT_ID` FOREIGN KEY (`option_id`) REFERENCES `catalog_product_option` (`option_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CATALOG_PRODUCT_OPTION_PRICE_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Option Price Table';



# Dump of table catalog_product_option_title
# ------------------------------------------------------------

DROP TABLE IF EXISTS `catalog_product_option_title`;

CREATE TABLE `catalog_product_option_title` (
  `option_title_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Option Title ID',
  `option_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Option ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `title` varchar(255) DEFAULT NULL COMMENT 'Title',
  PRIMARY KEY (`option_title_id`),
  UNIQUE KEY `UNQ_CATALOG_PRODUCT_OPTION_TITLE_OPTION_ID_STORE_ID` (`option_id`,`store_id`),
  KEY `IDX_CATALOG_PRODUCT_OPTION_TITLE_OPTION_ID` (`option_id`),
  KEY `IDX_CATALOG_PRODUCT_OPTION_TITLE_STORE_ID` (`store_id`),
  CONSTRAINT `FK_CAT_PRD_OPT_TTL_OPT_ID_CAT_PRD_OPT_OPT_ID` FOREIGN KEY (`option_id`) REFERENCES `catalog_product_option` (`option_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CATALOG_PRODUCT_OPTION_TITLE_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Option Title Table';



# Dump of table catalog_product_option_type_price
# ------------------------------------------------------------

DROP TABLE IF EXISTS `catalog_product_option_type_price`;

CREATE TABLE `catalog_product_option_type_price` (
  `option_type_price_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Option Type Price ID',
  `option_type_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Option Type ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Price',
  `price_type` varchar(7) NOT NULL DEFAULT 'fixed' COMMENT 'Price Type',
  PRIMARY KEY (`option_type_price_id`),
  UNIQUE KEY `UNQ_CATALOG_PRODUCT_OPTION_TYPE_PRICE_OPTION_TYPE_ID_STORE_ID` (`option_type_id`,`store_id`),
  KEY `IDX_CATALOG_PRODUCT_OPTION_TYPE_PRICE_OPTION_TYPE_ID` (`option_type_id`),
  KEY `IDX_CATALOG_PRODUCT_OPTION_TYPE_PRICE_STORE_ID` (`store_id`),
  CONSTRAINT `FK_B523E3378E8602F376CC415825576B7F` FOREIGN KEY (`option_type_id`) REFERENCES `catalog_product_option_type_value` (`option_type_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CAT_PRD_OPT_TYPE_PRICE_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Option Type Price Table';



# Dump of table catalog_product_option_type_title
# ------------------------------------------------------------

DROP TABLE IF EXISTS `catalog_product_option_type_title`;

CREATE TABLE `catalog_product_option_type_title` (
  `option_type_title_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Option Type Title ID',
  `option_type_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Option Type ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `title` varchar(255) DEFAULT NULL COMMENT 'Title',
  PRIMARY KEY (`option_type_title_id`),
  UNIQUE KEY `UNQ_CATALOG_PRODUCT_OPTION_TYPE_TITLE_OPTION_TYPE_ID_STORE_ID` (`option_type_id`,`store_id`),
  KEY `IDX_CATALOG_PRODUCT_OPTION_TYPE_TITLE_OPTION_TYPE_ID` (`option_type_id`),
  KEY `IDX_CATALOG_PRODUCT_OPTION_TYPE_TITLE_STORE_ID` (`store_id`),
  CONSTRAINT `FK_C085B9CF2C2A302E8043FDEA1937D6A2` FOREIGN KEY (`option_type_id`) REFERENCES `catalog_product_option_type_value` (`option_type_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CAT_PRD_OPT_TYPE_TTL_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Option Type Title Table';



# Dump of table catalog_product_option_type_value
# ------------------------------------------------------------

DROP TABLE IF EXISTS `catalog_product_option_type_value`;

CREATE TABLE `catalog_product_option_type_value` (
  `option_type_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Option Type ID',
  `option_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Option ID',
  `sku` varchar(64) DEFAULT NULL COMMENT 'SKU',
  `sort_order` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Sort Order',
  PRIMARY KEY (`option_type_id`),
  KEY `IDX_CATALOG_PRODUCT_OPTION_TYPE_VALUE_OPTION_ID` (`option_id`),
  CONSTRAINT `FK_CAT_PRD_OPT_TYPE_VAL_OPT_ID_CAT_PRD_OPT_OPT_ID` FOREIGN KEY (`option_id`) REFERENCES `catalog_product_option` (`option_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Option Type Value Table';



# Dump of table catalog_product_relation
# ------------------------------------------------------------

DROP TABLE IF EXISTS `catalog_product_relation`;

CREATE TABLE `catalog_product_relation` (
  `parent_id` int(10) unsigned NOT NULL COMMENT 'Parent ID',
  `child_id` int(10) unsigned NOT NULL COMMENT 'Child ID',
  PRIMARY KEY (`parent_id`,`child_id`),
  KEY `IDX_CATALOG_PRODUCT_RELATION_CHILD_ID` (`child_id`),
  CONSTRAINT `FK_CAT_PRD_RELATION_CHILD_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`child_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CAT_PRD_RELATION_PARENT_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`parent_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Relation Table';



# Dump of table catalog_product_super_attribute
# ------------------------------------------------------------

DROP TABLE IF EXISTS `catalog_product_super_attribute`;

CREATE TABLE `catalog_product_super_attribute` (
  `product_super_attribute_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Product Super Attribute ID',
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product ID',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute ID',
  `position` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Position',
  PRIMARY KEY (`product_super_attribute_id`),
  UNIQUE KEY `UNQ_CATALOG_PRODUCT_SUPER_ATTRIBUTE_PRODUCT_ID_ATTRIBUTE_ID` (`product_id`,`attribute_id`),
  KEY `IDX_CATALOG_PRODUCT_SUPER_ATTRIBUTE_PRODUCT_ID` (`product_id`),
  CONSTRAINT `FK_CAT_PRD_SPR_ATTR_PRD_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Super Attribute Table';



# Dump of table catalog_product_super_attribute_label
# ------------------------------------------------------------

DROP TABLE IF EXISTS `catalog_product_super_attribute_label`;

CREATE TABLE `catalog_product_super_attribute_label` (
  `value_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Value ID',
  `product_super_attribute_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product Super Attribute ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `use_default` smallint(5) unsigned DEFAULT '0' COMMENT 'Use Default Value',
  `value` varchar(255) DEFAULT NULL COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_CAT_PRD_SPR_ATTR_LBL_PRD_SPR_ATTR_ID_STORE_ID` (`product_super_attribute_id`,`store_id`),
  KEY `IDX_CAT_PRD_SPR_ATTR_LBL_PRD_SPR_ATTR_ID` (`product_super_attribute_id`),
  KEY `IDX_CATALOG_PRODUCT_SUPER_ATTRIBUTE_LABEL_STORE_ID` (`store_id`),
  CONSTRAINT `FK_309442281DF7784210ED82B2CC51E5D5` FOREIGN KEY (`product_super_attribute_id`) REFERENCES `catalog_product_super_attribute` (`product_super_attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CAT_PRD_SPR_ATTR_LBL_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Super Attribute Label Table';



# Dump of table catalog_product_super_attribute_pricing
# ------------------------------------------------------------

DROP TABLE IF EXISTS `catalog_product_super_attribute_pricing`;

CREATE TABLE `catalog_product_super_attribute_pricing` (
  `value_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Value ID',
  `product_super_attribute_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product Super Attribute ID',
  `value_index` varchar(255) DEFAULT NULL COMMENT 'Value Index',
  `is_percent` smallint(5) unsigned DEFAULT '0' COMMENT 'Is Percent',
  `pricing_value` decimal(12,4) DEFAULT NULL COMMENT 'Pricing Value',
  `website_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Website ID',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_CAT_PRD_SPR_ATTR_PRICING_PRD_SPR_ATTR_ID_VAL_IDX_WS_ID` (`product_super_attribute_id`,`value_index`,`website_id`),
  KEY `IDX_CAT_PRD_SPR_ATTR_PRICING_PRD_SPR_ATTR_ID` (`product_super_attribute_id`),
  KEY `IDX_CATALOG_PRODUCT_SUPER_ATTRIBUTE_PRICING_WEBSITE_ID` (`website_id`),
  CONSTRAINT `FK_CAT_PRD_SPR_ATTR_PRICING_WS_ID_CORE_WS_WS_ID` FOREIGN KEY (`website_id`) REFERENCES `core_website` (`website_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CDE8813117106CFAA3AD209358F66332` FOREIGN KEY (`product_super_attribute_id`) REFERENCES `catalog_product_super_attribute` (`product_super_attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Super Attribute Pricing Table';



# Dump of table catalog_product_super_link
# ------------------------------------------------------------

DROP TABLE IF EXISTS `catalog_product_super_link`;

CREATE TABLE `catalog_product_super_link` (
  `link_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Link ID',
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product ID',
  `parent_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Parent ID',
  PRIMARY KEY (`link_id`),
  UNIQUE KEY `UNQ_CATALOG_PRODUCT_SUPER_LINK_PRODUCT_ID_PARENT_ID` (`product_id`,`parent_id`),
  KEY `IDX_CATALOG_PRODUCT_SUPER_LINK_PARENT_ID` (`parent_id`),
  KEY `IDX_CATALOG_PRODUCT_SUPER_LINK_PRODUCT_ID` (`product_id`),
  CONSTRAINT `FK_CAT_PRD_SPR_LNK_PRD_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CAT_PRD_SPR_LNK_PARENT_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`parent_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Super Link Table';



# Dump of table catalog_product_website
# ------------------------------------------------------------

DROP TABLE IF EXISTS `catalog_product_website`;

CREATE TABLE `catalog_product_website` (
  `product_id` int(10) unsigned NOT NULL COMMENT 'Product ID',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  PRIMARY KEY (`product_id`,`website_id`),
  KEY `IDX_CATALOG_PRODUCT_WEBSITE_WEBSITE_ID` (`website_id`),
  CONSTRAINT `FK_CATALOG_PRODUCT_WEBSITE_WEBSITE_ID_CORE_WEBSITE_WEBSITE_ID` FOREIGN KEY (`website_id`) REFERENCES `core_website` (`website_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CAT_PRD_WS_PRD_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product To Website Linkage Table';



# Dump of table cataloginventory_stock
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cataloginventory_stock`;

CREATE TABLE `cataloginventory_stock` (
  `stock_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Stock Id',
  `stock_name` varchar(255) DEFAULT NULL COMMENT 'Stock Name',
  PRIMARY KEY (`stock_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cataloginventory Stock';

LOCK TABLES `cataloginventory_stock` WRITE;
/*!40000 ALTER TABLE `cataloginventory_stock` DISABLE KEYS */;

INSERT INTO `cataloginventory_stock` (`stock_id`, `stock_name`)
VALUES
	(1,'Default');

/*!40000 ALTER TABLE `cataloginventory_stock` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table cataloginventory_stock_item
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cataloginventory_stock_item`;

CREATE TABLE `cataloginventory_stock_item` (
  `item_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Item Id',
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product Id',
  `stock_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Stock Id',
  `qty` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Qty',
  `min_qty` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Min Qty',
  `use_config_min_qty` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Use Config Min Qty',
  `is_qty_decimal` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Qty Decimal',
  `backorders` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Backorders',
  `use_config_backorders` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Use Config Backorders',
  `min_sale_qty` decimal(12,4) NOT NULL DEFAULT '1.0000' COMMENT 'Min Sale Qty',
  `use_config_min_sale_qty` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Use Config Min Sale Qty',
  `max_sale_qty` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Max Sale Qty',
  `use_config_max_sale_qty` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Use Config Max Sale Qty',
  `is_in_stock` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is In Stock',
  `low_stock_date` timestamp NULL DEFAULT NULL COMMENT 'Low Stock Date',
  `notify_stock_qty` decimal(12,4) DEFAULT NULL COMMENT 'Notify Stock Qty',
  `use_config_notify_stock_qty` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Use Config Notify Stock Qty',
  `manage_stock` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Manage Stock',
  `use_config_manage_stock` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Use Config Manage Stock',
  `stock_status_changed_auto` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Stock Status Changed Automatically',
  `use_config_qty_increments` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Use Config Qty Increments',
  `qty_increments` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Qty Increments',
  `use_config_enable_qty_inc` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Use Config Enable Qty Increments',
  `enable_qty_increments` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Enable Qty Increments',
  `is_decimal_divided` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Divided into Multiple Boxes for Shipping',
  PRIMARY KEY (`item_id`),
  UNIQUE KEY `UNQ_CATALOGINVENTORY_STOCK_ITEM_PRODUCT_ID_STOCK_ID` (`product_id`,`stock_id`),
  KEY `IDX_CATALOGINVENTORY_STOCK_ITEM_PRODUCT_ID` (`product_id`),
  KEY `IDX_CATALOGINVENTORY_STOCK_ITEM_STOCK_ID` (`stock_id`),
  CONSTRAINT `FK_CATINV_STOCK_ITEM_PRD_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CATINV_STOCK_ITEM_STOCK_ID_CATINV_STOCK_STOCK_ID` FOREIGN KEY (`stock_id`) REFERENCES `cataloginventory_stock` (`stock_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cataloginventory Stock Item';



# Dump of table cataloginventory_stock_status
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cataloginventory_stock_status`;

CREATE TABLE `cataloginventory_stock_status` (
  `product_id` int(10) unsigned NOT NULL COMMENT 'Product Id',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website Id',
  `stock_id` smallint(5) unsigned NOT NULL COMMENT 'Stock Id',
  `qty` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Qty',
  `stock_status` smallint(5) unsigned NOT NULL COMMENT 'Stock Status',
  PRIMARY KEY (`product_id`,`website_id`,`stock_id`),
  KEY `IDX_CATALOGINVENTORY_STOCK_STATUS_STOCK_ID` (`stock_id`),
  KEY `IDX_CATALOGINVENTORY_STOCK_STATUS_WEBSITE_ID` (`website_id`),
  CONSTRAINT `FK_CATINV_STOCK_STS_STOCK_ID_CATINV_STOCK_STOCK_ID` FOREIGN KEY (`stock_id`) REFERENCES `cataloginventory_stock` (`stock_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CATINV_STOCK_STS_PRD_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CATINV_STOCK_STS_WS_ID_CORE_WS_WS_ID` FOREIGN KEY (`website_id`) REFERENCES `core_website` (`website_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cataloginventory Stock Status';



# Dump of table cataloginventory_stock_status_idx
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cataloginventory_stock_status_idx`;

CREATE TABLE `cataloginventory_stock_status_idx` (
  `product_id` int(10) unsigned NOT NULL COMMENT 'Product Id',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website Id',
  `stock_id` smallint(5) unsigned NOT NULL COMMENT 'Stock Id',
  `qty` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Qty',
  `stock_status` smallint(5) unsigned NOT NULL COMMENT 'Stock Status',
  PRIMARY KEY (`product_id`,`website_id`,`stock_id`),
  KEY `IDX_CATALOGINVENTORY_STOCK_STATUS_IDX_STOCK_ID` (`stock_id`),
  KEY `IDX_CATALOGINVENTORY_STOCK_STATUS_IDX_WEBSITE_ID` (`website_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cataloginventory Stock Status Indexer Idx';



# Dump of table cataloginventory_stock_status_tmp
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cataloginventory_stock_status_tmp`;

CREATE TABLE `cataloginventory_stock_status_tmp` (
  `product_id` int(10) unsigned NOT NULL COMMENT 'Product Id',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website Id',
  `stock_id` smallint(5) unsigned NOT NULL COMMENT 'Stock Id',
  `qty` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Qty',
  `stock_status` smallint(5) unsigned NOT NULL COMMENT 'Stock Status',
  PRIMARY KEY (`product_id`,`website_id`,`stock_id`),
  KEY `IDX_CATALOGINVENTORY_STOCK_STATUS_TMP_STOCK_ID` (`stock_id`),
  KEY `IDX_CATALOGINVENTORY_STOCK_STATUS_TMP_WEBSITE_ID` (`website_id`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8 COMMENT='Cataloginventory Stock Status Indexer Tmp';



# Dump of table catalogrule
# ------------------------------------------------------------

DROP TABLE IF EXISTS `catalogrule`;

CREATE TABLE `catalogrule` (
  `rule_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Rule Id',
  `name` varchar(255) DEFAULT NULL COMMENT 'Name',
  `description` text COMMENT 'Description',
  `from_date` date DEFAULT NULL COMMENT 'From Date',
  `to_date` date DEFAULT NULL COMMENT 'To Date',
  `is_active` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Is Active',
  `conditions_serialized` mediumtext COMMENT 'Conditions Serialized',
  `actions_serialized` mediumtext COMMENT 'Actions Serialized',
  `stop_rules_processing` smallint(6) NOT NULL DEFAULT '1' COMMENT 'Stop Rules Processing',
  `sort_order` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Sort Order',
  `simple_action` varchar(32) DEFAULT NULL COMMENT 'Simple Action',
  `discount_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Discount Amount',
  `sub_is_enable` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Rule Enable For Subitems',
  `sub_simple_action` varchar(32) DEFAULT NULL COMMENT 'Simple Action For Subitems',
  `sub_discount_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Discount Amount For Subitems',
  PRIMARY KEY (`rule_id`),
  KEY `IDX_CATALOGRULE_IS_ACTIVE_SORT_ORDER_TO_DATE_FROM_DATE` (`is_active`,`sort_order`,`to_date`,`from_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CatalogRule';



# Dump of table catalogrule_affected_product
# ------------------------------------------------------------

DROP TABLE IF EXISTS `catalogrule_affected_product`;

CREATE TABLE `catalogrule_affected_product` (
  `product_id` int(10) unsigned NOT NULL COMMENT 'Product Id',
  PRIMARY KEY (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CatalogRule Affected Product';



# Dump of table catalogrule_customer_group
# ------------------------------------------------------------

DROP TABLE IF EXISTS `catalogrule_customer_group`;

CREATE TABLE `catalogrule_customer_group` (
  `rule_id` int(10) unsigned NOT NULL COMMENT 'Rule Id',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group Id',
  PRIMARY KEY (`rule_id`,`customer_group_id`),
  KEY `IDX_CATALOGRULE_CUSTOMER_GROUP_RULE_ID` (`rule_id`),
  KEY `IDX_CATALOGRULE_CUSTOMER_GROUP_CUSTOMER_GROUP_ID` (`customer_group_id`),
  CONSTRAINT `FK_CATALOGRULE_CUSTOMER_GROUP_RULE_ID_CATALOGRULE_RULE_ID` FOREIGN KEY (`rule_id`) REFERENCES `catalogrule` (`rule_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CATRULE_CSTR_GROUP_CSTR_GROUP_ID_CSTR_GROUP_CSTR_GROUP_ID` FOREIGN KEY (`customer_group_id`) REFERENCES `customer_group` (`customer_group_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Rules To Customer Groups Relations';



# Dump of table catalogrule_group_website
# ------------------------------------------------------------

DROP TABLE IF EXISTS `catalogrule_group_website`;

CREATE TABLE `catalogrule_group_website` (
  `rule_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Rule Id',
  `customer_group_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Customer Group Id',
  `website_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Website Id',
  PRIMARY KEY (`rule_id`,`customer_group_id`,`website_id`),
  KEY `IDX_CATALOGRULE_GROUP_WEBSITE_RULE_ID` (`rule_id`),
  KEY `IDX_CATALOGRULE_GROUP_WEBSITE_CUSTOMER_GROUP_ID` (`customer_group_id`),
  KEY `IDX_CATALOGRULE_GROUP_WEBSITE_WEBSITE_ID` (`website_id`),
  CONSTRAINT `FK_CATRULE_GROUP_WS_CSTR_GROUP_ID_CSTR_GROUP_CSTR_GROUP_ID` FOREIGN KEY (`customer_group_id`) REFERENCES `customer_group` (`customer_group_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CATALOGRULE_GROUP_WEBSITE_RULE_ID_CATALOGRULE_RULE_ID` FOREIGN KEY (`rule_id`) REFERENCES `catalogrule` (`rule_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CATALOGRULE_GROUP_WEBSITE_WEBSITE_ID_CORE_WEBSITE_WEBSITE_ID` FOREIGN KEY (`website_id`) REFERENCES `core_website` (`website_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CatalogRule Group Website';



# Dump of table catalogrule_product
# ------------------------------------------------------------

DROP TABLE IF EXISTS `catalogrule_product`;

CREATE TABLE `catalogrule_product` (
  `rule_product_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Rule Product Id',
  `rule_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Rule Id',
  `from_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'From Time',
  `to_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'To time',
  `customer_group_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Customer Group Id',
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product Id',
  `action_operator` varchar(10) DEFAULT 'to_fixed' COMMENT 'Action Operator',
  `action_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Action Amount',
  `action_stop` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Action Stop',
  `sort_order` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Sort Order',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website Id',
  `sub_simple_action` varchar(32) DEFAULT NULL COMMENT 'Simple Action For Subitems',
  `sub_discount_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Discount Amount For Subitems',
  PRIMARY KEY (`rule_product_id`),
  UNIQUE KEY `EAA51B56FF092A0DCB795D1CEF812B7B` (`rule_id`,`from_time`,`to_time`,`website_id`,`customer_group_id`,`product_id`,`sort_order`),
  KEY `IDX_CATALOGRULE_PRODUCT_RULE_ID` (`rule_id`),
  KEY `IDX_CATALOGRULE_PRODUCT_CUSTOMER_GROUP_ID` (`customer_group_id`),
  KEY `IDX_CATALOGRULE_PRODUCT_WEBSITE_ID` (`website_id`),
  KEY `IDX_CATALOGRULE_PRODUCT_FROM_TIME` (`from_time`),
  KEY `IDX_CATALOGRULE_PRODUCT_TO_TIME` (`to_time`),
  KEY `IDX_CATALOGRULE_PRODUCT_PRODUCT_ID` (`product_id`),
  CONSTRAINT `FK_CATALOGRULE_PRODUCT_RULE_ID_CATALOGRULE_RULE_ID` FOREIGN KEY (`rule_id`) REFERENCES `catalogrule` (`rule_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CATALOGRULE_PRODUCT_WEBSITE_ID_CORE_WEBSITE_WEBSITE_ID` FOREIGN KEY (`website_id`) REFERENCES `core_website` (`website_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CATRULE_PRD_CSTR_GROUP_ID_CSTR_GROUP_CSTR_GROUP_ID` FOREIGN KEY (`customer_group_id`) REFERENCES `customer_group` (`customer_group_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CATRULE_PRD_PRD_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CatalogRule Product';



# Dump of table catalogrule_product_price
# ------------------------------------------------------------

DROP TABLE IF EXISTS `catalogrule_product_price`;

CREATE TABLE `catalogrule_product_price` (
  `rule_product_price_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Rule Product PriceId',
  `rule_date` date NOT NULL COMMENT 'Rule Date',
  `customer_group_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Customer Group Id',
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product Id',
  `rule_price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Rule Price',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website Id',
  `latest_start_date` date DEFAULT NULL COMMENT 'Latest StartDate',
  `earliest_end_date` date DEFAULT NULL COMMENT 'Earliest EndDate',
  PRIMARY KEY (`rule_product_price_id`),
  UNIQUE KEY `UNQ_CATRULE_PRD_PRICE_RULE_DATE_WS_ID_CSTR_GROUP_ID_PRD_ID` (`rule_date`,`website_id`,`customer_group_id`,`product_id`),
  KEY `IDX_CATALOGRULE_PRODUCT_PRICE_CUSTOMER_GROUP_ID` (`customer_group_id`),
  KEY `IDX_CATALOGRULE_PRODUCT_PRICE_WEBSITE_ID` (`website_id`),
  KEY `IDX_CATALOGRULE_PRODUCT_PRICE_PRODUCT_ID` (`product_id`),
  CONSTRAINT `FK_CATRULE_PRD_PRICE_PRD_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CATRULE_PRD_PRICE_CSTR_GROUP_ID_CSTR_GROUP_CSTR_GROUP_ID` FOREIGN KEY (`customer_group_id`) REFERENCES `customer_group` (`customer_group_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CATALOGRULE_PRODUCT_PRICE_WEBSITE_ID_CORE_WEBSITE_WEBSITE_ID` FOREIGN KEY (`website_id`) REFERENCES `core_website` (`website_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CatalogRule Product Price';



# Dump of table catalogrule_website
# ------------------------------------------------------------

DROP TABLE IF EXISTS `catalogrule_website`;

CREATE TABLE `catalogrule_website` (
  `rule_id` int(10) unsigned NOT NULL COMMENT 'Rule Id',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website Id',
  PRIMARY KEY (`rule_id`,`website_id`),
  KEY `IDX_CATALOGRULE_WEBSITE_RULE_ID` (`rule_id`),
  KEY `IDX_CATALOGRULE_WEBSITE_WEBSITE_ID` (`website_id`),
  CONSTRAINT `FK_CATALOGRULE_WEBSITE_RULE_ID_CATALOGRULE_RULE_ID` FOREIGN KEY (`rule_id`) REFERENCES `catalogrule` (`rule_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CATALOGRULE_WEBSITE_WEBSITE_ID_CORE_WEBSITE_WEBSITE_ID` FOREIGN KEY (`website_id`) REFERENCES `core_website` (`website_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Rules To Websites Relations';



# Dump of table catalogsearch_fulltext
# ------------------------------------------------------------

DROP TABLE IF EXISTS `catalogsearch_fulltext`;

CREATE TABLE `catalogsearch_fulltext` (
  `fulltext_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity ID',
  `product_id` int(10) unsigned NOT NULL COMMENT 'Product ID',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store ID',
  `data_index` longtext COMMENT 'Data index',
  PRIMARY KEY (`fulltext_id`),
  UNIQUE KEY `UNQ_CATALOGSEARCH_FULLTEXT_PRODUCT_ID_STORE_ID` (`product_id`,`store_id`),
  FULLTEXT KEY `FTI_CATALOGSEARCH_FULLTEXT_DATA_INDEX` (`data_index`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Catalog search result table';



# Dump of table catalogsearch_query
# ------------------------------------------------------------

DROP TABLE IF EXISTS `catalogsearch_query`;

CREATE TABLE `catalogsearch_query` (
  `query_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Query ID',
  `query_text` varchar(255) DEFAULT NULL COMMENT 'Query text',
  `num_results` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Num results',
  `popularity` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Popularity',
  `redirect` varchar(255) DEFAULT NULL COMMENT 'Redirect',
  `synonym_for` varchar(255) DEFAULT NULL COMMENT 'Synonym for',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `display_in_terms` smallint(6) NOT NULL DEFAULT '1' COMMENT 'Display in terms',
  `is_active` smallint(6) DEFAULT '1' COMMENT 'Active status',
  `is_processed` smallint(6) DEFAULT '0' COMMENT 'Processed status',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Updated at',
  PRIMARY KEY (`query_id`),
  KEY `IDX_CATALOGSEARCH_QUERY_QUERY_TEXT_STORE_ID_POPULARITY` (`query_text`,`store_id`,`popularity`),
  KEY `IDX_CATALOGSEARCH_QUERY_STORE_ID` (`store_id`),
  KEY `IDX_CATALOGSEARCH_QUERY_SYNONYM_FOR` (`synonym_for`),
  CONSTRAINT `FK_CATALOGSEARCH_QUERY_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog search query table';



# Dump of table catalogsearch_result
# ------------------------------------------------------------

DROP TABLE IF EXISTS `catalogsearch_result`;

CREATE TABLE `catalogsearch_result` (
  `query_id` int(10) unsigned NOT NULL COMMENT 'Query ID',
  `product_id` int(10) unsigned NOT NULL COMMENT 'Product ID',
  `relevance` decimal(20,4) NOT NULL DEFAULT '0.0000' COMMENT 'Relevance',
  PRIMARY KEY (`query_id`,`product_id`),
  KEY `IDX_CATALOGSEARCH_RESULT_QUERY_ID` (`query_id`),
  KEY `IDX_CATALOGSEARCH_RESULT_PRODUCT_ID` (`product_id`),
  CONSTRAINT `FK_CATALOGSEARCH_RESULT_QUERY_ID_CATALOGSEARCH_QUERY_QUERY_ID` FOREIGN KEY (`query_id`) REFERENCES `catalogsearch_query` (`query_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CATSRCH_RESULT_PRD_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog search result table';



# Dump of table checkout_agreement
# ------------------------------------------------------------

DROP TABLE IF EXISTS `checkout_agreement`;

CREATE TABLE `checkout_agreement` (
  `agreement_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Agreement Id',
  `name` varchar(255) DEFAULT NULL COMMENT 'Name',
  `content` text COMMENT 'Content',
  `content_height` varchar(25) DEFAULT NULL COMMENT 'Content Height',
  `checkbox_text` text COMMENT 'Checkbox Text',
  `is_active` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Is Active',
  `is_html` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Is Html',
  PRIMARY KEY (`agreement_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Checkout Agreement';



# Dump of table checkout_agreement_store
# ------------------------------------------------------------

DROP TABLE IF EXISTS `checkout_agreement_store`;

CREATE TABLE `checkout_agreement_store` (
  `agreement_id` int(10) unsigned NOT NULL COMMENT 'Agreement Id',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store Id',
  PRIMARY KEY (`agreement_id`,`store_id`),
  KEY `FK_CHECKOUT_AGREEMENT_STORE_STORE_ID_CORE_STORE_STORE_ID` (`store_id`),
  CONSTRAINT `FK_CHKT_AGRT_STORE_AGRT_ID_CHKT_AGRT_AGRT_ID` FOREIGN KEY (`agreement_id`) REFERENCES `checkout_agreement` (`agreement_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CHECKOUT_AGREEMENT_STORE_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Checkout Agreement Store';



# Dump of table cms_block
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cms_block`;

CREATE TABLE `cms_block` (
  `block_id` smallint(6) NOT NULL AUTO_INCREMENT COMMENT 'Block ID',
  `title` varchar(255) NOT NULL COMMENT 'Block Title',
  `identifier` varchar(255) NOT NULL COMMENT 'Block String Identifier',
  `content` mediumtext COMMENT 'Block Content',
  `creation_time` timestamp NULL DEFAULT NULL COMMENT 'Block Creation Time',
  `update_time` timestamp NULL DEFAULT NULL COMMENT 'Block Modification Time',
  `is_active` smallint(6) NOT NULL DEFAULT '1' COMMENT 'Is Block Active',
  PRIMARY KEY (`block_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS Block Table';

LOCK TABLES `cms_block` WRITE;
/*!40000 ALTER TABLE `cms_block` DISABLE KEYS */;

INSERT INTO `cms_block` (`block_id`, `title`, `identifier`, `content`, `creation_time`, `update_time`, `is_active`)
VALUES
	(1,'Footer Links','footer_links','\n<ul>\n    <li><a href=\"{{store direct_url=\"about-magento-demo-store\"}}\">About Us</a></li>\n    <li><a href=\"{{store direct_url=\"customer-service\"}}\">Customer Service</a></li>\n<li class=\"last privacy\"><a href=\"{{store direct_url=\"privacy-policy-cookie-restriction-mode\"}}\">Privacy Policy</a></li>\r\n</ul>','2015-10-02 19:23:31','2015-10-02 19:23:39',1),
	(2,'Footer Links Company','footer_links_company','\n<div class=\"links\">\n    <div class=\"block-title\">\n        <strong><span>Company</span></strong>\n    </div>\n    <ul>\n        <li><a href=\"{{store url=\"\"}}about-magento-demo-store/\">About Us</a></li>\n        <li><a href=\"{{store url=\"\"}}contacts/\">Contact Us</a></li>\n        <li><a href=\"{{store url=\"\"}}customer-service/\">Customer Service</a></li>\n        <li><a href=\"{{store url=\"\"}}privacy-policy-cookie-restriction-mode/\">Privacy Policy</a></li>\n    </ul>\n</div>','2015-10-02 19:23:37','2015-10-02 19:23:37',1),
	(3,'Cookie restriction notice','cookie_restriction_notice_block','<p>This website requires cookies to provide all of its features. For more information on what data is contained in the cookies, please see our <a href=\"{{store direct_url=\"privacy-policy-cookie-restriction-mode\"}}\">Privacy Policy page</a>. To accept cookies from this site, please click the Allow button below.</p>','2015-10-02 19:23:40','2015-10-02 19:23:40',1),
	(4,'Em0120 - Area 01 - Shipping','em0120_area01_shipping','<div class=\"col-sm-8 first\">\n<div class=\"content first \">\n<h3>Free shipping worldwide</h3>\n</div>\n</div>\n<div class=\"col-sm-8\">\n<div class=\"content second\">\n<h3>Sale up to 70% Off on Monday*</h3>\n</div>\n</div>\n<div class=\"col-sm-8 last\">\n<div class=\"content last \">\n<h3>Deal of The Week -$10.98 Chiffon</h3>\n</div>\n</div>','2015-10-02 19:30:02','2015-10-02 19:30:02',1),
	(5,'Em0120 - Area 05 - Features','em0120_area05_features','<div class=\"col-sm-8 first\">\n<div class=\"feature-content\">\n<h3>Style for every budget at CD!</h3>\n<p>Open source policymakers; crisis management legal aid, recognize potential investment action refugee research. Underprivileged Oxfam</p>\n</div>\n<div class=\"feature-content\">\n<h3>Clean design</h3>\n<p>Honesty medicine theory of social change, protect, involvement eradicate fluctuation sustainable future collaborative. Celebrate Jane Jacobs</p>\n</div>\n</div>\n<div class=\"col-sm-8\">\n<div class=\"feature-content\">\n<h3>Loaded With Power</h3>\n<p>Global health humanitarian relief human potential; catalyst small-scale farmers maintain opportunity combat poverty.</p>\n</div>\n<div class=\"feature-content\">\n<h3>Choose the products you love</h3>\n<p>Celebrate Jane Jacobs, economic security resolve storytelling human experience. Equal opportunity socio-economic divide Arab</p>\n</div>\n</div>\n<div class=\"col-sm-8 last\">\n<div class=\"feature-content\">\n<h3>Completely Customizable</h3>\n<p>Cross-agency coordination crowdsourcing sanitation Action Against Hunger affiliate reproductive rights. Nonprofit, shift initiative diversity</p>\n</div>\n<div class=\"feature-content\">\n<h3>Free Updates &amp; Support</h3>\n<p>Achieve Gandhi public sector human potential lore healthcare non-partisan forward-thinking innovation crowdsourcing equal</p>\n</div>\n</div>','2015-10-02 19:30:03','2015-10-02 19:30:03',1),
	(6,'Em0120 - Area 05 - Three Banners','em0120_area05_three_banners','<ul>\n<li class=\"col-sm-8 first\"><a href=\"#\"><img class=\"img-responsive\" src=\"{{skin url=\'images/media/banner04.jpg\'}}\" alt=\"\" /><span><span>Beauty</span><span>Best in Accessories</span></span></a>\n<div class=\"mask\">&nbsp;</div>\n</li>\n<li class=\"col-sm-8\"><a href=\"#\"><img class=\"img-responsive\" src=\"{{skin url=\'images/media/banner05.jpg\'}}\" alt=\"\" /><span><span>Dress</span><span> dance in all winter</span></span> </a>\n<div class=\"mask\">&nbsp;</div>\n</li>\n<li class=\"col-sm-8 last\"><a href=\"#\"><img class=\"img-responsive\" src=\"{{skin url=\'images/media/banner06.jpg\'}}\" alt=\"\" /><span><span>trends</span><span>New Collection 2015</span></span></a>\n<div class=\"mask\">&nbsp;</div>\n</li>\n</ul>','2015-10-02 19:30:04','2015-10-02 19:30:04',1),
	(7,'Em0120 - Area 06 - Banner Shipping','em0120_area06_banner_shipping','<p><span class=\"icon slide\">icon</span></p>\n<h3>LOOKING COOL <span>&amp;</span> COLLECTED</h3>\n<div><a class=\"see_more\" href=\"#\">DISCOVER</a></div>','2015-10-02 19:30:05','2015-10-02 19:30:05',1),
	(8,'Em0120 - Area 07 - Featured Products','em0120_area07_featured_products','<div class=\"featured-products\" style=\"text-align: left;\">\n<div class=\"left\">{{widget type=\"filterproducts/list\" type_filter=\"1\" featured=\"em_featured\" limit_count=\"1\" order_by=\"name asc\" show=\"thumb,name,sku,price\" thumbnail_width=\"364\" thumbnail_height=\"508\" choose_template=\"em_filterproducts/sample_grid.phtml\"}}</div>\n<div class=\"right\">{{widget type=\"filterproducts/list\" type_filter=\"1\" featured=\"em_featured\" limit_count=\"100\" column_count=\"3\" order_by=\"name asc\" show=\"thumb,name,sku,desc,addtocart,addto\" thumbnail_width=\"115\" thumbnail_height=\"161\" choose_template=\"custom_template\" custom_theme=\"em_filterproducts/home_featured_list.phtml\" slider_enable=\"1\" slider_items=\"1\" slider_items_desktop=\"1\" slider_items_desktop_small=\"1\" slider_items_tablet=\"1\" slider_items_mobile=\"1\" slider_speed=\"200\" slider_rewindspeed=\"200\" slider_navigation=\"1\"}}</div>\n</div>','2015-10-02 19:30:07','2015-10-02 19:30:07',1),
	(9,'Em0120 - Area 08 - Newsletter','em0120_area08_newsletter','<div>{{block type=\"newsletter/subscribe\" name=\"left.newsletter\" template=\"newsletter/subscribe.phtml\"}}</div>','2015-10-02 19:30:08','2015-10-02 19:30:08',1),
	(10,'Em0120 - Area 08 - Testimonial','em0120_area08_testimonial','<div class=\"testimonial\">\n<ul class=\"owl-carousel owl-theme\">\n<li class=\"item\">\n<div class=\"decs\">\n<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua...</p>\n</div>\n<div class=\"info\"><img src=\"{{skin url=\'images/media/banner08.jpg\'}}\" alt=\"\" />\n<h3>Customer Name</h3>\n<p>Saler Person</p>\n</div>\n</li>\n<li class=\"item\">\n<div class=\"decs\">\n<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua...</p>\n</div>\n<div class=\"info\"><img src=\"{{skin url=\'images/media/banner08.jpg\'}}\" alt=\"\" />\n<h3>Customer Name</h3>\n<p>Saler Person</p>\n</div>\n</li>\n<li class=\"item\">\n<div class=\"decs\">\n<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua...</p>\n</div>\n<div class=\"info\"><img src=\"{{skin url=\'images/media/banner08.jpg\'}}\" alt=\"\" />\n<h3>Customer Name</h3>\n<p>Saler Person</p>\n</div>\n</li>\n</ul>\n</div>\n<script type=\"text/javascript\">// <![CDATA[\n		jQuery(document).ready(function() {\n			jQuery(\'.testimonial >  ul\').owlCarousel({\n                //Basic Speeds\n                slideSpeed : 200,\n                rewindSpeed :800,\n             \n                //Autoplay\n                autoPlay :false,\n                lazyLoad : true,\n                stopOnHover : false,\n                mouseDrag : false,\n                touchDrag : false,    \n             \n                // Navigation\n                navigation : true,\n                navigationText : [\"Previous\", \"Next\"],\n                pagination :false,\n                paginationNumbers: false,\n             \n                // Responsive \n                responsive: true,\n                items : 1, /*items above 1200px browser width*/\n                itemsDesktop : [1199, 1], /*//items between 1199px and 981px*/\n                itemsDesktopSmall : [991, 1 ],\n                itemsTablet: [767,1],\n                itemsTabletSmall : [599,1],\n                itemsMobile : [320,1],\n             \n                // CSS Styles\n                baseClass : \"owl-carousel\",\n                theme : \"owl-theme\",\n                addClassActive : true,\n                scrollPerPage :false\n          });\n		});\n// ]]></script>','2015-10-02 19:30:09','2015-10-02 19:30:09',1),
	(11,'Em0120 - Area 09 - Brand','em0120_area09_brand','<div class=\"footer-brand\">\n<ul class=\"owl-carousel owl-theme\">\n<li class=\"item\"><a class=\"img_brand\" title=\"wp\" href=\"http://wpdance.com/\"><img class=\"first\" src=\"{{skin url=\'images/brands/brand_wp.png\'}}\" alt=\"wp\" /><img class=\"last\" src=\"{{skin url=\'images/brands/brand_wp_hover.png\'}}\" alt=\"wp\" /></a></li>\n<li class=\"item\"><a class=\"img_brand\" title=\"extreme\" href=\"http://www.emthemes.com/\"><img class=\"first\" src=\"{{skin url=\'images/brands/brand_ex.png\'}}\" alt=\"extreme\" /><img class=\"last\" src=\"{{skin url=\'images/brands/brand_ex_hover.png\'}}\" alt=\"extreme\" /></a></li>\n<li class=\"item\"><a class=\"img_brand\" title=\"presthemes\" href=\"http://www.prestashop.com/\"><img class=\"first\" src=\"{{skin url=\'images/brands/brand_pres.png\'}}\" alt=\"presthemes\" /><img class=\"last\" src=\"{{skin url=\'images/brands/brand_pres_hover.png\'}}\" alt=\"presthemes\" /></a></li>\n<li class=\"item\"><a class=\"img_brand\" title=\"galathemes\" href=\"http://galathemes.com/\"><img class=\"first\" src=\"{{skin url=\'images/brands/brand_gala.png\'}}\" alt=\"galathemes\" /><img class=\"last\" src=\"{{skin url=\'images/brands/brand_gala_hover.png\'}}\" alt=\"galathemes\" /></a></li>\n<li class=\"item\"><a class=\"img_brand\" title=\"bossthemes\" href=\"http://bossthemes.com/\"><img class=\"first\" src=\"{{skin url=\'images/brands/brand_boss.png\'}}\" alt=\"bossthemes\" /><img class=\"last\" src=\"{{skin url=\'images/brands/brand_boss_hover.png\'}}\" alt=\"bossthemes\" /></a></li>\n<li class=\"item\"><a class=\"img_brand\" title=\"eggthemes\" href=\"http://eggthemes.com/\"><img class=\"first\" src=\"{{skin url=\'images/brands/brand_egg.png\'}}\" alt=\"eggthemes\" /><img class=\"last\" src=\"{{skin url=\'images/brands/brand_egg_hover.png\'}}\" alt=\"eggthemes\" /></a></li>\n<li class=\"item\"><a class=\"img_brand\" title=\"designshopify\" href=\"http://designshopify.com/\"><img class=\"first\" src=\"{{skin url=\'images/brands/brand_design.png\'}}\" alt=\"designshopify\" /><img class=\"last\" src=\"{{skin url=\'images/brands/brand_design_hover.png\'}}\" alt=\"designshopify\" /></a></li>\n<li class=\"item\"><a class=\"img_brand\" title=\"codespot\" href=\"http://codespot.vn/\"><img class=\"first\" src=\"{{skin url=\'images/brands/brand_codespot.png\'}}\" alt=\"codespot\" /><img class=\"last\" src=\"{{skin url=\'images/brands/brand_codespot_hover.png\'}}\" alt=\"codespot\" /></a></li>\n</ul>\n<script type=\"text/javascript\">// <![CDATA[\n		jQuery(document).ready(function() {\n			jQuery(\'.footer-brand >  ul\').owlCarousel({\n                //Basic Speeds\n                slideSpeed : 200,\n                rewindSpeed :800,\n             \n                //Autoplay\n                autoPlay :false,\n                lazyLoad : true,\n                stopOnHover : false,\n                mouseDrag : false,\n                touchDrag : false,    \n             \n                // Navigation\n                navigation : true,\n                navigationText : [\"Previous\", \"Next\"],\n                pagination :false,\n                paginationNumbers: false,\n             \n                // Responsive \n                responsive: true,\n                items : 5, /*items above 1200px browser width*/\n                itemsDesktop : [1199, 5], /*//items between 1199px and 981px*/\n                itemsDesktopSmall : [991, 4 ],\n                itemsTablet: [767,3],\n                itemsTabletSmall : [599,2],\n                itemsMobile : [320,1],\n             \n                // CSS Styles\n                baseClass : \"owl-carousel\",\n                theme : \"owl-theme\",\n                addClassActive : true,\n                scrollPerPage :false\n          });\n		});\n// ]]></script>\n</div>','2015-10-02 19:30:10','2015-10-02 19:30:10',1),
	(12,'Em0120 - Area 09 - Four Banners','em0120_area09_four_banner','<ul>\n<li><a href=\"#\"><img class=\"img-responsive\" src=\"{{skin url=\'images/media/banner09.jpg\'}}\" alt=\"\" /></a></li>\n<li><a href=\"#\"><img class=\"img-responsive\" src=\"{{skin url=\'images/media/banner10.jpg\'}}\" alt=\"\" /></a></li>\n<li><a href=\"#\"><img class=\"img-responsive\" src=\"{{skin url=\'images/media/banner11.jpg\'}}\" alt=\"\" /></a></li>\n<li class=\"last\"><a href=\"#\"><img class=\"img-responsive\" src=\"{{skin url=\'images/media/banner12.jpg\'}}\" alt=\"\" /></a></li>\n</ul>','2015-10-02 19:30:11','2015-10-02 19:30:11',1),
	(13,'Em0120 - Area 10 - Links','em0120_area10_links','<div id=\"footer-information\" class=\"box link_text\">\n<div class=\"col-sm-8 first link_content\">\n<div class=\"inner_links\">\n<p class=\"h5\">About Adore</p>\n<div class=\"content_links\"><a href=\"#\"><img src=\"{{skin url=\'images/logo_footer.png\'}}\" alt=\"\" /></a>\n<p>In a venenatis enim. Duis vulputate lorem eget facilisis lacinia. Nulla facilisi. Sed eu lectus vitae nibh sollicitudin tincidunt rhoncus sit amet lore magna. Nam metus ut nunc pretium</p>\n<ul>\n<li><a class=\"show icon facebook\" title=\"Facebook\" href=\"#\" data-toggle=\"tooltip\" data-placement=\"bottom\" data-original-title=\"Facebook\"><span>Facebook</span></a></li>\n<li><a class=\"show icon pinterest\" title=\"Pinterest\" href=\"#\" data-toggle=\"tooltip\" data-placement=\"bottom\" data-original-title=\"Pinterest\"><span>Facebook</span></a></li>\n<li><a class=\"show icon twitter\" title=\"Twitter\" href=\"#\" data-toggle=\"tooltip\" data-placement=\"bottom\" data-original-title=\"Twitter\">Twitter</a></li>\n<li><a class=\"show icon google\" title=\"Google\" href=\"#\" data-toggle=\"tooltip\" data-placement=\"bottom\" data-original-title=\"Google\">Google</a></li>\n<li><a class=\"show icon rss\" title=\"Rss\" href=\"#\" data-toggle=\"tooltip\" data-placement=\"bottom\" data-original-title=\"Rss\">Rss</a></li>\n<li><a class=\"show icon vimeo\" title=\"Vimeo\" href=\"#\" data-toggle=\"tooltip\" data-placement=\"bottom\" data-original-title=\"Vimeo\">Vimeo</a></li>\n</ul>\n</div>\n</div>\n</div>\n<div class=\"col-sm-8 link_content\">\n<div class=\"inner_links\">\n<p class=\"h5\">Quick Link</p>\n<div class=\"content_links\">\n<ul class=\"list-unstyled\">\n<li><a href=\"{{store url=\'about-magento-demo-store\'}}\">About us</a></li>\n<li><a href=\"#\">Our offfice</a></li>\n<li><a href=\"#\">Deliver</a></li>\n<li><a href=\"#\">Store</a></li>\n<li><a href=\"#\">Guarantee</a></li>\n<li><a href=\"#\">Buy gift card</a></li>\n</ul>\n<ul class=\"list-unstyled\">\n<li><a href=\"#\">Track to your order</a></li>\n<li><a href=\"#\">Term</a></li>\n<li><a href=\"#\">Conditions</a></li>\n<li><a href=\"#\">Contact us</a></li>\n<li><a href=\"#\">Manufactures</a></li>\n<li><a href=\"#\">New Brands</a></li>\n</ul>\n</div>\n</div>\n</div>\n<div class=\"col-sm-8 omega link_content last\">\n<div class=\"inner_links\">\n<p class=\"h5\">Recent Post</p>\n<div class=\"content_links\">\n<div class=\"recent-blog\">{{block type=\"blog/post_list_recent\" name=\"blog.recent\" template=\"em_blog/post/list/recent_area10.phtml\"}}</div>\n</div>\n</div>\n</div>\n</div>','2015-10-02 19:30:13','2015-10-02 19:30:13',1),
	(14,'Em0120 - Footer - Payment','em0120_footer_payment','<p class=\"payment_accept\"><a class=\"brand-logo master\" title=\"Master Card\" href=\"#\">MasterCard</a> <a class=\"brand-logo visa\" title=\"Visa\" href=\"#\">Visa </a> <a class=\"brand-logo express \" title=\"American Express\" href=\"#\">American Express</a><a class=\"brand-logo paypal\" title=\"Paypal\" href=\"#\">Paypal</a> <a class=\"brand-logo skrill\" title=\"skrill\" href=\"#\">skrill</a></p>','2015-10-02 19:30:14','2015-10-02 19:30:14',1),
	(15,'Em0120 - Area 3 - Sample Block','em0120_area3_sample_block','<div class=\"box3\">\n<p>Sample Block Here ...</p>\n<p>This is a sample content in position EM Area 03. You can add your own content by insert widget into position EM Area 03</p>\n</div>','2015-10-02 19:30:15','2015-10-02 19:30:15',1),
	(16,'Em0120 - Area 4 - Sample Block','em0120_area4_sample_block','<div class=\"box3\">\n<p>Sample Block Here ...</p>\n<p>This is a sample content in position EM Area 04. You can add your own content by insert widget into position EM Area 04</p>\n</div>','2015-10-02 19:30:16','2015-10-02 19:30:16',1),
	(17,'EM0120 Sample Block - Alert Us','em0120_sample_block_alert_us','<div class=\"box3\">\n<p>Sample Block Here ...</p>\n<p>This is a sample content in position Alert Us. You can add your own content by insert widget into position Alert Us</p>\n</div>','2015-10-02 19:30:17','2015-10-02 19:30:17',1),
	(18,'EM0120 Sample Block - Extra Hint','em0120_sample_block_extra_hint','<div class=\"box3\">\n<p>Sample Block Here ...</p>\n<p>This is a sample content in position Extra Hint. You can add your own content by insert widget into position Extra Hint</p>\n</div>','2015-10-02 19:30:19','2015-10-02 19:30:19',1),
	(19,'Em0120 Product Collateral Sample','em0120_product_collateral_sample','<div class=\"box3\">\n<p>Sample Block Here ...</p>\n<p>A sample of additional collateral tabs that you can insert as a widget in static the backend.</p>\n</div>','2015-10-02 19:30:20','2015-10-02 19:30:20',1),
	(20,'Em0120 - Sidebar - Banner','em0120_sidebar_banner','<div class=\"block block-banner\"><a title=\"\" href=\"#\"><img class=\"img-responsive\" src=\"{{skin url=\'images/media/left_banner.jpg\'}}\" alt=\"\" /></a></div>','2015-10-02 19:30:21','2015-10-02 19:30:21',1),
	(21,'Em0120 - Sidebar - Banner Account','em0120_sidebar_banner_account','<div class=\"block block-banner\"><a title=\"\" href=\"#\"><img class=\"img-responsive\" src=\"{{skin url=\'images/media/left_banner_account.jpg\'}}\" alt=\"\" /></a></div>','2015-10-02 19:30:23','2015-10-02 19:30:23',1),
	(22,'Em0120 - Footer - Links','em0120_footer_links','<div class=\"footer-link\">\n<ul class=\"links\">\n<li><a href=\"{{store direct_url=\"about-magento-demo-store\"}}\">About Us</a></li>\n<li><a href=\"{{store direct_url=\"customer-service\"}}\">Customer Service</a></li>\n<li class=\"last privacy\"><a href=\"{{store direct_url=\"privacy-policy-cookie-restriction-mode\"}}\">Privacy Policy</a></li>\n</ul>\n<ul class=\"links\">\n<li class=\"first\"><a title=\"Contact Us\" href=\"{{store direct_url=\"contacts\"}}\">Contact Us</a></li>\n<li><a title=\"Site Map\" href=\"{{store direct_url=\"catalog/seo_sitemap/category\"}}\">Site Map</a></li>\n<li><a title=\"Search Terms\" href=\"{{store direct_url=\"catalogsearch/term/popular\"}}\">Search Terms</a></li>\n<li><a title=\"Advanced Search\" href=\"{{store direct_url=\"catalogsearch/advanced\"}}\">Advanced Search</a></li>\n<li class=\" last\"><a title=\"Orders and Returns\" href=\"{{store direct_url=\"sales/guest/form\"}}\">Orders and Returns</a></li>\n</ul>\n</div>','2015-10-02 19:30:24','2015-10-02 19:30:24',1),
	(23,'Em0120 - Area 05 - Accessories Two Banners','em0120_area05_accessories_two_banners','<ul>\n<li class=\"first\"><a href=\"#\"><img class=\"img-responsive\" src=\"{{skin url=\'images/media/banner04.png\'}}\" alt=\"\" /><span><span>Save off 50%</span><span>Featuring drawcord closure, adjustable shoulder strap</span></span></a>\n<div class=\"mask\">&nbsp;</div>\n</li>\n<li><a href=\"#\"><img class=\"img-responsive\" src=\"{{skin url=\'images/media/banner05.png\'}}\" alt=\"\" /><span><span>Leather</span><span>Black look duffle bag</span></span></a>\n<div class=\"mask\">&nbsp;</div>\n</li>\n</ul>','2015-10-02 19:30:25','2015-10-02 19:30:25',1),
	(24,'Em0120 - Area 06 - Accessories Blog','em0120_area06_accessories_blog','<div>{{block type=\"blog/post_list_recent\" name=\"blog.recent\" template=\"em_blog/post/list/recent_area06.phtml\"}}</div>','2015-10-02 19:30:27','2015-10-02 19:30:27',1),
	(25,'Em0120 - Area 16 - Accessories Banner Newsletter','em0120_area16_accessories_banner_newsletter','<ul>\n<li class=\"first\"><a href=\"#\"><img class=\"img-responsive\" src=\"{{skin url=\'images/media/banner07.jpg\'}}\" alt=\"\" /><span><span>Beauty</span><span>From $129.00 to $149.00</span></span></a>\n<div class=\"mask\">&nbsp;</div>\n</li>\n<li>\n<div class=\"newsletter-content\">{{block type=\"newsletter/subscribe\" name=\"left.newsletter\" template=\"newsletter/subscribe.phtml\"}}</div>\n</li>\n<li class=\"last\"><a href=\"#\"><img class=\"img-responsive\" src=\"{{skin url=\'images/media/banner08.jpg\'}}\" alt=\"\" /><span><span>Boots</span><span>timberland boots UK 9</span></span></a>\n<div class=\"mask\">&nbsp;</div>\n</li>\n</ul>','2015-10-02 19:30:28','2015-10-02 19:30:28',1),
	(26,'Em0120 - Area 07 - Furniture Bestseller Products','em0120_area07_furniture_bestseller_products','<div class=\"featured-products\">\n<div class=\"left\">{{widget type=\"filterproducts/list\" type_filter=\"2\" featured=\"em_featured\" limit_count=\"1\" order_by=\"name asc\" show=\"thumb,name,sku,price,addtocart,addto\" thumbnail_width=\"364\" thumbnail_height=\"508\" choose_template=\"em_filterproducts/sample_grid.phtml\"}}</div>\n<div class=\"right\">{{widget type=\"filterproducts/list\" type_filter=\"2\" featured=\"em_featured\" limit_count=\"100\" column_count=\"3\" order_by=\"name asc\" show=\"thumb,name,sku,desc,addtocart,addto\" thumbnail_width=\"115\" thumbnail_height=\"161\" choose_template=\"custom_template\" custom_theme=\"em_filterproducts/home_featured_list.phtml\" slider_enable=\"1\" slider_items=\"1\" slider_items_desktop=\"1\" slider_items_desktop_small=\"1\" slider_items_tablet=\"1\" slider_items_mobile=\"1\" slider_speed=\"200\" slider_rewindspeed=\"200\" slider_navigation=\"1\"}}</div>\n</div>','2015-10-02 19:30:29','2015-10-02 19:30:29',1),
	(27,'Em0120 - Area 08 - Furniture Testimonial','em0120_area08_furniture_testimonial','<div class=\"testimonial\">\n<ul>\n<li class=\"item\">\n<div class=\"decs\">\n<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.&nbsp;</p>\n</div>\n<div class=\"info\"><img src=\"{{skin url=\'images/media/banner08.jpg\'}}\" alt=\"\" />\n<h3>Customer Name</h3>\n<p>Saler Person</p>\n</div>\n</li>\n<li class=\"item\">\n<div class=\"decs\">\n<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.</p>\n</div>\n<div class=\"info\"><img src=\"{{skin url=\'images/media/banner08a.jpg\'}}\" alt=\"\" />\n<h3>Customer Name</h3>\n<p>Saler Person</p>\n</div>\n</li>\n<li class=\"item\">\n<div class=\"decs\">\n<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.&nbsp;</p>\n</div>\n<div class=\"info\"><img src=\"{{skin url=\'images/media/banner08b.jpg\'}}\" alt=\"\" />\n<h3>Customer Name</h3>\n<p>Saler Person</p>\n</div>\n</li>\n</ul>\n</div>','2015-10-02 19:30:30','2015-10-02 19:30:30',1),
	(28,'Em0120 - Area 08 - Furniture Tweets','em0120_area08_furniture_tweets','<div class=\"tweets-title\">Lastest tweets</div>\n<div class=\"tweets-status\">\n<div class=\"content-tweets\">\n<p class=\"h5\">@emthemets_support</p>\n<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.&nbsp;</p>\n</div>\n<a href=\"#\"><span><span>Follow us</span></span></a></div>','2015-10-02 19:30:32','2015-10-02 19:30:32',1),
	(29,'Em0120 - Area 08 - Furniture Two Banners','em0120_area08_furniture_two_banners','<ul>\n<li><a href=\"#\"><img src=\"{{skin url=\'images/media/banner13.jpg\'}}\" alt=\"\" /><span><span>Purple house</span><span>The best view 2015</span></span></a></li>\n<li><a href=\"#\"><img src=\"{{skin url=\'images/media/banner14.jpg\'}}\" alt=\"\" /><span><span>Garden</span><span>The deep seating group</span></span></a></li>\n</ul>','2015-10-02 19:30:33','2015-10-02 19:30:33',1),
	(30,'Em0120 - Area 05 - Jewellery Shipping','em0120_area05_jewellery_shipping','<div class=\"content\"><h3>Free shipping on order over</h3>\n<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</p></div>\n<div><a class=\"see_more\" href=\"#\"><span>WHERE WE SHIP TO</span> <span class=\"icon ship\">&gt;</span></a></div>','2015-10-02 19:30:34','2015-10-02 19:30:34',1),
	(31,'Em0120 - Main - Jewellery Recommend Product','em0120_main_jewellery_recommend_product','<div class=\"main-widget\">{{widget type=\"filterproducts/list\" type_filter=\"1\" featured=\"em_featured\" limit_count=\"10\" order_by=\"name asc\" frontend_title=\"We also recommend\" show=\"thumb,name,sku,price,label,addtocart,addto\" thumbnail_width=\"223\" thumbnail_height=\"311\" choose_template=\"em_filterproducts/sample_grid.phtml\" slider_enable=\"1\" slider_items=\"4\" slider_items_desktop=\"4\" slider_items_desktop_small=\"3\" slider_items_tablet=\"2\" slider_items_mobile=\"1\" slider_speed=\"200\" slider_rewindspeed=\"200\" slider_navigation=\"1\"}}</div>\n<div class=\"title\"><a href=\"#\"><img class=\"img-responsive\" src=\"{{skin url=\'images/media/banner01.jpg\'}}\" alt=\"\" /></a></div>','2015-10-02 19:30:35','2015-10-02 19:30:35',1),
	(32,'Em0120 - Area 06 - Jewellery Banner','em0120_area06_jewellery_banner','<p><a href=\"#\"> <img class=\"first img-responsive\" src=\"{{skin url =\"images/media/banner02.png\"}}\" alt=\"\" /> </a></p>','2015-10-02 19:30:36','2015-10-02 19:30:36',1),
	(33,'Em0120 - Area 09 - Jewellery Four Banners','em0120_area09_jewellery_four_banner','<ul>\n<li><a href=\"#\"><img class=\"img-responsive\" src=\"{{skin url=\'images/media/banner15.jpg\'}}\" alt=\"\" /></a>\n<h3>Lorem ipsum dolor sit amer consecteur</h3>\n<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.</p>\n<a href=\"#\">Read more</a></li>\n<li><a href=\"#\"><img class=\"img-responsive\" src=\"{{skin url=\'images/media/banner16.jpg\'}}\" alt=\"\" /></a>\n<h3>Lorem ipsum dolor sit amer consecteur</h3>\n<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.</p>\n<a href=\"#\">Read more</a></li>\n<li><a href=\"#\"><img class=\"img-responsive\" src=\"{{skin url=\'images/media/banner17.jpg\'}}\" alt=\"\" /></a>\n<h3>Lorem ipsum dolor sit amer consecteur</h3>\n<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.</p>\n<a href=\"#\">Read more</a></li>\n<li class=\"last\"><a href=\"#\"><img class=\"img-responsive\" src=\"{{skin url=\'images/media/banner18.jpg\'}}\" alt=\"\" /></a>\n<h3>Lorem ipsum dolor sit amer consecteur</h3>\n<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.</p>\n<a href=\"#\">Read more</a></li>\n</ul>','2015-10-02 19:30:37','2015-10-02 19:30:37',1),
	(34,'Em0120 - Area 05 - Watches Two Banners','em0120_area05_watches_two_banners','<ul>\n<li><a href=\"#\"><img src=\"{{skin url=\'images/media/banner13.jpg\'}}\" alt=\"\" /></a></li>\n<li><a href=\"#\"><img src=\"{{skin url=\'images/media/banner14_1.jpg\'}}\" alt=\"\" /></a></li>\n<li><a href=\"#\"><img src=\"{{skin url=\'images/media/banner14_2.jpg\'}}\" alt=\"\" /></a></li>\n<li><a href=\"#\"><img src=\"{{skin url=\'images/media/banner14_3.jpg\'}}\" alt=\"\" /></a></li>\n</ul>','2015-10-02 19:30:39','2015-10-02 19:30:39',1),
	(35,'Em0120 - Area 05 - Watches Three Banners','em0120_area05_watches_three_banners','<ul>\n<li class=\"first\"><a href=\"#\"><img class=\"img-responsive\" src=\"{{skin url=\'images/media/banner04.png\'}}\" alt=\"\" /></a>\n<div class=\"mask\">&nbsp;</div>\n<h3>Clean Design</h3>\n<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.</p>\n</li>\n<li><a href=\"#\"><img class=\"img-responsive\" src=\"{{skin url=\'images/media/banner05.png\'}}\" alt=\"\" /></a>\n<div class=\"mask\">&nbsp;</div>\n<h3>Choose the products you love</h3>\n<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.</p>\n</li>\n<li class=\"last\"><a href=\"#\"><img class=\"img-responsive\" src=\"{{skin url=\'images/media/banner06.png\'}}\" alt=\"\" /></a>\n<div class=\"mask\">&nbsp;</div>\n<h3>Free update &amp; support</h3>\n<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.</p>\n</li>\n</ul>','2015-10-02 19:30:40','2015-10-02 19:30:40',1),
	(36,'Em0120 - Area 16 - Watches Newsletter','em0120_area16_watches_newsletter','<div>{{block type=\"newsletter/subscribe\" name=\"left.newsletter\" template=\"newsletter/subscribe.phtml\"}}</div>','2015-10-02 19:30:41','2015-10-02 19:30:41',1),
	(37,'Em0120 - Area 16 - Watches Four Banners','em0120_area16_watches_four_banners','<ul>\n<li><a href=\"#\"><img class=\"img-responsive\" src=\"{{skin url=\'images/media/banner15.jpg\'}}\" alt=\"\" /></a>\n<div><h3>Lorem ipsum dolor sit amer consecteur</h3>\n<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.</p>\n<a href=\"#\">Read more</a></div></li>\n<li><a href=\"#\"><img class=\"img-responsive\" src=\"{{skin url=\'images/media/banner16.jpg\'}}\" alt=\"\" /></a>\n<div><h3>Lorem ipsum dolor sit amer consecteur</h3>\n<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.</p>\n<a href=\"#\">Read more</a></div></li>\n<li><a href=\"#\"><img class=\"img-responsive\" src=\"{{skin url=\'images/media/banner17.jpg\'}}\" alt=\"\" /></a>\n<div><h3>Lorem ipsum dolor sit amer consecteur</h3>\n<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.</p>\n<a href=\"#\">Read more</a></div></li>\n<li class=\"last\"><a href=\"#\"><img class=\"img-responsive\" src=\"{{skin url=\'images/media/banner18.jpg\'}}\" alt=\"\" /></a>\n<div><h3>Lorem ipsum dolor sit amer consecteur</h3>\n<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.</p>\n<a href=\"#\">Read more</a></div></li>\n</ul>','2015-10-02 19:30:42','2015-10-02 19:30:42',1),
	(38,'Em0120 - Area 01 - Furniture Four Banners','em0120_area01_furniture_four_banner','<ul>\n<li><a href=\"#\"><img class=\"img-responsive\" src=\"{{skin url=\'images/media/banner09.jpg\'}}\" alt=\"\" /></a></li>\n<li><a href=\"#\"><img class=\"img-responsive\" src=\"{{skin url=\'images/media/banner10.jpg\'}}\" alt=\"\" /></a></li>\n<li><a href=\"#\"><img class=\"img-responsive\" src=\"{{skin url=\'images/media/banner11.jpg\'}}\" alt=\"\" /></a></li>\n<li class=\"last\"><a href=\"#\"><img class=\"img-responsive\" src=\"{{skin url=\'images/media/banner12.jpg\'}}\" alt=\"\" /></a></li>\n</ul>','2015-10-02 19:30:44','2015-10-02 19:30:44',1),
	(39,'Em0120 - Area 17 - Promotion Banners','em0120_area17_promotion_banners','<ul>\n<li class=\"first\"><span class=\"promotion-icon\"></span><h3>Save an extra</h3><p>Reduce child mortality carbon right</p></li>\n<li><span class=\"promotion-icon\"></span><h3>Free ship all order</h3><p>Fundraising campaign, change, engage social worker</p></li>\n<li class=\"last\"><span class=\"promotion-icon\"></span><h3>25% off T-shirt</h3><p>Kickstater shifting landscape recognition</p></li>\n</ul>','2015-10-02 19:30:45','2015-10-02 19:30:45',1),
	(40,'Em0120 - Area 05 - Funiture Three Banners','em0120_area05_furniture_three_banners','<ul>\n<li class=\"first\"><a href=\"#\"><img class=\"img-responsive\" src=\"{{skin url=\'images/media/banner04.jpg\'}}\" alt=\"\" /><span><span>Nice sofe</span><span>Wood touched by light</span></span></a>\n<div class=\"mask\">&nbsp;</div>\n</li>\n<li><a href=\"#\"><img class=\"img-responsive\" src=\"{{skin url=\'images/media/banner05.jpg\'}}\" alt=\"\" /><span><span>Woody furni</span><span>Bring the comfort of your house</span></span></a>\n<div class=\"mask\">&nbsp;</div>\n</li>\n<li class=\"last\"><a href=\"#\"><img class=\"img-responsive\" src=\"{{skin url=\'images/media/banner06.jpg\'}}\" alt=\"\" /><span><span>Office</span><span>Panel collection infused</span></span></a>\n<div class=\"mask\">&nbsp;</div>\n</li>\n</ul>','2015-10-02 19:30:46','2015-10-02 19:30:46',1),
	(41,'Em0120 - Area 06 - Furniture Banner Shipping','em0120_area06_furniture_banner_shipping','<p><span class=\"icon slide\">icon</span></p>\n<h3>FREE SHIPPING ON ALL ORDERS</h3>\n<p>free over $125 for international orders</p>\n','2015-10-02 19:30:48','2015-10-02 19:30:48',1);

/*!40000 ALTER TABLE `cms_block` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table cms_block_store
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cms_block_store`;

CREATE TABLE `cms_block_store` (
  `block_id` smallint(6) NOT NULL COMMENT 'Block ID',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store ID',
  PRIMARY KEY (`block_id`,`store_id`),
  KEY `IDX_CMS_BLOCK_STORE_STORE_ID` (`store_id`),
  CONSTRAINT `FK_CMS_BLOCK_STORE_BLOCK_ID_CMS_BLOCK_BLOCK_ID` FOREIGN KEY (`block_id`) REFERENCES `cms_block` (`block_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CMS_BLOCK_STORE_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS Block To Store Linkage Table';

LOCK TABLES `cms_block_store` WRITE;
/*!40000 ALTER TABLE `cms_block_store` DISABLE KEYS */;

INSERT INTO `cms_block_store` (`block_id`, `store_id`)
VALUES
	(1,0),
	(2,0),
	(3,0),
	(4,0),
	(5,0),
	(6,0),
	(7,0),
	(8,0),
	(9,0),
	(10,0),
	(11,0),
	(12,0),
	(13,0),
	(14,0),
	(15,0),
	(16,0),
	(17,0),
	(18,0),
	(19,0),
	(20,0),
	(21,0),
	(22,0),
	(23,0),
	(24,0),
	(25,0),
	(26,0),
	(27,0),
	(28,0),
	(29,0),
	(30,0),
	(31,0),
	(32,0),
	(33,0),
	(34,0),
	(35,0),
	(36,0),
	(37,0),
	(38,0),
	(39,0),
	(40,0),
	(41,0);

/*!40000 ALTER TABLE `cms_block_store` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table cms_page
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cms_page`;

CREATE TABLE `cms_page` (
  `page_id` smallint(6) NOT NULL AUTO_INCREMENT COMMENT 'Page ID',
  `title` varchar(255) DEFAULT NULL COMMENT 'Page Title',
  `root_template` varchar(255) DEFAULT NULL COMMENT 'Page Template',
  `meta_keywords` text COMMENT 'Page Meta Keywords',
  `meta_description` text COMMENT 'Page Meta Description',
  `identifier` varchar(100) DEFAULT NULL COMMENT 'Page String Identifier',
  `content_heading` varchar(255) DEFAULT NULL COMMENT 'Page Content Heading',
  `content` mediumtext COMMENT 'Page Content',
  `creation_time` timestamp NULL DEFAULT NULL COMMENT 'Page Creation Time',
  `update_time` timestamp NULL DEFAULT NULL COMMENT 'Page Modification Time',
  `is_active` smallint(6) NOT NULL DEFAULT '1' COMMENT 'Is Page Active',
  `sort_order` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Page Sort Order',
  `layout_update_xml` text COMMENT 'Page Layout Update Content',
  `custom_theme` varchar(100) DEFAULT NULL COMMENT 'Page Custom Theme',
  `custom_root_template` varchar(255) DEFAULT NULL COMMENT 'Page Custom Template',
  `custom_layout_update_xml` text COMMENT 'Page Custom Layout Update Content',
  `custom_theme_from` date DEFAULT NULL COMMENT 'Page Custom Theme Active From Date',
  `custom_theme_to` date DEFAULT NULL COMMENT 'Page Custom Theme Active To Date',
  PRIMARY KEY (`page_id`),
  KEY `IDX_CMS_PAGE_IDENTIFIER` (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS Page Table';

LOCK TABLES `cms_page` WRITE;
/*!40000 ALTER TABLE `cms_page` DISABLE KEYS */;

INSERT INTO `cms_page` (`page_id`, `title`, `root_template`, `meta_keywords`, `meta_description`, `identifier`, `content_heading`, `content`, `creation_time`, `update_time`, `is_active`, `sort_order`, `layout_update_xml`, `custom_theme`, `custom_root_template`, `custom_layout_update_xml`, `custom_theme_from`, `custom_theme_to`)
VALUES
	(1,'404 Not Found 1','two_columns_right','Page keywords','Page description','no-route',NULL,'\n<div class=\"page-title\"><h1>Whoops, our bad...</h1></div>\n<dl>\n    <dt>The page you requested was not found, and we have a fine guess why.</dt>\n    <dd>\n        <ul class=\"disc\">\n            <li>If you typed the URL directly, please make sure the spelling is correct.</li>\n            <li>If you clicked on a link to get here, the link is outdated.</li>\n        </ul>\n    </dd>\n</dl>\n<dl>\n    <dt>What can you do?</dt>\n    <dd>Have no fear, help is near! There are many ways you can get back on track with Magento Store.</dd>\n    <dd>\n        <ul class=\"disc\">\n            <li><a href=\"#\" onclick=\"history.go(-1); return false;\">Go back</a> to the previous page.</li>\n            <li>Use the search bar at the top of the page to search for your products.</li>\n            <li>Follow these links to get you back on track!<br /><a href=\"{{store url=\"\"}}\">Store Home</a>\n            <span class=\"separator\">|</span> <a href=\"{{store url=\"customer/account\"}}\">My Account</a></li>\n        </ul>\n    </dd>\n</dl>\n','2015-10-02 19:23:32','2015-10-02 19:23:32',1,0,NULL,NULL,NULL,NULL,NULL,NULL),
	(2,'Home page','two_columns_right',NULL,NULL,'home',NULL,'<div class=\"page-title\"><h2>Home Page</h2></div>','2015-10-02 19:23:33','2015-10-02 19:24:41',1,0,'<!--<reference name=\"content\">\n        <block type=\"catalog/product_new\" name=\"home.catalog.product.new\" alias=\"product_new\" template=\"catalog/product/new.phtml\" after=\"cms_page\">\n            <action method=\"addPriceBlockType\">\n                <type>bundle</type>\n                <block>bundle/catalog_product_price</block>\n                <template>bundle/catalog/product/price.phtml</template>\n            </action>\n        </block>\n        <block type=\"reports/product_viewed\" name=\"home.reports.product.viewed\" alias=\"product_viewed\" template=\"reports/home_product_viewed.phtml\" after=\"product_new\">\n            <action method=\"addPriceBlockType\">\n                <type>bundle</type>\n                <block>bundle/catalog_product_price</block>\n                <template>bundle/catalog/product/price.phtml</template>\n            </action>\n        </block>\n        <block type=\"reports/product_compared\" name=\"home.reports.product.compared\" template=\"reports/home_product_compared.phtml\" after=\"product_viewed\">\n            <action method=\"addPriceBlockType\">\n                <type>bundle</type>\n                <block>bundle/catalog_product_price</block>\n                <template>bundle/catalog/product/price.phtml</template>\n            </action>\n        </block>\n    </reference>\n    <reference name=\"right\">\n        <action method=\"unsetChild\"><alias>right.reports.product.viewed</alias></action>\n        <action method=\"unsetChild\"><alias>right.reports.product.compared</alias></action>\n    </reference>-->',NULL,NULL,NULL,NULL,NULL),
	(3,'About Us','two_columns_right',NULL,NULL,'about-magento-demo-store',NULL,'\n<div class=\"page-title\">\n    <h1>About Magento Store</h1>\n</div>\n<div class=\"col3-set\">\n<div class=\"col-1\"><p style=\"line-height:1.2em;\"><small>Lorem ipsum dolor sit amet, consectetuer adipiscing elit.\nMorbi luctus. Duis lobortis. Nulla nec velit. Mauris pulvinar erat non massa. Suspendisse tortor turpis, porta nec,\ntempus vitae, iaculis semper, pede.</small></p>\n<p style=\"color:#888; font:1.2em/1.4em georgia, serif;\">Lorem ipsum dolor sit amet, consectetuer adipiscing elit.\nMorbi luctus. Duis lobortis. Nulla nec velit. Mauris pulvinar erat non massa. Suspendisse tortor turpis,\nporta nec, tempus vitae, iaculis semper, pede. Cras vel libero id lectus rhoncus porta.</p></div>\n<div class=\"col-2\">\n<p><strong style=\"color:#de036f;\">Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Morbi luctus.\nDuis lobortis. Nulla nec velit.</strong></p>\n<p>Vivamus tortor nisl, lobortis in, faucibus et, tempus at, dui. Nunc risus. Proin scelerisque augue. Nam ullamcorper.\nPhasellus id massa. Pellentesque nisl. Pellentesque habitant morbi tristique senectus et netus et malesuada\nfames ac turpis egestas. Nunc augue. Aenean sed justo non leo vehicula laoreet. Praesent ipsum libero, auctor ac,\ntempus nec, tempor nec, justo. </p>\n<p>Maecenas ullamcorper, odio vel tempus egestas, dui orci faucibus orci, sit amet aliquet lectus dolor et quam.\nPellentesque consequat luctus purus. Nunc et risus. Etiam a nibh. Phasellus dignissim metus eget nisi.\nVestibulum sapien dolor, aliquet nec, porta ac, malesuada a, libero. Praesent feugiat purus eget est.\nNulla facilisi. Vestibulum tincidunt sapien eu velit. Mauris purus. Maecenas eget mauris eu orci accumsan feugiat.\nPellentesque eget velit. Nunc tincidunt.</p></div>\n<div class=\"col-3\">\n<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Morbi luctus. Duis lobortis. Nulla nec velit.\nMauris pulvinar erat non massa. Suspendisse tortor turpis, porta nec, tempus vitae, iaculis semper, pede.\nCras vel libero id lectus rhoncus porta. Suspendisse convallis felis ac enim. Vivamus tortor nisl, lobortis in,\nfaucibus et, tempus at, dui. Nunc risus. Proin scelerisque augue. Nam ullamcorper </p>\n<p><strong style=\"color:#de036f;\">Maecenas ullamcorper, odio vel tempus egestas, dui orci faucibus orci,\nsit amet aliquet lectus dolor et quam. Pellentesque consequat luctus purus.</strong></p>\n<p>Nunc et risus. Etiam a nibh. Phasellus dignissim metus eget nisi.</p>\n<div class=\"divider\"></div>\n<p>To all of you, from all of us at Magento Store - Thank you and Happy eCommerce!</p>\n<p style=\"line-height:1.2em;\"><strong style=\"font:italic 2em Georgia, serif;\">John Doe</strong><br />\n<small>Some important guy</small></p></div>\n</div>','2015-10-02 19:23:34','2015-10-02 19:23:34',1,0,NULL,NULL,NULL,NULL,NULL,NULL),
	(4,'Customer Service','three_columns',NULL,NULL,'customer-service',NULL,'<div class=\"page-title\">\n<h1>Customer Service</h1>\n</div>\n<ul class=\"disc\">\n<li><a href=\"#answer1\">Shipping &amp; Delivery</a></li>\n<li><a href=\"#answer2\">Privacy &amp; Security</a></li>\n<li><a href=\"#answer3\">Returns &amp; Replacements</a></li>\n<li><a href=\"#answer4\">Ordering</a></li>\n<li><a href=\"#answer5\">Payment, Pricing &amp; Promotions</a></li>\n<li><a href=\"#answer6\">Viewing Orders</a></li>\n<li><a href=\"#answer7\">Updating Account Information</a></li>\n</ul>\n<dl>\n<dt id=\"answer1\">Shipping &amp; Delivery</dt>\n<dd>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Morbi luctus. Duis lobortis. Nulla nec velit.\nMauris pulvinar erat non massa. Suspendisse tortor turpis, porta nec, tempus vitae, iaculis semper, pede.\nCras vel libero id lectus rhoncus porta. Suspendisse convallis felis ac enim. Vivamus tortor nisl, lobortis in,\nfaucibus et, tempus at, dui. Nunc risus. Proin scelerisque augue. Nam ullamcorper. Phasellus id massa.\nPellentesque nisl. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.\nNunc augue. Aenean sed justo non leo vehicula laoreet. Praesent ipsum libero, auctor ac, tempus nec, tempor nec,\njusto.</dd>\n<dt id=\"answer2\">Privacy &amp; Security</dt>\n<dd>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Morbi luctus. Duis lobortis. Nulla nec velit.\nMauris pulvinar erat non massa. Suspendisse tortor turpis, porta nec, tempus vitae, iaculis semper, pede.\nCras vel libero id lectus rhoncus porta. Suspendisse convallis felis ac enim. Vivamus tortor nisl, lobortis in,\nfaucibus et, tempus at, dui. Nunc risus. Proin scelerisque augue. Nam ullamcorper. Phasellus id massa.\nPellentesque nisl. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.\nNunc augue. Aenean sed justo non leo vehicula laoreet. Praesent ipsum libero, auctor ac, tempus nec, tempor nec,\njusto.</dd>\n<dt id=\"answer3\">Returns &amp; Replacements</dt>\n<dd>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Morbi luctus. Duis lobortis. Nulla nec velit.\nMauris pulvinar erat non massa. Suspendisse tortor turpis, porta nec, tempus vitae, iaculis semper, pede.\nCras vel libero id lectus rhoncus porta. Suspendisse convallis felis ac enim. Vivamus tortor nisl, lobortis in,\nfaucibus et, tempus at, dui. Nunc risus. Proin scelerisque augue. Nam ullamcorper. Phasellus id massa.\nPellentesque nisl. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.\nNunc augue. Aenean sed justo non leo vehicula laoreet. Praesent ipsum libero, auctor ac, tempus nec, tempor nec,\njusto.</dd>\n<dt id=\"answer4\">Ordering</dt>\n<dd>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Morbi luctus. Duis lobortis. Nulla nec velit.\nMauris pulvinar erat non massa. Suspendisse tortor turpis, porta nec, tempus vitae, iaculis semper, pede.\nCras vel libero id lectus rhoncus porta. Suspendisse convallis felis ac enim. Vivamus tortor nisl, lobortis in,\nfaucibus et, tempus at, dui. Nunc risus. Proin scelerisque augue. Nam ullamcorper. Phasellus id massa.\nPellentesque nisl. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.\nNunc augue. Aenean sed justo non leo vehicula laoreet. Praesent ipsum libero, auctor ac, tempus nec, tempor nec,\njusto.</dd>\n<dt id=\"answer5\">Payment, Pricing &amp; Promotions</dt>\n<dd>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Morbi luctus. Duis lobortis. Nulla nec velit.\nMauris pulvinar erat non massa. Suspendisse tortor turpis, porta nec, tempus vitae, iaculis semper, pede.\nCras vel libero id lectus rhoncus porta. Suspendisse convallis felis ac enim. Vivamus tortor nisl, lobortis in,\nfaucibus et, tempus at, dui. Nunc risus. Proin scelerisque augue. Nam ullamcorper. Phasellus id massa.\nPellentesque nisl. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.\nNunc augue. Aenean sed justo non leo vehicula laoreet. Praesent ipsum libero, auctor ac, tempus nec, tempor nec,\njusto.</dd>\n<dt id=\"answer6\">Viewing Orders</dt>\n<dd>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Morbi luctus. Duis lobortis. Nulla nec velit.\nMauris pulvinar erat non massa. Suspendisse tortor turpis, porta nec, tempus vitae, iaculis semper, pede.\nCras vel libero id lectus rhoncus porta. Suspendisse convallis felis ac enim. Vivamus tortor nisl, lobortis in,\nfaucibus et, tempus at, dui. Nunc risus. Proin scelerisque augue. Nam ullamcorper. Phasellus id massa.\n Pellentesque nisl. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.\n Nunc augue. Aenean sed justo non leo vehicula laoreet. Praesent ipsum libero, auctor ac, tempus nec, tempor nec,\n justo.</dd>\n<dt id=\"answer7\">Updating Account Information</dt>\n<dd>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Morbi luctus. Duis lobortis. Nulla nec velit.\n Mauris pulvinar erat non massa. Suspendisse tortor turpis, porta nec, tempus vitae, iaculis semper, pede.\n Cras vel libero id lectus rhoncus porta. Suspendisse convallis felis ac enim. Vivamus tortor nisl, lobortis in,\n faucibus et, tempus at, dui. Nunc risus. Proin scelerisque augue. Nam ullamcorper. Phasellus id massa.\n Pellentesque nisl. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.\n Nunc augue. Aenean sed justo non leo vehicula laoreet. Praesent ipsum libero, auctor ac, tempus nec, tempor nec,\n justo.</dd>\n</dl>','2015-10-02 19:23:35','2015-10-02 19:23:35',1,0,NULL,NULL,NULL,NULL,NULL,NULL),
	(5,'Enable Cookies','one_column',NULL,NULL,'enable-cookies',NULL,'<div class=\"std\">\n    <ul class=\"messages\">\n        <li class=\"notice-msg\">\n            <ul>\n                <li>Please enable cookies in your web browser to continue.</li>\n            </ul>\n        </li>\n    </ul>\n    <div class=\"page-title\">\n        <h1><a name=\"top\"></a>What are Cookies?</h1>\n    </div>\n    <p>Cookies are short pieces of data that are sent to your computer when you visit a website.\n    On later visits, this data is then returned to that website. Cookies allow us to recognize you automatically\n    whenever you visit our site so that we can personalize your experience and provide you with better service.\n    We also use cookies (and similar browser data, such as Flash cookies) for fraud prevention and other purposes.\n     If your web browser is set to refuse cookies from our website, you will not be able to complete a purchase\n     or take advantage of certain features of our website, such as storing items in your Shopping Cart or\n     receiving personalized recommendations. As a result, we strongly encourage you to configure your web\n     browser to accept cookies from our website.</p>\n    <h2 class=\"subtitle\">Enabling Cookies</h2>\n    <ul class=\"disc\">\n        <li><a href=\"#ie7\">Internet Explorer 7.x</a></li>\n        <li><a href=\"#ie6\">Internet Explorer 6.x</a></li>\n        <li><a href=\"#firefox\">Mozilla/Firefox</a></li>\n        <li><a href=\"#opera\">Opera 7.x</a></li>\n    </ul>\n    <h3><a name=\"ie7\"></a>Internet Explorer 7.x</h3>\n    <ol>\n        <li>\n            <p>Start Internet Explorer</p>\n        </li>\n        <li>\n            <p>Under the <strong>Tools</strong> menu, click <strong>Internet Options</strong></p>\n            <p><img src=\"{{skin url=\"images/cookies/ie7-1.gif\"}}\" alt=\"\" /></p>\n        </li>\n        <li>\n            <p>Click the <strong>Privacy</strong> tab</p>\n            <p><img src=\"{{skin url=\"images/cookies/ie7-2.gif\"}}\" alt=\"\" /></p>\n        </li>\n        <li>\n            <p>Click the <strong>Advanced</strong> button</p>\n            <p><img src=\"{{skin url=\"images/cookies/ie7-3.gif\"}}\" alt=\"\" /></p>\n        </li>\n        <li>\n            <p>Put a check mark in the box for <strong>Override Automatic Cookie Handling</strong>,\n            put another check mark in the <strong>Always accept session cookies </strong>box</p>\n            <p><img src=\"{{skin url=\"images/cookies/ie7-4.gif\"}}\" alt=\"\" /></p>\n        </li>\n        <li>\n            <p>Click <strong>OK</strong></p>\n            <p><img src=\"{{skin url=\"images/cookies/ie7-5.gif\"}}\" alt=\"\" /></p>\n        </li>\n        <li>\n            <p>Click <strong>OK</strong></p>\n            <p><img src=\"{{skin url=\"images/cookies/ie7-6.gif\"}}\" alt=\"\" /></p>\n        </li>\n        <li>\n            <p>Restart Internet Explore</p>\n        </li>\n    </ol>\n    <p class=\"a-top\"><a href=\"#top\">Back to Top</a></p>\n    <h3><a name=\"ie6\"></a>Internet Explorer 6.x</h3>\n    <ol>\n        <li>\n            <p>Select <strong>Internet Options</strong> from the Tools menu</p>\n            <p><img src=\"{{skin url=\"images/cookies/ie6-1.gif\"}}\" alt=\"\" /></p>\n        </li>\n        <li>\n            <p>Click on the <strong>Privacy</strong> tab</p>\n        </li>\n        <li>\n            <p>Click the <strong>Default</strong> button (or manually slide the bar down to <strong>Medium</strong>)\n            under <strong>Settings</strong>. Click <strong>OK</strong></p>\n            <p><img src=\"{{skin url=\"images/cookies/ie6-2.gif\"}}\" alt=\"\" /></p>\n        </li>\n    </ol>\n    <p class=\"a-top\"><a href=\"#top\">Back to Top</a></p>\n    <h3><a name=\"firefox\"></a>Mozilla/Firefox</h3>\n    <ol>\n        <li>\n            <p>Click on the <strong>Tools</strong>-menu in Mozilla</p>\n        </li>\n        <li>\n            <p>Click on the <strong>Options...</strong> item in the menu - a new window open</p>\n        </li>\n        <li>\n            <p>Click on the <strong>Privacy</strong> selection in the left part of the window. (See image below)</p>\n            <p><img src=\"{{skin url=\"images/cookies/firefox.png\"}}\" alt=\"\" /></p>\n        </li>\n        <li>\n            <p>Expand the <strong>Cookies</strong> section</p>\n        </li>\n        <li>\n            <p>Check the <strong>Enable cookies</strong> and <strong>Accept cookies normally</strong> checkboxes</p>\n        </li>\n        <li>\n            <p>Save changes by clicking <strong>Ok</strong>.</p>\n        </li>\n    </ol>\n    <p class=\"a-top\"><a href=\"#top\">Back to Top</a></p>\n    <h3><a name=\"opera\"></a>Opera 7.x</h3>\n    <ol>\n        <li>\n            <p>Click on the <strong>Tools</strong> menu in Opera</p>\n        </li>\n        <li>\n            <p>Click on the <strong>Preferences...</strong> item in the menu - a new window open</p>\n        </li>\n        <li>\n            <p>Click on the <strong>Privacy</strong> selection near the bottom left of the window. (See image below)</p>\n            <p><img src=\"{{skin url=\"images/cookies/opera.png\"}}\" alt=\"\" /></p>\n        </li>\n        <li>\n            <p>The <strong>Enable cookies</strong> checkbox must be checked, and <strong>Accept all cookies</strong>\n            should be selected in the &quot;<strong>Normal cookies</strong>&quot; drop-down</p>\n        </li>\n        <li>\n            <p>Save changes by clicking <strong>Ok</strong></p>\n        </li>\n    </ol>\n    <p class=\"a-top\"><a href=\"#top\">Back to Top</a></p>\n</div>\n','2015-10-02 19:23:36','2015-10-02 19:23:36',1,0,NULL,NULL,NULL,NULL,NULL,NULL),
	(6,'Privacy Policy','one_column',NULL,NULL,'privacy-policy-cookie-restriction-mode','Privacy Policy','<p style=\"color: #ff0000; font-weight: bold; font-size: 13px\">\n    Please replace this text with you Privacy Policy.\n    Please add any additional cookies your website uses below (e.g., Google Analytics)\n</p>\n<p>\n    This privacy policy sets out how {{config path=\"general/store_information/name\"}} uses and protects any information\n    that you give {{config path=\"general/store_information/name\"}} when you use this website.\n    {{config path=\"general/store_information/name\"}} is committed to ensuring that your privacy is protected.\n    Should we ask you to provide certain information by which you can be identified when using this website,\n    then you can be assured that it will only be used in accordance with this privacy statement.\n    {{config path=\"general/store_information/name\"}} may change this policy from time to time by updating this page.\n    You should check this page from time to time to ensure that you are happy with any changes.\n</p>\n<h2>What we collect</h2>\n<p>We may collect the following information:</p>\n<ul>\n    <li>name</li>\n    <li>contact information including email address</li>\n    <li>demographic information such as postcode, preferences and interests</li>\n    <li>other information relevant to customer surveys and/or offers</li>\n</ul>\n<p>\n    For the exhaustive list of cookies we collect see the <a href=\"#list\">List of cookies we collect</a> section.\n</p>\n<h2>What we do with the information we gather</h2>\n<p>\n    We require this information to understand your needs and provide you with a better service,\n    and in particular for the following reasons:\n</p>\n<ul>\n    <li>Internal record keeping.</li>\n    <li>We may use the information to improve our products and services.</li>\n    <li>\n        We may periodically send promotional emails about new products, special offers or other information which we\n        think you may find interesting using the email address which you have provided.\n    </li>\n    <li>\n        From time to time, we may also use your information to contact you for market research purposes.\n        We may contact you by email, phone, fax or mail. We may use the information to customise the website\n        according to your interests.\n    </li>\n</ul>\n<h2>Security</h2>\n<p>\n    We are committed to ensuring that your information is secure. In order to prevent unauthorised access or disclosure,\n    we have put in place suitable physical, electronic and managerial procedures to safeguard and secure\n    the information we collect online.\n</p>\n<h2>How we use cookies</h2>\n<p>\n    A cookie is a small file which asks permission to be placed on your computer\'s hard drive.\n    Once you agree, the file is added and the cookie helps analyse web traffic or lets you know when you visit\n    a particular site. Cookies allow web applications to respond to you as an individual. The web application\n    can tailor its operations to your needs, likes and dislikes by gathering and remembering information about\n    your preferences.\n</p>\n<p>\n    We use traffic log cookies to identify which pages are being used. This helps us analyse data about web page traffic\n    and improve our website in order to tailor it to customer needs. We only use this information for statistical\n    analysis purposes and then the data is removed from the system.\n</p>\n<p>\n    Overall, cookies help us provide you with a better website, by enabling us to monitor which pages you find useful\n    and which you do not. A cookie in no way gives us access to your computer or any information about you,\n    other than the data you choose to share with us. You can choose to accept or decline cookies.\n    Most web browsers automatically accept cookies, but you can usually modify your browser setting\n    to decline cookies if you prefer. This may prevent you from taking full advantage of the website.\n</p>\n<h2>Links to other websites</h2>\n<p>\n    Our website may contain links to other websites of interest. However, once you have used these links\n    to leave our site, you should note that we do not have any control over that other website.\n    Therefore, we cannot be responsible for the protection and privacy of any information which you provide whilst\n    visiting such sites and such sites are not governed by this privacy statement.\n    You should exercise caution and look at the privacy statement applicable to the website in question.\n</p>\n<h2>Controlling your personal information</h2>\n<p>You may choose to restrict the collection or use of your personal information in the following ways:</p>\n<ul>\n    <li>\n        whenever you are asked to fill in a form on the website, look for the box that you can click to indicate\n        that you do not want the information to be used by anybody for direct marketing purposes\n    </li>\n    <li>\n        if you have previously agreed to us using your personal information for direct marketing purposes,\n        you may change your mind at any time by writing to or emailing us at\n        {{config path=\"trans_email/ident_general/email\"}}\n    </li>\n</ul>\n<p>\n    We will not sell, distribute or lease your personal information to third parties unless we have your permission\n    or are required by law to do so. We may use your personal information to send you promotional information\n    about third parties which we think you may find interesting if you tell us that you wish this to happen.\n</p>\n<p>\n    You may request details of personal information which we hold about you under the Data Protection Act 1998.\n    A small fee will be payable. If you would like a copy of the information held on you please write to\n    {{config path=\"general/store_information/address\"}}.\n</p>\n<p>\n    If you believe that any information we are holding on you is incorrect or incomplete,\n    please write to or email us as soon as possible, at the above address.\n    We will promptly correct any information found to be incorrect.\n</p>\n<h2><a name=\"list\"></a>List of cookies we collect</h2>\n<p>The table below lists the cookies we collect and what information they store.</p>\n<table class=\"data-table\">\n    <thead>\n        <tr>\n            <th>COOKIE name</th>\n            <th>COOKIE Description</th>\n        </tr>\n    </thead>\n    <tbody>\n        <tr>\n            <th>CART</th>\n            <td>The association with your shopping cart.</td>\n        </tr>\n        <tr>\n            <th>CATEGORY_INFO</th>\n            <td>Stores the category info on the page, that allows to display pages more quickly.</td>\n        </tr>\n        <tr>\n            <th>COMPARE</th>\n            <td>The items that you have in the Compare Products list.</td>\n        </tr>\n        <tr>\n            <th>CURRENCY</th>\n            <td>Your preferred currency</td>\n        </tr>\n        <tr>\n            <th>CUSTOMER</th>\n            <td>An encrypted version of your customer id with the store.</td>\n        </tr>\n        <tr>\n            <th>CUSTOMER_AUTH</th>\n            <td>An indicator if you are currently logged into the store.</td>\n        </tr>\n        <tr>\n            <th>CUSTOMER_INFO</th>\n            <td>An encrypted version of the customer group you belong to.</td>\n        </tr>\n        <tr>\n            <th>CUSTOMER_SEGMENT_IDS</th>\n            <td>Stores the Customer Segment ID</td>\n        </tr>\n        <tr>\n            <th>EXTERNAL_NO_CACHE</th>\n            <td>A flag, which indicates whether caching is disabled or not.</td>\n        </tr>\n        <tr>\n            <th>FRONTEND</th>\n            <td>You sesssion ID on the server.</td>\n        </tr>\n        <tr>\n            <th>GUEST-VIEW</th>\n            <td>Allows guests to edit their orders.</td>\n        </tr>\n        <tr>\n            <th>LAST_CATEGORY</th>\n            <td>The last category you visited.</td>\n        </tr>\n        <tr>\n            <th>LAST_PRODUCT</th>\n            <td>The most recent product you have viewed.</td>\n        </tr>\n        <tr>\n            <th>NEWMESSAGE</th>\n            <td>Indicates whether a new message has been received.</td>\n        </tr>\n        <tr>\n            <th>NO_CACHE</th>\n            <td>Indicates whether it is allowed to use cache.</td>\n        </tr>\n        <tr>\n            <th>PERSISTENT_SHOPPING_CART</th>\n            <td>A link to information about your cart and viewing history if you have asked the site.</td>\n        </tr>\n        <tr>\n            <th>POLL</th>\n            <td>The ID of any polls you have recently voted in.</td>\n        </tr>\n        <tr>\n            <th>POLLN</th>\n            <td>Information on what polls you have voted on.</td>\n        </tr>\n        <tr>\n            <th>RECENTLYCOMPARED</th>\n            <td>The items that you have recently compared.            </td>\n        </tr>\n        <tr>\n            <th>STF</th>\n            <td>Information on products you have emailed to friends.</td>\n        </tr>\n        <tr>\n            <th>STORE</th>\n            <td>The store view or language you have selected.</td>\n        </tr>\n        <tr>\n            <th>USER_ALLOWED_SAVE_COOKIE</th>\n            <td>Indicates whether a customer allowed to use cookies.</td>\n        </tr>\n        <tr>\n            <th>VIEWED_PRODUCT_IDS</th>\n            <td>The products that you have recently viewed.</td>\n        </tr>\n        <tr>\n            <th>WISHLIST</th>\n            <td>An encrypted list of products added to your Wishlist.</td>\n        </tr>\n        <tr>\n            <th>WISHLIST_CNT</th>\n            <td>The number of items in your Wishlist.</td>\n        </tr>\n    </tbody>\n</table>','2015-10-02 19:23:38','2015-10-02 19:23:38',1,0,NULL,NULL,NULL,NULL,NULL,NULL),
	(7,'Em0120 Adore Magento Theme - Homepage','one_column',NULL,NULL,'em0120_home',NULL,'<!-- empty -->','2015-10-02 19:30:49','2015-10-02 19:30:49',1,0,NULL,NULL,NULL,NULL,NULL,NULL),
	(8,'Em0120 Typography','one_column',NULL,NULL,'em0120_typography',NULL,'<div class=\"box\">\n<h2>General Elements</h2>\n<h1>Heading 1</h1>\n<h2>Heading 2</h2>\n<h3>Heading 3</h3>\n<h4>Heading 4</h4>\n<h5>Heading 5</h5>\n<ul>\n<li>Bullet List 1</li>\n<ul>\n<li>Bullet List 1.1</li>\n<li>Bullet List 1.2</li>\n<li>Bullet List 1.3</li>\n<li>Bullet List 1.4</li>\n</ul>\n<li>Bullet List 2</li>\n<li>Bullet List 3</li>\n<li>Bullet List 4</li>\n</ul>\n<ol>\n<li>Number List 1</li>\n<ol>\n<li>Number List 1.1</li>\n<li>Number List 1.2</li>\n<li>Number List 1.3</li>\n<li>Number List 1.4</li>\n</ol>\n<li>Number List 2</li>\n<li>Number List 3</li>\n<li>Number List 4</li>\n</ol><dl><dt>Definition title dt</dt><dd>Defination description dd</dd><dt>Definition title dt</dt><dd>Defination description dd</dd></dl>\n<p><code>Code tag:&nbsp;Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</code></p>\n<blockquote>\n<p>block quote&nbsp;Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>\n</blockquote>\n<div class=\"box f-left\">element with class <strong>.f-left</strong></div>\n<div class=\"box f-right\">element with class <strong>.f-right</strong></div>\n<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.&nbsp;Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.&nbsp;Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>\n<h2>Tables</h2>\n<p>Table with class <strong>.data-table</strong></p>\n<table class=\"data-table\" style=\"width: 100%;\" border=\"0\"><colgroup><col /> <col /> <col /> <col /> <col /></colgroup>\n<thead>\n<tr><th>THEAD TH</th><th>THEAD TH</th><th>THEAD TH</th><th>THEAD TH</th><th>THEAD TH</th></tr>\n</thead>\n<tbody>\n<tr>\n<td>TBODY TD</td>\n<td>TBODY TD</td>\n<td>TBODY TD</td>\n<td>TBODY TD</td>\n<td class=\"last\">TBODY TD</td>\n</tr>\n<tr>\n<td>TBODY TD</td>\n<td>TBODY TD</td>\n<td>TBODY TD</td>\n<td>TBODY TD</td>\n<td class=\"last\">TBODY TD</td>\n</tr>\n<tr>\n<td>TBODY TD</td>\n<td>TBODY TD</td>\n<td>TBODY TD</td>\n<td>TBODY TD</td>\n<td class=\"last\">TBODY TD</td>\n</tr>\n</tbody>\n</table>\n<br />\n<h2>Custom CSS Classes</h2>\n<p class=\"small\">tag <strong>small</strong> and class <strong>.small</strong></p>\n<p class=\"underline\">element with class <strong>.underline</strong></p>\n<p><strong>ul.none</strong> and <strong>ol.none</strong>:</p>\n<ul class=\"none\">\n<li>Bullet List 1</li>\n<ul>\n<li>Bullet List 1.1</li>\n<li>Bullet List 1.2</li>\n<li>Bullet List 1.3</li>\n<li>Bullet List 1.4</li>\n</ul>\n<li>Bullet List 2</li>\n<li>Bullet List 3</li>\n<li>Bullet List 4</li>\n</ul>\n<p><strong>ul.hoz</strong> and <strong>ol.hoz</strong>:</p>\n<ul class=\"hoz\">\n<li>Bullet List 1</li>\n<li>Bullet List 2</li>\n<li>Bullet List 3</li>\n<li>Bullet List 4</li>\n</ul>\n<div class=\"box\">\n<p>paragraph with class <strong>.box</strong>:</p>\n<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>\n</div>\n<p class=\"bottom\">Paragraph with class <strong>.bottom</strong> always has margin-bottom = 0.</p>\n<p>Add class <strong>.hide-lte2</strong> to hide element when screen\'s width less than 1280px.</p>\n<p class=\"box hide-lte2\">This block will disappear when resize window less than 1280px</p>\n<p>Add class <strong>.hide-lte1</strong> to hide element when screen\'s width less than 980px.</p>\n<p class=\"box hide-lte1\">This block will disappear when resize window less than 980px</p>\n<p>Add class <strong>.hide-lte0</strong> to hide element when screen\'s width less than 760px.</p>\n<p class=\"box hide-lte0\">This block will disappear when resize window less than 760px</p>\n<h2>Icons</h2>\n<table class=\"data-table dticon\" style=\"background: #cccccc;\" border=\"0\">\n<tbody>\n<tr>\n<td align=\"center\" valign=\"top\">\n<p>.icon.my_account</p>\n<p><span class=\"icon my_account\">span.icon.my_account</span></p>\n</td>\n<td align=\"center\" valign=\"top\">\n<p>.icon.my_wishlist</p>\n<p><span class=\"icon my_wishlist\">span.icon.my_wishlist</span></p>\n</td>\n<td align=\"center\" valign=\"top\">\n<p>.icon.log_in</p>\n<p><span class=\"icon log_in\">span.icon.log_in</span></p>\n</td>\n<td align=\"center\" valign=\"top\">\n<p>.icon.register</p>\n<p><span class=\"icon register\">span.icon.register</span></p>\n</td>\n<td align=\"center\" valign=\"top\">\n<p>.icon.cart</p>\n<p><span class=\"icon cart\"><span>span.icon.cart</span></span></p>\n</td>\n<td align=\"center\" valign=\"top\">\n<p>.icon.<span>facebook</span></p>\n<p><span class=\"icon facebook\"><span>a.icon.facebook</span>d</span></p>\n</td>\n<td align=\"center\" valign=\"top\">\n<p>.icon.pinterest</p>\n<p><span class=\"icon pinterest\">a.icon.pinterest</span></p>\n</td>\n<td align=\"center\" valign=\"top\">\n<p>.icon.twitter</p>\n<p><span class=\"icon twitter\">a.icon.twitter</span></p>\n</td>\n<td align=\"center\" valign=\"top\">\n<p>.icon.google</p>\n<p><span class=\"icon google\">a.icon.google</span></p>\n</td>\n<td align=\"center\" valign=\"top\">\n<p>.icon.rss</p>\n<p><span class=\"icon rss\">a.icon.rss</span></p>\n</td>\n<td align=\"center\" valign=\"top\">\n<p>.icon.vimeo</p>\n<p><span class=\"icon vimeo\">a.icon.vimeo</span></p>\n</td>\n</tr>\n</tbody>\n</table>\n<br />\n<h2>Logo</h2>\n<table class=\"data-table dtlogo\" border=\"0\">\n<tbody>\n<tr>\n<td align=\"center\" valign=\"top\">\n<p>.brand-logo.visa</p>\n<p><span class=\"brand-logo visa\">a.brand-logo.visa</span></p>\n</td>\n<td align=\"center\" valign=\"top\">\n<p>.brand-logo.master</p>\n<p><span class=\"brand-logo master\">a.brand-logo.master</span></p>\n</td>\n<td align=\"center\" valign=\"top\">\n<p>.brand-logo.express</p>\n<p><span class=\"brand-logo express\">a.brand-logo.express</span></p>\n</td>\n<td align=\"center\" valign=\"top\">\n<p>.brand-logo.paypal</p>\n<p><span class=\"brand-logo paypal\">a.brand-logo.paypal</span></p>\n</td>\n<td class=\"last\" align=\"center\" valign=\"top\">\n<p>.brand-logo.skrill</p>\n<p><span class=\"brand-logo skrill\">a.brand-logo.skrill</span></p>\n</td>\n</tr>\n</tbody>\n</table>\n<br />\n<p>image with class <strong>.fluid</strong>:</p>\n<p><img class=\"fluid\" title=\"image with class .fluid\" src=\"{{skin url=\"images/media/banner.jpg\"}}\" alt=\"image with class .fluid\" /></p>\n</div>','2015-10-02 19:30:50','2015-10-02 19:30:50',1,0,NULL,NULL,NULL,NULL,NULL,NULL),
	(9,'Em0120 Widgets','one_column',NULL,NULL,'em0120_widgets',NULL,'<h2>Demo EM Slideshow Widget</h2>\n<div class=\"row\">\n<div class=\"col-sm-24\">{{widget type=\"slideshow2/slideshow2\" slideshow=\"1\"}}<br /><hr /></div>\n</div>\n<div class=\"clear\">&nbsp;</div>\n<h2>Demo EM Featured Products Widget</h2>\n<div class=\"row\">\n<div class=\"col-sm-12 first\">\n<h3>Grid View</h3>\n<div>{{widget type=\"filterproducts/list\" type_filter=\"1\" featured=\"em_featured\" limit_count=\"6\" order_by=\"name asc\" item_height=\"435\" show=\"thumb,name,sku,desc,review,price,label,addtocart,addto\" thumbnail_width=\"150\" thumbnail_height=\"150\" choose_template=\"em_filterproducts/sample_grid.phtml\"}}</div>\n</div>\n<div class=\"col-sm-12 last\">\n<h3>Grid View with column count = 2</h3>\n<div>{{widget type=\"filterproducts/list\" type_filter=\"1\" featured=\"em_featured\" limit_count=\"4\" column_count=\"2\" order_by=\"name asc\" item_height=\"435\" show=\"thumb,name,sku,desc,review,price,label,addtocart,addto\" thumbnail_width=\"150\" thumbnail_height=\"150\" choose_template=\"em_filterproducts/sample_grid.phtml\"}}</div>\n</div>\n</div>\n<div class=\"clear\">&nbsp;</div>\n<hr />\n<div class=\"row\">\n<div class=\"col-sm-12 first\">\n<h3>List View</h3>\n<div>{{widget type=\"filterproducts/list\" type_filter=\"1\" featured=\"em_featured\" limit_count=\"4\" order_by=\"name asc\" show=\"thumb,name,sku,desc,review,price,label,addtocart,addto\" thumbnail_width=\"150\" thumbnail_height=\"150\" choose_template=\"em_filterproducts/sample_list.phtml\"}}</div>\n</div>\n<div class=\"col-sm-12 last\">\n<h3>List View with column count = 2</h3>\n<div>{{widget type=\"filterproducts/list\" type_filter=\"1\" featured=\"em_featured\" limit_count=\"4\" column_count=\"2\" order_by=\"name asc\" show=\"thumb,name,sku,desc,review,price,label,addtocart,addto\" thumbnail_width=\"150\" thumbnail_height=\"150\" choose_template=\"em_filterproducts/sample_list.phtml\"}}</div>\n</div>\n</div>\n<div class=\"clear\">&nbsp;</div>\n<hr />\n<h2>Demo EM Bestseller Products Widget</h2>\n<div class=\"row\">\n<div class=\"col-sm-12 first\">\n<h3>Grid View</h3>\n<div>{{widget type=\"filterproducts/list\" type_filter=\"2\" featured=\"em_featured\" limit_count=\"6\" order_by=\"name asc\" item_height=\"435\" show=\"thumb,name,sku,desc,review,price,label,addtocart,addto\" thumbnail_width=\"150\" thumbnail_height=\"150\" choose_template=\"em_filterproducts/sample_grid.phtml\"}}</div>\n</div>\n<div class=\"col-sm-12 last\">\n<h3>List View</h3>\n<div>{{widget type=\"filterproducts/list\" type_filter=\"2\" featured=\"em_featured\" limit_count=\"4\" order_by=\"name asc\" show=\"thumb,name,sku,desc,review,price,label,addtocart,addto\" thumbnail_width=\"150\" thumbnail_height=\"150\" choose_template=\"em_filterproducts/sample_list.phtml\"}}</div>\n</div>\n</div>\n<div class=\"clear\">&nbsp;</div>\n<hr />\n<h2>Demo EM New Products Widget</h2>\n<div class=\"row\">\n<div class=\"col-sm-12 first\">\n<h3>Grid View</h3>\n<div>{{widget type=\"filterproducts/list\" type_filter=\"3\" featured=\"em_featured\" limit_count=\"6\" order_by=\"name asc\" item_height=\"435\" show=\"thumb,name,sku,desc,review,price,label,addtocart,addto\" thumbnail_width=\"150\" thumbnail_height=\"150\" choose_template=\"em_filterproducts/sample_grid.phtml\"}}</div>\n</div>\n<div class=\"col-sm-12 last\">\n<h3>List View</h3>\n<div>{{widget type=\"filterproducts/list\" type_filter=\"3\" featured=\"em_featured\" limit_count=\"4\" order_by=\"name asc\" show=\"thumb,name,sku,desc,review,price,label,addtocart,addto\" thumbnail_width=\"150\" thumbnail_height=\"150\" choose_template=\"em_filterproducts/sample_list.phtml\"}}</div>\n</div>\n</div>\n<div class=\"clear\">&nbsp;</div>\n<hr />\n<h2>Demo EM Sale Products Widget</h2>\n<div class=\"row\">\n<div class=\"col-sm-12 first\">\n<h3>Grid View</h3>\n<div>{{widget type=\"filterproducts/list\" type_filter=\"4\" featured=\"em_featured\" limit_count=\"6\" order_by=\"name asc\" item_height=\"392\" show=\"thumb,name,sku,desc,review,price,label,addtocart,addto\" thumbnail_width=\"150\" thumbnail_height=\"150\" choose_template=\"em_filterproducts/sample_grid.phtml\"}}</div>\n</div>\n<div class=\"col-sm-12 last\">\n<h3>List View</h3>\n<div>{{widget type=\"filterproducts/list\" type_filter=\"4\" featured=\"em_featured\" limit_count=\"4\" order_by=\"name asc\" show=\"thumb,name,sku,desc,review,price,label,addtocart,addto\" thumbnail_width=\"150\" thumbnail_height=\"150\" choose_template=\"em_filterproducts/sample_list.phtml\"}}</div>\n</div>\n</div>\n<div class=\"clear\">&nbsp;</div>\n<hr />\n<h2>Demo EM Products Widget with Slider</h2>\n<div class=\"row\">\n<div class=\"col-sm-24 last\">\n<h3>Horizontal Sliding</h3>\n<div>{{widget type=\"filterproducts/list\" type_filter=\"1\" featured=\"em_featured\" limit_count=\"10\" order_by=\"name asc\" item_height=\"500\" show=\"thumb,name,sku,desc,review,price,label,addtocart,addto\" thumbnail_width=\"293\" thumbnail_height=\"309\" choose_template=\"em_filterproducts/sample_grid.phtml\" slider_enable=\"1\" slider_items=\"4\" slider_items_desktop=\"4\" slider_items_desktop_small=\"4\" slider_items_tablet=\"4\" slider_items_tablet_small=\"4\" slider_items_mobile=\"1\" slider_speed=\"200\" slider_rewindspeed=\"200\" slider_navigation=\"1\"}}</div>\n</div>\n</div>\n<hr />\n<h2>Demo EM Tabs Widget</h2>\n<div class=\"row\">\n<div class=\"col-sm-24\">{{widget type=\"tabs/group\" title_1=\"YTo0OntpOjA7czo1OiJUYWIgMSI7aToxO3M6MDoiIjtpOjM7czowOiIiO2k6MjtzOjA6IiI7fQ==\" block_1=\"6\" title_2=\"YTo0OntpOjA7czo1OiJUYWIgMiI7aToxO3M6MDoiIjtpOjM7czowOiIiO2k6MjtzOjA6IiI7fQ==\" block_2=\"5\" title_3=\"YTo0OntpOjA7czo1OiJUYWIgMyI7aToxO3M6MDoiIjtpOjM7czowOiIiO2k6MjtzOjA6IiI7fQ==\" block_3=\"6\" template=\"emtabs/group.phtml\"}}</div>\n</div>','2015-10-02 19:30:51','2015-10-02 19:30:51',1,0,NULL,NULL,NULL,NULL,NULL,NULL);

/*!40000 ALTER TABLE `cms_page` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table cms_page_store
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cms_page_store`;

CREATE TABLE `cms_page_store` (
  `page_id` smallint(6) NOT NULL COMMENT 'Page ID',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store ID',
  PRIMARY KEY (`page_id`,`store_id`),
  KEY `IDX_CMS_PAGE_STORE_STORE_ID` (`store_id`),
  CONSTRAINT `FK_CMS_PAGE_STORE_PAGE_ID_CMS_PAGE_PAGE_ID` FOREIGN KEY (`page_id`) REFERENCES `cms_page` (`page_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CMS_PAGE_STORE_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS Page To Store Linkage Table';

LOCK TABLES `cms_page_store` WRITE;
/*!40000 ALTER TABLE `cms_page_store` DISABLE KEYS */;

INSERT INTO `cms_page_store` (`page_id`, `store_id`)
VALUES
	(1,0),
	(2,0),
	(3,0),
	(4,0),
	(5,0),
	(6,0),
	(7,0),
	(8,0),
	(9,0);

/*!40000 ALTER TABLE `cms_page_store` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table core_cache
# ------------------------------------------------------------

DROP TABLE IF EXISTS `core_cache`;

CREATE TABLE `core_cache` (
  `id` varchar(200) NOT NULL COMMENT 'Cache Id',
  `data` mediumblob COMMENT 'Cache Data',
  `create_time` int(11) DEFAULT NULL COMMENT 'Cache Creation Time',
  `update_time` int(11) DEFAULT NULL COMMENT 'Time of Cache Updating',
  `expire_time` int(11) DEFAULT NULL COMMENT 'Cache Expiration Time',
  PRIMARY KEY (`id`),
  KEY `IDX_CORE_CACHE_EXPIRE_TIME` (`expire_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Caches';



# Dump of table core_cache_option
# ------------------------------------------------------------

DROP TABLE IF EXISTS `core_cache_option`;

CREATE TABLE `core_cache_option` (
  `code` varchar(32) NOT NULL COMMENT 'Code',
  `value` smallint(6) DEFAULT NULL COMMENT 'Value',
  PRIMARY KEY (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache Options';

LOCK TABLES `core_cache_option` WRITE;
/*!40000 ALTER TABLE `core_cache_option` DISABLE KEYS */;

INSERT INTO `core_cache_option` (`code`, `value`)
VALUES
	('block_html',0),
	('collections',0),
	('config',0),
	('config_api',0),
	('config_api2',0),
	('eav',0),
	('layout',0),
	('translate',0);

/*!40000 ALTER TABLE `core_cache_option` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table core_cache_tag
# ------------------------------------------------------------

DROP TABLE IF EXISTS `core_cache_tag`;

CREATE TABLE `core_cache_tag` (
  `tag` varchar(100) NOT NULL COMMENT 'Tag',
  `cache_id` varchar(200) NOT NULL COMMENT 'Cache Id',
  PRIMARY KEY (`tag`,`cache_id`),
  KEY `IDX_CORE_CACHE_TAG_CACHE_ID` (`cache_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tag Caches';



# Dump of table core_config_data
# ------------------------------------------------------------

DROP TABLE IF EXISTS `core_config_data`;

CREATE TABLE `core_config_data` (
  `config_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Config Id',
  `scope` varchar(8) NOT NULL DEFAULT 'default' COMMENT 'Config Scope',
  `scope_id` int(11) NOT NULL DEFAULT '0' COMMENT 'Config Scope Id',
  `path` varchar(255) NOT NULL DEFAULT 'general' COMMENT 'Config Path',
  `value` text COMMENT 'Config Value',
  PRIMARY KEY (`config_id`),
  UNIQUE KEY `UNQ_CORE_CONFIG_DATA_SCOPE_SCOPE_ID_PATH` (`scope`,`scope_id`,`path`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Config Data';

LOCK TABLES `core_config_data` WRITE;
/*!40000 ALTER TABLE `core_config_data` DISABLE KEYS */;

INSERT INTO `core_config_data` (`config_id`, `scope`, `scope_id`, `path`, `value`)
VALUES
	(1,'default',0,'general/region/display_all','1'),
	(2,'default',0,'general/region/state_required','AT,CA,CH,DE,EE,ES,FI,FR,LT,LV,RO,US'),
	(3,'default',0,'catalog/category/root_id','2'),
	(4,'default',0,'payment/paypal_express/skip_order_review_step','1'),
	(5,'default',0,'payment/payflow_link/mobile_optimized','1'),
	(6,'default',0,'payment/payflow_advanced/mobile_optimized','1'),
	(7,'default',0,'payment/hosted_pro/mobile_optimized','1'),
	(8,'default',0,'admin/dashboard/enable_charts','1'),
	(9,'default',0,'web/unsecure/base_url','http://luteste.ecommerce/'),
	(10,'default',0,'web/secure/base_url','http://luteste.ecommerce/'),
	(11,'default',0,'general/locale/code','pt_BR'),
	(12,'default',0,'general/locale/timezone','America/Sao_Paulo'),
	(13,'default',0,'currency/options/base','BRL'),
	(14,'default',0,'currency/options/default','BRL'),
	(15,'default',0,'currency/options/allow','BRL');

/*!40000 ALTER TABLE `core_config_data` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table core_email_queue
# ------------------------------------------------------------

DROP TABLE IF EXISTS `core_email_queue`;

CREATE TABLE `core_email_queue` (
  `message_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Message Id',
  `entity_id` int(10) unsigned DEFAULT NULL COMMENT 'Entity ID',
  `entity_type` varchar(128) DEFAULT NULL COMMENT 'Entity Type',
  `event_type` varchar(128) DEFAULT NULL COMMENT 'Event Type',
  `message_body_hash` varchar(64) NOT NULL COMMENT 'Message Body Hash',
  `message_body` mediumtext NOT NULL COMMENT 'Message Body',
  `message_parameters` text NOT NULL COMMENT 'Message Parameters',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Creation Time',
  `processed_at` timestamp NULL DEFAULT NULL COMMENT 'Finish Time',
  PRIMARY KEY (`message_id`),
  KEY `0ADECE62FD629241C147389ADF20706E` (`entity_id`,`entity_type`,`event_type`,`message_body_hash`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Email Queue';



# Dump of table core_email_queue_recipients
# ------------------------------------------------------------

DROP TABLE IF EXISTS `core_email_queue_recipients`;

CREATE TABLE `core_email_queue_recipients` (
  `recipient_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Recipient Id',
  `message_id` int(10) unsigned NOT NULL COMMENT 'Message ID',
  `recipient_email` varchar(128) NOT NULL COMMENT 'Recipient Email',
  `recipient_name` varchar(255) NOT NULL COMMENT 'Recipient Name',
  `email_type` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Email Type',
  PRIMARY KEY (`recipient_id`),
  UNIQUE KEY `19BDB9C5FE4BD685FCF992A71E976CD0` (`message_id`,`recipient_email`,`email_type`),
  KEY `IDX_CORE_EMAIL_QUEUE_RECIPIENTS_RECIPIENT_EMAIL` (`recipient_email`),
  KEY `IDX_CORE_EMAIL_QUEUE_RECIPIENTS_EMAIL_TYPE` (`email_type`),
  CONSTRAINT `FK_6F4948F3ABF97DE12127EF14B140802A` FOREIGN KEY (`message_id`) REFERENCES `core_email_queue` (`message_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Email Queue';



# Dump of table core_email_template
# ------------------------------------------------------------

DROP TABLE IF EXISTS `core_email_template`;

CREATE TABLE `core_email_template` (
  `template_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Template Id',
  `template_code` varchar(150) NOT NULL COMMENT 'Template Name',
  `template_text` text NOT NULL COMMENT 'Template Content',
  `template_styles` text COMMENT 'Templste Styles',
  `template_type` int(10) unsigned DEFAULT NULL COMMENT 'Template Type',
  `template_subject` varchar(200) NOT NULL COMMENT 'Template Subject',
  `template_sender_name` varchar(200) DEFAULT NULL COMMENT 'Template Sender Name',
  `template_sender_email` varchar(200) DEFAULT NULL COMMENT 'Template Sender Email',
  `added_at` timestamp NULL DEFAULT NULL COMMENT 'Date of Template Creation',
  `modified_at` timestamp NULL DEFAULT NULL COMMENT 'Date of Template Modification',
  `orig_template_code` varchar(200) DEFAULT NULL COMMENT 'Original Template Code',
  `orig_template_variables` text COMMENT 'Original Template Variables',
  PRIMARY KEY (`template_id`),
  UNIQUE KEY `UNQ_CORE_EMAIL_TEMPLATE_TEMPLATE_CODE` (`template_code`),
  KEY `IDX_CORE_EMAIL_TEMPLATE_ADDED_AT` (`added_at`),
  KEY `IDX_CORE_EMAIL_TEMPLATE_MODIFIED_AT` (`modified_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Email Templates';



# Dump of table core_flag
# ------------------------------------------------------------

DROP TABLE IF EXISTS `core_flag`;

CREATE TABLE `core_flag` (
  `flag_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Flag Id',
  `flag_code` varchar(255) NOT NULL COMMENT 'Flag Code',
  `state` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Flag State',
  `flag_data` text COMMENT 'Flag Data',
  `last_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Date of Last Flag Update',
  PRIMARY KEY (`flag_id`),
  KEY `IDX_CORE_FLAG_LAST_UPDATE` (`last_update`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Flag';

LOCK TABLES `core_flag` WRITE;
/*!40000 ALTER TABLE `core_flag` DISABLE KEYS */;

INSERT INTO `core_flag` (`flag_id`, `flag_code`, `state`, `flag_data`, `last_update`)
VALUES
	(1,'admin_notification_survey',0,'a:1:{s:13:\"survey_viewed\";b:1;}','2015-10-02 19:26:35');

/*!40000 ALTER TABLE `core_flag` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table core_layout_link
# ------------------------------------------------------------

DROP TABLE IF EXISTS `core_layout_link`;

CREATE TABLE `core_layout_link` (
  `layout_link_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Link Id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  `area` varchar(64) DEFAULT NULL COMMENT 'Area',
  `package` varchar(64) DEFAULT NULL COMMENT 'Package',
  `theme` varchar(64) DEFAULT NULL COMMENT 'Theme',
  `layout_update_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Layout Update Id',
  PRIMARY KEY (`layout_link_id`),
  UNIQUE KEY `UNQ_CORE_LAYOUT_LINK_STORE_ID_PACKAGE_THEME_LAYOUT_UPDATE_ID` (`store_id`,`package`,`theme`,`layout_update_id`),
  KEY `IDX_CORE_LAYOUT_LINK_LAYOUT_UPDATE_ID` (`layout_update_id`),
  CONSTRAINT `FK_CORE_LAYOUT_LINK_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CORE_LYT_LNK_LYT_UPDATE_ID_CORE_LYT_UPDATE_LYT_UPDATE_ID` FOREIGN KEY (`layout_update_id`) REFERENCES `core_layout_update` (`layout_update_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Layout Link';

LOCK TABLES `core_layout_link` WRITE;
/*!40000 ALTER TABLE `core_layout_link` DISABLE KEYS */;

INSERT INTO `core_layout_link` (`layout_link_id`, `store_id`, `area`, `package`, `theme`, `layout_update_id`)
VALUES
	(1,0,'frontend','default','em0120',1),
	(2,0,'frontend','default','em0120',2),
	(3,0,'frontend','default','em0120',3),
	(4,0,'frontend','default','em0120',4),
	(5,0,'frontend','default','em0120',5),
	(6,0,'frontend','default','em0120',6),
	(7,0,'frontend','default','em0120',7),
	(8,0,'frontend','default','em0120',8),
	(9,0,'frontend','default','em0120',9),
	(10,0,'frontend','default','em0120',10),
	(11,0,'frontend','default','em0120',11),
	(12,0,'frontend','default','em0120',12),
	(13,0,'frontend','default','em0120',13),
	(14,0,'frontend','default','em0120',14),
	(15,0,'frontend','default','em0120',15),
	(16,0,'frontend','default','em0120',16),
	(17,0,'frontend','default','em0120',17),
	(18,0,'frontend','default','em0120',18),
	(19,0,'frontend','default','em0120',19),
	(20,0,'frontend','default','em0120',20),
	(21,0,'frontend','default','em0120',21),
	(22,0,'frontend','default','em0120',22),
	(23,0,'frontend','default','em0120',23),
	(24,0,'frontend','default','em0120',24),
	(25,0,'frontend','default','em0120',25),
	(26,0,'frontend','default','em0120',26),
	(27,0,'frontend','default','em0120',27),
	(28,0,'frontend','default','em0120',28),
	(29,0,'frontend','default','em0120',29),
	(30,0,'frontend','default','em0120',30),
	(31,0,'frontend','default','em0120',31),
	(32,0,'frontend','default','em0120',32),
	(33,0,'frontend','default','em0120',33),
	(34,0,'frontend','default','em0120',34),
	(35,0,'frontend','default','em0120',35),
	(36,0,'frontend','default','em0120',36),
	(37,0,'frontend','default','em0120',37),
	(38,0,'frontend','default','em0120',38),
	(39,0,'frontend','default','em0120',39),
	(40,0,'frontend','default','em0120',40),
	(41,0,'frontend','default','em0120',41),
	(42,0,'frontend','default','em0120',42),
	(43,0,'frontend','default','em0120',43),
	(44,0,'frontend','default','em0120',44),
	(45,0,'frontend','default','em0120',45),
	(46,0,'frontend','default','em0120',46),
	(47,0,'frontend','default','em0120',47),
	(48,0,'frontend','default','em0120',48),
	(49,0,'frontend','default','em0120',49),
	(50,0,'frontend','default','em0120',50);

/*!40000 ALTER TABLE `core_layout_link` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table core_layout_update
# ------------------------------------------------------------

DROP TABLE IF EXISTS `core_layout_update`;

CREATE TABLE `core_layout_update` (
  `layout_update_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Layout Update Id',
  `handle` varchar(255) DEFAULT NULL COMMENT 'Handle',
  `xml` text COMMENT 'Xml',
  `sort_order` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Sort Order',
  PRIMARY KEY (`layout_update_id`),
  KEY `IDX_CORE_LAYOUT_UPDATE_HANDLE` (`handle`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Layout Updates';

LOCK TABLES `core_layout_update` WRITE;
/*!40000 ALTER TABLE `core_layout_update` DISABLE KEYS */;

INSERT INTO `core_layout_update` (`layout_update_id`, `handle`, `xml`, `sort_order`)
VALUES
	(1,'default','<reference name=\"em_area1\"><block type=\"cmswidget/widget_block\" name=\"a36f6b75d318a55bbc654823959e0616\"><action method=\"setData\"><name>block_id</name><value>4</value></action><action method=\"setData\"><name>custom_class</name><value>area01-shipping</value></action></block></reference>',0),
	(2,'cms_index_index','<reference name=\"em_area2\"><block type=\"slideshow2/slideshow2\" name=\"17da4363a2b69c9eb5b1dfb86f031be0\"><action method=\"setData\"><name>slideshow</name><value>1</value></action></block></reference>',0),
	(3,'cms_index_index','<reference name=\"em_area5\"><block type=\"cmswidget/widget_block\" name=\"8ab25098f313d59c7e6fee85d0e10c7d\"><action method=\"setData\"><name>block_id</name><value>5</value></action><action method=\"setData\"><name>custom_class</name><value>area05-features</value></action><action method=\"setData\"><name>block_title</name><value>Theme Features</value></action></block></reference>',0),
	(4,'cms_index_index','<reference name=\"em_area5\"><block type=\"cmswidget/widget_block\" name=\"7c398de7bdc77abf6e7928b3a2f67f72\"><action method=\"setData\"><name>block_id</name><value>6</value></action><action method=\"setData\"><name>custom_class</name><value>area05-three-banners</value></action></block></reference>',1),
	(5,'cms_index_index','<reference name=\"em_area6\"><block type=\"cmswidget/widget_block\" name=\"a640c6f3fb2d6d1ea8d497da0732933b\"><action method=\"setData\"><name>block_id</name><value>7</value></action><action method=\"setData\"><name>custom_class</name><value>area06-banner-shipping</value></action></block></reference>',0),
	(6,'cms_index_index','<reference name=\"em_area7\"><block type=\"cmswidget/widget_block\" name=\"f31a186df1a7b9446ef1b0b5094af9ce\"><action method=\"setData\"><name>block_id</name><value>8</value></action><action method=\"setData\"><name>custom_class</name><value>area07-featured-products</value></action><action method=\"setData\"><name>block_title</name><value>Featured Products</value></action></block></reference>',1),
	(7,'cms_index_index','<reference name=\"em_area8\"><block type=\"cmswidget/widget_block\" name=\"428564de162edb873b048858790821e7\"><action method=\"setData\"><name>block_id</name><value>9</value></action><action method=\"setData\"><name>custom_class</name><value>area08-newsletter</value></action></block></reference>',1),
	(8,'cms_index_index','<reference name=\"em_area8\"><block type=\"cmswidget/widget_block\" name=\"7d92f6fc98f96e1ed196a259bc6ee9a3\"><action method=\"setData\"><name>block_id</name><value>10</value></action><action method=\"setData\"><name>custom_class</name><value>area08-testimonial</value></action><action method=\"setData\"><name>block_title</name><value>Testimonial</value></action></block></reference>',2),
	(9,'default','<reference name=\"em_area9\"><block type=\"cmswidget/widget_block\" name=\"7f34c0096ba874095f23586e3732f057\"><action method=\"setData\"><name>block_id</name><value>11</value></action><action method=\"setData\"><name>custom_class</name><value>area09-brand</value></action></block></reference>',3),
	(10,'default','<reference name=\"em_area10\"><block type=\"cmswidget/widget_block\" name=\"5637dd50bc8bb4db54ed78a1d2a87005\"><action method=\"setData\"><name>block_id</name><value>13</value></action><action method=\"setData\"><name>custom_class</name><value>area10-links</value></action></block></reference>',2),
	(11,'default','<reference name=\"bottom.container\"><block type=\"cmswidget/widget_block\" name=\"ff93df3a3f949d08cd5b5e1ae31ec19d\"><action method=\"setData\"><name>block_id</name><value>14</value></action><action method=\"setData\"><name>custom_class</name><value>footer-payment</value></action></block></reference>',0),
	(12,'default','<reference name=\"em0120.top.menu\"><block type=\"megamenupro/megamenupro\" name=\"03e0945f6187aca6c9ad0695aa498c3f\"><action method=\"setData\"><name>menu</name><value>1</value></action></block></reference>',0),
	(13,'catalog_product_view','<reference name=\"left\"><block type=\"recentreviewproducts/list\" name=\"055b3a0d2bd6d0a7958466fe7db89be7\"><action method=\"setData\"><name>limit_count</name><value>3</value></action><action method=\"setData\"><name>order_by</name><value>name asc</value></action><action method=\"setData\"><name>frontend_title</name><value>Latest Review</value></action><action method=\"setData\"><name>thumbnail_width</name><value>239</value></action><action method=\"setData\"><name>thumbnail_height</name><value>335</value></action><action method=\"setData\"><name>show_product_name</name><value>true</value></action><action method=\"setData\"><name>show_thumbnail</name><value>true</value></action><action method=\"setData\"><name>show_price</name><value>true</value></action><action method=\"setData\"><name>show_addtocart</name><value>false</value></action><action method=\"setData\"><name>show_addto</name><value>false</value></action><action method=\"setData\"><name>show_label</name><value>false</value></action><action method=\"setData\"><name>choose_template</name><value>em_recentviewproducts/grid_products_simple.phtml</value></action></block></reference>',0),
	(14,'catalog_category_default','<reference name=\"left\"><block type=\"recentreviewproducts/list\" name=\"c99f1e148b841de73d3519efd889a93c\"><action method=\"setData\"><name>limit_count</name><value>3</value></action><action method=\"setData\"><name>order_by</name><value>name asc</value></action><action method=\"setData\"><name>frontend_title</name><value>Latest Review</value></action><action method=\"setData\"><name>thumbnail_width</name><value>239</value></action><action method=\"setData\"><name>thumbnail_height</name><value>335</value></action><action method=\"setData\"><name>show_product_name</name><value>true</value></action><action method=\"setData\"><name>show_thumbnail</name><value>true</value></action><action method=\"setData\"><name>show_price</name><value>true</value></action><action method=\"setData\"><name>show_addtocart</name><value>false</value></action><action method=\"setData\"><name>show_addto</name><value>false</value></action><action method=\"setData\"><name>show_label</name><value>false</value></action><action method=\"setData\"><name>choose_template</name><value>em_recentviewproducts/grid_products_simple.phtml</value></action></block></reference>',0),
	(15,'catalog_category_layered','<reference name=\"left\"><block type=\"recentreviewproducts/list\" name=\"7fa6e0ca1a13e578c016a1f407da8bb1\"><action method=\"setData\"><name>limit_count</name><value>3</value></action><action method=\"setData\"><name>order_by</name><value>name asc</value></action><action method=\"setData\"><name>frontend_title</name><value>Latest Review</value></action><action method=\"setData\"><name>thumbnail_width</name><value>239</value></action><action method=\"setData\"><name>thumbnail_height</name><value>335</value></action><action method=\"setData\"><name>show_product_name</name><value>true</value></action><action method=\"setData\"><name>show_thumbnail</name><value>true</value></action><action method=\"setData\"><name>show_price</name><value>true</value></action><action method=\"setData\"><name>show_addtocart</name><value>false</value></action><action method=\"setData\"><name>show_addto</name><value>false</value></action><action method=\"setData\"><name>show_label</name><value>false</value></action><action method=\"setData\"><name>choose_template</name><value>em_recentviewproducts/grid_products_simple.phtml</value></action></block></reference>',0),
	(16,'catalog_product_view','<reference name=\"em_area3\"><block type=\"cmswidget/widget_block\" name=\"53eacff33f72c09e87c1ec269f16a87e\"><action method=\"setData\"><name>block_id</name><value>15</value></action></block></reference>',0),
	(17,'catalog_product_view','<reference name=\"em_area4\"><block type=\"cmswidget/widget_block\" name=\"66dcba7d8f2e39f6c241d5e9e6a73102\"><action method=\"setData\"><name>block_id</name><value>16</value></action></block></reference>',0),
	(18,'catalog_product_view','<reference name=\"alert.urls\"><block type=\"cmswidget/widget_block\" name=\"d48663c49452dd668eeb7c8aca80e8ba\"><action method=\"setData\"><name>block_id</name><value>17</value></action></block></reference>',0),
	(19,'catalog_product_view','<reference name=\"product.info.extrahint\"><block type=\"cmswidget/widget_block\" name=\"aeeb13f17c92dfb5e10a6d91129610f2\"><action method=\"setData\"><name>block_id</name><value>18</value></action></block></reference>',0),
	(20,'catalog_product_view','<reference name=\"product.info.additonal_collateral\"><block type=\"cmswidget/widget_block\" name=\"b13494660e018cf93d0f429445ee797e\"><action method=\"setData\"><name>block_id</name><value>19</value></action><action method=\"setData\"><name>block_title</name><value>Custom Tabs 1</value></action></block></reference>',0),
	(21,'catalog_product_view','<reference name=\"product.info.additonal_collateral\"><block type=\"cmswidget/widget_block\" name=\"fecd94f1963c8958bc7fc283c247a258\"><action method=\"setData\"><name>block_id</name><value>19</value></action><action method=\"setData\"><name>block_title</name><value>Custom Tabs N</value></action></block></reference>',0),
	(22,'checkout_onepage_index','<reference name=\"em_area12\"><block type=\"cmswidget/widget_block\" name=\"3543e10326074210df3f4fefc2f73a0e\"><action method=\"setData\"><name>block_id</name><value>20</value></action></block></reference>',0),
	(23,'customer_account_forgotpassword','<reference name=\"em_area12\"><block type=\"cmswidget/widget_block\" name=\"e581b6ea436fdee11a2b570398922b9d\"><action method=\"setData\"><name>block_id</name><value>20</value></action></block></reference>',0),
	(24,'customer_account_create','<reference name=\"em_area12\"><block type=\"cmswidget/widget_block\" name=\"a8b69096a506b6bc4178fb5494e3ceb1\"><action method=\"setData\"><name>block_id</name><value>20</value></action></block></reference>',0),
	(25,'customer_account_logoutsuccess','<reference name=\"em_area12\"><block type=\"cmswidget/widget_block\" name=\"b5ce8b9a5e01dd736d7d3587864fca4e\"><action method=\"setData\"><name>block_id</name><value>20</value></action></block></reference>',0),
	(26,'customer_account_login','<reference name=\"em_area12\"><block type=\"cmswidget/widget_block\" name=\"18082b0f926e978129038a599c4d626b\"><action method=\"setData\"><name>block_id</name><value>20</value></action></block></reference>',0),
	(27,'customer_account_edit','<reference name=\"em_area12\"><block type=\"cmswidget/widget_block\" name=\"0510ad4e899604839e175e14a5462abb\"><action method=\"setData\"><name>block_id</name><value>20</value></action></block></reference>',0),
	(28,'customer_account','<reference name=\"em_area12\"><block type=\"cmswidget/widget_block\" name=\"ac4518cca2fd5ed61a06be0a5a0a8a25\"><action method=\"setData\"><name>block_id</name><value>20</value></action></block></reference>',0),
	(29,'catalog_product_view','<reference name=\"em_area12\"><block type=\"cmswidget/widget_block\" name=\"09ea8c191df337c0bc9c9162bd09c763\"><action method=\"setData\"><name>block_id</name><value>20</value></action></block></reference>',0),
	(30,'catalog_category_default','<reference name=\"em_area12\"><block type=\"cmswidget/widget_block\" name=\"821f99220a832e2d1f1a17bdddd113cc\"><action method=\"setData\"><name>block_id</name><value>20</value></action></block></reference>',0),
	(31,'catalog_category_layered','<reference name=\"em_area12\"><block type=\"cmswidget/widget_block\" name=\"7f617f71543b59ee37dcd2690deab63f\"><action method=\"setData\"><name>block_id</name><value>20</value></action></block></reference>',0),
	(32,'blog_tag_taglist','<reference name=\"em_area12\"><block type=\"cmswidget/widget_block\" name=\"a303a6283fcd8709379351ed02cc27d3\"><action method=\"setData\"><name>block_id</name><value>20</value></action></block></reference>',0),
	(33,'blog_tag_view','<reference name=\"em_area12\"><block type=\"cmswidget/widget_block\" name=\"71d801ff0d51510fe648bbb2515b1df4\"><action method=\"setData\"><name>block_id</name><value>20</value></action></block></reference>',0),
	(34,'blog_index_index','<reference name=\"em_area12\"><block type=\"cmswidget/widget_block\" name=\"8ec79882c04da89f7ec5618806dcc646\"><action method=\"setData\"><name>block_id</name><value>20</value></action></block></reference>',0),
	(35,'blog_category_view','<reference name=\"em_area12\"><block type=\"cmswidget/widget_block\" name=\"665a6fc7b938856e6c19eba87ac40e1c\"><action method=\"setData\"><name>block_id</name><value>20</value></action></block></reference>',0),
	(36,'blog_post_view','<reference name=\"em_area12\"><block type=\"cmswidget/widget_block\" name=\"09b615ea5358d36040e52a036f11b0f2\"><action method=\"setData\"><name>block_id</name><value>20</value></action></block></reference>',0),
	(37,'page_two_columns_left','<reference name=\"em_area1\"><block type=\"cmswidget/widget_block\" name=\"d5a071beba7eb3d621b7d818727143e3\"><action method=\"setData\"><name>block_id</name><value>20</value></action></block></reference>',0),
	(38,'checkout_onepage_index','<reference name=\"em_area12\"><block type=\"cmswidget/widget_block\" name=\"53485c2b53067c0fd4660c8c00bcd25f\"><action method=\"setData\"><name>block_id</name><value>21</value></action></block></reference>',0),
	(39,'customer_account','<reference name=\"em_area12\"><block type=\"cmswidget/widget_block\" name=\"28ee387765414480689c207142d9400d\"><action method=\"setData\"><name>block_id</name><value>21</value></action></block></reference>',0),
	(40,'customer_account_forgotpassword','<reference name=\"em_area12\"><block type=\"cmswidget/widget_block\" name=\"e022bb62d2bcba3cc340890f12b0783c\"><action method=\"setData\"><name>block_id</name><value>21</value></action></block></reference>',0),
	(41,'customer_account_create','<reference name=\"em_area12\"><block type=\"cmswidget/widget_block\" name=\"04f8eddb8be90caac68ac69e2f224475\"><action method=\"setData\"><name>block_id</name><value>21</value></action></block></reference>',0),
	(42,'customer_account_logoutsuccess','<reference name=\"em_area12\"><block type=\"cmswidget/widget_block\" name=\"2453ce649746bc7c88e6a7075a0c0178\"><action method=\"setData\"><name>block_id</name><value>21</value></action></block></reference>',0),
	(43,'customer_account_login','<reference name=\"em_area12\"><block type=\"cmswidget/widget_block\" name=\"821f29326b9ac757fa0844b128e09426\"><action method=\"setData\"><name>block_id</name><value>21</value></action></block></reference>',0),
	(44,'customer_account_edit','<reference name=\"em_area12\"><block type=\"cmswidget/widget_block\" name=\"13815e708f4cdbcb7e9bb2b5ec843160\"><action method=\"setData\"><name>block_id</name><value>21</value></action></block></reference>',0),
	(45,'default','<reference name=\"em0120.top.menu\"><block type=\"megamenupro/megamenupro\" name=\"568caca247dcd56082be95f442048445\"></block></reference>',0),
	(46,'default','<reference name=\"left\"><block type=\"megamenupro/megamenupro\" name=\"b08e9db4fa06202b838201a9e81b8e2c\"></block></reference>',0),
	(47,'default','<reference name=\"right\"><block type=\"megamenupro/megamenupro\" name=\"ac6e7c379e06ee00e53cdda8b488c081\"></block></reference>',0),
	(49,'cms_index_index','<reference name=\"content\"><block type=\"tabs/group\" name=\"c9ba6aab6fef63be55524d258f1f70e5\" template=\"emtabs/group.phtml\"><action method=\"setData\"><name>custom_class</name><value>main-products-block</value></action><action method=\"setData\"><name>title_1</name><value>All Product,,,,,,,,,,,,</value></action><action method=\"setData\"><name>instance_1</name><value>25</value></action><action method=\"setData\"><name>title_2</name><value>Special,,,,,,,,,,,,</value></action><action method=\"setData\"><name>instance_2</name><value>26</value></action><action method=\"setData\"><name>title_3</name><value>New Arrival,,,,,,,,,,,,</value></action><action method=\"setData\"><name>instance_3</name><value>27</value></action><action method=\"setData\"><name>title_4</name><value>,,,,,,,,,,,,</value></action><action method=\"setData\"><name>title_5</name><value>,,,,,,,,,,,,</value></action><action method=\"setData\"><name>title_6</name><value>,,,,,,,,,,,,</value></action><action method=\"setData\"><name>title_7</name><value>,,,,,,,,,,,,</value></action><action method=\"setData\"><name>title_8</name><value>,,,,,,,,,,,,</value></action><action method=\"setData\"><name>title_9</name><value>,,,,,,,,,,,,</value></action><action method=\"setData\"><name>title_10</name><value>,,,,,,,,,,,,</value></action><action method=\"setData\"><name>instance</name><value>28</value></action></block></reference>',0),
	(50,'default','<reference name=\"em_area17\"><block type=\"cmswidget/widget_block\" name=\"bff9b281727457ad7e5635cb8262b88a\"><action method=\"setData\"><name>block_id</name><value>39</value></action><action method=\"setData\"><name>custom_class</name><value>area17-promotion-banners</value></action></block></reference>',0);

/*!40000 ALTER TABLE `core_layout_update` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table core_resource
# ------------------------------------------------------------

DROP TABLE IF EXISTS `core_resource`;

CREATE TABLE `core_resource` (
  `code` varchar(50) NOT NULL COMMENT 'Resource Code',
  `version` varchar(50) DEFAULT NULL COMMENT 'Resource Version',
  `data_version` varchar(50) DEFAULT NULL COMMENT 'Data Version',
  PRIMARY KEY (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Resources';

LOCK TABLES `core_resource` WRITE;
/*!40000 ALTER TABLE `core_resource` DISABLE KEYS */;

INSERT INTO `core_resource` (`code`, `version`, `data_version`)
VALUES
	('adminnotification_setup','1.6.0.0','1.6.0.0'),
	('admin_setup','1.6.1.1','1.6.1.1'),
	('ajaxcart_setup','0.1.0','0.1.0'),
	('api2_setup','1.0.0.0','1.0.0.0'),
	('api_setup','1.6.0.1','1.6.0.1'),
	('backup_setup','1.6.0.0','1.6.0.0'),
	('bundle_setup','1.6.0.0.1','1.6.0.0.1'),
	('captcha_setup','1.7.0.0.0','1.7.0.0.0'),
	('catalogindex_setup','1.6.0.0','1.6.0.0'),
	('cataloginventory_setup','1.6.0.0.2','1.6.0.0.2'),
	('catalogrule_setup','1.6.0.3','1.6.0.3'),
	('catalogsearch_setup','1.8.2.0','1.8.2.0'),
	('catalog_setup','1.6.0.0.19.1.2','1.6.0.0.19.1.2'),
	('checkout_setup','1.6.0.0','1.6.0.0'),
	('cms_setup','1.6.0.0.2','1.6.0.0.2'),
	('compiler_setup','1.6.0.0','1.6.0.0'),
	('contacts_setup','1.6.0.0','1.6.0.0'),
	('core_setup','1.6.0.6','1.6.0.6'),
	('cron_setup','1.6.0.0','1.6.0.0'),
	('customer_setup','1.6.2.0.4','1.6.2.0.4'),
	('dataflow_setup','1.6.0.0','1.6.0.0'),
	('directory_setup','1.6.0.3','1.6.0.3'),
	('downloadable_setup','1.6.0.0.2','1.6.0.0.2'),
	('eav_setup','1.6.0.1','1.6.0.1'),
	('em0120settings_setup','0.1.0','0.1.0'),
	('filterproducts_setup','1.0.0','1.0.0'),
	('giftmessage_setup','1.6.0.0','1.6.0.0'),
	('googleanalytics_setup','1.6.0.0','1.6.0.0'),
	('importexport_setup','1.6.0.2','1.6.0.2'),
	('index_setup','1.6.0.0','1.6.0.0'),
	('layerednavigation_setup','1.0.0','1.0.0'),
	('log_setup','1.6.1.1','1.6.1.1'),
	('moneybookers_setup','1.6.0.0','1.6.0.0'),
	('newsletter_setup','1.6.0.2','1.6.0.2'),
	('oauth_setup','1.0.0.0','1.0.0.0'),
	('paygate_setup','1.6.0.0','1.6.0.0'),
	('payment_setup','1.6.0.0','1.6.0.0'),
	('paypaluk_setup','1.6.0.0','1.6.0.0'),
	('paypal_setup','1.6.0.6','1.6.0.6'),
	('persistent_setup','1.0.0.0','1.0.0.0'),
	('poll_setup','1.6.0.1','1.6.0.1'),
	('productalert_setup','1.6.0.0','1.6.0.0'),
	('productlabels_setup','1.0.0','1.0.0'),
	('quickshop_setup','0.1.0','0.1.0'),
	('rating_setup','1.6.0.1','1.6.0.1'),
	('recentreviewproducts_setup','0.1.0','0.1.0'),
	('reports_setup','1.6.0.0.1','1.6.0.0.1'),
	('review_setup','1.6.0.0','1.6.0.0'),
	('salesrule_setup','1.6.0.3','1.6.0.3'),
	('sales_setup','1.6.0.9','1.6.0.9'),
	('sendfriend_setup','1.6.0.1','1.6.0.1'),
	('shipping_setup','1.6.0.0','1.6.0.0'),
	('sitemap_setup','1.6.0.0','1.6.0.0'),
	('slideshow2_setup','1.0.0','1.0.0'),
	('tag_setup','1.6.0.0','1.6.0.0'),
	('tax_setup','1.6.0.4','1.6.0.4'),
	('themeframework_setup','0.1.0','0.1.0'),
	('usa_setup','1.6.0.3','1.6.0.3'),
	('weee_setup','1.6.0.0','1.6.0.0'),
	('widget_setup','1.6.0.0','1.6.0.0'),
	('wishlist_setup','1.6.0.0','1.6.0.0');

/*!40000 ALTER TABLE `core_resource` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table core_session
# ------------------------------------------------------------

DROP TABLE IF EXISTS `core_session`;

CREATE TABLE `core_session` (
  `session_id` varchar(255) NOT NULL COMMENT 'Session Id',
  `session_expires` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Date of Session Expiration',
  `session_data` mediumblob NOT NULL COMMENT 'Session Data',
  PRIMARY KEY (`session_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Database Sessions Storage';



# Dump of table core_store
# ------------------------------------------------------------

DROP TABLE IF EXISTS `core_store`;

CREATE TABLE `core_store` (
  `store_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Store Id',
  `code` varchar(32) DEFAULT NULL COMMENT 'Code',
  `website_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Website Id',
  `group_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Group Id',
  `name` varchar(255) NOT NULL COMMENT 'Store Name',
  `sort_order` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Sort Order',
  `is_active` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Activity',
  PRIMARY KEY (`store_id`),
  UNIQUE KEY `UNQ_CORE_STORE_CODE` (`code`),
  KEY `IDX_CORE_STORE_WEBSITE_ID` (`website_id`),
  KEY `IDX_CORE_STORE_IS_ACTIVE_SORT_ORDER` (`is_active`,`sort_order`),
  KEY `IDX_CORE_STORE_GROUP_ID` (`group_id`),
  CONSTRAINT `FK_CORE_STORE_GROUP_ID_CORE_STORE_GROUP_GROUP_ID` FOREIGN KEY (`group_id`) REFERENCES `core_store_group` (`group_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CORE_STORE_WEBSITE_ID_CORE_WEBSITE_WEBSITE_ID` FOREIGN KEY (`website_id`) REFERENCES `core_website` (`website_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores';

LOCK TABLES `core_store` WRITE;
/*!40000 ALTER TABLE `core_store` DISABLE KEYS */;

INSERT INTO `core_store` (`store_id`, `code`, `website_id`, `group_id`, `name`, `sort_order`, `is_active`)
VALUES
	(0,'admin',0,0,'Admin',0,1),
	(1,'default',1,1,'Default Store View',0,1);

/*!40000 ALTER TABLE `core_store` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table core_store_group
# ------------------------------------------------------------

DROP TABLE IF EXISTS `core_store_group`;

CREATE TABLE `core_store_group` (
  `group_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Group Id',
  `website_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Website Id',
  `name` varchar(255) NOT NULL COMMENT 'Store Group Name',
  `root_category_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Root Category Id',
  `default_store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Default Store Id',
  PRIMARY KEY (`group_id`),
  KEY `IDX_CORE_STORE_GROUP_WEBSITE_ID` (`website_id`),
  KEY `IDX_CORE_STORE_GROUP_DEFAULT_STORE_ID` (`default_store_id`),
  CONSTRAINT `FK_CORE_STORE_GROUP_WEBSITE_ID_CORE_WEBSITE_WEBSITE_ID` FOREIGN KEY (`website_id`) REFERENCES `core_website` (`website_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Store Groups';

LOCK TABLES `core_store_group` WRITE;
/*!40000 ALTER TABLE `core_store_group` DISABLE KEYS */;

INSERT INTO `core_store_group` (`group_id`, `website_id`, `name`, `root_category_id`, `default_store_id`)
VALUES
	(0,0,'Default',0,0),
	(1,1,'Main Website Store',2,1);

/*!40000 ALTER TABLE `core_store_group` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table core_translate
# ------------------------------------------------------------

DROP TABLE IF EXISTS `core_translate`;

CREATE TABLE `core_translate` (
  `key_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Key Id of Translation',
  `string` varchar(255) NOT NULL DEFAULT 'Translate String' COMMENT 'Translation String',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  `translate` varchar(255) DEFAULT NULL COMMENT 'Translate',
  `locale` varchar(20) NOT NULL DEFAULT 'en_US' COMMENT 'Locale',
  `crc_string` bigint(20) NOT NULL DEFAULT '1591228201' COMMENT 'Translation String CRC32 Hash',
  PRIMARY KEY (`key_id`),
  UNIQUE KEY `UNQ_CORE_TRANSLATE_STORE_ID_LOCALE_CRC_STRING_STRING` (`store_id`,`locale`,`crc_string`,`string`),
  KEY `IDX_CORE_TRANSLATE_STORE_ID` (`store_id`),
  CONSTRAINT `FK_CORE_TRANSLATE_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Translations';



# Dump of table core_url_rewrite
# ------------------------------------------------------------

DROP TABLE IF EXISTS `core_url_rewrite`;

CREATE TABLE `core_url_rewrite` (
  `url_rewrite_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Rewrite Id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  `id_path` varchar(255) DEFAULT NULL COMMENT 'Id Path',
  `request_path` varchar(255) DEFAULT NULL COMMENT 'Request Path',
  `target_path` varchar(255) DEFAULT NULL COMMENT 'Target Path',
  `is_system` smallint(5) unsigned DEFAULT '1' COMMENT 'Defines is Rewrite System',
  `options` varchar(255) DEFAULT NULL COMMENT 'Options',
  `description` varchar(255) DEFAULT NULL COMMENT 'Deascription',
  `category_id` int(10) unsigned DEFAULT NULL COMMENT 'Category Id',
  `product_id` int(10) unsigned DEFAULT NULL COMMENT 'Product Id',
  PRIMARY KEY (`url_rewrite_id`),
  UNIQUE KEY `UNQ_CORE_URL_REWRITE_REQUEST_PATH_STORE_ID` (`request_path`,`store_id`),
  UNIQUE KEY `UNQ_CORE_URL_REWRITE_ID_PATH_IS_SYSTEM_STORE_ID` (`id_path`,`is_system`,`store_id`),
  KEY `IDX_CORE_URL_REWRITE_TARGET_PATH_STORE_ID` (`target_path`,`store_id`),
  KEY `IDX_CORE_URL_REWRITE_ID_PATH` (`id_path`),
  KEY `IDX_CORE_URL_REWRITE_STORE_ID` (`store_id`),
  KEY `FK_CORE_URL_REWRITE_CTGR_ID_CAT_CTGR_ENTT_ENTT_ID` (`category_id`),
  KEY `FK_CORE_URL_REWRITE_PRODUCT_ID_CATALOG_CATEGORY_ENTITY_ENTITY_ID` (`product_id`),
  CONSTRAINT `FK_CORE_URL_REWRITE_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CORE_URL_REWRITE_CTGR_ID_CAT_CTGR_ENTT_ENTT_ID` FOREIGN KEY (`category_id`) REFERENCES `catalog_category_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CORE_URL_REWRITE_PRODUCT_ID_CATALOG_CATEGORY_ENTITY_ENTITY_ID` FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Url Rewrites';



# Dump of table core_variable
# ------------------------------------------------------------

DROP TABLE IF EXISTS `core_variable`;

CREATE TABLE `core_variable` (
  `variable_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Variable Id',
  `code` varchar(255) DEFAULT NULL COMMENT 'Variable Code',
  `name` varchar(255) DEFAULT NULL COMMENT 'Variable Name',
  PRIMARY KEY (`variable_id`),
  UNIQUE KEY `UNQ_CORE_VARIABLE_CODE` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Variables';



# Dump of table core_variable_value
# ------------------------------------------------------------

DROP TABLE IF EXISTS `core_variable_value`;

CREATE TABLE `core_variable_value` (
  `value_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Variable Value Id',
  `variable_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Variable Id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  `plain_value` text COMMENT 'Plain Text Value',
  `html_value` text COMMENT 'Html Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_CORE_VARIABLE_VALUE_VARIABLE_ID_STORE_ID` (`variable_id`,`store_id`),
  KEY `IDX_CORE_VARIABLE_VALUE_VARIABLE_ID` (`variable_id`),
  KEY `IDX_CORE_VARIABLE_VALUE_STORE_ID` (`store_id`),
  CONSTRAINT `FK_CORE_VARIABLE_VALUE_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CORE_VARIABLE_VALUE_VARIABLE_ID_CORE_VARIABLE_VARIABLE_ID` FOREIGN KEY (`variable_id`) REFERENCES `core_variable` (`variable_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Variable Value';



# Dump of table core_website
# ------------------------------------------------------------

DROP TABLE IF EXISTS `core_website`;

CREATE TABLE `core_website` (
  `website_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Website Id',
  `code` varchar(32) DEFAULT NULL COMMENT 'Code',
  `name` varchar(64) DEFAULT NULL COMMENT 'Website Name',
  `sort_order` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Sort Order',
  `default_group_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Default Group Id',
  `is_default` smallint(5) unsigned DEFAULT '0' COMMENT 'Defines Is Website Default',
  PRIMARY KEY (`website_id`),
  UNIQUE KEY `UNQ_CORE_WEBSITE_CODE` (`code`),
  KEY `IDX_CORE_WEBSITE_SORT_ORDER` (`sort_order`),
  KEY `IDX_CORE_WEBSITE_DEFAULT_GROUP_ID` (`default_group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Websites';

LOCK TABLES `core_website` WRITE;
/*!40000 ALTER TABLE `core_website` DISABLE KEYS */;

INSERT INTO `core_website` (`website_id`, `code`, `name`, `sort_order`, `default_group_id`, `is_default`)
VALUES
	(0,'admin','Admin',0,0,0),
	(1,'base','Main Website',0,1,1);

/*!40000 ALTER TABLE `core_website` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table coupon_aggregated
# ------------------------------------------------------------

DROP TABLE IF EXISTS `coupon_aggregated`;

CREATE TABLE `coupon_aggregated` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `period` date NOT NULL COMMENT 'Period',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `order_status` varchar(50) DEFAULT NULL COMMENT 'Order Status',
  `coupon_code` varchar(50) DEFAULT NULL COMMENT 'Coupon Code',
  `coupon_uses` int(11) NOT NULL DEFAULT '0' COMMENT 'Coupon Uses',
  `subtotal_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Subtotal Amount',
  `discount_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Discount Amount',
  `total_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Amount',
  `subtotal_amount_actual` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Subtotal Amount Actual',
  `discount_amount_actual` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Discount Amount Actual',
  `total_amount_actual` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Amount Actual',
  `rule_name` varchar(255) DEFAULT NULL COMMENT 'Rule Name',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNQ_COUPON_AGGREGATED_PERIOD_STORE_ID_ORDER_STATUS_COUPON_CODE` (`period`,`store_id`,`order_status`,`coupon_code`),
  KEY `IDX_COUPON_AGGREGATED_STORE_ID` (`store_id`),
  KEY `IDX_COUPON_AGGREGATED_RULE_NAME` (`rule_name`),
  CONSTRAINT `FK_COUPON_AGGREGATED_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Coupon Aggregated';



# Dump of table coupon_aggregated_order
# ------------------------------------------------------------

DROP TABLE IF EXISTS `coupon_aggregated_order`;

CREATE TABLE `coupon_aggregated_order` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `period` date NOT NULL COMMENT 'Period',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `order_status` varchar(50) DEFAULT NULL COMMENT 'Order Status',
  `coupon_code` varchar(50) DEFAULT NULL COMMENT 'Coupon Code',
  `coupon_uses` int(11) NOT NULL DEFAULT '0' COMMENT 'Coupon Uses',
  `subtotal_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Subtotal Amount',
  `discount_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Discount Amount',
  `total_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Amount',
  `rule_name` varchar(255) DEFAULT NULL COMMENT 'Rule Name',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNQ_COUPON_AGGRED_ORDER_PERIOD_STORE_ID_ORDER_STS_COUPON_CODE` (`period`,`store_id`,`order_status`,`coupon_code`),
  KEY `IDX_COUPON_AGGREGATED_ORDER_STORE_ID` (`store_id`),
  KEY `IDX_COUPON_AGGREGATED_ORDER_RULE_NAME` (`rule_name`),
  CONSTRAINT `FK_COUPON_AGGREGATED_ORDER_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Coupon Aggregated Order';



# Dump of table coupon_aggregated_updated
# ------------------------------------------------------------

DROP TABLE IF EXISTS `coupon_aggregated_updated`;

CREATE TABLE `coupon_aggregated_updated` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `period` date NOT NULL COMMENT 'Period',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `order_status` varchar(50) DEFAULT NULL COMMENT 'Order Status',
  `coupon_code` varchar(50) DEFAULT NULL COMMENT 'Coupon Code',
  `coupon_uses` int(11) NOT NULL DEFAULT '0' COMMENT 'Coupon Uses',
  `subtotal_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Subtotal Amount',
  `discount_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Discount Amount',
  `total_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Amount',
  `subtotal_amount_actual` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Subtotal Amount Actual',
  `discount_amount_actual` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Discount Amount Actual',
  `total_amount_actual` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Amount Actual',
  `rule_name` varchar(255) DEFAULT NULL COMMENT 'Rule Name',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNQ_COUPON_AGGRED_UPDATED_PERIOD_STORE_ID_ORDER_STS_COUPON_CODE` (`period`,`store_id`,`order_status`,`coupon_code`),
  KEY `IDX_COUPON_AGGREGATED_UPDATED_STORE_ID` (`store_id`),
  KEY `IDX_COUPON_AGGREGATED_UPDATED_RULE_NAME` (`rule_name`),
  CONSTRAINT `FK_COUPON_AGGREGATED_UPDATED_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Coupon Aggregated Updated';



# Dump of table cron_schedule
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cron_schedule`;

CREATE TABLE `cron_schedule` (
  `schedule_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Schedule Id',
  `job_code` varchar(255) NOT NULL DEFAULT '0' COMMENT 'Job Code',
  `status` varchar(7) NOT NULL DEFAULT 'pending' COMMENT 'Status',
  `messages` text COMMENT 'Messages',
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Created At',
  `scheduled_at` timestamp NULL DEFAULT NULL COMMENT 'Scheduled At',
  `executed_at` timestamp NULL DEFAULT NULL COMMENT 'Executed At',
  `finished_at` timestamp NULL DEFAULT NULL COMMENT 'Finished At',
  PRIMARY KEY (`schedule_id`),
  KEY `IDX_CRON_SCHEDULE_JOB_CODE` (`job_code`),
  KEY `IDX_CRON_SCHEDULE_SCHEDULED_AT_STATUS` (`scheduled_at`,`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cron Schedule';



# Dump of table customer_address_entity
# ------------------------------------------------------------

DROP TABLE IF EXISTS `customer_address_entity`;

CREATE TABLE `customer_address_entity` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type Id',
  `attribute_set_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Set Id',
  `increment_id` varchar(50) DEFAULT NULL COMMENT 'Increment Id',
  `parent_id` int(10) unsigned DEFAULT NULL COMMENT 'Parent Id',
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Created At',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Updated At',
  `is_active` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Is Active',
  PRIMARY KEY (`entity_id`),
  KEY `IDX_CUSTOMER_ADDRESS_ENTITY_PARENT_ID` (`parent_id`),
  CONSTRAINT `FK_CUSTOMER_ADDRESS_ENTITY_PARENT_ID_CUSTOMER_ENTITY_ENTITY_ID` FOREIGN KEY (`parent_id`) REFERENCES `customer_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Customer Address Entity';



# Dump of table customer_address_entity_datetime
# ------------------------------------------------------------

DROP TABLE IF EXISTS `customer_address_entity_datetime`;

CREATE TABLE `customer_address_entity_datetime` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value Id',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type Id',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Id',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Id',
  `value` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_CUSTOMER_ADDRESS_ENTITY_DATETIME_ENTITY_ID_ATTRIBUTE_ID` (`entity_id`,`attribute_id`),
  KEY `IDX_CUSTOMER_ADDRESS_ENTITY_DATETIME_ENTITY_TYPE_ID` (`entity_type_id`),
  KEY `IDX_CUSTOMER_ADDRESS_ENTITY_DATETIME_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_CUSTOMER_ADDRESS_ENTITY_DATETIME_ENTITY_ID` (`entity_id`),
  KEY `IDX_CSTR_ADDR_ENTT_DTIME_ENTT_ID_ATTR_ID_VAL` (`entity_id`,`attribute_id`,`value`),
  CONSTRAINT `FK_CSTR_ADDR_ENTT_DTIME_ATTR_ID_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CSTR_ADDR_ENTT_DTIME_ENTT_ID_CSTR_ADDR_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `customer_address_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CSTR_ADDR_ENTT_DTIME_ENTT_TYPE_ID_EAV_ENTT_TYPE_ENTT_TYPE_ID` FOREIGN KEY (`entity_type_id`) REFERENCES `eav_entity_type` (`entity_type_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Customer Address Entity Datetime';



# Dump of table customer_address_entity_decimal
# ------------------------------------------------------------

DROP TABLE IF EXISTS `customer_address_entity_decimal`;

CREATE TABLE `customer_address_entity_decimal` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value Id',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type Id',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Id',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Id',
  `value` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_CUSTOMER_ADDRESS_ENTITY_DECIMAL_ENTITY_ID_ATTRIBUTE_ID` (`entity_id`,`attribute_id`),
  KEY `IDX_CUSTOMER_ADDRESS_ENTITY_DECIMAL_ENTITY_TYPE_ID` (`entity_type_id`),
  KEY `IDX_CUSTOMER_ADDRESS_ENTITY_DECIMAL_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_CUSTOMER_ADDRESS_ENTITY_DECIMAL_ENTITY_ID` (`entity_id`),
  KEY `IDX_CUSTOMER_ADDRESS_ENTITY_DECIMAL_ENTITY_ID_ATTRIBUTE_ID_VALUE` (`entity_id`,`attribute_id`,`value`),
  CONSTRAINT `FK_CSTR_ADDR_ENTT_DEC_ATTR_ID_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CSTR_ADDR_ENTT_DEC_ENTT_ID_CSTR_ADDR_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `customer_address_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CSTR_ADDR_ENTT_DEC_ENTT_TYPE_ID_EAV_ENTT_TYPE_ENTT_TYPE_ID` FOREIGN KEY (`entity_type_id`) REFERENCES `eav_entity_type` (`entity_type_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Customer Address Entity Decimal';



# Dump of table customer_address_entity_int
# ------------------------------------------------------------

DROP TABLE IF EXISTS `customer_address_entity_int`;

CREATE TABLE `customer_address_entity_int` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value Id',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type Id',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Id',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Id',
  `value` int(11) NOT NULL DEFAULT '0' COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_CUSTOMER_ADDRESS_ENTITY_INT_ENTITY_ID_ATTRIBUTE_ID` (`entity_id`,`attribute_id`),
  KEY `IDX_CUSTOMER_ADDRESS_ENTITY_INT_ENTITY_TYPE_ID` (`entity_type_id`),
  KEY `IDX_CUSTOMER_ADDRESS_ENTITY_INT_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_CUSTOMER_ADDRESS_ENTITY_INT_ENTITY_ID` (`entity_id`),
  KEY `IDX_CUSTOMER_ADDRESS_ENTITY_INT_ENTITY_ID_ATTRIBUTE_ID_VALUE` (`entity_id`,`attribute_id`,`value`),
  CONSTRAINT `FK_CSTR_ADDR_ENTT_INT_ATTR_ID_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CSTR_ADDR_ENTT_INT_ENTT_ID_CSTR_ADDR_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `customer_address_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CSTR_ADDR_ENTT_INT_ENTT_TYPE_ID_EAV_ENTT_TYPE_ENTT_TYPE_ID` FOREIGN KEY (`entity_type_id`) REFERENCES `eav_entity_type` (`entity_type_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Customer Address Entity Int';



# Dump of table customer_address_entity_text
# ------------------------------------------------------------

DROP TABLE IF EXISTS `customer_address_entity_text`;

CREATE TABLE `customer_address_entity_text` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value Id',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type Id',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Id',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Id',
  `value` text NOT NULL COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_CUSTOMER_ADDRESS_ENTITY_TEXT_ENTITY_ID_ATTRIBUTE_ID` (`entity_id`,`attribute_id`),
  KEY `IDX_CUSTOMER_ADDRESS_ENTITY_TEXT_ENTITY_TYPE_ID` (`entity_type_id`),
  KEY `IDX_CUSTOMER_ADDRESS_ENTITY_TEXT_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_CUSTOMER_ADDRESS_ENTITY_TEXT_ENTITY_ID` (`entity_id`),
  CONSTRAINT `FK_CSTR_ADDR_ENTT_TEXT_ATTR_ID_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CSTR_ADDR_ENTT_TEXT_ENTT_ID_CSTR_ADDR_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `customer_address_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CSTR_ADDR_ENTT_TEXT_ENTT_TYPE_ID_EAV_ENTT_TYPE_ENTT_TYPE_ID` FOREIGN KEY (`entity_type_id`) REFERENCES `eav_entity_type` (`entity_type_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Customer Address Entity Text';



# Dump of table customer_address_entity_varchar
# ------------------------------------------------------------

DROP TABLE IF EXISTS `customer_address_entity_varchar`;

CREATE TABLE `customer_address_entity_varchar` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value Id',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type Id',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Id',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Id',
  `value` varchar(255) DEFAULT NULL COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_CUSTOMER_ADDRESS_ENTITY_VARCHAR_ENTITY_ID_ATTRIBUTE_ID` (`entity_id`,`attribute_id`),
  KEY `IDX_CUSTOMER_ADDRESS_ENTITY_VARCHAR_ENTITY_TYPE_ID` (`entity_type_id`),
  KEY `IDX_CUSTOMER_ADDRESS_ENTITY_VARCHAR_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_CUSTOMER_ADDRESS_ENTITY_VARCHAR_ENTITY_ID` (`entity_id`),
  KEY `IDX_CUSTOMER_ADDRESS_ENTITY_VARCHAR_ENTITY_ID_ATTRIBUTE_ID_VALUE` (`entity_id`,`attribute_id`,`value`),
  CONSTRAINT `FK_CSTR_ADDR_ENTT_VCHR_ATTR_ID_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CSTR_ADDR_ENTT_VCHR_ENTT_ID_CSTR_ADDR_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `customer_address_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CSTR_ADDR_ENTT_VCHR_ENTT_TYPE_ID_EAV_ENTT_TYPE_ENTT_TYPE_ID` FOREIGN KEY (`entity_type_id`) REFERENCES `eav_entity_type` (`entity_type_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Customer Address Entity Varchar';



# Dump of table customer_eav_attribute
# ------------------------------------------------------------

DROP TABLE IF EXISTS `customer_eav_attribute`;

CREATE TABLE `customer_eav_attribute` (
  `attribute_id` smallint(5) unsigned NOT NULL COMMENT 'Attribute Id',
  `is_visible` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Is Visible',
  `input_filter` varchar(255) DEFAULT NULL COMMENT 'Input Filter',
  `multiline_count` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Multiline Count',
  `validate_rules` text COMMENT 'Validate Rules',
  `is_system` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is System',
  `sort_order` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Sort Order',
  `data_model` varchar(255) DEFAULT NULL COMMENT 'Data Model',
  PRIMARY KEY (`attribute_id`),
  CONSTRAINT `FK_CSTR_EAV_ATTR_ATTR_ID_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Customer Eav Attribute';

LOCK TABLES `customer_eav_attribute` WRITE;
/*!40000 ALTER TABLE `customer_eav_attribute` DISABLE KEYS */;

INSERT INTO `customer_eav_attribute` (`attribute_id`, `is_visible`, `input_filter`, `multiline_count`, `validate_rules`, `is_system`, `sort_order`, `data_model`)
VALUES
	(1,1,NULL,0,NULL,1,10,NULL),
	(2,0,NULL,0,NULL,1,0,NULL),
	(3,1,NULL,0,NULL,1,20,NULL),
	(4,0,NULL,0,NULL,0,30,NULL),
	(5,1,NULL,0,'a:2:{s:15:\"max_text_length\";i:255;s:15:\"min_text_length\";i:1;}',1,40,NULL),
	(6,1,NULL,0,NULL,0,50,NULL),
	(7,1,NULL,0,'a:2:{s:15:\"max_text_length\";i:255;s:15:\"min_text_length\";i:1;}',1,60,NULL),
	(8,0,NULL,0,NULL,0,70,NULL),
	(9,1,NULL,0,'a:1:{s:16:\"input_validation\";s:5:\"email\";}',1,80,NULL),
	(10,1,NULL,0,NULL,1,25,NULL),
	(11,0,'date',0,'a:1:{s:16:\"input_validation\";s:4:\"date\";}',0,90,NULL),
	(12,0,NULL,0,NULL,1,0,NULL),
	(13,0,NULL,0,NULL,1,0,NULL),
	(14,0,NULL,0,NULL,1,0,NULL),
	(15,0,NULL,0,'a:1:{s:15:\"max_text_length\";i:255;}',0,100,NULL),
	(16,0,NULL,0,NULL,1,0,NULL),
	(17,0,'datetime',0,NULL,0,0,NULL),
	(18,0,NULL,0,'a:0:{}',0,110,NULL),
	(19,0,NULL,0,NULL,0,10,NULL),
	(20,1,NULL,0,'a:2:{s:15:\"max_text_length\";i:255;s:15:\"min_text_length\";i:1;}',1,20,NULL),
	(21,1,NULL,0,NULL,0,30,NULL),
	(22,1,NULL,0,'a:2:{s:15:\"max_text_length\";i:255;s:15:\"min_text_length\";i:1;}',1,40,NULL),
	(23,0,NULL,0,NULL,0,50,NULL),
	(24,1,NULL,0,'a:2:{s:15:\"max_text_length\";i:255;s:15:\"min_text_length\";i:1;}',1,60,NULL),
	(25,1,NULL,2,'a:2:{s:15:\"max_text_length\";i:255;s:15:\"min_text_length\";i:1;}',1,70,NULL),
	(26,1,NULL,0,'a:2:{s:15:\"max_text_length\";i:255;s:15:\"min_text_length\";i:1;}',1,80,NULL),
	(27,1,NULL,0,NULL,1,90,NULL),
	(28,1,NULL,0,NULL,1,100,NULL),
	(29,1,NULL,0,NULL,1,100,NULL),
	(30,1,NULL,0,'a:0:{}',1,110,'customer/attribute_data_postcode'),
	(31,1,NULL,0,'a:2:{s:15:\"max_text_length\";i:255;s:15:\"min_text_length\";i:1;}',1,120,NULL),
	(32,1,NULL,0,'a:2:{s:15:\"max_text_length\";i:255;s:15:\"min_text_length\";i:1;}',1,130,NULL),
	(33,0,NULL,0,NULL,1,0,NULL),
	(34,0,NULL,0,'a:1:{s:16:\"input_validation\";s:4:\"date\";}',1,0,NULL),
	(35,1,NULL,0,NULL,1,28,NULL),
	(36,1,NULL,0,NULL,1,140,NULL),
	(37,0,NULL,0,NULL,1,0,NULL),
	(38,0,NULL,0,NULL,1,0,NULL),
	(39,0,NULL,0,NULL,1,0,NULL),
	(40,0,NULL,0,NULL,1,0,NULL);

/*!40000 ALTER TABLE `customer_eav_attribute` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table customer_eav_attribute_website
# ------------------------------------------------------------

DROP TABLE IF EXISTS `customer_eav_attribute_website`;

CREATE TABLE `customer_eav_attribute_website` (
  `attribute_id` smallint(5) unsigned NOT NULL COMMENT 'Attribute Id',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website Id',
  `is_visible` smallint(5) unsigned DEFAULT NULL COMMENT 'Is Visible',
  `is_required` smallint(5) unsigned DEFAULT NULL COMMENT 'Is Required',
  `default_value` text COMMENT 'Default Value',
  `multiline_count` smallint(5) unsigned DEFAULT NULL COMMENT 'Multiline Count',
  PRIMARY KEY (`attribute_id`,`website_id`),
  KEY `IDX_CUSTOMER_EAV_ATTRIBUTE_WEBSITE_WEBSITE_ID` (`website_id`),
  CONSTRAINT `FK_CSTR_EAV_ATTR_WS_ATTR_ID_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CSTR_EAV_ATTR_WS_WS_ID_CORE_WS_WS_ID` FOREIGN KEY (`website_id`) REFERENCES `core_website` (`website_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Customer Eav Attribute Website';



# Dump of table customer_entity
# ------------------------------------------------------------

DROP TABLE IF EXISTS `customer_entity`;

CREATE TABLE `customer_entity` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type Id',
  `attribute_set_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Set Id',
  `website_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Website Id',
  `email` varchar(255) DEFAULT NULL COMMENT 'Email',
  `group_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Group Id',
  `increment_id` varchar(50) DEFAULT NULL COMMENT 'Increment Id',
  `store_id` smallint(5) unsigned DEFAULT '0' COMMENT 'Store Id',
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Created At',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Updated At',
  `is_active` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Is Active',
  `disable_auto_group_change` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Disable automatic group change based on VAT ID',
  PRIMARY KEY (`entity_id`),
  UNIQUE KEY `UNQ_CUSTOMER_ENTITY_EMAIL_WEBSITE_ID` (`email`,`website_id`),
  KEY `IDX_CUSTOMER_ENTITY_STORE_ID` (`store_id`),
  KEY `IDX_CUSTOMER_ENTITY_ENTITY_TYPE_ID` (`entity_type_id`),
  KEY `IDX_CUSTOMER_ENTITY_EMAIL_WEBSITE_ID` (`email`,`website_id`),
  KEY `IDX_CUSTOMER_ENTITY_WEBSITE_ID` (`website_id`),
  CONSTRAINT `FK_CUSTOMER_ENTITY_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `FK_CUSTOMER_ENTITY_WEBSITE_ID_CORE_WEBSITE_WEBSITE_ID` FOREIGN KEY (`website_id`) REFERENCES `core_website` (`website_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Customer Entity';



# Dump of table customer_entity_datetime
# ------------------------------------------------------------

DROP TABLE IF EXISTS `customer_entity_datetime`;

CREATE TABLE `customer_entity_datetime` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value Id',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type Id',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Id',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Id',
  `value` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_CUSTOMER_ENTITY_DATETIME_ENTITY_ID_ATTRIBUTE_ID` (`entity_id`,`attribute_id`),
  KEY `IDX_CUSTOMER_ENTITY_DATETIME_ENTITY_TYPE_ID` (`entity_type_id`),
  KEY `IDX_CUSTOMER_ENTITY_DATETIME_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_CUSTOMER_ENTITY_DATETIME_ENTITY_ID` (`entity_id`),
  KEY `IDX_CUSTOMER_ENTITY_DATETIME_ENTITY_ID_ATTRIBUTE_ID_VALUE` (`entity_id`,`attribute_id`,`value`),
  CONSTRAINT `FK_CSTR_ENTT_DTIME_ATTR_ID_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CUSTOMER_ENTITY_DATETIME_ENTITY_ID_CUSTOMER_ENTITY_ENTITY_ID` FOREIGN KEY (`entity_id`) REFERENCES `customer_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CSTR_ENTT_DTIME_ENTT_TYPE_ID_EAV_ENTT_TYPE_ENTT_TYPE_ID` FOREIGN KEY (`entity_type_id`) REFERENCES `eav_entity_type` (`entity_type_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Customer Entity Datetime';



# Dump of table customer_entity_decimal
# ------------------------------------------------------------

DROP TABLE IF EXISTS `customer_entity_decimal`;

CREATE TABLE `customer_entity_decimal` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value Id',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type Id',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Id',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Id',
  `value` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_CUSTOMER_ENTITY_DECIMAL_ENTITY_ID_ATTRIBUTE_ID` (`entity_id`,`attribute_id`),
  KEY `IDX_CUSTOMER_ENTITY_DECIMAL_ENTITY_TYPE_ID` (`entity_type_id`),
  KEY `IDX_CUSTOMER_ENTITY_DECIMAL_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_CUSTOMER_ENTITY_DECIMAL_ENTITY_ID` (`entity_id`),
  KEY `IDX_CUSTOMER_ENTITY_DECIMAL_ENTITY_ID_ATTRIBUTE_ID_VALUE` (`entity_id`,`attribute_id`,`value`),
  CONSTRAINT `FK_CSTR_ENTT_DEC_ATTR_ID_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CUSTOMER_ENTITY_DECIMAL_ENTITY_ID_CUSTOMER_ENTITY_ENTITY_ID` FOREIGN KEY (`entity_id`) REFERENCES `customer_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CSTR_ENTT_DEC_ENTT_TYPE_ID_EAV_ENTT_TYPE_ENTT_TYPE_ID` FOREIGN KEY (`entity_type_id`) REFERENCES `eav_entity_type` (`entity_type_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Customer Entity Decimal';



# Dump of table customer_entity_int
# ------------------------------------------------------------

DROP TABLE IF EXISTS `customer_entity_int`;

CREATE TABLE `customer_entity_int` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value Id',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type Id',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Id',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Id',
  `value` int(11) NOT NULL DEFAULT '0' COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_CUSTOMER_ENTITY_INT_ENTITY_ID_ATTRIBUTE_ID` (`entity_id`,`attribute_id`),
  KEY `IDX_CUSTOMER_ENTITY_INT_ENTITY_TYPE_ID` (`entity_type_id`),
  KEY `IDX_CUSTOMER_ENTITY_INT_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_CUSTOMER_ENTITY_INT_ENTITY_ID` (`entity_id`),
  KEY `IDX_CUSTOMER_ENTITY_INT_ENTITY_ID_ATTRIBUTE_ID_VALUE` (`entity_id`,`attribute_id`,`value`),
  CONSTRAINT `FK_CUSTOMER_ENTITY_INT_ATTRIBUTE_ID_EAV_ATTRIBUTE_ATTRIBUTE_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CUSTOMER_ENTITY_INT_ENTITY_ID_CUSTOMER_ENTITY_ENTITY_ID` FOREIGN KEY (`entity_id`) REFERENCES `customer_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CSTR_ENTT_INT_ENTT_TYPE_ID_EAV_ENTT_TYPE_ENTT_TYPE_ID` FOREIGN KEY (`entity_type_id`) REFERENCES `eav_entity_type` (`entity_type_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Customer Entity Int';



# Dump of table customer_entity_text
# ------------------------------------------------------------

DROP TABLE IF EXISTS `customer_entity_text`;

CREATE TABLE `customer_entity_text` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value Id',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type Id',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Id',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Id',
  `value` text NOT NULL COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_CUSTOMER_ENTITY_TEXT_ENTITY_ID_ATTRIBUTE_ID` (`entity_id`,`attribute_id`),
  KEY `IDX_CUSTOMER_ENTITY_TEXT_ENTITY_TYPE_ID` (`entity_type_id`),
  KEY `IDX_CUSTOMER_ENTITY_TEXT_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_CUSTOMER_ENTITY_TEXT_ENTITY_ID` (`entity_id`),
  CONSTRAINT `FK_CUSTOMER_ENTITY_TEXT_ATTRIBUTE_ID_EAV_ATTRIBUTE_ATTRIBUTE_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CUSTOMER_ENTITY_TEXT_ENTITY_ID_CUSTOMER_ENTITY_ENTITY_ID` FOREIGN KEY (`entity_id`) REFERENCES `customer_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CSTR_ENTT_TEXT_ENTT_TYPE_ID_EAV_ENTT_TYPE_ENTT_TYPE_ID` FOREIGN KEY (`entity_type_id`) REFERENCES `eav_entity_type` (`entity_type_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Customer Entity Text';



# Dump of table customer_entity_varchar
# ------------------------------------------------------------

DROP TABLE IF EXISTS `customer_entity_varchar`;

CREATE TABLE `customer_entity_varchar` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value Id',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type Id',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Id',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Id',
  `value` varchar(255) DEFAULT NULL COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_CUSTOMER_ENTITY_VARCHAR_ENTITY_ID_ATTRIBUTE_ID` (`entity_id`,`attribute_id`),
  KEY `IDX_CUSTOMER_ENTITY_VARCHAR_ENTITY_TYPE_ID` (`entity_type_id`),
  KEY `IDX_CUSTOMER_ENTITY_VARCHAR_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_CUSTOMER_ENTITY_VARCHAR_ENTITY_ID` (`entity_id`),
  KEY `IDX_CUSTOMER_ENTITY_VARCHAR_ENTITY_ID_ATTRIBUTE_ID_VALUE` (`entity_id`,`attribute_id`,`value`),
  CONSTRAINT `FK_CSTR_ENTT_VCHR_ATTR_ID_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CUSTOMER_ENTITY_VARCHAR_ENTITY_ID_CUSTOMER_ENTITY_ENTITY_ID` FOREIGN KEY (`entity_id`) REFERENCES `customer_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_CSTR_ENTT_VCHR_ENTT_TYPE_ID_EAV_ENTT_TYPE_ENTT_TYPE_ID` FOREIGN KEY (`entity_type_id`) REFERENCES `eav_entity_type` (`entity_type_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Customer Entity Varchar';



# Dump of table customer_form_attribute
# ------------------------------------------------------------

DROP TABLE IF EXISTS `customer_form_attribute`;

CREATE TABLE `customer_form_attribute` (
  `form_code` varchar(32) NOT NULL COMMENT 'Form Code',
  `attribute_id` smallint(5) unsigned NOT NULL COMMENT 'Attribute Id',
  PRIMARY KEY (`form_code`,`attribute_id`),
  KEY `IDX_CUSTOMER_FORM_ATTRIBUTE_ATTRIBUTE_ID` (`attribute_id`),
  CONSTRAINT `FK_CSTR_FORM_ATTR_ATTR_ID_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Customer Form Attribute';

LOCK TABLES `customer_form_attribute` WRITE;
/*!40000 ALTER TABLE `customer_form_attribute` DISABLE KEYS */;

INSERT INTO `customer_form_attribute` (`form_code`, `attribute_id`)
VALUES
	('adminhtml_customer',1),
	('adminhtml_customer',3),
	('adminhtml_customer',4),
	('checkout_register',4),
	('customer_account_create',4),
	('customer_account_edit',4),
	('adminhtml_customer',5),
	('checkout_register',5),
	('customer_account_create',5),
	('customer_account_edit',5),
	('adminhtml_customer',6),
	('checkout_register',6),
	('customer_account_create',6),
	('customer_account_edit',6),
	('adminhtml_customer',7),
	('checkout_register',7),
	('customer_account_create',7),
	('customer_account_edit',7),
	('adminhtml_customer',8),
	('checkout_register',8),
	('customer_account_create',8),
	('customer_account_edit',8),
	('adminhtml_checkout',9),
	('adminhtml_customer',9),
	('checkout_register',9),
	('customer_account_create',9),
	('customer_account_edit',9),
	('adminhtml_checkout',10),
	('adminhtml_customer',10),
	('adminhtml_checkout',11),
	('adminhtml_customer',11),
	('checkout_register',11),
	('customer_account_create',11),
	('customer_account_edit',11),
	('adminhtml_checkout',15),
	('adminhtml_customer',15),
	('checkout_register',15),
	('customer_account_create',15),
	('customer_account_edit',15),
	('adminhtml_customer',17),
	('checkout_register',17),
	('customer_account_create',17),
	('customer_account_edit',17),
	('adminhtml_checkout',18),
	('adminhtml_customer',18),
	('checkout_register',18),
	('customer_account_create',18),
	('customer_account_edit',18),
	('adminhtml_customer_address',19),
	('customer_address_edit',19),
	('customer_register_address',19),
	('adminhtml_customer_address',20),
	('customer_address_edit',20),
	('customer_register_address',20),
	('adminhtml_customer_address',21),
	('customer_address_edit',21),
	('customer_register_address',21),
	('adminhtml_customer_address',22),
	('customer_address_edit',22),
	('customer_register_address',22),
	('adminhtml_customer_address',23),
	('customer_address_edit',23),
	('customer_register_address',23),
	('adminhtml_customer_address',24),
	('customer_address_edit',24),
	('customer_register_address',24),
	('adminhtml_customer_address',25),
	('customer_address_edit',25),
	('customer_register_address',25),
	('adminhtml_customer_address',26),
	('customer_address_edit',26),
	('customer_register_address',26),
	('adminhtml_customer_address',27),
	('customer_address_edit',27),
	('customer_register_address',27),
	('adminhtml_customer_address',28),
	('customer_address_edit',28),
	('customer_register_address',28),
	('adminhtml_customer_address',29),
	('customer_address_edit',29),
	('customer_register_address',29),
	('adminhtml_customer_address',30),
	('customer_address_edit',30),
	('customer_register_address',30),
	('adminhtml_customer_address',31),
	('customer_address_edit',31),
	('customer_register_address',31),
	('adminhtml_customer_address',32),
	('customer_address_edit',32),
	('customer_register_address',32),
	('adminhtml_customer',35),
	('adminhtml_customer_address',36),
	('customer_address_edit',36),
	('customer_register_address',36);

/*!40000 ALTER TABLE `customer_form_attribute` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table customer_group
# ------------------------------------------------------------

DROP TABLE IF EXISTS `customer_group`;

CREATE TABLE `customer_group` (
  `customer_group_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Customer Group Id',
  `customer_group_code` varchar(32) NOT NULL COMMENT 'Customer Group Code',
  `tax_class_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Tax Class Id',
  PRIMARY KEY (`customer_group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Customer Group';

LOCK TABLES `customer_group` WRITE;
/*!40000 ALTER TABLE `customer_group` DISABLE KEYS */;

INSERT INTO `customer_group` (`customer_group_id`, `customer_group_code`, `tax_class_id`)
VALUES
	(0,'NOT LOGGED IN',3),
	(1,'General',3),
	(2,'Wholesale',3),
	(3,'Retailer',3);

/*!40000 ALTER TABLE `customer_group` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table dataflow_batch
# ------------------------------------------------------------

DROP TABLE IF EXISTS `dataflow_batch`;

CREATE TABLE `dataflow_batch` (
  `batch_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Batch Id',
  `profile_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Profile ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  `adapter` varchar(128) DEFAULT NULL COMMENT 'Adapter',
  `params` text COMMENT 'Parameters',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Created At',
  PRIMARY KEY (`batch_id`),
  KEY `IDX_DATAFLOW_BATCH_PROFILE_ID` (`profile_id`),
  KEY `IDX_DATAFLOW_BATCH_STORE_ID` (`store_id`),
  KEY `IDX_DATAFLOW_BATCH_CREATED_AT` (`created_at`),
  CONSTRAINT `FK_DATAFLOW_BATCH_PROFILE_ID_DATAFLOW_PROFILE_PROFILE_ID` FOREIGN KEY (`profile_id`) REFERENCES `dataflow_profile` (`profile_id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `FK_DATAFLOW_BATCH_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Dataflow Batch';



# Dump of table dataflow_batch_export
# ------------------------------------------------------------

DROP TABLE IF EXISTS `dataflow_batch_export`;

CREATE TABLE `dataflow_batch_export` (
  `batch_export_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Batch Export Id',
  `batch_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Batch Id',
  `batch_data` longtext COMMENT 'Batch Data',
  `status` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Status',
  PRIMARY KEY (`batch_export_id`),
  KEY `IDX_DATAFLOW_BATCH_EXPORT_BATCH_ID` (`batch_id`),
  CONSTRAINT `FK_DATAFLOW_BATCH_EXPORT_BATCH_ID_DATAFLOW_BATCH_BATCH_ID` FOREIGN KEY (`batch_id`) REFERENCES `dataflow_batch` (`batch_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Dataflow Batch Export';



# Dump of table dataflow_batch_import
# ------------------------------------------------------------

DROP TABLE IF EXISTS `dataflow_batch_import`;

CREATE TABLE `dataflow_batch_import` (
  `batch_import_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Batch Import Id',
  `batch_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Batch Id',
  `batch_data` longtext COMMENT 'Batch Data',
  `status` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Status',
  PRIMARY KEY (`batch_import_id`),
  KEY `IDX_DATAFLOW_BATCH_IMPORT_BATCH_ID` (`batch_id`),
  CONSTRAINT `FK_DATAFLOW_BATCH_IMPORT_BATCH_ID_DATAFLOW_BATCH_BATCH_ID` FOREIGN KEY (`batch_id`) REFERENCES `dataflow_batch` (`batch_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Dataflow Batch Import';



# Dump of table dataflow_import_data
# ------------------------------------------------------------

DROP TABLE IF EXISTS `dataflow_import_data`;

CREATE TABLE `dataflow_import_data` (
  `import_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Import Id',
  `session_id` int(11) DEFAULT NULL COMMENT 'Session Id',
  `serial_number` int(11) NOT NULL DEFAULT '0' COMMENT 'Serial Number',
  `value` text COMMENT 'Value',
  `status` int(11) NOT NULL DEFAULT '0' COMMENT 'Status',
  PRIMARY KEY (`import_id`),
  KEY `IDX_DATAFLOW_IMPORT_DATA_SESSION_ID` (`session_id`),
  CONSTRAINT `FK_DATAFLOW_IMPORT_DATA_SESSION_ID_DATAFLOW_SESSION_SESSION_ID` FOREIGN KEY (`session_id`) REFERENCES `dataflow_session` (`session_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Dataflow Import Data';



# Dump of table dataflow_profile
# ------------------------------------------------------------

DROP TABLE IF EXISTS `dataflow_profile`;

CREATE TABLE `dataflow_profile` (
  `profile_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Profile Id',
  `name` varchar(255) DEFAULT NULL COMMENT 'Name',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Created At',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'Updated At',
  `actions_xml` text COMMENT 'Actions Xml',
  `gui_data` text COMMENT 'Gui Data',
  `direction` varchar(6) DEFAULT NULL COMMENT 'Direction',
  `entity_type` varchar(64) DEFAULT NULL COMMENT 'Entity Type',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  `data_transfer` varchar(11) DEFAULT NULL COMMENT 'Data Transfer',
  PRIMARY KEY (`profile_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Dataflow Profile';

LOCK TABLES `dataflow_profile` WRITE;
/*!40000 ALTER TABLE `dataflow_profile` DISABLE KEYS */;

INSERT INTO `dataflow_profile` (`profile_id`, `name`, `created_at`, `updated_at`, `actions_xml`, `gui_data`, `direction`, `entity_type`, `store_id`, `data_transfer`)
VALUES
	(1,'Export All Products','2015-10-02 19:23:31','2015-10-02 19:23:31','<action type=\"catalog/convert_adapter_product\" method=\"load\">\\r\\n    <var name=\"store\"><![CDATA[0]]></var>\\r\\n</action>\\r\\n\\r\\n<action type=\"catalog/convert_parser_product\" method=\"unparse\">\\r\\n    <var name=\"store\"><![CDATA[0]]></var>\\r\\n</action>\\r\\n\\r\\n<action type=\"dataflow/convert_mapper_column\" method=\"map\">\\r\\n</action>\\r\\n\\r\\n<action type=\"dataflow/convert_parser_csv\" method=\"unparse\">\\r\\n    <var name=\"delimiter\"><![CDATA[,]]></var>\\r\\n    <var name=\"enclose\"><![CDATA[\"]]></var>\\r\\n    <var name=\"fieldnames\">true</var>\\r\\n</action>\\r\\n\\r\\n<action type=\"dataflow/convert_adapter_io\" method=\"save\">\\r\\n    <var name=\"type\">file</var>\\r\\n    <var name=\"path\">var/export</var>\\r\\n    <var name=\"filename\"><![CDATA[export_all_products.csv]]></var>\\r\\n</action>\\r\\n\\r\\n','a:5:{s:4:\"file\";a:7:{s:4:\"type\";s:4:\"file\";s:8:\"filename\";s:23:\"export_all_products.csv\";s:4:\"path\";s:10:\"var/export\";s:4:\"host\";s:0:\"\";s:4:\"user\";s:0:\"\";s:8:\"password\";s:0:\"\";s:7:\"passive\";s:0:\"\";}s:5:\"parse\";a:5:{s:4:\"type\";s:3:\"csv\";s:12:\"single_sheet\";s:0:\"\";s:9:\"delimiter\";s:1:\",\";s:7:\"enclose\";s:1:\"\"\";s:10:\"fieldnames\";s:4:\"true\";}s:3:\"map\";a:3:{s:14:\"only_specified\";s:0:\"\";s:7:\"product\";a:2:{s:2:\"db\";a:0:{}s:4:\"file\";a:0:{}}s:8:\"customer\";a:2:{s:2:\"db\";a:0:{}s:4:\"file\";a:0:{}}}s:7:\"product\";a:1:{s:6:\"filter\";a:8:{s:4:\"name\";s:0:\"\";s:3:\"sku\";s:0:\"\";s:4:\"type\";s:1:\"0\";s:13:\"attribute_set\";s:0:\"\";s:5:\"price\";a:2:{s:4:\"from\";s:0:\"\";s:2:\"to\";s:0:\"\";}s:3:\"qty\";a:2:{s:4:\"from\";s:0:\"\";s:2:\"to\";s:0:\"\";}s:10:\"visibility\";s:1:\"0\";s:6:\"status\";s:1:\"0\";}}s:8:\"customer\";a:1:{s:6:\"filter\";a:10:{s:9:\"firstname\";s:0:\"\";s:8:\"lastname\";s:0:\"\";s:5:\"email\";s:0:\"\";s:5:\"group\";s:1:\"0\";s:10:\"adressType\";s:15:\"default_billing\";s:9:\"telephone\";s:0:\"\";s:8:\"postcode\";s:0:\"\";s:7:\"country\";s:0:\"\";s:6:\"region\";s:0:\"\";s:10:\"created_at\";a:2:{s:4:\"from\";s:0:\"\";s:2:\"to\";s:0:\"\";}}}}','export','product',0,'file'),
	(2,'Export Product Stocks','2015-10-02 19:23:31','2015-10-02 19:23:31','<action type=\"catalog/convert_adapter_product\" method=\"load\">\\r\\n    <var name=\"store\"><![CDATA[0]]></var>\\r\\n</action>\\r\\n\\r\\n<action type=\"catalog/convert_parser_product\" method=\"unparse\">\\r\\n    <var name=\"store\"><![CDATA[0]]></var>\\r\\n</action>\\r\\n\\r\\n<action type=\"dataflow/convert_mapper_column\" method=\"map\">\\r\\n</action>\\r\\n\\r\\n<action type=\"dataflow/convert_parser_csv\" method=\"unparse\">\\r\\n    <var name=\"delimiter\"><![CDATA[,]]></var>\\r\\n    <var name=\"enclose\"><![CDATA[\"]]></var>\\r\\n    <var name=\"fieldnames\">true</var>\\r\\n</action>\\r\\n\\r\\n<action type=\"dataflow/convert_adapter_io\" method=\"save\">\\r\\n    <var name=\"type\">file</var>\\r\\n    <var name=\"path\">var/export</var>\\r\\n    <var name=\"filename\"><![CDATA[export_all_products.csv]]></var>\\r\\n</action>\\r\\n\\r\\n','a:5:{s:4:\"file\";a:7:{s:4:\"type\";s:4:\"file\";s:8:\"filename\";s:25:\"export_product_stocks.csv\";s:4:\"path\";s:10:\"var/export\";s:4:\"host\";s:0:\"\";s:4:\"user\";s:0:\"\";s:8:\"password\";s:0:\"\";s:7:\"passive\";s:0:\"\";}s:5:\"parse\";a:5:{s:4:\"type\";s:3:\"csv\";s:12:\"single_sheet\";s:0:\"\";s:9:\"delimiter\";s:1:\",\";s:7:\"enclose\";s:1:\"\"\";s:10:\"fieldnames\";s:4:\"true\";}s:3:\"map\";a:3:{s:14:\"only_specified\";s:4:\"true\";s:7:\"product\";a:2:{s:2:\"db\";a:4:{i:1;s:5:\"store\";i:2;s:3:\"sku\";i:3;s:3:\"qty\";i:4;s:11:\"is_in_stock\";}s:4:\"file\";a:4:{i:1;s:5:\"store\";i:2;s:3:\"sku\";i:3;s:3:\"qty\";i:4;s:11:\"is_in_stock\";}}s:8:\"customer\";a:2:{s:2:\"db\";a:0:{}s:4:\"file\";a:0:{}}}s:7:\"product\";a:1:{s:6:\"filter\";a:8:{s:4:\"name\";s:0:\"\";s:3:\"sku\";s:0:\"\";s:4:\"type\";s:1:\"0\";s:13:\"attribute_set\";s:0:\"\";s:5:\"price\";a:2:{s:4:\"from\";s:0:\"\";s:2:\"to\";s:0:\"\";}s:3:\"qty\";a:2:{s:4:\"from\";s:0:\"\";s:2:\"to\";s:0:\"\";}s:10:\"visibility\";s:1:\"0\";s:6:\"status\";s:1:\"0\";}}s:8:\"customer\";a:1:{s:6:\"filter\";a:10:{s:9:\"firstname\";s:0:\"\";s:8:\"lastname\";s:0:\"\";s:5:\"email\";s:0:\"\";s:5:\"group\";s:1:\"0\";s:10:\"adressType\";s:15:\"default_billing\";s:9:\"telephone\";s:0:\"\";s:8:\"postcode\";s:0:\"\";s:7:\"country\";s:0:\"\";s:6:\"region\";s:0:\"\";s:10:\"created_at\";a:2:{s:4:\"from\";s:0:\"\";s:2:\"to\";s:0:\"\";}}}}','export','product',0,'file'),
	(3,'Import All Products','2015-10-02 19:23:31','2015-10-02 19:23:31','<action type=\"dataflow/convert_parser_csv\" method=\"parse\">\\r\\n    <var name=\"delimiter\"><![CDATA[,]]></var>\\r\\n    <var name=\"enclose\"><![CDATA[\"]]></var>\\r\\n    <var name=\"fieldnames\">true</var>\\r\\n    <var name=\"store\"><![CDATA[0]]></var>\\r\\n    <var name=\"adapter\">catalog/convert_adapter_product</var>\\r\\n    <var name=\"method\">parse</var>\\r\\n</action>','a:5:{s:4:\"file\";a:7:{s:4:\"type\";s:4:\"file\";s:8:\"filename\";s:23:\"export_all_products.csv\";s:4:\"path\";s:10:\"var/export\";s:4:\"host\";s:0:\"\";s:4:\"user\";s:0:\"\";s:8:\"password\";s:0:\"\";s:7:\"passive\";s:0:\"\";}s:5:\"parse\";a:5:{s:4:\"type\";s:3:\"csv\";s:12:\"single_sheet\";s:0:\"\";s:9:\"delimiter\";s:1:\",\";s:7:\"enclose\";s:1:\"\"\";s:10:\"fieldnames\";s:4:\"true\";}s:3:\"map\";a:3:{s:14:\"only_specified\";s:0:\"\";s:7:\"product\";a:2:{s:2:\"db\";a:0:{}s:4:\"file\";a:0:{}}s:8:\"customer\";a:2:{s:2:\"db\";a:0:{}s:4:\"file\";a:0:{}}}s:7:\"product\";a:1:{s:6:\"filter\";a:8:{s:4:\"name\";s:0:\"\";s:3:\"sku\";s:0:\"\";s:4:\"type\";s:1:\"0\";s:13:\"attribute_set\";s:0:\"\";s:5:\"price\";a:2:{s:4:\"from\";s:0:\"\";s:2:\"to\";s:0:\"\";}s:3:\"qty\";a:2:{s:4:\"from\";s:0:\"\";s:2:\"to\";s:0:\"\";}s:10:\"visibility\";s:1:\"0\";s:6:\"status\";s:1:\"0\";}}s:8:\"customer\";a:1:{s:6:\"filter\";a:10:{s:9:\"firstname\";s:0:\"\";s:8:\"lastname\";s:0:\"\";s:5:\"email\";s:0:\"\";s:5:\"group\";s:1:\"0\";s:10:\"adressType\";s:15:\"default_billing\";s:9:\"telephone\";s:0:\"\";s:8:\"postcode\";s:0:\"\";s:7:\"country\";s:0:\"\";s:6:\"region\";s:0:\"\";s:10:\"created_at\";a:2:{s:4:\"from\";s:0:\"\";s:2:\"to\";s:0:\"\";}}}}','import','product',0,'interactive'),
	(4,'Import Product Stocks','2015-10-02 19:23:31','2015-10-02 19:23:31','<action type=\"dataflow/convert_parser_csv\" method=\"parse\">\\r\\n    <var name=\"delimiter\"><![CDATA[,]]></var>\\r\\n    <var name=\"enclose\"><![CDATA[\"]]></var>\\r\\n    <var name=\"fieldnames\">true</var>\\r\\n    <var name=\"store\"><![CDATA[0]]></var>\\r\\n    <var name=\"adapter\">catalog/convert_adapter_product</var>\\r\\n    <var name=\"method\">parse</var>\\r\\n</action>','a:5:{s:4:\"file\";a:7:{s:4:\"type\";s:4:\"file\";s:8:\"filename\";s:18:\"export_product.csv\";s:4:\"path\";s:10:\"var/export\";s:4:\"host\";s:0:\"\";s:4:\"user\";s:0:\"\";s:8:\"password\";s:0:\"\";s:7:\"passive\";s:0:\"\";}s:5:\"parse\";a:5:{s:4:\"type\";s:3:\"csv\";s:12:\"single_sheet\";s:0:\"\";s:9:\"delimiter\";s:1:\",\";s:7:\"enclose\";s:1:\"\"\";s:10:\"fieldnames\";s:4:\"true\";}s:3:\"map\";a:3:{s:14:\"only_specified\";s:0:\"\";s:7:\"product\";a:2:{s:2:\"db\";a:0:{}s:4:\"file\";a:0:{}}s:8:\"customer\";a:2:{s:2:\"db\";a:0:{}s:4:\"file\";a:0:{}}}s:7:\"product\";a:1:{s:6:\"filter\";a:8:{s:4:\"name\";s:0:\"\";s:3:\"sku\";s:0:\"\";s:4:\"type\";s:1:\"0\";s:13:\"attribute_set\";s:0:\"\";s:5:\"price\";a:2:{s:4:\"from\";s:0:\"\";s:2:\"to\";s:0:\"\";}s:3:\"qty\";a:2:{s:4:\"from\";s:0:\"\";s:2:\"to\";s:0:\"\";}s:10:\"visibility\";s:1:\"0\";s:6:\"status\";s:1:\"0\";}}s:8:\"customer\";a:1:{s:6:\"filter\";a:10:{s:9:\"firstname\";s:0:\"\";s:8:\"lastname\";s:0:\"\";s:5:\"email\";s:0:\"\";s:5:\"group\";s:1:\"0\";s:10:\"adressType\";s:15:\"default_billing\";s:9:\"telephone\";s:0:\"\";s:8:\"postcode\";s:0:\"\";s:7:\"country\";s:0:\"\";s:6:\"region\";s:0:\"\";s:10:\"created_at\";a:2:{s:4:\"from\";s:0:\"\";s:2:\"to\";s:0:\"\";}}}}','import','product',0,'interactive'),
	(5,'Export Customers','2015-10-02 19:23:31','2015-10-02 19:23:31','<action type=\"customer/convert_adapter_customer\" method=\"load\">\\r\\n    <var name=\"store\"><![CDATA[0]]></var>\\r\\n    <var name=\"filter/adressType\"><![CDATA[default_billing]]></var>\\r\\n</action>\\r\\n\\r\\n<action type=\"customer/convert_parser_customer\" method=\"unparse\">\\r\\n    <var name=\"store\"><![CDATA[0]]></var>\\r\\n</action>\\r\\n\\r\\n<action type=\"dataflow/convert_mapper_column\" method=\"map\">\\r\\n</action>\\r\\n\\r\\n<action type=\"dataflow/convert_parser_csv\" method=\"unparse\">\\r\\n    <var name=\"delimiter\"><![CDATA[,]]></var>\\r\\n    <var name=\"enclose\"><![CDATA[\"]]></var>\\r\\n    <var name=\"fieldnames\">true</var>\\r\\n</action>\\r\\n\\r\\n<action type=\"dataflow/convert_adapter_io\" method=\"save\">\\r\\n    <var name=\"type\">file</var>\\r\\n    <var name=\"path\">var/export</var>\\r\\n    <var name=\"filename\"><![CDATA[export_customers.csv]]></var>\\r\\n</action>\\r\\n\\r\\n','a:5:{s:4:\"file\";a:7:{s:4:\"type\";s:4:\"file\";s:8:\"filename\";s:20:\"export_customers.csv\";s:4:\"path\";s:10:\"var/export\";s:4:\"host\";s:0:\"\";s:4:\"user\";s:0:\"\";s:8:\"password\";s:0:\"\";s:7:\"passive\";s:0:\"\";}s:5:\"parse\";a:5:{s:4:\"type\";s:3:\"csv\";s:12:\"single_sheet\";s:0:\"\";s:9:\"delimiter\";s:1:\",\";s:7:\"enclose\";s:1:\"\"\";s:10:\"fieldnames\";s:4:\"true\";}s:3:\"map\";a:3:{s:14:\"only_specified\";s:0:\"\";s:7:\"product\";a:2:{s:2:\"db\";a:0:{}s:4:\"file\";a:0:{}}s:8:\"customer\";a:2:{s:2:\"db\";a:0:{}s:4:\"file\";a:0:{}}}s:7:\"product\";a:1:{s:6:\"filter\";a:8:{s:4:\"name\";s:0:\"\";s:3:\"sku\";s:0:\"\";s:4:\"type\";s:1:\"0\";s:13:\"attribute_set\";s:0:\"\";s:5:\"price\";a:2:{s:4:\"from\";s:0:\"\";s:2:\"to\";s:0:\"\";}s:3:\"qty\";a:2:{s:4:\"from\";s:0:\"\";s:2:\"to\";s:0:\"\";}s:10:\"visibility\";s:1:\"0\";s:6:\"status\";s:1:\"0\";}}s:8:\"customer\";a:1:{s:6:\"filter\";a:10:{s:9:\"firstname\";s:0:\"\";s:8:\"lastname\";s:0:\"\";s:5:\"email\";s:0:\"\";s:5:\"group\";s:1:\"0\";s:10:\"adressType\";s:15:\"default_billing\";s:9:\"telephone\";s:0:\"\";s:8:\"postcode\";s:0:\"\";s:7:\"country\";s:0:\"\";s:6:\"region\";s:0:\"\";s:10:\"created_at\";a:2:{s:4:\"from\";s:0:\"\";s:2:\"to\";s:0:\"\";}}}}','export','customer',0,'file'),
	(6,'Import Customers','2015-10-02 19:23:31','2015-10-02 19:23:31','<action type=\"dataflow/convert_parser_csv\" method=\"parse\">\\r\\n    <var name=\"delimiter\"><![CDATA[,]]></var>\\r\\n    <var name=\"enclose\"><![CDATA[\"]]></var>\\r\\n    <var name=\"fieldnames\">true</var>\\r\\n    <var name=\"store\"><![CDATA[0]]></var>\\r\\n    <var name=\"adapter\">customer/convert_adapter_customer</var>\\r\\n    <var name=\"method\">parse</var>\\r\\n</action>','a:5:{s:4:\"file\";a:7:{s:4:\"type\";s:4:\"file\";s:8:\"filename\";s:19:\"export_customer.csv\";s:4:\"path\";s:10:\"var/export\";s:4:\"host\";s:0:\"\";s:4:\"user\";s:0:\"\";s:8:\"password\";s:0:\"\";s:7:\"passive\";s:0:\"\";}s:5:\"parse\";a:5:{s:4:\"type\";s:3:\"csv\";s:12:\"single_sheet\";s:0:\"\";s:9:\"delimiter\";s:1:\",\";s:7:\"enclose\";s:1:\"\"\";s:10:\"fieldnames\";s:4:\"true\";}s:3:\"map\";a:3:{s:14:\"only_specified\";s:0:\"\";s:7:\"product\";a:2:{s:2:\"db\";a:0:{}s:4:\"file\";a:0:{}}s:8:\"customer\";a:2:{s:2:\"db\";a:0:{}s:4:\"file\";a:0:{}}}s:7:\"product\";a:1:{s:6:\"filter\";a:8:{s:4:\"name\";s:0:\"\";s:3:\"sku\";s:0:\"\";s:4:\"type\";s:1:\"0\";s:13:\"attribute_set\";s:0:\"\";s:5:\"price\";a:2:{s:4:\"from\";s:0:\"\";s:2:\"to\";s:0:\"\";}s:3:\"qty\";a:2:{s:4:\"from\";s:0:\"\";s:2:\"to\";s:0:\"\";}s:10:\"visibility\";s:1:\"0\";s:6:\"status\";s:1:\"0\";}}s:8:\"customer\";a:1:{s:6:\"filter\";a:10:{s:9:\"firstname\";s:0:\"\";s:8:\"lastname\";s:0:\"\";s:5:\"email\";s:0:\"\";s:5:\"group\";s:1:\"0\";s:10:\"adressType\";s:15:\"default_billing\";s:9:\"telephone\";s:0:\"\";s:8:\"postcode\";s:0:\"\";s:7:\"country\";s:0:\"\";s:6:\"region\";s:0:\"\";s:10:\"created_at\";a:2:{s:4:\"from\";s:0:\"\";s:2:\"to\";s:0:\"\";}}}}','import','customer',0,'interactive');

/*!40000 ALTER TABLE `dataflow_profile` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table dataflow_profile_history
# ------------------------------------------------------------

DROP TABLE IF EXISTS `dataflow_profile_history`;

CREATE TABLE `dataflow_profile_history` (
  `history_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'History Id',
  `profile_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Profile Id',
  `action_code` varchar(64) DEFAULT NULL COMMENT 'Action Code',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'User Id',
  `performed_at` timestamp NULL DEFAULT NULL COMMENT 'Performed At',
  PRIMARY KEY (`history_id`),
  KEY `IDX_DATAFLOW_PROFILE_HISTORY_PROFILE_ID` (`profile_id`),
  CONSTRAINT `FK_AEA06B0C500063D3CE6EA671AE776645` FOREIGN KEY (`profile_id`) REFERENCES `dataflow_profile` (`profile_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Dataflow Profile History';

LOCK TABLES `dataflow_profile_history` WRITE;
/*!40000 ALTER TABLE `dataflow_profile_history` DISABLE KEYS */;

INSERT INTO `dataflow_profile_history` (`history_id`, `profile_id`, `action_code`, `user_id`, `performed_at`)
VALUES
	(1,1,'create',0,'2015-10-02 19:23:31'),
	(2,2,'create',0,'2015-10-02 19:23:31'),
	(3,3,'create',0,'2015-10-02 19:23:31'),
	(4,4,'create',0,'2015-10-02 19:23:31'),
	(5,5,'create',0,'2015-10-02 19:23:31'),
	(6,6,'create',0,'2015-10-02 19:23:31');

/*!40000 ALTER TABLE `dataflow_profile_history` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table dataflow_session
# ------------------------------------------------------------

DROP TABLE IF EXISTS `dataflow_session`;

CREATE TABLE `dataflow_session` (
  `session_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Session Id',
  `user_id` int(11) NOT NULL COMMENT 'User Id',
  `created_date` timestamp NULL DEFAULT NULL COMMENT 'Created Date',
  `file` varchar(255) DEFAULT NULL COMMENT 'File',
  `type` varchar(32) DEFAULT NULL COMMENT 'Type',
  `direction` varchar(32) DEFAULT NULL COMMENT 'Direction',
  `comment` varchar(255) DEFAULT NULL COMMENT 'Comment',
  PRIMARY KEY (`session_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Dataflow Session';



# Dump of table design_change
# ------------------------------------------------------------

DROP TABLE IF EXISTS `design_change`;

CREATE TABLE `design_change` (
  `design_change_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Design Change Id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  `design` varchar(255) DEFAULT NULL COMMENT 'Design',
  `date_from` date DEFAULT NULL COMMENT 'First Date of Design Activity',
  `date_to` date DEFAULT NULL COMMENT 'Last Date of Design Activity',
  PRIMARY KEY (`design_change_id`),
  KEY `IDX_DESIGN_CHANGE_STORE_ID` (`store_id`),
  CONSTRAINT `FK_DESIGN_CHANGE_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Design Changes';



# Dump of table directory_country
# ------------------------------------------------------------

DROP TABLE IF EXISTS `directory_country`;

CREATE TABLE `directory_country` (
  `country_id` varchar(2) NOT NULL DEFAULT '' COMMENT 'Country Id in ISO-2',
  `iso2_code` varchar(2) DEFAULT NULL COMMENT 'Country ISO-2 format',
  `iso3_code` varchar(3) DEFAULT NULL COMMENT 'Country ISO-3',
  PRIMARY KEY (`country_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Directory Country';

LOCK TABLES `directory_country` WRITE;
/*!40000 ALTER TABLE `directory_country` DISABLE KEYS */;

INSERT INTO `directory_country` (`country_id`, `iso2_code`, `iso3_code`)
VALUES
	('AD','AD','AND'),
	('AE','AE','ARE'),
	('AF','AF','AFG'),
	('AG','AG','ATG'),
	('AI','AI','AIA'),
	('AL','AL','ALB'),
	('AM','AM','ARM'),
	('AN','AN','ANT'),
	('AO','AO','AGO'),
	('AQ','AQ','ATA'),
	('AR','AR','ARG'),
	('AS','AS','ASM'),
	('AT','AT','AUT'),
	('AU','AU','AUS'),
	('AW','AW','ABW'),
	('AX','AX','ALA'),
	('AZ','AZ','AZE'),
	('BA','BA','BIH'),
	('BB','BB','BRB'),
	('BD','BD','BGD'),
	('BE','BE','BEL'),
	('BF','BF','BFA'),
	('BG','BG','BGR'),
	('BH','BH','BHR'),
	('BI','BI','BDI'),
	('BJ','BJ','BEN'),
	('BL','BL','BLM'),
	('BM','BM','BMU'),
	('BN','BN','BRN'),
	('BO','BO','BOL'),
	('BR','BR','BRA'),
	('BS','BS','BHS'),
	('BT','BT','BTN'),
	('BV','BV','BVT'),
	('BW','BW','BWA'),
	('BY','BY','BLR'),
	('BZ','BZ','BLZ'),
	('CA','CA','CAN'),
	('CC','CC','CCK'),
	('CD','CD','COD'),
	('CF','CF','CAF'),
	('CG','CG','COG'),
	('CH','CH','CHE'),
	('CI','CI','CIV'),
	('CK','CK','COK'),
	('CL','CL','CHL'),
	('CM','CM','CMR'),
	('CN','CN','CHN'),
	('CO','CO','COL'),
	('CR','CR','CRI'),
	('CU','CU','CUB'),
	('CV','CV','CPV'),
	('CX','CX','CXR'),
	('CY','CY','CYP'),
	('CZ','CZ','CZE'),
	('DE','DE','DEU'),
	('DJ','DJ','DJI'),
	('DK','DK','DNK'),
	('DM','DM','DMA'),
	('DO','DO','DOM'),
	('DZ','DZ','DZA'),
	('EC','EC','ECU'),
	('EE','EE','EST'),
	('EG','EG','EGY'),
	('EH','EH','ESH'),
	('ER','ER','ERI'),
	('ES','ES','ESP'),
	('ET','ET','ETH'),
	('FI','FI','FIN'),
	('FJ','FJ','FJI'),
	('FK','FK','FLK'),
	('FM','FM','FSM'),
	('FO','FO','FRO'),
	('FR','FR','FRA'),
	('GA','GA','GAB'),
	('GB','GB','GBR'),
	('GD','GD','GRD'),
	('GE','GE','GEO'),
	('GF','GF','GUF'),
	('GG','GG','GGY'),
	('GH','GH','GHA'),
	('GI','GI','GIB'),
	('GL','GL','GRL'),
	('GM','GM','GMB'),
	('GN','GN','GIN'),
	('GP','GP','GLP'),
	('GQ','GQ','GNQ'),
	('GR','GR','GRC'),
	('GS','GS','SGS'),
	('GT','GT','GTM'),
	('GU','GU','GUM'),
	('GW','GW','GNB'),
	('GY','GY','GUY'),
	('HK','HK','HKG'),
	('HM','HM','HMD'),
	('HN','HN','HND'),
	('HR','HR','HRV'),
	('HT','HT','HTI'),
	('HU','HU','HUN'),
	('ID','ID','IDN'),
	('IE','IE','IRL'),
	('IL','IL','ISR'),
	('IM','IM','IMN'),
	('IN','IN','IND'),
	('IO','IO','IOT'),
	('IQ','IQ','IRQ'),
	('IR','IR','IRN'),
	('IS','IS','ISL'),
	('IT','IT','ITA'),
	('JE','JE','JEY'),
	('JM','JM','JAM'),
	('JO','JO','JOR'),
	('JP','JP','JPN'),
	('KE','KE','KEN'),
	('KG','KG','KGZ'),
	('KH','KH','KHM'),
	('KI','KI','KIR'),
	('KM','KM','COM'),
	('KN','KN','KNA'),
	('KP','KP','PRK'),
	('KR','KR','KOR'),
	('KW','KW','KWT'),
	('KY','KY','CYM'),
	('KZ','KZ','KAZ'),
	('LA','LA','LAO'),
	('LB','LB','LBN'),
	('LC','LC','LCA'),
	('LI','LI','LIE'),
	('LK','LK','LKA'),
	('LR','LR','LBR'),
	('LS','LS','LSO'),
	('LT','LT','LTU'),
	('LU','LU','LUX'),
	('LV','LV','LVA'),
	('LY','LY','LBY'),
	('MA','MA','MAR'),
	('MC','MC','MCO'),
	('MD','MD','MDA'),
	('ME','ME','MNE'),
	('MF','MF','MAF'),
	('MG','MG','MDG'),
	('MH','MH','MHL'),
	('MK','MK','MKD'),
	('ML','ML','MLI'),
	('MM','MM','MMR'),
	('MN','MN','MNG'),
	('MO','MO','MAC'),
	('MP','MP','MNP'),
	('MQ','MQ','MTQ'),
	('MR','MR','MRT'),
	('MS','MS','MSR'),
	('MT','MT','MLT'),
	('MU','MU','MUS'),
	('MV','MV','MDV'),
	('MW','MW','MWI'),
	('MX','MX','MEX'),
	('MY','MY','MYS'),
	('MZ','MZ','MOZ'),
	('NA','NA','NAM'),
	('NC','NC','NCL'),
	('NE','NE','NER'),
	('NF','NF','NFK'),
	('NG','NG','NGA'),
	('NI','NI','NIC'),
	('NL','NL','NLD'),
	('NO','NO','NOR'),
	('NP','NP','NPL'),
	('NR','NR','NRU'),
	('NU','NU','NIU'),
	('NZ','NZ','NZL'),
	('OM','OM','OMN'),
	('PA','PA','PAN'),
	('PE','PE','PER'),
	('PF','PF','PYF'),
	('PG','PG','PNG'),
	('PH','PH','PHL'),
	('PK','PK','PAK'),
	('PL','PL','POL'),
	('PM','PM','SPM'),
	('PN','PN','PCN'),
	('PR','PR','PRI'),
	('PS','PS','PSE'),
	('PT','PT','PRT'),
	('PW','PW','PLW'),
	('PY','PY','PRY'),
	('QA','QA','QAT'),
	('RE','RE','REU'),
	('RO','RO','ROU'),
	('RS','RS','SRB'),
	('RU','RU','RUS'),
	('RW','RW','RWA'),
	('SA','SA','SAU'),
	('SB','SB','SLB'),
	('SC','SC','SYC'),
	('SD','SD','SDN'),
	('SE','SE','SWE'),
	('SG','SG','SGP'),
	('SH','SH','SHN'),
	('SI','SI','SVN'),
	('SJ','SJ','SJM'),
	('SK','SK','SVK'),
	('SL','SL','SLE'),
	('SM','SM','SMR'),
	('SN','SN','SEN'),
	('SO','SO','SOM'),
	('SR','SR','SUR'),
	('ST','ST','STP'),
	('SV','SV','SLV'),
	('SY','SY','SYR'),
	('SZ','SZ','SWZ'),
	('TC','TC','TCA'),
	('TD','TD','TCD'),
	('TF','TF','ATF'),
	('TG','TG','TGO'),
	('TH','TH','THA'),
	('TJ','TJ','TJK'),
	('TK','TK','TKL'),
	('TL','TL','TLS'),
	('TM','TM','TKM'),
	('TN','TN','TUN'),
	('TO','TO','TON'),
	('TR','TR','TUR'),
	('TT','TT','TTO'),
	('TV','TV','TUV'),
	('TW','TW','TWN'),
	('TZ','TZ','TZA'),
	('UA','UA','UKR'),
	('UG','UG','UGA'),
	('UM','UM','UMI'),
	('US','US','USA'),
	('UY','UY','URY'),
	('UZ','UZ','UZB'),
	('VA','VA','VAT'),
	('VC','VC','VCT'),
	('VE','VE','VEN'),
	('VG','VG','VGB'),
	('VI','VI','VIR'),
	('VN','VN','VNM'),
	('VU','VU','VUT'),
	('WF','WF','WLF'),
	('WS','WS','WSM'),
	('YE','YE','YEM'),
	('YT','YT','MYT'),
	('ZA','ZA','ZAF'),
	('ZM','ZM','ZMB'),
	('ZW','ZW','ZWE');

/*!40000 ALTER TABLE `directory_country` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table directory_country_format
# ------------------------------------------------------------

DROP TABLE IF EXISTS `directory_country_format`;

CREATE TABLE `directory_country_format` (
  `country_format_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Country Format Id',
  `country_id` varchar(2) DEFAULT NULL COMMENT 'Country Id in ISO-2',
  `type` varchar(30) DEFAULT NULL COMMENT 'Country Format Type',
  `format` text NOT NULL COMMENT 'Country Format',
  PRIMARY KEY (`country_format_id`),
  UNIQUE KEY `UNQ_DIRECTORY_COUNTRY_FORMAT_COUNTRY_ID_TYPE` (`country_id`,`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Directory Country Format';



# Dump of table directory_country_region
# ------------------------------------------------------------

DROP TABLE IF EXISTS `directory_country_region`;

CREATE TABLE `directory_country_region` (
  `region_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Region Id',
  `country_id` varchar(4) NOT NULL DEFAULT '0' COMMENT 'Country Id in ISO-2',
  `code` varchar(32) DEFAULT NULL COMMENT 'Region code',
  `default_name` varchar(255) DEFAULT NULL COMMENT 'Region Name',
  PRIMARY KEY (`region_id`),
  KEY `IDX_DIRECTORY_COUNTRY_REGION_COUNTRY_ID` (`country_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Directory Country Region';

LOCK TABLES `directory_country_region` WRITE;
/*!40000 ALTER TABLE `directory_country_region` DISABLE KEYS */;

INSERT INTO `directory_country_region` (`region_id`, `country_id`, `code`, `default_name`)
VALUES
	(1,'US','AL','Alabama'),
	(2,'US','AK','Alaska'),
	(3,'US','AS','American Samoa'),
	(4,'US','AZ','Arizona'),
	(5,'US','AR','Arkansas'),
	(6,'US','AF','Armed Forces Africa'),
	(7,'US','AA','Armed Forces Americas'),
	(8,'US','AC','Armed Forces Canada'),
	(9,'US','AE','Armed Forces Europe'),
	(10,'US','AM','Armed Forces Middle East'),
	(11,'US','AP','Armed Forces Pacific'),
	(12,'US','CA','California'),
	(13,'US','CO','Colorado'),
	(14,'US','CT','Connecticut'),
	(15,'US','DE','Delaware'),
	(16,'US','DC','District of Columbia'),
	(17,'US','FM','Federated States Of Micronesia'),
	(18,'US','FL','Florida'),
	(19,'US','GA','Georgia'),
	(20,'US','GU','Guam'),
	(21,'US','HI','Hawaii'),
	(22,'US','ID','Idaho'),
	(23,'US','IL','Illinois'),
	(24,'US','IN','Indiana'),
	(25,'US','IA','Iowa'),
	(26,'US','KS','Kansas'),
	(27,'US','KY','Kentucky'),
	(28,'US','LA','Louisiana'),
	(29,'US','ME','Maine'),
	(30,'US','MH','Marshall Islands'),
	(31,'US','MD','Maryland'),
	(32,'US','MA','Massachusetts'),
	(33,'US','MI','Michigan'),
	(34,'US','MN','Minnesota'),
	(35,'US','MS','Mississippi'),
	(36,'US','MO','Missouri'),
	(37,'US','MT','Montana'),
	(38,'US','NE','Nebraska'),
	(39,'US','NV','Nevada'),
	(40,'US','NH','New Hampshire'),
	(41,'US','NJ','New Jersey'),
	(42,'US','NM','New Mexico'),
	(43,'US','NY','New York'),
	(44,'US','NC','North Carolina'),
	(45,'US','ND','North Dakota'),
	(46,'US','MP','Northern Mariana Islands'),
	(47,'US','OH','Ohio'),
	(48,'US','OK','Oklahoma'),
	(49,'US','OR','Oregon'),
	(50,'US','PW','Palau'),
	(51,'US','PA','Pennsylvania'),
	(52,'US','PR','Puerto Rico'),
	(53,'US','RI','Rhode Island'),
	(54,'US','SC','South Carolina'),
	(55,'US','SD','South Dakota'),
	(56,'US','TN','Tennessee'),
	(57,'US','TX','Texas'),
	(58,'US','UT','Utah'),
	(59,'US','VT','Vermont'),
	(60,'US','VI','Virgin Islands'),
	(61,'US','VA','Virginia'),
	(62,'US','WA','Washington'),
	(63,'US','WV','West Virginia'),
	(64,'US','WI','Wisconsin'),
	(65,'US','WY','Wyoming'),
	(66,'CA','AB','Alberta'),
	(67,'CA','BC','British Columbia'),
	(68,'CA','MB','Manitoba'),
	(69,'CA','NL','Newfoundland and Labrador'),
	(70,'CA','NB','New Brunswick'),
	(71,'CA','NS','Nova Scotia'),
	(72,'CA','NT','Northwest Territories'),
	(73,'CA','NU','Nunavut'),
	(74,'CA','ON','Ontario'),
	(75,'CA','PE','Prince Edward Island'),
	(76,'CA','QC','Quebec'),
	(77,'CA','SK','Saskatchewan'),
	(78,'CA','YT','Yukon Territory'),
	(79,'DE','NDS','Niedersachsen'),
	(80,'DE','BAW','Baden-Württemberg'),
	(81,'DE','BAY','Bayern'),
	(82,'DE','BER','Berlin'),
	(83,'DE','BRG','Brandenburg'),
	(84,'DE','BRE','Bremen'),
	(85,'DE','HAM','Hamburg'),
	(86,'DE','HES','Hessen'),
	(87,'DE','MEC','Mecklenburg-Vorpommern'),
	(88,'DE','NRW','Nordrhein-Westfalen'),
	(89,'DE','RHE','Rheinland-Pfalz'),
	(90,'DE','SAR','Saarland'),
	(91,'DE','SAS','Sachsen'),
	(92,'DE','SAC','Sachsen-Anhalt'),
	(93,'DE','SCN','Schleswig-Holstein'),
	(94,'DE','THE','Thüringen'),
	(95,'AT','WI','Wien'),
	(96,'AT','NO','Niederösterreich'),
	(97,'AT','OO','Oberösterreich'),
	(98,'AT','SB','Salzburg'),
	(99,'AT','KN','Kärnten'),
	(100,'AT','ST','Steiermark'),
	(101,'AT','TI','Tirol'),
	(102,'AT','BL','Burgenland'),
	(103,'AT','VB','Vorarlberg'),
	(104,'CH','AG','Aargau'),
	(105,'CH','AI','Appenzell Innerrhoden'),
	(106,'CH','AR','Appenzell Ausserrhoden'),
	(107,'CH','BE','Bern'),
	(108,'CH','BL','Basel-Landschaft'),
	(109,'CH','BS','Basel-Stadt'),
	(110,'CH','FR','Freiburg'),
	(111,'CH','GE','Genf'),
	(112,'CH','GL','Glarus'),
	(113,'CH','GR','Graubünden'),
	(114,'CH','JU','Jura'),
	(115,'CH','LU','Luzern'),
	(116,'CH','NE','Neuenburg'),
	(117,'CH','NW','Nidwalden'),
	(118,'CH','OW','Obwalden'),
	(119,'CH','SG','St. Gallen'),
	(120,'CH','SH','Schaffhausen'),
	(121,'CH','SO','Solothurn'),
	(122,'CH','SZ','Schwyz'),
	(123,'CH','TG','Thurgau'),
	(124,'CH','TI','Tessin'),
	(125,'CH','UR','Uri'),
	(126,'CH','VD','Waadt'),
	(127,'CH','VS','Wallis'),
	(128,'CH','ZG','Zug'),
	(129,'CH','ZH','Zürich'),
	(130,'ES','A Coruсa','A Coruña'),
	(131,'ES','Alava','Alava'),
	(132,'ES','Albacete','Albacete'),
	(133,'ES','Alicante','Alicante'),
	(134,'ES','Almeria','Almeria'),
	(135,'ES','Asturias','Asturias'),
	(136,'ES','Avila','Avila'),
	(137,'ES','Badajoz','Badajoz'),
	(138,'ES','Baleares','Baleares'),
	(139,'ES','Barcelona','Barcelona'),
	(140,'ES','Burgos','Burgos'),
	(141,'ES','Caceres','Caceres'),
	(142,'ES','Cadiz','Cadiz'),
	(143,'ES','Cantabria','Cantabria'),
	(144,'ES','Castellon','Castellon'),
	(145,'ES','Ceuta','Ceuta'),
	(146,'ES','Ciudad Real','Ciudad Real'),
	(147,'ES','Cordoba','Cordoba'),
	(148,'ES','Cuenca','Cuenca'),
	(149,'ES','Girona','Girona'),
	(150,'ES','Granada','Granada'),
	(151,'ES','Guadalajara','Guadalajara'),
	(152,'ES','Guipuzcoa','Guipuzcoa'),
	(153,'ES','Huelva','Huelva'),
	(154,'ES','Huesca','Huesca'),
	(155,'ES','Jaen','Jaen'),
	(156,'ES','La Rioja','La Rioja'),
	(157,'ES','Las Palmas','Las Palmas'),
	(158,'ES','Leon','Leon'),
	(159,'ES','Lleida','Lleida'),
	(160,'ES','Lugo','Lugo'),
	(161,'ES','Madrid','Madrid'),
	(162,'ES','Malaga','Malaga'),
	(163,'ES','Melilla','Melilla'),
	(164,'ES','Murcia','Murcia'),
	(165,'ES','Navarra','Navarra'),
	(166,'ES','Ourense','Ourense'),
	(167,'ES','Palencia','Palencia'),
	(168,'ES','Pontevedra','Pontevedra'),
	(169,'ES','Salamanca','Salamanca'),
	(170,'ES','Santa Cruz de Tenerife','Santa Cruz de Tenerife'),
	(171,'ES','Segovia','Segovia'),
	(172,'ES','Sevilla','Sevilla'),
	(173,'ES','Soria','Soria'),
	(174,'ES','Tarragona','Tarragona'),
	(175,'ES','Teruel','Teruel'),
	(176,'ES','Toledo','Toledo'),
	(177,'ES','Valencia','Valencia'),
	(178,'ES','Valladolid','Valladolid'),
	(179,'ES','Vizcaya','Vizcaya'),
	(180,'ES','Zamora','Zamora'),
	(181,'ES','Zaragoza','Zaragoza'),
	(182,'FR','1','Ain'),
	(183,'FR','2','Aisne'),
	(184,'FR','3','Allier'),
	(185,'FR','4','Alpes-de-Haute-Provence'),
	(186,'FR','5','Hautes-Alpes'),
	(187,'FR','6','Alpes-Maritimes'),
	(188,'FR','7','Ardèche'),
	(189,'FR','8','Ardennes'),
	(190,'FR','9','Ariège'),
	(191,'FR','10','Aube'),
	(192,'FR','11','Aude'),
	(193,'FR','12','Aveyron'),
	(194,'FR','13','Bouches-du-Rhône'),
	(195,'FR','14','Calvados'),
	(196,'FR','15','Cantal'),
	(197,'FR','16','Charente'),
	(198,'FR','17','Charente-Maritime'),
	(199,'FR','18','Cher'),
	(200,'FR','19','Corrèze'),
	(201,'FR','2A','Corse-du-Sud'),
	(202,'FR','2B','Haute-Corse'),
	(203,'FR','21','Côte-d\'Or'),
	(204,'FR','22','Côtes-d\'Armor'),
	(205,'FR','23','Creuse'),
	(206,'FR','24','Dordogne'),
	(207,'FR','25','Doubs'),
	(208,'FR','26','Drôme'),
	(209,'FR','27','Eure'),
	(210,'FR','28','Eure-et-Loir'),
	(211,'FR','29','Finistère'),
	(212,'FR','30','Gard'),
	(213,'FR','31','Haute-Garonne'),
	(214,'FR','32','Gers'),
	(215,'FR','33','Gironde'),
	(216,'FR','34','Hérault'),
	(217,'FR','35','Ille-et-Vilaine'),
	(218,'FR','36','Indre'),
	(219,'FR','37','Indre-et-Loire'),
	(220,'FR','38','Isère'),
	(221,'FR','39','Jura'),
	(222,'FR','40','Landes'),
	(223,'FR','41','Loir-et-Cher'),
	(224,'FR','42','Loire'),
	(225,'FR','43','Haute-Loire'),
	(226,'FR','44','Loire-Atlantique'),
	(227,'FR','45','Loiret'),
	(228,'FR','46','Lot'),
	(229,'FR','47','Lot-et-Garonne'),
	(230,'FR','48','Lozère'),
	(231,'FR','49','Maine-et-Loire'),
	(232,'FR','50','Manche'),
	(233,'FR','51','Marne'),
	(234,'FR','52','Haute-Marne'),
	(235,'FR','53','Mayenne'),
	(236,'FR','54','Meurthe-et-Moselle'),
	(237,'FR','55','Meuse'),
	(238,'FR','56','Morbihan'),
	(239,'FR','57','Moselle'),
	(240,'FR','58','Nièvre'),
	(241,'FR','59','Nord'),
	(242,'FR','60','Oise'),
	(243,'FR','61','Orne'),
	(244,'FR','62','Pas-de-Calais'),
	(245,'FR','63','Puy-de-Dôme'),
	(246,'FR','64','Pyrénées-Atlantiques'),
	(247,'FR','65','Hautes-Pyrénées'),
	(248,'FR','66','Pyrénées-Orientales'),
	(249,'FR','67','Bas-Rhin'),
	(250,'FR','68','Haut-Rhin'),
	(251,'FR','69','Rhône'),
	(252,'FR','70','Haute-Saône'),
	(253,'FR','71','Saône-et-Loire'),
	(254,'FR','72','Sarthe'),
	(255,'FR','73','Savoie'),
	(256,'FR','74','Haute-Savoie'),
	(257,'FR','75','Paris'),
	(258,'FR','76','Seine-Maritime'),
	(259,'FR','77','Seine-et-Marne'),
	(260,'FR','78','Yvelines'),
	(261,'FR','79','Deux-Sèvres'),
	(262,'FR','80','Somme'),
	(263,'FR','81','Tarn'),
	(264,'FR','82','Tarn-et-Garonne'),
	(265,'FR','83','Var'),
	(266,'FR','84','Vaucluse'),
	(267,'FR','85','Vendée'),
	(268,'FR','86','Vienne'),
	(269,'FR','87','Haute-Vienne'),
	(270,'FR','88','Vosges'),
	(271,'FR','89','Yonne'),
	(272,'FR','90','Territoire-de-Belfort'),
	(273,'FR','91','Essonne'),
	(274,'FR','92','Hauts-de-Seine'),
	(275,'FR','93','Seine-Saint-Denis'),
	(276,'FR','94','Val-de-Marne'),
	(277,'FR','95','Val-d\'Oise'),
	(278,'RO','AB','Alba'),
	(279,'RO','AR','Arad'),
	(280,'RO','AG','Argeş'),
	(281,'RO','BC','Bacău'),
	(282,'RO','BH','Bihor'),
	(283,'RO','BN','Bistriţa-Năsăud'),
	(284,'RO','BT','Botoşani'),
	(285,'RO','BV','Braşov'),
	(286,'RO','BR','Brăila'),
	(287,'RO','B','Bucureşti'),
	(288,'RO','BZ','Buzău'),
	(289,'RO','CS','Caraş-Severin'),
	(290,'RO','CL','Călăraşi'),
	(291,'RO','CJ','Cluj'),
	(292,'RO','CT','Constanţa'),
	(293,'RO','CV','Covasna'),
	(294,'RO','DB','Dâmboviţa'),
	(295,'RO','DJ','Dolj'),
	(296,'RO','GL','Galaţi'),
	(297,'RO','GR','Giurgiu'),
	(298,'RO','GJ','Gorj'),
	(299,'RO','HR','Harghita'),
	(300,'RO','HD','Hunedoara'),
	(301,'RO','IL','Ialomiţa'),
	(302,'RO','IS','Iaşi'),
	(303,'RO','IF','Ilfov'),
	(304,'RO','MM','Maramureş'),
	(305,'RO','MH','Mehedinţi'),
	(306,'RO','MS','Mureş'),
	(307,'RO','NT','Neamţ'),
	(308,'RO','OT','Olt'),
	(309,'RO','PH','Prahova'),
	(310,'RO','SM','Satu-Mare'),
	(311,'RO','SJ','Sălaj'),
	(312,'RO','SB','Sibiu'),
	(313,'RO','SV','Suceava'),
	(314,'RO','TR','Teleorman'),
	(315,'RO','TM','Timiş'),
	(316,'RO','TL','Tulcea'),
	(317,'RO','VS','Vaslui'),
	(318,'RO','VL','Vâlcea'),
	(319,'RO','VN','Vrancea'),
	(320,'FI','Lappi','Lappi'),
	(321,'FI','Pohjois-Pohjanmaa','Pohjois-Pohjanmaa'),
	(322,'FI','Kainuu','Kainuu'),
	(323,'FI','Pohjois-Karjala','Pohjois-Karjala'),
	(324,'FI','Pohjois-Savo','Pohjois-Savo'),
	(325,'FI','Etelä-Savo','Etelä-Savo'),
	(326,'FI','Etelä-Pohjanmaa','Etelä-Pohjanmaa'),
	(327,'FI','Pohjanmaa','Pohjanmaa'),
	(328,'FI','Pirkanmaa','Pirkanmaa'),
	(329,'FI','Satakunta','Satakunta'),
	(330,'FI','Keski-Pohjanmaa','Keski-Pohjanmaa'),
	(331,'FI','Keski-Suomi','Keski-Suomi'),
	(332,'FI','Varsinais-Suomi','Varsinais-Suomi'),
	(333,'FI','Etelä-Karjala','Etelä-Karjala'),
	(334,'FI','Päijät-Häme','Päijät-Häme'),
	(335,'FI','Kanta-Häme','Kanta-Häme'),
	(336,'FI','Uusimaa','Uusimaa'),
	(337,'FI','Itä-Uusimaa','Itä-Uusimaa'),
	(338,'FI','Kymenlaakso','Kymenlaakso'),
	(339,'FI','Ahvenanmaa','Ahvenanmaa'),
	(340,'EE','EE-37','Harjumaa'),
	(341,'EE','EE-39','Hiiumaa'),
	(342,'EE','EE-44','Ida-Virumaa'),
	(343,'EE','EE-49','Jõgevamaa'),
	(344,'EE','EE-51','Järvamaa'),
	(345,'EE','EE-57','Läänemaa'),
	(346,'EE','EE-59','Lääne-Virumaa'),
	(347,'EE','EE-65','Põlvamaa'),
	(348,'EE','EE-67','Pärnumaa'),
	(349,'EE','EE-70','Raplamaa'),
	(350,'EE','EE-74','Saaremaa'),
	(351,'EE','EE-78','Tartumaa'),
	(352,'EE','EE-82','Valgamaa'),
	(353,'EE','EE-84','Viljandimaa'),
	(354,'EE','EE-86','Võrumaa'),
	(355,'LV','LV-DGV','Daugavpils'),
	(356,'LV','LV-JEL','Jelgava'),
	(357,'LV','Jēkabpils','Jēkabpils'),
	(358,'LV','LV-JUR','Jūrmala'),
	(359,'LV','LV-LPX','Liepāja'),
	(360,'LV','LV-LE','Liepājas novads'),
	(361,'LV','LV-REZ','Rēzekne'),
	(362,'LV','LV-RIX','Rīga'),
	(363,'LV','LV-RI','Rīgas novads'),
	(364,'LV','Valmiera','Valmiera'),
	(365,'LV','LV-VEN','Ventspils'),
	(366,'LV','Aglonas novads','Aglonas novads'),
	(367,'LV','LV-AI','Aizkraukles novads'),
	(368,'LV','Aizputes novads','Aizputes novads'),
	(369,'LV','Aknīstes novads','Aknīstes novads'),
	(370,'LV','Alojas novads','Alojas novads'),
	(371,'LV','Alsungas novads','Alsungas novads'),
	(372,'LV','LV-AL','Alūksnes novads'),
	(373,'LV','Amatas novads','Amatas novads'),
	(374,'LV','Apes novads','Apes novads'),
	(375,'LV','Auces novads','Auces novads'),
	(376,'LV','Babītes novads','Babītes novads'),
	(377,'LV','Baldones novads','Baldones novads'),
	(378,'LV','Baltinavas novads','Baltinavas novads'),
	(379,'LV','LV-BL','Balvu novads'),
	(380,'LV','LV-BU','Bauskas novads'),
	(381,'LV','Beverīnas novads','Beverīnas novads'),
	(382,'LV','Brocēnu novads','Brocēnu novads'),
	(383,'LV','Burtnieku novads','Burtnieku novads'),
	(384,'LV','Carnikavas novads','Carnikavas novads'),
	(385,'LV','Cesvaines novads','Cesvaines novads'),
	(386,'LV','Ciblas novads','Ciblas novads'),
	(387,'LV','LV-CE','Cēsu novads'),
	(388,'LV','Dagdas novads','Dagdas novads'),
	(389,'LV','LV-DA','Daugavpils novads'),
	(390,'LV','LV-DO','Dobeles novads'),
	(391,'LV','Dundagas novads','Dundagas novads'),
	(392,'LV','Durbes novads','Durbes novads'),
	(393,'LV','Engures novads','Engures novads'),
	(394,'LV','Garkalnes novads','Garkalnes novads'),
	(395,'LV','Grobiņas novads','Grobiņas novads'),
	(396,'LV','LV-GU','Gulbenes novads'),
	(397,'LV','Iecavas novads','Iecavas novads'),
	(398,'LV','Ikšķiles novads','Ikšķiles novads'),
	(399,'LV','Ilūkstes novads','Ilūkstes novads'),
	(400,'LV','Inčukalna novads','Inčukalna novads'),
	(401,'LV','Jaunjelgavas novads','Jaunjelgavas novads'),
	(402,'LV','Jaunpiebalgas novads','Jaunpiebalgas novads'),
	(403,'LV','Jaunpils novads','Jaunpils novads'),
	(404,'LV','LV-JL','Jelgavas novads'),
	(405,'LV','LV-JK','Jēkabpils novads'),
	(406,'LV','Kandavas novads','Kandavas novads'),
	(407,'LV','Kokneses novads','Kokneses novads'),
	(408,'LV','Krimuldas novads','Krimuldas novads'),
	(409,'LV','Krustpils novads','Krustpils novads'),
	(410,'LV','LV-KR','Krāslavas novads'),
	(411,'LV','LV-KU','Kuldīgas novads'),
	(412,'LV','Kārsavas novads','Kārsavas novads'),
	(413,'LV','Lielvārdes novads','Lielvārdes novads'),
	(414,'LV','LV-LM','Limbažu novads'),
	(415,'LV','Lubānas novads','Lubānas novads'),
	(416,'LV','LV-LU','Ludzas novads'),
	(417,'LV','Līgatnes novads','Līgatnes novads'),
	(418,'LV','Līvānu novads','Līvānu novads'),
	(419,'LV','LV-MA','Madonas novads'),
	(420,'LV','Mazsalacas novads','Mazsalacas novads'),
	(421,'LV','Mālpils novads','Mālpils novads'),
	(422,'LV','Mārupes novads','Mārupes novads'),
	(423,'LV','Naukšēnu novads','Naukšēnu novads'),
	(424,'LV','Neretas novads','Neretas novads'),
	(425,'LV','Nīcas novads','Nīcas novads'),
	(426,'LV','LV-OG','Ogres novads'),
	(427,'LV','Olaines novads','Olaines novads'),
	(428,'LV','Ozolnieku novads','Ozolnieku novads'),
	(429,'LV','LV-PR','Preiļu novads'),
	(430,'LV','Priekules novads','Priekules novads'),
	(431,'LV','Priekuļu novads','Priekuļu novads'),
	(432,'LV','Pārgaujas novads','Pārgaujas novads'),
	(433,'LV','Pāvilostas novads','Pāvilostas novads'),
	(434,'LV','Pļaviņu novads','Pļaviņu novads'),
	(435,'LV','Raunas novads','Raunas novads'),
	(436,'LV','Riebiņu novads','Riebiņu novads'),
	(437,'LV','Rojas novads','Rojas novads'),
	(438,'LV','Ropažu novads','Ropažu novads'),
	(439,'LV','Rucavas novads','Rucavas novads'),
	(440,'LV','Rugāju novads','Rugāju novads'),
	(441,'LV','Rundāles novads','Rundāles novads'),
	(442,'LV','LV-RE','Rēzeknes novads'),
	(443,'LV','Rūjienas novads','Rūjienas novads'),
	(444,'LV','Salacgrīvas novads','Salacgrīvas novads'),
	(445,'LV','Salas novads','Salas novads'),
	(446,'LV','Salaspils novads','Salaspils novads'),
	(447,'LV','LV-SA','Saldus novads'),
	(448,'LV','Saulkrastu novads','Saulkrastu novads'),
	(449,'LV','Siguldas novads','Siguldas novads'),
	(450,'LV','Skrundas novads','Skrundas novads'),
	(451,'LV','Skrīveru novads','Skrīveru novads'),
	(452,'LV','Smiltenes novads','Smiltenes novads'),
	(453,'LV','Stopiņu novads','Stopiņu novads'),
	(454,'LV','Strenču novads','Strenču novads'),
	(455,'LV','Sējas novads','Sējas novads'),
	(456,'LV','LV-TA','Talsu novads'),
	(457,'LV','LV-TU','Tukuma novads'),
	(458,'LV','Tērvetes novads','Tērvetes novads'),
	(459,'LV','Vaiņodes novads','Vaiņodes novads'),
	(460,'LV','LV-VK','Valkas novads'),
	(461,'LV','LV-VM','Valmieras novads'),
	(462,'LV','Varakļānu novads','Varakļānu novads'),
	(463,'LV','Vecpiebalgas novads','Vecpiebalgas novads'),
	(464,'LV','Vecumnieku novads','Vecumnieku novads'),
	(465,'LV','LV-VE','Ventspils novads'),
	(466,'LV','Viesītes novads','Viesītes novads'),
	(467,'LV','Viļakas novads','Viļakas novads'),
	(468,'LV','Viļānu novads','Viļānu novads'),
	(469,'LV','Vārkavas novads','Vārkavas novads'),
	(470,'LV','Zilupes novads','Zilupes novads'),
	(471,'LV','Ādažu novads','Ādažu novads'),
	(472,'LV','Ērgļu novads','Ērgļu novads'),
	(473,'LV','Ķeguma novads','Ķeguma novads'),
	(474,'LV','Ķekavas novads','Ķekavas novads'),
	(475,'LT','LT-AL','Alytaus Apskritis'),
	(476,'LT','LT-KU','Kauno Apskritis'),
	(477,'LT','LT-KL','Klaipėdos Apskritis'),
	(478,'LT','LT-MR','Marijampolės Apskritis'),
	(479,'LT','LT-PN','Panevėžio Apskritis'),
	(480,'LT','LT-SA','Šiaulių Apskritis'),
	(481,'LT','LT-TA','Tauragės Apskritis'),
	(482,'LT','LT-TE','Telšių Apskritis'),
	(483,'LT','LT-UT','Utenos Apskritis'),
	(484,'LT','LT-VL','Vilniaus Apskritis');

/*!40000 ALTER TABLE `directory_country_region` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table directory_country_region_name
# ------------------------------------------------------------

DROP TABLE IF EXISTS `directory_country_region_name`;

CREATE TABLE `directory_country_region_name` (
  `locale` varchar(8) NOT NULL DEFAULT '' COMMENT 'Locale',
  `region_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Region Id',
  `name` varchar(255) DEFAULT NULL COMMENT 'Region Name',
  PRIMARY KEY (`locale`,`region_id`),
  KEY `IDX_DIRECTORY_COUNTRY_REGION_NAME_REGION_ID` (`region_id`),
  CONSTRAINT `FK_D7CFDEB379F775328EB6F62695E2B3E1` FOREIGN KEY (`region_id`) REFERENCES `directory_country_region` (`region_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Directory Country Region Name';

LOCK TABLES `directory_country_region_name` WRITE;
/*!40000 ALTER TABLE `directory_country_region_name` DISABLE KEYS */;

INSERT INTO `directory_country_region_name` (`locale`, `region_id`, `name`)
VALUES
	('en_US',1,'Alabama'),
	('en_US',2,'Alaska'),
	('en_US',3,'American Samoa'),
	('en_US',4,'Arizona'),
	('en_US',5,'Arkansas'),
	('en_US',6,'Armed Forces Africa'),
	('en_US',7,'Armed Forces Americas'),
	('en_US',8,'Armed Forces Canada'),
	('en_US',9,'Armed Forces Europe'),
	('en_US',10,'Armed Forces Middle East'),
	('en_US',11,'Armed Forces Pacific'),
	('en_US',12,'California'),
	('en_US',13,'Colorado'),
	('en_US',14,'Connecticut'),
	('en_US',15,'Delaware'),
	('en_US',16,'District of Columbia'),
	('en_US',17,'Federated States Of Micronesia'),
	('en_US',18,'Florida'),
	('en_US',19,'Georgia'),
	('en_US',20,'Guam'),
	('en_US',21,'Hawaii'),
	('en_US',22,'Idaho'),
	('en_US',23,'Illinois'),
	('en_US',24,'Indiana'),
	('en_US',25,'Iowa'),
	('en_US',26,'Kansas'),
	('en_US',27,'Kentucky'),
	('en_US',28,'Louisiana'),
	('en_US',29,'Maine'),
	('en_US',30,'Marshall Islands'),
	('en_US',31,'Maryland'),
	('en_US',32,'Massachusetts'),
	('en_US',33,'Michigan'),
	('en_US',34,'Minnesota'),
	('en_US',35,'Mississippi'),
	('en_US',36,'Missouri'),
	('en_US',37,'Montana'),
	('en_US',38,'Nebraska'),
	('en_US',39,'Nevada'),
	('en_US',40,'New Hampshire'),
	('en_US',41,'New Jersey'),
	('en_US',42,'New Mexico'),
	('en_US',43,'New York'),
	('en_US',44,'North Carolina'),
	('en_US',45,'North Dakota'),
	('en_US',46,'Northern Mariana Islands'),
	('en_US',47,'Ohio'),
	('en_US',48,'Oklahoma'),
	('en_US',49,'Oregon'),
	('en_US',50,'Palau'),
	('en_US',51,'Pennsylvania'),
	('en_US',52,'Puerto Rico'),
	('en_US',53,'Rhode Island'),
	('en_US',54,'South Carolina'),
	('en_US',55,'South Dakota'),
	('en_US',56,'Tennessee'),
	('en_US',57,'Texas'),
	('en_US',58,'Utah'),
	('en_US',59,'Vermont'),
	('en_US',60,'Virgin Islands'),
	('en_US',61,'Virginia'),
	('en_US',62,'Washington'),
	('en_US',63,'West Virginia'),
	('en_US',64,'Wisconsin'),
	('en_US',65,'Wyoming'),
	('en_US',66,'Alberta'),
	('en_US',67,'British Columbia'),
	('en_US',68,'Manitoba'),
	('en_US',69,'Newfoundland and Labrador'),
	('en_US',70,'New Brunswick'),
	('en_US',71,'Nova Scotia'),
	('en_US',72,'Northwest Territories'),
	('en_US',73,'Nunavut'),
	('en_US',74,'Ontario'),
	('en_US',75,'Prince Edward Island'),
	('en_US',76,'Quebec'),
	('en_US',77,'Saskatchewan'),
	('en_US',78,'Yukon Territory'),
	('en_US',79,'Niedersachsen'),
	('en_US',80,'Baden-Württemberg'),
	('en_US',81,'Bayern'),
	('en_US',82,'Berlin'),
	('en_US',83,'Brandenburg'),
	('en_US',84,'Bremen'),
	('en_US',85,'Hamburg'),
	('en_US',86,'Hessen'),
	('en_US',87,'Mecklenburg-Vorpommern'),
	('en_US',88,'Nordrhein-Westfalen'),
	('en_US',89,'Rheinland-Pfalz'),
	('en_US',90,'Saarland'),
	('en_US',91,'Sachsen'),
	('en_US',92,'Sachsen-Anhalt'),
	('en_US',93,'Schleswig-Holstein'),
	('en_US',94,'Thüringen'),
	('en_US',95,'Wien'),
	('en_US',96,'Niederösterreich'),
	('en_US',97,'Oberösterreich'),
	('en_US',98,'Salzburg'),
	('en_US',99,'Kärnten'),
	('en_US',100,'Steiermark'),
	('en_US',101,'Tirol'),
	('en_US',102,'Burgenland'),
	('en_US',103,'Vorarlberg'),
	('en_US',104,'Aargau'),
	('en_US',105,'Appenzell Innerrhoden'),
	('en_US',106,'Appenzell Ausserrhoden'),
	('en_US',107,'Bern'),
	('en_US',108,'Basel-Landschaft'),
	('en_US',109,'Basel-Stadt'),
	('en_US',110,'Freiburg'),
	('en_US',111,'Genf'),
	('en_US',112,'Glarus'),
	('en_US',113,'Graubünden'),
	('en_US',114,'Jura'),
	('en_US',115,'Luzern'),
	('en_US',116,'Neuenburg'),
	('en_US',117,'Nidwalden'),
	('en_US',118,'Obwalden'),
	('en_US',119,'St. Gallen'),
	('en_US',120,'Schaffhausen'),
	('en_US',121,'Solothurn'),
	('en_US',122,'Schwyz'),
	('en_US',123,'Thurgau'),
	('en_US',124,'Tessin'),
	('en_US',125,'Uri'),
	('en_US',126,'Waadt'),
	('en_US',127,'Wallis'),
	('en_US',128,'Zug'),
	('en_US',129,'Zürich'),
	('en_US',130,'A Coruña'),
	('en_US',131,'Alava'),
	('en_US',132,'Albacete'),
	('en_US',133,'Alicante'),
	('en_US',134,'Almeria'),
	('en_US',135,'Asturias'),
	('en_US',136,'Avila'),
	('en_US',137,'Badajoz'),
	('en_US',138,'Baleares'),
	('en_US',139,'Barcelona'),
	('en_US',140,'Burgos'),
	('en_US',141,'Caceres'),
	('en_US',142,'Cadiz'),
	('en_US',143,'Cantabria'),
	('en_US',144,'Castellon'),
	('en_US',145,'Ceuta'),
	('en_US',146,'Ciudad Real'),
	('en_US',147,'Cordoba'),
	('en_US',148,'Cuenca'),
	('en_US',149,'Girona'),
	('en_US',150,'Granada'),
	('en_US',151,'Guadalajara'),
	('en_US',152,'Guipuzcoa'),
	('en_US',153,'Huelva'),
	('en_US',154,'Huesca'),
	('en_US',155,'Jaen'),
	('en_US',156,'La Rioja'),
	('en_US',157,'Las Palmas'),
	('en_US',158,'Leon'),
	('en_US',159,'Lleida'),
	('en_US',160,'Lugo'),
	('en_US',161,'Madrid'),
	('en_US',162,'Malaga'),
	('en_US',163,'Melilla'),
	('en_US',164,'Murcia'),
	('en_US',165,'Navarra'),
	('en_US',166,'Ourense'),
	('en_US',167,'Palencia'),
	('en_US',168,'Pontevedra'),
	('en_US',169,'Salamanca'),
	('en_US',170,'Santa Cruz de Tenerife'),
	('en_US',171,'Segovia'),
	('en_US',172,'Sevilla'),
	('en_US',173,'Soria'),
	('en_US',174,'Tarragona'),
	('en_US',175,'Teruel'),
	('en_US',176,'Toledo'),
	('en_US',177,'Valencia'),
	('en_US',178,'Valladolid'),
	('en_US',179,'Vizcaya'),
	('en_US',180,'Zamora'),
	('en_US',181,'Zaragoza'),
	('en_US',182,'Ain'),
	('en_US',183,'Aisne'),
	('en_US',184,'Allier'),
	('en_US',185,'Alpes-de-Haute-Provence'),
	('en_US',186,'Hautes-Alpes'),
	('en_US',187,'Alpes-Maritimes'),
	('en_US',188,'Ardèche'),
	('en_US',189,'Ardennes'),
	('en_US',190,'Ariège'),
	('en_US',191,'Aube'),
	('en_US',192,'Aude'),
	('en_US',193,'Aveyron'),
	('en_US',194,'Bouches-du-Rhône'),
	('en_US',195,'Calvados'),
	('en_US',196,'Cantal'),
	('en_US',197,'Charente'),
	('en_US',198,'Charente-Maritime'),
	('en_US',199,'Cher'),
	('en_US',200,'Corrèze'),
	('en_US',201,'Corse-du-Sud'),
	('en_US',202,'Haute-Corse'),
	('en_US',203,'Côte-d\'Or'),
	('en_US',204,'Côtes-d\'Armor'),
	('en_US',205,'Creuse'),
	('en_US',206,'Dordogne'),
	('en_US',207,'Doubs'),
	('en_US',208,'Drôme'),
	('en_US',209,'Eure'),
	('en_US',210,'Eure-et-Loir'),
	('en_US',211,'Finistère'),
	('en_US',212,'Gard'),
	('en_US',213,'Haute-Garonne'),
	('en_US',214,'Gers'),
	('en_US',215,'Gironde'),
	('en_US',216,'Hérault'),
	('en_US',217,'Ille-et-Vilaine'),
	('en_US',218,'Indre'),
	('en_US',219,'Indre-et-Loire'),
	('en_US',220,'Isère'),
	('en_US',221,'Jura'),
	('en_US',222,'Landes'),
	('en_US',223,'Loir-et-Cher'),
	('en_US',224,'Loire'),
	('en_US',225,'Haute-Loire'),
	('en_US',226,'Loire-Atlantique'),
	('en_US',227,'Loiret'),
	('en_US',228,'Lot'),
	('en_US',229,'Lot-et-Garonne'),
	('en_US',230,'Lozère'),
	('en_US',231,'Maine-et-Loire'),
	('en_US',232,'Manche'),
	('en_US',233,'Marne'),
	('en_US',234,'Haute-Marne'),
	('en_US',235,'Mayenne'),
	('en_US',236,'Meurthe-et-Moselle'),
	('en_US',237,'Meuse'),
	('en_US',238,'Morbihan'),
	('en_US',239,'Moselle'),
	('en_US',240,'Nièvre'),
	('en_US',241,'Nord'),
	('en_US',242,'Oise'),
	('en_US',243,'Orne'),
	('en_US',244,'Pas-de-Calais'),
	('en_US',245,'Puy-de-Dôme'),
	('en_US',246,'Pyrénées-Atlantiques'),
	('en_US',247,'Hautes-Pyrénées'),
	('en_US',248,'Pyrénées-Orientales'),
	('en_US',249,'Bas-Rhin'),
	('en_US',250,'Haut-Rhin'),
	('en_US',251,'Rhône'),
	('en_US',252,'Haute-Saône'),
	('en_US',253,'Saône-et-Loire'),
	('en_US',254,'Sarthe'),
	('en_US',255,'Savoie'),
	('en_US',256,'Haute-Savoie'),
	('en_US',257,'Paris'),
	('en_US',258,'Seine-Maritime'),
	('en_US',259,'Seine-et-Marne'),
	('en_US',260,'Yvelines'),
	('en_US',261,'Deux-Sèvres'),
	('en_US',262,'Somme'),
	('en_US',263,'Tarn'),
	('en_US',264,'Tarn-et-Garonne'),
	('en_US',265,'Var'),
	('en_US',266,'Vaucluse'),
	('en_US',267,'Vendée'),
	('en_US',268,'Vienne'),
	('en_US',269,'Haute-Vienne'),
	('en_US',270,'Vosges'),
	('en_US',271,'Yonne'),
	('en_US',272,'Territoire-de-Belfort'),
	('en_US',273,'Essonne'),
	('en_US',274,'Hauts-de-Seine'),
	('en_US',275,'Seine-Saint-Denis'),
	('en_US',276,'Val-de-Marne'),
	('en_US',277,'Val-d\'Oise'),
	('en_US',278,'Alba'),
	('en_US',279,'Arad'),
	('en_US',280,'Argeş'),
	('en_US',281,'Bacău'),
	('en_US',282,'Bihor'),
	('en_US',283,'Bistriţa-Năsăud'),
	('en_US',284,'Botoşani'),
	('en_US',285,'Braşov'),
	('en_US',286,'Brăila'),
	('en_US',287,'Bucureşti'),
	('en_US',288,'Buzău'),
	('en_US',289,'Caraş-Severin'),
	('en_US',290,'Călăraşi'),
	('en_US',291,'Cluj'),
	('en_US',292,'Constanţa'),
	('en_US',293,'Covasna'),
	('en_US',294,'Dâmboviţa'),
	('en_US',295,'Dolj'),
	('en_US',296,'Galaţi'),
	('en_US',297,'Giurgiu'),
	('en_US',298,'Gorj'),
	('en_US',299,'Harghita'),
	('en_US',300,'Hunedoara'),
	('en_US',301,'Ialomiţa'),
	('en_US',302,'Iaşi'),
	('en_US',303,'Ilfov'),
	('en_US',304,'Maramureş'),
	('en_US',305,'Mehedinţi'),
	('en_US',306,'Mureş'),
	('en_US',307,'Neamţ'),
	('en_US',308,'Olt'),
	('en_US',309,'Prahova'),
	('en_US',310,'Satu-Mare'),
	('en_US',311,'Sălaj'),
	('en_US',312,'Sibiu'),
	('en_US',313,'Suceava'),
	('en_US',314,'Teleorman'),
	('en_US',315,'Timiş'),
	('en_US',316,'Tulcea'),
	('en_US',317,'Vaslui'),
	('en_US',318,'Vâlcea'),
	('en_US',319,'Vrancea'),
	('en_US',320,'Lappi'),
	('en_US',321,'Pohjois-Pohjanmaa'),
	('en_US',322,'Kainuu'),
	('en_US',323,'Pohjois-Karjala'),
	('en_US',324,'Pohjois-Savo'),
	('en_US',325,'Etelä-Savo'),
	('en_US',326,'Etelä-Pohjanmaa'),
	('en_US',327,'Pohjanmaa'),
	('en_US',328,'Pirkanmaa'),
	('en_US',329,'Satakunta'),
	('en_US',330,'Keski-Pohjanmaa'),
	('en_US',331,'Keski-Suomi'),
	('en_US',332,'Varsinais-Suomi'),
	('en_US',333,'Etelä-Karjala'),
	('en_US',334,'Päijät-Häme'),
	('en_US',335,'Kanta-Häme'),
	('en_US',336,'Uusimaa'),
	('en_US',337,'Itä-Uusimaa'),
	('en_US',338,'Kymenlaakso'),
	('en_US',339,'Ahvenanmaa'),
	('en_US',340,'Harjumaa'),
	('en_US',341,'Hiiumaa'),
	('en_US',342,'Ida-Virumaa'),
	('en_US',343,'Jõgevamaa'),
	('en_US',344,'Järvamaa'),
	('en_US',345,'Läänemaa'),
	('en_US',346,'Lääne-Virumaa'),
	('en_US',347,'Põlvamaa'),
	('en_US',348,'Pärnumaa'),
	('en_US',349,'Raplamaa'),
	('en_US',350,'Saaremaa'),
	('en_US',351,'Tartumaa'),
	('en_US',352,'Valgamaa'),
	('en_US',353,'Viljandimaa'),
	('en_US',354,'Võrumaa'),
	('en_US',355,'Daugavpils'),
	('en_US',356,'Jelgava'),
	('en_US',357,'Jēkabpils'),
	('en_US',358,'Jūrmala'),
	('en_US',359,'Liepāja'),
	('en_US',360,'Liepājas novads'),
	('en_US',361,'Rēzekne'),
	('en_US',362,'Rīga'),
	('en_US',363,'Rīgas novads'),
	('en_US',364,'Valmiera'),
	('en_US',365,'Ventspils'),
	('en_US',366,'Aglonas novads'),
	('en_US',367,'Aizkraukles novads'),
	('en_US',368,'Aizputes novads'),
	('en_US',369,'Aknīstes novads'),
	('en_US',370,'Alojas novads'),
	('en_US',371,'Alsungas novads'),
	('en_US',372,'Alūksnes novads'),
	('en_US',373,'Amatas novads'),
	('en_US',374,'Apes novads'),
	('en_US',375,'Auces novads'),
	('en_US',376,'Babītes novads'),
	('en_US',377,'Baldones novads'),
	('en_US',378,'Baltinavas novads'),
	('en_US',379,'Balvu novads'),
	('en_US',380,'Bauskas novads'),
	('en_US',381,'Beverīnas novads'),
	('en_US',382,'Brocēnu novads'),
	('en_US',383,'Burtnieku novads'),
	('en_US',384,'Carnikavas novads'),
	('en_US',385,'Cesvaines novads'),
	('en_US',386,'Ciblas novads'),
	('en_US',387,'Cēsu novads'),
	('en_US',388,'Dagdas novads'),
	('en_US',389,'Daugavpils novads'),
	('en_US',390,'Dobeles novads'),
	('en_US',391,'Dundagas novads'),
	('en_US',392,'Durbes novads'),
	('en_US',393,'Engures novads'),
	('en_US',394,'Garkalnes novads'),
	('en_US',395,'Grobiņas novads'),
	('en_US',396,'Gulbenes novads'),
	('en_US',397,'Iecavas novads'),
	('en_US',398,'Ikšķiles novads'),
	('en_US',399,'Ilūkstes novads'),
	('en_US',400,'Inčukalna novads'),
	('en_US',401,'Jaunjelgavas novads'),
	('en_US',402,'Jaunpiebalgas novads'),
	('en_US',403,'Jaunpils novads'),
	('en_US',404,'Jelgavas novads'),
	('en_US',405,'Jēkabpils novads'),
	('en_US',406,'Kandavas novads'),
	('en_US',407,'Kokneses novads'),
	('en_US',408,'Krimuldas novads'),
	('en_US',409,'Krustpils novads'),
	('en_US',410,'Krāslavas novads'),
	('en_US',411,'Kuldīgas novads'),
	('en_US',412,'Kārsavas novads'),
	('en_US',413,'Lielvārdes novads'),
	('en_US',414,'Limbažu novads'),
	('en_US',415,'Lubānas novads'),
	('en_US',416,'Ludzas novads'),
	('en_US',417,'Līgatnes novads'),
	('en_US',418,'Līvānu novads'),
	('en_US',419,'Madonas novads'),
	('en_US',420,'Mazsalacas novads'),
	('en_US',421,'Mālpils novads'),
	('en_US',422,'Mārupes novads'),
	('en_US',423,'Naukšēnu novads'),
	('en_US',424,'Neretas novads'),
	('en_US',425,'Nīcas novads'),
	('en_US',426,'Ogres novads'),
	('en_US',427,'Olaines novads'),
	('en_US',428,'Ozolnieku novads'),
	('en_US',429,'Preiļu novads'),
	('en_US',430,'Priekules novads'),
	('en_US',431,'Priekuļu novads'),
	('en_US',432,'Pārgaujas novads'),
	('en_US',433,'Pāvilostas novads'),
	('en_US',434,'Pļaviņu novads'),
	('en_US',435,'Raunas novads'),
	('en_US',436,'Riebiņu novads'),
	('en_US',437,'Rojas novads'),
	('en_US',438,'Ropažu novads'),
	('en_US',439,'Rucavas novads'),
	('en_US',440,'Rugāju novads'),
	('en_US',441,'Rundāles novads'),
	('en_US',442,'Rēzeknes novads'),
	('en_US',443,'Rūjienas novads'),
	('en_US',444,'Salacgrīvas novads'),
	('en_US',445,'Salas novads'),
	('en_US',446,'Salaspils novads'),
	('en_US',447,'Saldus novads'),
	('en_US',448,'Saulkrastu novads'),
	('en_US',449,'Siguldas novads'),
	('en_US',450,'Skrundas novads'),
	('en_US',451,'Skrīveru novads'),
	('en_US',452,'Smiltenes novads'),
	('en_US',453,'Stopiņu novads'),
	('en_US',454,'Strenču novads'),
	('en_US',455,'Sējas novads'),
	('en_US',456,'Talsu novads'),
	('en_US',457,'Tukuma novads'),
	('en_US',458,'Tērvetes novads'),
	('en_US',459,'Vaiņodes novads'),
	('en_US',460,'Valkas novads'),
	('en_US',461,'Valmieras novads'),
	('en_US',462,'Varakļānu novads'),
	('en_US',463,'Vecpiebalgas novads'),
	('en_US',464,'Vecumnieku novads'),
	('en_US',465,'Ventspils novads'),
	('en_US',466,'Viesītes novads'),
	('en_US',467,'Viļakas novads'),
	('en_US',468,'Viļānu novads'),
	('en_US',469,'Vārkavas novads'),
	('en_US',470,'Zilupes novads'),
	('en_US',471,'Ādažu novads'),
	('en_US',472,'Ērgļu novads'),
	('en_US',473,'Ķeguma novads'),
	('en_US',474,'Ķekavas novads'),
	('en_US',475,'Alytaus Apskritis'),
	('en_US',476,'Kauno Apskritis'),
	('en_US',477,'Klaipėdos Apskritis'),
	('en_US',478,'Marijampolės Apskritis'),
	('en_US',479,'Panevėžio Apskritis'),
	('en_US',480,'Šiaulių Apskritis'),
	('en_US',481,'Tauragės Apskritis'),
	('en_US',482,'Telšių Apskritis'),
	('en_US',483,'Utenos Apskritis'),
	('en_US',484,'Vilniaus Apskritis');

/*!40000 ALTER TABLE `directory_country_region_name` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table directory_currency_rate
# ------------------------------------------------------------

DROP TABLE IF EXISTS `directory_currency_rate`;

CREATE TABLE `directory_currency_rate` (
  `currency_from` varchar(3) NOT NULL DEFAULT '' COMMENT 'Currency Code Convert From',
  `currency_to` varchar(3) NOT NULL DEFAULT '' COMMENT 'Currency Code Convert To',
  `rate` decimal(24,12) NOT NULL DEFAULT '0.000000000000' COMMENT 'Currency Conversion Rate',
  PRIMARY KEY (`currency_from`,`currency_to`),
  KEY `IDX_DIRECTORY_CURRENCY_RATE_CURRENCY_TO` (`currency_to`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Directory Currency Rate';

LOCK TABLES `directory_currency_rate` WRITE;
/*!40000 ALTER TABLE `directory_currency_rate` DISABLE KEYS */;

INSERT INTO `directory_currency_rate` (`currency_from`, `currency_to`, `rate`)
VALUES
	('EUR','EUR',1.000000000000),
	('EUR','USD',1.415000000000),
	('USD','EUR',0.706700000000),
	('USD','USD',1.000000000000);

/*!40000 ALTER TABLE `directory_currency_rate` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table downloadable_link
# ------------------------------------------------------------

DROP TABLE IF EXISTS `downloadable_link`;

CREATE TABLE `downloadable_link` (
  `link_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Link ID',
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product ID',
  `sort_order` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Sort order',
  `number_of_downloads` int(11) DEFAULT NULL COMMENT 'Number of downloads',
  `is_shareable` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Shareable flag',
  `link_url` varchar(255) DEFAULT NULL COMMENT 'Link Url',
  `link_file` varchar(255) DEFAULT NULL COMMENT 'Link File',
  `link_type` varchar(20) DEFAULT NULL COMMENT 'Link Type',
  `sample_url` varchar(255) DEFAULT NULL COMMENT 'Sample Url',
  `sample_file` varchar(255) DEFAULT NULL COMMENT 'Sample File',
  `sample_type` varchar(20) DEFAULT NULL COMMENT 'Sample Type',
  PRIMARY KEY (`link_id`),
  KEY `IDX_DOWNLOADABLE_LINK_PRODUCT_ID` (`product_id`),
  KEY `IDX_DOWNLOADABLE_LINK_PRODUCT_ID_SORT_ORDER` (`product_id`,`sort_order`),
  CONSTRAINT `FK_DOWNLOADABLE_LINK_PRODUCT_ID_CATALOG_PRODUCT_ENTITY_ENTITY_ID` FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Downloadable Link Table';



# Dump of table downloadable_link_price
# ------------------------------------------------------------

DROP TABLE IF EXISTS `downloadable_link_price`;

CREATE TABLE `downloadable_link_price` (
  `price_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Price ID',
  `link_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Link ID',
  `website_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Website ID',
  `price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Price',
  PRIMARY KEY (`price_id`),
  KEY `IDX_DOWNLOADABLE_LINK_PRICE_LINK_ID` (`link_id`),
  KEY `IDX_DOWNLOADABLE_LINK_PRICE_WEBSITE_ID` (`website_id`),
  CONSTRAINT `FK_DOWNLOADABLE_LINK_PRICE_LINK_ID_DOWNLOADABLE_LINK_LINK_ID` FOREIGN KEY (`link_id`) REFERENCES `downloadable_link` (`link_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_DOWNLOADABLE_LINK_PRICE_WEBSITE_ID_CORE_WEBSITE_WEBSITE_ID` FOREIGN KEY (`website_id`) REFERENCES `core_website` (`website_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Downloadable Link Price Table';



# Dump of table downloadable_link_purchased
# ------------------------------------------------------------

DROP TABLE IF EXISTS `downloadable_link_purchased`;

CREATE TABLE `downloadable_link_purchased` (
  `purchased_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Purchased ID',
  `order_id` int(10) unsigned DEFAULT '0' COMMENT 'Order ID',
  `order_increment_id` varchar(50) DEFAULT NULL COMMENT 'Order Increment ID',
  `order_item_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Order Item ID',
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Date of creation',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Date of modification',
  `customer_id` int(10) unsigned DEFAULT '0' COMMENT 'Customer ID',
  `product_name` varchar(255) DEFAULT NULL COMMENT 'Product name',
  `product_sku` varchar(255) DEFAULT NULL COMMENT 'Product sku',
  `link_section_title` varchar(255) DEFAULT NULL COMMENT 'Link_section_title',
  PRIMARY KEY (`purchased_id`),
  KEY `IDX_DOWNLOADABLE_LINK_PURCHASED_ORDER_ID` (`order_id`),
  KEY `IDX_DOWNLOADABLE_LINK_PURCHASED_ORDER_ITEM_ID` (`order_item_id`),
  KEY `IDX_DOWNLOADABLE_LINK_PURCHASED_CUSTOMER_ID` (`customer_id`),
  CONSTRAINT `FK_DL_LNK_PURCHASED_CSTR_ID_CSTR_ENTT_ENTT_ID` FOREIGN KEY (`customer_id`) REFERENCES `customer_entity` (`entity_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `FK_DL_LNK_PURCHASED_ORDER_ID_SALES_FLAT_ORDER_ENTT_ID` FOREIGN KEY (`order_id`) REFERENCES `sales_flat_order` (`entity_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Downloadable Link Purchased Table';



# Dump of table downloadable_link_purchased_item
# ------------------------------------------------------------

DROP TABLE IF EXISTS `downloadable_link_purchased_item`;

CREATE TABLE `downloadable_link_purchased_item` (
  `item_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Item ID',
  `purchased_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Purchased ID',
  `order_item_id` int(10) unsigned DEFAULT '0' COMMENT 'Order Item ID',
  `product_id` int(10) unsigned DEFAULT '0' COMMENT 'Product ID',
  `link_hash` varchar(255) DEFAULT NULL COMMENT 'Link hash',
  `number_of_downloads_bought` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Number of downloads bought',
  `number_of_downloads_used` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Number of downloads used',
  `link_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Link ID',
  `link_title` varchar(255) DEFAULT NULL COMMENT 'Link Title',
  `is_shareable` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Shareable Flag',
  `link_url` varchar(255) DEFAULT NULL COMMENT 'Link Url',
  `link_file` varchar(255) DEFAULT NULL COMMENT 'Link File',
  `link_type` varchar(255) DEFAULT NULL COMMENT 'Link Type',
  `status` varchar(50) DEFAULT NULL COMMENT 'Status',
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Creation Time',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Update Time',
  PRIMARY KEY (`item_id`),
  KEY `IDX_DOWNLOADABLE_LINK_PURCHASED_ITEM_LINK_HASH` (`link_hash`),
  KEY `IDX_DOWNLOADABLE_LINK_PURCHASED_ITEM_ORDER_ITEM_ID` (`order_item_id`),
  KEY `IDX_DOWNLOADABLE_LINK_PURCHASED_ITEM_PURCHASED_ID` (`purchased_id`),
  CONSTRAINT `FK_46CC8E252307CE62F00A8F1887512A39` FOREIGN KEY (`purchased_id`) REFERENCES `downloadable_link_purchased` (`purchased_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_B219BF25756700DEE44550B21220ECCE` FOREIGN KEY (`order_item_id`) REFERENCES `sales_flat_order_item` (`item_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Downloadable Link Purchased Item Table';



# Dump of table downloadable_link_title
# ------------------------------------------------------------

DROP TABLE IF EXISTS `downloadable_link_title`;

CREATE TABLE `downloadable_link_title` (
  `title_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Title ID',
  `link_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Link ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `title` varchar(255) DEFAULT NULL COMMENT 'Title',
  PRIMARY KEY (`title_id`),
  UNIQUE KEY `UNQ_DOWNLOADABLE_LINK_TITLE_LINK_ID_STORE_ID` (`link_id`,`store_id`),
  KEY `IDX_DOWNLOADABLE_LINK_TITLE_LINK_ID` (`link_id`),
  KEY `IDX_DOWNLOADABLE_LINK_TITLE_STORE_ID` (`store_id`),
  CONSTRAINT `FK_DOWNLOADABLE_LINK_TITLE_LINK_ID_DOWNLOADABLE_LINK_LINK_ID` FOREIGN KEY (`link_id`) REFERENCES `downloadable_link` (`link_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_DOWNLOADABLE_LINK_TITLE_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Link Title Table';



# Dump of table downloadable_sample
# ------------------------------------------------------------

DROP TABLE IF EXISTS `downloadable_sample`;

CREATE TABLE `downloadable_sample` (
  `sample_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Sample ID',
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product ID',
  `sample_url` varchar(255) DEFAULT NULL COMMENT 'Sample URL',
  `sample_file` varchar(255) DEFAULT NULL COMMENT 'Sample file',
  `sample_type` varchar(20) DEFAULT NULL COMMENT 'Sample Type',
  `sort_order` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Sort Order',
  PRIMARY KEY (`sample_id`),
  KEY `IDX_DOWNLOADABLE_SAMPLE_PRODUCT_ID` (`product_id`),
  CONSTRAINT `FK_DL_SAMPLE_PRD_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Downloadable Sample Table';



# Dump of table downloadable_sample_title
# ------------------------------------------------------------

DROP TABLE IF EXISTS `downloadable_sample_title`;

CREATE TABLE `downloadable_sample_title` (
  `title_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Title ID',
  `sample_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Sample ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `title` varchar(255) DEFAULT NULL COMMENT 'Title',
  PRIMARY KEY (`title_id`),
  UNIQUE KEY `UNQ_DOWNLOADABLE_SAMPLE_TITLE_SAMPLE_ID_STORE_ID` (`sample_id`,`store_id`),
  KEY `IDX_DOWNLOADABLE_SAMPLE_TITLE_SAMPLE_ID` (`sample_id`),
  KEY `IDX_DOWNLOADABLE_SAMPLE_TITLE_STORE_ID` (`store_id`),
  CONSTRAINT `FK_DL_SAMPLE_TTL_SAMPLE_ID_DL_SAMPLE_SAMPLE_ID` FOREIGN KEY (`sample_id`) REFERENCES `downloadable_sample` (`sample_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_DOWNLOADABLE_SAMPLE_TITLE_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Downloadable Sample Title Table';



# Dump of table eav_attribute
# ------------------------------------------------------------

DROP TABLE IF EXISTS `eav_attribute`;

CREATE TABLE `eav_attribute` (
  `attribute_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Attribute Id',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type Id',
  `attribute_code` varchar(255) DEFAULT NULL COMMENT 'Attribute Code',
  `attribute_model` varchar(255) DEFAULT NULL COMMENT 'Attribute Model',
  `backend_model` varchar(255) DEFAULT NULL COMMENT 'Backend Model',
  `backend_type` varchar(8) NOT NULL DEFAULT 'static' COMMENT 'Backend Type',
  `backend_table` varchar(255) DEFAULT NULL COMMENT 'Backend Table',
  `frontend_model` varchar(255) DEFAULT NULL COMMENT 'Frontend Model',
  `frontend_input` varchar(50) DEFAULT NULL COMMENT 'Frontend Input',
  `frontend_label` varchar(255) DEFAULT NULL COMMENT 'Frontend Label',
  `frontend_class` varchar(255) DEFAULT NULL COMMENT 'Frontend Class',
  `source_model` varchar(255) DEFAULT NULL COMMENT 'Source Model',
  `is_required` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Defines Is Required',
  `is_user_defined` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Defines Is User Defined',
  `default_value` text COMMENT 'Default Value',
  `is_unique` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Defines Is Unique',
  `note` varchar(255) DEFAULT NULL COMMENT 'Note',
  PRIMARY KEY (`attribute_id`),
  UNIQUE KEY `UNQ_EAV_ATTRIBUTE_ENTITY_TYPE_ID_ATTRIBUTE_CODE` (`entity_type_id`,`attribute_code`),
  KEY `IDX_EAV_ATTRIBUTE_ENTITY_TYPE_ID` (`entity_type_id`),
  CONSTRAINT `FK_EAV_ATTRIBUTE_ENTITY_TYPE_ID_EAV_ENTITY_TYPE_ENTITY_TYPE_ID` FOREIGN KEY (`entity_type_id`) REFERENCES `eav_entity_type` (`entity_type_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Eav Attribute';

LOCK TABLES `eav_attribute` WRITE;
/*!40000 ALTER TABLE `eav_attribute` DISABLE KEYS */;

INSERT INTO `eav_attribute` (`attribute_id`, `entity_type_id`, `attribute_code`, `attribute_model`, `backend_model`, `backend_type`, `backend_table`, `frontend_model`, `frontend_input`, `frontend_label`, `frontend_class`, `source_model`, `is_required`, `is_user_defined`, `default_value`, `is_unique`, `note`)
VALUES
	(1,1,'website_id',NULL,'customer/customer_attribute_backend_website','static',NULL,NULL,'select','Associate to Website',NULL,'customer/customer_attribute_source_website',1,0,NULL,0,NULL),
	(2,1,'store_id',NULL,'customer/customer_attribute_backend_store','static',NULL,NULL,'select','Create In',NULL,'customer/customer_attribute_source_store',1,0,NULL,0,NULL),
	(3,1,'created_in',NULL,NULL,'varchar',NULL,NULL,'text','Created From',NULL,NULL,0,0,NULL,0,NULL),
	(4,1,'prefix',NULL,NULL,'varchar',NULL,NULL,'text','Prefix',NULL,NULL,0,0,NULL,0,NULL),
	(5,1,'firstname',NULL,NULL,'varchar',NULL,NULL,'text','First Name',NULL,NULL,1,0,NULL,0,NULL),
	(6,1,'middlename',NULL,NULL,'varchar',NULL,NULL,'text','Middle Name/Initial',NULL,NULL,0,0,NULL,0,NULL),
	(7,1,'lastname',NULL,NULL,'varchar',NULL,NULL,'text','Last Name',NULL,NULL,1,0,NULL,0,NULL),
	(8,1,'suffix',NULL,NULL,'varchar',NULL,NULL,'text','Suffix',NULL,NULL,0,0,NULL,0,NULL),
	(9,1,'email',NULL,NULL,'static',NULL,NULL,'text','Email',NULL,NULL,1,0,NULL,0,NULL),
	(10,1,'group_id',NULL,NULL,'static',NULL,NULL,'select','Group',NULL,'customer/customer_attribute_source_group',1,0,NULL,0,NULL),
	(11,1,'dob',NULL,'eav/entity_attribute_backend_datetime','datetime',NULL,'eav/entity_attribute_frontend_datetime','date','Date Of Birth',NULL,NULL,0,0,NULL,0,NULL),
	(12,1,'password_hash',NULL,'customer/customer_attribute_backend_password','varchar',NULL,NULL,'hidden',NULL,NULL,NULL,0,0,NULL,0,NULL),
	(13,1,'default_billing',NULL,'customer/customer_attribute_backend_billing','int',NULL,NULL,'text','Default Billing Address',NULL,NULL,0,0,NULL,0,NULL),
	(14,1,'default_shipping',NULL,'customer/customer_attribute_backend_shipping','int',NULL,NULL,'text','Default Shipping Address',NULL,NULL,0,0,NULL,0,NULL),
	(15,1,'taxvat',NULL,NULL,'varchar',NULL,NULL,'text','Tax/VAT Number',NULL,NULL,0,0,NULL,0,NULL),
	(16,1,'confirmation',NULL,NULL,'varchar',NULL,NULL,'text','Is Confirmed',NULL,NULL,0,0,NULL,0,NULL),
	(17,1,'created_at',NULL,NULL,'static',NULL,NULL,'datetime','Created At',NULL,NULL,0,0,NULL,0,NULL),
	(18,1,'gender',NULL,NULL,'int',NULL,NULL,'select','Gender',NULL,'eav/entity_attribute_source_table',0,0,NULL,0,NULL),
	(19,2,'prefix',NULL,NULL,'varchar',NULL,NULL,'text','Prefix',NULL,NULL,0,0,NULL,0,NULL),
	(20,2,'firstname',NULL,NULL,'varchar',NULL,NULL,'text','First Name',NULL,NULL,1,0,NULL,0,NULL),
	(21,2,'middlename',NULL,NULL,'varchar',NULL,NULL,'text','Middle Name/Initial',NULL,NULL,0,0,NULL,0,NULL),
	(22,2,'lastname',NULL,NULL,'varchar',NULL,NULL,'text','Last Name',NULL,NULL,1,0,NULL,0,NULL),
	(23,2,'suffix',NULL,NULL,'varchar',NULL,NULL,'text','Suffix',NULL,NULL,0,0,NULL,0,NULL),
	(24,2,'company',NULL,NULL,'varchar',NULL,NULL,'text','Company',NULL,NULL,0,0,NULL,0,NULL),
	(25,2,'street',NULL,'customer/entity_address_attribute_backend_street','text',NULL,NULL,'multiline','Street Address',NULL,NULL,1,0,NULL,0,NULL),
	(26,2,'city',NULL,NULL,'varchar',NULL,NULL,'text','City',NULL,NULL,1,0,NULL,0,NULL),
	(27,2,'country_id',NULL,NULL,'varchar',NULL,NULL,'select','Country',NULL,'customer/entity_address_attribute_source_country',1,0,NULL,0,NULL),
	(28,2,'region',NULL,'customer/entity_address_attribute_backend_region','varchar',NULL,NULL,'text','State/Province',NULL,NULL,0,0,NULL,0,NULL),
	(29,2,'region_id',NULL,NULL,'int',NULL,NULL,'hidden','State/Province',NULL,'customer/entity_address_attribute_source_region',0,0,NULL,0,NULL),
	(30,2,'postcode',NULL,NULL,'varchar',NULL,NULL,'text','Zip/Postal Code',NULL,NULL,1,0,NULL,0,NULL),
	(31,2,'telephone',NULL,NULL,'varchar',NULL,NULL,'text','Telephone',NULL,NULL,1,0,NULL,0,NULL),
	(32,2,'fax',NULL,NULL,'varchar',NULL,NULL,'text','Fax',NULL,NULL,0,0,NULL,0,NULL),
	(33,1,'rp_token',NULL,NULL,'varchar',NULL,NULL,'hidden',NULL,NULL,NULL,0,0,NULL,0,NULL),
	(34,1,'rp_token_created_at',NULL,NULL,'datetime',NULL,NULL,'date',NULL,NULL,NULL,0,0,NULL,0,NULL),
	(35,1,'disable_auto_group_change',NULL,'customer/attribute_backend_data_boolean','static',NULL,NULL,'boolean','Disable Automatic Group Change Based on VAT ID',NULL,NULL,0,0,NULL,0,NULL),
	(36,2,'vat_id',NULL,NULL,'varchar',NULL,NULL,'text','VAT number',NULL,NULL,0,0,NULL,0,NULL),
	(37,2,'vat_is_valid',NULL,NULL,'int',NULL,NULL,'text','VAT number validity',NULL,NULL,0,0,NULL,0,NULL),
	(38,2,'vat_request_id',NULL,NULL,'varchar',NULL,NULL,'text','VAT number validation request ID',NULL,NULL,0,0,NULL,0,NULL),
	(39,2,'vat_request_date',NULL,NULL,'varchar',NULL,NULL,'text','VAT number validation request date',NULL,NULL,0,0,NULL,0,NULL),
	(40,2,'vat_request_success',NULL,NULL,'int',NULL,NULL,'text','VAT number validation request success',NULL,NULL,0,0,NULL,0,NULL),
	(41,3,'name',NULL,NULL,'varchar',NULL,NULL,'text','Name',NULL,NULL,1,0,NULL,0,NULL),
	(42,3,'is_active',NULL,NULL,'int',NULL,NULL,'select','Is Active',NULL,'eav/entity_attribute_source_boolean',1,0,NULL,0,NULL),
	(43,3,'url_key',NULL,'catalog/category_attribute_backend_urlkey','varchar',NULL,NULL,'text','URL Key',NULL,NULL,0,0,NULL,0,NULL),
	(44,3,'description',NULL,NULL,'text',NULL,NULL,'textarea','Description',NULL,NULL,0,0,NULL,0,NULL),
	(45,3,'image',NULL,'catalog/category_attribute_backend_image','varchar',NULL,NULL,'image','Image',NULL,NULL,0,0,NULL,0,NULL),
	(46,3,'meta_title',NULL,NULL,'varchar',NULL,NULL,'text','Page Title',NULL,NULL,0,0,NULL,0,NULL),
	(47,3,'meta_keywords',NULL,NULL,'text',NULL,NULL,'textarea','Meta Keywords',NULL,NULL,0,0,NULL,0,NULL),
	(48,3,'meta_description',NULL,NULL,'text',NULL,NULL,'textarea','Meta Description',NULL,NULL,0,0,NULL,0,NULL),
	(49,3,'display_mode',NULL,NULL,'varchar',NULL,NULL,'select','Display Mode',NULL,'catalog/category_attribute_source_mode',0,0,NULL,0,NULL),
	(50,3,'landing_page',NULL,NULL,'int',NULL,NULL,'select','CMS Block',NULL,'catalog/category_attribute_source_page',0,0,NULL,0,NULL),
	(51,3,'is_anchor',NULL,NULL,'int',NULL,NULL,'select','Is Anchor',NULL,'eav/entity_attribute_source_boolean',0,0,NULL,0,NULL),
	(52,3,'path',NULL,NULL,'static',NULL,NULL,'text','Path',NULL,NULL,0,0,NULL,0,NULL),
	(53,3,'position',NULL,NULL,'static',NULL,NULL,'text','Position',NULL,NULL,0,0,NULL,0,NULL),
	(54,3,'all_children',NULL,NULL,'text',NULL,NULL,'text',NULL,NULL,NULL,0,0,NULL,0,NULL),
	(55,3,'path_in_store',NULL,NULL,'text',NULL,NULL,'text',NULL,NULL,NULL,0,0,NULL,0,NULL),
	(56,3,'children',NULL,NULL,'text',NULL,NULL,'text',NULL,NULL,NULL,0,0,NULL,0,NULL),
	(57,3,'url_path',NULL,NULL,'varchar',NULL,NULL,'text',NULL,NULL,NULL,0,0,NULL,0,NULL),
	(58,3,'custom_design',NULL,NULL,'varchar',NULL,NULL,'select','Custom Design',NULL,'core/design_source_design',0,0,NULL,0,NULL),
	(59,3,'custom_design_from',NULL,'eav/entity_attribute_backend_datetime','datetime',NULL,NULL,'date','Active From',NULL,NULL,0,0,NULL,0,NULL),
	(60,3,'custom_design_to',NULL,'eav/entity_attribute_backend_datetime','datetime',NULL,NULL,'date','Active To',NULL,NULL,0,0,NULL,0,NULL),
	(61,3,'page_layout',NULL,NULL,'varchar',NULL,NULL,'select','Page Layout',NULL,'catalog/category_attribute_source_layout',0,0,NULL,0,NULL),
	(62,3,'custom_layout_update',NULL,'catalog/attribute_backend_customlayoutupdate','text',NULL,NULL,'textarea','Custom Layout Update',NULL,NULL,0,0,NULL,0,NULL),
	(63,3,'level',NULL,NULL,'static',NULL,NULL,'text','Level',NULL,NULL,0,0,NULL,0,NULL),
	(64,3,'children_count',NULL,NULL,'static',NULL,NULL,'text','Children Count',NULL,NULL,0,0,NULL,0,NULL),
	(65,3,'available_sort_by',NULL,'catalog/category_attribute_backend_sortby','text',NULL,NULL,'multiselect','Available Product Listing Sort By',NULL,'catalog/category_attribute_source_sortby',1,0,NULL,0,NULL),
	(66,3,'default_sort_by',NULL,'catalog/category_attribute_backend_sortby','varchar',NULL,NULL,'select','Default Product Listing Sort By',NULL,'catalog/category_attribute_source_sortby',1,0,NULL,0,NULL),
	(67,3,'include_in_menu',NULL,NULL,'int',NULL,NULL,'select','Include in Navigation Menu',NULL,'eav/entity_attribute_source_boolean',1,0,'1',0,NULL),
	(68,3,'custom_use_parent_settings',NULL,NULL,'int',NULL,NULL,'select','Use Parent Category Settings',NULL,'eav/entity_attribute_source_boolean',0,0,NULL,0,NULL),
	(69,3,'custom_apply_to_products',NULL,NULL,'int',NULL,NULL,'select','Apply To Products',NULL,'eav/entity_attribute_source_boolean',0,0,NULL,0,NULL),
	(70,3,'filter_price_range',NULL,NULL,'decimal',NULL,NULL,'text','Layered Navigation Price Step',NULL,NULL,0,0,NULL,0,NULL),
	(71,4,'name',NULL,NULL,'varchar',NULL,NULL,'text','Name',NULL,NULL,1,0,NULL,0,NULL),
	(72,4,'description',NULL,NULL,'text',NULL,NULL,'textarea','Description',NULL,NULL,1,0,NULL,0,NULL),
	(73,4,'short_description',NULL,NULL,'text',NULL,NULL,'textarea','Short Description',NULL,NULL,1,0,NULL,0,NULL),
	(74,4,'sku',NULL,'catalog/product_attribute_backend_sku','static',NULL,NULL,'text','SKU',NULL,NULL,1,0,NULL,1,NULL),
	(75,4,'price',NULL,'catalog/product_attribute_backend_price','decimal',NULL,NULL,'price','Price',NULL,NULL,1,0,NULL,0,NULL),
	(76,4,'special_price',NULL,'catalog/product_attribute_backend_price','decimal',NULL,NULL,'price','Special Price',NULL,NULL,0,0,NULL,0,'The Special Price is active only when lower than the Actual Price'),
	(77,4,'special_from_date',NULL,'catalog/product_attribute_backend_startdate_specialprice','datetime',NULL,NULL,'date','Special Price From Date',NULL,NULL,0,0,NULL,0,NULL),
	(78,4,'special_to_date',NULL,'eav/entity_attribute_backend_datetime','datetime',NULL,NULL,'date','Special Price To Date',NULL,NULL,0,0,NULL,0,NULL),
	(79,4,'cost',NULL,'catalog/product_attribute_backend_price','decimal',NULL,NULL,'price','Cost',NULL,NULL,0,1,NULL,0,NULL),
	(80,4,'weight',NULL,NULL,'decimal',NULL,NULL,'weight','Weight',NULL,NULL,1,0,NULL,0,NULL),
	(81,4,'manufacturer',NULL,NULL,'int',NULL,NULL,'select','Manufacturer',NULL,NULL,0,1,NULL,0,NULL),
	(82,4,'meta_title',NULL,NULL,'varchar',NULL,NULL,'text','Meta Title',NULL,NULL,0,0,NULL,0,NULL),
	(83,4,'meta_keyword',NULL,NULL,'text',NULL,NULL,'textarea','Meta Keywords',NULL,NULL,0,0,NULL,0,NULL),
	(84,4,'meta_description',NULL,NULL,'varchar',NULL,NULL,'textarea','Meta Description',NULL,NULL,0,0,NULL,0,'Maximum 255 chars'),
	(85,4,'image',NULL,NULL,'varchar',NULL,'catalog/product_attribute_frontend_image','media_image','Base Image',NULL,NULL,0,0,NULL,0,NULL),
	(86,4,'small_image',NULL,NULL,'varchar',NULL,'catalog/product_attribute_frontend_image','media_image','Small Image',NULL,NULL,0,0,NULL,0,NULL),
	(87,4,'thumbnail',NULL,NULL,'varchar',NULL,'catalog/product_attribute_frontend_image','media_image','Thumbnail',NULL,NULL,0,0,NULL,0,NULL),
	(88,4,'media_gallery',NULL,'catalog/product_attribute_backend_media','varchar',NULL,NULL,'gallery','Media Gallery',NULL,NULL,0,0,NULL,0,NULL),
	(89,4,'old_id',NULL,NULL,'int',NULL,NULL,'text',NULL,NULL,NULL,0,0,NULL,0,NULL),
	(90,4,'group_price',NULL,'catalog/product_attribute_backend_groupprice','decimal',NULL,NULL,'text','Group Price',NULL,NULL,0,0,NULL,0,NULL),
	(91,4,'tier_price',NULL,'catalog/product_attribute_backend_tierprice','decimal',NULL,NULL,'text','Tier Price',NULL,NULL,0,0,NULL,0,NULL),
	(92,4,'color',NULL,NULL,'int',NULL,NULL,'select','Color',NULL,NULL,0,1,NULL,0,NULL),
	(93,4,'news_from_date',NULL,'catalog/product_attribute_backend_startdate','datetime',NULL,NULL,'date','Set Product as New from Date',NULL,NULL,0,0,NULL,0,NULL),
	(94,4,'news_to_date',NULL,'eav/entity_attribute_backend_datetime','datetime',NULL,NULL,'date','Set Product as New to Date',NULL,NULL,0,0,NULL,0,NULL),
	(95,4,'gallery',NULL,NULL,'varchar',NULL,NULL,'gallery','Image Gallery',NULL,NULL,0,0,NULL,0,NULL),
	(96,4,'status',NULL,NULL,'int',NULL,NULL,'select','Status',NULL,'catalog/product_status',1,0,NULL,0,NULL),
	(97,4,'url_key',NULL,'catalog/product_attribute_backend_urlkey','varchar',NULL,NULL,'text','URL Key',NULL,NULL,0,0,NULL,0,NULL),
	(98,4,'url_path',NULL,NULL,'varchar',NULL,NULL,'text',NULL,NULL,NULL,0,0,NULL,0,NULL),
	(99,4,'minimal_price',NULL,NULL,'decimal',NULL,NULL,'price','Minimal Price',NULL,NULL,0,0,NULL,0,NULL),
	(100,4,'is_recurring',NULL,NULL,'int',NULL,NULL,'select','Enable Recurring Profile',NULL,'eav/entity_attribute_source_boolean',0,0,NULL,0,'Products with recurring profile participate in catalog as nominal items.'),
	(101,4,'recurring_profile',NULL,'catalog/product_attribute_backend_recurring','text',NULL,NULL,'text','Recurring Payment Profile',NULL,NULL,0,0,NULL,0,NULL),
	(102,4,'visibility',NULL,NULL,'int',NULL,NULL,'select','Visibility',NULL,'catalog/product_visibility',1,0,'4',0,NULL),
	(103,4,'custom_design',NULL,NULL,'varchar',NULL,NULL,'select','Custom Design',NULL,'core/design_source_design',0,0,NULL,0,NULL),
	(104,4,'custom_design_from',NULL,'catalog/product_attribute_backend_startdate','datetime',NULL,NULL,'date','Active From',NULL,NULL,0,0,NULL,0,NULL),
	(105,4,'custom_design_to',NULL,'eav/entity_attribute_backend_datetime','datetime',NULL,NULL,'date','Active To',NULL,NULL,0,0,NULL,0,NULL),
	(106,4,'custom_layout_update',NULL,'catalog/attribute_backend_customlayoutupdate','text',NULL,NULL,'textarea','Custom Layout Update',NULL,NULL,0,0,NULL,0,NULL),
	(107,4,'page_layout',NULL,NULL,'varchar',NULL,NULL,'select','Page Layout',NULL,'catalog/product_attribute_source_layout',0,0,NULL,0,NULL),
	(108,4,'category_ids',NULL,NULL,'static',NULL,NULL,'text',NULL,NULL,NULL,0,0,NULL,0,NULL),
	(109,4,'options_container',NULL,NULL,'varchar',NULL,NULL,'select','Display Product Options In',NULL,'catalog/entity_product_attribute_design_options_container',0,0,'container1',0,NULL),
	(110,4,'required_options',NULL,NULL,'static',NULL,NULL,'text',NULL,NULL,NULL,0,0,NULL,0,NULL),
	(111,4,'has_options',NULL,NULL,'static',NULL,NULL,'text',NULL,NULL,NULL,0,0,NULL,0,NULL),
	(112,4,'image_label',NULL,NULL,'varchar',NULL,NULL,'text','Image Label',NULL,NULL,0,0,NULL,0,NULL),
	(113,4,'small_image_label',NULL,NULL,'varchar',NULL,NULL,'text','Small Image Label',NULL,NULL,0,0,NULL,0,NULL),
	(114,4,'thumbnail_label',NULL,NULL,'varchar',NULL,NULL,'text','Thumbnail Label',NULL,NULL,0,0,NULL,0,NULL),
	(115,4,'created_at',NULL,'eav/entity_attribute_backend_time_created','static',NULL,NULL,'text',NULL,NULL,NULL,1,0,NULL,0,NULL),
	(116,4,'updated_at',NULL,'eav/entity_attribute_backend_time_updated','static',NULL,NULL,'text',NULL,NULL,NULL,1,0,NULL,0,NULL),
	(117,4,'country_of_manufacture',NULL,NULL,'varchar',NULL,NULL,'select','Country of Manufacture',NULL,'catalog/product_attribute_source_countryofmanufacture',0,0,NULL,0,NULL),
	(118,4,'msrp_enabled',NULL,'catalog/product_attribute_backend_msrp','varchar',NULL,NULL,'select','Apply MAP',NULL,'catalog/product_attribute_source_msrp_type_enabled',0,0,'2',0,NULL),
	(119,4,'msrp_display_actual_price_type',NULL,'catalog/product_attribute_backend_boolean','varchar',NULL,NULL,'select','Display Actual Price',NULL,'catalog/product_attribute_source_msrp_type_price',0,0,'4',0,NULL),
	(120,4,'msrp',NULL,'catalog/product_attribute_backend_price','decimal',NULL,NULL,'price','Manufacturer\'s Suggested Retail Price',NULL,NULL,0,0,NULL,0,NULL),
	(121,4,'tax_class_id',NULL,NULL,'int',NULL,NULL,'select','Tax Class',NULL,'tax/class_source_product',1,0,NULL,0,NULL),
	(122,4,'gift_message_available',NULL,'catalog/product_attribute_backend_boolean','varchar',NULL,NULL,'select','Allow Gift Message',NULL,'eav/entity_attribute_source_boolean',0,0,NULL,0,NULL),
	(123,4,'price_type',NULL,NULL,'int',NULL,NULL,NULL,NULL,NULL,NULL,1,0,NULL,0,NULL),
	(124,4,'sku_type',NULL,NULL,'int',NULL,NULL,NULL,NULL,NULL,NULL,1,0,NULL,0,NULL),
	(125,4,'weight_type',NULL,NULL,'int',NULL,NULL,NULL,NULL,NULL,NULL,1,0,NULL,0,NULL),
	(126,4,'price_view',NULL,NULL,'int',NULL,NULL,'select','Price View',NULL,'bundle/product_attribute_source_price_view',1,0,NULL,0,NULL),
	(127,4,'shipment_type',NULL,NULL,'int',NULL,NULL,NULL,'Shipment',NULL,NULL,1,0,NULL,0,NULL),
	(128,4,'links_purchased_separately',NULL,NULL,'int',NULL,NULL,NULL,'Links can be purchased separately',NULL,NULL,1,0,NULL,0,NULL),
	(129,4,'samples_title',NULL,NULL,'varchar',NULL,NULL,NULL,'Samples title',NULL,NULL,1,0,NULL,0,NULL),
	(130,4,'links_title',NULL,NULL,'varchar',NULL,NULL,NULL,'Links title',NULL,NULL,1,0,NULL,0,NULL),
	(131,4,'links_exist',NULL,NULL,'int',NULL,NULL,NULL,NULL,NULL,NULL,0,0,'0',0,NULL),
	(132,4,'em_featured',NULL,NULL,'int',NULL,NULL,'boolean','Featured Product',NULL,NULL,0,1,'0',0,NULL),
	(133,4,'em_deal',NULL,NULL,'int',NULL,NULL,'boolean','Special Deal',NULL,NULL,0,1,'0',0,NULL),
	(134,4,'em_hot',NULL,NULL,'int',NULL,NULL,'boolean','Hot Product',NULL,NULL,0,1,'0',0,NULL),
	(135,9,'name',NULL,NULL,'varchar',NULL,NULL,'text','Label Name',NULL,NULL,1,0,NULL,0,NULL),
	(136,9,'image',NULL,'productlabels/productlabels_attribute_backend_image','varchar',NULL,NULL,'image','Image',NULL,NULL,0,0,NULL,0,NULL),
	(137,9,'background',NULL,'productlabels/productlabels_attribute_backend_image','varchar',NULL,NULL,'image','Background',NULL,NULL,0,0,NULL,0,NULL),
	(138,9,'texthtml',NULL,NULL,'text',NULL,NULL,'textarea','Text',NULL,NULL,0,0,NULL,0,NULL),
	(139,9,'css_class',NULL,NULL,'varchar',NULL,NULL,'text','Css class',NULL,NULL,0,0,NULL,0,'The name of often used css.(Bestseller Product Label: bestseller; New Product Label: new; Sale Product Label: special)'),
	(140,9,'status',NULL,NULL,'int',NULL,NULL,'select','Enable',NULL,'eav/entity_attribute_source_boolean',1,0,NULL,0,NULL),
	(141,9,'actions',NULL,NULL,'text',NULL,NULL,'textarea','Actions',NULL,NULL,0,0,NULL,0,NULL),
	(142,9,'created_at',NULL,'eav/entity_attribute_backend_time_created','static',NULL,NULL,'text',NULL,NULL,NULL,1,0,NULL,0,NULL),
	(143,9,'updated_at',NULL,'eav/entity_attribute_backend_time_updated','static',NULL,NULL,'text',NULL,NULL,NULL,1,0,NULL,0,NULL),
	(144,10,'content',NULL,NULL,'text',NULL,NULL,'textarea','Css Content',NULL,NULL,0,0,NULL,0,NULL);

/*!40000 ALTER TABLE `eav_attribute` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table eav_attribute_group
# ------------------------------------------------------------

DROP TABLE IF EXISTS `eav_attribute_group`;

CREATE TABLE `eav_attribute_group` (
  `attribute_group_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Attribute Group Id',
  `attribute_set_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Set Id',
  `attribute_group_name` varchar(255) DEFAULT NULL COMMENT 'Attribute Group Name',
  `sort_order` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Sort Order',
  `default_id` smallint(5) unsigned DEFAULT '0' COMMENT 'Default Id',
  PRIMARY KEY (`attribute_group_id`),
  UNIQUE KEY `UNQ_EAV_ATTRIBUTE_GROUP_ATTRIBUTE_SET_ID_ATTRIBUTE_GROUP_NAME` (`attribute_set_id`,`attribute_group_name`),
  KEY `IDX_EAV_ATTRIBUTE_GROUP_ATTRIBUTE_SET_ID_SORT_ORDER` (`attribute_set_id`,`sort_order`),
  CONSTRAINT `FK_EAV_ATTR_GROUP_ATTR_SET_ID_EAV_ATTR_SET_ATTR_SET_ID` FOREIGN KEY (`attribute_set_id`) REFERENCES `eav_attribute_set` (`attribute_set_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Eav Attribute Group';

LOCK TABLES `eav_attribute_group` WRITE;
/*!40000 ALTER TABLE `eav_attribute_group` DISABLE KEYS */;

INSERT INTO `eav_attribute_group` (`attribute_group_id`, `attribute_set_id`, `attribute_group_name`, `sort_order`, `default_id`)
VALUES
	(1,1,'General',1,1),
	(2,2,'General',1,1),
	(3,3,'General',10,1),
	(4,3,'General Information',2,0),
	(5,3,'Display Settings',20,0),
	(6,3,'Custom Design',30,0),
	(7,4,'General',1,1),
	(8,4,'Prices',2,0),
	(9,4,'Meta Information',3,0),
	(10,4,'Images',4,0),
	(11,4,'Recurring Profile',5,0),
	(12,4,'Design',6,0),
	(13,5,'General',1,1),
	(14,6,'General',1,1),
	(15,7,'General',1,1),
	(16,8,'General',1,1),
	(17,4,'Gift Options',7,0),
	(18,9,'General',1,1),
	(19,10,'General',1,1);

/*!40000 ALTER TABLE `eav_attribute_group` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table eav_attribute_label
# ------------------------------------------------------------

DROP TABLE IF EXISTS `eav_attribute_label`;

CREATE TABLE `eav_attribute_label` (
  `attribute_label_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Attribute Label Id',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  `value` varchar(255) DEFAULT NULL COMMENT 'Value',
  PRIMARY KEY (`attribute_label_id`),
  KEY `IDX_EAV_ATTRIBUTE_LABEL_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_EAV_ATTRIBUTE_LABEL_STORE_ID` (`store_id`),
  KEY `IDX_EAV_ATTRIBUTE_LABEL_ATTRIBUTE_ID_STORE_ID` (`attribute_id`,`store_id`),
  CONSTRAINT `FK_EAV_ATTRIBUTE_LABEL_ATTRIBUTE_ID_EAV_ATTRIBUTE_ATTRIBUTE_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_EAV_ATTRIBUTE_LABEL_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Eav Attribute Label';



# Dump of table eav_attribute_option
# ------------------------------------------------------------

DROP TABLE IF EXISTS `eav_attribute_option`;

CREATE TABLE `eav_attribute_option` (
  `option_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Option Id',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Id',
  `sort_order` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Sort Order',
  PRIMARY KEY (`option_id`),
  KEY `IDX_EAV_ATTRIBUTE_OPTION_ATTRIBUTE_ID` (`attribute_id`),
  CONSTRAINT `FK_EAV_ATTRIBUTE_OPTION_ATTRIBUTE_ID_EAV_ATTRIBUTE_ATTRIBUTE_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Eav Attribute Option';

LOCK TABLES `eav_attribute_option` WRITE;
/*!40000 ALTER TABLE `eav_attribute_option` DISABLE KEYS */;

INSERT INTO `eav_attribute_option` (`option_id`, `attribute_id`, `sort_order`)
VALUES
	(1,18,0),
	(2,18,1);

/*!40000 ALTER TABLE `eav_attribute_option` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table eav_attribute_option_value
# ------------------------------------------------------------

DROP TABLE IF EXISTS `eav_attribute_option_value`;

CREATE TABLE `eav_attribute_option_value` (
  `value_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Value Id',
  `option_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Option Id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  `value` varchar(255) DEFAULT NULL COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  KEY `IDX_EAV_ATTRIBUTE_OPTION_VALUE_OPTION_ID` (`option_id`),
  KEY `IDX_EAV_ATTRIBUTE_OPTION_VALUE_STORE_ID` (`store_id`),
  CONSTRAINT `FK_EAV_ATTR_OPT_VAL_OPT_ID_EAV_ATTR_OPT_OPT_ID` FOREIGN KEY (`option_id`) REFERENCES `eav_attribute_option` (`option_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_EAV_ATTRIBUTE_OPTION_VALUE_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Eav Attribute Option Value';

LOCK TABLES `eav_attribute_option_value` WRITE;
/*!40000 ALTER TABLE `eav_attribute_option_value` DISABLE KEYS */;

INSERT INTO `eav_attribute_option_value` (`value_id`, `option_id`, `store_id`, `value`)
VALUES
	(1,1,0,'Male'),
	(2,2,0,'Female');

/*!40000 ALTER TABLE `eav_attribute_option_value` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table eav_attribute_set
# ------------------------------------------------------------

DROP TABLE IF EXISTS `eav_attribute_set`;

CREATE TABLE `eav_attribute_set` (
  `attribute_set_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Attribute Set Id',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type Id',
  `attribute_set_name` varchar(255) DEFAULT NULL COMMENT 'Attribute Set Name',
  `sort_order` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Sort Order',
  PRIMARY KEY (`attribute_set_id`),
  UNIQUE KEY `UNQ_EAV_ATTRIBUTE_SET_ENTITY_TYPE_ID_ATTRIBUTE_SET_NAME` (`entity_type_id`,`attribute_set_name`),
  KEY `IDX_EAV_ATTRIBUTE_SET_ENTITY_TYPE_ID_SORT_ORDER` (`entity_type_id`,`sort_order`),
  CONSTRAINT `FK_EAV_ATTR_SET_ENTT_TYPE_ID_EAV_ENTT_TYPE_ENTT_TYPE_ID` FOREIGN KEY (`entity_type_id`) REFERENCES `eav_entity_type` (`entity_type_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Eav Attribute Set';

LOCK TABLES `eav_attribute_set` WRITE;
/*!40000 ALTER TABLE `eav_attribute_set` DISABLE KEYS */;

INSERT INTO `eav_attribute_set` (`attribute_set_id`, `entity_type_id`, `attribute_set_name`, `sort_order`)
VALUES
	(1,1,'Default',1),
	(2,2,'Default',1),
	(3,3,'Default',1),
	(4,4,'Default',1),
	(5,5,'Default',1),
	(6,6,'Default',1),
	(7,7,'Default',1),
	(8,8,'Default',1),
	(9,9,'Default',1),
	(10,10,'Default',1);

/*!40000 ALTER TABLE `eav_attribute_set` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table eav_entity
# ------------------------------------------------------------

DROP TABLE IF EXISTS `eav_entity`;

CREATE TABLE `eav_entity` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type Id',
  `attribute_set_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Set Id',
  `increment_id` varchar(50) DEFAULT NULL COMMENT 'Increment Id',
  `parent_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Parent Id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Created At',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Updated At',
  `is_active` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Defines Is Entity Active',
  PRIMARY KEY (`entity_id`),
  KEY `IDX_EAV_ENTITY_ENTITY_TYPE_ID` (`entity_type_id`),
  KEY `IDX_EAV_ENTITY_STORE_ID` (`store_id`),
  CONSTRAINT `FK_EAV_ENTITY_ENTITY_TYPE_ID_EAV_ENTITY_TYPE_ENTITY_TYPE_ID` FOREIGN KEY (`entity_type_id`) REFERENCES `eav_entity_type` (`entity_type_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_EAV_ENTITY_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Eav Entity';



# Dump of table eav_entity_attribute
# ------------------------------------------------------------

DROP TABLE IF EXISTS `eav_entity_attribute`;

CREATE TABLE `eav_entity_attribute` (
  `entity_attribute_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Attribute Id',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type Id',
  `attribute_set_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Set Id',
  `attribute_group_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Group Id',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Id',
  `sort_order` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Sort Order',
  PRIMARY KEY (`entity_attribute_id`),
  UNIQUE KEY `UNQ_EAV_ENTITY_ATTRIBUTE_ATTRIBUTE_SET_ID_ATTRIBUTE_ID` (`attribute_set_id`,`attribute_id`),
  UNIQUE KEY `UNQ_EAV_ENTITY_ATTRIBUTE_ATTRIBUTE_GROUP_ID_ATTRIBUTE_ID` (`attribute_group_id`,`attribute_id`),
  KEY `IDX_EAV_ENTITY_ATTRIBUTE_ATTRIBUTE_SET_ID_SORT_ORDER` (`attribute_set_id`,`sort_order`),
  KEY `IDX_EAV_ENTITY_ATTRIBUTE_ATTRIBUTE_ID` (`attribute_id`),
  CONSTRAINT `FK_EAV_ENTITY_ATTRIBUTE_ATTRIBUTE_ID_EAV_ATTRIBUTE_ATTRIBUTE_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_EAV_ENTT_ATTR_ATTR_GROUP_ID_EAV_ATTR_GROUP_ATTR_GROUP_ID` FOREIGN KEY (`attribute_group_id`) REFERENCES `eav_attribute_group` (`attribute_group_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Eav Entity Attributes';

LOCK TABLES `eav_entity_attribute` WRITE;
/*!40000 ALTER TABLE `eav_entity_attribute` DISABLE KEYS */;

INSERT INTO `eav_entity_attribute` (`entity_attribute_id`, `entity_type_id`, `attribute_set_id`, `attribute_group_id`, `attribute_id`, `sort_order`)
VALUES
	(1,1,1,1,1,10),
	(2,1,1,1,2,0),
	(3,1,1,1,3,20),
	(4,1,1,1,4,30),
	(5,1,1,1,5,40),
	(6,1,1,1,6,50),
	(7,1,1,1,7,60),
	(8,1,1,1,8,70),
	(9,1,1,1,9,80),
	(10,1,1,1,10,25),
	(11,1,1,1,11,90),
	(12,1,1,1,12,0),
	(13,1,1,1,13,0),
	(14,1,1,1,14,0),
	(15,1,1,1,15,100),
	(16,1,1,1,16,0),
	(17,1,1,1,17,86),
	(18,1,1,1,18,110),
	(19,2,2,2,19,10),
	(20,2,2,2,20,20),
	(21,2,2,2,21,30),
	(22,2,2,2,22,40),
	(23,2,2,2,23,50),
	(24,2,2,2,24,60),
	(25,2,2,2,25,70),
	(26,2,2,2,26,80),
	(27,2,2,2,27,90),
	(28,2,2,2,28,100),
	(29,2,2,2,29,100),
	(30,2,2,2,30,110),
	(31,2,2,2,31,120),
	(32,2,2,2,32,130),
	(33,1,1,1,33,111),
	(34,1,1,1,34,112),
	(35,1,1,1,35,28),
	(36,2,2,2,36,140),
	(37,2,2,2,37,132),
	(38,2,2,2,38,133),
	(39,2,2,2,39,134),
	(40,2,2,2,40,135),
	(41,3,3,4,41,1),
	(42,3,3,4,42,2),
	(43,3,3,4,43,3),
	(44,3,3,4,44,4),
	(45,3,3,4,45,5),
	(46,3,3,4,46,6),
	(47,3,3,4,47,7),
	(48,3,3,4,48,8),
	(49,3,3,5,49,10),
	(50,3,3,5,50,20),
	(51,3,3,5,51,30),
	(52,3,3,4,52,12),
	(53,3,3,4,53,13),
	(54,3,3,4,54,14),
	(55,3,3,4,55,15),
	(56,3,3,4,56,16),
	(57,3,3,4,57,17),
	(58,3,3,6,58,10),
	(59,3,3,6,59,30),
	(60,3,3,6,60,40),
	(61,3,3,6,61,50),
	(62,3,3,6,62,60),
	(63,3,3,4,63,24),
	(64,3,3,4,64,25),
	(65,3,3,5,65,40),
	(66,3,3,5,66,50),
	(67,3,3,4,67,10),
	(68,3,3,6,68,5),
	(69,3,3,6,69,6),
	(70,3,3,5,70,51),
	(71,4,4,7,71,1),
	(72,4,4,7,72,2),
	(73,4,4,7,73,3),
	(74,4,4,7,74,4),
	(75,4,4,8,75,1),
	(76,4,4,8,76,3),
	(77,4,4,8,77,4),
	(78,4,4,8,78,5),
	(79,4,4,8,79,6),
	(80,4,4,7,80,5),
	(81,4,4,9,82,1),
	(82,4,4,9,83,2),
	(83,4,4,9,84,3),
	(84,4,4,10,85,1),
	(85,4,4,10,86,2),
	(86,4,4,10,87,3),
	(87,4,4,10,88,4),
	(88,4,4,7,89,6),
	(89,4,4,8,90,2),
	(90,4,4,8,91,7),
	(91,4,4,7,93,7),
	(92,4,4,7,94,8),
	(93,4,4,10,95,5),
	(94,4,4,7,96,9),
	(95,4,4,7,97,10),
	(96,4,4,7,98,11),
	(97,4,4,8,99,8),
	(98,4,4,11,100,1),
	(99,4,4,11,101,2),
	(100,4,4,7,102,12),
	(101,4,4,12,103,1),
	(102,4,4,12,104,2),
	(103,4,4,12,105,3),
	(104,4,4,12,106,4),
	(105,4,4,12,107,5),
	(106,4,4,7,108,13),
	(107,4,4,12,109,6),
	(108,4,4,7,110,14),
	(109,4,4,7,111,15),
	(110,4,4,7,112,16),
	(111,4,4,7,113,17),
	(112,4,4,7,114,18),
	(113,4,4,7,115,19),
	(114,4,4,7,116,20),
	(115,4,4,7,117,21),
	(116,4,4,8,118,9),
	(117,4,4,8,119,10),
	(118,4,4,8,120,11),
	(119,4,4,8,121,12),
	(120,4,4,17,122,1),
	(121,4,4,7,123,22),
	(122,4,4,7,124,23),
	(123,4,4,7,125,24),
	(124,4,4,8,126,13),
	(125,4,4,7,127,25),
	(126,4,4,7,128,26),
	(127,4,4,7,129,27),
	(128,4,4,7,130,28),
	(129,4,4,7,131,29),
	(130,4,4,7,132,30),
	(131,4,4,7,133,31),
	(132,4,4,7,134,32),
	(133,9,9,18,135,1),
	(134,9,9,18,136,2),
	(135,9,9,18,137,3),
	(136,9,9,18,138,4),
	(137,9,9,18,139,5),
	(138,9,9,18,140,7),
	(139,9,9,18,141,8),
	(140,9,9,18,142,9),
	(141,9,9,18,143,10),
	(142,10,10,19,144,1);

/*!40000 ALTER TABLE `eav_entity_attribute` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table eav_entity_datetime
# ------------------------------------------------------------

DROP TABLE IF EXISTS `eav_entity_datetime`;

CREATE TABLE `eav_entity_datetime` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value Id',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type Id',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Id',
  `value` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Attribute Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_EAV_ENTITY_DATETIME_ENTITY_ID_ATTRIBUTE_ID_STORE_ID` (`entity_id`,`attribute_id`,`store_id`),
  KEY `IDX_EAV_ENTITY_DATETIME_ENTITY_TYPE_ID` (`entity_type_id`),
  KEY `IDX_EAV_ENTITY_DATETIME_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_EAV_ENTITY_DATETIME_STORE_ID` (`store_id`),
  KEY `IDX_EAV_ENTITY_DATETIME_ENTITY_ID` (`entity_id`),
  KEY `IDX_EAV_ENTITY_DATETIME_ATTRIBUTE_ID_VALUE` (`attribute_id`,`value`),
  KEY `IDX_EAV_ENTITY_DATETIME_ENTITY_TYPE_ID_VALUE` (`entity_type_id`,`value`),
  CONSTRAINT `FK_EAV_ENTITY_DATETIME_ENTITY_ID_EAV_ENTITY_ENTITY_ID` FOREIGN KEY (`entity_id`) REFERENCES `eav_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_EAV_ENTT_DTIME_ENTT_TYPE_ID_EAV_ENTT_TYPE_ENTT_TYPE_ID` FOREIGN KEY (`entity_type_id`) REFERENCES `eav_entity_type` (`entity_type_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_EAV_ENTITY_DATETIME_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Eav Entity Value Prefix';



# Dump of table eav_entity_decimal
# ------------------------------------------------------------

DROP TABLE IF EXISTS `eav_entity_decimal`;

CREATE TABLE `eav_entity_decimal` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value Id',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type Id',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Id',
  `value` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Attribute Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_EAV_ENTITY_DECIMAL_ENTITY_ID_ATTRIBUTE_ID_STORE_ID` (`entity_id`,`attribute_id`,`store_id`),
  KEY `IDX_EAV_ENTITY_DECIMAL_ENTITY_TYPE_ID` (`entity_type_id`),
  KEY `IDX_EAV_ENTITY_DECIMAL_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_EAV_ENTITY_DECIMAL_STORE_ID` (`store_id`),
  KEY `IDX_EAV_ENTITY_DECIMAL_ENTITY_ID` (`entity_id`),
  KEY `IDX_EAV_ENTITY_DECIMAL_ATTRIBUTE_ID_VALUE` (`attribute_id`,`value`),
  KEY `IDX_EAV_ENTITY_DECIMAL_ENTITY_TYPE_ID_VALUE` (`entity_type_id`,`value`),
  CONSTRAINT `FK_EAV_ENTITY_DECIMAL_ENTITY_ID_EAV_ENTITY_ENTITY_ID` FOREIGN KEY (`entity_id`) REFERENCES `eav_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_EAV_ENTT_DEC_ENTT_TYPE_ID_EAV_ENTT_TYPE_ENTT_TYPE_ID` FOREIGN KEY (`entity_type_id`) REFERENCES `eav_entity_type` (`entity_type_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_EAV_ENTITY_DECIMAL_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Eav Entity Value Prefix';



# Dump of table eav_entity_int
# ------------------------------------------------------------

DROP TABLE IF EXISTS `eav_entity_int`;

CREATE TABLE `eav_entity_int` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value Id',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type Id',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Id',
  `value` int(11) NOT NULL DEFAULT '0' COMMENT 'Attribute Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_EAV_ENTITY_INT_ENTITY_ID_ATTRIBUTE_ID_STORE_ID` (`entity_id`,`attribute_id`,`store_id`),
  KEY `IDX_EAV_ENTITY_INT_ENTITY_TYPE_ID` (`entity_type_id`),
  KEY `IDX_EAV_ENTITY_INT_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_EAV_ENTITY_INT_STORE_ID` (`store_id`),
  KEY `IDX_EAV_ENTITY_INT_ENTITY_ID` (`entity_id`),
  KEY `IDX_EAV_ENTITY_INT_ATTRIBUTE_ID_VALUE` (`attribute_id`,`value`),
  KEY `IDX_EAV_ENTITY_INT_ENTITY_TYPE_ID_VALUE` (`entity_type_id`,`value`),
  CONSTRAINT `FK_EAV_ENTITY_INT_ENTITY_ID_EAV_ENTITY_ENTITY_ID` FOREIGN KEY (`entity_id`) REFERENCES `eav_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_EAV_ENTITY_INT_ENTITY_TYPE_ID_EAV_ENTITY_TYPE_ENTITY_TYPE_ID` FOREIGN KEY (`entity_type_id`) REFERENCES `eav_entity_type` (`entity_type_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_EAV_ENTITY_INT_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Eav Entity Value Prefix';



# Dump of table eav_entity_store
# ------------------------------------------------------------

DROP TABLE IF EXISTS `eav_entity_store`;

CREATE TABLE `eav_entity_store` (
  `entity_store_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Store Id',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type Id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  `increment_prefix` varchar(20) DEFAULT NULL COMMENT 'Increment Prefix',
  `increment_last_id` varchar(50) DEFAULT NULL COMMENT 'Last Incremented Id',
  PRIMARY KEY (`entity_store_id`),
  KEY `IDX_EAV_ENTITY_STORE_ENTITY_TYPE_ID` (`entity_type_id`),
  KEY `IDX_EAV_ENTITY_STORE_STORE_ID` (`store_id`),
  CONSTRAINT `FK_EAV_ENTT_STORE_ENTT_TYPE_ID_EAV_ENTT_TYPE_ENTT_TYPE_ID` FOREIGN KEY (`entity_type_id`) REFERENCES `eav_entity_type` (`entity_type_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_EAV_ENTITY_STORE_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Eav Entity Store';



# Dump of table eav_entity_text
# ------------------------------------------------------------

DROP TABLE IF EXISTS `eav_entity_text`;

CREATE TABLE `eav_entity_text` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value Id',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type Id',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Id',
  `value` text NOT NULL COMMENT 'Attribute Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_EAV_ENTITY_TEXT_ENTITY_ID_ATTRIBUTE_ID_STORE_ID` (`entity_id`,`attribute_id`,`store_id`),
  KEY `IDX_EAV_ENTITY_TEXT_ENTITY_TYPE_ID` (`entity_type_id`),
  KEY `IDX_EAV_ENTITY_TEXT_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_EAV_ENTITY_TEXT_STORE_ID` (`store_id`),
  KEY `IDX_EAV_ENTITY_TEXT_ENTITY_ID` (`entity_id`),
  CONSTRAINT `FK_EAV_ENTITY_TEXT_ENTITY_ID_EAV_ENTITY_ENTITY_ID` FOREIGN KEY (`entity_id`) REFERENCES `eav_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_EAV_ENTITY_TEXT_ENTITY_TYPE_ID_EAV_ENTITY_TYPE_ENTITY_TYPE_ID` FOREIGN KEY (`entity_type_id`) REFERENCES `eav_entity_type` (`entity_type_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_EAV_ENTITY_TEXT_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Eav Entity Value Prefix';



# Dump of table eav_entity_type
# ------------------------------------------------------------

DROP TABLE IF EXISTS `eav_entity_type`;

CREATE TABLE `eav_entity_type` (
  `entity_type_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Type Id',
  `entity_type_code` varchar(50) NOT NULL COMMENT 'Entity Type Code',
  `entity_model` varchar(255) NOT NULL COMMENT 'Entity Model',
  `attribute_model` varchar(255) DEFAULT NULL COMMENT 'Attribute Model',
  `entity_table` varchar(255) DEFAULT NULL COMMENT 'Entity Table',
  `value_table_prefix` varchar(255) DEFAULT NULL COMMENT 'Value Table Prefix',
  `entity_id_field` varchar(255) DEFAULT NULL COMMENT 'Entity Id Field',
  `is_data_sharing` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Defines Is Data Sharing',
  `data_sharing_key` varchar(100) DEFAULT 'default' COMMENT 'Data Sharing Key',
  `default_attribute_set_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Default Attribute Set Id',
  `increment_model` varchar(255) DEFAULT '' COMMENT 'Increment Model',
  `increment_per_store` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Increment Per Store',
  `increment_pad_length` smallint(5) unsigned NOT NULL DEFAULT '8' COMMENT 'Increment Pad Length',
  `increment_pad_char` varchar(1) NOT NULL DEFAULT '0' COMMENT 'Increment Pad Char',
  `additional_attribute_table` varchar(255) DEFAULT '' COMMENT 'Additional Attribute Table',
  `entity_attribute_collection` varchar(255) DEFAULT NULL COMMENT 'Entity Attribute Collection',
  PRIMARY KEY (`entity_type_id`),
  KEY `IDX_EAV_ENTITY_TYPE_ENTITY_TYPE_CODE` (`entity_type_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Eav Entity Type';

LOCK TABLES `eav_entity_type` WRITE;
/*!40000 ALTER TABLE `eav_entity_type` DISABLE KEYS */;

INSERT INTO `eav_entity_type` (`entity_type_id`, `entity_type_code`, `entity_model`, `attribute_model`, `entity_table`, `value_table_prefix`, `entity_id_field`, `is_data_sharing`, `data_sharing_key`, `default_attribute_set_id`, `increment_model`, `increment_per_store`, `increment_pad_length`, `increment_pad_char`, `additional_attribute_table`, `entity_attribute_collection`)
VALUES
	(1,'customer','customer/customer','customer/attribute','customer/entity',NULL,NULL,1,'default',1,'eav/entity_increment_numeric',0,8,'0','customer/eav_attribute','customer/attribute_collection'),
	(2,'customer_address','customer/address','customer/attribute','customer/address_entity',NULL,NULL,1,'default',2,NULL,0,8,'0','customer/eav_attribute','customer/address_attribute_collection'),
	(3,'catalog_category','catalog/category','catalog/resource_eav_attribute','catalog/category',NULL,NULL,1,'default',3,NULL,0,8,'0','catalog/eav_attribute','catalog/category_attribute_collection'),
	(4,'catalog_product','catalog/product','catalog/resource_eav_attribute','catalog/product',NULL,NULL,1,'default',4,NULL,0,8,'0','catalog/eav_attribute','catalog/product_attribute_collection'),
	(5,'order','sales/order',NULL,'sales/order',NULL,NULL,1,'default',0,'eav/entity_increment_numeric',1,8,'0',NULL,NULL),
	(6,'invoice','sales/order_invoice',NULL,'sales/invoice',NULL,NULL,1,'default',0,'eav/entity_increment_numeric',1,8,'0',NULL,NULL),
	(7,'creditmemo','sales/order_creditmemo',NULL,'sales/creditmemo',NULL,NULL,1,'default',0,'eav/entity_increment_numeric',1,8,'0',NULL,NULL),
	(8,'shipment','sales/order_shipment',NULL,'sales/shipment',NULL,NULL,1,'default',0,'eav/entity_increment_numeric',1,8,'0',NULL,NULL),
	(9,'productlabels','productlabels/productlabels','productlabels/attribute','productlabels/productlabels',NULL,NULL,1,'default',9,NULL,0,8,'0','productlabels/eav_attribute','productlabels/attribute_collection'),
	(10,'productlabels_css','productlabels/css','productlabels/attribute','productlabels/css',NULL,NULL,1,'default',10,NULL,0,8,'0','productlabels/eav_attribute','productlabels/attribute_collection');

/*!40000 ALTER TABLE `eav_entity_type` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table eav_entity_varchar
# ------------------------------------------------------------

DROP TABLE IF EXISTS `eav_entity_varchar`;

CREATE TABLE `eav_entity_varchar` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value Id',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type Id',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Id',
  `value` varchar(255) DEFAULT NULL COMMENT 'Attribute Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_EAV_ENTITY_VARCHAR_ENTITY_ID_ATTRIBUTE_ID_STORE_ID` (`entity_id`,`attribute_id`,`store_id`),
  KEY `IDX_EAV_ENTITY_VARCHAR_ENTITY_TYPE_ID` (`entity_type_id`),
  KEY `IDX_EAV_ENTITY_VARCHAR_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_EAV_ENTITY_VARCHAR_STORE_ID` (`store_id`),
  KEY `IDX_EAV_ENTITY_VARCHAR_ENTITY_ID` (`entity_id`),
  KEY `IDX_EAV_ENTITY_VARCHAR_ATTRIBUTE_ID_VALUE` (`attribute_id`,`value`),
  KEY `IDX_EAV_ENTITY_VARCHAR_ENTITY_TYPE_ID_VALUE` (`entity_type_id`,`value`),
  CONSTRAINT `FK_EAV_ENTITY_VARCHAR_ENTITY_ID_EAV_ENTITY_ENTITY_ID` FOREIGN KEY (`entity_id`) REFERENCES `eav_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_EAV_ENTT_VCHR_ENTT_TYPE_ID_EAV_ENTT_TYPE_ENTT_TYPE_ID` FOREIGN KEY (`entity_type_id`) REFERENCES `eav_entity_type` (`entity_type_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_EAV_ENTITY_VARCHAR_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Eav Entity Value Prefix';



# Dump of table eav_form_element
# ------------------------------------------------------------

DROP TABLE IF EXISTS `eav_form_element`;

CREATE TABLE `eav_form_element` (
  `element_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Element Id',
  `type_id` smallint(5) unsigned NOT NULL COMMENT 'Type Id',
  `fieldset_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Fieldset Id',
  `attribute_id` smallint(5) unsigned NOT NULL COMMENT 'Attribute Id',
  `sort_order` int(11) NOT NULL DEFAULT '0' COMMENT 'Sort Order',
  PRIMARY KEY (`element_id`),
  UNIQUE KEY `UNQ_EAV_FORM_ELEMENT_TYPE_ID_ATTRIBUTE_ID` (`type_id`,`attribute_id`),
  KEY `IDX_EAV_FORM_ELEMENT_TYPE_ID` (`type_id`),
  KEY `IDX_EAV_FORM_ELEMENT_FIELDSET_ID` (`fieldset_id`),
  KEY `IDX_EAV_FORM_ELEMENT_ATTRIBUTE_ID` (`attribute_id`),
  CONSTRAINT `FK_EAV_FORM_ELEMENT_ATTRIBUTE_ID_EAV_ATTRIBUTE_ATTRIBUTE_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_EAV_FORM_ELEMENT_FIELDSET_ID_EAV_FORM_FIELDSET_FIELDSET_ID` FOREIGN KEY (`fieldset_id`) REFERENCES `eav_form_fieldset` (`fieldset_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `FK_EAV_FORM_ELEMENT_TYPE_ID_EAV_FORM_TYPE_TYPE_ID` FOREIGN KEY (`type_id`) REFERENCES `eav_form_type` (`type_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Eav Form Element';

LOCK TABLES `eav_form_element` WRITE;
/*!40000 ALTER TABLE `eav_form_element` DISABLE KEYS */;

INSERT INTO `eav_form_element` (`element_id`, `type_id`, `fieldset_id`, `attribute_id`, `sort_order`)
VALUES
	(1,1,NULL,20,0),
	(2,1,NULL,21,1),
	(3,1,NULL,22,2),
	(4,1,NULL,24,3),
	(5,1,NULL,9,4),
	(6,1,NULL,25,5),
	(7,1,NULL,26,6),
	(8,1,NULL,28,7),
	(9,1,NULL,30,8),
	(10,1,NULL,27,9),
	(11,1,NULL,31,10),
	(12,1,NULL,32,11),
	(13,2,NULL,20,0),
	(14,2,NULL,21,1),
	(15,2,NULL,22,2),
	(16,2,NULL,24,3),
	(17,2,NULL,9,4),
	(18,2,NULL,25,5),
	(19,2,NULL,26,6),
	(20,2,NULL,28,7),
	(21,2,NULL,30,8),
	(22,2,NULL,27,9),
	(23,2,NULL,31,10),
	(24,2,NULL,32,11),
	(25,3,NULL,20,0),
	(26,3,NULL,21,1),
	(27,3,NULL,22,2),
	(28,3,NULL,24,3),
	(29,3,NULL,25,4),
	(30,3,NULL,26,5),
	(31,3,NULL,28,6),
	(32,3,NULL,30,7),
	(33,3,NULL,27,8),
	(34,3,NULL,31,9),
	(35,3,NULL,32,10),
	(36,4,NULL,20,0),
	(37,4,NULL,21,1),
	(38,4,NULL,22,2),
	(39,4,NULL,24,3),
	(40,4,NULL,25,4),
	(41,4,NULL,26,5),
	(42,4,NULL,28,6),
	(43,4,NULL,30,7),
	(44,4,NULL,27,8),
	(45,4,NULL,31,9),
	(46,4,NULL,32,10),
	(47,5,1,5,0),
	(48,5,1,6,1),
	(49,5,1,7,2),
	(50,5,1,9,3),
	(51,5,2,24,0),
	(52,5,2,31,1),
	(53,5,2,25,2),
	(54,5,2,26,3),
	(55,5,2,28,4),
	(56,5,2,30,5),
	(57,5,2,27,6);

/*!40000 ALTER TABLE `eav_form_element` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table eav_form_fieldset
# ------------------------------------------------------------

DROP TABLE IF EXISTS `eav_form_fieldset`;

CREATE TABLE `eav_form_fieldset` (
  `fieldset_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Fieldset Id',
  `type_id` smallint(5) unsigned NOT NULL COMMENT 'Type Id',
  `code` varchar(64) NOT NULL COMMENT 'Code',
  `sort_order` int(11) NOT NULL DEFAULT '0' COMMENT 'Sort Order',
  PRIMARY KEY (`fieldset_id`),
  UNIQUE KEY `UNQ_EAV_FORM_FIELDSET_TYPE_ID_CODE` (`type_id`,`code`),
  KEY `IDX_EAV_FORM_FIELDSET_TYPE_ID` (`type_id`),
  CONSTRAINT `FK_EAV_FORM_FIELDSET_TYPE_ID_EAV_FORM_TYPE_TYPE_ID` FOREIGN KEY (`type_id`) REFERENCES `eav_form_type` (`type_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Eav Form Fieldset';

LOCK TABLES `eav_form_fieldset` WRITE;
/*!40000 ALTER TABLE `eav_form_fieldset` DISABLE KEYS */;

INSERT INTO `eav_form_fieldset` (`fieldset_id`, `type_id`, `code`, `sort_order`)
VALUES
	(1,5,'general',1),
	(2,5,'address',2);

/*!40000 ALTER TABLE `eav_form_fieldset` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table eav_form_fieldset_label
# ------------------------------------------------------------

DROP TABLE IF EXISTS `eav_form_fieldset_label`;

CREATE TABLE `eav_form_fieldset_label` (
  `fieldset_id` smallint(5) unsigned NOT NULL COMMENT 'Fieldset Id',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store Id',
  `label` varchar(255) NOT NULL COMMENT 'Label',
  PRIMARY KEY (`fieldset_id`,`store_id`),
  KEY `IDX_EAV_FORM_FIELDSET_LABEL_FIELDSET_ID` (`fieldset_id`),
  KEY `IDX_EAV_FORM_FIELDSET_LABEL_STORE_ID` (`store_id`),
  CONSTRAINT `FK_EAV_FORM_FSET_LBL_FSET_ID_EAV_FORM_FSET_FSET_ID` FOREIGN KEY (`fieldset_id`) REFERENCES `eav_form_fieldset` (`fieldset_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_EAV_FORM_FIELDSET_LABEL_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Eav Form Fieldset Label';

LOCK TABLES `eav_form_fieldset_label` WRITE;
/*!40000 ALTER TABLE `eav_form_fieldset_label` DISABLE KEYS */;

INSERT INTO `eav_form_fieldset_label` (`fieldset_id`, `store_id`, `label`)
VALUES
	(1,0,'Personal Information'),
	(2,0,'Address Information');

/*!40000 ALTER TABLE `eav_form_fieldset_label` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table eav_form_type
# ------------------------------------------------------------

DROP TABLE IF EXISTS `eav_form_type`;

CREATE TABLE `eav_form_type` (
  `type_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Type Id',
  `code` varchar(64) NOT NULL COMMENT 'Code',
  `label` varchar(255) NOT NULL COMMENT 'Label',
  `is_system` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is System',
  `theme` varchar(64) DEFAULT NULL COMMENT 'Theme',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store Id',
  PRIMARY KEY (`type_id`),
  UNIQUE KEY `UNQ_EAV_FORM_TYPE_CODE_THEME_STORE_ID` (`code`,`theme`,`store_id`),
  KEY `IDX_EAV_FORM_TYPE_STORE_ID` (`store_id`),
  CONSTRAINT `FK_EAV_FORM_TYPE_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Eav Form Type';

LOCK TABLES `eav_form_type` WRITE;
/*!40000 ALTER TABLE `eav_form_type` DISABLE KEYS */;

INSERT INTO `eav_form_type` (`type_id`, `code`, `label`, `is_system`, `theme`, `store_id`)
VALUES
	(1,'checkout_onepage_register','checkout_onepage_register',1,'',0),
	(2,'checkout_onepage_register_guest','checkout_onepage_register_guest',1,'',0),
	(3,'checkout_onepage_billing_address','checkout_onepage_billing_address',1,'',0),
	(4,'checkout_onepage_shipping_address','checkout_onepage_shipping_address',1,'',0),
	(5,'checkout_multishipping_register','checkout_multishipping_register',1,'',0);

/*!40000 ALTER TABLE `eav_form_type` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table eav_form_type_entity
# ------------------------------------------------------------

DROP TABLE IF EXISTS `eav_form_type_entity`;

CREATE TABLE `eav_form_type_entity` (
  `type_id` smallint(5) unsigned NOT NULL COMMENT 'Type Id',
  `entity_type_id` smallint(5) unsigned NOT NULL COMMENT 'Entity Type Id',
  PRIMARY KEY (`type_id`,`entity_type_id`),
  KEY `IDX_EAV_FORM_TYPE_ENTITY_ENTITY_TYPE_ID` (`entity_type_id`),
  CONSTRAINT `FK_EAV_FORM_TYPE_ENTT_ENTT_TYPE_ID_EAV_ENTT_TYPE_ENTT_TYPE_ID` FOREIGN KEY (`entity_type_id`) REFERENCES `eav_entity_type` (`entity_type_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_EAV_FORM_TYPE_ENTITY_TYPE_ID_EAV_FORM_TYPE_TYPE_ID` FOREIGN KEY (`type_id`) REFERENCES `eav_form_type` (`type_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Eav Form Type Entity';

LOCK TABLES `eav_form_type_entity` WRITE;
/*!40000 ALTER TABLE `eav_form_type_entity` DISABLE KEYS */;

INSERT INTO `eav_form_type_entity` (`type_id`, `entity_type_id`)
VALUES
	(1,1),
	(2,1),
	(5,1),
	(1,2),
	(2,2),
	(3,2),
	(4,2),
	(5,2);

/*!40000 ALTER TABLE `eav_form_type_entity` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table em_slideshow2_slider
# ------------------------------------------------------------

DROP TABLE IF EXISTS `em_slideshow2_slider`;

CREATE TABLE `em_slideshow2_slider` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Slideshow ID',
  `name` varchar(100) DEFAULT NULL COMMENT 'Slideshow name',
  `identifier` varchar(255) DEFAULT NULL COMMENT 'Identifier',
  `description` mediumtext COMMENT 'description',
  `images` mediumtext COMMENT 'images',
  `slider_type` varchar(20) DEFAULT NULL COMMENT 'Slideshow type',
  `slider_params` mediumtext COMMENT 'Slideshow params',
  `delay` varchar(10) DEFAULT NULL COMMENT 'Slideshow delay',
  `touch` varchar(30) DEFAULT NULL COMMENT 'Slideshow touch',
  `stop_hover` varchar(30) DEFAULT NULL COMMENT 'Slideshow stop hover',
  `shuffle_mode` varchar(30) DEFAULT NULL COMMENT 'Slideshow shuffle mode',
  `stop_slider` varchar(30) DEFAULT NULL COMMENT 'Slideshow stop slider',
  `stop_after_loop` varchar(30) DEFAULT NULL COMMENT 'Slideshow stop after loop',
  `stop_at_slide` varchar(30) DEFAULT NULL COMMENT 'Slideshow stop at slide',
  `position` mediumtext COMMENT 'position',
  `appearance` mediumtext COMMENT 'appearance',
  `navigation` mediumtext COMMENT 'navigation',
  `thumbnail` mediumtext COMMENT 'thumbnail',
  `visibility` mediumtext COMMENT 'visibility',
  `trouble` mediumtext COMMENT 'trouble',
  `creation_time` timestamp NULL DEFAULT NULL COMMENT 'Slideshow Creation Time',
  `update_time` timestamp NULL DEFAULT NULL COMMENT 'Slideshow Modification Time',
  `status` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Is Slideshow Active',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='EM Slideshow2 Slider Table';

LOCK TABLES `em_slideshow2_slider` WRITE;
/*!40000 ALTER TABLE `em_slideshow2_slider` DISABLE KEYS */;

INSERT INTO `em_slideshow2_slider` (`id`, `name`, `identifier`, `description`, `images`, `slider_type`, `slider_params`, `delay`, `touch`, `stop_hover`, `shuffle_mode`, `stop_slider`, `stop_after_loop`, `stop_at_slide`, `position`, `appearance`, `navigation`, `thumbnail`, `visibility`, `trouble`, `creation_time`, `update_time`, `status`)
VALUES
	(1,'Em0120 Main Slideshow','autoupdate_1_em0120_main_slideshow','Coming soon','[{\"url\":\"1403766002_0_slide1.jpg\",\"trans\":\"demo\",\"slotamount\":\"7\",\"masterspeed\":\"\",\"link\":\"\",\"position\":\"1\",\"video\":\"0\",\"kenb\":\"0\",\"kenb_bgfit\":\"100\",\"kenb_bgfitend\":\"200\",\"kenb_dura\":\"3000\",\"info\":[{\"text\":\"\\u003Cp\\u003E\\u003Cimg src=\\\"{{skin url=\'images\\/slideshow\\/text1-slide1.png\'}}\\\" alt=\\\"\\\" \\/\\u003E\\u003C\\/p\\u003E\",\"parallax\":\"0\",\"start\":\"\",\"end\":\"\",\"data_x\":\"553\",\"data_y\":\"150\",\"animation\":\"sft\",\"easing\":\"easeOutBack\",\"speed\":\"500\"},{\"text\":\"\\u003Cp\\u003E\\u003Cimg src=\\\"{{skin url=\'images\\/slideshow\\/text2-slide1.png\'}}\\\" alt=\\\"\\\" \\/\\u003E\\u003C\\/p\\u003E\",\"parallax\":\"0\",\"start\":\"\",\"end\":\"\",\"data_x\":\"593\",\"data_y\":\"368\",\"animation\":\"sfr\",\"easing\":\"easeOutBack\",\"speed\":\"500\"},{\"text\":\"\\u003Ca href=\\\"#\\\" class=\\\"btn-cart\\\"\\u003Estart to shop\\u003C\\/a\\u003E\",\"parallax\":\"0\",\"start\":\"\",\"end\":\"\",\"data_x\":\"700\",\"data_y\":\"455\",\"animation\":\"lfb\",\"easing\":\"easeOutBack\",\"speed\":\"500\"}]},{\"url\":\"1403766002_1_slide2.jpg\",\"trans\":\"demo\",\"slotamount\":\"7\",\"masterspeed\":\"\",\"link\":\"\",\"position\":\"2\",\"video\":\"0\",\"kenb\":\"0\",\"kenb_bgfit\":\"100\",\"kenb_bgfitend\":\"200\",\"kenb_dura\":\"3000\",\"info\":[{\"text\":\"\\u003Cp\\u003E\\u003Cimg src=\\\"{{skin url=\'images\\/slideshow\\/text1-slide2.png\'}}\\\" alt=\\\"\\\" \\/\\u003E\\u003C\\/p\\u003E\",\"parallax\":\"0\",\"start\":\"\",\"end\":\"\",\"data_x\":\"570\",\"data_y\":\"150\",\"animation\":\"randomrotate\",\"easing\":\"easeOutBack\",\"speed\":\"500\"},{\"text\":\"\\u003Cp\\u003E\\u003Cimg src=\\\"{{skin url=\'images\\/slideshow\\/text2-slide2.png\'}}\\\" alt=\\\"\\\" \\/\\u003E\\u003C\\/p\\u003E\",\"parallax\":\"0\",\"start\":\"\",\"end\":\"\",\"data_x\":\"460\",\"data_y\":\"368\",\"animation\":\"lfr\",\"easing\":\"easeOutBack\",\"speed\":\"500\"},{\"text\":\"\\u003Ca href=\\\"#\\\" class=\\\"btn-cart\\\"\\u003Estart to shop\\u003C\\/a\\u003E\",\"parallax\":\"0\",\"start\":\"\",\"end\":\"\",\"data_x\":\"680\",\"data_y\":\"455\",\"animation\":\"randomrotate\",\"easing\":\"easeOutBack\",\"speed\":\"500\"}]},{\"url\":\"1403766002_2_slide3.jpg\",\"trans\":\"demo\",\"slotamount\":\"7\",\"masterspeed\":\"\",\"link\":\"\",\"position\":\"3\",\"video\":\"0\",\"kenb\":\"0\",\"kenb_bgfit\":\"100\",\"kenb_bgfitend\":\"200\",\"kenb_dura\":\"3000\",\"info\":[{\"text\":\"\\u003Cp\\u003E\\u003Cimg src=\\\"{{skin url=\'images\\/slideshow\\/text1-slide3.png\'}}\\\" alt=\\\"\\\" \\/\\u003E\\u003C\\/p\\u003E\",\"parallax\":\"0\",\"start\":\"\",\"end\":\"\",\"data_x\":\"550\",\"data_y\":\"150\",\"animation\":\"randomrotate\",\"easing\":\"easeOutBack\",\"speed\":\"500\"},{\"text\":\"\\u003Cp\\u003E\\u003Cimg src=\\\"{{skin url=\'images\\/slideshow\\/text2-slide3.png\'}}\\\" alt=\\\"\\\" \\/\\u003E\\u003C\\/p\\u003E\",\"parallax\":\"0\",\"start\":\"\",\"end\":\"\",\"data_x\":\"490\",\"data_y\":\"368\",\"animation\":\"randomrotate\",\"easing\":\"easeOutBack\",\"speed\":\"500\"},{\"text\":\"\\u003Ca href=\\\"#\\\" class=\\\"btn-cart\\\"\\u003Estart to shop\\u003C\\/a\\u003E\",\"parallax\":\"0\",\"start\":\"\",\"end\":\"\",\"data_x\":\"710\",\"data_y\":\"455\",\"animation\":\"randomrotate\",\"easing\":\"easeOutBack\",\"speed\":\"500\"}]}]','fullwidth','{\"size_width\":\"1600\",\"size_height\":\"664\",\"screen_width_1\":\"1180\",\"slider_width_1\":\"960\",\"screen_width_2\":\"991\",\"slider_width_2\":\"740\",\"screen_width_3\":\"767\",\"slider_width_3\":\"548\",\"screen_width_4\":\"516\",\"slider_width_4\":\"420\",\"screen_width_5\":\"481\",\"slider_width_5\":\"460\",\"screen_width_6\":\"321\",\"slider_width_6\":\"300\",\"screen_width_7\":\"\",\"slider_width_7\":\"\",\"screen_width_8\":\"\",\"slider_width_8\":\"\",\"screen_width_9\":\"\",\"slider_width_9\":\"\",\"screen_width_10\":\"\",\"slider_width_10\":\"\"}','5000000000','on','on','off','off','0','2','{\"type\":\"center\",\"mg_top\":\"0\",\"mg_bottom\":\"0\",\"mg_left\":\"0\",\"mg_right\":\"0\"}','{\"shadow_type\":\"0\",\"show_time\":\"true\",\"time_position\":\"top\",\"bg_color\":\"\",\"padding\":\"\",\"show_bg_img\":\"false\",\"bg_img\":\"\"}','{\"nav_type\":\"bullet\",\"nav_arrows\":\"verticalcentered\",\"nav_style\":\"preview1\",\"nav_offset_hor\":\"0\",\"nav_offset_vert\":\"20\",\"nav_always_on\":\"false\",\"hide_thumbs\":\"200\"}','{\"thumb_width\":\"100\",\"thumb_height\":\"50\",\"thumb_amount\":\"5\"}','{\"hide_slider_under\":\"0\",\"hide_defined_layers_under\":\"0\",\"hide_all_layers_under\":\"0\"}','{\"jquery_noconflict\":\"on\",\"js_to_body\":\"false\"}','2015-10-02 19:30:53','2015-10-02 19:30:53',1),
	(2,'Em0120 Accessosries Slideshow','autoupdate_2_em0120_accessosries_slideshow','Coming soon','[{\"url\":\"1415875901_0_slide3.jpg\",\"trans\":\"demo\",\"slotamount\":\"7\",\"masterspeed\":\"300\",\"link\":\"\",\"position\":\"0\",\"video\":\"0\",\"kenb\":\"0\",\"kenb_bgfit\":\"100\",\"kenb_bgfitend\":\"200\",\"kenb_dura\":\"3000\",\"info\":[{\"text\":\"\\u003Cp\\u003E\\u003Cimg src=\\\"{{skin url=\'images\\/media\\/s3-text1.png\'}}\\\" alt=\\\"\\\" \\/\\u003E\\u003C\\/p\\u003E\",\"parallax\":\"0\",\"start\":\"\",\"end\":\"\",\"data_x\":\"218\",\"data_y\":\"120\",\"animation\":\"sft\",\"easing\":\"easeOutCubic\",\"speed\":\"300\"},{\"text\":\"\\u003Cp\\u003E\\u003Cimg src=\\\"{{skin url=\'images\\/media\\/s3-text2.png\'}}\\\" alt=\\\"\\\" \\/\\u003E\\u003C\\/p\\u003E\",\"parallax\":\"0\",\"start\":\"\",\"end\":\"\",\"data_x\":\"120\",\"data_y\":\"255\",\"animation\":\"sfl\",\"easing\":\"easeOutBack\",\"speed\":\"300\"},{\"text\":\"\\u003Ca href=\\\"#\\\" class=\\\"btn-cart\\\"\\u003Ediscover\\u003C\\/a\\u003E\",\"parallax\":\"0\",\"start\":\"\",\"end\":\"\",\"data_x\":\"338\",\"data_y\":\"345\",\"animation\":\"lfb\",\"easing\":\"easeInOutCubic\",\"speed\":\"300\"},{\"text\":\"\\u003Cp\\u003E\\u003Cimg src=\\\"{{skin url=\'images\\/media\\/s3-text1-1.png\'}}\\\" alt=\\\"\\\" \\/\\u003E\\u003C\\/p\\u003E\",\"parallax\":\"0\",\"start\":\"\",\"end\":\"\",\"data_x\":\"1010\",\"data_y\":\"120\",\"animation\":\"sft\",\"easing\":\"easeOutBack\",\"speed\":\"300\"},{\"text\":\"\\u003Cp\\u003E\\u003Cimg src=\\\"{{skin url=\'images\\/media\\/s3-text2-2.png\'}}\\\" alt=\\\"\\\" \\/\\u003E\\u003C\\/p\\u003E\",\"parallax\":\"0\",\"start\":\"\",\"end\":\"\",\"data_x\":\"896\",\"data_y\":\"255\",\"animation\":\"sfr\",\"easing\":\"easeOutQuint\",\"speed\":\"300\"},{\"text\":\"\\u003Ca href=\\\"#\\\" class=\\\"btn-cart\\\"\\u003Estart to shop\\u003C\\/a\\u003E\",\"parallax\":\"0\",\"start\":\"\",\"end\":\"\",\"data_x\":\"1030\",\"data_y\":\"345\",\"animation\":\"sft\",\"easing\":\"easeInExpo\",\"speed\":\"300\"}]},{\"url\":\"1406885217_0_slide1.jpg\",\"trans\":\"demo\",\"slotamount\":\"7\",\"masterspeed\":\"\",\"link\":\"#\",\"position\":\"1\",\"video\":\"0\",\"kenb\":\"0\",\"kenb_bgfit\":\"100\",\"kenb_bgfitend\":\"200\",\"kenb_dura\":\"3000\",\"info\":[{\"text\":\"\\u003Cp\\u003E\\u003Cimg src=\\\"{{skin url=\'images\\/media\\/text1.png\'}}\\\" alt=\\\"\\\" \\/\\u003E\\u003C\\/p\\u003E\",\"parallax\":\"0\",\"start\":\"\",\"end\":\"\",\"data_x\":\"218\",\"data_y\":\"120\",\"animation\":\"sfb\",\"easing\":\"easeOutBack\",\"speed\":\"500\"},{\"text\":\"\\u003Cp\\u003E\\u003Cimg src=\\\"{{skin url=\'images\\/media\\/text2.png\'}}\\\" alt=\\\"\\\" \\/\\u003E\\u003C\\/p\\u003E\",\"parallax\":\"0\",\"start\":\"\",\"end\":\"\",\"data_x\":\"120\",\"data_y\":\"255\",\"animation\":\"sft\",\"easing\":\"easeOutBack\",\"speed\":\"500\"},{\"text\":\"\\u003Ca href=\\\"#\\\" class=\\\"btn-cart\\\"\\u003Estart to shop\\u003C\\/a\\u003E\",\"parallax\":\"0\",\"start\":\"\",\"end\":\"\",\"data_x\":\"308\",\"data_y\":\"345\",\"animation\":\"sfl\",\"easing\":\"easeOutBack\",\"speed\":\"500\"},{\"text\":\"\\u003Cp\\u003E\\u003Cimg src=\\\"{{skin url=\'images\\/media\\/text1-1.png\'}}\\\" alt=\\\"\\\" \\/\\u003E\\u003C\\/p\\u003E\",\"parallax\":\"0\",\"start\":\"\",\"end\":\"\",\"data_x\":\"1020\",\"data_y\":\"120\",\"animation\":\"sft\",\"easing\":\"easeOutBack\",\"speed\":\"500\"},{\"text\":\"\\u003Cp\\u003E\\u003Cimg src=\\\"{{skin url=\'images\\/media\\/text2-2.png\'}}\\\" alt=\\\"\\\" \\/\\u003E\\u003C\\/p\\u003E\",\"parallax\":\"0\",\"start\":\"\",\"end\":\"\",\"data_x\":\"896\",\"data_y\":\"255\",\"animation\":\"sfr\",\"easing\":\"easeOutBack\",\"speed\":\"500\"},{\"text\":\"\\u003Ca href=\\\"#\\\" class=\\\"btn-cart\\\"\\u003Estart to shop\\u003C\\/a\\u003E\",\"parallax\":\"0\",\"start\":\"\",\"end\":\"\",\"data_x\":\"1050\",\"data_y\":\"345\",\"animation\":\"randomrotate\",\"easing\":\"easeOutBack\",\"speed\":\"500\"}]},{\"url\":\"1415875756_0_slide2.jpg\",\"trans\":\"demo\",\"slotamount\":\"7\",\"masterspeed\":\"\",\"link\":\"#\",\"position\":\"2\",\"video\":\"0\",\"kenb\":\"0\",\"kenb_bgfit\":\"100\",\"kenb_bgfitend\":\"200\",\"kenb_dura\":\"3000\",\"info\":[{\"text\":\"\\u003Cp\\u003E\\u003Cimg src=\\\"{{skin url=\'images\\/media\\/s2-text1.png\'}}\\\" alt=\\\"\\\" \\/\\u003E\\u003C\\/p\\u003E\",\"parallax\":\"0\",\"start\":\"\",\"end\":\"\",\"data_x\":\"218\",\"data_y\":\"120\",\"animation\":\"fade\",\"easing\":\"easeOutBack\",\"speed\":\"300\"},{\"text\":\"\\u003Cp\\u003E\\u003Cimg src=\\\"{{skin url=\'images\\/media\\/s2-text2.png\'}}\\\" alt=\\\"\\\" \\/\\u003E\\u003C\\/p\\u003E\",\"parallax\":\"0\",\"start\":\"\",\"end\":\"\",\"data_x\":\"240\",\"data_y\":\"255\",\"animation\":\"fade\",\"easing\":\"easeOutBack\",\"speed\":\"300\"},{\"text\":\"\\u003Ca href=\\\"#\\\" class=\\\"btn-cart\\\"\\u003Eview details\\u003C\\/a\\u003E\",\"parallax\":\"0\",\"start\":\"\",\"end\":\"\",\"data_x\":\"318\",\"data_y\":\"345\",\"animation\":\"fade\",\"easing\":\"easeOutBack\",\"speed\":\"300\"},{\"text\":\"\\u003Cp\\u003E\\u003Cimg src=\\\"{{skin url=\'images\\/media\\/s2-text1-1.png\'}}\\\" alt=\\\"\\\" \\/\\u003E\\u003C\\/p\\u003E\",\"parallax\":\"0\",\"start\":\"\",\"end\":\"\",\"data_x\":\"965\",\"data_y\":\"120\",\"animation\":\"fade\",\"easing\":\"easeOutBack\",\"speed\":\"300\"},{\"text\":\"\\u003Cp\\u003E\\u003Cimg src=\\\"{{skin url=\'images\\/media\\/s2-text2-2.png\'}}\\\" alt=\\\"\\\" \\/\\u003E\\u003C\\/p\\u003E\",\"parallax\":\"0\",\"start\":\"\",\"end\":\"\",\"data_x\":\"896\",\"data_y\":\"255\",\"animation\":\"fade\",\"easing\":\"easeOutBack\",\"speed\":\"300\"},{\"text\":\"\\u003Ca href=\\\"#\\\" class=\\\"btn-cart\\\"\\u003Estart to shop\\u003C\\/a\\u003E\",\"parallax\":\"0\",\"start\":\"\",\"end\":\"\",\"data_x\":\"1045\",\"data_y\":\"345\",\"animation\":\"fade\",\"easing\":\"easeOutBack\",\"speed\":\"300\"}]}]','fullwidth','{\"size_width\":\"1600\",\"size_height\":\"486\",\"screen_width_1\":\"1180\",\"slider_width_1\":\"960\",\"screen_width_2\":\"991\",\"slider_width_2\":\"740\",\"screen_width_3\":\"767\",\"slider_width_3\":\"548\",\"screen_width_4\":\"516\",\"slider_width_4\":\"420\",\"screen_width_5\":\"481\",\"slider_width_5\":\"460\",\"screen_width_6\":\"321\",\"slider_width_6\":\"300\",\"screen_width_7\":\"\",\"slider_width_7\":\"\",\"screen_width_8\":\"\",\"slider_width_8\":\"\",\"screen_width_9\":\"\",\"slider_width_9\":\"\",\"screen_width_10\":\"\",\"slider_width_10\":\"\"}','5000','on','on','off','off','0','2','{\"type\":\"center\",\"mg_top\":\"0\",\"mg_bottom\":\"0\",\"mg_left\":\"0\",\"mg_right\":\"0\"}','{\"shadow_type\":\"0\",\"show_time\":\"true\",\"time_position\":\"top\",\"bg_color\":\"\",\"padding\":\"\",\"show_bg_img\":\"false\",\"bg_img\":\"\"}','{\"nav_type\":\"none\",\"nav_arrows\":\"nexttobullets\",\"nav_style\":\"round\",\"nav_offset_hor\":\"0\",\"nav_offset_vert\":\"20\",\"nav_always_on\":\"false\",\"hide_thumbs\":\"200\"}','{\"thumb_width\":\"100\",\"thumb_height\":\"50\",\"thumb_amount\":\"5\"}','{\"hide_slider_under\":\"0\",\"hide_defined_layers_under\":\"0\",\"hide_all_layers_under\":\"0\"}','{\"jquery_noconflict\":\"on\",\"js_to_body\":\"false\"}','2015-10-02 19:30:53','2015-10-02 19:30:53',1),
	(3,'Em0120 Furniture Slideshow','autoupdate_3_em0120_furniture_slideshow','Coming soon','[{\"url\":\"1412139600_2_s3.jpg\",\"trans\":\"demo\",\"slotamount\":\"7\",\"masterspeed\":\"\",\"link\":\"\",\"position\":\"0\",\"video\":\"0\",\"kenb\":\"0\",\"kenb_bgfit\":\"100\",\"kenb_bgfitend\":\"200\",\"kenb_dura\":\"3000\",\"info\":[{\"text\":\"\\u003Cp\\u003E\\u003Cimg src=\\\"{{skin url=\'images\\/media\\/text1.png\'}}\\\" alt=\\\"\\\" \\/\\u003E\\u003C\\/p\\u003E\",\"parallax\":\"0\",\"start\":\"\",\"end\":\"\",\"data_x\":\"250\",\"data_y\":\"130\",\"animation\":\"sft\",\"easing\":\"easeOutBack\",\"speed\":\"300\"},{\"text\":\"\\u003Cp\\u003E\\u003Cimg src=\\\"{{skin url=\'images\\/media\\/text2.png\'}}\\\" alt=\\\"\\\" \\/\\u003E\\u003C\\/p\\u003E\",\"parallax\":\"0\",\"start\":\"\",\"end\":\"\",\"data_x\":\"150\",\"data_y\":\"260\",\"animation\":\"sfr\",\"easing\":\"easeOutBack\",\"speed\":\"300\"},{\"text\":\"\\u003Cp\\u003E\\u003Cimg src=\\\"{{skin url=\'images\\/media\\/text3.png\'}}\\\" alt=\\\"\\\" \\/\\u003E\\u003C\\/p\\u003E\",\"parallax\":\"0\",\"start\":\"\",\"end\":\"\",\"data_x\":\"960\",\"data_y\":\"240\",\"animation\":\"sfb\",\"easing\":\"easeOutBack\",\"speed\":\"300\"},{\"text\":\"\\u003Ca href=\\\"#\\\" class=\\\"btn-cart\\\"\\u003Estart to shop\\u003C\\/a\\u003E\",\"parallax\":\"0\",\"start\":\"\",\"end\":\"\",\"data_x\":\"330\",\"data_y\":\"340\",\"animation\":\"lft\",\"easing\":\"easeOutBack\",\"speed\":\"300\"}]},{\"url\":\"1415864472_0_slider3.jpg\",\"trans\":\"demo\",\"slotamount\":\"7\",\"masterspeed\":\"300\",\"link\":\"\",\"position\":\"0\",\"video\":\"0\",\"kenb\":\"0\",\"kenb_bgfit\":\"100\",\"kenb_bgfitend\":\"200\",\"kenb_dura\":\"3000\",\"info\":[{\"text\":\"\\u003Cp\\u003E\\u003Cimg src=\\\"{{skin url=\'images\\/media\\/text7.png\'}}\\\" alt=\\\"\\\" \\/\\u003E\\u003C\\/p\\u003E\",\"parallax\":\"0\",\"start\":\"\",\"end\":\"\",\"data_x\":\"270\",\"data_y\":\"130\",\"animation\":\"sft\",\"easing\":\"easeOutBack\",\"speed\":\"300\"},{\"text\":\"\\u003Cp\\u003E\\u003Cimg src=\\\"{{skin url=\'images\\/media\\/text8.png\'}}\\\" alt=\\\"\\\" \\/\\u003E\\u003C\\/p\\u003E\",\"parallax\":\"0\",\"start\":\"\",\"end\":\"\",\"data_x\":\"110\",\"data_y\":\"260\",\"animation\":\"sfl\",\"easing\":\"easeOutQuint\",\"speed\":\"300\"},{\"text\":\"\\u003Ca href=\\\"#\\\" class=\\\"btn-cart\\\"\\u003Estart to shop\\u003C\\/a\\u003E\",\"parallax\":\"0\",\"start\":\"\",\"end\":\"\",\"data_x\":\"330\",\"data_y\":\"340\",\"animation\":\"lfb\",\"easing\":\"easeOutCubic\",\"speed\":\"300\"},{\"text\":\"\\u003Cp\\u003E\\u003Cimg src=\\\"{{skin url=\'images\\/media\\/text9.png\'}}\\\" alt=\\\"\\\" \\/\\u003E\\u003C\\/p\\u003E\",\"parallax\":\"0\",\"start\":\"\",\"end\":\"\",\"data_x\":\"960\",\"data_y\":\"240\",\"animation\":\"sfr\",\"easing\":\"easeOutBack\",\"speed\":\"300\"}]},{\"url\":\"1412139600_1_s2.jpg\",\"trans\":\"demo\",\"slotamount\":\"7\",\"masterspeed\":\"\",\"link\":\"\",\"position\":\"1\",\"video\":\"0\",\"kenb\":\"0\",\"kenb_bgfit\":\"100\",\"kenb_bgfitend\":\"200\",\"kenb_dura\":\"3000\",\"info\":[{\"text\":\"\\u003Cp\\u003E\\u003Cimg src=\\\"{{skin url=\'images\\/media\\/text4.png\'}}\\\" alt=\\\"\\\" \\/\\u003E\\u003C\\/p\\u003E\",\"parallax\":\"0\",\"start\":\"\",\"end\":\"\",\"data_x\":\"155\",\"data_y\":\"130\",\"animation\":\"sft\",\"easing\":\"easeOutBack\",\"speed\":\"500\"},{\"text\":\"\\u003Cp\\u003E\\u003Cimg src=\\\"{{skin url=\'images\\/media\\/text5.png\'}}\\\" alt=\\\"\\\" \\/\\u003E\\u003C\\/p\\u003E\",\"parallax\":\"0\",\"start\":\"\",\"end\":\"\",\"data_x\":\"150\",\"data_y\":\"260\",\"animation\":\"sfl\",\"easing\":\"easeInQuart\",\"speed\":\"500\"},{\"text\":\"\\u003Cp\\u003E\\u003Cimg src=\\\"{{skin url=\'images\\/media\\/text6.png\'}}\\\" alt=\\\"\\\" \\/\\u003E\\u003C\\/p\\u003E\",\"parallax\":\"0\",\"start\":\"\",\"end\":\"\",\"data_x\":\"960\",\"data_y\":\"240\",\"animation\":\"sfr\",\"easing\":\"easeOutBack\",\"speed\":\"300\"},{\"text\":\"\\u003Ca href=\\\"#\\\" class=\\\"btn-cart\\\"\\u003Estart to shop\\u003C\\/a\\u003E\",\"parallax\":\"0\",\"start\":\"\",\"end\":\"\",\"data_x\":\"330\",\"data_y\":\"340\",\"animation\":\"lfb\",\"easing\":\"easeOutBack\",\"speed\":\"300\"}]}]','fullwidth','{\"size_width\":\"1180\",\"size_height\":\"490\",\"screen_width_1\":\"1180\",\"slider_width_1\":\"960\",\"screen_width_2\":\"991\",\"slider_width_2\":\"740\",\"screen_width_3\":\"767\",\"slider_width_3\":\"548\",\"screen_width_4\":\"516\",\"slider_width_4\":\"420\",\"screen_width_5\":\"481\",\"slider_width_5\":\"460\",\"screen_width_6\":\"321\",\"slider_width_6\":\"300\",\"screen_width_7\":\"\",\"slider_width_7\":\"\",\"screen_width_8\":\"\",\"slider_width_8\":\"\",\"screen_width_9\":\"\",\"slider_width_9\":\"\",\"screen_width_10\":\"\",\"slider_width_10\":\"\"}','5000','on','on','off','off','0','2','{\"type\":\"center\",\"mg_top\":\"0\",\"mg_bottom\":\"0\",\"mg_left\":\"0\",\"mg_right\":\"0\"}','{\"shadow_type\":\"0\",\"show_time\":\"true\",\"time_position\":\"top\",\"bg_color\":\"\",\"padding\":\"\",\"show_bg_img\":\"false\",\"bg_img\":\"\"}','{\"nav_type\":\"none\",\"nav_arrows\":\"nexttobullets\",\"nav_style\":\"round\",\"nav_offset_hor\":\"0\",\"nav_offset_vert\":\"20\",\"nav_always_on\":\"false\",\"hide_thumbs\":\"200\"}','{\"thumb_width\":\"100\",\"thumb_height\":\"50\",\"thumb_amount\":\"5\"}','{\"hide_slider_under\":\"0\",\"hide_defined_layers_under\":\"0\",\"hide_all_layers_under\":\"0\"}','{\"jquery_noconflict\":\"on\",\"js_to_body\":\"false\"}','2015-10-02 19:30:53','2015-10-02 19:30:53',1),
	(4,'Em0120 Jewellery Slideshow','autoupdate_4_em0120_jewellery_slideshow','Coming soon','[{\"url\":\"1417491937_0_Banner-1.png\",\"trans\":\"demo\",\"slotamount\":\"7\",\"masterspeed\":\"\",\"link\":\"#\",\"position\":\"0\",\"video\":\"0\",\"kenb\":\"0\",\"kenb_bgfit\":\"100\",\"kenb_bgfitend\":\"200\",\"kenb_dura\":\"3000\",\"info\":[{\"text\":\"\\u003Cp\\u003E\\u003Cimg src=\\\"{{skin url=\'images\\/media\\/2_text1.png\'}}\\\" alt=\\\"\\\" \\/\\u003E\\u003C\\/p\\u003E\",\"parallax\":\"0\",\"start\":\"\",\"end\":\"\",\"data_x\":\"350\",\"data_y\":\"390\",\"animation\":\"randomrotate\",\"easing\":\"easeOutBack\",\"speed\":\"500\"},{\"text\":\"\\u003Ca href=\\\"#\\\" class=\\\"btn-cart\\\"\\u003Estart to shop\\u003C\\/a\\u003E\",\"parallax\":\"0\",\"start\":\"\",\"end\":\"\",\"data_x\":\"366\",\"data_y\":\"490\",\"animation\":\"randomrotate\",\"easing\":\"easeOutBack\",\"speed\":\"500\"},{\"text\":\"\\u003Cp\\u003E\\u003Cimg src=\\\"{{skin url=\'images\\/media\\/2_text2.png\'}}\\\" alt=\\\"\\\" \\/\\u003E\\u003C\\/p\\u003E\",\"parallax\":\"0\",\"start\":\"\",\"end\":\"\",\"data_x\":\"960\",\"data_y\":\"35\",\"animation\":\"randomrotate\",\"easing\":\"easeOutBack\",\"speed\":\"500\"}]},{\"url\":\"1417492895_0_Banner-2.png\",\"trans\":\"demo\",\"slotamount\":\"7\",\"masterspeed\":\"\",\"link\":\"\",\"position\":\"0\",\"video\":\"0\",\"kenb\":\"0\",\"kenb_bgfit\":\"100\",\"kenb_bgfitend\":\"200\",\"kenb_dura\":\"3000\",\"info\":[{\"text\":\"\\u003Cp\\u003E\\u003Cimg src=\\\"{{skin url=\'images\\/media\\/1_text1.png\'}}\\\" alt=\\\"\\\" \\/\\u003E\\u003C\\/p\\u003E\",\"parallax\":\"0\",\"start\":\"\",\"end\":\"\",\"data_x\":\"350\",\"data_y\":\"390\",\"animation\":\"randomrotate\",\"easing\":\"easeOutBack\",\"speed\":\"500\"},{\"text\":\"\\u003Ca href=\\\"#\\\" class=\\\"btn-cart\\\"\\u003Estart to shop\\u003C\\/a\\u003E\",\"parallax\":\"0\",\"start\":\"\",\"end\":\"\",\"data_x\":\"360\",\"data_y\":\"490\",\"animation\":\"randomrotate\",\"easing\":\"easeOutBack\",\"speed\":\"500\"},{\"text\":\"\\u003Cp\\u003E\\u003Cimg src=\\\"{{skin url=\'images\\/media\\/1_text2.png\'}}\\\" alt=\\\"\\\" \\/\\u003E\\u003C\\/p\\u003E\",\"parallax\":\"0\",\"start\":\"\",\"end\":\"\",\"data_x\":\"960\",\"data_y\":\"35\",\"animation\":\"randomrotate\",\"easing\":\"easeOutBack\",\"speed\":\"500\"}]},{\"url\":\"1417492895_1_Banner-3.png\",\"trans\":\"demo\",\"slotamount\":\"7\",\"masterspeed\":\"\",\"link\":\"#\",\"position\":\"1\",\"video\":\"0\",\"kenb\":\"0\",\"kenb_bgfit\":\"100\",\"kenb_bgfitend\":\"200\",\"kenb_dura\":\"3000\",\"info\":[{\"text\":\"\\u003Cp\\u003E\\u003Cimg src=\\\"{{skin url=\'images\\/media\\/3_text1.png\'}}\\\" alt=\\\"\\\" \\/\\u003E\\u003C\\/p\\u003E\",\"parallax\":\"0\",\"start\":\"\",\"end\":\"\",\"data_x\":\"342\",\"data_y\":\"390\",\"animation\":\"randomrotate\",\"easing\":\"easeOutBack\",\"speed\":\"500\"},{\"text\":\"\\u003Ca href=\\\"#\\\" class=\\\"btn-cart\\\"\\u003Estart to shop\\u003C\\/a\\u003E\",\"parallax\":\"0\",\"start\":\"\",\"end\":\"\",\"data_x\":\"373\",\"data_y\":\"490\",\"animation\":\"randomrotate\",\"easing\":\"easeOutBack\",\"speed\":\"500\"},{\"text\":\"\\u003Cp\\u003E\\u003Cimg src=\\\"{{skin url=\'images\\/media\\/3_text2.png\'}}\\\" alt=\\\"\\\" \\/\\u003E\\u003C\\/p\\u003E\",\"parallax\":\"0\",\"start\":\"\",\"end\":\"\",\"data_x\":\"960\",\"data_y\":\"35\",\"animation\":\"randomrotate\",\"easing\":\"easeOutBack\",\"speed\":\"500\"}]}]','fullwidth','{\"size_width\":\"1180\",\"size_height\":\"543\",\"screen_width_1\":\"1180\",\"slider_width_1\":\"960\",\"screen_width_2\":\"991\",\"slider_width_2\":\"740\",\"screen_width_3\":\"767\",\"slider_width_3\":\"548\",\"screen_width_4\":\"516\",\"slider_width_4\":\"420\",\"screen_width_5\":\"481\",\"slider_width_5\":\"460\",\"screen_width_6\":\"321\",\"slider_width_6\":\"300\",\"screen_width_7\":\"\",\"slider_width_7\":\"\",\"screen_width_8\":\"\",\"slider_width_8\":\"\",\"screen_width_9\":\"\",\"slider_width_9\":\"\",\"screen_width_10\":\"\",\"slider_width_10\":\"\"}','5000','on','on','off','off','0','2','{\"type\":\"center\",\"mg_top\":\"0\",\"mg_bottom\":\"0\",\"mg_left\":\"0\",\"mg_right\":\"0\"}','{\"shadow_type\":\"0\",\"show_time\":\"true\",\"time_position\":\"top\",\"bg_color\":\"\",\"padding\":\"\",\"show_bg_img\":\"false\",\"bg_img\":\"\"}','{\"nav_type\":\"none\",\"nav_arrows\":\"nexttobullets\",\"nav_style\":\"round\",\"nav_offset_hor\":\"0\",\"nav_offset_vert\":\"20\",\"nav_always_on\":\"false\",\"hide_thumbs\":\"200\"}','{\"thumb_width\":\"100\",\"thumb_height\":\"50\",\"thumb_amount\":\"5\"}','{\"hide_slider_under\":\"0\",\"hide_defined_layers_under\":\"0\",\"hide_all_layers_under\":\"0\"}','{\"jquery_noconflict\":\"on\",\"js_to_body\":\"false\"}','2015-10-02 19:30:53','2015-10-02 19:30:53',1),
	(5,'Em0120 Watches Slideshow','autoupdate_5_em0120_watches_slideshow','Coming soon','[{\"url\":\"1407381699_0_slide.jpg\",\"trans\":\"demo\",\"slotamount\":\"7\",\"masterspeed\":\"\",\"link\":\"#\",\"position\":\"0\",\"video\":\"0\",\"kenb\":\"0\",\"kenb_bgfit\":\"100\",\"kenb_bgfitend\":\"200\",\"kenb_dura\":\"3000\",\"info\":[{\"text\":\"\\u003Cp\\u003E\\u003Cimg  src=\\\"{{skin url=\'images\\/media\\/text1.png}}\\\" alt=\\\"\\\"  \\/\\u003E\\u003C\\/p\\u003E\\r\\n\",\"parallax\":\"0\",\"start\":\"\",\"end\":\"\",\"data_x\":\"250\",\"data_y\":\"120\",\"animation\":\"lft\",\"easing\":\"easeOutBack\",\"speed\":\"500\"},{\"text\":\"\\u003Cp\\u003E\\u003Cimg  src=\\\"{{skin url=\'images\\/media\\/text2.png}}\\\" alt=\\\"\\\"  \\/\\u003E\\u003C\\/p\\u003E\",\"parallax\":\"0\",\"start\":\"\",\"end\":\"\",\"data_x\":\"130\",\"data_y\":\"250\",\"animation\":\"randomrotate\",\"easing\":\"easeOutBack\",\"speed\":\"500\"},{\"text\":\"\\u003Ca href=\\\"#\\\" class=\\\"btn-cart\\\"\\u003Estart to shop\\u003C\\/a\\u003E\",\"parallax\":\"0\",\"start\":\"\",\"end\":\"\",\"data_x\":\"312\",\"data_y\":\"338\",\"animation\":\"fade\",\"easing\":\"easeOutBack\",\"speed\":\"300\"}]},{\"url\":\"1412308803_1_s3.jpg\",\"trans\":\"demo\",\"slotamount\":\"7\",\"masterspeed\":\"\",\"link\":\"\",\"position\":\"0\",\"video\":\"0\",\"kenb\":\"0\",\"kenb_bgfit\":\"100\",\"kenb_bgfitend\":\"200\",\"kenb_dura\":\"3000\",\"info\":[{\"text\":\"\\u003Cp\\u003E\\u003Cimg  src=\\\"{{skin url=\'images\\/media\\/3_text1.png}}\\\" alt=\\\"\\\"  \\/\\u003E\\u003C\\/p\\u003E\\r\\n\",\"parallax\":\"0\",\"start\":\"\",\"end\":\"\",\"data_x\":\"250\",\"data_y\":\"120\",\"animation\":\"sft\",\"easing\":\"easeOutBack\",\"speed\":\"500\"},{\"text\":\"\\u003Cp\\u003E\\u003Cimg  src=\\\"{{skin url=\'images\\/media\\/3_text2.png}}\\\" alt=\\\"\\\"  \\/\\u003E\\u003C\\/p\\u003E\",\"parallax\":\"0\",\"start\":\"\",\"end\":\"\",\"data_x\":\"210\",\"data_y\":\"250\",\"animation\":\"sfb\",\"easing\":\"easeOutBack\",\"speed\":\"500\"},{\"text\":\"\\u003Ca href=\\\"#\\\" class=\\\"btn-cart\\\"\\u003Estart to shop\\u003C\\/a\\u003E\",\"parallax\":\"0\",\"start\":\"\",\"end\":\"\",\"data_x\":\"330\",\"data_y\":\"338\",\"animation\":\"sfr\",\"easing\":\"easeOutBack\",\"speed\":\"500\"}]},{\"url\":\"1412308803_0_s2.jpg\",\"trans\":\"demo\",\"slotamount\":\"7\",\"masterspeed\":\"\",\"link\":\"#\",\"position\":\"1\",\"video\":\"0\",\"kenb\":\"0\",\"kenb_bgfit\":\"100\",\"kenb_bgfitend\":\"200\",\"kenb_dura\":\"3000\",\"info\":[{\"text\":\"\\u003Cp\\u003E\\u003Cimg  src=\\\"{{skin url=\'images\\/media\\/2_text1.png}}\\\" alt=\\\"\\\"  \\/\\u003E\\u003C\\/p\\u003E\\r\\n\",\"parallax\":\"0\",\"start\":\"\",\"end\":\"\",\"data_x\":\"250\",\"data_y\":\"120\",\"animation\":\"lft\",\"easing\":\"easeOutBack\",\"speed\":\"500\"},{\"text\":\"\\u003Cp\\u003E\\u003Cimg  src=\\\"{{skin url=\'images\\/media\\/2_text2.png}}\\\" alt=\\\"\\\"  \\/\\u003E\\u003C\\/p\\u003E\",\"parallax\":\"0\",\"start\":\"\",\"end\":\"\",\"data_x\":\"190\",\"data_y\":\"250\",\"animation\":\"lfr\",\"easing\":\"easeOutBack\",\"speed\":\"500\"},{\"text\":\"\\u003Ca href=\\\"#\\\" class=\\\"btn-cart\\\"\\u003Estart to shop\\u003C\\/a\\u003E\",\"parallax\":\"0\",\"start\":\"\",\"end\":\"\",\"data_x\":\"325\",\"data_y\":\"338\",\"animation\":\"lfb\",\"easing\":\"easeOutBack\",\"speed\":\"500\"}]}]','fullwidth','{\"size_width\":\"1200\",\"size_height\":\"484\",\"screen_width_1\":\"1180\",\"slider_width_1\":\"960\",\"screen_width_2\":\"991\",\"slider_width_2\":\"740\",\"screen_width_3\":\"767\",\"slider_width_3\":\"548\",\"screen_width_4\":\"516\",\"slider_width_4\":\"420\",\"screen_width_5\":\"481\",\"slider_width_5\":\"460\",\"screen_width_6\":\"321\",\"slider_width_6\":\"300\",\"screen_width_7\":\"\",\"slider_width_7\":\"\",\"screen_width_8\":\"\",\"slider_width_8\":\"\",\"screen_width_9\":\"\",\"slider_width_9\":\"\",\"screen_width_10\":\"\",\"slider_width_10\":\"\"}','5000','on','on','off','off','0','2','{\"type\":\"center\",\"mg_top\":\"0\",\"mg_bottom\":\"0\",\"mg_left\":\"0\",\"mg_right\":\"0\"}','{\"shadow_type\":\"0\",\"show_time\":\"true\",\"time_position\":\"top\",\"bg_color\":\"\",\"padding\":\"\",\"show_bg_img\":\"false\",\"bg_img\":\"\"}','{\"nav_type\":\"none\",\"nav_arrows\":\"nexttobullets\",\"nav_style\":\"round\",\"nav_offset_hor\":\"0\",\"nav_offset_vert\":\"20\",\"nav_always_on\":\"false\",\"hide_thumbs\":\"200\"}','{\"thumb_width\":\"100\",\"thumb_height\":\"50\",\"thumb_amount\":\"5\"}','{\"hide_slider_under\":\"0\",\"hide_defined_layers_under\":\"0\",\"hide_all_layers_under\":\"0\"}','{\"jquery_noconflict\":\"on\",\"js_to_body\":\"false\"}','2015-10-02 19:30:53','2015-10-02 19:30:53',1),
	(6,'Em0120 Bikini Slideshow','autoupdate_6_em0120_bikini_slideshow','Coming soon',NULL,'fixed','{\"size_width\":\"960\",\"size_height\":\"350\",\"screen_width_1\":\"940\",\"slider_width_1\":\"770\",\"screen_width_2\":\"780\",\"slider_width_2\":\"500\",\"screen_width_3\":\"510\",\"slider_width_3\":\"310\",\"screen_width_4\":\"\",\"slider_width_4\":\"\",\"screen_width_5\":\"\",\"slider_width_5\":\"\",\"screen_width_6\":\"\",\"slider_width_6\":\"\",\"screen_width_7\":\"\",\"slider_width_7\":\"\",\"screen_width_8\":\"\",\"slider_width_8\":\"\",\"screen_width_9\":\"\",\"slider_width_9\":\"\",\"screen_width_10\":\"\",\"slider_width_10\":\"\"}','5000','on','on','off','off','0','2','{\"type\":\"center\",\"mg_top\":\"0\",\"mg_bottom\":\"0\",\"mg_left\":\"0\",\"mg_right\":\"0\"}','{\"shadow_type\":\"0\",\"show_time\":\"true\",\"time_position\":\"top\",\"bg_color\":\"#E9E9E9\",\"padding\":\"5\",\"show_bg_img\":\"false\",\"bg_img\":\"\"}','{\"nav_type\":\"none\",\"nav_arrows\":\"nexttobullets\",\"nav_style\":\"round\",\"nav_offset_hor\":\"0\",\"nav_offset_vert\":\"20\",\"nav_always_on\":\"false\",\"hide_thumbs\":\"200\"}','{\"thumb_width\":\"100\",\"thumb_height\":\"50\",\"thumb_amount\":\"5\"}','{\"hide_slider_under\":\"0\",\"hide_defined_layers_under\":\"0\",\"hide_all_layers_under\":\"0\"}','{\"jquery_noconflict\":\"on\",\"js_to_body\":\"false\"}','2015-10-02 19:30:53','2015-10-02 19:30:53',1);

/*!40000 ALTER TABLE `em_slideshow2_slider` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table gift_message
# ------------------------------------------------------------

DROP TABLE IF EXISTS `gift_message`;

CREATE TABLE `gift_message` (
  `gift_message_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'GiftMessage Id',
  `customer_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Customer id',
  `sender` varchar(255) DEFAULT NULL COMMENT 'Sender',
  `recipient` varchar(255) DEFAULT NULL COMMENT 'Recipient',
  `message` text COMMENT 'Message',
  PRIMARY KEY (`gift_message_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Gift Message';



# Dump of table importexport_importdata
# ------------------------------------------------------------

DROP TABLE IF EXISTS `importexport_importdata`;

CREATE TABLE `importexport_importdata` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `entity` varchar(50) NOT NULL COMMENT 'Entity',
  `behavior` varchar(10) NOT NULL DEFAULT 'append' COMMENT 'Behavior',
  `data` longtext COMMENT 'Data',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Import Data Table';



# Dump of table index_event
# ------------------------------------------------------------

DROP TABLE IF EXISTS `index_event`;

CREATE TABLE `index_event` (
  `event_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Event Id',
  `type` varchar(64) NOT NULL COMMENT 'Type',
  `entity` varchar(64) NOT NULL COMMENT 'Entity',
  `entity_pk` bigint(20) DEFAULT NULL COMMENT 'Entity Primary Key',
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Creation Time',
  `old_data` mediumtext COMMENT 'Old Data',
  `new_data` mediumtext COMMENT 'New Data',
  PRIMARY KEY (`event_id`),
  UNIQUE KEY `UNQ_INDEX_EVENT_TYPE_ENTITY_ENTITY_PK` (`type`,`entity`,`entity_pk`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Index Event';

LOCK TABLES `index_event` WRITE;
/*!40000 ALTER TABLE `index_event` DISABLE KEYS */;

INSERT INTO `index_event` (`event_id`, `type`, `entity`, `entity_pk`, `created_at`, `old_data`, `new_data`)
VALUES
	(1,'save','catalog_category',1,'2015-10-02 19:24:39',NULL,'a:5:{s:35:\"cataloginventory_stock_match_result\";b:0;s:34:\"catalog_product_price_match_result\";b:0;s:24:\"catalog_url_match_result\";b:1;s:37:\"catalog_category_product_match_result\";b:1;s:35:\"catalogsearch_fulltext_match_result\";b:1;}'),
	(2,'save','catalog_category',2,'2015-10-02 19:24:41',NULL,'a:5:{s:35:\"cataloginventory_stock_match_result\";b:0;s:34:\"catalog_product_price_match_result\";b:0;s:24:\"catalog_url_match_result\";b:1;s:37:\"catalog_category_product_match_result\";b:1;s:35:\"catalogsearch_fulltext_match_result\";b:1;}');

/*!40000 ALTER TABLE `index_event` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table index_process
# ------------------------------------------------------------

DROP TABLE IF EXISTS `index_process`;

CREATE TABLE `index_process` (
  `process_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Process Id',
  `indexer_code` varchar(32) NOT NULL COMMENT 'Indexer Code',
  `status` varchar(15) NOT NULL DEFAULT 'pending' COMMENT 'Status',
  `started_at` timestamp NULL DEFAULT NULL COMMENT 'Started At',
  `ended_at` timestamp NULL DEFAULT NULL COMMENT 'Ended At',
  `mode` varchar(9) NOT NULL DEFAULT 'real_time' COMMENT 'Mode',
  PRIMARY KEY (`process_id`),
  UNIQUE KEY `UNQ_INDEX_PROCESS_INDEXER_CODE` (`indexer_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Index Process';

LOCK TABLES `index_process` WRITE;
/*!40000 ALTER TABLE `index_process` DISABLE KEYS */;

INSERT INTO `index_process` (`process_id`, `indexer_code`, `status`, `started_at`, `ended_at`, `mode`)
VALUES
	(1,'catalog_product_attribute','require_reindex',NULL,NULL,'real_time'),
	(2,'catalog_product_price','require_reindex',NULL,NULL,'real_time'),
	(3,'catalog_url','require_reindex','2015-10-02 19:24:41','2015-10-02 19:24:41','real_time'),
	(4,'catalog_product_flat','require_reindex',NULL,NULL,'real_time'),
	(5,'catalog_category_flat','require_reindex',NULL,NULL,'real_time'),
	(6,'catalog_category_product','require_reindex','2015-10-02 19:24:41','2015-10-02 19:24:41','real_time'),
	(7,'catalogsearch_fulltext','require_reindex','2015-10-02 19:24:41','2015-10-02 19:24:41','real_time'),
	(8,'cataloginventory_stock','require_reindex',NULL,NULL,'real_time'),
	(9,'tag_summary','require_reindex',NULL,NULL,'real_time');

/*!40000 ALTER TABLE `index_process` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table index_process_event
# ------------------------------------------------------------

DROP TABLE IF EXISTS `index_process_event`;

CREATE TABLE `index_process_event` (
  `process_id` int(10) unsigned NOT NULL COMMENT 'Process Id',
  `event_id` bigint(20) unsigned NOT NULL COMMENT 'Event Id',
  `status` varchar(7) NOT NULL DEFAULT 'new' COMMENT 'Status',
  PRIMARY KEY (`process_id`,`event_id`),
  KEY `IDX_INDEX_PROCESS_EVENT_EVENT_ID` (`event_id`),
  CONSTRAINT `FK_INDEX_PROCESS_EVENT_EVENT_ID_INDEX_EVENT_EVENT_ID` FOREIGN KEY (`event_id`) REFERENCES `index_event` (`event_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_INDEX_PROCESS_EVENT_PROCESS_ID_INDEX_PROCESS_PROCESS_ID` FOREIGN KEY (`process_id`) REFERENCES `index_process` (`process_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Index Process Event';



# Dump of table label_css_entity
# ------------------------------------------------------------

DROP TABLE IF EXISTS `label_css_entity`;

CREATE TABLE `label_css_entity` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity ID',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type Id',
  PRIMARY KEY (`entity_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Productlabels Css Entity Table';



# Dump of table label_css_entity_text
# ------------------------------------------------------------

DROP TABLE IF EXISTS `label_css_entity_text`;

CREATE TABLE `label_css_entity_text` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value Id',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type Id',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Id',
  `value` text COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_LABEL_CSS_ENTITY_TEXT_ENTITY_ID_ATTRIBUTE_ID_STORE_ID` (`entity_id`,`attribute_id`,`store_id`),
  KEY `IDX_LABEL_CSS_ENTITY_TEXT_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_LABEL_CSS_ENTITY_TEXT_STORE_ID` (`store_id`),
  KEY `IDX_LABEL_CSS_ENTITY_TEXT_ENTITY_ID` (`entity_id`),
  CONSTRAINT `FK_LABEL_CSS_ENTITY_TEXT_ATTRIBUTE_ID_EAV_ATTRIBUTE_ATTRIBUTE_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_LABEL_CSS_ENTITY_TEXT_ENTITY_ID_LABEL_CSS_ENTITY_ENTITY_ID` FOREIGN KEY (`entity_id`) REFERENCES `label_css_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_LABEL_CSS_ENTITY_TEXT_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Label Entity Text';



# Dump of table label_eav_attribute
# ------------------------------------------------------------

DROP TABLE IF EXISTS `label_eav_attribute`;

CREATE TABLE `label_eav_attribute` (
  `attribute_id` smallint(5) unsigned NOT NULL COMMENT 'Attribute ID',
  `is_global` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Is Global',
  `is_visible` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Is Visible',
  `is_searchable` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Searchable',
  `is_filterable` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Filterable',
  `is_comparable` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Comparable',
  `is_visible_on_front` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Visible On Front',
  `is_html_allowed_on_front` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is HTML Allowed On Front',
  `is_used_for_price_rules` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Used For Price Rules',
  `is_filterable_in_search` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Filterable In Search',
  `used_in_product_listing` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Used In Product Listing',
  `used_for_sort_by` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Used For Sorting',
  `is_configurable` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Is Configurable',
  `apply_to` varchar(255) DEFAULT NULL COMMENT 'Apply To',
  `is_visible_in_advanced_search` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Visible In Advanced Search',
  `position` int(11) NOT NULL DEFAULT '0' COMMENT 'Position',
  `is_wysiwyg_enabled` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is WYSIWYG Enabled',
  `is_used_for_promo_rules` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Used For Promo Rules',
  PRIMARY KEY (`attribute_id`),
  KEY `IDX_LABEL_EAV_ATTRIBUTE_USED_FOR_SORT_BY` (`used_for_sort_by`),
  KEY `IDX_LABEL_EAV_ATTRIBUTE_USED_IN_PRODUCT_LISTING` (`used_in_product_listing`),
  CONSTRAINT `FK_LABEL_EAV_ATTRIBUTE_ATTRIBUTE_ID_EAV_ATTRIBUTE_ATTRIBUTE_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Productlabels EAV Attribute Table';

LOCK TABLES `label_eav_attribute` WRITE;
/*!40000 ALTER TABLE `label_eav_attribute` DISABLE KEYS */;

INSERT INTO `label_eav_attribute` (`attribute_id`, `is_global`, `is_visible`, `is_searchable`, `is_filterable`, `is_comparable`, `is_visible_on_front`, `is_html_allowed_on_front`, `is_used_for_price_rules`, `is_filterable_in_search`, `used_in_product_listing`, `used_for_sort_by`, `is_configurable`, `apply_to`, `is_visible_in_advanced_search`, `position`, `is_wysiwyg_enabled`, `is_used_for_promo_rules`)
VALUES
	(135,0,1,0,0,0,0,0,0,0,0,0,1,NULL,0,0,0,0),
	(136,0,1,0,0,0,0,0,0,0,0,0,1,NULL,0,0,0,0),
	(137,0,1,0,0,0,0,0,0,0,0,0,1,NULL,0,0,0,0),
	(138,0,1,0,0,0,0,0,0,0,0,0,1,NULL,0,0,0,0),
	(139,0,1,0,0,0,0,0,0,0,0,0,1,NULL,0,0,0,0),
	(140,0,1,0,0,0,0,0,0,0,0,0,1,NULL,0,0,0,0),
	(141,1,1,0,0,0,0,0,0,0,0,0,1,NULL,0,0,0,0),
	(142,1,1,0,0,0,0,0,0,0,0,0,1,NULL,0,0,0,0),
	(143,1,1,0,0,0,0,0,0,0,0,0,1,NULL,0,0,0,0),
	(144,0,1,0,0,0,0,0,0,0,0,0,1,NULL,0,0,0,0);

/*!40000 ALTER TABLE `label_eav_attribute` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table label_entity
# ------------------------------------------------------------

DROP TABLE IF EXISTS `label_entity`;

CREATE TABLE `label_entity` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity ID',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type Id',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Created Date',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'Updated Date',
  PRIMARY KEY (`entity_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Productlabels Entity Table';



# Dump of table label_entity_int
# ------------------------------------------------------------

DROP TABLE IF EXISTS `label_entity_int`;

CREATE TABLE `label_entity_int` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value Id',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type Id',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Id',
  `value` int(11) DEFAULT NULL COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_LABEL_ENTITY_INT_ENTITY_ID_ATTRIBUTE_ID_STORE_ID` (`entity_id`,`attribute_id`,`store_id`),
  KEY `IDX_LABEL_ENTITY_INT_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_LABEL_ENTITY_INT_STORE_ID` (`store_id`),
  KEY `IDX_LABEL_ENTITY_INT_ENTITY_ID` (`entity_id`),
  CONSTRAINT `FK_LABEL_ENTITY_INT_ATTRIBUTE_ID_EAV_ATTRIBUTE_ATTRIBUTE_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_LABEL_ENTITY_INT_ENTITY_ID_LABEL_ENTITY_ENTITY_ID` FOREIGN KEY (`entity_id`) REFERENCES `label_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_LABEL_ENTITY_INT_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Label Entity Int';



# Dump of table label_entity_text
# ------------------------------------------------------------

DROP TABLE IF EXISTS `label_entity_text`;

CREATE TABLE `label_entity_text` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value Id',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type Id',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Id',
  `value` text COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_LABEL_ENTITY_TEXT_ENTITY_ID_ATTRIBUTE_ID_STORE_ID` (`entity_id`,`attribute_id`,`store_id`),
  KEY `IDX_LABEL_ENTITY_TEXT_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_LABEL_ENTITY_TEXT_STORE_ID` (`store_id`),
  KEY `IDX_LABEL_ENTITY_TEXT_ENTITY_ID` (`entity_id`),
  CONSTRAINT `FK_LABEL_ENTITY_TEXT_ATTRIBUTE_ID_EAV_ATTRIBUTE_ATTRIBUTE_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_LABEL_ENTITY_TEXT_ENTITY_ID_LABEL_ENTITY_ENTITY_ID` FOREIGN KEY (`entity_id`) REFERENCES `label_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_LABEL_ENTITY_TEXT_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Label Entity Text';



# Dump of table label_entity_varchar
# ------------------------------------------------------------

DROP TABLE IF EXISTS `label_entity_varchar`;

CREATE TABLE `label_entity_varchar` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value Id',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type Id',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Id',
  `value` varchar(255) DEFAULT NULL COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_LABEL_ENTITY_VARCHAR_ENTITY_ID_ATTRIBUTE_ID_STORE_ID` (`entity_id`,`attribute_id`,`store_id`),
  KEY `IDX_LABEL_ENTITY_VARCHAR_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_LABEL_ENTITY_VARCHAR_STORE_ID` (`store_id`),
  KEY `IDX_LABEL_ENTITY_VARCHAR_ENTITY_ID` (`entity_id`),
  CONSTRAINT `FK_LABEL_ENTITY_VARCHAR_ATTRIBUTE_ID_EAV_ATTRIBUTE_ATTRIBUTE_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_LABEL_ENTITY_VARCHAR_ENTITY_ID_LABEL_ENTITY_ENTITY_ID` FOREIGN KEY (`entity_id`) REFERENCES `label_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_LABEL_ENTITY_VARCHAR_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Label Entity Varchar';



# Dump of table ln_filter
# ------------------------------------------------------------

DROP TABLE IF EXISTS `ln_filter`;

CREATE TABLE `ln_filter` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `position` int(11) DEFAULT NULL,
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `attribute_id` smallint(5) DEFAULT NULL,
  `attribute_code` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `display_as` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `store_id` smallint(6) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table ln_option
# ------------------------------------------------------------

DROP TABLE IF EXISTS `ln_option`;

CREATE TABLE `ln_option` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `option_id` int(10) DEFAULT NULL,
  `value` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `image` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table log_customer
# ------------------------------------------------------------

DROP TABLE IF EXISTS `log_customer`;

CREATE TABLE `log_customer` (
  `log_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Log ID',
  `visitor_id` bigint(20) unsigned DEFAULT NULL COMMENT 'Visitor ID',
  `customer_id` int(11) NOT NULL DEFAULT '0' COMMENT 'Customer ID',
  `login_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Login Time',
  `logout_at` timestamp NULL DEFAULT NULL COMMENT 'Logout Time',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store ID',
  PRIMARY KEY (`log_id`),
  KEY `IDX_LOG_CUSTOMER_VISITOR_ID` (`visitor_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Log Customers Table';



# Dump of table log_quote
# ------------------------------------------------------------

DROP TABLE IF EXISTS `log_quote`;

CREATE TABLE `log_quote` (
  `quote_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Quote ID',
  `visitor_id` bigint(20) unsigned DEFAULT NULL COMMENT 'Visitor ID',
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Creation Time',
  `deleted_at` timestamp NULL DEFAULT NULL COMMENT 'Deletion Time',
  PRIMARY KEY (`quote_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Log Quotes Table';



# Dump of table log_summary
# ------------------------------------------------------------

DROP TABLE IF EXISTS `log_summary`;

CREATE TABLE `log_summary` (
  `summary_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Summary ID',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store ID',
  `type_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Type ID',
  `visitor_count` int(11) NOT NULL DEFAULT '0' COMMENT 'Visitor Count',
  `customer_count` int(11) NOT NULL DEFAULT '0' COMMENT 'Customer Count',
  `add_date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Date',
  PRIMARY KEY (`summary_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Log Summary Table';



# Dump of table log_summary_type
# ------------------------------------------------------------

DROP TABLE IF EXISTS `log_summary_type`;

CREATE TABLE `log_summary_type` (
  `type_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Type ID',
  `type_code` varchar(64) DEFAULT NULL COMMENT 'Type Code',
  `period` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Period',
  `period_type` varchar(6) NOT NULL DEFAULT 'MINUTE' COMMENT 'Period Type',
  PRIMARY KEY (`type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Log Summary Types Table';

LOCK TABLES `log_summary_type` WRITE;
/*!40000 ALTER TABLE `log_summary_type` DISABLE KEYS */;

INSERT INTO `log_summary_type` (`type_id`, `type_code`, `period`, `period_type`)
VALUES
	(1,'hour',1,'HOUR'),
	(2,'day',1,'DAY');

/*!40000 ALTER TABLE `log_summary_type` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table log_url
# ------------------------------------------------------------

DROP TABLE IF EXISTS `log_url`;

CREATE TABLE `log_url` (
  `url_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'URL ID',
  `visitor_id` bigint(20) unsigned DEFAULT NULL COMMENT 'Visitor ID',
  `visit_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Visit Time',
  KEY `IDX_LOG_URL_VISITOR_ID` (`visitor_id`),
  KEY `url_id` (`url_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Log URL Table';



# Dump of table log_url_info
# ------------------------------------------------------------

DROP TABLE IF EXISTS `log_url_info`;

CREATE TABLE `log_url_info` (
  `url_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'URL ID',
  `url` varchar(255) DEFAULT NULL COMMENT 'URL',
  `referer` varchar(255) DEFAULT NULL COMMENT 'Referrer',
  PRIMARY KEY (`url_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Log URL Info Table';



# Dump of table log_visitor
# ------------------------------------------------------------

DROP TABLE IF EXISTS `log_visitor`;

CREATE TABLE `log_visitor` (
  `visitor_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Visitor ID',
  `session_id` varchar(64) DEFAULT NULL COMMENT 'Session ID',
  `first_visit_at` timestamp NULL DEFAULT NULL COMMENT 'First Visit Time',
  `last_visit_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Last Visit Time',
  `last_url_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'Last URL ID',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store ID',
  PRIMARY KEY (`visitor_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Log Visitors Table';



# Dump of table log_visitor_info
# ------------------------------------------------------------

DROP TABLE IF EXISTS `log_visitor_info`;

CREATE TABLE `log_visitor_info` (
  `visitor_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'Visitor ID',
  `http_referer` varchar(255) DEFAULT NULL COMMENT 'HTTP Referrer',
  `http_user_agent` varchar(255) DEFAULT NULL COMMENT 'HTTP User-Agent',
  `http_accept_charset` varchar(255) DEFAULT NULL COMMENT 'HTTP Accept-Charset',
  `http_accept_language` varchar(255) DEFAULT NULL COMMENT 'HTTP Accept-Language',
  `server_addr` varbinary(16) DEFAULT NULL,
  `remote_addr` varbinary(16) DEFAULT NULL,
  PRIMARY KEY (`visitor_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Log Visitor Info Table';



# Dump of table log_visitor_online
# ------------------------------------------------------------

DROP TABLE IF EXISTS `log_visitor_online`;

CREATE TABLE `log_visitor_online` (
  `visitor_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Visitor ID',
  `visitor_type` varchar(1) NOT NULL COMMENT 'Visitor Type',
  `remote_addr` varbinary(16) DEFAULT NULL,
  `first_visit_at` timestamp NULL DEFAULT NULL COMMENT 'First Visit Time',
  `last_visit_at` timestamp NULL DEFAULT NULL COMMENT 'Last Visit Time',
  `customer_id` int(10) unsigned DEFAULT NULL COMMENT 'Customer ID',
  `last_url` varchar(255) DEFAULT NULL COMMENT 'Last URL',
  PRIMARY KEY (`visitor_id`),
  KEY `IDX_LOG_VISITOR_ONLINE_VISITOR_TYPE` (`visitor_type`),
  KEY `IDX_LOG_VISITOR_ONLINE_FIRST_VISIT_AT_LAST_VISIT_AT` (`first_visit_at`,`last_visit_at`),
  KEY `IDX_LOG_VISITOR_ONLINE_CUSTOMER_ID` (`customer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Log Visitor Online Table';



# Dump of table megamenupro
# ------------------------------------------------------------

DROP TABLE IF EXISTS `megamenupro`;

CREATE TABLE `megamenupro` (
  `megamenupro_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL DEFAULT '',
  `identifier` varchar(255) NOT NULL DEFAULT '',
  `description` text NOT NULL,
  `type` smallint(6) NOT NULL DEFAULT '0',
  `content` longtext NOT NULL,
  `css_class` varchar(255) DEFAULT NULL,
  `status` smallint(6) NOT NULL DEFAULT '0',
  `created_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  PRIMARY KEY (`megamenupro_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `megamenupro` WRITE;
/*!40000 ALTER TABLE `megamenupro` DISABLE KEYS */;

INSERT INTO `megamenupro` (`megamenupro_id`, `name`, `identifier`, `description`, `type`, `content`, `css_class`, `status`, `created_time`, `update_time`)
VALUES
	(1,'Em0120 Main Megamenu','autoupdate_4_em0120_main_megamenu','Coming soon',0,'[{\"type\":\"link\",\"label\":\"WHATS NEW!\",\"sublabel\":\"\",\"icon_url\":\"\",\"url\":\"\",\"target\":\"\",\"css_class\":\"\",\"container_css\":\"dropdown-menu\",\"depth\":\"0\"},{\"type\":\"hbox\",\"width\":\"\",\"height\":\"\",\"spacing\":\"\",\"css_class\":\"col-menu menu_col10\",\"container_css\":\"\",\"depth\":\"1\"},{\"type\":\"vbox\",\"width\":\"\",\"height\":\"\",\"spacing\":\"\",\"css_class\":\"col-sm-12\",\"container_css\":\"\",\"depth\":\"2\"},{\"type\":\"text\",\"text\":\"PGg1PlN1c3BlbmRpc3NlIHBvdGVuPC9oNT4Ke3t3aWRnZXQgdHlwZT0ibWVnYW1lbnVwcm8vY2F0YWxvZ25hdmlnYXRpb24iIGNhdGVnb3J5X2lkPSJjYXRlZ29yeS8xMiIgZGlyZWN0aW9uPSJ2ZXJ0aWNhbCJ9fQo8aDU+RHVpcyBzYWdpdHRpcyBzb2xsZTwvaDU+Cnt7d2lkZ2V0IHR5cGU9Im1lZ2FtZW51cHJvL2NhdGFsb2duYXZpZ2F0aW9uIiBjYXRlZ29yeV9pZD0iY2F0ZWdvcnkvMTUiIGRpcmVjdGlvbj0idmVydGljYWwifX0=\",\"css_class\":\"\",\"container_css\":\"\",\"depth\":\"3\"},{\"type\":\"vbox\",\"width\":\"\",\"height\":\"\",\"spacing\":\"\",\"css_class\":\"col-sm-12\",\"container_css\":\"\",\"depth\":\"2\"},{\"type\":\"text\",\"text\":\"PGg1PkVsZWlmZW5kIHBlbGxlbnRlczwvaDU+Cnt7d2lkZ2V0IHR5cGU9Im1lZ2FtZW51cHJvL2NhdGFsb2duYXZpZ2F0aW9uIiBjYXRlZ29yeV9pZD0iY2F0ZWdvcnkvMTAiIGRpcmVjdGlvbj0idmVydGljYWwifX0KPGg1PkN1cmFiaXR1ciB0ZW1wdXM8L2g1Pgp7e3dpZGdldCB0eXBlPSJtZWdhbWVudXByby9jYXRhbG9nbmF2aWdhdGlvbiIgY2F0ZWdvcnlfaWQ9ImNhdGVnb3J5LzE1IiBkaXJlY3Rpb249InZlcnRpY2FsIn19\",\"css_class\":\"\",\"container_css\":\"\",\"depth\":\"3\"},{\"type\":\"link\",\"label\":\"WOMEN\",\"sublabel\":\"\",\"icon_url\":\"\",\"url\":\"\",\"target\":\"\",\"css_class\":\"menu-link\",\"container_css\":\"dropdown-menu\",\"depth\":\"0\"},{\"type\":\"hbox\",\"width\":\"\",\"height\":\"\",\"spacing\":\"\",\"css_class\":\"col-menu col-sm-24 col-8\",\"container_css\":\"\",\"depth\":\"1\"},{\"type\":\"text\",\"text\":\"e3t3aWRnZXQgdHlwZT0ibWVnYW1lbnVwcm8vY2F0YWxvZ25hdmlnYXRpb24iIGNhdGVnb3J5X2lkPSJjYXRlZ29yeS8zIiBkaXJlY3Rpb249InZlcnRpY2FsIn19Cg==\",\"css_class\":\"col-sm-24\",\"container_css\":\"\",\"depth\":\"2\"},{\"type\":\"link\",\"label\":\"MEN\",\"sublabel\":\"\",\"icon_url\":\"\",\"url\":\"\",\"target\":\"\",\"css_class\":\"\",\"container_css\":\"dropdown-menu\",\"depth\":\"0\"},{\"type\":\"hbox\",\"width\":\"\",\"height\":\"\",\"spacing\":\"\",\"css_class\":\"container row\",\"container_css\":\"\",\"depth\":\"1\"},{\"type\":\"hbox\",\"width\":\"\",\"height\":\"\",\"spacing\":\"\",\"css_class\":\"col-menu  col-sm-24\",\"container_css\":\"\",\"depth\":\"2\"},{\"type\":\"vbox\",\"width\":\"\",\"height\":\"\",\"spacing\":\"\",\"css_class\":\"\",\"container_css\":\"\",\"depth\":\"3\"},{\"type\":\"text\",\"text\":\"PGg1PlJFVElOQSBSRUFEWTwvaDU+CjxkaXY+e3t3aWRnZXQgdHlwZT0ibWVnYW1lbnVwcm8vY2F0YWxvZ25hdmlnYXRpb24iIGNhdGVnb3J5X2lkPSJjYXRlZ29yeS8xNSJ9fTwvZGl2Pgo=\",\"css_class\":\"col-sm-4\",\"container_css\":\"\",\"depth\":\"4\"},{\"type\":\"text\",\"text\":\"PGg1PkZVTExZIFJFU1BPTlNJVkU8L2g1Pgo8ZGl2Pnt7d2lkZ2V0IHR5cGU9Im1lZ2FtZW51cHJvL2NhdGFsb2duYXZpZ2F0aW9uIiBjYXRlZ29yeV9pZD0iY2F0ZWdvcnkvMTUifX08L2Rpdj4K\",\"css_class\":\"col-sm-4\",\"container_css\":\"\",\"depth\":\"4\"},{\"type\":\"text\",\"text\":\"PGg1PlVOTElNSVRFRCBDT0xPUlM8L2g1Pgo8ZGl2Pnt7d2lkZ2V0IHR5cGU9Im1lZ2FtZW51cHJvL2NhdGFsb2duYXZpZ2F0aW9uIiBjYXRlZ29yeV9pZD0iY2F0ZWdvcnkvMTUifX08L2Rpdj4K\",\"css_class\":\"col-sm-4\",\"container_css\":\"\",\"depth\":\"4\"},{\"type\":\"text\",\"text\":\"PGg1PkNVU1RPTSBXSURHRVRTPC9oNT4KPGRpdj57e3dpZGdldCB0eXBlPSJtZWdhbWVudXByby9jYXRhbG9nbmF2aWdhdGlvbiIgY2F0ZWdvcnlfaWQ9ImNhdGVnb3J5LzE1In19PC9kaXY+Cg==\",\"css_class\":\"col-sm-4\",\"container_css\":\"\",\"depth\":\"4\"},{\"type\":\"text\",\"text\":\"PGg1PkNVU1RPTSBDT0xPUlM8L2g1Pgo8ZGl2Pnt7d2lkZ2V0IHR5cGU9Im1lZ2FtZW51cHJvL2NhdGFsb2duYXZpZ2F0aW9uIiBjYXRlZ29yeV9pZD0iY2F0ZWdvcnkvMTUifX08L2Rpdj4K\",\"css_class\":\"col-sm-4\",\"container_css\":\"\",\"depth\":\"4\"},{\"type\":\"text\",\"text\":\"PGg1PkdPT0dMRSBGT05UUzwvaDU+CjxkaXY+e3t3aWRnZXQgdHlwZT0ibWVnYW1lbnVwcm8vY2F0YWxvZ25hdmlnYXRpb24iIGNhdGVnb3J5X2lkPSJjYXRlZ29yeS8xNSJ9fTwvZGl2Pgo=\",\"css_class\":\"col-sm-4\",\"container_css\":\"\",\"depth\":\"4\"},{\"type\":\"vbox\",\"width\":\"\",\"height\":\"\",\"spacing\":\"\",\"css_class\":\"\",\"container_css\":\"\",\"depth\":\"3\"},{\"type\":\"text\",\"text\":\"PHAgY2xhc3M9ImNvbC10aXRsZSI+SGVyZSBpcyBzb21lIGNvbnRlbnQgd2l0aCBzaWRlIGltYWdlczwvcD4KPHA+PGEgY2xhc3M9ImltZyIgaHJlZj0iIyI+PGltZyBjbGFzcz0iaW1nLXJlc3BvbnNpdmUiIHNyYz0ie3ttZWRpYSB1cmw9Ind5c2l3eWcvbWVudV9pbWcxLnBuZyJ9fSIgYWx0PSIiIC8+PC9hPjwvcD4=\",\"css_class\":\"col-sm-8\",\"container_css\":\"\",\"depth\":\"4\"},{\"type\":\"text\",\"text\":\"PHAgY2xhc3M9ImNvbC10aXRsZSI+WW91IGNhbiB1c2UgaGlnaHRsaWdodCBzb21lIGNvbnRlbnQ8L3A+CjxwPk1hdXJpcyB0aW5jaWR1bnRzIG1hbGVzdWFkYSBwZWxsZW50ZXNxdWUgZmVybWVudHVtIG1pIGZlbGlzIG51bmMganVzdG8gbGFjdXMgZmV1Z2lhdCBub24gdmVoaWN1bGEgc2l0IGFtZXQuIDwvcD4KPHA+RG9uZWMgc29sbGljaXR1ZGluLCBsZWN0dXMgdmVsIHNvZGFsZXMgY29uc2VjdGV0dXIsIGxpYmVybyBuaWJoIGlhY3VsaXMgb2RpbywgYWMgZWxlaWZlbmQgb2RpbyBtaSBpZCBuaXNsLiBFdGlhbSBmZWxpcyBsZW8sIHZ1bHB1dGF0ZSBpbiB2ZXN0aWJ1bHVtIHZhcml1cywgYWNjdW1zYW4gdGVtcG9yIGxpZ3VsYS4gU3VzcGVuZGlzc2UgbWF1cmlzIG5pYmgsIG1vbGxpcyBhYyB0ZW1wdXMgc2l0IGFtZXQsIGZhY2lsaXNpcyBpbiBudW5jLiBQcm9pbiBhYyBvcmNpIGlwc3VtLiBTZWQgcXVpcyB2ZWhpY3VsYSBlc3QuIE51bmMgY29uZ3VlIG5pc2kgdml0YWUgbWkgcGxhY2VyYXQgcGhhcmV0cmEuPGJyLz5uaWJoIGlhY3VsaXMgb2RpbywgYWMgZWxlaWZlbmQgb2RpbyBtaSBpZCBuaXNsLiBFdGlhbSBmZWxpcwpuaWJoIGlhY3VsaXMgb2RpbywgYWMgZWxlaWZlbmQgb2RpbyBtaSBpZCBuaXNsLiA8L3A+\",\"css_class\":\"col-sm-8\",\"container_css\":\"\",\"depth\":\"4\"},{\"type\":\"text\",\"text\":\"PHAgY2xhc3M9ImNvbC10aXRsZSI+Jm5ic3A7PC9wPgo8cD5QZWxsZW50ZXNxdWUgZmVybWVudHVtIG1pIG51bmMganVzdG8gZmV1Z2lhdCBub24gdmVoaWN1bGEgc2l0IGFtZXQsIGRhcGlidXMgc2l0IGFtZXQgaXBzdW0uIDwvcD4KPHA+TnVuYyBwaGFyZXRyYSBsb3JlbSBlZ2V0IHNhcGllbiBvcm5hcmUgaWQgcGxhY2VyYXQgbWFzc2EgbGFjaW5pYS4gTnVsbGEgZmFjaWxpc2kuIFByYWVzZW50IG5pc2kgb2RpbywgcG9zdWVyZSBhYyB2YXJpdXMgZXUsIHBlbGxlbnRlc3F1ZSBzaXQgYW1ldCBuaXNpLiBNb3JiaSB1bGxhbWNvcnBlciBudWxsYSBpZCBsb3JlbSByaG9uY3VzIGJsYW5kaXQuIE51bmMgbW9sZXN0aWUgcHJldGl1bSBwaGFyZXRyYS4gU3VzcGVuZGlzc2UgaW4gZWxpdCBkdWksIGFjIHZlaGljdWxhIGVyYXQuIFZpdmFtdXMgY29uc2VxdWF0IHJpc3VzIHV0IGR1aSBmZXVnaWF0IGVsZWlmZW5kLjxici8+bmliaCBpYWN1bGlzIG9kaW8sIGFjIGVsZWlmZW5kIG9kaW8gbWkgaWQgbmlzbC48YnIvPm1hc3NhIGxhY2luaWEgdWxsYSBmYWNpbGlzaSBwcmFlc2VudCBuaXNpIG9kaW8uIDwvcD4=\",\"css_class\":\"col-sm-8\",\"container_css\":\"\",\"depth\":\"4\"},{\"type\":\"link\",\"label\":\"SALE\",\"sublabel\":\"\",\"icon_url\":\"\",\"url\":\"\",\"target\":\"\",\"css_class\":\"com\",\"container_css\":\"dropdown-menu\",\"depth\":\"0\"},{\"type\":\"hbox\",\"width\":\"\",\"height\":\"\",\"spacing\":\"\",\"css_class\":\"container row\",\"container_css\":\"\",\"depth\":\"1\"},{\"type\":\"vbox\",\"width\":\"\",\"height\":\"\",\"spacing\":\"\",\"css_class\":\"col-menu  col-sm-24\",\"container_css\":\"\",\"depth\":\"2\"},{\"type\":\"text\",\"text\":\"PHA+PGEgY2xhc3M9ImltZyIgaHJlZj0iIyI+PGltZyBzcmM9Int7bWVkaWEgdXJsPSJ3eXNpd3lnL21lbnVfaW1nMi5wbmcifX0iIGFsdD0iIiAvPjwvYT48L3A+CjxwPkRvbmVjIHNvbGxpY2l0dWRpbiwgbGVjdHVzIHZlbCBzb2RhbGVzIGNvbnNlY3RldHVyLCBsaWJlcm8gbmliaCBpYWN1bGlzIG9kaW8sIGFjIGVsZWlmZW5kIG9kaW8gbWkgaWQgbmlzbC4gRXRpYW0gZmVsaXMgbGVvLCB2dWxwdXRhdGUgaW4gdmVzdGlidWx1bSB2YXJpdXMsIGFjY3Vtc2FuIHRlbXBvciBsaWd1bGEuIFN1c3BlbmRpc3NlIG1hdXJpcyBuaWJoLCBtb2xsaXMgYWMgdGVtcHVzIHNpdCBhbWV0LCBmYWNpbGlzaXMgaW4gbnVuYy4gUHJvaW4gYWMgb3JjaSBpcHN1bS48L3A+CjxwPkxvcmVtIGlwc3VtIGRvbG9yIHNpdCBhbWV0LCBjb25zZWN0ZXR1ciBhZGlwaXNjaW5nIGVsaXQuIFZlc3RpYnVsdW0gdmVzdGlidWx1bSBjdXJzdXMgdWx0cmljaWVzLiBRdWlzcXVlIHNlbXBlciwgYXJjdSBldCwgbm9uIHNlbXBlciBzYXBpZW4gbGFjdXMgdXQgbnVsbGEuIEludGVnZXIgdHJpc3RpcXVlIHZlc3RpYnVsdW0gbWFnbmEsIHNpdCBhbWV0IHZlc3RpYnVsdW0gcHVydXMgdmVzdGlidWx1bSBpZC4gQ3JhcyBjdXJzdXMgYmxhbmRpdCB0aW5jaWR1bnQuIENsYXNzIGFwdGVudCB0YWNpdGkgc29jaW9zcXUgYWQgbGl0b3JhIHRvcnF1ZW50LCBwZXIgaW5jZXB0b3MgaGltZW5hZW9zLiBBZW5lYW4gbnVuYyBtYXVyaXMsIG1hdHRpcyBmYXVjaWJ1cyBwb3J0YSBvcm5hcmUsIG1hdHRpcyB1dCBuaXNsLjxici8+dHJpc3RpcXVlIHZlc3RpYnVsdW0gbWFnbmEsIHNpdCBhbWV0IHZlc3RpYnVsdW0gcHVydXMgdmVzdGlidWx1bSBpZC4gQ3JhcyBjdXJzdXMgdGluY2lkdW50LiBDbGFzcyBhcHRlbnQgdGFjaXRpIHNvY2lvc3F1IGFkIGxpdG9yYSB0b3JxdWVudCBub3N0cmEsIHBlciBpbmNlcHRvcyBoaW1lbmFlb3MuIEFlbmVhbiBudW5jIG1hdXJpcywgbWF0dGlzIGZhdWNpYnVzLCBzaXQgYW1ldCB2ZXN0aWJ1bHVtIHB1cnVzLiA8L3A+\",\"css_class\":\"col-sm-8\",\"container_css\":\"\",\"depth\":\"3\"},{\"type\":\"text\",\"text\":\"PGg1PkR1aXMgcG9ydHRpdG9yPC9oNT4KPGRpdj57e3dpZGdldCB0eXBlPSJtZWdhbWVudXByby9jYXRhbG9nbmF2aWdhdGlvbiIgY2F0ZWdvcnlfaWQ9ImNhdGVnb3J5LzE1In19PC9kaXY+CjxkaXY+e3t3aWRnZXQgdHlwZT0ibWVnYW1lbnVwcm8vY2F0YWxvZ25hdmlnYXRpb24iIGNhdGVnb3J5X2lkPSJjYXRlZ29yeS8xNSJ9fTwvZGl2Pg==\",\"css_class\":\"col-sm-4\",\"container_css\":\"\",\"depth\":\"3\"},{\"type\":\"text\",\"text\":\"PGg1PkZ1c2NlIGxpZ3VsYW5pPC9oNT4KPGRpdj57e3dpZGdldCB0eXBlPSJtZWdhbWVudXByby9jYXRhbG9nbmF2aWdhdGlvbiIgY2F0ZWdvcnlfaWQ9ImNhdGVnb3J5LzE1In19PC9kaXY+CjxkaXY+e3t3aWRnZXQgdHlwZT0ibWVnYW1lbnVwcm8vY2F0YWxvZ25hdmlnYXRpb24iIGNhdGVnb3J5X2lkPSJjYXRlZ29yeS8xNSJ9fTwvZGl2Pg==\",\"css_class\":\"col-sm-4\",\"container_css\":\"\",\"depth\":\"3\"},{\"type\":\"text\",\"text\":\"PGg1PkR1aXMgY29tbTwvaDU+CjxkaXY+e3t3aWRnZXQgdHlwZT0ibWVnYW1lbnVwcm8vY2F0YWxvZ25hdmlnYXRpb24iIGNhdGVnb3J5X2lkPSJjYXRlZ29yeS8xNSJ9fTwvZGl2Pgo8ZGl2Pnt7d2lkZ2V0IHR5cGU9Im1lZ2FtZW51cHJvL2NhdGFsb2duYXZpZ2F0aW9uIiBjYXRlZ29yeV9pZD0iY2F0ZWdvcnkvMTUifX08L2Rpdj4=\",\"css_class\":\"col-sm-4\",\"container_css\":\"\",\"depth\":\"3\"},{\"type\":\"text\",\"text\":\"PGRpdiBjbGFzcz0ibm9fcXVpY2tzaG9wIj57e3dpZGdldCB0eXBlPSJmaWx0ZXJwcm9kdWN0cy9saXN0IiB0eXBlX2ZpbHRlcj0iMiIgZmVhdHVyZWQ9ImVtX2ZlYXR1cmVkIiBsaW1pdF9jb3VudD0iMSIgb3JkZXJfYnk9Im5hbWUgYXNjIiBmcm9udGVuZF90aXRsZT0iQmVzdCBzZWxsZXJzIiBzaG93PSJ0aHVtYixuYW1lLHNrdSxwcmljZSIgdGh1bWJuYWlsX3dpZHRoPSIxNzciIHRodW1ibmFpbF9oZWlnaHQ9IjE3NyIgY2hvb3NlX3RlbXBsYXRlPSJlbV9maWx0ZXJwcm9kdWN0cy9zYW1wbGVfZ3JpZC5waHRtbCJ9fTwvZGl2Pg==\",\"css_class\":\"col-sm-4\",\"container_css\":\"\",\"depth\":\"3\"},{\"type\":\"link\",\"label\":\"ACCESSORIES\",\"sublabel\":\"\",\"icon_url\":\"\",\"url\":\"\",\"target\":\"\",\"css_class\":\"com\",\"container_css\":\"dropdown-menu\",\"depth\":\"0\"},{\"type\":\"hbox\",\"width\":\"\",\"height\":\"\",\"spacing\":\"\",\"css_class\":\"container row\",\"container_css\":\"\",\"depth\":\"1\"},{\"type\":\"vbox\",\"width\":\"\",\"height\":\"\",\"spacing\":\"\",\"css_class\":\"col-menu  col-sm-24\",\"container_css\":\"\",\"depth\":\"2\"},{\"type\":\"text\",\"text\":\"PHA+PGEgY2xhc3M9ImltZyIgaHJlZj0iIyI+PGltZyBzcmM9Int7bWVkaWEgdXJsPSJ3eXNpd3lnL21lbnVfaW1nMi5wbmcifX0iIGFsdD0iIiAvPjwvYT48L3A+CjxwPkRvbmVjIHNvbGxpY2l0dWRpbiwgbGVjdHVzIHZlbCBzb2RhbGVzIGNvbnNlY3RldHVyLCBsaWJlcm8gbmliaCBpYWN1bGlzIG9kaW8sIGFjIGVsZWlmZW5kIG9kaW8gbWkgaWQgbmlzbC4gRXRpYW0gZmVsaXMgbGVvLCB2dWxwdXRhdGUgaW4gdmVzdGlidWx1bSB2YXJpdXMsIGFjY3Vtc2FuIHRlbXBvciBsaWd1bGEuIFN1c3BlbmRpc3NlIG1hdXJpcyBuaWJoLCBtb2xsaXMgYWMgdGVtcHVzIHNpdCBhbWV0LCBmYWNpbGlzaXMgaW4gbnVuYy4gUHJvaW4gYWMgb3JjaSBpcHN1bS4gU2VkIHF1aXMgdmVoaWN1bGEgZXN0LiBOdW5jIGNvbmd1ZSBuaXNpIHZpdGFlIG1pIHBsYWNlcmF0IHBoYXJldHJhLiBtYXNzYSBsYWNpbmlhLiBOdWxsYSBmYWNpbGlzaS4gUHJhZXNlbnQgbmlzaSBvZGlvLCBwb3N1ZXJlIGFjIHZhcml1cyBldSwgcGVsbGVudGVzcXVlIHNpdCBhbWV0IG5pc2kuPC9wPgo8cD5Eb25lYyBzb2xsaWNpdHVkaW4sIGxlY3R1cyB2ZWwgc29kYWxlcyBjb25zZWN0ZXR1ciwgbGliZXJvIG5pYmggaWFjdWxpcyBvZGlvLCBhYyBlbGVpZmVuZCBvZGlvIG1pIGlkIG5pc2wuIEV0aWFtIGZlbGlzIGxlbywgdnVscHV0YXRlIGluIHZlc3RpYnVsdW0gdmFyaXVzLCBhY2N1bXNhbiB0ZW1wb3IgbGlndWxhLiBTdXNwZW5kaXNzZSBtYXVyaXMgbmliaCwgbW9sbGlzIGFjIHRlbXB1cyBzaXQgYW1ldCwgZmFjaWxpc2lzIGluIG51bmMuIDwvcD4KPHA+UHJvaW4gYWMgb3JjaSBpcHN1bS4gU2VkIHF1aXMgdmVoaWN1bGEgZXN0LiBOdW5jIGNvbmd1ZSBuaXNpIHZpdGFlIG1pIHBsYWNlcmF0IHBoYXJldHJhLiBtYXNzYSBsYWNpbmlhLiBOdWxsYSBmYWNpbGlzaS4gUHJhZXNlbnQgbmlzaSBvZGlvLCBwb3N1ZXJlIGFjIHZhcml1cyBldSwgcGVsbGVudGVzcXVlIHNpdCBhbWV0IG5pc2kuPC9wPg==\",\"css_class\":\"col-sm-8\",\"container_css\":\"\",\"depth\":\"3\"},{\"type\":\"text\",\"text\":\"PGg1PkJBQ0tHUk9VTkQgUEFURVJOUzwvaDU+CjxkaXY+e3t3aWRnZXQgdHlwZT0ibWVnYW1lbnVwcm8vY2F0YWxvZ25hdmlnYXRpb24iIGNhdGVnb3J5X2lkPSJjYXRlZ29yeS8xNSJ9fTwvZGl2Pgo8ZGl2Pnt7d2lkZ2V0IHR5cGU9Im1lZ2FtZW51cHJvL2NhdGFsb2duYXZpZ2F0aW9uIiBjYXRlZ29yeV9pZD0iY2F0ZWdvcnkvMTUifX08L2Rpdj4=\",\"css_class\":\"col-sm-4\",\"container_css\":\"\",\"depth\":\"3\"},{\"type\":\"text\",\"text\":\"PGg1PlBST0RVQ1QgTEFCRUxTPC9oNT4KPGRpdj57e3dpZGdldCB0eXBlPSJtZWdhbWVudXByby9jYXRhbG9nbmF2aWdhdGlvbiIgY2F0ZWdvcnlfaWQ9ImNhdGVnb3J5LzE1In19PC9kaXY+CjxkaXY+e3t3aWRnZXQgdHlwZT0ibWVnYW1lbnVwcm8vY2F0YWxvZ25hdmlnYXRpb24iIGNhdGVnb3J5X2lkPSJjYXRlZ29yeS8xNSJ9fTwvZGl2Pg==\",\"css_class\":\"col-sm-4\",\"container_css\":\"\",\"depth\":\"3\"},{\"type\":\"text\",\"text\":\"PGEgY2xhc3M9ImltZyIgaHJlZj0iaHR0cDovL3d3dy55b3V0dWJlLmNvbS9lbWJlZC9GRXFYV3dQRnVzSSIgb25jbGljaz0idGFyZ2V0PSdfYmxhbmsnIj4KPGltZyBjbGFzcz0iaW1nLXJlc3BvbnNpdmUiIHNyYz0ie3ttZWRpYSB1cmw9Ind5c2l3eWcvbWVudV92aWRlby5wbmcifX0iIGFsdD0iIiAvPgo8L2E+CjxwPk51bmMgcGhhcmV0cmEgbG9yZW0gZWdldCBzYXBpZW4gb3JuYXJlIGlkIHBsYWNlcmF0IG1hc3NhIGxhY2luaWEuIE51bGxhIGZhY2lsaXNpLiBQcmFlc2VudCBuaXNpIG9kaW8sIHBvc3VlcmUgYWMgdmFyaXVzIGV1LCBwZWxsZW50ZXNxdWUgc2l0IGFtZXQgbmlzaS4gTW9yYmkgdWxsYW1jb3JwZXIgbnVsbGEgaWQgbG9yZW0gcmhvbmN1cyBibGFuZGl0LiBOdW5jIG1vbGVzdGllIHByZXRpdW0gcGhhcmV0cmEuIFN1c3BlbmRpc3NlIGluIGVsaXQgZHVpLCBhYyB2ZWhpY3VsYSBlcmF0LiBWaXZhbXVzIGNvbnNlcXVhdCByaXN1cyB1dCBkdWkgZmV1Z2lhdCBlbGVpZmVuZC48YnIvPm1hc3NhIGxhY2luaWEuIE51bGxhIGZhY2lsaXNpLiBQcmFlc2VudCBuaXNpIG9kaW8sIHBvc3VlcmUgYWMgdmFyaXVzIGV1LCBwZWxsZW50ZXNxdWUgc2l0IGFtZXQgbmlzaS4gIDwvcD4=\",\"css_class\":\"col-sm-8\",\"container_css\":\"\",\"depth\":\"3\"},{\"type\":\"link\",\"label\":\"BRANDS\",\"sublabel\":\"\",\"icon_url\":\"\",\"url\":\"\",\"target\":\"\",\"css_class\":\"\",\"container_css\":\"dropdown-menu\",\"depth\":\"0\"},{\"type\":\"hbox\",\"width\":\"\",\"height\":\"\",\"spacing\":\"\",\"css_class\":\" container row\",\"container_css\":\"\",\"depth\":\"1\"},{\"type\":\"vbox\",\"width\":\"\",\"height\":\"\",\"spacing\":\"\",\"css_class\":\"col-menu col-sm-21\",\"container_css\":\"\",\"depth\":\"2\"},{\"type\":\"text\",\"text\":\"PHAgY2xhc3M9Imxpc3QtaW1nIj48YSBocmVmPSIjIj48aW1nIHNyYz0ie3ttZWRpYSB1cmw9Ind5c2l3eWcvYnJhbmRzL21lbnVfbG9nby5wbmcifX0iIGFsdD0iIiAvPjwvYT4gPGEgaHJlZj0iIyI+PGltZyBzcmM9Int7bWVkaWEgdXJsPSJ3eXNpd3lnL2JyYW5kcy9tZW51X2xvZ28ucG5nIn19IiBhbHQ9IiIgLz48L2E+IDxhIGhyZWY9IiMiPjxpbWcgc3JjPSJ7e21lZGlhIHVybD0id3lzaXd5Zy9icmFuZHMvbWVudV9sb2dvLnBuZyJ9fSIgYWx0PSIiIC8+PC9hPiA8YSBocmVmPSIjIj48aW1nIHNyYz0ie3ttZWRpYSB1cmw9Ind5c2l3eWcvYnJhbmRzL21lbnVfbG9nby5wbmcifX0iIGFsdD0iIiAvPjwvYT4gPGEgaHJlZj0iIyI+PGltZyBzcmM9Int7bWVkaWEgdXJsPSJ3eXNpd3lnL2JyYW5kcy9tZW51X2xvZ28ucG5nIn19IiBhbHQ9IiIgLz48L2E+IDwvcD4=\",\"css_class\":\"\",\"container_css\":\"\",\"depth\":\"3\"},{\"type\":\"link\",\"label\":\"Blog\",\"sublabel\":\"\",\"icon_url\":\"\",\"url\":\"{{store direct_url=\'blog\'}}\",\"target\":\"\",\"css_class\":\"\",\"container_css\":\"\",\"depth\":\"0\"}]',NULL,1,NULL,NULL);

/*!40000 ALTER TABLE `megamenupro` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table newsletter_problem
# ------------------------------------------------------------

DROP TABLE IF EXISTS `newsletter_problem`;

CREATE TABLE `newsletter_problem` (
  `problem_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Problem Id',
  `subscriber_id` int(10) unsigned DEFAULT NULL COMMENT 'Subscriber Id',
  `queue_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Queue Id',
  `problem_error_code` int(10) unsigned DEFAULT '0' COMMENT 'Problem Error Code',
  `problem_error_text` varchar(200) DEFAULT NULL COMMENT 'Problem Error Text',
  PRIMARY KEY (`problem_id`),
  KEY `IDX_NEWSLETTER_PROBLEM_SUBSCRIBER_ID` (`subscriber_id`),
  KEY `IDX_NEWSLETTER_PROBLEM_QUEUE_ID` (`queue_id`),
  CONSTRAINT `FK_NEWSLETTER_PROBLEM_QUEUE_ID_NEWSLETTER_QUEUE_QUEUE_ID` FOREIGN KEY (`queue_id`) REFERENCES `newsletter_queue` (`queue_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_NLTTR_PROBLEM_SUBSCRIBER_ID_NLTTR_SUBSCRIBER_SUBSCRIBER_ID` FOREIGN KEY (`subscriber_id`) REFERENCES `newsletter_subscriber` (`subscriber_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Newsletter Problems';



# Dump of table newsletter_queue
# ------------------------------------------------------------

DROP TABLE IF EXISTS `newsletter_queue`;

CREATE TABLE `newsletter_queue` (
  `queue_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Queue Id',
  `template_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Template Id',
  `newsletter_type` int(11) DEFAULT NULL COMMENT 'Newsletter Type',
  `newsletter_text` text COMMENT 'Newsletter Text',
  `newsletter_styles` text COMMENT 'Newsletter Styles',
  `newsletter_subject` varchar(200) DEFAULT NULL COMMENT 'Newsletter Subject',
  `newsletter_sender_name` varchar(200) DEFAULT NULL COMMENT 'Newsletter Sender Name',
  `newsletter_sender_email` varchar(200) DEFAULT NULL COMMENT 'Newsletter Sender Email',
  `queue_status` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Queue Status',
  `queue_start_at` timestamp NULL DEFAULT NULL COMMENT 'Queue Start At',
  `queue_finish_at` timestamp NULL DEFAULT NULL COMMENT 'Queue Finish At',
  PRIMARY KEY (`queue_id`),
  KEY `IDX_NEWSLETTER_QUEUE_TEMPLATE_ID` (`template_id`),
  CONSTRAINT `FK_NEWSLETTER_QUEUE_TEMPLATE_ID_NEWSLETTER_TEMPLATE_TEMPLATE_ID` FOREIGN KEY (`template_id`) REFERENCES `newsletter_template` (`template_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Newsletter Queue';



# Dump of table newsletter_queue_link
# ------------------------------------------------------------

DROP TABLE IF EXISTS `newsletter_queue_link`;

CREATE TABLE `newsletter_queue_link` (
  `queue_link_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Queue Link Id',
  `queue_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Queue Id',
  `subscriber_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Subscriber Id',
  `letter_sent_at` timestamp NULL DEFAULT NULL COMMENT 'Letter Sent At',
  PRIMARY KEY (`queue_link_id`),
  KEY `IDX_NEWSLETTER_QUEUE_LINK_SUBSCRIBER_ID` (`subscriber_id`),
  KEY `IDX_NEWSLETTER_QUEUE_LINK_QUEUE_ID` (`queue_id`),
  KEY `IDX_NEWSLETTER_QUEUE_LINK_QUEUE_ID_LETTER_SENT_AT` (`queue_id`,`letter_sent_at`),
  CONSTRAINT `FK_NEWSLETTER_QUEUE_LINK_QUEUE_ID_NEWSLETTER_QUEUE_QUEUE_ID` FOREIGN KEY (`queue_id`) REFERENCES `newsletter_queue` (`queue_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_NLTTR_QUEUE_LNK_SUBSCRIBER_ID_NLTTR_SUBSCRIBER_SUBSCRIBER_ID` FOREIGN KEY (`subscriber_id`) REFERENCES `newsletter_subscriber` (`subscriber_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Newsletter Queue Link';



# Dump of table newsletter_queue_store_link
# ------------------------------------------------------------

DROP TABLE IF EXISTS `newsletter_queue_store_link`;

CREATE TABLE `newsletter_queue_store_link` (
  `queue_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Queue Id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  PRIMARY KEY (`queue_id`,`store_id`),
  KEY `IDX_NEWSLETTER_QUEUE_STORE_LINK_STORE_ID` (`store_id`),
  CONSTRAINT `FK_NLTTR_QUEUE_STORE_LNK_QUEUE_ID_NLTTR_QUEUE_QUEUE_ID` FOREIGN KEY (`queue_id`) REFERENCES `newsletter_queue` (`queue_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_NEWSLETTER_QUEUE_STORE_LINK_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Newsletter Queue Store Link';



# Dump of table newsletter_subscriber
# ------------------------------------------------------------

DROP TABLE IF EXISTS `newsletter_subscriber`;

CREATE TABLE `newsletter_subscriber` (
  `subscriber_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Subscriber Id',
  `store_id` smallint(5) unsigned DEFAULT '0' COMMENT 'Store Id',
  `change_status_at` timestamp NULL DEFAULT NULL COMMENT 'Change Status At',
  `customer_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Customer Id',
  `subscriber_email` varchar(150) DEFAULT NULL COMMENT 'Subscriber Email',
  `subscriber_status` int(11) NOT NULL DEFAULT '0' COMMENT 'Subscriber Status',
  `subscriber_confirm_code` varchar(32) DEFAULT 'NULL' COMMENT 'Subscriber Confirm Code',
  PRIMARY KEY (`subscriber_id`),
  KEY `IDX_NEWSLETTER_SUBSCRIBER_CUSTOMER_ID` (`customer_id`),
  KEY `IDX_NEWSLETTER_SUBSCRIBER_STORE_ID` (`store_id`),
  CONSTRAINT `FK_NEWSLETTER_SUBSCRIBER_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Newsletter Subscriber';



# Dump of table newsletter_template
# ------------------------------------------------------------

DROP TABLE IF EXISTS `newsletter_template`;

CREATE TABLE `newsletter_template` (
  `template_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Template Id',
  `template_code` varchar(150) DEFAULT NULL COMMENT 'Template Code',
  `template_text` text COMMENT 'Template Text',
  `template_text_preprocessed` text COMMENT 'Template Text Preprocessed',
  `template_styles` text COMMENT 'Template Styles',
  `template_type` int(10) unsigned DEFAULT NULL COMMENT 'Template Type',
  `template_subject` varchar(200) DEFAULT NULL COMMENT 'Template Subject',
  `template_sender_name` varchar(200) DEFAULT NULL COMMENT 'Template Sender Name',
  `template_sender_email` varchar(200) DEFAULT NULL COMMENT 'Template Sender Email',
  `template_actual` smallint(5) unsigned DEFAULT '1' COMMENT 'Template Actual',
  `added_at` timestamp NULL DEFAULT NULL COMMENT 'Added At',
  `modified_at` timestamp NULL DEFAULT NULL COMMENT 'Modified At',
  PRIMARY KEY (`template_id`),
  KEY `IDX_NEWSLETTER_TEMPLATE_TEMPLATE_ACTUAL` (`template_actual`),
  KEY `IDX_NEWSLETTER_TEMPLATE_ADDED_AT` (`added_at`),
  KEY `IDX_NEWSLETTER_TEMPLATE_MODIFIED_AT` (`modified_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Newsletter Template';

LOCK TABLES `newsletter_template` WRITE;
/*!40000 ALTER TABLE `newsletter_template` DISABLE KEYS */;

INSERT INTO `newsletter_template` (`template_id`, `template_code`, `template_text`, `template_text_preprocessed`, `template_styles`, `template_type`, `template_subject`, `template_sender_name`, `template_sender_email`, `template_actual`, `added_at`, `modified_at`)
VALUES
	(1,'Example Newsletter Template','{{template config_path=\"design/email/header\"}}\n{{inlinecss file=\"email-inline.css\"}}\n\n<table cellpadding=\"0\" cellspacing=\"0\" border=\"0\">\n<tr>\n    <td class=\"full\">\n        <table class=\"columns\">\n            <tr>\n                <td class=\"email-heading\">\n                    <h1>Welcome</h1>\n                    <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit,\n                    sed do eiusmod tempor incididunt ut labore et.</p>\n                </td>\n                <td class=\"store-info\">\n                    <h4>Contact Us</h4>\n                    <p>\n                        {{depend store_phone}}\n                        <b>Call Us:</b>\n                        <a href=\"tel:{{var phone}}\">{{var store_phone}}</a><br>\n                        {{/depend}}\n                        {{depend store_hours}}\n                        <span class=\"no-link\">{{var store_hours}}</span><br>\n                        {{/depend}}\n                        {{depend store_email}}\n                        <b>Email:</b> <a href=\"mailto:{{var store_email}}\">{{var store_email}}</a>\n                        {{/depend}}\n                    </p>\n                </td>\n            </tr>\n        </table>\n    </td>\n</tr>\n<tr>\n    <td class=\"full\">\n        <table class=\"columns\">\n            <tr>\n                <td>\n                    <img width=\"600\" src=\"http://placehold.it/600x200\" class=\"main-image\">\n                </td>\n                <td class=\"expander\"></td>\n            </tr>\n        </table>\n        <table class=\"columns\">\n            <tr>\n                <td class=\"panel\">\n                    <p>Phasellus dictum sapien a neque luctus cursus. Pellentesque sem dolor, fringilla et pharetra\n                    vitae. <a href=\"#\">Click it! &raquo;</a></p>\n                </td>\n                <td class=\"expander\"></td>\n            </tr>\n        </table>\n    </td>\n</tr>\n<tr>\n    <td>\n        <table class=\"row\">\n            <tr>\n                <td class=\"half left wrapper\">\n                    <table class=\"columns\">\n                        <tr>\n                            <td>\n                                <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor\n                                incididunt ut labore et. Lorem ipsum dolor sit amet, consectetur adipisicing elit,\n                                sed do eiusmod tempor incididunt ut labore et. Lorem ipsum dolor sit amet.</p>\n                                <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor\n                                incididunt ut labore et. Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed\n                                do eiusmod tempor incididunt ut labore et. Lorem ipsum dolor sit amet.</p>\n                                <table class=\"button\">\n                                    <tr>\n                                        <td>\n                                            <a href=\"#\">Click Me!</a>\n                                        </td>\n                                    </tr>\n                                </table>\n                            </td>\n                            <td class=\"expander\"></td>\n                        </tr>\n                    </table>\n                </td>\n                <td class=\"half right wrapper last\">\n                    <table class=\"columns\">\n                        <tr>\n                            <td class=\"panel sidebar-links\">\n                                <h6>Header Thing</h6>\n                                <p>Sub-head or something</p>\n                                <table>\n                                    <tr>\n                                        <td>\n                                            <p><a href=\"#\">Just a Plain Link &raquo;</a></p>\n                                        </td>\n                                    </tr>\n                                    <tr>\n                                        <td>\n                                            <hr/>\n                                        </td>\n                                    </tr>\n                                    <tr>\n                                        <td>\n                                            <p><a href=\"#\">Just a Plain Link &raquo;</a></p>\n                                        </td>\n                                    </tr>\n                                    <tr>\n                                        <td>\n                                            <hr/>\n                                        </td>\n                                    </tr>\n                                    <tr>\n                                        <td>\n                                            <p><a href=\"#\">Just a Plain Link &raquo;</a></p>\n                                        </td>\n                                    </tr>\n                                    <tr>\n                                        <td>\n                                            <hr/>\n                                        </td>\n                                    </tr>\n                                    <tr>\n                                        <td>\n                                            <p><a href=\"#\">Just a Plain Link &raquo;</a></p>\n                                        </td>\n                                    </tr>\n                                    <tr>\n                                        <td>\n                                            <hr/>\n                                        </td>\n                                    </tr>\n                                    <tr>\n                                        <td>\n                                            <p><a href=\"#\">Just a Plain Link &raquo;</a></p>\n                                        </td>\n                                    </tr>\n                                    <tr>\n                                        <td>\n                                            <hr/>\n                                        </td>\n                                    </tr>\n                                    <tr>\n                                        <td>\n                                            <p><a href=\"#\">Just a Plain Link &raquo;</a></p>\n                                        </td>\n                                    </tr>\n                                    <tr>\n                                        <td>\n                                            <hr/>\n                                        </td>\n                                    </tr>\n                                    <tr>\n                                        <td>\n                                            <p><a href=\"#\">Just a Plain Link &raquo;</a></p>\n                                        </td>\n                                    </tr>\n                                    <tr><td>&nbsp;</td></tr>\n                                </table>\n                            </td>\n                            <td class=\"expander\"></td>\n                        </tr>\n                    </table>\n                    <br>\n                    <table class=\"columns\">\n                        <tr>\n                            <td class=\"panel\">\n                                <h6>Connect With Us:</h6>\n                                <table class=\"social-button facebook\">\n                                    <tr>\n                                        <td>\n                                            <a href=\"#\">Facebook</a>\n                                        </td>\n                                    </tr>\n                                </table>\n                                <hr>\n                                <table class=\"social-button twitter\">\n                                    <tr>\n                                        <td>\n                                            <a href=\"#\">Twitter</a>\n                                        </td>\n                                    </tr>\n                                </table>\n                                <hr>\n                                <table class=\"social-button google-plus\">\n                                    <tr>\n                                        <td>\n                                            <a href=\"#\">Google +</a>\n                                        </td>\n                                    </tr>\n                                </table>\n                                <br>\n                                <h6>Contact Info:</h6>\n                                {{depend store_phone}}\n                                <p>\n                                    <b>Call Us:</b>\n                                    <a href=\"tel:{{var phone}}\">{{var store_phone}}</a>\n                                </p>\n                                {{/depend}}\n                                {{depend store_hours}}\n                                <p><span class=\"no-link\">{{var store_hours}}</span><br></p>\n                                {{/depend}}\n                                {{depend store_email}}\n                                <p><b>Email:</b> <a href=\"mailto:{{var store_email}}\">{{var store_email}}</a></p>\n                                {{/depend}}\n                            </td>\n                            <td class=\"expander\"></td>\n                        </tr>\n                    </table>\n                </td>\n            </tr>\n        </table>\n        <table class=\"row\">\n            <tr>\n                <td class=\"full wrapper\">\n                    {{block type=\"catalog/product_new\" template=\"email/catalog/product/new.phtml\" products_count=\"4\"\n                    column_count=\"4\" }}\n                </td>\n            </tr>\n        </table>\n        <table class=\"row\">\n            <tr>\n                <td class=\"full wrapper last\">\n                    <table class=\"columns\">\n                        <tr>\n                            <td align=\"center\">\n                                <center>\n                                    <p><a href=\"#\">Terms</a> | <a href=\"#\">Privacy</a> | <a href=\"#\">Unsubscribe</a></p>\n                                </center>\n                            </td>\n                            <td class=\"expander\"></td>\n                        </tr>\n                    </table>\n                </td>\n            </tr>\n        </table>\n    </td>\n</tr>\n</table>\n\n{{template config_path=\"design/email/footer\"}}',NULL,NULL,2,'Example Subject','Owner','owner@example.com',1,'2015-10-02 19:24:42','2015-10-02 19:24:42');

/*!40000 ALTER TABLE `newsletter_template` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table oauth_consumer
# ------------------------------------------------------------

DROP TABLE IF EXISTS `oauth_consumer`;

CREATE TABLE `oauth_consumer` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Created At',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'Updated At',
  `name` varchar(255) NOT NULL COMMENT 'Name of consumer',
  `key` varchar(32) NOT NULL COMMENT 'Key code',
  `secret` varchar(32) NOT NULL COMMENT 'Secret code',
  `callback_url` varchar(255) DEFAULT NULL COMMENT 'Callback URL',
  `rejected_callback_url` varchar(255) NOT NULL COMMENT 'Rejected callback URL',
  PRIMARY KEY (`entity_id`),
  UNIQUE KEY `UNQ_OAUTH_CONSUMER_KEY` (`key`),
  UNIQUE KEY `UNQ_OAUTH_CONSUMER_SECRET` (`secret`),
  KEY `IDX_OAUTH_CONSUMER_CREATED_AT` (`created_at`),
  KEY `IDX_OAUTH_CONSUMER_UPDATED_AT` (`updated_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='OAuth Consumers';



# Dump of table oauth_nonce
# ------------------------------------------------------------

DROP TABLE IF EXISTS `oauth_nonce`;

CREATE TABLE `oauth_nonce` (
  `nonce` varchar(32) NOT NULL COMMENT 'Nonce String',
  `timestamp` int(10) unsigned NOT NULL COMMENT 'Nonce Timestamp',
  UNIQUE KEY `UNQ_OAUTH_NONCE_NONCE` (`nonce`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='oauth_nonce';



# Dump of table oauth_token
# ------------------------------------------------------------

DROP TABLE IF EXISTS `oauth_token`;

CREATE TABLE `oauth_token` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity ID',
  `consumer_id` int(10) unsigned NOT NULL COMMENT 'Consumer ID',
  `admin_id` int(10) unsigned DEFAULT NULL COMMENT 'Admin user ID',
  `customer_id` int(10) unsigned DEFAULT NULL COMMENT 'Customer user ID',
  `type` varchar(16) NOT NULL COMMENT 'Token Type',
  `token` varchar(32) NOT NULL COMMENT 'Token',
  `secret` varchar(32) NOT NULL COMMENT 'Token Secret',
  `verifier` varchar(32) DEFAULT NULL COMMENT 'Token Verifier',
  `callback_url` varchar(255) NOT NULL COMMENT 'Token Callback URL',
  `revoked` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Token revoked',
  `authorized` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Token authorized',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Token creation timestamp',
  PRIMARY KEY (`entity_id`),
  UNIQUE KEY `UNQ_OAUTH_TOKEN_TOKEN` (`token`),
  KEY `IDX_OAUTH_TOKEN_CONSUMER_ID` (`consumer_id`),
  KEY `FK_OAUTH_TOKEN_ADMIN_ID_ADMIN_USER_USER_ID` (`admin_id`),
  KEY `FK_OAUTH_TOKEN_CUSTOMER_ID_CUSTOMER_ENTITY_ENTITY_ID` (`customer_id`),
  CONSTRAINT `FK_OAUTH_TOKEN_ADMIN_ID_ADMIN_USER_USER_ID` FOREIGN KEY (`admin_id`) REFERENCES `admin_user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_OAUTH_TOKEN_CONSUMER_ID_OAUTH_CONSUMER_ENTITY_ID` FOREIGN KEY (`consumer_id`) REFERENCES `oauth_consumer` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_OAUTH_TOKEN_CUSTOMER_ID_CUSTOMER_ENTITY_ENTITY_ID` FOREIGN KEY (`customer_id`) REFERENCES `customer_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='OAuth Tokens';



# Dump of table paypal_cert
# ------------------------------------------------------------

DROP TABLE IF EXISTS `paypal_cert`;

CREATE TABLE `paypal_cert` (
  `cert_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Cert Id',
  `website_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Website Id',
  `content` text COMMENT 'Content',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'Updated At',
  PRIMARY KEY (`cert_id`),
  KEY `IDX_PAYPAL_CERT_WEBSITE_ID` (`website_id`),
  CONSTRAINT `FK_PAYPAL_CERT_WEBSITE_ID_CORE_WEBSITE_WEBSITE_ID` FOREIGN KEY (`website_id`) REFERENCES `core_website` (`website_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Paypal Certificate Table';



# Dump of table paypal_payment_transaction
# ------------------------------------------------------------

DROP TABLE IF EXISTS `paypal_payment_transaction`;

CREATE TABLE `paypal_payment_transaction` (
  `transaction_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `txn_id` varchar(100) DEFAULT NULL COMMENT 'Txn Id',
  `additional_information` blob COMMENT 'Additional Information',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Created At',
  PRIMARY KEY (`transaction_id`),
  UNIQUE KEY `UNQ_PAYPAL_PAYMENT_TRANSACTION_TXN_ID` (`txn_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='PayPal Payflow Link Payment Transaction';



# Dump of table paypal_settlement_report
# ------------------------------------------------------------

DROP TABLE IF EXISTS `paypal_settlement_report`;

CREATE TABLE `paypal_settlement_report` (
  `report_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Report Id',
  `report_date` timestamp NULL DEFAULT NULL COMMENT 'Report Date',
  `account_id` varchar(64) DEFAULT NULL COMMENT 'Account Id',
  `filename` varchar(24) DEFAULT NULL COMMENT 'Filename',
  `last_modified` timestamp NULL DEFAULT NULL COMMENT 'Last Modified',
  PRIMARY KEY (`report_id`),
  UNIQUE KEY `UNQ_PAYPAL_SETTLEMENT_REPORT_REPORT_DATE_ACCOUNT_ID` (`report_date`,`account_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Paypal Settlement Report Table';



# Dump of table paypal_settlement_report_row
# ------------------------------------------------------------

DROP TABLE IF EXISTS `paypal_settlement_report_row`;

CREATE TABLE `paypal_settlement_report_row` (
  `row_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Row Id',
  `report_id` int(10) unsigned NOT NULL COMMENT 'Report Id',
  `transaction_id` varchar(19) DEFAULT NULL COMMENT 'Transaction Id',
  `invoice_id` varchar(127) DEFAULT NULL COMMENT 'Invoice Id',
  `paypal_reference_id` varchar(19) DEFAULT NULL COMMENT 'Paypal Reference Id',
  `paypal_reference_id_type` varchar(3) DEFAULT NULL COMMENT 'Paypal Reference Id Type',
  `transaction_event_code` varchar(5) DEFAULT NULL COMMENT 'Transaction Event Code',
  `transaction_initiation_date` timestamp NULL DEFAULT NULL COMMENT 'Transaction Initiation Date',
  `transaction_completion_date` timestamp NULL DEFAULT NULL COMMENT 'Transaction Completion Date',
  `transaction_debit_or_credit` varchar(2) NOT NULL DEFAULT 'CR' COMMENT 'Transaction Debit Or Credit',
  `gross_transaction_amount` decimal(20,6) NOT NULL DEFAULT '0.000000' COMMENT 'Gross Transaction Amount',
  `gross_transaction_currency` varchar(3) DEFAULT '' COMMENT 'Gross Transaction Currency',
  `fee_debit_or_credit` varchar(2) DEFAULT NULL COMMENT 'Fee Debit Or Credit',
  `fee_amount` decimal(20,6) NOT NULL DEFAULT '0.000000' COMMENT 'Fee Amount',
  `fee_currency` varchar(3) DEFAULT NULL COMMENT 'Fee Currency',
  `custom_field` varchar(255) DEFAULT NULL COMMENT 'Custom Field',
  `consumer_id` varchar(127) DEFAULT NULL COMMENT 'Consumer Id',
  `payment_tracking_id` varchar(255) DEFAULT NULL COMMENT 'Payment Tracking ID',
  `store_id` varchar(50) DEFAULT NULL COMMENT 'Store ID',
  PRIMARY KEY (`row_id`),
  KEY `IDX_PAYPAL_SETTLEMENT_REPORT_ROW_REPORT_ID` (`report_id`),
  CONSTRAINT `FK_E183E488F593E0DE10C6EBFFEBAC9B55` FOREIGN KEY (`report_id`) REFERENCES `paypal_settlement_report` (`report_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Paypal Settlement Report Row Table';



# Dump of table persistent_session
# ------------------------------------------------------------

DROP TABLE IF EXISTS `persistent_session`;

CREATE TABLE `persistent_session` (
  `persistent_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Session id',
  `key` varchar(50) NOT NULL COMMENT 'Unique cookie key',
  `customer_id` int(10) unsigned DEFAULT NULL COMMENT 'Customer id',
  `website_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Website ID',
  `info` text COMMENT 'Session Data',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'Updated At',
  PRIMARY KEY (`persistent_id`),
  UNIQUE KEY `IDX_PERSISTENT_SESSION_KEY` (`key`),
  UNIQUE KEY `IDX_PERSISTENT_SESSION_CUSTOMER_ID` (`customer_id`),
  KEY `IDX_PERSISTENT_SESSION_UPDATED_AT` (`updated_at`),
  KEY `FK_PERSISTENT_SESSION_WEBSITE_ID_CORE_WEBSITE_WEBSITE_ID` (`website_id`),
  CONSTRAINT `FK_PERSISTENT_SESSION_CUSTOMER_ID_CUSTOMER_ENTITY_ENTITY_ID` FOREIGN KEY (`customer_id`) REFERENCES `customer_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `FK_PERSISTENT_SESSION_WEBSITE_ID_CORE_WEBSITE_WEBSITE_ID` FOREIGN KEY (`website_id`) REFERENCES `core_website` (`website_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Persistent Session';



# Dump of table poll
# ------------------------------------------------------------

DROP TABLE IF EXISTS `poll`;

CREATE TABLE `poll` (
  `poll_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Poll Id',
  `poll_title` varchar(255) DEFAULT NULL COMMENT 'Poll title',
  `votes_count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Votes Count',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store id',
  `date_posted` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Date posted',
  `date_closed` timestamp NULL DEFAULT NULL COMMENT 'Date closed',
  `active` smallint(6) NOT NULL DEFAULT '1' COMMENT 'Is active',
  `closed` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Is closed',
  `answers_display` smallint(6) DEFAULT NULL COMMENT 'Answers display',
  PRIMARY KEY (`poll_id`),
  KEY `IDX_POLL_STORE_ID` (`store_id`),
  CONSTRAINT `FK_POLL_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Poll';

LOCK TABLES `poll` WRITE;
/*!40000 ALTER TABLE `poll` DISABLE KEYS */;

INSERT INTO `poll` (`poll_id`, `poll_title`, `votes_count`, `store_id`, `date_posted`, `date_closed`, `active`, `closed`, `answers_display`)
VALUES
	(1,'What is your favorite color',7,0,'2015-10-02 19:24:41',NULL,1,0,NULL);

/*!40000 ALTER TABLE `poll` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table poll_answer
# ------------------------------------------------------------

DROP TABLE IF EXISTS `poll_answer`;

CREATE TABLE `poll_answer` (
  `answer_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Answer Id',
  `poll_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Poll Id',
  `answer_title` varchar(255) DEFAULT NULL COMMENT 'Answer title',
  `votes_count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Votes Count',
  `answer_order` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Answers display',
  PRIMARY KEY (`answer_id`),
  KEY `IDX_POLL_ANSWER_POLL_ID` (`poll_id`),
  CONSTRAINT `FK_POLL_ANSWER_POLL_ID_POLL_POLL_ID` FOREIGN KEY (`poll_id`) REFERENCES `poll` (`poll_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Poll Answers';

LOCK TABLES `poll_answer` WRITE;
/*!40000 ALTER TABLE `poll_answer` DISABLE KEYS */;

INSERT INTO `poll_answer` (`answer_id`, `poll_id`, `answer_title`, `votes_count`, `answer_order`)
VALUES
	(1,1,'Green',4,0),
	(2,1,'Red',1,0),
	(3,1,'Black',0,0),
	(4,1,'Magenta',2,0);

/*!40000 ALTER TABLE `poll_answer` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table poll_store
# ------------------------------------------------------------

DROP TABLE IF EXISTS `poll_store`;

CREATE TABLE `poll_store` (
  `poll_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Poll Id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store id',
  PRIMARY KEY (`poll_id`,`store_id`),
  KEY `IDX_POLL_STORE_STORE_ID` (`store_id`),
  CONSTRAINT `FK_POLL_STORE_POLL_ID_POLL_POLL_ID` FOREIGN KEY (`poll_id`) REFERENCES `poll` (`poll_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_POLL_STORE_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Poll Store';

LOCK TABLES `poll_store` WRITE;
/*!40000 ALTER TABLE `poll_store` DISABLE KEYS */;

INSERT INTO `poll_store` (`poll_id`, `store_id`)
VALUES
	(1,1);

/*!40000 ALTER TABLE `poll_store` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table poll_vote
# ------------------------------------------------------------

DROP TABLE IF EXISTS `poll_vote`;

CREATE TABLE `poll_vote` (
  `vote_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Vote Id',
  `poll_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Poll Id',
  `poll_answer_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Poll answer id',
  `ip_address` varbinary(16) DEFAULT NULL,
  `customer_id` int(11) DEFAULT NULL COMMENT 'Customer id',
  `vote_time` timestamp NULL DEFAULT NULL COMMENT 'Date closed',
  PRIMARY KEY (`vote_id`),
  KEY `IDX_POLL_VOTE_POLL_ANSWER_ID` (`poll_answer_id`),
  CONSTRAINT `FK_POLL_VOTE_POLL_ANSWER_ID_POLL_ANSWER_ANSWER_ID` FOREIGN KEY (`poll_answer_id`) REFERENCES `poll_answer` (`answer_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Poll Vote';



# Dump of table product_alert_price
# ------------------------------------------------------------

DROP TABLE IF EXISTS `product_alert_price`;

CREATE TABLE `product_alert_price` (
  `alert_price_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Product alert price id',
  `customer_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Customer id',
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product id',
  `price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Price amount',
  `website_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Website id',
  `add_date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Product alert add date',
  `last_send_date` timestamp NULL DEFAULT NULL COMMENT 'Product alert last send date',
  `send_count` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Product alert send count',
  `status` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Product alert status',
  PRIMARY KEY (`alert_price_id`),
  KEY `IDX_PRODUCT_ALERT_PRICE_CUSTOMER_ID` (`customer_id`),
  KEY `IDX_PRODUCT_ALERT_PRICE_PRODUCT_ID` (`product_id`),
  KEY `IDX_PRODUCT_ALERT_PRICE_WEBSITE_ID` (`website_id`),
  CONSTRAINT `FK_PRODUCT_ALERT_PRICE_CUSTOMER_ID_CUSTOMER_ENTITY_ENTITY_ID` FOREIGN KEY (`customer_id`) REFERENCES `customer_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_PRD_ALERT_PRICE_PRD_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_PRODUCT_ALERT_PRICE_WEBSITE_ID_CORE_WEBSITE_WEBSITE_ID` FOREIGN KEY (`website_id`) REFERENCES `core_website` (`website_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Product Alert Price';



# Dump of table product_alert_stock
# ------------------------------------------------------------

DROP TABLE IF EXISTS `product_alert_stock`;

CREATE TABLE `product_alert_stock` (
  `alert_stock_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Product alert stock id',
  `customer_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Customer id',
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product id',
  `website_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Website id',
  `add_date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Product alert add date',
  `send_date` timestamp NULL DEFAULT NULL COMMENT 'Product alert send date',
  `send_count` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Send Count',
  `status` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Product alert status',
  PRIMARY KEY (`alert_stock_id`),
  KEY `IDX_PRODUCT_ALERT_STOCK_CUSTOMER_ID` (`customer_id`),
  KEY `IDX_PRODUCT_ALERT_STOCK_PRODUCT_ID` (`product_id`),
  KEY `IDX_PRODUCT_ALERT_STOCK_WEBSITE_ID` (`website_id`),
  CONSTRAINT `FK_PRODUCT_ALERT_STOCK_WEBSITE_ID_CORE_WEBSITE_WEBSITE_ID` FOREIGN KEY (`website_id`) REFERENCES `core_website` (`website_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_PRODUCT_ALERT_STOCK_CUSTOMER_ID_CUSTOMER_ENTITY_ENTITY_ID` FOREIGN KEY (`customer_id`) REFERENCES `customer_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_PRD_ALERT_STOCK_PRD_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Product Alert Stock';



# Dump of table rating
# ------------------------------------------------------------

DROP TABLE IF EXISTS `rating`;

CREATE TABLE `rating` (
  `rating_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Rating Id',
  `entity_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Id',
  `rating_code` varchar(64) NOT NULL COMMENT 'Rating Code',
  `position` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Rating Position On Frontend',
  PRIMARY KEY (`rating_id`),
  UNIQUE KEY `UNQ_RATING_RATING_CODE` (`rating_code`),
  KEY `IDX_RATING_ENTITY_ID` (`entity_id`),
  CONSTRAINT `FK_RATING_ENTITY_ID_RATING_ENTITY_ENTITY_ID` FOREIGN KEY (`entity_id`) REFERENCES `rating_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Ratings';

LOCK TABLES `rating` WRITE;
/*!40000 ALTER TABLE `rating` DISABLE KEYS */;

INSERT INTO `rating` (`rating_id`, `entity_id`, `rating_code`, `position`)
VALUES
	(1,1,'Quality',0),
	(2,1,'Value',0),
	(3,1,'Price',0);

/*!40000 ALTER TABLE `rating` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table rating_entity
# ------------------------------------------------------------

DROP TABLE IF EXISTS `rating_entity`;

CREATE TABLE `rating_entity` (
  `entity_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `entity_code` varchar(64) NOT NULL COMMENT 'Entity Code',
  PRIMARY KEY (`entity_id`),
  UNIQUE KEY `UNQ_RATING_ENTITY_ENTITY_CODE` (`entity_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Rating entities';

LOCK TABLES `rating_entity` WRITE;
/*!40000 ALTER TABLE `rating_entity` DISABLE KEYS */;

INSERT INTO `rating_entity` (`entity_id`, `entity_code`)
VALUES
	(1,'product'),
	(2,'product_review'),
	(3,'review');

/*!40000 ALTER TABLE `rating_entity` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table rating_option
# ------------------------------------------------------------

DROP TABLE IF EXISTS `rating_option`;

CREATE TABLE `rating_option` (
  `option_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Rating Option Id',
  `rating_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Rating Id',
  `code` varchar(32) NOT NULL COMMENT 'Rating Option Code',
  `value` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Rating Option Value',
  `position` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Ration option position on frontend',
  PRIMARY KEY (`option_id`),
  KEY `IDX_RATING_OPTION_RATING_ID` (`rating_id`),
  CONSTRAINT `FK_RATING_OPTION_RATING_ID_RATING_RATING_ID` FOREIGN KEY (`rating_id`) REFERENCES `rating` (`rating_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Rating options';

LOCK TABLES `rating_option` WRITE;
/*!40000 ALTER TABLE `rating_option` DISABLE KEYS */;

INSERT INTO `rating_option` (`option_id`, `rating_id`, `code`, `value`, `position`)
VALUES
	(1,1,'1',1,1),
	(2,1,'2',2,2),
	(3,1,'3',3,3),
	(4,1,'4',4,4),
	(5,1,'5',5,5),
	(6,2,'1',1,1),
	(7,2,'2',2,2),
	(8,2,'3',3,3),
	(9,2,'4',4,4),
	(10,2,'5',5,5),
	(11,3,'1',1,1),
	(12,3,'2',2,2),
	(13,3,'3',3,3),
	(14,3,'4',4,4),
	(15,3,'5',5,5);

/*!40000 ALTER TABLE `rating_option` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table rating_option_vote
# ------------------------------------------------------------

DROP TABLE IF EXISTS `rating_option_vote`;

CREATE TABLE `rating_option_vote` (
  `vote_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Vote id',
  `option_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Vote option id',
  `remote_ip` varchar(50) DEFAULT NULL,
  `remote_ip_long` varbinary(16) DEFAULT NULL,
  `customer_id` int(10) unsigned DEFAULT '0' COMMENT 'Customer Id',
  `entity_pk_value` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'Product id',
  `rating_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Rating id',
  `review_id` bigint(20) unsigned DEFAULT NULL COMMENT 'Review id',
  `percent` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Percent amount',
  `value` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Vote option value',
  PRIMARY KEY (`vote_id`),
  KEY `IDX_RATING_OPTION_VOTE_OPTION_ID` (`option_id`),
  KEY `FK_RATING_OPTION_VOTE_REVIEW_ID_REVIEW_REVIEW_ID` (`review_id`),
  CONSTRAINT `FK_RATING_OPTION_VOTE_OPTION_ID_RATING_OPTION_OPTION_ID` FOREIGN KEY (`option_id`) REFERENCES `rating_option` (`option_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_RATING_OPTION_VOTE_REVIEW_ID_REVIEW_REVIEW_ID` FOREIGN KEY (`review_id`) REFERENCES `review` (`review_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Rating option values';



# Dump of table rating_option_vote_aggregated
# ------------------------------------------------------------

DROP TABLE IF EXISTS `rating_option_vote_aggregated`;

CREATE TABLE `rating_option_vote_aggregated` (
  `primary_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Vote aggregation id',
  `rating_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Rating id',
  `entity_pk_value` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'Product id',
  `vote_count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Vote dty',
  `vote_value_sum` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'General vote sum',
  `percent` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Vote percent',
  `percent_approved` smallint(6) DEFAULT '0' COMMENT 'Vote percent approved by admin',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  PRIMARY KEY (`primary_id`),
  KEY `IDX_RATING_OPTION_VOTE_AGGREGATED_RATING_ID` (`rating_id`),
  KEY `IDX_RATING_OPTION_VOTE_AGGREGATED_STORE_ID` (`store_id`),
  CONSTRAINT `FK_RATING_OPTION_VOTE_AGGREGATED_RATING_ID_RATING_RATING_ID` FOREIGN KEY (`rating_id`) REFERENCES `rating` (`rating_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_RATING_OPTION_VOTE_AGGREGATED_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Rating vote aggregated';



# Dump of table rating_store
# ------------------------------------------------------------

DROP TABLE IF EXISTS `rating_store`;

CREATE TABLE `rating_store` (
  `rating_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Rating id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store id',
  PRIMARY KEY (`rating_id`,`store_id`),
  KEY `IDX_RATING_STORE_STORE_ID` (`store_id`),
  CONSTRAINT `FK_RATING_STORE_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_RATING_STORE_RATING_ID_RATING_RATING_ID` FOREIGN KEY (`rating_id`) REFERENCES `rating` (`rating_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Rating Store';



# Dump of table rating_title
# ------------------------------------------------------------

DROP TABLE IF EXISTS `rating_title`;

CREATE TABLE `rating_title` (
  `rating_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Rating Id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  `value` varchar(255) NOT NULL COMMENT 'Rating Label',
  PRIMARY KEY (`rating_id`,`store_id`),
  KEY `IDX_RATING_TITLE_STORE_ID` (`store_id`),
  CONSTRAINT `FK_RATING_TITLE_RATING_ID_RATING_RATING_ID` FOREIGN KEY (`rating_id`) REFERENCES `rating` (`rating_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_RATING_TITLE_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Rating Title';



# Dump of table recentreviewproducts
# ------------------------------------------------------------

DROP TABLE IF EXISTS `recentreviewproducts`;

CREATE TABLE `recentreviewproducts` (
  `recentreviewproducts_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL DEFAULT '',
  `filename` varchar(255) NOT NULL DEFAULT '',
  `content` text NOT NULL,
  `status` smallint(6) NOT NULL DEFAULT '0',
  `created_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  PRIMARY KEY (`recentreviewproducts_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table report_compared_product_index
# ------------------------------------------------------------

DROP TABLE IF EXISTS `report_compared_product_index`;

CREATE TABLE `report_compared_product_index` (
  `index_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Index Id',
  `visitor_id` int(10) unsigned DEFAULT NULL COMMENT 'Visitor Id',
  `customer_id` int(10) unsigned DEFAULT NULL COMMENT 'Customer Id',
  `product_id` int(10) unsigned NOT NULL COMMENT 'Product Id',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `added_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Added At',
  PRIMARY KEY (`index_id`),
  UNIQUE KEY `UNQ_REPORT_COMPARED_PRODUCT_INDEX_VISITOR_ID_PRODUCT_ID` (`visitor_id`,`product_id`),
  UNIQUE KEY `UNQ_REPORT_COMPARED_PRODUCT_INDEX_CUSTOMER_ID_PRODUCT_ID` (`customer_id`,`product_id`),
  KEY `IDX_REPORT_COMPARED_PRODUCT_INDEX_STORE_ID` (`store_id`),
  KEY `IDX_REPORT_COMPARED_PRODUCT_INDEX_ADDED_AT` (`added_at`),
  KEY `IDX_REPORT_COMPARED_PRODUCT_INDEX_PRODUCT_ID` (`product_id`),
  CONSTRAINT `FK_REPORT_CMPD_PRD_IDX_CSTR_ID_CSTR_ENTT_ENTT_ID` FOREIGN KEY (`customer_id`) REFERENCES `customer_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_REPORT_CMPD_PRD_IDX_PRD_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_REPORT_COMPARED_PRODUCT_INDEX_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Reports Compared Product Index Table';



# Dump of table report_event
# ------------------------------------------------------------

DROP TABLE IF EXISTS `report_event`;

CREATE TABLE `report_event` (
  `event_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Event Id',
  `logged_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Logged At',
  `event_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Event Type Id',
  `object_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Object Id',
  `subject_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Subject Id',
  `subtype` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Subtype',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store Id',
  PRIMARY KEY (`event_id`),
  KEY `IDX_REPORT_EVENT_EVENT_TYPE_ID` (`event_type_id`),
  KEY `IDX_REPORT_EVENT_SUBJECT_ID` (`subject_id`),
  KEY `IDX_REPORT_EVENT_OBJECT_ID` (`object_id`),
  KEY `IDX_REPORT_EVENT_SUBTYPE` (`subtype`),
  KEY `IDX_REPORT_EVENT_STORE_ID` (`store_id`),
  CONSTRAINT `FK_REPORT_EVENT_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_REPORT_EVENT_EVENT_TYPE_ID_REPORT_EVENT_TYPES_EVENT_TYPE_ID` FOREIGN KEY (`event_type_id`) REFERENCES `report_event_types` (`event_type_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Reports Event Table';



# Dump of table report_event_types
# ------------------------------------------------------------

DROP TABLE IF EXISTS `report_event_types`;

CREATE TABLE `report_event_types` (
  `event_type_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Event Type Id',
  `event_name` varchar(64) NOT NULL COMMENT 'Event Name',
  `customer_login` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Customer Login',
  PRIMARY KEY (`event_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Reports Event Type Table';

LOCK TABLES `report_event_types` WRITE;
/*!40000 ALTER TABLE `report_event_types` DISABLE KEYS */;

INSERT INTO `report_event_types` (`event_type_id`, `event_name`, `customer_login`)
VALUES
	(1,'catalog_product_view',0),
	(2,'sendfriend_product',0),
	(3,'catalog_product_compare_add_product',0),
	(4,'checkout_cart_add_product',0),
	(5,'wishlist_add_product',0),
	(6,'wishlist_share',0);

/*!40000 ALTER TABLE `report_event_types` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table report_viewed_product_aggregated_daily
# ------------------------------------------------------------

DROP TABLE IF EXISTS `report_viewed_product_aggregated_daily`;

CREATE TABLE `report_viewed_product_aggregated_daily` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `period` date DEFAULT NULL COMMENT 'Period',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `product_id` int(10) unsigned DEFAULT NULL COMMENT 'Product Id',
  `product_name` varchar(255) DEFAULT NULL COMMENT 'Product Name',
  `product_price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Product Price',
  `views_num` int(11) NOT NULL DEFAULT '0' COMMENT 'Number of Views',
  `rating_pos` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Rating Pos',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNQ_REPORT_VIEWED_PRD_AGGRED_DAILY_PERIOD_STORE_ID_PRD_ID` (`period`,`store_id`,`product_id`),
  KEY `IDX_REPORT_VIEWED_PRODUCT_AGGREGATED_DAILY_STORE_ID` (`store_id`),
  KEY `IDX_REPORT_VIEWED_PRODUCT_AGGREGATED_DAILY_PRODUCT_ID` (`product_id`),
  CONSTRAINT `FK_REPORT_VIEWED_PRD_AGGRED_DAILY_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_REPORT_VIEWED_PRD_AGGRED_DAILY_PRD_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Most Viewed Products Aggregated Daily';



# Dump of table report_viewed_product_aggregated_monthly
# ------------------------------------------------------------

DROP TABLE IF EXISTS `report_viewed_product_aggregated_monthly`;

CREATE TABLE `report_viewed_product_aggregated_monthly` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `period` date DEFAULT NULL COMMENT 'Period',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `product_id` int(10) unsigned DEFAULT NULL COMMENT 'Product Id',
  `product_name` varchar(255) DEFAULT NULL COMMENT 'Product Name',
  `product_price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Product Price',
  `views_num` int(11) NOT NULL DEFAULT '0' COMMENT 'Number of Views',
  `rating_pos` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Rating Pos',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNQ_REPORT_VIEWED_PRD_AGGRED_MONTHLY_PERIOD_STORE_ID_PRD_ID` (`period`,`store_id`,`product_id`),
  KEY `IDX_REPORT_VIEWED_PRODUCT_AGGREGATED_MONTHLY_STORE_ID` (`store_id`),
  KEY `IDX_REPORT_VIEWED_PRODUCT_AGGREGATED_MONTHLY_PRODUCT_ID` (`product_id`),
  CONSTRAINT `FK_REPORT_VIEWED_PRD_AGGRED_MONTHLY_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_REPORT_VIEWED_PRD_AGGRED_MONTHLY_PRD_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Most Viewed Products Aggregated Monthly';



# Dump of table report_viewed_product_aggregated_yearly
# ------------------------------------------------------------

DROP TABLE IF EXISTS `report_viewed_product_aggregated_yearly`;

CREATE TABLE `report_viewed_product_aggregated_yearly` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `period` date DEFAULT NULL COMMENT 'Period',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `product_id` int(10) unsigned DEFAULT NULL COMMENT 'Product Id',
  `product_name` varchar(255) DEFAULT NULL COMMENT 'Product Name',
  `product_price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Product Price',
  `views_num` int(11) NOT NULL DEFAULT '0' COMMENT 'Number of Views',
  `rating_pos` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Rating Pos',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNQ_REPORT_VIEWED_PRD_AGGRED_YEARLY_PERIOD_STORE_ID_PRD_ID` (`period`,`store_id`,`product_id`),
  KEY `IDX_REPORT_VIEWED_PRODUCT_AGGREGATED_YEARLY_STORE_ID` (`store_id`),
  KEY `IDX_REPORT_VIEWED_PRODUCT_AGGREGATED_YEARLY_PRODUCT_ID` (`product_id`),
  CONSTRAINT `FK_REPORT_VIEWED_PRD_AGGRED_YEARLY_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_REPORT_VIEWED_PRD_AGGRED_YEARLY_PRD_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Most Viewed Products Aggregated Yearly';



# Dump of table report_viewed_product_index
# ------------------------------------------------------------

DROP TABLE IF EXISTS `report_viewed_product_index`;

CREATE TABLE `report_viewed_product_index` (
  `index_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Index Id',
  `visitor_id` int(10) unsigned DEFAULT NULL COMMENT 'Visitor Id',
  `customer_id` int(10) unsigned DEFAULT NULL COMMENT 'Customer Id',
  `product_id` int(10) unsigned NOT NULL COMMENT 'Product Id',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `added_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Added At',
  PRIMARY KEY (`index_id`),
  UNIQUE KEY `UNQ_REPORT_VIEWED_PRODUCT_INDEX_VISITOR_ID_PRODUCT_ID` (`visitor_id`,`product_id`),
  UNIQUE KEY `UNQ_REPORT_VIEWED_PRODUCT_INDEX_CUSTOMER_ID_PRODUCT_ID` (`customer_id`,`product_id`),
  KEY `IDX_REPORT_VIEWED_PRODUCT_INDEX_STORE_ID` (`store_id`),
  KEY `IDX_REPORT_VIEWED_PRODUCT_INDEX_ADDED_AT` (`added_at`),
  KEY `IDX_REPORT_VIEWED_PRODUCT_INDEX_PRODUCT_ID` (`product_id`),
  CONSTRAINT `FK_REPORT_VIEWED_PRD_IDX_CSTR_ID_CSTR_ENTT_ENTT_ID` FOREIGN KEY (`customer_id`) REFERENCES `customer_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_REPORT_VIEWED_PRD_IDX_PRD_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_REPORT_VIEWED_PRODUCT_INDEX_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Reports Viewed Product Index Table';



# Dump of table review
# ------------------------------------------------------------

DROP TABLE IF EXISTS `review`;

CREATE TABLE `review` (
  `review_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Review id',
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Review create date',
  `entity_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity id',
  `entity_pk_value` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product id',
  `status_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Status code',
  PRIMARY KEY (`review_id`),
  KEY `IDX_REVIEW_ENTITY_ID` (`entity_id`),
  KEY `IDX_REVIEW_STATUS_ID` (`status_id`),
  KEY `IDX_REVIEW_ENTITY_PK_VALUE` (`entity_pk_value`),
  CONSTRAINT `FK_REVIEW_ENTITY_ID_REVIEW_ENTITY_ENTITY_ID` FOREIGN KEY (`entity_id`) REFERENCES `review_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_REVIEW_STATUS_ID_REVIEW_STATUS_STATUS_ID` FOREIGN KEY (`status_id`) REFERENCES `review_status` (`status_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Review base information';



# Dump of table review_detail
# ------------------------------------------------------------

DROP TABLE IF EXISTS `review_detail`;

CREATE TABLE `review_detail` (
  `detail_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Review detail id',
  `review_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'Review id',
  `store_id` smallint(5) unsigned DEFAULT '0' COMMENT 'Store id',
  `title` varchar(255) NOT NULL COMMENT 'Title',
  `detail` text NOT NULL COMMENT 'Detail description',
  `nickname` varchar(128) NOT NULL COMMENT 'User nickname',
  `customer_id` int(10) unsigned DEFAULT NULL COMMENT 'Customer Id',
  PRIMARY KEY (`detail_id`),
  KEY `IDX_REVIEW_DETAIL_REVIEW_ID` (`review_id`),
  KEY `IDX_REVIEW_DETAIL_STORE_ID` (`store_id`),
  KEY `IDX_REVIEW_DETAIL_CUSTOMER_ID` (`customer_id`),
  CONSTRAINT `FK_REVIEW_DETAIL_CUSTOMER_ID_CUSTOMER_ENTITY_ENTITY_ID` FOREIGN KEY (`customer_id`) REFERENCES `customer_entity` (`entity_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `FK_REVIEW_DETAIL_REVIEW_ID_REVIEW_REVIEW_ID` FOREIGN KEY (`review_id`) REFERENCES `review` (`review_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_REVIEW_DETAIL_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Review detail information';



# Dump of table review_entity
# ------------------------------------------------------------

DROP TABLE IF EXISTS `review_entity`;

CREATE TABLE `review_entity` (
  `entity_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Review entity id',
  `entity_code` varchar(32) NOT NULL COMMENT 'Review entity code',
  PRIMARY KEY (`entity_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Review entities';

LOCK TABLES `review_entity` WRITE;
/*!40000 ALTER TABLE `review_entity` DISABLE KEYS */;

INSERT INTO `review_entity` (`entity_id`, `entity_code`)
VALUES
	(1,'product'),
	(2,'customer'),
	(3,'category');

/*!40000 ALTER TABLE `review_entity` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table review_entity_summary
# ------------------------------------------------------------

DROP TABLE IF EXISTS `review_entity_summary`;

CREATE TABLE `review_entity_summary` (
  `primary_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'Summary review entity id',
  `entity_pk_value` bigint(20) NOT NULL DEFAULT '0' COMMENT 'Product id',
  `entity_type` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Entity type id',
  `reviews_count` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Qty of reviews',
  `rating_summary` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Summarized rating',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store id',
  PRIMARY KEY (`primary_id`),
  KEY `IDX_REVIEW_ENTITY_SUMMARY_STORE_ID` (`store_id`),
  CONSTRAINT `FK_REVIEW_ENTITY_SUMMARY_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Review aggregates';



# Dump of table review_status
# ------------------------------------------------------------

DROP TABLE IF EXISTS `review_status`;

CREATE TABLE `review_status` (
  `status_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Status id',
  `status_code` varchar(32) NOT NULL COMMENT 'Status code',
  PRIMARY KEY (`status_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Review statuses';

LOCK TABLES `review_status` WRITE;
/*!40000 ALTER TABLE `review_status` DISABLE KEYS */;

INSERT INTO `review_status` (`status_id`, `status_code`)
VALUES
	(1,'Approved'),
	(2,'Pending'),
	(3,'Not Approved');

/*!40000 ALTER TABLE `review_status` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table review_store
# ------------------------------------------------------------

DROP TABLE IF EXISTS `review_store`;

CREATE TABLE `review_store` (
  `review_id` bigint(20) unsigned NOT NULL COMMENT 'Review Id',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store Id',
  PRIMARY KEY (`review_id`,`store_id`),
  KEY `IDX_REVIEW_STORE_STORE_ID` (`store_id`),
  CONSTRAINT `FK_REVIEW_STORE_REVIEW_ID_REVIEW_REVIEW_ID` FOREIGN KEY (`review_id`) REFERENCES `review` (`review_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_REVIEW_STORE_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Review Store';



# Dump of table sales_bestsellers_aggregated_daily
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sales_bestsellers_aggregated_daily`;

CREATE TABLE `sales_bestsellers_aggregated_daily` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `period` date DEFAULT NULL COMMENT 'Period',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `product_id` int(10) unsigned DEFAULT NULL COMMENT 'Product Id',
  `product_name` varchar(255) DEFAULT NULL COMMENT 'Product Name',
  `product_price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Product Price',
  `qty_ordered` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Qty Ordered',
  `rating_pos` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Rating Pos',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNQ_SALES_BESTSELLERS_AGGRED_DAILY_PERIOD_STORE_ID_PRD_ID` (`period`,`store_id`,`product_id`),
  KEY `IDX_SALES_BESTSELLERS_AGGREGATED_DAILY_STORE_ID` (`store_id`),
  KEY `IDX_SALES_BESTSELLERS_AGGREGATED_DAILY_PRODUCT_ID` (`product_id`),
  CONSTRAINT `FK_SALES_BESTSELLERS_AGGRED_DAILY_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_SALES_BESTSELLERS_AGGRED_DAILY_PRD_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Bestsellers Aggregated Daily';



# Dump of table sales_bestsellers_aggregated_monthly
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sales_bestsellers_aggregated_monthly`;

CREATE TABLE `sales_bestsellers_aggregated_monthly` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `period` date DEFAULT NULL COMMENT 'Period',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `product_id` int(10) unsigned DEFAULT NULL COMMENT 'Product Id',
  `product_name` varchar(255) DEFAULT NULL COMMENT 'Product Name',
  `product_price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Product Price',
  `qty_ordered` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Qty Ordered',
  `rating_pos` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Rating Pos',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNQ_SALES_BESTSELLERS_AGGRED_MONTHLY_PERIOD_STORE_ID_PRD_ID` (`period`,`store_id`,`product_id`),
  KEY `IDX_SALES_BESTSELLERS_AGGREGATED_MONTHLY_STORE_ID` (`store_id`),
  KEY `IDX_SALES_BESTSELLERS_AGGREGATED_MONTHLY_PRODUCT_ID` (`product_id`),
  CONSTRAINT `FK_SALES_BESTSELLERS_AGGRED_MONTHLY_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_SALES_BESTSELLERS_AGGRED_MONTHLY_PRD_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Bestsellers Aggregated Monthly';



# Dump of table sales_bestsellers_aggregated_yearly
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sales_bestsellers_aggregated_yearly`;

CREATE TABLE `sales_bestsellers_aggregated_yearly` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `period` date DEFAULT NULL COMMENT 'Period',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `product_id` int(10) unsigned DEFAULT NULL COMMENT 'Product Id',
  `product_name` varchar(255) DEFAULT NULL COMMENT 'Product Name',
  `product_price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Product Price',
  `qty_ordered` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Qty Ordered',
  `rating_pos` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Rating Pos',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNQ_SALES_BESTSELLERS_AGGRED_YEARLY_PERIOD_STORE_ID_PRD_ID` (`period`,`store_id`,`product_id`),
  KEY `IDX_SALES_BESTSELLERS_AGGREGATED_YEARLY_STORE_ID` (`store_id`),
  KEY `IDX_SALES_BESTSELLERS_AGGREGATED_YEARLY_PRODUCT_ID` (`product_id`),
  CONSTRAINT `FK_SALES_BESTSELLERS_AGGRED_YEARLY_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_SALES_BESTSELLERS_AGGRED_YEARLY_PRD_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Bestsellers Aggregated Yearly';



# Dump of table sales_billing_agreement
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sales_billing_agreement`;

CREATE TABLE `sales_billing_agreement` (
  `agreement_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Agreement Id',
  `customer_id` int(10) unsigned NOT NULL COMMENT 'Customer Id',
  `method_code` varchar(32) NOT NULL COMMENT 'Method Code',
  `reference_id` varchar(32) NOT NULL COMMENT 'Reference Id',
  `status` varchar(20) NOT NULL COMMENT 'Status',
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Created At',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'Updated At',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `agreement_label` varchar(255) DEFAULT NULL COMMENT 'Agreement Label',
  PRIMARY KEY (`agreement_id`),
  KEY `IDX_SALES_BILLING_AGREEMENT_CUSTOMER_ID` (`customer_id`),
  KEY `IDX_SALES_BILLING_AGREEMENT_STORE_ID` (`store_id`),
  CONSTRAINT `FK_SALES_BILLING_AGREEMENT_CUSTOMER_ID_CUSTOMER_ENTITY_ENTITY_ID` FOREIGN KEY (`customer_id`) REFERENCES `customer_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_SALES_BILLING_AGREEMENT_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Billing Agreement';



# Dump of table sales_billing_agreement_order
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sales_billing_agreement_order`;

CREATE TABLE `sales_billing_agreement_order` (
  `agreement_id` int(10) unsigned NOT NULL COMMENT 'Agreement Id',
  `order_id` int(10) unsigned NOT NULL COMMENT 'Order Id',
  PRIMARY KEY (`agreement_id`,`order_id`),
  KEY `IDX_SALES_BILLING_AGREEMENT_ORDER_ORDER_ID` (`order_id`),
  CONSTRAINT `FK_SALES_BILLING_AGRT_ORDER_AGRT_ID_SALES_BILLING_AGRT_AGRT_ID` FOREIGN KEY (`agreement_id`) REFERENCES `sales_billing_agreement` (`agreement_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_SALES_BILLING_AGRT_ORDER_ORDER_ID_SALES_FLAT_ORDER_ENTT_ID` FOREIGN KEY (`order_id`) REFERENCES `sales_flat_order` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Billing Agreement Order';



# Dump of table sales_flat_creditmemo
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sales_flat_creditmemo`;

CREATE TABLE `sales_flat_creditmemo` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `adjustment_positive` decimal(12,4) DEFAULT NULL COMMENT 'Adjustment Positive',
  `base_shipping_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Tax Amount',
  `store_to_order_rate` decimal(12,4) DEFAULT NULL COMMENT 'Store To Order Rate',
  `base_discount_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Discount Amount',
  `base_to_order_rate` decimal(12,4) DEFAULT NULL COMMENT 'Base To Order Rate',
  `grand_total` decimal(12,4) DEFAULT NULL COMMENT 'Grand Total',
  `base_adjustment_negative` decimal(12,4) DEFAULT NULL COMMENT 'Base Adjustment Negative',
  `base_subtotal_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Base Subtotal Incl Tax',
  `shipping_amount` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Amount',
  `subtotal_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Subtotal Incl Tax',
  `adjustment_negative` decimal(12,4) DEFAULT NULL COMMENT 'Adjustment Negative',
  `base_shipping_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Amount',
  `store_to_base_rate` decimal(12,4) DEFAULT NULL COMMENT 'Store To Base Rate',
  `base_to_global_rate` decimal(12,4) DEFAULT NULL COMMENT 'Base To Global Rate',
  `base_adjustment` decimal(12,4) DEFAULT NULL COMMENT 'Base Adjustment',
  `base_subtotal` decimal(12,4) DEFAULT NULL COMMENT 'Base Subtotal',
  `discount_amount` decimal(12,4) DEFAULT NULL COMMENT 'Discount Amount',
  `subtotal` decimal(12,4) DEFAULT NULL COMMENT 'Subtotal',
  `adjustment` decimal(12,4) DEFAULT NULL COMMENT 'Adjustment',
  `base_grand_total` decimal(12,4) DEFAULT NULL COMMENT 'Base Grand Total',
  `base_adjustment_positive` decimal(12,4) DEFAULT NULL COMMENT 'Base Adjustment Positive',
  `base_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Tax Amount',
  `shipping_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Tax Amount',
  `tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Tax Amount',
  `order_id` int(10) unsigned NOT NULL COMMENT 'Order Id',
  `email_sent` smallint(5) unsigned DEFAULT NULL COMMENT 'Email Sent',
  `creditmemo_status` int(11) DEFAULT NULL COMMENT 'Creditmemo Status',
  `state` int(11) DEFAULT NULL COMMENT 'State',
  `shipping_address_id` int(11) DEFAULT NULL COMMENT 'Shipping Address Id',
  `billing_address_id` int(11) DEFAULT NULL COMMENT 'Billing Address Id',
  `invoice_id` int(11) DEFAULT NULL COMMENT 'Invoice Id',
  `store_currency_code` varchar(3) DEFAULT NULL COMMENT 'Store Currency Code',
  `order_currency_code` varchar(3) DEFAULT NULL COMMENT 'Order Currency Code',
  `base_currency_code` varchar(3) DEFAULT NULL COMMENT 'Base Currency Code',
  `global_currency_code` varchar(3) DEFAULT NULL COMMENT 'Global Currency Code',
  `transaction_id` varchar(255) DEFAULT NULL COMMENT 'Transaction Id',
  `increment_id` varchar(50) DEFAULT NULL COMMENT 'Increment Id',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Created At',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'Updated At',
  `hidden_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Hidden Tax Amount',
  `base_hidden_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Hidden Tax Amount',
  `shipping_hidden_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Hidden Tax Amount',
  `base_shipping_hidden_tax_amnt` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Hidden Tax Amount',
  `shipping_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Incl Tax',
  `base_shipping_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Incl Tax',
  `discount_description` varchar(255) DEFAULT NULL COMMENT 'Discount Description',
  PRIMARY KEY (`entity_id`),
  UNIQUE KEY `UNQ_SALES_FLAT_CREDITMEMO_INCREMENT_ID` (`increment_id`),
  KEY `IDX_SALES_FLAT_CREDITMEMO_STORE_ID` (`store_id`),
  KEY `IDX_SALES_FLAT_CREDITMEMO_ORDER_ID` (`order_id`),
  KEY `IDX_SALES_FLAT_CREDITMEMO_CREDITMEMO_STATUS` (`creditmemo_status`),
  KEY `IDX_SALES_FLAT_CREDITMEMO_STATE` (`state`),
  KEY `IDX_SALES_FLAT_CREDITMEMO_CREATED_AT` (`created_at`),
  CONSTRAINT `FK_SALES_FLAT_CREDITMEMO_ORDER_ID_SALES_FLAT_ORDER_ENTITY_ID` FOREIGN KEY (`order_id`) REFERENCES `sales_flat_order` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_SALES_FLAT_CREDITMEMO_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Creditmemo';



# Dump of table sales_flat_creditmemo_comment
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sales_flat_creditmemo_comment`;

CREATE TABLE `sales_flat_creditmemo_comment` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `parent_id` int(10) unsigned NOT NULL COMMENT 'Parent Id',
  `is_customer_notified` int(11) DEFAULT NULL COMMENT 'Is Customer Notified',
  `is_visible_on_front` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Visible On Front',
  `comment` text COMMENT 'Comment',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Created At',
  PRIMARY KEY (`entity_id`),
  KEY `IDX_SALES_FLAT_CREDITMEMO_COMMENT_CREATED_AT` (`created_at`),
  KEY `IDX_SALES_FLAT_CREDITMEMO_COMMENT_PARENT_ID` (`parent_id`),
  CONSTRAINT `FK_B0FCB0B5467075BE63D474F2CD5F7804` FOREIGN KEY (`parent_id`) REFERENCES `sales_flat_creditmemo` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Creditmemo Comment';



# Dump of table sales_flat_creditmemo_grid
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sales_flat_creditmemo_grid`;

CREATE TABLE `sales_flat_creditmemo_grid` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity Id',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `store_to_order_rate` decimal(12,4) DEFAULT NULL COMMENT 'Store To Order Rate',
  `base_to_order_rate` decimal(12,4) DEFAULT NULL COMMENT 'Base To Order Rate',
  `grand_total` decimal(12,4) DEFAULT NULL COMMENT 'Grand Total',
  `store_to_base_rate` decimal(12,4) DEFAULT NULL COMMENT 'Store To Base Rate',
  `base_to_global_rate` decimal(12,4) DEFAULT NULL COMMENT 'Base To Global Rate',
  `base_grand_total` decimal(12,4) DEFAULT NULL COMMENT 'Base Grand Total',
  `order_id` int(10) unsigned NOT NULL COMMENT 'Order Id',
  `creditmemo_status` int(11) DEFAULT NULL COMMENT 'Creditmemo Status',
  `state` int(11) DEFAULT NULL COMMENT 'State',
  `invoice_id` int(11) DEFAULT NULL COMMENT 'Invoice Id',
  `store_currency_code` varchar(3) DEFAULT NULL COMMENT 'Store Currency Code',
  `order_currency_code` varchar(3) DEFAULT NULL COMMENT 'Order Currency Code',
  `base_currency_code` varchar(3) DEFAULT NULL COMMENT 'Base Currency Code',
  `global_currency_code` varchar(3) DEFAULT NULL COMMENT 'Global Currency Code',
  `increment_id` varchar(50) DEFAULT NULL COMMENT 'Increment Id',
  `order_increment_id` varchar(50) DEFAULT NULL COMMENT 'Order Increment Id',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Created At',
  `order_created_at` timestamp NULL DEFAULT NULL COMMENT 'Order Created At',
  `billing_name` varchar(255) DEFAULT NULL COMMENT 'Billing Name',
  PRIMARY KEY (`entity_id`),
  UNIQUE KEY `UNQ_SALES_FLAT_CREDITMEMO_GRID_INCREMENT_ID` (`increment_id`),
  KEY `IDX_SALES_FLAT_CREDITMEMO_GRID_STORE_ID` (`store_id`),
  KEY `IDX_SALES_FLAT_CREDITMEMO_GRID_GRAND_TOTAL` (`grand_total`),
  KEY `IDX_SALES_FLAT_CREDITMEMO_GRID_BASE_GRAND_TOTAL` (`base_grand_total`),
  KEY `IDX_SALES_FLAT_CREDITMEMO_GRID_ORDER_ID` (`order_id`),
  KEY `IDX_SALES_FLAT_CREDITMEMO_GRID_CREDITMEMO_STATUS` (`creditmemo_status`),
  KEY `IDX_SALES_FLAT_CREDITMEMO_GRID_STATE` (`state`),
  KEY `IDX_SALES_FLAT_CREDITMEMO_GRID_ORDER_INCREMENT_ID` (`order_increment_id`),
  KEY `IDX_SALES_FLAT_CREDITMEMO_GRID_CREATED_AT` (`created_at`),
  KEY `IDX_SALES_FLAT_CREDITMEMO_GRID_ORDER_CREATED_AT` (`order_created_at`),
  KEY `IDX_SALES_FLAT_CREDITMEMO_GRID_BILLING_NAME` (`billing_name`),
  CONSTRAINT `FK_78C711B225167A11CC077B03D1C8E1CC` FOREIGN KEY (`entity_id`) REFERENCES `sales_flat_creditmemo` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_SALES_FLAT_CREDITMEMO_GRID_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Creditmemo Grid';



# Dump of table sales_flat_creditmemo_item
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sales_flat_creditmemo_item`;

CREATE TABLE `sales_flat_creditmemo_item` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `parent_id` int(10) unsigned NOT NULL COMMENT 'Parent Id',
  `base_price` decimal(12,4) DEFAULT NULL COMMENT 'Base Price',
  `tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Tax Amount',
  `base_row_total` decimal(12,4) DEFAULT NULL COMMENT 'Base Row Total',
  `discount_amount` decimal(12,4) DEFAULT NULL COMMENT 'Discount Amount',
  `row_total` decimal(12,4) DEFAULT NULL COMMENT 'Row Total',
  `base_discount_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Discount Amount',
  `price_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Price Incl Tax',
  `base_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Tax Amount',
  `base_price_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Base Price Incl Tax',
  `qty` decimal(12,4) DEFAULT NULL COMMENT 'Qty',
  `base_cost` decimal(12,4) DEFAULT NULL COMMENT 'Base Cost',
  `price` decimal(12,4) DEFAULT NULL COMMENT 'Price',
  `base_row_total_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Base Row Total Incl Tax',
  `row_total_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Row Total Incl Tax',
  `product_id` int(11) DEFAULT NULL COMMENT 'Product Id',
  `order_item_id` int(11) DEFAULT NULL COMMENT 'Order Item Id',
  `additional_data` text COMMENT 'Additional Data',
  `description` text COMMENT 'Description',
  `sku` varchar(255) DEFAULT NULL COMMENT 'Sku',
  `name` varchar(255) DEFAULT NULL COMMENT 'Name',
  `hidden_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Hidden Tax Amount',
  `base_hidden_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Hidden Tax Amount',
  `weee_tax_disposition` decimal(12,4) DEFAULT NULL COMMENT 'Weee Tax Disposition',
  `weee_tax_row_disposition` decimal(12,4) DEFAULT NULL COMMENT 'Weee Tax Row Disposition',
  `base_weee_tax_disposition` decimal(12,4) DEFAULT NULL COMMENT 'Base Weee Tax Disposition',
  `base_weee_tax_row_disposition` decimal(12,4) DEFAULT NULL COMMENT 'Base Weee Tax Row Disposition',
  `weee_tax_applied` text COMMENT 'Weee Tax Applied',
  `base_weee_tax_applied_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Weee Tax Applied Amount',
  `base_weee_tax_applied_row_amnt` decimal(12,4) DEFAULT NULL COMMENT 'Base Weee Tax Applied Row Amnt',
  `weee_tax_applied_amount` decimal(12,4) DEFAULT NULL COMMENT 'Weee Tax Applied Amount',
  `weee_tax_applied_row_amount` decimal(12,4) DEFAULT NULL COMMENT 'Weee Tax Applied Row Amount',
  PRIMARY KEY (`entity_id`),
  KEY `IDX_SALES_FLAT_CREDITMEMO_ITEM_PARENT_ID` (`parent_id`),
  CONSTRAINT `FK_306DAC836C699F0B5E13BE486557AC8A` FOREIGN KEY (`parent_id`) REFERENCES `sales_flat_creditmemo` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Creditmemo Item';



# Dump of table sales_flat_invoice
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sales_flat_invoice`;

CREATE TABLE `sales_flat_invoice` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `base_grand_total` decimal(12,4) DEFAULT NULL COMMENT 'Base Grand Total',
  `shipping_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Tax Amount',
  `tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Tax Amount',
  `base_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Tax Amount',
  `store_to_order_rate` decimal(12,4) DEFAULT NULL COMMENT 'Store To Order Rate',
  `base_shipping_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Tax Amount',
  `base_discount_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Discount Amount',
  `base_to_order_rate` decimal(12,4) DEFAULT NULL COMMENT 'Base To Order Rate',
  `grand_total` decimal(12,4) DEFAULT NULL COMMENT 'Grand Total',
  `shipping_amount` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Amount',
  `subtotal_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Subtotal Incl Tax',
  `base_subtotal_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Base Subtotal Incl Tax',
  `store_to_base_rate` decimal(12,4) DEFAULT NULL COMMENT 'Store To Base Rate',
  `base_shipping_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Amount',
  `total_qty` decimal(12,4) DEFAULT NULL COMMENT 'Total Qty',
  `base_to_global_rate` decimal(12,4) DEFAULT NULL COMMENT 'Base To Global Rate',
  `subtotal` decimal(12,4) DEFAULT NULL COMMENT 'Subtotal',
  `base_subtotal` decimal(12,4) DEFAULT NULL COMMENT 'Base Subtotal',
  `discount_amount` decimal(12,4) DEFAULT NULL COMMENT 'Discount Amount',
  `billing_address_id` int(11) DEFAULT NULL COMMENT 'Billing Address Id',
  `is_used_for_refund` smallint(5) unsigned DEFAULT NULL COMMENT 'Is Used For Refund',
  `order_id` int(10) unsigned NOT NULL COMMENT 'Order Id',
  `email_sent` smallint(5) unsigned DEFAULT NULL COMMENT 'Email Sent',
  `can_void_flag` smallint(5) unsigned DEFAULT NULL COMMENT 'Can Void Flag',
  `state` int(11) DEFAULT NULL COMMENT 'State',
  `shipping_address_id` int(11) DEFAULT NULL COMMENT 'Shipping Address Id',
  `store_currency_code` varchar(3) DEFAULT NULL COMMENT 'Store Currency Code',
  `transaction_id` varchar(255) DEFAULT NULL COMMENT 'Transaction Id',
  `order_currency_code` varchar(3) DEFAULT NULL COMMENT 'Order Currency Code',
  `base_currency_code` varchar(3) DEFAULT NULL COMMENT 'Base Currency Code',
  `global_currency_code` varchar(3) DEFAULT NULL COMMENT 'Global Currency Code',
  `increment_id` varchar(50) DEFAULT NULL COMMENT 'Increment Id',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Created At',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'Updated At',
  `hidden_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Hidden Tax Amount',
  `base_hidden_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Hidden Tax Amount',
  `shipping_hidden_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Hidden Tax Amount',
  `base_shipping_hidden_tax_amnt` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Hidden Tax Amount',
  `shipping_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Incl Tax',
  `base_shipping_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Incl Tax',
  `base_total_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Base Total Refunded',
  `discount_description` varchar(255) DEFAULT NULL COMMENT 'Discount Description',
  PRIMARY KEY (`entity_id`),
  UNIQUE KEY `UNQ_SALES_FLAT_INVOICE_INCREMENT_ID` (`increment_id`),
  KEY `IDX_SALES_FLAT_INVOICE_STORE_ID` (`store_id`),
  KEY `IDX_SALES_FLAT_INVOICE_GRAND_TOTAL` (`grand_total`),
  KEY `IDX_SALES_FLAT_INVOICE_ORDER_ID` (`order_id`),
  KEY `IDX_SALES_FLAT_INVOICE_STATE` (`state`),
  KEY `IDX_SALES_FLAT_INVOICE_CREATED_AT` (`created_at`),
  CONSTRAINT `FK_SALES_FLAT_INVOICE_ORDER_ID_SALES_FLAT_ORDER_ENTITY_ID` FOREIGN KEY (`order_id`) REFERENCES `sales_flat_order` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_SALES_FLAT_INVOICE_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Invoice';



# Dump of table sales_flat_invoice_comment
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sales_flat_invoice_comment`;

CREATE TABLE `sales_flat_invoice_comment` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `parent_id` int(10) unsigned NOT NULL COMMENT 'Parent Id',
  `is_customer_notified` smallint(5) unsigned DEFAULT NULL COMMENT 'Is Customer Notified',
  `is_visible_on_front` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Visible On Front',
  `comment` text COMMENT 'Comment',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Created At',
  PRIMARY KEY (`entity_id`),
  KEY `IDX_SALES_FLAT_INVOICE_COMMENT_CREATED_AT` (`created_at`),
  KEY `IDX_SALES_FLAT_INVOICE_COMMENT_PARENT_ID` (`parent_id`),
  CONSTRAINT `FK_5C4B36BBE5231A76AB8018B281ED50BC` FOREIGN KEY (`parent_id`) REFERENCES `sales_flat_invoice` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Invoice Comment';



# Dump of table sales_flat_invoice_grid
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sales_flat_invoice_grid`;

CREATE TABLE `sales_flat_invoice_grid` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity Id',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `base_grand_total` decimal(12,4) DEFAULT NULL COMMENT 'Base Grand Total',
  `grand_total` decimal(12,4) DEFAULT NULL COMMENT 'Grand Total',
  `order_id` int(10) unsigned NOT NULL COMMENT 'Order Id',
  `state` int(11) DEFAULT NULL COMMENT 'State',
  `store_currency_code` varchar(3) DEFAULT NULL COMMENT 'Store Currency Code',
  `order_currency_code` varchar(3) DEFAULT NULL COMMENT 'Order Currency Code',
  `base_currency_code` varchar(3) DEFAULT NULL COMMENT 'Base Currency Code',
  `global_currency_code` varchar(3) DEFAULT NULL COMMENT 'Global Currency Code',
  `increment_id` varchar(50) DEFAULT NULL COMMENT 'Increment Id',
  `order_increment_id` varchar(50) DEFAULT NULL COMMENT 'Order Increment Id',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Created At',
  `order_created_at` timestamp NULL DEFAULT NULL COMMENT 'Order Created At',
  `billing_name` varchar(255) DEFAULT NULL COMMENT 'Billing Name',
  PRIMARY KEY (`entity_id`),
  UNIQUE KEY `UNQ_SALES_FLAT_INVOICE_GRID_INCREMENT_ID` (`increment_id`),
  KEY `IDX_SALES_FLAT_INVOICE_GRID_STORE_ID` (`store_id`),
  KEY `IDX_SALES_FLAT_INVOICE_GRID_GRAND_TOTAL` (`grand_total`),
  KEY `IDX_SALES_FLAT_INVOICE_GRID_ORDER_ID` (`order_id`),
  KEY `IDX_SALES_FLAT_INVOICE_GRID_STATE` (`state`),
  KEY `IDX_SALES_FLAT_INVOICE_GRID_ORDER_INCREMENT_ID` (`order_increment_id`),
  KEY `IDX_SALES_FLAT_INVOICE_GRID_CREATED_AT` (`created_at`),
  KEY `IDX_SALES_FLAT_INVOICE_GRID_ORDER_CREATED_AT` (`order_created_at`),
  KEY `IDX_SALES_FLAT_INVOICE_GRID_BILLING_NAME` (`billing_name`),
  CONSTRAINT `FK_SALES_FLAT_INVOICE_GRID_ENTT_ID_SALES_FLAT_INVOICE_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `sales_flat_invoice` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_SALES_FLAT_INVOICE_GRID_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Invoice Grid';



# Dump of table sales_flat_invoice_item
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sales_flat_invoice_item`;

CREATE TABLE `sales_flat_invoice_item` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `parent_id` int(10) unsigned NOT NULL COMMENT 'Parent Id',
  `base_price` decimal(12,4) DEFAULT NULL COMMENT 'Base Price',
  `tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Tax Amount',
  `base_row_total` decimal(12,4) DEFAULT NULL COMMENT 'Base Row Total',
  `discount_amount` decimal(12,4) DEFAULT NULL COMMENT 'Discount Amount',
  `row_total` decimal(12,4) DEFAULT NULL COMMENT 'Row Total',
  `base_discount_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Discount Amount',
  `price_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Price Incl Tax',
  `base_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Tax Amount',
  `base_price_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Base Price Incl Tax',
  `qty` decimal(12,4) DEFAULT NULL COMMENT 'Qty',
  `base_cost` decimal(12,4) DEFAULT NULL COMMENT 'Base Cost',
  `price` decimal(12,4) DEFAULT NULL COMMENT 'Price',
  `base_row_total_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Base Row Total Incl Tax',
  `row_total_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Row Total Incl Tax',
  `product_id` int(11) DEFAULT NULL COMMENT 'Product Id',
  `order_item_id` int(11) DEFAULT NULL COMMENT 'Order Item Id',
  `additional_data` text COMMENT 'Additional Data',
  `description` text COMMENT 'Description',
  `sku` varchar(255) DEFAULT NULL COMMENT 'Sku',
  `name` varchar(255) DEFAULT NULL COMMENT 'Name',
  `hidden_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Hidden Tax Amount',
  `base_hidden_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Hidden Tax Amount',
  `base_weee_tax_applied_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Weee Tax Applied Amount',
  `base_weee_tax_applied_row_amnt` decimal(12,4) DEFAULT NULL COMMENT 'Base Weee Tax Applied Row Amnt',
  `weee_tax_applied_amount` decimal(12,4) DEFAULT NULL COMMENT 'Weee Tax Applied Amount',
  `weee_tax_applied_row_amount` decimal(12,4) DEFAULT NULL COMMENT 'Weee Tax Applied Row Amount',
  `weee_tax_applied` text COMMENT 'Weee Tax Applied',
  `weee_tax_disposition` decimal(12,4) DEFAULT NULL COMMENT 'Weee Tax Disposition',
  `weee_tax_row_disposition` decimal(12,4) DEFAULT NULL COMMENT 'Weee Tax Row Disposition',
  `base_weee_tax_disposition` decimal(12,4) DEFAULT NULL COMMENT 'Base Weee Tax Disposition',
  `base_weee_tax_row_disposition` decimal(12,4) DEFAULT NULL COMMENT 'Base Weee Tax Row Disposition',
  PRIMARY KEY (`entity_id`),
  KEY `IDX_SALES_FLAT_INVOICE_ITEM_PARENT_ID` (`parent_id`),
  CONSTRAINT `FK_SALES_FLAT_INVOICE_ITEM_PARENT_ID_SALES_FLAT_INVOICE_ENTT_ID` FOREIGN KEY (`parent_id`) REFERENCES `sales_flat_invoice` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Invoice Item';



# Dump of table sales_flat_order
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sales_flat_order`;

CREATE TABLE `sales_flat_order` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `state` varchar(32) DEFAULT NULL COMMENT 'State',
  `status` varchar(32) DEFAULT NULL COMMENT 'Status',
  `coupon_code` varchar(255) DEFAULT NULL COMMENT 'Coupon Code',
  `protect_code` varchar(255) DEFAULT NULL COMMENT 'Protect Code',
  `shipping_description` varchar(255) DEFAULT NULL COMMENT 'Shipping Description',
  `is_virtual` smallint(5) unsigned DEFAULT NULL COMMENT 'Is Virtual',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `customer_id` int(10) unsigned DEFAULT NULL COMMENT 'Customer Id',
  `base_discount_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Discount Amount',
  `base_discount_canceled` decimal(12,4) DEFAULT NULL COMMENT 'Base Discount Canceled',
  `base_discount_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Base Discount Invoiced',
  `base_discount_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Base Discount Refunded',
  `base_grand_total` decimal(12,4) DEFAULT NULL COMMENT 'Base Grand Total',
  `base_shipping_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Amount',
  `base_shipping_canceled` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Canceled',
  `base_shipping_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Invoiced',
  `base_shipping_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Refunded',
  `base_shipping_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Tax Amount',
  `base_shipping_tax_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Tax Refunded',
  `base_subtotal` decimal(12,4) DEFAULT NULL COMMENT 'Base Subtotal',
  `base_subtotal_canceled` decimal(12,4) DEFAULT NULL COMMENT 'Base Subtotal Canceled',
  `base_subtotal_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Base Subtotal Invoiced',
  `base_subtotal_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Base Subtotal Refunded',
  `base_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Tax Amount',
  `base_tax_canceled` decimal(12,4) DEFAULT NULL COMMENT 'Base Tax Canceled',
  `base_tax_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Base Tax Invoiced',
  `base_tax_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Base Tax Refunded',
  `base_to_global_rate` decimal(12,4) DEFAULT NULL COMMENT 'Base To Global Rate',
  `base_to_order_rate` decimal(12,4) DEFAULT NULL COMMENT 'Base To Order Rate',
  `base_total_canceled` decimal(12,4) DEFAULT NULL COMMENT 'Base Total Canceled',
  `base_total_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Base Total Invoiced',
  `base_total_invoiced_cost` decimal(12,4) DEFAULT NULL COMMENT 'Base Total Invoiced Cost',
  `base_total_offline_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Base Total Offline Refunded',
  `base_total_online_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Base Total Online Refunded',
  `base_total_paid` decimal(12,4) DEFAULT NULL COMMENT 'Base Total Paid',
  `base_total_qty_ordered` decimal(12,4) DEFAULT NULL COMMENT 'Base Total Qty Ordered',
  `base_total_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Base Total Refunded',
  `discount_amount` decimal(12,4) DEFAULT NULL COMMENT 'Discount Amount',
  `discount_canceled` decimal(12,4) DEFAULT NULL COMMENT 'Discount Canceled',
  `discount_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Discount Invoiced',
  `discount_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Discount Refunded',
  `grand_total` decimal(12,4) DEFAULT NULL COMMENT 'Grand Total',
  `shipping_amount` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Amount',
  `shipping_canceled` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Canceled',
  `shipping_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Invoiced',
  `shipping_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Refunded',
  `shipping_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Tax Amount',
  `shipping_tax_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Tax Refunded',
  `store_to_base_rate` decimal(12,4) DEFAULT NULL COMMENT 'Store To Base Rate',
  `store_to_order_rate` decimal(12,4) DEFAULT NULL COMMENT 'Store To Order Rate',
  `subtotal` decimal(12,4) DEFAULT NULL COMMENT 'Subtotal',
  `subtotal_canceled` decimal(12,4) DEFAULT NULL COMMENT 'Subtotal Canceled',
  `subtotal_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Subtotal Invoiced',
  `subtotal_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Subtotal Refunded',
  `tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Tax Amount',
  `tax_canceled` decimal(12,4) DEFAULT NULL COMMENT 'Tax Canceled',
  `tax_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Tax Invoiced',
  `tax_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Tax Refunded',
  `total_canceled` decimal(12,4) DEFAULT NULL COMMENT 'Total Canceled',
  `total_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Total Invoiced',
  `total_offline_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Total Offline Refunded',
  `total_online_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Total Online Refunded',
  `total_paid` decimal(12,4) DEFAULT NULL COMMENT 'Total Paid',
  `total_qty_ordered` decimal(12,4) DEFAULT NULL COMMENT 'Total Qty Ordered',
  `total_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Total Refunded',
  `can_ship_partially` smallint(5) unsigned DEFAULT NULL COMMENT 'Can Ship Partially',
  `can_ship_partially_item` smallint(5) unsigned DEFAULT NULL COMMENT 'Can Ship Partially Item',
  `customer_is_guest` smallint(5) unsigned DEFAULT NULL COMMENT 'Customer Is Guest',
  `customer_note_notify` smallint(5) unsigned DEFAULT NULL COMMENT 'Customer Note Notify',
  `billing_address_id` int(11) DEFAULT NULL COMMENT 'Billing Address Id',
  `customer_group_id` smallint(6) DEFAULT NULL COMMENT 'Customer Group Id',
  `edit_increment` int(11) DEFAULT NULL COMMENT 'Edit Increment',
  `email_sent` smallint(5) unsigned DEFAULT NULL COMMENT 'Email Sent',
  `forced_shipment_with_invoice` smallint(5) unsigned DEFAULT NULL COMMENT 'Forced Do Shipment With Invoice',
  `payment_auth_expiration` int(11) DEFAULT NULL COMMENT 'Payment Authorization Expiration',
  `quote_address_id` int(11) DEFAULT NULL COMMENT 'Quote Address Id',
  `quote_id` int(11) DEFAULT NULL COMMENT 'Quote Id',
  `shipping_address_id` int(11) DEFAULT NULL COMMENT 'Shipping Address Id',
  `adjustment_negative` decimal(12,4) DEFAULT NULL COMMENT 'Adjustment Negative',
  `adjustment_positive` decimal(12,4) DEFAULT NULL COMMENT 'Adjustment Positive',
  `base_adjustment_negative` decimal(12,4) DEFAULT NULL COMMENT 'Base Adjustment Negative',
  `base_adjustment_positive` decimal(12,4) DEFAULT NULL COMMENT 'Base Adjustment Positive',
  `base_shipping_discount_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Discount Amount',
  `base_subtotal_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Base Subtotal Incl Tax',
  `base_total_due` decimal(12,4) DEFAULT NULL COMMENT 'Base Total Due',
  `payment_authorization_amount` decimal(12,4) DEFAULT NULL COMMENT 'Payment Authorization Amount',
  `shipping_discount_amount` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Discount Amount',
  `subtotal_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Subtotal Incl Tax',
  `total_due` decimal(12,4) DEFAULT NULL COMMENT 'Total Due',
  `weight` decimal(12,4) DEFAULT NULL COMMENT 'Weight',
  `customer_dob` datetime DEFAULT NULL COMMENT 'Customer Dob',
  `increment_id` varchar(50) DEFAULT NULL COMMENT 'Increment Id',
  `applied_rule_ids` varchar(255) DEFAULT NULL COMMENT 'Applied Rule Ids',
  `base_currency_code` varchar(3) DEFAULT NULL COMMENT 'Base Currency Code',
  `customer_email` varchar(255) DEFAULT NULL COMMENT 'Customer Email',
  `customer_firstname` varchar(255) DEFAULT NULL COMMENT 'Customer Firstname',
  `customer_lastname` varchar(255) DEFAULT NULL COMMENT 'Customer Lastname',
  `customer_middlename` varchar(255) DEFAULT NULL COMMENT 'Customer Middlename',
  `customer_prefix` varchar(255) DEFAULT NULL COMMENT 'Customer Prefix',
  `customer_suffix` varchar(255) DEFAULT NULL COMMENT 'Customer Suffix',
  `customer_taxvat` varchar(255) DEFAULT NULL COMMENT 'Customer Taxvat',
  `discount_description` varchar(255) DEFAULT NULL COMMENT 'Discount Description',
  `ext_customer_id` varchar(255) DEFAULT NULL COMMENT 'Ext Customer Id',
  `ext_order_id` varchar(255) DEFAULT NULL COMMENT 'Ext Order Id',
  `global_currency_code` varchar(3) DEFAULT NULL COMMENT 'Global Currency Code',
  `hold_before_state` varchar(255) DEFAULT NULL COMMENT 'Hold Before State',
  `hold_before_status` varchar(255) DEFAULT NULL COMMENT 'Hold Before Status',
  `order_currency_code` varchar(255) DEFAULT NULL COMMENT 'Order Currency Code',
  `original_increment_id` varchar(50) DEFAULT NULL COMMENT 'Original Increment Id',
  `relation_child_id` varchar(32) DEFAULT NULL COMMENT 'Relation Child Id',
  `relation_child_real_id` varchar(32) DEFAULT NULL COMMENT 'Relation Child Real Id',
  `relation_parent_id` varchar(32) DEFAULT NULL COMMENT 'Relation Parent Id',
  `relation_parent_real_id` varchar(32) DEFAULT NULL COMMENT 'Relation Parent Real Id',
  `remote_ip` varchar(255) DEFAULT NULL COMMENT 'Remote Ip',
  `shipping_method` varchar(255) DEFAULT NULL COMMENT 'Shipping Method',
  `store_currency_code` varchar(3) DEFAULT NULL COMMENT 'Store Currency Code',
  `store_name` varchar(255) DEFAULT NULL COMMENT 'Store Name',
  `x_forwarded_for` varchar(255) DEFAULT NULL COMMENT 'X Forwarded For',
  `customer_note` text COMMENT 'Customer Note',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Created At',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'Updated At',
  `total_item_count` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Total Item Count',
  `customer_gender` int(11) DEFAULT NULL COMMENT 'Customer Gender',
  `hidden_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Hidden Tax Amount',
  `base_hidden_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Hidden Tax Amount',
  `shipping_hidden_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Hidden Tax Amount',
  `base_shipping_hidden_tax_amnt` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Hidden Tax Amount',
  `hidden_tax_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Hidden Tax Invoiced',
  `base_hidden_tax_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Base Hidden Tax Invoiced',
  `hidden_tax_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Hidden Tax Refunded',
  `base_hidden_tax_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Base Hidden Tax Refunded',
  `shipping_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Incl Tax',
  `base_shipping_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Incl Tax',
  `coupon_rule_name` varchar(255) DEFAULT NULL COMMENT 'Coupon Sales Rule Name',
  `paypal_ipn_customer_notified` int(11) DEFAULT '0' COMMENT 'Paypal Ipn Customer Notified',
  `gift_message_id` int(11) DEFAULT NULL COMMENT 'Gift Message Id',
  PRIMARY KEY (`entity_id`),
  UNIQUE KEY `UNQ_SALES_FLAT_ORDER_INCREMENT_ID` (`increment_id`),
  KEY `IDX_SALES_FLAT_ORDER_STATUS` (`status`),
  KEY `IDX_SALES_FLAT_ORDER_STATE` (`state`),
  KEY `IDX_SALES_FLAT_ORDER_STORE_ID` (`store_id`),
  KEY `IDX_SALES_FLAT_ORDER_CREATED_AT` (`created_at`),
  KEY `IDX_SALES_FLAT_ORDER_CUSTOMER_ID` (`customer_id`),
  KEY `IDX_SALES_FLAT_ORDER_EXT_ORDER_ID` (`ext_order_id`),
  KEY `IDX_SALES_FLAT_ORDER_QUOTE_ID` (`quote_id`),
  KEY `IDX_SALES_FLAT_ORDER_UPDATED_AT` (`updated_at`),
  CONSTRAINT `FK_SALES_FLAT_ORDER_CUSTOMER_ID_CUSTOMER_ENTITY_ENTITY_ID` FOREIGN KEY (`customer_id`) REFERENCES `customer_entity` (`entity_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `FK_SALES_FLAT_ORDER_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Order';



# Dump of table sales_flat_order_address
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sales_flat_order_address`;

CREATE TABLE `sales_flat_order_address` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `parent_id` int(10) unsigned DEFAULT NULL COMMENT 'Parent Id',
  `customer_address_id` int(11) DEFAULT NULL COMMENT 'Customer Address Id',
  `quote_address_id` int(11) DEFAULT NULL COMMENT 'Quote Address Id',
  `region_id` int(11) DEFAULT NULL COMMENT 'Region Id',
  `customer_id` int(11) DEFAULT NULL COMMENT 'Customer Id',
  `fax` varchar(255) DEFAULT NULL COMMENT 'Fax',
  `region` varchar(255) DEFAULT NULL COMMENT 'Region',
  `postcode` varchar(255) DEFAULT NULL COMMENT 'Postcode',
  `lastname` varchar(255) DEFAULT NULL COMMENT 'Lastname',
  `street` varchar(255) DEFAULT NULL COMMENT 'Street',
  `city` varchar(255) DEFAULT NULL COMMENT 'City',
  `email` varchar(255) DEFAULT NULL COMMENT 'Email',
  `telephone` varchar(255) DEFAULT NULL COMMENT 'Telephone',
  `country_id` varchar(2) DEFAULT NULL COMMENT 'Country Id',
  `firstname` varchar(255) DEFAULT NULL COMMENT 'Firstname',
  `address_type` varchar(255) DEFAULT NULL COMMENT 'Address Type',
  `prefix` varchar(255) DEFAULT NULL COMMENT 'Prefix',
  `middlename` varchar(255) DEFAULT NULL COMMENT 'Middlename',
  `suffix` varchar(255) DEFAULT NULL COMMENT 'Suffix',
  `company` varchar(255) DEFAULT NULL COMMENT 'Company',
  `vat_id` text COMMENT 'Vat Id',
  `vat_is_valid` smallint(6) DEFAULT NULL COMMENT 'Vat Is Valid',
  `vat_request_id` text COMMENT 'Vat Request Id',
  `vat_request_date` text COMMENT 'Vat Request Date',
  `vat_request_success` smallint(6) DEFAULT NULL COMMENT 'Vat Request Success',
  PRIMARY KEY (`entity_id`),
  KEY `IDX_SALES_FLAT_ORDER_ADDRESS_PARENT_ID` (`parent_id`),
  CONSTRAINT `FK_SALES_FLAT_ORDER_ADDRESS_PARENT_ID_SALES_FLAT_ORDER_ENTITY_ID` FOREIGN KEY (`parent_id`) REFERENCES `sales_flat_order` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Order Address';



# Dump of table sales_flat_order_grid
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sales_flat_order_grid`;

CREATE TABLE `sales_flat_order_grid` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity Id',
  `status` varchar(32) DEFAULT NULL COMMENT 'Status',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `store_name` varchar(255) DEFAULT NULL COMMENT 'Store Name',
  `customer_id` int(10) unsigned DEFAULT NULL COMMENT 'Customer Id',
  `base_grand_total` decimal(12,4) DEFAULT NULL COMMENT 'Base Grand Total',
  `base_total_paid` decimal(12,4) DEFAULT NULL COMMENT 'Base Total Paid',
  `grand_total` decimal(12,4) DEFAULT NULL COMMENT 'Grand Total',
  `total_paid` decimal(12,4) DEFAULT NULL COMMENT 'Total Paid',
  `increment_id` varchar(50) DEFAULT NULL COMMENT 'Increment Id',
  `base_currency_code` varchar(3) DEFAULT NULL COMMENT 'Base Currency Code',
  `order_currency_code` varchar(255) DEFAULT NULL COMMENT 'Order Currency Code',
  `shipping_name` varchar(255) DEFAULT NULL COMMENT 'Shipping Name',
  `billing_name` varchar(255) DEFAULT NULL COMMENT 'Billing Name',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Created At',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'Updated At',
  PRIMARY KEY (`entity_id`),
  UNIQUE KEY `UNQ_SALES_FLAT_ORDER_GRID_INCREMENT_ID` (`increment_id`),
  KEY `IDX_SALES_FLAT_ORDER_GRID_STATUS` (`status`),
  KEY `IDX_SALES_FLAT_ORDER_GRID_STORE_ID` (`store_id`),
  KEY `IDX_SALES_FLAT_ORDER_GRID_BASE_GRAND_TOTAL` (`base_grand_total`),
  KEY `IDX_SALES_FLAT_ORDER_GRID_BASE_TOTAL_PAID` (`base_total_paid`),
  KEY `IDX_SALES_FLAT_ORDER_GRID_GRAND_TOTAL` (`grand_total`),
  KEY `IDX_SALES_FLAT_ORDER_GRID_TOTAL_PAID` (`total_paid`),
  KEY `IDX_SALES_FLAT_ORDER_GRID_SHIPPING_NAME` (`shipping_name`),
  KEY `IDX_SALES_FLAT_ORDER_GRID_BILLING_NAME` (`billing_name`),
  KEY `IDX_SALES_FLAT_ORDER_GRID_CREATED_AT` (`created_at`),
  KEY `IDX_SALES_FLAT_ORDER_GRID_CUSTOMER_ID` (`customer_id`),
  KEY `IDX_SALES_FLAT_ORDER_GRID_UPDATED_AT` (`updated_at`),
  CONSTRAINT `FK_SALES_FLAT_ORDER_GRID_CUSTOMER_ID_CUSTOMER_ENTITY_ENTITY_ID` FOREIGN KEY (`customer_id`) REFERENCES `customer_entity` (`entity_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `FK_SALES_FLAT_ORDER_GRID_ENTITY_ID_SALES_FLAT_ORDER_ENTITY_ID` FOREIGN KEY (`entity_id`) REFERENCES `sales_flat_order` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_SALES_FLAT_ORDER_GRID_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Order Grid';



# Dump of table sales_flat_order_item
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sales_flat_order_item`;

CREATE TABLE `sales_flat_order_item` (
  `item_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Item Id',
  `order_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Order Id',
  `parent_item_id` int(10) unsigned DEFAULT NULL COMMENT 'Parent Item Id',
  `quote_item_id` int(10) unsigned DEFAULT NULL COMMENT 'Quote Item Id',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Created At',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Updated At',
  `product_id` int(10) unsigned DEFAULT NULL COMMENT 'Product Id',
  `product_type` varchar(255) DEFAULT NULL COMMENT 'Product Type',
  `product_options` text COMMENT 'Product Options',
  `weight` decimal(12,4) DEFAULT '0.0000' COMMENT 'Weight',
  `is_virtual` smallint(5) unsigned DEFAULT NULL COMMENT 'Is Virtual',
  `sku` varchar(255) DEFAULT NULL COMMENT 'Sku',
  `name` varchar(255) DEFAULT NULL COMMENT 'Name',
  `description` text COMMENT 'Description',
  `applied_rule_ids` text COMMENT 'Applied Rule Ids',
  `additional_data` text COMMENT 'Additional Data',
  `free_shipping` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Free Shipping',
  `is_qty_decimal` smallint(5) unsigned DEFAULT NULL COMMENT 'Is Qty Decimal',
  `no_discount` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'No Discount',
  `qty_backordered` decimal(12,4) DEFAULT '0.0000' COMMENT 'Qty Backordered',
  `qty_canceled` decimal(12,4) DEFAULT '0.0000' COMMENT 'Qty Canceled',
  `qty_invoiced` decimal(12,4) DEFAULT '0.0000' COMMENT 'Qty Invoiced',
  `qty_ordered` decimal(12,4) DEFAULT '0.0000' COMMENT 'Qty Ordered',
  `qty_refunded` decimal(12,4) DEFAULT '0.0000' COMMENT 'Qty Refunded',
  `qty_shipped` decimal(12,4) DEFAULT '0.0000' COMMENT 'Qty Shipped',
  `base_cost` decimal(12,4) DEFAULT '0.0000' COMMENT 'Base Cost',
  `price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Price',
  `base_price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Base Price',
  `original_price` decimal(12,4) DEFAULT NULL COMMENT 'Original Price',
  `base_original_price` decimal(12,4) DEFAULT NULL COMMENT 'Base Original Price',
  `tax_percent` decimal(12,4) DEFAULT '0.0000' COMMENT 'Tax Percent',
  `tax_amount` decimal(12,4) DEFAULT '0.0000' COMMENT 'Tax Amount',
  `base_tax_amount` decimal(12,4) DEFAULT '0.0000' COMMENT 'Base Tax Amount',
  `tax_invoiced` decimal(12,4) DEFAULT '0.0000' COMMENT 'Tax Invoiced',
  `base_tax_invoiced` decimal(12,4) DEFAULT '0.0000' COMMENT 'Base Tax Invoiced',
  `discount_percent` decimal(12,4) DEFAULT '0.0000' COMMENT 'Discount Percent',
  `discount_amount` decimal(12,4) DEFAULT '0.0000' COMMENT 'Discount Amount',
  `base_discount_amount` decimal(12,4) DEFAULT '0.0000' COMMENT 'Base Discount Amount',
  `discount_invoiced` decimal(12,4) DEFAULT '0.0000' COMMENT 'Discount Invoiced',
  `base_discount_invoiced` decimal(12,4) DEFAULT '0.0000' COMMENT 'Base Discount Invoiced',
  `amount_refunded` decimal(12,4) DEFAULT '0.0000' COMMENT 'Amount Refunded',
  `base_amount_refunded` decimal(12,4) DEFAULT '0.0000' COMMENT 'Base Amount Refunded',
  `row_total` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Row Total',
  `base_row_total` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Base Row Total',
  `row_invoiced` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Row Invoiced',
  `base_row_invoiced` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Base Row Invoiced',
  `row_weight` decimal(12,4) DEFAULT '0.0000' COMMENT 'Row Weight',
  `base_tax_before_discount` decimal(12,4) DEFAULT NULL COMMENT 'Base Tax Before Discount',
  `tax_before_discount` decimal(12,4) DEFAULT NULL COMMENT 'Tax Before Discount',
  `ext_order_item_id` varchar(255) DEFAULT NULL COMMENT 'Ext Order Item Id',
  `locked_do_invoice` smallint(5) unsigned DEFAULT NULL COMMENT 'Locked Do Invoice',
  `locked_do_ship` smallint(5) unsigned DEFAULT NULL COMMENT 'Locked Do Ship',
  `price_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Price Incl Tax',
  `base_price_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Base Price Incl Tax',
  `row_total_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Row Total Incl Tax',
  `base_row_total_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Base Row Total Incl Tax',
  `hidden_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Hidden Tax Amount',
  `base_hidden_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Hidden Tax Amount',
  `hidden_tax_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Hidden Tax Invoiced',
  `base_hidden_tax_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Base Hidden Tax Invoiced',
  `hidden_tax_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Hidden Tax Refunded',
  `base_hidden_tax_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Base Hidden Tax Refunded',
  `is_nominal` int(11) NOT NULL DEFAULT '0' COMMENT 'Is Nominal',
  `tax_canceled` decimal(12,4) DEFAULT NULL COMMENT 'Tax Canceled',
  `hidden_tax_canceled` decimal(12,4) DEFAULT NULL COMMENT 'Hidden Tax Canceled',
  `tax_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Tax Refunded',
  `base_tax_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Base Tax Refunded',
  `discount_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Discount Refunded',
  `base_discount_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Base Discount Refunded',
  `gift_message_id` int(11) DEFAULT NULL COMMENT 'Gift Message Id',
  `gift_message_available` int(11) DEFAULT NULL COMMENT 'Gift Message Available',
  `base_weee_tax_applied_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Weee Tax Applied Amount',
  `base_weee_tax_applied_row_amnt` decimal(12,4) DEFAULT NULL COMMENT 'Base Weee Tax Applied Row Amnt',
  `weee_tax_applied_amount` decimal(12,4) DEFAULT NULL COMMENT 'Weee Tax Applied Amount',
  `weee_tax_applied_row_amount` decimal(12,4) DEFAULT NULL COMMENT 'Weee Tax Applied Row Amount',
  `weee_tax_applied` text COMMENT 'Weee Tax Applied',
  `weee_tax_disposition` decimal(12,4) DEFAULT NULL COMMENT 'Weee Tax Disposition',
  `weee_tax_row_disposition` decimal(12,4) DEFAULT NULL COMMENT 'Weee Tax Row Disposition',
  `base_weee_tax_disposition` decimal(12,4) DEFAULT NULL COMMENT 'Base Weee Tax Disposition',
  `base_weee_tax_row_disposition` decimal(12,4) DEFAULT NULL COMMENT 'Base Weee Tax Row Disposition',
  PRIMARY KEY (`item_id`),
  KEY `IDX_SALES_FLAT_ORDER_ITEM_ORDER_ID` (`order_id`),
  KEY `IDX_SALES_FLAT_ORDER_ITEM_STORE_ID` (`store_id`),
  CONSTRAINT `FK_SALES_FLAT_ORDER_ITEM_ORDER_ID_SALES_FLAT_ORDER_ENTITY_ID` FOREIGN KEY (`order_id`) REFERENCES `sales_flat_order` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_SALES_FLAT_ORDER_ITEM_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Order Item';



# Dump of table sales_flat_order_payment
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sales_flat_order_payment`;

CREATE TABLE `sales_flat_order_payment` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `parent_id` int(10) unsigned NOT NULL COMMENT 'Parent Id',
  `base_shipping_captured` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Captured',
  `shipping_captured` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Captured',
  `amount_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Amount Refunded',
  `base_amount_paid` decimal(12,4) DEFAULT NULL COMMENT 'Base Amount Paid',
  `amount_canceled` decimal(12,4) DEFAULT NULL COMMENT 'Amount Canceled',
  `base_amount_authorized` decimal(12,4) DEFAULT NULL COMMENT 'Base Amount Authorized',
  `base_amount_paid_online` decimal(12,4) DEFAULT NULL COMMENT 'Base Amount Paid Online',
  `base_amount_refunded_online` decimal(12,4) DEFAULT NULL COMMENT 'Base Amount Refunded Online',
  `base_shipping_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Amount',
  `shipping_amount` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Amount',
  `amount_paid` decimal(12,4) DEFAULT NULL COMMENT 'Amount Paid',
  `amount_authorized` decimal(12,4) DEFAULT NULL COMMENT 'Amount Authorized',
  `base_amount_ordered` decimal(12,4) DEFAULT NULL COMMENT 'Base Amount Ordered',
  `base_shipping_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Refunded',
  `shipping_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Refunded',
  `base_amount_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Base Amount Refunded',
  `amount_ordered` decimal(12,4) DEFAULT NULL COMMENT 'Amount Ordered',
  `base_amount_canceled` decimal(12,4) DEFAULT NULL COMMENT 'Base Amount Canceled',
  `quote_payment_id` int(11) DEFAULT NULL COMMENT 'Quote Payment Id',
  `additional_data` text COMMENT 'Additional Data',
  `cc_exp_month` varchar(255) DEFAULT NULL COMMENT 'Cc Exp Month',
  `cc_ss_start_year` varchar(255) DEFAULT NULL COMMENT 'Cc Ss Start Year',
  `echeck_bank_name` varchar(255) DEFAULT NULL COMMENT 'Echeck Bank Name',
  `method` varchar(255) DEFAULT NULL COMMENT 'Method',
  `cc_debug_request_body` varchar(255) DEFAULT NULL COMMENT 'Cc Debug Request Body',
  `cc_secure_verify` varchar(255) DEFAULT NULL COMMENT 'Cc Secure Verify',
  `protection_eligibility` varchar(255) DEFAULT NULL COMMENT 'Protection Eligibility',
  `cc_approval` varchar(255) DEFAULT NULL COMMENT 'Cc Approval',
  `cc_last4` varchar(255) DEFAULT NULL COMMENT 'Cc Last4',
  `cc_status_description` varchar(255) DEFAULT NULL COMMENT 'Cc Status Description',
  `echeck_type` varchar(255) DEFAULT NULL COMMENT 'Echeck Type',
  `cc_debug_response_serialized` varchar(255) DEFAULT NULL COMMENT 'Cc Debug Response Serialized',
  `cc_ss_start_month` varchar(255) DEFAULT NULL COMMENT 'Cc Ss Start Month',
  `echeck_account_type` varchar(255) DEFAULT NULL COMMENT 'Echeck Account Type',
  `last_trans_id` varchar(255) DEFAULT NULL COMMENT 'Last Trans Id',
  `cc_cid_status` varchar(255) DEFAULT NULL COMMENT 'Cc Cid Status',
  `cc_owner` varchar(255) DEFAULT NULL COMMENT 'Cc Owner',
  `cc_type` varchar(255) DEFAULT NULL COMMENT 'Cc Type',
  `po_number` varchar(255) DEFAULT NULL COMMENT 'Po Number',
  `cc_exp_year` varchar(255) DEFAULT NULL COMMENT 'Cc Exp Year',
  `cc_status` varchar(255) DEFAULT NULL COMMENT 'Cc Status',
  `echeck_routing_number` varchar(255) DEFAULT NULL COMMENT 'Echeck Routing Number',
  `account_status` varchar(255) DEFAULT NULL COMMENT 'Account Status',
  `anet_trans_method` varchar(255) DEFAULT NULL COMMENT 'Anet Trans Method',
  `cc_debug_response_body` varchar(255) DEFAULT NULL COMMENT 'Cc Debug Response Body',
  `cc_ss_issue` varchar(255) DEFAULT NULL COMMENT 'Cc Ss Issue',
  `echeck_account_name` varchar(255) DEFAULT NULL COMMENT 'Echeck Account Name',
  `cc_avs_status` varchar(255) DEFAULT NULL COMMENT 'Cc Avs Status',
  `cc_number_enc` varchar(255) DEFAULT NULL COMMENT 'Cc Number Enc',
  `cc_trans_id` varchar(255) DEFAULT NULL COMMENT 'Cc Trans Id',
  `paybox_request_number` varchar(255) DEFAULT NULL COMMENT 'Paybox Request Number',
  `address_status` varchar(255) DEFAULT NULL COMMENT 'Address Status',
  `additional_information` text COMMENT 'Additional Information',
  PRIMARY KEY (`entity_id`),
  KEY `IDX_SALES_FLAT_ORDER_PAYMENT_PARENT_ID` (`parent_id`),
  CONSTRAINT `FK_SALES_FLAT_ORDER_PAYMENT_PARENT_ID_SALES_FLAT_ORDER_ENTITY_ID` FOREIGN KEY (`parent_id`) REFERENCES `sales_flat_order` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Order Payment';



# Dump of table sales_flat_order_status_history
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sales_flat_order_status_history`;

CREATE TABLE `sales_flat_order_status_history` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `parent_id` int(10) unsigned NOT NULL COMMENT 'Parent Id',
  `is_customer_notified` int(11) DEFAULT NULL COMMENT 'Is Customer Notified',
  `is_visible_on_front` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Visible On Front',
  `comment` text COMMENT 'Comment',
  `status` varchar(32) DEFAULT NULL COMMENT 'Status',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Created At',
  `entity_name` varchar(32) DEFAULT NULL COMMENT 'Shows what entity history is bind to.',
  PRIMARY KEY (`entity_id`),
  KEY `IDX_SALES_FLAT_ORDER_STATUS_HISTORY_PARENT_ID` (`parent_id`),
  KEY `IDX_SALES_FLAT_ORDER_STATUS_HISTORY_CREATED_AT` (`created_at`),
  CONSTRAINT `FK_CE7C71E74CB74DDACED337CEE6753D5E` FOREIGN KEY (`parent_id`) REFERENCES `sales_flat_order` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Order Status History';



# Dump of table sales_flat_quote
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sales_flat_quote`;

CREATE TABLE `sales_flat_quote` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Created At',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Updated At',
  `converted_at` timestamp NULL DEFAULT NULL COMMENT 'Converted At',
  `is_active` smallint(5) unsigned DEFAULT '1' COMMENT 'Is Active',
  `is_virtual` smallint(5) unsigned DEFAULT '0' COMMENT 'Is Virtual',
  `is_multi_shipping` smallint(5) unsigned DEFAULT '0' COMMENT 'Is Multi Shipping',
  `items_count` int(10) unsigned DEFAULT '0' COMMENT 'Items Count',
  `items_qty` decimal(12,4) DEFAULT '0.0000' COMMENT 'Items Qty',
  `orig_order_id` int(10) unsigned DEFAULT '0' COMMENT 'Orig Order Id',
  `store_to_base_rate` decimal(12,4) DEFAULT '0.0000' COMMENT 'Store To Base Rate',
  `store_to_quote_rate` decimal(12,4) DEFAULT '0.0000' COMMENT 'Store To Quote Rate',
  `base_currency_code` varchar(255) DEFAULT NULL COMMENT 'Base Currency Code',
  `store_currency_code` varchar(255) DEFAULT NULL COMMENT 'Store Currency Code',
  `quote_currency_code` varchar(255) DEFAULT NULL COMMENT 'Quote Currency Code',
  `grand_total` decimal(12,4) DEFAULT '0.0000' COMMENT 'Grand Total',
  `base_grand_total` decimal(12,4) DEFAULT '0.0000' COMMENT 'Base Grand Total',
  `checkout_method` varchar(255) DEFAULT NULL COMMENT 'Checkout Method',
  `customer_id` int(10) unsigned DEFAULT '0' COMMENT 'Customer Id',
  `customer_tax_class_id` int(10) unsigned DEFAULT '0' COMMENT 'Customer Tax Class Id',
  `customer_group_id` int(10) unsigned DEFAULT '0' COMMENT 'Customer Group Id',
  `customer_email` varchar(255) DEFAULT NULL COMMENT 'Customer Email',
  `customer_prefix` varchar(40) DEFAULT NULL COMMENT 'Customer Prefix',
  `customer_firstname` varchar(255) DEFAULT NULL COMMENT 'Customer Firstname',
  `customer_middlename` varchar(40) DEFAULT NULL COMMENT 'Customer Middlename',
  `customer_lastname` varchar(255) DEFAULT NULL COMMENT 'Customer Lastname',
  `customer_suffix` varchar(40) DEFAULT NULL COMMENT 'Customer Suffix',
  `customer_dob` datetime DEFAULT NULL COMMENT 'Customer Dob',
  `customer_note` varchar(255) DEFAULT NULL COMMENT 'Customer Note',
  `customer_note_notify` smallint(5) unsigned DEFAULT '1' COMMENT 'Customer Note Notify',
  `customer_is_guest` smallint(5) unsigned DEFAULT '0' COMMENT 'Customer Is Guest',
  `remote_ip` varchar(255) DEFAULT NULL COMMENT 'Remote Ip',
  `applied_rule_ids` varchar(255) DEFAULT NULL COMMENT 'Applied Rule Ids',
  `reserved_order_id` varchar(64) DEFAULT NULL COMMENT 'Reserved Order Id',
  `password_hash` varchar(255) DEFAULT NULL COMMENT 'Password Hash',
  `coupon_code` varchar(255) DEFAULT NULL COMMENT 'Coupon Code',
  `global_currency_code` varchar(255) DEFAULT NULL COMMENT 'Global Currency Code',
  `base_to_global_rate` decimal(12,4) DEFAULT NULL COMMENT 'Base To Global Rate',
  `base_to_quote_rate` decimal(12,4) DEFAULT NULL COMMENT 'Base To Quote Rate',
  `customer_taxvat` varchar(255) DEFAULT NULL COMMENT 'Customer Taxvat',
  `customer_gender` varchar(255) DEFAULT NULL COMMENT 'Customer Gender',
  `subtotal` decimal(12,4) DEFAULT NULL COMMENT 'Subtotal',
  `base_subtotal` decimal(12,4) DEFAULT NULL COMMENT 'Base Subtotal',
  `subtotal_with_discount` decimal(12,4) DEFAULT NULL COMMENT 'Subtotal With Discount',
  `base_subtotal_with_discount` decimal(12,4) DEFAULT NULL COMMENT 'Base Subtotal With Discount',
  `is_changed` int(10) unsigned DEFAULT NULL COMMENT 'Is Changed',
  `trigger_recollect` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Trigger Recollect',
  `ext_shipping_info` text COMMENT 'Ext Shipping Info',
  `gift_message_id` int(11) DEFAULT NULL COMMENT 'Gift Message Id',
  `is_persistent` smallint(5) unsigned DEFAULT '0' COMMENT 'Is Quote Persistent',
  PRIMARY KEY (`entity_id`),
  KEY `IDX_SALES_FLAT_QUOTE_CUSTOMER_ID_STORE_ID_IS_ACTIVE` (`customer_id`,`store_id`,`is_active`),
  KEY `IDX_SALES_FLAT_QUOTE_STORE_ID` (`store_id`),
  CONSTRAINT `FK_SALES_FLAT_QUOTE_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Quote';



# Dump of table sales_flat_quote_address
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sales_flat_quote_address`;

CREATE TABLE `sales_flat_quote_address` (
  `address_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Address Id',
  `quote_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Quote Id',
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Created At',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Updated At',
  `customer_id` int(10) unsigned DEFAULT NULL COMMENT 'Customer Id',
  `save_in_address_book` smallint(6) DEFAULT '0' COMMENT 'Save In Address Book',
  `customer_address_id` int(10) unsigned DEFAULT NULL COMMENT 'Customer Address Id',
  `address_type` varchar(255) DEFAULT NULL COMMENT 'Address Type',
  `email` varchar(255) DEFAULT NULL COMMENT 'Email',
  `prefix` varchar(40) DEFAULT NULL COMMENT 'Prefix',
  `firstname` varchar(255) DEFAULT NULL COMMENT 'Firstname',
  `middlename` varchar(40) DEFAULT NULL COMMENT 'Middlename',
  `lastname` varchar(255) DEFAULT NULL COMMENT 'Lastname',
  `suffix` varchar(40) DEFAULT NULL COMMENT 'Suffix',
  `company` varchar(255) DEFAULT NULL COMMENT 'Company',
  `street` varchar(255) DEFAULT NULL COMMENT 'Street',
  `city` varchar(255) DEFAULT NULL COMMENT 'City',
  `region` varchar(255) DEFAULT NULL COMMENT 'Region',
  `region_id` int(10) unsigned DEFAULT NULL COMMENT 'Region Id',
  `postcode` varchar(255) DEFAULT NULL COMMENT 'Postcode',
  `country_id` varchar(255) DEFAULT NULL COMMENT 'Country Id',
  `telephone` varchar(255) DEFAULT NULL COMMENT 'Telephone',
  `fax` varchar(255) DEFAULT NULL COMMENT 'Fax',
  `same_as_billing` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Same As Billing',
  `free_shipping` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Free Shipping',
  `collect_shipping_rates` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Collect Shipping Rates',
  `shipping_method` varchar(255) DEFAULT NULL COMMENT 'Shipping Method',
  `shipping_description` varchar(255) DEFAULT NULL COMMENT 'Shipping Description',
  `weight` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Weight',
  `subtotal` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Subtotal',
  `base_subtotal` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Base Subtotal',
  `subtotal_with_discount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Subtotal With Discount',
  `base_subtotal_with_discount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Base Subtotal With Discount',
  `tax_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Tax Amount',
  `base_tax_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Base Tax Amount',
  `shipping_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Shipping Amount',
  `base_shipping_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Base Shipping Amount',
  `shipping_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Tax Amount',
  `base_shipping_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Tax Amount',
  `discount_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Discount Amount',
  `base_discount_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Base Discount Amount',
  `grand_total` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Grand Total',
  `base_grand_total` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Base Grand Total',
  `customer_notes` text COMMENT 'Customer Notes',
  `applied_taxes` text COMMENT 'Applied Taxes',
  `discount_description` varchar(255) DEFAULT NULL COMMENT 'Discount Description',
  `shipping_discount_amount` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Discount Amount',
  `base_shipping_discount_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Discount Amount',
  `subtotal_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Subtotal Incl Tax',
  `base_subtotal_total_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Base Subtotal Total Incl Tax',
  `hidden_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Hidden Tax Amount',
  `base_hidden_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Hidden Tax Amount',
  `shipping_hidden_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Hidden Tax Amount',
  `base_shipping_hidden_tax_amnt` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Hidden Tax Amount',
  `shipping_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Incl Tax',
  `base_shipping_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Incl Tax',
  `vat_id` text COMMENT 'Vat Id',
  `vat_is_valid` smallint(6) DEFAULT NULL COMMENT 'Vat Is Valid',
  `vat_request_id` text COMMENT 'Vat Request Id',
  `vat_request_date` text COMMENT 'Vat Request Date',
  `vat_request_success` smallint(6) DEFAULT NULL COMMENT 'Vat Request Success',
  `gift_message_id` int(11) DEFAULT NULL COMMENT 'Gift Message Id',
  PRIMARY KEY (`address_id`),
  KEY `IDX_SALES_FLAT_QUOTE_ADDRESS_QUOTE_ID` (`quote_id`),
  CONSTRAINT `FK_SALES_FLAT_QUOTE_ADDRESS_QUOTE_ID_SALES_FLAT_QUOTE_ENTITY_ID` FOREIGN KEY (`quote_id`) REFERENCES `sales_flat_quote` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Quote Address';



# Dump of table sales_flat_quote_address_item
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sales_flat_quote_address_item`;

CREATE TABLE `sales_flat_quote_address_item` (
  `address_item_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Address Item Id',
  `parent_item_id` int(10) unsigned DEFAULT NULL COMMENT 'Parent Item Id',
  `quote_address_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Quote Address Id',
  `quote_item_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Quote Item Id',
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Created At',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Updated At',
  `applied_rule_ids` text COMMENT 'Applied Rule Ids',
  `additional_data` text COMMENT 'Additional Data',
  `weight` decimal(12,4) DEFAULT '0.0000' COMMENT 'Weight',
  `qty` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Qty',
  `discount_amount` decimal(12,4) DEFAULT '0.0000' COMMENT 'Discount Amount',
  `tax_amount` decimal(12,4) DEFAULT '0.0000' COMMENT 'Tax Amount',
  `row_total` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Row Total',
  `base_row_total` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Base Row Total',
  `row_total_with_discount` decimal(12,4) DEFAULT '0.0000' COMMENT 'Row Total With Discount',
  `base_discount_amount` decimal(12,4) DEFAULT '0.0000' COMMENT 'Base Discount Amount',
  `base_tax_amount` decimal(12,4) DEFAULT '0.0000' COMMENT 'Base Tax Amount',
  `row_weight` decimal(12,4) DEFAULT '0.0000' COMMENT 'Row Weight',
  `product_id` int(10) unsigned DEFAULT NULL COMMENT 'Product Id',
  `super_product_id` int(10) unsigned DEFAULT NULL COMMENT 'Super Product Id',
  `parent_product_id` int(10) unsigned DEFAULT NULL COMMENT 'Parent Product Id',
  `sku` varchar(255) DEFAULT NULL COMMENT 'Sku',
  `image` varchar(255) DEFAULT NULL COMMENT 'Image',
  `name` varchar(255) DEFAULT NULL COMMENT 'Name',
  `description` text COMMENT 'Description',
  `free_shipping` int(10) unsigned DEFAULT NULL COMMENT 'Free Shipping',
  `is_qty_decimal` int(10) unsigned DEFAULT NULL COMMENT 'Is Qty Decimal',
  `price` decimal(12,4) DEFAULT NULL COMMENT 'Price',
  `discount_percent` decimal(12,4) DEFAULT NULL COMMENT 'Discount Percent',
  `no_discount` int(10) unsigned DEFAULT NULL COMMENT 'No Discount',
  `tax_percent` decimal(12,4) DEFAULT NULL COMMENT 'Tax Percent',
  `base_price` decimal(12,4) DEFAULT NULL COMMENT 'Base Price',
  `base_cost` decimal(12,4) DEFAULT NULL COMMENT 'Base Cost',
  `price_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Price Incl Tax',
  `base_price_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Base Price Incl Tax',
  `row_total_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Row Total Incl Tax',
  `base_row_total_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Base Row Total Incl Tax',
  `hidden_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Hidden Tax Amount',
  `base_hidden_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Hidden Tax Amount',
  `gift_message_id` int(11) DEFAULT NULL COMMENT 'Gift Message Id',
  PRIMARY KEY (`address_item_id`),
  KEY `IDX_SALES_FLAT_QUOTE_ADDRESS_ITEM_QUOTE_ADDRESS_ID` (`quote_address_id`),
  KEY `IDX_SALES_FLAT_QUOTE_ADDRESS_ITEM_PARENT_ITEM_ID` (`parent_item_id`),
  KEY `IDX_SALES_FLAT_QUOTE_ADDRESS_ITEM_QUOTE_ITEM_ID` (`quote_item_id`),
  CONSTRAINT `FK_2EF8E28181D666D94D4E30DC2B0F80BF` FOREIGN KEY (`quote_item_id`) REFERENCES `sales_flat_quote_item` (`item_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_A345FC758F20C314169CE27DCE53477F` FOREIGN KEY (`parent_item_id`) REFERENCES `sales_flat_quote_address_item` (`address_item_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_B521389746C00700D1B2B76EBBE53854` FOREIGN KEY (`quote_address_id`) REFERENCES `sales_flat_quote_address` (`address_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Quote Address Item';



# Dump of table sales_flat_quote_item
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sales_flat_quote_item`;

CREATE TABLE `sales_flat_quote_item` (
  `item_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Item Id',
  `quote_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Quote Id',
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Created At',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Updated At',
  `product_id` int(10) unsigned DEFAULT NULL COMMENT 'Product Id',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `parent_item_id` int(10) unsigned DEFAULT NULL COMMENT 'Parent Item Id',
  `is_virtual` smallint(5) unsigned DEFAULT NULL COMMENT 'Is Virtual',
  `sku` varchar(255) DEFAULT NULL COMMENT 'Sku',
  `name` varchar(255) DEFAULT NULL COMMENT 'Name',
  `description` text COMMENT 'Description',
  `applied_rule_ids` text COMMENT 'Applied Rule Ids',
  `additional_data` text COMMENT 'Additional Data',
  `free_shipping` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Free Shipping',
  `is_qty_decimal` smallint(5) unsigned DEFAULT NULL COMMENT 'Is Qty Decimal',
  `no_discount` smallint(5) unsigned DEFAULT '0' COMMENT 'No Discount',
  `weight` decimal(12,4) DEFAULT '0.0000' COMMENT 'Weight',
  `qty` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Qty',
  `price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Price',
  `base_price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Base Price',
  `custom_price` decimal(12,4) DEFAULT NULL COMMENT 'Custom Price',
  `discount_percent` decimal(12,4) DEFAULT '0.0000' COMMENT 'Discount Percent',
  `discount_amount` decimal(12,4) DEFAULT '0.0000' COMMENT 'Discount Amount',
  `base_discount_amount` decimal(12,4) DEFAULT '0.0000' COMMENT 'Base Discount Amount',
  `tax_percent` decimal(12,4) DEFAULT '0.0000' COMMENT 'Tax Percent',
  `tax_amount` decimal(12,4) DEFAULT '0.0000' COMMENT 'Tax Amount',
  `base_tax_amount` decimal(12,4) DEFAULT '0.0000' COMMENT 'Base Tax Amount',
  `row_total` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Row Total',
  `base_row_total` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Base Row Total',
  `row_total_with_discount` decimal(12,4) DEFAULT '0.0000' COMMENT 'Row Total With Discount',
  `row_weight` decimal(12,4) DEFAULT '0.0000' COMMENT 'Row Weight',
  `product_type` varchar(255) DEFAULT NULL COMMENT 'Product Type',
  `base_tax_before_discount` decimal(12,4) DEFAULT NULL COMMENT 'Base Tax Before Discount',
  `tax_before_discount` decimal(12,4) DEFAULT NULL COMMENT 'Tax Before Discount',
  `original_custom_price` decimal(12,4) DEFAULT NULL COMMENT 'Original Custom Price',
  `redirect_url` varchar(255) DEFAULT NULL COMMENT 'Redirect Url',
  `base_cost` decimal(12,4) DEFAULT NULL COMMENT 'Base Cost',
  `price_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Price Incl Tax',
  `base_price_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Base Price Incl Tax',
  `row_total_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Row Total Incl Tax',
  `base_row_total_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Base Row Total Incl Tax',
  `hidden_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Hidden Tax Amount',
  `base_hidden_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Hidden Tax Amount',
  `gift_message_id` int(11) DEFAULT NULL COMMENT 'Gift Message Id',
  `weee_tax_disposition` decimal(12,4) DEFAULT NULL COMMENT 'Weee Tax Disposition',
  `weee_tax_row_disposition` decimal(12,4) DEFAULT NULL COMMENT 'Weee Tax Row Disposition',
  `base_weee_tax_disposition` decimal(12,4) DEFAULT NULL COMMENT 'Base Weee Tax Disposition',
  `base_weee_tax_row_disposition` decimal(12,4) DEFAULT NULL COMMENT 'Base Weee Tax Row Disposition',
  `weee_tax_applied` text COMMENT 'Weee Tax Applied',
  `weee_tax_applied_amount` decimal(12,4) DEFAULT NULL COMMENT 'Weee Tax Applied Amount',
  `weee_tax_applied_row_amount` decimal(12,4) DEFAULT NULL COMMENT 'Weee Tax Applied Row Amount',
  `base_weee_tax_applied_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Weee Tax Applied Amount',
  `base_weee_tax_applied_row_amnt` decimal(12,4) DEFAULT NULL COMMENT 'Base Weee Tax Applied Row Amnt',
  PRIMARY KEY (`item_id`),
  KEY `IDX_SALES_FLAT_QUOTE_ITEM_PARENT_ITEM_ID` (`parent_item_id`),
  KEY `IDX_SALES_FLAT_QUOTE_ITEM_PRODUCT_ID` (`product_id`),
  KEY `IDX_SALES_FLAT_QUOTE_ITEM_QUOTE_ID` (`quote_id`),
  KEY `IDX_SALES_FLAT_QUOTE_ITEM_STORE_ID` (`store_id`),
  CONSTRAINT `FK_B201DEB5DE51B791AF5C5BF87053C5A7` FOREIGN KEY (`parent_item_id`) REFERENCES `sales_flat_quote_item` (`item_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_SALES_FLAT_QUOTE_ITEM_PRD_ID_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_SALES_FLAT_QUOTE_ITEM_QUOTE_ID_SALES_FLAT_QUOTE_ENTITY_ID` FOREIGN KEY (`quote_id`) REFERENCES `sales_flat_quote` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_SALES_FLAT_QUOTE_ITEM_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Quote Item';



# Dump of table sales_flat_quote_item_option
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sales_flat_quote_item_option`;

CREATE TABLE `sales_flat_quote_item_option` (
  `option_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Option Id',
  `item_id` int(10) unsigned NOT NULL COMMENT 'Item Id',
  `product_id` int(10) unsigned NOT NULL COMMENT 'Product Id',
  `code` varchar(255) NOT NULL COMMENT 'Code',
  `value` text COMMENT 'Value',
  PRIMARY KEY (`option_id`),
  KEY `IDX_SALES_FLAT_QUOTE_ITEM_OPTION_ITEM_ID` (`item_id`),
  CONSTRAINT `FK_5F20E478CA64B6891EA8A9D6C2735739` FOREIGN KEY (`item_id`) REFERENCES `sales_flat_quote_item` (`item_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Quote Item Option';



# Dump of table sales_flat_quote_payment
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sales_flat_quote_payment`;

CREATE TABLE `sales_flat_quote_payment` (
  `payment_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Payment Id',
  `quote_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Quote Id',
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Created At',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Updated At',
  `method` varchar(255) DEFAULT NULL COMMENT 'Method',
  `cc_type` varchar(255) DEFAULT NULL COMMENT 'Cc Type',
  `cc_number_enc` varchar(255) DEFAULT NULL COMMENT 'Cc Number Enc',
  `cc_last4` varchar(255) DEFAULT NULL COMMENT 'Cc Last4',
  `cc_cid_enc` varchar(255) DEFAULT NULL COMMENT 'Cc Cid Enc',
  `cc_owner` varchar(255) DEFAULT NULL COMMENT 'Cc Owner',
  `cc_exp_month` smallint(5) unsigned DEFAULT '0' COMMENT 'Cc Exp Month',
  `cc_exp_year` smallint(5) unsigned DEFAULT '0' COMMENT 'Cc Exp Year',
  `cc_ss_owner` varchar(255) DEFAULT NULL COMMENT 'Cc Ss Owner',
  `cc_ss_start_month` smallint(5) unsigned DEFAULT '0' COMMENT 'Cc Ss Start Month',
  `cc_ss_start_year` smallint(5) unsigned DEFAULT '0' COMMENT 'Cc Ss Start Year',
  `po_number` varchar(255) DEFAULT NULL COMMENT 'Po Number',
  `additional_data` text COMMENT 'Additional Data',
  `cc_ss_issue` varchar(255) DEFAULT NULL COMMENT 'Cc Ss Issue',
  `additional_information` text COMMENT 'Additional Information',
  `paypal_payer_id` varchar(255) DEFAULT NULL COMMENT 'Paypal Payer Id',
  `paypal_payer_status` varchar(255) DEFAULT NULL COMMENT 'Paypal Payer Status',
  `paypal_correlation_id` varchar(255) DEFAULT NULL COMMENT 'Paypal Correlation Id',
  PRIMARY KEY (`payment_id`),
  KEY `IDX_SALES_FLAT_QUOTE_PAYMENT_QUOTE_ID` (`quote_id`),
  CONSTRAINT `FK_SALES_FLAT_QUOTE_PAYMENT_QUOTE_ID_SALES_FLAT_QUOTE_ENTITY_ID` FOREIGN KEY (`quote_id`) REFERENCES `sales_flat_quote` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Quote Payment';



# Dump of table sales_flat_quote_shipping_rate
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sales_flat_quote_shipping_rate`;

CREATE TABLE `sales_flat_quote_shipping_rate` (
  `rate_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Rate Id',
  `address_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Address Id',
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Created At',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Updated At',
  `carrier` varchar(255) DEFAULT NULL COMMENT 'Carrier',
  `carrier_title` varchar(255) DEFAULT NULL COMMENT 'Carrier Title',
  `code` varchar(255) DEFAULT NULL COMMENT 'Code',
  `method` varchar(255) DEFAULT NULL COMMENT 'Method',
  `method_description` text COMMENT 'Method Description',
  `price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Price',
  `error_message` text COMMENT 'Error Message',
  `method_title` text COMMENT 'Method Title',
  PRIMARY KEY (`rate_id`),
  KEY `IDX_SALES_FLAT_QUOTE_SHIPPING_RATE_ADDRESS_ID` (`address_id`),
  CONSTRAINT `FK_B1F177EFB73D3EDF5322BA64AC48D150` FOREIGN KEY (`address_id`) REFERENCES `sales_flat_quote_address` (`address_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Quote Shipping Rate';



# Dump of table sales_flat_shipment
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sales_flat_shipment`;

CREATE TABLE `sales_flat_shipment` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `total_weight` decimal(12,4) DEFAULT NULL COMMENT 'Total Weight',
  `total_qty` decimal(12,4) DEFAULT NULL COMMENT 'Total Qty',
  `email_sent` smallint(5) unsigned DEFAULT NULL COMMENT 'Email Sent',
  `order_id` int(10) unsigned NOT NULL COMMENT 'Order Id',
  `customer_id` int(11) DEFAULT NULL COMMENT 'Customer Id',
  `shipping_address_id` int(11) DEFAULT NULL COMMENT 'Shipping Address Id',
  `billing_address_id` int(11) DEFAULT NULL COMMENT 'Billing Address Id',
  `shipment_status` int(11) DEFAULT NULL COMMENT 'Shipment Status',
  `increment_id` varchar(50) DEFAULT NULL COMMENT 'Increment Id',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Created At',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'Updated At',
  `packages` text COMMENT 'Packed Products in Packages',
  `shipping_label` mediumblob COMMENT 'Shipping Label Content',
  PRIMARY KEY (`entity_id`),
  UNIQUE KEY `UNQ_SALES_FLAT_SHIPMENT_INCREMENT_ID` (`increment_id`),
  KEY `IDX_SALES_FLAT_SHIPMENT_STORE_ID` (`store_id`),
  KEY `IDX_SALES_FLAT_SHIPMENT_TOTAL_QTY` (`total_qty`),
  KEY `IDX_SALES_FLAT_SHIPMENT_ORDER_ID` (`order_id`),
  KEY `IDX_SALES_FLAT_SHIPMENT_CREATED_AT` (`created_at`),
  KEY `IDX_SALES_FLAT_SHIPMENT_UPDATED_AT` (`updated_at`),
  CONSTRAINT `FK_SALES_FLAT_SHIPMENT_ORDER_ID_SALES_FLAT_ORDER_ENTITY_ID` FOREIGN KEY (`order_id`) REFERENCES `sales_flat_order` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_SALES_FLAT_SHIPMENT_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Shipment';



# Dump of table sales_flat_shipment_comment
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sales_flat_shipment_comment`;

CREATE TABLE `sales_flat_shipment_comment` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `parent_id` int(10) unsigned NOT NULL COMMENT 'Parent Id',
  `is_customer_notified` int(11) DEFAULT NULL COMMENT 'Is Customer Notified',
  `is_visible_on_front` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Visible On Front',
  `comment` text COMMENT 'Comment',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Created At',
  PRIMARY KEY (`entity_id`),
  KEY `IDX_SALES_FLAT_SHIPMENT_COMMENT_CREATED_AT` (`created_at`),
  KEY `IDX_SALES_FLAT_SHIPMENT_COMMENT_PARENT_ID` (`parent_id`),
  CONSTRAINT `FK_C2D69CC1FB03D2B2B794B0439F6650CF` FOREIGN KEY (`parent_id`) REFERENCES `sales_flat_shipment` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Shipment Comment';



# Dump of table sales_flat_shipment_grid
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sales_flat_shipment_grid`;

CREATE TABLE `sales_flat_shipment_grid` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity Id',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `total_qty` decimal(12,4) DEFAULT NULL COMMENT 'Total Qty',
  `order_id` int(10) unsigned NOT NULL COMMENT 'Order Id',
  `shipment_status` int(11) DEFAULT NULL COMMENT 'Shipment Status',
  `increment_id` varchar(50) DEFAULT NULL COMMENT 'Increment Id',
  `order_increment_id` varchar(50) DEFAULT NULL COMMENT 'Order Increment Id',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Created At',
  `order_created_at` timestamp NULL DEFAULT NULL COMMENT 'Order Created At',
  `shipping_name` varchar(255) DEFAULT NULL COMMENT 'Shipping Name',
  PRIMARY KEY (`entity_id`),
  UNIQUE KEY `UNQ_SALES_FLAT_SHIPMENT_GRID_INCREMENT_ID` (`increment_id`),
  KEY `IDX_SALES_FLAT_SHIPMENT_GRID_STORE_ID` (`store_id`),
  KEY `IDX_SALES_FLAT_SHIPMENT_GRID_TOTAL_QTY` (`total_qty`),
  KEY `IDX_SALES_FLAT_SHIPMENT_GRID_ORDER_ID` (`order_id`),
  KEY `IDX_SALES_FLAT_SHIPMENT_GRID_SHIPMENT_STATUS` (`shipment_status`),
  KEY `IDX_SALES_FLAT_SHIPMENT_GRID_ORDER_INCREMENT_ID` (`order_increment_id`),
  KEY `IDX_SALES_FLAT_SHIPMENT_GRID_CREATED_AT` (`created_at`),
  KEY `IDX_SALES_FLAT_SHIPMENT_GRID_ORDER_CREATED_AT` (`order_created_at`),
  KEY `IDX_SALES_FLAT_SHIPMENT_GRID_SHIPPING_NAME` (`shipping_name`),
  CONSTRAINT `FK_SALES_FLAT_SHIPMENT_GRID_ENTT_ID_SALES_FLAT_SHIPMENT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `sales_flat_shipment` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_SALES_FLAT_SHIPMENT_GRID_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Shipment Grid';



# Dump of table sales_flat_shipment_item
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sales_flat_shipment_item`;

CREATE TABLE `sales_flat_shipment_item` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `parent_id` int(10) unsigned NOT NULL COMMENT 'Parent Id',
  `row_total` decimal(12,4) DEFAULT NULL COMMENT 'Row Total',
  `price` decimal(12,4) DEFAULT NULL COMMENT 'Price',
  `weight` decimal(12,4) DEFAULT NULL COMMENT 'Weight',
  `qty` decimal(12,4) DEFAULT NULL COMMENT 'Qty',
  `product_id` int(11) DEFAULT NULL COMMENT 'Product Id',
  `order_item_id` int(11) DEFAULT NULL COMMENT 'Order Item Id',
  `additional_data` text COMMENT 'Additional Data',
  `description` text COMMENT 'Description',
  `name` varchar(255) DEFAULT NULL COMMENT 'Name',
  `sku` varchar(255) DEFAULT NULL COMMENT 'Sku',
  PRIMARY KEY (`entity_id`),
  KEY `IDX_SALES_FLAT_SHIPMENT_ITEM_PARENT_ID` (`parent_id`),
  CONSTRAINT `FK_3AECE5007D18F159231B87E8306FC02A` FOREIGN KEY (`parent_id`) REFERENCES `sales_flat_shipment` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Shipment Item';



# Dump of table sales_flat_shipment_track
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sales_flat_shipment_track`;

CREATE TABLE `sales_flat_shipment_track` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `parent_id` int(10) unsigned NOT NULL COMMENT 'Parent Id',
  `weight` decimal(12,4) DEFAULT NULL COMMENT 'Weight',
  `qty` decimal(12,4) DEFAULT NULL COMMENT 'Qty',
  `order_id` int(10) unsigned NOT NULL COMMENT 'Order Id',
  `track_number` text COMMENT 'Number',
  `description` text COMMENT 'Description',
  `title` varchar(255) DEFAULT NULL COMMENT 'Title',
  `carrier_code` varchar(32) DEFAULT NULL COMMENT 'Carrier Code',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Created At',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'Updated At',
  PRIMARY KEY (`entity_id`),
  KEY `IDX_SALES_FLAT_SHIPMENT_TRACK_PARENT_ID` (`parent_id`),
  KEY `IDX_SALES_FLAT_SHIPMENT_TRACK_ORDER_ID` (`order_id`),
  KEY `IDX_SALES_FLAT_SHIPMENT_TRACK_CREATED_AT` (`created_at`),
  CONSTRAINT `FK_BCD2FA28717D29F37E10A153E6F2F841` FOREIGN KEY (`parent_id`) REFERENCES `sales_flat_shipment` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Shipment Track';



# Dump of table sales_invoiced_aggregated
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sales_invoiced_aggregated`;

CREATE TABLE `sales_invoiced_aggregated` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `period` date DEFAULT NULL COMMENT 'Period',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `order_status` varchar(50) DEFAULT NULL COMMENT 'Order Status',
  `orders_count` int(11) NOT NULL DEFAULT '0' COMMENT 'Orders Count',
  `orders_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Orders Invoiced',
  `invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Invoiced',
  `invoiced_captured` decimal(12,4) DEFAULT NULL COMMENT 'Invoiced Captured',
  `invoiced_not_captured` decimal(12,4) DEFAULT NULL COMMENT 'Invoiced Not Captured',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNQ_SALES_INVOICED_AGGREGATED_PERIOD_STORE_ID_ORDER_STATUS` (`period`,`store_id`,`order_status`),
  KEY `IDX_SALES_INVOICED_AGGREGATED_STORE_ID` (`store_id`),
  CONSTRAINT `FK_SALES_INVOICED_AGGREGATED_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Invoiced Aggregated';



# Dump of table sales_invoiced_aggregated_order
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sales_invoiced_aggregated_order`;

CREATE TABLE `sales_invoiced_aggregated_order` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `period` date DEFAULT NULL COMMENT 'Period',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `order_status` varchar(50) NOT NULL DEFAULT '' COMMENT 'Order Status',
  `orders_count` int(11) NOT NULL DEFAULT '0' COMMENT 'Orders Count',
  `orders_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Orders Invoiced',
  `invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Invoiced',
  `invoiced_captured` decimal(12,4) DEFAULT NULL COMMENT 'Invoiced Captured',
  `invoiced_not_captured` decimal(12,4) DEFAULT NULL COMMENT 'Invoiced Not Captured',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNQ_SALES_INVOICED_AGGREGATED_ORDER_PERIOD_STORE_ID_ORDER_STATUS` (`period`,`store_id`,`order_status`),
  KEY `IDX_SALES_INVOICED_AGGREGATED_ORDER_STORE_ID` (`store_id`),
  CONSTRAINT `FK_SALES_INVOICED_AGGREGATED_ORDER_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Invoiced Aggregated Order';



# Dump of table sales_order_aggregated_created
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sales_order_aggregated_created`;

CREATE TABLE `sales_order_aggregated_created` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `period` date DEFAULT NULL COMMENT 'Period',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `order_status` varchar(50) NOT NULL DEFAULT '' COMMENT 'Order Status',
  `orders_count` int(11) NOT NULL DEFAULT '0' COMMENT 'Orders Count',
  `total_qty_ordered` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Qty Ordered',
  `total_qty_invoiced` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Qty Invoiced',
  `total_income_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Income Amount',
  `total_revenue_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Revenue Amount',
  `total_profit_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Profit Amount',
  `total_invoiced_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Invoiced Amount',
  `total_canceled_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Canceled Amount',
  `total_paid_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Paid Amount',
  `total_refunded_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Refunded Amount',
  `total_tax_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Tax Amount',
  `total_tax_amount_actual` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Tax Amount Actual',
  `total_shipping_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Shipping Amount',
  `total_shipping_amount_actual` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Shipping Amount Actual',
  `total_discount_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Discount Amount',
  `total_discount_amount_actual` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Discount Amount Actual',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNQ_SALES_ORDER_AGGREGATED_CREATED_PERIOD_STORE_ID_ORDER_STATUS` (`period`,`store_id`,`order_status`),
  KEY `IDX_SALES_ORDER_AGGREGATED_CREATED_STORE_ID` (`store_id`),
  CONSTRAINT `FK_SALES_ORDER_AGGREGATED_CREATED_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Order Aggregated Created';



# Dump of table sales_order_aggregated_updated
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sales_order_aggregated_updated`;

CREATE TABLE `sales_order_aggregated_updated` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `period` date DEFAULT NULL COMMENT 'Period',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `order_status` varchar(50) NOT NULL COMMENT 'Order Status',
  `orders_count` int(11) NOT NULL DEFAULT '0' COMMENT 'Orders Count',
  `total_qty_ordered` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Qty Ordered',
  `total_qty_invoiced` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Qty Invoiced',
  `total_income_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Income Amount',
  `total_revenue_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Revenue Amount',
  `total_profit_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Profit Amount',
  `total_invoiced_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Invoiced Amount',
  `total_canceled_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Canceled Amount',
  `total_paid_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Paid Amount',
  `total_refunded_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Refunded Amount',
  `total_tax_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Tax Amount',
  `total_tax_amount_actual` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Tax Amount Actual',
  `total_shipping_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Shipping Amount',
  `total_shipping_amount_actual` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Shipping Amount Actual',
  `total_discount_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Discount Amount',
  `total_discount_amount_actual` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Discount Amount Actual',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNQ_SALES_ORDER_AGGREGATED_UPDATED_PERIOD_STORE_ID_ORDER_STATUS` (`period`,`store_id`,`order_status`),
  KEY `IDX_SALES_ORDER_AGGREGATED_UPDATED_STORE_ID` (`store_id`),
  CONSTRAINT `FK_SALES_ORDER_AGGREGATED_UPDATED_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Order Aggregated Updated';



# Dump of table sales_order_status
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sales_order_status`;

CREATE TABLE `sales_order_status` (
  `status` varchar(32) NOT NULL COMMENT 'Status',
  `label` varchar(128) NOT NULL COMMENT 'Label',
  PRIMARY KEY (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Order Status Table';

LOCK TABLES `sales_order_status` WRITE;
/*!40000 ALTER TABLE `sales_order_status` DISABLE KEYS */;

INSERT INTO `sales_order_status` (`status`, `label`)
VALUES
	('canceled','Canceled'),
	('closed','Closed'),
	('complete','Complete'),
	('fraud','Suspected Fraud'),
	('holded','On Hold'),
	('payment_review','Payment Review'),
	('paypal_canceled_reversal','PayPal Canceled Reversal'),
	('paypal_reversed','PayPal Reversed'),
	('pending','Pending'),
	('pending_payment','Pending Payment'),
	('pending_paypal','Pending PayPal'),
	('processing','Processing');

/*!40000 ALTER TABLE `sales_order_status` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table sales_order_status_label
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sales_order_status_label`;

CREATE TABLE `sales_order_status_label` (
  `status` varchar(32) NOT NULL COMMENT 'Status',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store Id',
  `label` varchar(128) NOT NULL COMMENT 'Label',
  PRIMARY KEY (`status`,`store_id`),
  KEY `IDX_SALES_ORDER_STATUS_LABEL_STORE_ID` (`store_id`),
  CONSTRAINT `FK_SALES_ORDER_STATUS_LABEL_STATUS_SALES_ORDER_STATUS_STATUS` FOREIGN KEY (`status`) REFERENCES `sales_order_status` (`status`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_SALES_ORDER_STATUS_LABEL_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Order Status Label Table';



# Dump of table sales_order_status_state
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sales_order_status_state`;

CREATE TABLE `sales_order_status_state` (
  `status` varchar(32) NOT NULL COMMENT 'Status',
  `state` varchar(32) NOT NULL COMMENT 'Label',
  `is_default` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Default',
  PRIMARY KEY (`status`,`state`),
  CONSTRAINT `FK_SALES_ORDER_STATUS_STATE_STATUS_SALES_ORDER_STATUS_STATUS` FOREIGN KEY (`status`) REFERENCES `sales_order_status` (`status`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Order Status Table';

LOCK TABLES `sales_order_status_state` WRITE;
/*!40000 ALTER TABLE `sales_order_status_state` DISABLE KEYS */;

INSERT INTO `sales_order_status_state` (`status`, `state`, `is_default`)
VALUES
	('canceled','canceled',1),
	('closed','closed',1),
	('complete','complete',1),
	('fraud','payment_review',0),
	('holded','holded',1),
	('payment_review','payment_review',1),
	('pending','new',1),
	('pending_payment','pending_payment',1),
	('processing','processing',1);

/*!40000 ALTER TABLE `sales_order_status_state` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table sales_order_tax
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sales_order_tax`;

CREATE TABLE `sales_order_tax` (
  `tax_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Tax Id',
  `order_id` int(10) unsigned NOT NULL COMMENT 'Order Id',
  `code` varchar(255) DEFAULT NULL COMMENT 'Code',
  `title` varchar(255) DEFAULT NULL COMMENT 'Title',
  `percent` decimal(12,4) DEFAULT NULL COMMENT 'Percent',
  `amount` decimal(12,4) DEFAULT NULL COMMENT 'Amount',
  `priority` int(11) NOT NULL COMMENT 'Priority',
  `position` int(11) NOT NULL COMMENT 'Position',
  `base_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Amount',
  `process` smallint(6) NOT NULL COMMENT 'Process',
  `base_real_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Real Amount',
  `hidden` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Hidden',
  PRIMARY KEY (`tax_id`),
  KEY `IDX_SALES_ORDER_TAX_ORDER_ID_PRIORITY_POSITION` (`order_id`,`priority`,`position`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Order Tax Table';



# Dump of table sales_order_tax_item
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sales_order_tax_item`;

CREATE TABLE `sales_order_tax_item` (
  `tax_item_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Tax Item Id',
  `tax_id` int(10) unsigned NOT NULL COMMENT 'Tax Id',
  `item_id` int(10) unsigned NOT NULL COMMENT 'Item Id',
  `tax_percent` decimal(12,4) NOT NULL COMMENT 'Real Tax Percent For Item',
  PRIMARY KEY (`tax_item_id`),
  UNIQUE KEY `UNQ_SALES_ORDER_TAX_ITEM_TAX_ID_ITEM_ID` (`tax_id`,`item_id`),
  KEY `IDX_SALES_ORDER_TAX_ITEM_TAX_ID` (`tax_id`),
  KEY `IDX_SALES_ORDER_TAX_ITEM_ITEM_ID` (`item_id`),
  CONSTRAINT `FK_SALES_ORDER_TAX_ITEM_ITEM_ID_SALES_FLAT_ORDER_ITEM_ITEM_ID` FOREIGN KEY (`item_id`) REFERENCES `sales_flat_order_item` (`item_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_SALES_ORDER_TAX_ITEM_TAX_ID_SALES_ORDER_TAX_TAX_ID` FOREIGN KEY (`tax_id`) REFERENCES `sales_order_tax` (`tax_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Order Tax Item';



# Dump of table sales_payment_transaction
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sales_payment_transaction`;

CREATE TABLE `sales_payment_transaction` (
  `transaction_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Transaction Id',
  `parent_id` int(10) unsigned DEFAULT NULL COMMENT 'Parent Id',
  `order_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Order Id',
  `payment_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Payment Id',
  `txn_id` varchar(100) DEFAULT NULL COMMENT 'Txn Id',
  `parent_txn_id` varchar(100) DEFAULT NULL COMMENT 'Parent Txn Id',
  `txn_type` varchar(15) DEFAULT NULL COMMENT 'Txn Type',
  `is_closed` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Is Closed',
  `additional_information` blob COMMENT 'Additional Information',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Created At',
  PRIMARY KEY (`transaction_id`),
  UNIQUE KEY `UNQ_SALES_PAYMENT_TRANSACTION_ORDER_ID_PAYMENT_ID_TXN_ID` (`order_id`,`payment_id`,`txn_id`),
  KEY `IDX_SALES_PAYMENT_TRANSACTION_ORDER_ID` (`order_id`),
  KEY `IDX_SALES_PAYMENT_TRANSACTION_PARENT_ID` (`parent_id`),
  KEY `IDX_SALES_PAYMENT_TRANSACTION_PAYMENT_ID` (`payment_id`),
  CONSTRAINT `FK_SALES_PAYMENT_TRANSACTION_ORDER_ID_SALES_FLAT_ORDER_ENTITY_ID` FOREIGN KEY (`order_id`) REFERENCES `sales_flat_order` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_B99FF1A06402D725EBDB0F3A7ECD47A2` FOREIGN KEY (`parent_id`) REFERENCES `sales_payment_transaction` (`transaction_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_DA51A10B2405B64A4DAEF77A64F0DAAD` FOREIGN KEY (`payment_id`) REFERENCES `sales_flat_order_payment` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Payment Transaction';



# Dump of table sales_recurring_profile
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sales_recurring_profile`;

CREATE TABLE `sales_recurring_profile` (
  `profile_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Profile Id',
  `state` varchar(20) NOT NULL COMMENT 'State',
  `customer_id` int(10) unsigned DEFAULT NULL COMMENT 'Customer Id',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `method_code` varchar(32) NOT NULL COMMENT 'Method Code',
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Created At',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'Updated At',
  `reference_id` varchar(32) DEFAULT NULL COMMENT 'Reference Id',
  `subscriber_name` varchar(150) DEFAULT NULL COMMENT 'Subscriber Name',
  `start_datetime` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Start Datetime',
  `internal_reference_id` varchar(42) NOT NULL COMMENT 'Internal Reference Id',
  `schedule_description` varchar(255) NOT NULL COMMENT 'Schedule Description',
  `suspension_threshold` smallint(5) unsigned DEFAULT NULL COMMENT 'Suspension Threshold',
  `bill_failed_later` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Bill Failed Later',
  `period_unit` varchar(20) NOT NULL COMMENT 'Period Unit',
  `period_frequency` smallint(5) unsigned DEFAULT NULL COMMENT 'Period Frequency',
  `period_max_cycles` smallint(5) unsigned DEFAULT NULL COMMENT 'Period Max Cycles',
  `billing_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Billing Amount',
  `trial_period_unit` varchar(20) DEFAULT NULL COMMENT 'Trial Period Unit',
  `trial_period_frequency` smallint(5) unsigned DEFAULT NULL COMMENT 'Trial Period Frequency',
  `trial_period_max_cycles` smallint(5) unsigned DEFAULT NULL COMMENT 'Trial Period Max Cycles',
  `trial_billing_amount` text COMMENT 'Trial Billing Amount',
  `currency_code` varchar(3) NOT NULL COMMENT 'Currency Code',
  `shipping_amount` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Amount',
  `tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Tax Amount',
  `init_amount` decimal(12,4) DEFAULT NULL COMMENT 'Init Amount',
  `init_may_fail` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Init May Fail',
  `order_info` text NOT NULL COMMENT 'Order Info',
  `order_item_info` text NOT NULL COMMENT 'Order Item Info',
  `billing_address_info` text NOT NULL COMMENT 'Billing Address Info',
  `shipping_address_info` text COMMENT 'Shipping Address Info',
  `profile_vendor_info` text COMMENT 'Profile Vendor Info',
  `additional_info` text COMMENT 'Additional Info',
  PRIMARY KEY (`profile_id`),
  UNIQUE KEY `UNQ_SALES_RECURRING_PROFILE_INTERNAL_REFERENCE_ID` (`internal_reference_id`),
  KEY `IDX_SALES_RECURRING_PROFILE_CUSTOMER_ID` (`customer_id`),
  KEY `IDX_SALES_RECURRING_PROFILE_STORE_ID` (`store_id`),
  CONSTRAINT `FK_SALES_RECURRING_PROFILE_CUSTOMER_ID_CUSTOMER_ENTITY_ENTITY_ID` FOREIGN KEY (`customer_id`) REFERENCES `customer_entity` (`entity_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `FK_SALES_RECURRING_PROFILE_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Recurring Profile';



# Dump of table sales_recurring_profile_order
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sales_recurring_profile_order`;

CREATE TABLE `sales_recurring_profile_order` (
  `link_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Link Id',
  `profile_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Profile Id',
  `order_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Order Id',
  PRIMARY KEY (`link_id`),
  UNIQUE KEY `UNQ_SALES_RECURRING_PROFILE_ORDER_PROFILE_ID_ORDER_ID` (`profile_id`,`order_id`),
  KEY `IDX_SALES_RECURRING_PROFILE_ORDER_ORDER_ID` (`order_id`),
  CONSTRAINT `FK_7FF85741C66DCD37A4FBE3E3255A5A01` FOREIGN KEY (`order_id`) REFERENCES `sales_flat_order` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_B8A7A5397B67455786E55461748C59F4` FOREIGN KEY (`profile_id`) REFERENCES `sales_recurring_profile` (`profile_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Recurring Profile Order';



# Dump of table sales_refunded_aggregated
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sales_refunded_aggregated`;

CREATE TABLE `sales_refunded_aggregated` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `period` date DEFAULT NULL COMMENT 'Period',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `order_status` varchar(50) NOT NULL DEFAULT '' COMMENT 'Order Status',
  `orders_count` int(11) NOT NULL DEFAULT '0' COMMENT 'Orders Count',
  `refunded` decimal(12,4) DEFAULT NULL COMMENT 'Refunded',
  `online_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Online Refunded',
  `offline_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Offline Refunded',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNQ_SALES_REFUNDED_AGGREGATED_PERIOD_STORE_ID_ORDER_STATUS` (`period`,`store_id`,`order_status`),
  KEY `IDX_SALES_REFUNDED_AGGREGATED_STORE_ID` (`store_id`),
  CONSTRAINT `FK_SALES_REFUNDED_AGGREGATED_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Refunded Aggregated';



# Dump of table sales_refunded_aggregated_order
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sales_refunded_aggregated_order`;

CREATE TABLE `sales_refunded_aggregated_order` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `period` date DEFAULT NULL COMMENT 'Period',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `order_status` varchar(50) DEFAULT NULL COMMENT 'Order Status',
  `orders_count` int(11) NOT NULL DEFAULT '0' COMMENT 'Orders Count',
  `refunded` decimal(12,4) DEFAULT NULL COMMENT 'Refunded',
  `online_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Online Refunded',
  `offline_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Offline Refunded',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNQ_SALES_REFUNDED_AGGREGATED_ORDER_PERIOD_STORE_ID_ORDER_STATUS` (`period`,`store_id`,`order_status`),
  KEY `IDX_SALES_REFUNDED_AGGREGATED_ORDER_STORE_ID` (`store_id`),
  CONSTRAINT `FK_SALES_REFUNDED_AGGREGATED_ORDER_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Refunded Aggregated Order';



# Dump of table sales_shipping_aggregated
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sales_shipping_aggregated`;

CREATE TABLE `sales_shipping_aggregated` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `period` date DEFAULT NULL COMMENT 'Period',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `order_status` varchar(50) DEFAULT NULL COMMENT 'Order Status',
  `shipping_description` varchar(255) DEFAULT NULL COMMENT 'Shipping Description',
  `orders_count` int(11) NOT NULL DEFAULT '0' COMMENT 'Orders Count',
  `total_shipping` decimal(12,4) DEFAULT NULL COMMENT 'Total Shipping',
  `total_shipping_actual` decimal(12,4) DEFAULT NULL COMMENT 'Total Shipping Actual',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNQ_SALES_SHPP_AGGRED_PERIOD_STORE_ID_ORDER_STS_SHPP_DESCRIPTION` (`period`,`store_id`,`order_status`,`shipping_description`),
  KEY `IDX_SALES_SHIPPING_AGGREGATED_STORE_ID` (`store_id`),
  CONSTRAINT `FK_SALES_SHIPPING_AGGREGATED_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Shipping Aggregated';



# Dump of table sales_shipping_aggregated_order
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sales_shipping_aggregated_order`;

CREATE TABLE `sales_shipping_aggregated_order` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `period` date DEFAULT NULL COMMENT 'Period',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `order_status` varchar(50) DEFAULT NULL COMMENT 'Order Status',
  `shipping_description` varchar(255) DEFAULT NULL COMMENT 'Shipping Description',
  `orders_count` int(11) NOT NULL DEFAULT '0' COMMENT 'Orders Count',
  `total_shipping` decimal(12,4) DEFAULT NULL COMMENT 'Total Shipping',
  `total_shipping_actual` decimal(12,4) DEFAULT NULL COMMENT 'Total Shipping Actual',
  PRIMARY KEY (`id`),
  UNIQUE KEY `C05FAE47282EEA68654D0924E946761F` (`period`,`store_id`,`order_status`,`shipping_description`),
  KEY `IDX_SALES_SHIPPING_AGGREGATED_ORDER_STORE_ID` (`store_id`),
  CONSTRAINT `FK_SALES_SHIPPING_AGGREGATED_ORDER_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Shipping Aggregated Order';



# Dump of table salesrule
# ------------------------------------------------------------

DROP TABLE IF EXISTS `salesrule`;

CREATE TABLE `salesrule` (
  `rule_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Rule Id',
  `name` varchar(255) DEFAULT NULL COMMENT 'Name',
  `description` text COMMENT 'Description',
  `from_date` date DEFAULT NULL,
  `to_date` date DEFAULT NULL,
  `uses_per_customer` int(11) NOT NULL DEFAULT '0' COMMENT 'Uses Per Customer',
  `is_active` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Is Active',
  `conditions_serialized` mediumtext COMMENT 'Conditions Serialized',
  `actions_serialized` mediumtext COMMENT 'Actions Serialized',
  `stop_rules_processing` smallint(6) NOT NULL DEFAULT '1' COMMENT 'Stop Rules Processing',
  `is_advanced` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Is Advanced',
  `product_ids` text COMMENT 'Product Ids',
  `sort_order` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Sort Order',
  `simple_action` varchar(32) DEFAULT NULL COMMENT 'Simple Action',
  `discount_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Discount Amount',
  `discount_qty` decimal(12,4) DEFAULT NULL COMMENT 'Discount Qty',
  `discount_step` int(10) unsigned NOT NULL COMMENT 'Discount Step',
  `simple_free_shipping` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Simple Free Shipping',
  `apply_to_shipping` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Apply To Shipping',
  `times_used` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Times Used',
  `is_rss` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Is Rss',
  `coupon_type` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Coupon Type',
  `use_auto_generation` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Use Auto Generation',
  `uses_per_coupon` int(11) NOT NULL DEFAULT '0' COMMENT 'Uses Per Coupon',
  PRIMARY KEY (`rule_id`),
  KEY `IDX_SALESRULE_IS_ACTIVE_SORT_ORDER_TO_DATE_FROM_DATE` (`is_active`,`sort_order`,`to_date`,`from_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Salesrule';



# Dump of table salesrule_coupon
# ------------------------------------------------------------

DROP TABLE IF EXISTS `salesrule_coupon`;

CREATE TABLE `salesrule_coupon` (
  `coupon_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Coupon Id',
  `rule_id` int(10) unsigned NOT NULL COMMENT 'Rule Id',
  `code` varchar(255) DEFAULT NULL COMMENT 'Code',
  `usage_limit` int(10) unsigned DEFAULT NULL COMMENT 'Usage Limit',
  `usage_per_customer` int(10) unsigned DEFAULT NULL COMMENT 'Usage Per Customer',
  `times_used` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Times Used',
  `expiration_date` timestamp NULL DEFAULT NULL COMMENT 'Expiration Date',
  `is_primary` smallint(5) unsigned DEFAULT NULL COMMENT 'Is Primary',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Coupon Code Creation Date',
  `type` smallint(6) DEFAULT '0' COMMENT 'Coupon Code Type',
  PRIMARY KEY (`coupon_id`),
  UNIQUE KEY `UNQ_SALESRULE_COUPON_CODE` (`code`),
  UNIQUE KEY `UNQ_SALESRULE_COUPON_RULE_ID_IS_PRIMARY` (`rule_id`,`is_primary`),
  KEY `IDX_SALESRULE_COUPON_RULE_ID` (`rule_id`),
  CONSTRAINT `FK_SALESRULE_COUPON_RULE_ID_SALESRULE_RULE_ID` FOREIGN KEY (`rule_id`) REFERENCES `salesrule` (`rule_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Salesrule Coupon';



# Dump of table salesrule_coupon_usage
# ------------------------------------------------------------

DROP TABLE IF EXISTS `salesrule_coupon_usage`;

CREATE TABLE `salesrule_coupon_usage` (
  `coupon_id` int(10) unsigned NOT NULL COMMENT 'Coupon Id',
  `customer_id` int(10) unsigned NOT NULL COMMENT 'Customer Id',
  `times_used` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Times Used',
  PRIMARY KEY (`coupon_id`,`customer_id`),
  KEY `IDX_SALESRULE_COUPON_USAGE_COUPON_ID` (`coupon_id`),
  KEY `IDX_SALESRULE_COUPON_USAGE_CUSTOMER_ID` (`customer_id`),
  CONSTRAINT `FK_SALESRULE_COUPON_USAGE_COUPON_ID_SALESRULE_COUPON_COUPON_ID` FOREIGN KEY (`coupon_id`) REFERENCES `salesrule_coupon` (`coupon_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_SALESRULE_COUPON_USAGE_CUSTOMER_ID_CUSTOMER_ENTITY_ENTITY_ID` FOREIGN KEY (`customer_id`) REFERENCES `customer_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Salesrule Coupon Usage';



# Dump of table salesrule_customer
# ------------------------------------------------------------

DROP TABLE IF EXISTS `salesrule_customer`;

CREATE TABLE `salesrule_customer` (
  `rule_customer_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Rule Customer Id',
  `rule_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Rule Id',
  `customer_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Customer Id',
  `times_used` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Times Used',
  PRIMARY KEY (`rule_customer_id`),
  KEY `IDX_SALESRULE_CUSTOMER_RULE_ID_CUSTOMER_ID` (`rule_id`,`customer_id`),
  KEY `IDX_SALESRULE_CUSTOMER_CUSTOMER_ID_RULE_ID` (`customer_id`,`rule_id`),
  CONSTRAINT `FK_SALESRULE_CUSTOMER_CUSTOMER_ID_CUSTOMER_ENTITY_ENTITY_ID` FOREIGN KEY (`customer_id`) REFERENCES `customer_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_SALESRULE_CUSTOMER_RULE_ID_SALESRULE_RULE_ID` FOREIGN KEY (`rule_id`) REFERENCES `salesrule` (`rule_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Salesrule Customer';



# Dump of table salesrule_customer_group
# ------------------------------------------------------------

DROP TABLE IF EXISTS `salesrule_customer_group`;

CREATE TABLE `salesrule_customer_group` (
  `rule_id` int(10) unsigned NOT NULL COMMENT 'Rule Id',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group Id',
  PRIMARY KEY (`rule_id`,`customer_group_id`),
  KEY `IDX_SALESRULE_CUSTOMER_GROUP_RULE_ID` (`rule_id`),
  KEY `IDX_SALESRULE_CUSTOMER_GROUP_CUSTOMER_GROUP_ID` (`customer_group_id`),
  CONSTRAINT `FK_SALESRULE_CUSTOMER_GROUP_RULE_ID_SALESRULE_RULE_ID` FOREIGN KEY (`rule_id`) REFERENCES `salesrule` (`rule_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_SALESRULE_CSTR_GROUP_CSTR_GROUP_ID_CSTR_GROUP_CSTR_GROUP_ID` FOREIGN KEY (`customer_group_id`) REFERENCES `customer_group` (`customer_group_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Rules To Customer Groups Relations';



# Dump of table salesrule_label
# ------------------------------------------------------------

DROP TABLE IF EXISTS `salesrule_label`;

CREATE TABLE `salesrule_label` (
  `label_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Label Id',
  `rule_id` int(10) unsigned NOT NULL COMMENT 'Rule Id',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store Id',
  `label` varchar(255) DEFAULT NULL COMMENT 'Label',
  PRIMARY KEY (`label_id`),
  UNIQUE KEY `UNQ_SALESRULE_LABEL_RULE_ID_STORE_ID` (`rule_id`,`store_id`),
  KEY `IDX_SALESRULE_LABEL_STORE_ID` (`store_id`),
  KEY `IDX_SALESRULE_LABEL_RULE_ID` (`rule_id`),
  CONSTRAINT `FK_SALESRULE_LABEL_RULE_ID_SALESRULE_RULE_ID` FOREIGN KEY (`rule_id`) REFERENCES `salesrule` (`rule_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_SALESRULE_LABEL_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Salesrule Label';



# Dump of table salesrule_product_attribute
# ------------------------------------------------------------

DROP TABLE IF EXISTS `salesrule_product_attribute`;

CREATE TABLE `salesrule_product_attribute` (
  `rule_id` int(10) unsigned NOT NULL COMMENT 'Rule Id',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website Id',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group Id',
  `attribute_id` smallint(5) unsigned NOT NULL COMMENT 'Attribute Id',
  PRIMARY KEY (`rule_id`,`website_id`,`customer_group_id`,`attribute_id`),
  KEY `IDX_SALESRULE_PRODUCT_ATTRIBUTE_WEBSITE_ID` (`website_id`),
  KEY `IDX_SALESRULE_PRODUCT_ATTRIBUTE_CUSTOMER_GROUP_ID` (`customer_group_id`),
  KEY `IDX_SALESRULE_PRODUCT_ATTRIBUTE_ATTRIBUTE_ID` (`attribute_id`),
  CONSTRAINT `FK_SALESRULE_PRD_ATTR_ATTR_ID_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `FK_SALESRULE_PRD_ATTR_CSTR_GROUP_ID_CSTR_GROUP_CSTR_GROUP_ID` FOREIGN KEY (`customer_group_id`) REFERENCES `customer_group` (`customer_group_id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `FK_SALESRULE_PRODUCT_ATTRIBUTE_RULE_ID_SALESRULE_RULE_ID` FOREIGN KEY (`rule_id`) REFERENCES `salesrule` (`rule_id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `FK_SALESRULE_PRD_ATTR_WS_ID_CORE_WS_WS_ID` FOREIGN KEY (`website_id`) REFERENCES `core_website` (`website_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Salesrule Product Attribute';



# Dump of table salesrule_website
# ------------------------------------------------------------

DROP TABLE IF EXISTS `salesrule_website`;

CREATE TABLE `salesrule_website` (
  `rule_id` int(10) unsigned NOT NULL COMMENT 'Rule Id',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website Id',
  PRIMARY KEY (`rule_id`,`website_id`),
  KEY `IDX_SALESRULE_WEBSITE_RULE_ID` (`rule_id`),
  KEY `IDX_SALESRULE_WEBSITE_WEBSITE_ID` (`website_id`),
  CONSTRAINT `FK_SALESRULE_WEBSITE_RULE_ID_SALESRULE_RULE_ID` FOREIGN KEY (`rule_id`) REFERENCES `salesrule` (`rule_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_SALESRULE_WEBSITE_WEBSITE_ID_CORE_WEBSITE_WEBSITE_ID` FOREIGN KEY (`website_id`) REFERENCES `core_website` (`website_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Rules To Websites Relations';



# Dump of table sendfriend_log
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sendfriend_log`;

CREATE TABLE `sendfriend_log` (
  `log_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Log ID',
  `ip` varbinary(16) DEFAULT NULL,
  `time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Log time',
  `website_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Website ID',
  PRIMARY KEY (`log_id`),
  KEY `IDX_SENDFRIEND_LOG_IP` (`ip`),
  KEY `IDX_SENDFRIEND_LOG_TIME` (`time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Send to friend function log storage table';



# Dump of table shipping_tablerate
# ------------------------------------------------------------

DROP TABLE IF EXISTS `shipping_tablerate`;

CREATE TABLE `shipping_tablerate` (
  `pk` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary key',
  `website_id` int(11) NOT NULL DEFAULT '0' COMMENT 'Website Id',
  `dest_country_id` varchar(4) NOT NULL DEFAULT '0' COMMENT 'Destination coutry ISO/2 or ISO/3 code',
  `dest_region_id` int(11) NOT NULL DEFAULT '0' COMMENT 'Destination Region Id',
  `dest_zip` varchar(10) NOT NULL DEFAULT '*' COMMENT 'Destination Post Code (Zip)',
  `condition_name` varchar(20) NOT NULL COMMENT 'Rate Condition name',
  `condition_value` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Rate condition value',
  `price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Price',
  `cost` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Cost',
  PRIMARY KEY (`pk`),
  UNIQUE KEY `D60821CDB2AFACEE1566CFC02D0D4CAA` (`website_id`,`dest_country_id`,`dest_region_id`,`dest_zip`,`condition_name`,`condition_value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Shipping Tablerate';



# Dump of table sitemap
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sitemap`;

CREATE TABLE `sitemap` (
  `sitemap_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Sitemap Id',
  `sitemap_type` varchar(32) DEFAULT NULL COMMENT 'Sitemap Type',
  `sitemap_filename` varchar(32) DEFAULT NULL COMMENT 'Sitemap Filename',
  `sitemap_path` varchar(255) DEFAULT NULL COMMENT 'Sitemap Path',
  `sitemap_time` timestamp NULL DEFAULT NULL COMMENT 'Sitemap Time',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store id',
  PRIMARY KEY (`sitemap_id`),
  KEY `IDX_SITEMAP_STORE_ID` (`store_id`),
  CONSTRAINT `FK_SITEMAP_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Google Sitemap';



# Dump of table tag
# ------------------------------------------------------------

DROP TABLE IF EXISTS `tag`;

CREATE TABLE `tag` (
  `tag_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Tag Id',
  `name` varchar(255) DEFAULT NULL COMMENT 'Name',
  `status` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Status',
  `first_customer_id` int(10) unsigned DEFAULT NULL COMMENT 'First Customer Id',
  `first_store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'First Store Id',
  PRIMARY KEY (`tag_id`),
  KEY `FK_TAG_FIRST_CUSTOMER_ID_CUSTOMER_ENTITY_ENTITY_ID` (`first_customer_id`),
  KEY `FK_TAG_FIRST_STORE_ID_CORE_STORE_STORE_ID` (`first_store_id`),
  CONSTRAINT `FK_TAG_FIRST_CUSTOMER_ID_CUSTOMER_ENTITY_ENTITY_ID` FOREIGN KEY (`first_customer_id`) REFERENCES `customer_entity` (`entity_id`) ON DELETE SET NULL ON UPDATE NO ACTION,
  CONSTRAINT `FK_TAG_FIRST_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`first_store_id`) REFERENCES `core_store` (`store_id`) ON DELETE SET NULL ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tag';



# Dump of table tag_properties
# ------------------------------------------------------------

DROP TABLE IF EXISTS `tag_properties`;

CREATE TABLE `tag_properties` (
  `tag_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Tag Id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  `base_popularity` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Base Popularity',
  PRIMARY KEY (`tag_id`,`store_id`),
  KEY `IDX_TAG_PROPERTIES_STORE_ID` (`store_id`),
  CONSTRAINT `FK_TAG_PROPERTIES_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_TAG_PROPERTIES_TAG_ID_TAG_TAG_ID` FOREIGN KEY (`tag_id`) REFERENCES `tag` (`tag_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tag Properties';



# Dump of table tag_relation
# ------------------------------------------------------------

DROP TABLE IF EXISTS `tag_relation`;

CREATE TABLE `tag_relation` (
  `tag_relation_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Tag Relation Id',
  `tag_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Tag Id',
  `customer_id` int(10) unsigned DEFAULT NULL COMMENT 'Customer Id',
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product Id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Store Id',
  `active` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Active',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Created At',
  PRIMARY KEY (`tag_relation_id`),
  UNIQUE KEY `UNQ_TAG_RELATION_TAG_ID_CUSTOMER_ID_PRODUCT_ID_STORE_ID` (`tag_id`,`customer_id`,`product_id`,`store_id`),
  KEY `IDX_TAG_RELATION_PRODUCT_ID` (`product_id`),
  KEY `IDX_TAG_RELATION_TAG_ID` (`tag_id`),
  KEY `IDX_TAG_RELATION_CUSTOMER_ID` (`customer_id`),
  KEY `IDX_TAG_RELATION_STORE_ID` (`store_id`),
  CONSTRAINT `FK_TAG_RELATION_CUSTOMER_ID_CUSTOMER_ENTITY_ENTITY_ID` FOREIGN KEY (`customer_id`) REFERENCES `customer_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_TAG_RELATION_PRODUCT_ID_CATALOG_PRODUCT_ENTITY_ENTITY_ID` FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_TAG_RELATION_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_TAG_RELATION_TAG_ID_TAG_TAG_ID` FOREIGN KEY (`tag_id`) REFERENCES `tag` (`tag_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tag Relation';



# Dump of table tag_summary
# ------------------------------------------------------------

DROP TABLE IF EXISTS `tag_summary`;

CREATE TABLE `tag_summary` (
  `tag_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Tag Id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  `customers` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Customers',
  `products` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Products',
  `uses` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Uses',
  `historical_uses` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Historical Uses',
  `popularity` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Popularity',
  `base_popularity` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Base Popularity',
  PRIMARY KEY (`tag_id`,`store_id`),
  KEY `IDX_TAG_SUMMARY_STORE_ID` (`store_id`),
  KEY `IDX_TAG_SUMMARY_TAG_ID` (`tag_id`),
  CONSTRAINT `FK_TAG_SUMMARY_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_TAG_SUMMARY_TAG_ID_TAG_TAG_ID` FOREIGN KEY (`tag_id`) REFERENCES `tag` (`tag_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tag Summary';



# Dump of table tax_calculation
# ------------------------------------------------------------

DROP TABLE IF EXISTS `tax_calculation`;

CREATE TABLE `tax_calculation` (
  `tax_calculation_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Tax Calculation Id',
  `tax_calculation_rate_id` int(11) NOT NULL COMMENT 'Tax Calculation Rate Id',
  `tax_calculation_rule_id` int(11) NOT NULL COMMENT 'Tax Calculation Rule Id',
  `customer_tax_class_id` smallint(6) NOT NULL COMMENT 'Customer Tax Class Id',
  `product_tax_class_id` smallint(6) NOT NULL COMMENT 'Product Tax Class Id',
  PRIMARY KEY (`tax_calculation_id`),
  KEY `IDX_TAX_CALCULATION_TAX_CALCULATION_RULE_ID` (`tax_calculation_rule_id`),
  KEY `IDX_TAX_CALCULATION_TAX_CALCULATION_RATE_ID` (`tax_calculation_rate_id`),
  KEY `IDX_TAX_CALCULATION_CUSTOMER_TAX_CLASS_ID` (`customer_tax_class_id`),
  KEY `IDX_TAX_CALCULATION_PRODUCT_TAX_CLASS_ID` (`product_tax_class_id`),
  KEY `IDX_TAX_CALC_TAX_CALC_RATE_ID_CSTR_TAX_CLASS_ID_PRD_TAX_CLASS_ID` (`tax_calculation_rate_id`,`customer_tax_class_id`,`product_tax_class_id`),
  CONSTRAINT `FK_TAX_CALCULATION_PRODUCT_TAX_CLASS_ID_TAX_CLASS_CLASS_ID` FOREIGN KEY (`product_tax_class_id`) REFERENCES `tax_class` (`class_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_TAX_CALCULATION_CUSTOMER_TAX_CLASS_ID_TAX_CLASS_CLASS_ID` FOREIGN KEY (`customer_tax_class_id`) REFERENCES `tax_class` (`class_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_TAX_CALC_TAX_CALC_RATE_ID_TAX_CALC_RATE_TAX_CALC_RATE_ID` FOREIGN KEY (`tax_calculation_rate_id`) REFERENCES `tax_calculation_rate` (`tax_calculation_rate_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_TAX_CALC_TAX_CALC_RULE_ID_TAX_CALC_RULE_TAX_CALC_RULE_ID` FOREIGN KEY (`tax_calculation_rule_id`) REFERENCES `tax_calculation_rule` (`tax_calculation_rule_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tax Calculation';

LOCK TABLES `tax_calculation` WRITE;
/*!40000 ALTER TABLE `tax_calculation` DISABLE KEYS */;

INSERT INTO `tax_calculation` (`tax_calculation_id`, `tax_calculation_rate_id`, `tax_calculation_rule_id`, `customer_tax_class_id`, `product_tax_class_id`)
VALUES
	(1,1,1,3,2),
	(2,2,1,3,2);

/*!40000 ALTER TABLE `tax_calculation` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table tax_calculation_rate
# ------------------------------------------------------------

DROP TABLE IF EXISTS `tax_calculation_rate`;

CREATE TABLE `tax_calculation_rate` (
  `tax_calculation_rate_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Tax Calculation Rate Id',
  `tax_country_id` varchar(2) NOT NULL COMMENT 'Tax Country Id',
  `tax_region_id` int(11) NOT NULL COMMENT 'Tax Region Id',
  `tax_postcode` varchar(21) DEFAULT NULL COMMENT 'Tax Postcode',
  `code` varchar(255) NOT NULL COMMENT 'Code',
  `rate` decimal(12,4) NOT NULL COMMENT 'Rate',
  `zip_is_range` smallint(6) DEFAULT NULL COMMENT 'Zip Is Range',
  `zip_from` int(10) unsigned DEFAULT NULL COMMENT 'Zip From',
  `zip_to` int(10) unsigned DEFAULT NULL COMMENT 'Zip To',
  PRIMARY KEY (`tax_calculation_rate_id`),
  KEY `IDX_TAX_CALC_RATE_TAX_COUNTRY_ID_TAX_REGION_ID_TAX_POSTCODE` (`tax_country_id`,`tax_region_id`,`tax_postcode`),
  KEY `IDX_TAX_CALCULATION_RATE_CODE` (`code`),
  KEY `CA799F1E2CB843495F601E56C84A626D` (`tax_calculation_rate_id`,`tax_country_id`,`tax_region_id`,`zip_is_range`,`tax_postcode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tax Calculation Rate';

LOCK TABLES `tax_calculation_rate` WRITE;
/*!40000 ALTER TABLE `tax_calculation_rate` DISABLE KEYS */;

INSERT INTO `tax_calculation_rate` (`tax_calculation_rate_id`, `tax_country_id`, `tax_region_id`, `tax_postcode`, `code`, `rate`, `zip_is_range`, `zip_from`, `zip_to`)
VALUES
	(1,'US',12,'*','US-CA-*-Rate 1',8.2500,NULL,NULL,NULL),
	(2,'US',43,'*','US-NY-*-Rate 1',8.3750,NULL,NULL,NULL);

/*!40000 ALTER TABLE `tax_calculation_rate` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table tax_calculation_rate_title
# ------------------------------------------------------------

DROP TABLE IF EXISTS `tax_calculation_rate_title`;

CREATE TABLE `tax_calculation_rate_title` (
  `tax_calculation_rate_title_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Tax Calculation Rate Title Id',
  `tax_calculation_rate_id` int(11) NOT NULL COMMENT 'Tax Calculation Rate Id',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store Id',
  `value` varchar(255) NOT NULL COMMENT 'Value',
  PRIMARY KEY (`tax_calculation_rate_title_id`),
  KEY `IDX_TAX_CALCULATION_RATE_TITLE_TAX_CALCULATION_RATE_ID_STORE_ID` (`tax_calculation_rate_id`,`store_id`),
  KEY `IDX_TAX_CALCULATION_RATE_TITLE_TAX_CALCULATION_RATE_ID` (`tax_calculation_rate_id`),
  KEY `IDX_TAX_CALCULATION_RATE_TITLE_STORE_ID` (`store_id`),
  CONSTRAINT `FK_TAX_CALCULATION_RATE_TITLE_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_37FB965F786AD5897BB3AE90470C42AB` FOREIGN KEY (`tax_calculation_rate_id`) REFERENCES `tax_calculation_rate` (`tax_calculation_rate_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tax Calculation Rate Title';



# Dump of table tax_calculation_rule
# ------------------------------------------------------------

DROP TABLE IF EXISTS `tax_calculation_rule`;

CREATE TABLE `tax_calculation_rule` (
  `tax_calculation_rule_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Tax Calculation Rule Id',
  `code` varchar(255) NOT NULL COMMENT 'Code',
  `priority` int(11) NOT NULL COMMENT 'Priority',
  `position` int(11) NOT NULL COMMENT 'Position',
  `calculate_subtotal` int(11) NOT NULL COMMENT 'Calculate off subtotal option',
  PRIMARY KEY (`tax_calculation_rule_id`),
  KEY `IDX_TAX_CALC_RULE_PRIORITY_POSITION_TAX_CALC_RULE_ID` (`priority`,`position`,`tax_calculation_rule_id`),
  KEY `IDX_TAX_CALCULATION_RULE_CODE` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tax Calculation Rule';

LOCK TABLES `tax_calculation_rule` WRITE;
/*!40000 ALTER TABLE `tax_calculation_rule` DISABLE KEYS */;

INSERT INTO `tax_calculation_rule` (`tax_calculation_rule_id`, `code`, `priority`, `position`, `calculate_subtotal`)
VALUES
	(1,'Retail Customer-Taxable Goods-Rate 1',1,1,0);

/*!40000 ALTER TABLE `tax_calculation_rule` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table tax_class
# ------------------------------------------------------------

DROP TABLE IF EXISTS `tax_class`;

CREATE TABLE `tax_class` (
  `class_id` smallint(6) NOT NULL AUTO_INCREMENT COMMENT 'Class Id',
  `class_name` varchar(255) NOT NULL COMMENT 'Class Name',
  `class_type` varchar(8) NOT NULL DEFAULT 'CUSTOMER' COMMENT 'Class Type',
  PRIMARY KEY (`class_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tax Class';

LOCK TABLES `tax_class` WRITE;
/*!40000 ALTER TABLE `tax_class` DISABLE KEYS */;

INSERT INTO `tax_class` (`class_id`, `class_name`, `class_type`)
VALUES
	(2,'Taxable Goods','PRODUCT'),
	(3,'Retail Customer','CUSTOMER'),
	(4,'Shipping','PRODUCT');

/*!40000 ALTER TABLE `tax_class` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table tax_order_aggregated_created
# ------------------------------------------------------------

DROP TABLE IF EXISTS `tax_order_aggregated_created`;

CREATE TABLE `tax_order_aggregated_created` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `period` date DEFAULT NULL COMMENT 'Period',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `code` varchar(255) NOT NULL COMMENT 'Code',
  `order_status` varchar(50) NOT NULL COMMENT 'Order Status',
  `percent` float DEFAULT NULL COMMENT 'Percent',
  `orders_count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Orders Count',
  `tax_base_amount_sum` float DEFAULT NULL COMMENT 'Tax Base Amount Sum',
  PRIMARY KEY (`id`),
  UNIQUE KEY `FCA5E2C02689EB2641B30580D7AACF12` (`period`,`store_id`,`code`,`percent`,`order_status`),
  KEY `IDX_TAX_ORDER_AGGREGATED_CREATED_STORE_ID` (`store_id`),
  CONSTRAINT `FK_TAX_ORDER_AGGREGATED_CREATED_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tax Order Aggregation';



# Dump of table tax_order_aggregated_updated
# ------------------------------------------------------------

DROP TABLE IF EXISTS `tax_order_aggregated_updated`;

CREATE TABLE `tax_order_aggregated_updated` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `period` date DEFAULT NULL COMMENT 'Period',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `code` varchar(255) NOT NULL COMMENT 'Code',
  `order_status` varchar(50) NOT NULL COMMENT 'Order Status',
  `percent` float DEFAULT NULL COMMENT 'Percent',
  `orders_count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Orders Count',
  `tax_base_amount_sum` float DEFAULT NULL COMMENT 'Tax Base Amount Sum',
  PRIMARY KEY (`id`),
  UNIQUE KEY `DB0AF14011199AA6CD31D5078B90AA8D` (`period`,`store_id`,`code`,`percent`,`order_status`),
  KEY `IDX_TAX_ORDER_AGGREGATED_UPDATED_STORE_ID` (`store_id`),
  CONSTRAINT `FK_TAX_ORDER_AGGREGATED_UPDATED_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tax Order Aggregated Updated';



# Dump of table themeframework_area
# ------------------------------------------------------------

DROP TABLE IF EXISTS `themeframework_area`;

CREATE TABLE `themeframework_area` (
  `area_id` smallint(6) NOT NULL AUTO_INCREMENT COMMENT 'Area ID',
  `package_theme` varchar(100) DEFAULT NULL COMMENT 'Package Theme',
  `layout` varchar(100) DEFAULT NULL COMMENT 'Layout',
  `content` mediumtext COMMENT 'Area Content',
  `creation_time` timestamp NULL DEFAULT NULL COMMENT 'Area Creation Time',
  `update_time` timestamp NULL DEFAULT NULL COMMENT 'Area Modification Time',
  `is_active` smallint(6) NOT NULL DEFAULT '1' COMMENT 'Is Area Active',
  PRIMARY KEY (`area_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='EM ThemeFramework Area Table';

LOCK TABLES `themeframework_area` WRITE;
/*!40000 ALTER TABLE `themeframework_area` DISABLE KEYS */;

INSERT INTO `themeframework_area` (`area_id`, `package_theme`, `layout`, `content`, `creation_time`, `update_time`, `is_active`)
VALUES
	(1,'default/em0120','1column','a:9:{i:0;a:6:{s:10:\"custom_css\";s:9:\"em-header\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:4:\"type\";s:14:\"container_free\";s:5:\"items\";a:1:{i:0;s:6:\"header\";}}i:1;a:6:{s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:43:\"<div class=\"em-shipping\"> {{content}}</div>\";s:13:\"display_empty\";b:0;s:4:\"type\";s:12:\"container_24\";s:5:\"items\";a:2:{i:0;a:11:{s:6:\"column\";s:2:\"24\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:3:{i:0;s:8:\"em_area1\";i:1;s:15:\"global_messages\";i:2;s:11:\"breadcrumbs\";}}i:1;s:5:\"clear\";}}i:2;a:6:{s:10:\"custom_css\";s:12:\"em-slideshow\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:52:\"<div class=\"em-slideshow-wrapper\"> {{content}}</div>\";s:13:\"display_empty\";b:0;s:4:\"type\";s:12:\"container_24\";s:5:\"items\";a:1:{i:0;a:11:{s:6:\"column\";s:2:\"24\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:1:{i:0;s:8:\"em_area2\";}}}}i:3;a:6:{s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:41:\"<div class=\"em-content\">{{content}}</div>\";s:13:\"display_empty\";b:0;s:4:\"type\";s:12:\"container_24\";s:5:\"items\";a:3:{i:0;a:11:{s:6:\"column\";s:2:\"24\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:7:\"em-main\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:3:{i:0;s:8:\"em_area3\";i:1;s:7:\"content\";i:2;s:8:\"em_area4\";}}i:1;s:5:\"clear\";i:2;a:11:{s:6:\"column\";s:2:\"24\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:1:{i:0;s:8:\"em_area5\";}}}}i:4;a:6:{s:10:\"custom_css\";s:9:\"em-banner\";s:10:\"inner_html\";s:92:\"<div class=\"container\"><div class=\"row\"><div class=\"col-sm-24\">{{content}}</div></div></div>\";s:10:\"outer_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:4:\"type\";s:14:\"container_free\";s:5:\"items\";a:1:{i:0;s:8:\"em_area6\";}}i:5;a:6:{s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:49:\"<div class=\"em-content-bottom\"> {{content}}</div>\";s:13:\"display_empty\";b:0;s:4:\"type\";s:12:\"container_24\";s:5:\"items\";a:5:{i:0;a:11:{s:6:\"column\";s:2:\"16\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:1:{i:0;s:8:\"em_area7\";}}i:1;a:11:{s:6:\"column\";s:1:\"8\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:1:{i:0;s:8:\"em_area8\";}}i:2;s:5:\"clear\";i:3;a:11:{s:6:\"column\";s:2:\"24\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:2:{i:0;s:9:\"em_area16\";i:1;s:8:\"em_area9\";}}i:4;s:5:\"clear\";}}i:6;a:6:{s:10:\"custom_css\";s:19:\"em-promotion-banner\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:4:\"type\";s:14:\"container_free\";s:5:\"items\";a:1:{i:0;s:9:\"em_area17\";}}i:7;a:6:{s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:40:\"<div class=\"em-footer\">{{content}}</div>\";s:13:\"display_empty\";b:0;s:4:\"type\";s:12:\"container_24\";s:5:\"items\";a:1:{i:0;a:11:{s:6:\"column\";s:2:\"24\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:3:{i:0;s:9:\"em_area10\";i:1;s:9:\"em_area15\";i:2;s:6:\"footer\";}}}}i:8;a:6:{s:10:\"custom_css\";s:14:\"em-page-bottom\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:4:\"type\";s:14:\"container_free\";s:5:\"items\";a:1:{i:0;s:15:\"before_body_end\";}}}','2015-10-02 19:29:34','2015-10-02 19:29:34',1),
	(2,'default/em0120','2columns-left','a:9:{i:0;a:6:{s:10:\"custom_css\";s:9:\"em-header\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:4:\"type\";s:14:\"container_free\";s:5:\"items\";a:1:{i:0;s:6:\"header\";}}i:1;a:6:{s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:43:\"<div class=\"em-shipping\"> {{content}}</div>\";s:13:\"display_empty\";b:0;s:4:\"type\";s:12:\"container_24\";s:5:\"items\";a:2:{i:0;a:11:{s:6:\"column\";s:2:\"24\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:3:{i:0;s:8:\"em_area1\";i:1;s:15:\"global_messages\";i:2;s:11:\"breadcrumbs\";}}i:1;s:5:\"clear\";}}i:2;a:6:{s:10:\"custom_css\";s:13:\"em-slideshow \";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:52:\"<div class=\"em-slideshow-wrapper\"> {{content}}</div>\";s:13:\"display_empty\";b:0;s:4:\"type\";s:12:\"container_24\";s:5:\"items\";a:1:{i:0;a:11:{s:6:\"column\";s:2:\"24\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:1:{i:0;s:8:\"em_area2\";}}}}i:3;a:6:{s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:41:\"<div class=\"em-content\">{{content}}</div>\";s:13:\"display_empty\";b:0;s:4:\"type\";s:12:\"container_24\";s:5:\"items\";a:4:{i:0;a:11:{s:6:\"column\";s:2:\"18\";s:4:\"push\";s:1:\"6\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:7:\"em-main\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:3:{i:0;s:8:\"em_area3\";i:1;s:7:\"content\";i:2;s:8:\"em_area4\";}}i:1;a:11:{s:6:\"column\";s:1:\"6\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:2:\"18\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:7:\"em-left\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:3:{i:0;s:9:\"em_area11\";i:1;s:4:\"left\";i:2;s:9:\"em_area12\";}}i:2;s:5:\"clear\";i:3;a:11:{s:6:\"column\";s:2:\"24\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:1:{i:0;s:8:\"em_area5\";}}}}i:4;a:6:{s:10:\"custom_css\";s:9:\"em-banner\";s:10:\"inner_html\";s:92:\"<div class=\"container\"><div class=\"row\"><div class=\"col-sm-24\">{{content}}</div></div></div>\";s:10:\"outer_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:4:\"type\";s:14:\"container_free\";s:5:\"items\";a:1:{i:0;s:8:\"em_area6\";}}i:5;a:6:{s:10:\"custom_css\";s:17:\"em-content-bottom\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:49:\"<div class=\"em-content-bottom\"> {{content}}</div>\";s:13:\"display_empty\";b:0;s:4:\"type\";s:12:\"container_24\";s:5:\"items\";a:5:{i:0;a:11:{s:6:\"column\";s:2:\"16\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:1:{i:0;s:8:\"em_area7\";}}i:1;a:11:{s:6:\"column\";s:1:\"8\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:1:{i:0;s:8:\"em_area8\";}}i:2;s:5:\"clear\";i:3;a:11:{s:6:\"column\";s:2:\"24\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:2:{i:0;s:9:\"em_area16\";i:1;s:8:\"em_area9\";}}i:4;s:5:\"clear\";}}i:6;a:6:{s:10:\"custom_css\";s:19:\"em-promotion-banner\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:4:\"type\";s:14:\"container_free\";s:5:\"items\";a:1:{i:0;s:9:\"em_area17\";}}i:7;a:6:{s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:40:\"<div class=\"em-footer\">{{content}}</div>\";s:13:\"display_empty\";b:0;s:4:\"type\";s:12:\"container_24\";s:5:\"items\";a:1:{i:0;a:11:{s:6:\"column\";s:2:\"24\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:3:{i:0;s:9:\"em_area10\";i:1;s:9:\"em_area15\";i:2;s:6:\"footer\";}}}}i:8;a:6:{s:10:\"custom_css\";s:14:\"em-page-bottom\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:4:\"type\";s:14:\"container_free\";s:5:\"items\";a:1:{i:0;s:15:\"before_body_end\";}}}','2015-10-02 19:29:36','2015-10-02 19:29:36',1),
	(3,'default/em0120','3columns','a:9:{i:0;a:6:{s:10:\"custom_css\";s:9:\"em-header\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:4:\"type\";s:14:\"container_free\";s:5:\"items\";a:1:{i:0;s:6:\"header\";}}i:1;a:6:{s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:43:\"<div class=\"em-shipping\"> {{content}}</div>\";s:13:\"display_empty\";b:0;s:4:\"type\";s:12:\"container_24\";s:5:\"items\";a:2:{i:0;a:11:{s:6:\"column\";s:2:\"24\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:3:{i:0;s:8:\"em_area1\";i:1;s:15:\"global_messages\";i:2;s:11:\"breadcrumbs\";}}i:1;s:5:\"clear\";}}i:2;a:6:{s:10:\"custom_css\";s:12:\"em-slideshow\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:52:\"<div class=\"em-slideshow-wrapper\"> {{content}}</div>\";s:13:\"display_empty\";b:0;s:4:\"type\";s:12:\"container_24\";s:5:\"items\";a:1:{i:0;a:11:{s:6:\"column\";s:2:\"24\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:1:{i:0;s:8:\"em_area2\";}}}}i:3;a:6:{s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:41:\"<div class=\"em-content\">{{content}}</div>\";s:13:\"display_empty\";b:0;s:4:\"type\";s:12:\"container_24\";s:5:\"items\";a:5:{i:0;a:11:{s:6:\"column\";s:2:\"12\";s:4:\"push\";s:1:\"6\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:7:\"em-main\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:3:{i:0;s:8:\"em_area3\";i:1;s:7:\"content\";i:2;s:8:\"em_area4\";}}i:1;a:11:{s:6:\"column\";s:1:\"6\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:2:\"12\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:7:\"em-left\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:3:{i:0;s:9:\"em_area11\";i:1;s:4:\"left\";i:2;s:9:\"em_area12\";}}i:2;a:11:{s:6:\"column\";s:1:\"6\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:8:\"em-right\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:3:{i:0;s:9:\"em_area13\";i:1;s:5:\"right\";i:2;s:9:\"em_area14\";}}i:3;s:5:\"clear\";i:4;a:11:{s:6:\"column\";s:2:\"24\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:1:{i:0;s:8:\"em_area5\";}}}}i:4;a:6:{s:10:\"custom_css\";s:9:\"em-banner\";s:10:\"inner_html\";s:92:\"<div class=\"container\"><div class=\"row\"><div class=\"col-sm-24\">{{content}}</div></div></div>\";s:10:\"outer_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:4:\"type\";s:14:\"container_free\";s:5:\"items\";a:1:{i:0;s:8:\"em_area6\";}}i:5;a:6:{s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:49:\"<div class=\"em-content-bottom\"> {{content}}</div>\";s:13:\"display_empty\";b:0;s:4:\"type\";s:12:\"container_24\";s:5:\"items\";a:5:{i:0;a:11:{s:6:\"column\";s:2:\"16\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:1:{i:0;s:8:\"em_area7\";}}i:1;a:11:{s:6:\"column\";s:1:\"8\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:1:{i:0;s:8:\"em_area8\";}}i:2;s:5:\"clear\";i:3;a:11:{s:6:\"column\";s:2:\"24\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:2:{i:0;s:9:\"em_area16\";i:1;s:8:\"em_area9\";}}i:4;s:5:\"clear\";}}i:6;a:6:{s:10:\"custom_css\";s:19:\"em-promotion-banner\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:4:\"type\";s:14:\"container_free\";s:5:\"items\";a:1:{i:0;s:9:\"em_area17\";}}i:7;a:6:{s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:41:\" <div class=\"em-footer\">{{content}}</div>\";s:13:\"display_empty\";b:0;s:4:\"type\";s:12:\"container_24\";s:5:\"items\";a:1:{i:0;a:11:{s:6:\"column\";s:2:\"24\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:3:{i:0;s:9:\"em_area10\";i:1;s:9:\"em_area15\";i:2;s:6:\"footer\";}}}}i:8;a:6:{s:10:\"custom_css\";s:14:\"em-page-bottom\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:4:\"type\";s:14:\"container_free\";s:5:\"items\";a:1:{i:0;s:15:\"before_body_end\";}}}','2015-10-02 19:29:37','2015-10-02 19:29:37',1),
	(4,'default/em0120','2columns-right','a:9:{i:0;a:6:{s:10:\"custom_css\";s:9:\"em-header\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:4:\"type\";s:14:\"container_free\";s:5:\"items\";a:1:{i:0;s:6:\"header\";}}i:1;a:6:{s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:43:\"<div class=\"em-shipping\"> {{content}}</div>\";s:13:\"display_empty\";b:0;s:4:\"type\";s:12:\"container_24\";s:5:\"items\";a:2:{i:0;a:11:{s:6:\"column\";s:2:\"24\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:3:{i:0;s:8:\"em_area1\";i:1;s:15:\"global_messages\";i:2;s:11:\"breadcrumbs\";}}i:1;s:5:\"clear\";}}i:2;a:6:{s:10:\"custom_css\";s:12:\"em-slideshow\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:52:\"<div class=\"em-slideshow-wrapper\"> {{content}}</div>\";s:13:\"display_empty\";b:0;s:4:\"type\";s:12:\"container_24\";s:5:\"items\";a:1:{i:0;a:11:{s:6:\"column\";s:2:\"24\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:1:{i:0;s:8:\"em_area2\";}}}}i:3;a:6:{s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:41:\"<div class=\"em-content\">{{content}}</div>\";s:13:\"display_empty\";b:0;s:4:\"type\";s:12:\"container_24\";s:5:\"items\";a:4:{i:0;a:11:{s:6:\"column\";s:2:\"18\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:7:\"em-main\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:3:{i:0;s:8:\"em_area3\";i:1;s:7:\"content\";i:2;s:8:\"em_area4\";}}i:1;a:11:{s:6:\"column\";s:1:\"6\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:8:\"em-right\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:3:{i:0;s:9:\"em_area13\";i:1;s:5:\"right\";i:2;s:9:\"em_area14\";}}i:2;s:5:\"clear\";i:3;a:11:{s:6:\"column\";s:2:\"24\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:1:{i:0;s:8:\"em_area5\";}}}}i:4;a:6:{s:10:\"custom_css\";s:9:\"em-banner\";s:10:\"inner_html\";s:92:\"<div class=\"container\"><div class=\"row\"><div class=\"col-sm-24\">{{content}}</div></div></div>\";s:10:\"outer_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:4:\"type\";s:14:\"container_free\";s:5:\"items\";a:1:{i:0;s:8:\"em_area6\";}}i:5;a:6:{s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:49:\"<div class=\"em-content-bottom\"> {{content}}</div>\";s:13:\"display_empty\";b:0;s:4:\"type\";s:12:\"container_24\";s:5:\"items\";a:5:{i:0;a:11:{s:6:\"column\";s:2:\"16\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:1:{i:0;s:8:\"em_area7\";}}i:1;a:11:{s:6:\"column\";s:1:\"8\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:1:{i:0;s:8:\"em_area8\";}}i:2;s:5:\"clear\";i:3;a:11:{s:6:\"column\";s:2:\"24\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:2:{i:0;s:9:\"em_area16\";i:1;s:8:\"em_area9\";}}i:4;s:5:\"clear\";}}i:6;a:6:{s:10:\"custom_css\";s:19:\"em-promotion-banner\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:4:\"type\";s:14:\"container_free\";s:5:\"items\";a:1:{i:0;s:9:\"em_area17\";}}i:7;a:6:{s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:40:\"<div class=\"em-footer\">{{content}}</div>\";s:13:\"display_empty\";b:0;s:4:\"type\";s:12:\"container_24\";s:5:\"items\";a:1:{i:0;a:11:{s:6:\"column\";s:2:\"24\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:3:{i:0;s:9:\"em_area10\";i:1;s:9:\"em_area15\";i:2;s:6:\"footer\";}}}}i:8;a:6:{s:10:\"custom_css\";s:14:\"em-page-bottom\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:4:\"type\";s:14:\"container_free\";s:5:\"items\";a:1:{i:0;s:15:\"before_body_end\";}}}','2015-10-02 19:29:38','2015-10-02 19:29:38',1),
	(5,'default/em0120','1column','a:10:{i:0;a:6:{s:10:\"custom_css\";s:9:\"em-header\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:4:\"type\";s:14:\"container_free\";s:5:\"items\";a:1:{i:0;s:6:\"header\";}}i:1;a:6:{s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:43:\"<div class=\"em-shipping\"> {{content}}</div>\";s:13:\"display_empty\";b:0;s:4:\"type\";s:12:\"container_24\";s:5:\"items\";a:2:{i:0;a:11:{s:6:\"column\";s:2:\"24\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:3:{i:0;s:8:\"em_area1\";i:1;s:15:\"global_messages\";i:2;s:11:\"breadcrumbs\";}}i:1;s:5:\"clear\";}}i:2;a:6:{s:10:\"custom_css\";s:12:\"em-slideshow\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:52:\"<div class=\"em-slideshow-wrapper\"> {{content}}</div>\";s:13:\"display_empty\";b:0;s:4:\"type\";s:12:\"container_24\";s:5:\"items\";a:1:{i:0;a:11:{s:6:\"column\";s:2:\"24\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:1:{i:0;s:8:\"em_area2\";}}}}i:3;a:6:{s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:41:\"<div class=\"em-content\">{{content}}</div>\";s:13:\"display_empty\";b:0;s:4:\"type\";s:12:\"container_24\";s:5:\"items\";a:2:{i:0;a:11:{s:6:\"column\";s:2:\"24\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:7:\"em-main\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:3:{i:0;s:8:\"em_area3\";i:1;s:7:\"content\";i:2;s:8:\"em_area4\";}}i:1;s:5:\"clear\";}}i:4;a:6:{s:10:\"custom_css\";s:11:\"em-products\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:4:\"type\";s:14:\"container_free\";s:5:\"items\";a:1:{i:0;s:8:\"em_area5\";}}i:5;a:6:{s:10:\"custom_css\";s:9:\"em-banner\";s:10:\"inner_html\";s:92:\"<div class=\"container\"><div class=\"row\"><div class=\"col-sm-24\">{{content}}</div></div></div>\";s:10:\"outer_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:4:\"type\";s:14:\"container_free\";s:5:\"items\";a:1:{i:0;s:8:\"em_area6\";}}i:6;a:6:{s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:49:\"<div class=\"em-content-bottom\"> {{content}}</div>\";s:13:\"display_empty\";b:0;s:4:\"type\";s:12:\"container_24\";s:5:\"items\";a:5:{i:0;a:11:{s:6:\"column\";s:2:\"16\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:1:{i:0;s:8:\"em_area7\";}}i:1;a:11:{s:6:\"column\";s:1:\"8\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:1:{i:0;s:8:\"em_area8\";}}i:2;s:5:\"clear\";i:3;a:11:{s:6:\"column\";s:2:\"24\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:2:{i:0;s:9:\"em_area16\";i:1;s:8:\"em_area9\";}}i:4;s:5:\"clear\";}}i:7;a:6:{s:10:\"custom_css\";s:19:\"em-promotion-banner\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:4:\"type\";s:14:\"container_free\";s:5:\"items\";a:1:{i:0;s:9:\"em_area17\";}}i:8;a:6:{s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:40:\"<div class=\"em-footer\">{{content}}</div>\";s:13:\"display_empty\";b:0;s:4:\"type\";s:12:\"container_24\";s:5:\"items\";a:1:{i:0;a:11:{s:6:\"column\";s:2:\"24\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:3:{i:0;s:9:\"em_area10\";i:1;s:9:\"em_area15\";i:2;s:6:\"footer\";}}}}i:9;a:6:{s:10:\"custom_css\";s:14:\"em-page-bottom\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:4:\"type\";s:14:\"container_free\";s:5:\"items\";a:1:{i:0;s:15:\"before_body_end\";}}}','2015-10-02 19:29:40','2015-10-02 19:29:40',0),
	(6,'default/em0120','2columns-left','a:11:{i:0;a:6:{s:10:\"custom_css\";s:9:\"em-header\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:4:\"type\";s:14:\"container_free\";s:5:\"items\";a:1:{i:0;s:6:\"header\";}}i:1;a:6:{s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:43:\"<div class=\"em-shipping\"> {{content}}</div>\";s:13:\"display_empty\";b:0;s:4:\"type\";s:12:\"container_24\";s:5:\"items\";a:2:{i:0;a:11:{s:6:\"column\";s:2:\"24\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:3:{i:0;s:8:\"em_area1\";i:1;s:15:\"global_messages\";i:2;s:11:\"breadcrumbs\";}}i:1;s:5:\"clear\";}}i:2;a:6:{s:10:\"custom_css\";s:13:\"em-slideshow \";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:52:\"<div class=\"em-slideshow-wrapper\"> {{content}}</div>\";s:13:\"display_empty\";b:0;s:4:\"type\";s:12:\"container_24\";s:5:\"items\";a:1:{i:0;a:11:{s:6:\"column\";s:2:\"24\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:1:{i:0;s:8:\"em_area2\";}}}}i:3;a:6:{s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:41:\"<div class=\"em-content\">{{content}}</div>\";s:13:\"display_empty\";b:0;s:4:\"type\";s:12:\"container_24\";s:5:\"items\";a:3:{i:0;a:11:{s:6:\"column\";s:2:\"18\";s:4:\"push\";s:1:\"6\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:7:\"em-main\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:3:{i:0;s:8:\"em_area3\";i:1;s:7:\"content\";i:2;s:8:\"em_area4\";}}i:1;a:11:{s:6:\"column\";s:1:\"6\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:2:\"18\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:7:\"em-left\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:3:{i:0;s:9:\"em_area11\";i:1;s:4:\"left\";i:2;s:9:\"em_area12\";}}i:2;s:5:\"clear\";}}i:4;a:6:{s:10:\"custom_css\";s:11:\"em-products\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:4:\"type\";s:14:\"container_free\";s:5:\"items\";a:1:{i:0;s:8:\"em_area5\";}}i:5;a:6:{s:10:\"custom_css\";s:9:\"em-banner\";s:10:\"inner_html\";s:92:\"<div class=\"container\"><div class=\"row\"><div class=\"col-sm-24\">{{content}}</div></div></div>\";s:10:\"outer_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:4:\"type\";s:14:\"container_free\";s:5:\"items\";a:1:{i:0;s:8:\"em_area6\";}}i:6;a:6:{s:10:\"custom_css\";s:17:\"em-content-bottom\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:49:\"<div class=\"em-content-bottom\"> {{content}}</div>\";s:13:\"display_empty\";b:0;s:4:\"type\";s:12:\"container_24\";s:5:\"items\";a:5:{i:0;a:11:{s:6:\"column\";s:2:\"16\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:1:{i:0;s:8:\"em_area7\";}}i:1;a:11:{s:6:\"column\";s:1:\"8\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:1:{i:0;s:8:\"em_area8\";}}i:2;s:5:\"clear\";i:3;a:11:{s:6:\"column\";s:2:\"24\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:1:{i:0;s:9:\"em_area16\";}}i:4;s:5:\"clear\";}}i:7;a:6:{s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:40:\"<div class=\"em-footer\">{{content}}</div>\";s:13:\"display_empty\";b:0;s:4:\"type\";s:12:\"container_24\";s:5:\"items\";a:1:{i:0;a:11:{s:6:\"column\";s:2:\"24\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:1:{i:0;s:8:\"em_area9\";}}}}i:8;a:6:{s:10:\"custom_css\";s:19:\"em-promotion-banner\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:4:\"type\";s:14:\"container_free\";s:5:\"items\";a:1:{i:0;s:9:\"em_area17\";}}i:9;a:6:{s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:40:\"<div class=\"em-footer\">{{content}}</div>\";s:13:\"display_empty\";b:0;s:4:\"type\";s:12:\"container_24\";s:5:\"items\";a:1:{i:0;a:11:{s:6:\"column\";s:2:\"24\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:3:{i:0;s:9:\"em_area10\";i:1;s:9:\"em_area15\";i:2;s:6:\"footer\";}}}}i:10;a:6:{s:10:\"custom_css\";s:14:\"em-page-bottom\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:4:\"type\";s:14:\"container_free\";s:5:\"items\";a:1:{i:0;s:15:\"before_body_end\";}}}','2015-10-02 19:29:41','2015-10-02 19:29:41',0),
	(7,'default/em0120','3columns','a:11:{i:0;a:6:{s:10:\"custom_css\";s:9:\"em-header\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:4:\"type\";s:14:\"container_free\";s:5:\"items\";a:1:{i:0;s:6:\"header\";}}i:1;a:6:{s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:43:\"<div class=\"em-shipping\"> {{content}}</div>\";s:13:\"display_empty\";b:0;s:4:\"type\";s:12:\"container_24\";s:5:\"items\";a:2:{i:0;a:11:{s:6:\"column\";s:2:\"24\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:3:{i:0;s:8:\"em_area1\";i:1;s:15:\"global_messages\";i:2;s:11:\"breadcrumbs\";}}i:1;s:5:\"clear\";}}i:2;a:6:{s:10:\"custom_css\";s:12:\"em-slideshow\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:52:\"<div class=\"em-slideshow-wrapper\"> {{content}}</div>\";s:13:\"display_empty\";b:0;s:4:\"type\";s:12:\"container_24\";s:5:\"items\";a:1:{i:0;a:11:{s:6:\"column\";s:2:\"24\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:1:{i:0;s:8:\"em_area2\";}}}}i:3;a:6:{s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:41:\"<div class=\"em-content\">{{content}}</div>\";s:13:\"display_empty\";b:0;s:4:\"type\";s:12:\"container_24\";s:5:\"items\";a:4:{i:0;a:11:{s:6:\"column\";s:2:\"12\";s:4:\"push\";s:1:\"6\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:7:\"em-main\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:3:{i:0;s:8:\"em_area3\";i:1;s:7:\"content\";i:2;s:8:\"em_area4\";}}i:1;a:11:{s:6:\"column\";s:1:\"6\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:2:\"12\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:7:\"em-left\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:3:{i:0;s:9:\"em_area11\";i:1;s:4:\"left\";i:2;s:9:\"em_area12\";}}i:2;a:11:{s:6:\"column\";s:1:\"6\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:8:\"em-right\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:3:{i:0;s:9:\"em_area13\";i:1;s:5:\"right\";i:2;s:9:\"em_area14\";}}i:3;s:5:\"clear\";}}i:4;a:6:{s:10:\"custom_css\";s:11:\"em-products\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:4:\"type\";s:14:\"container_free\";s:5:\"items\";a:1:{i:0;s:8:\"em_area5\";}}i:5;a:6:{s:10:\"custom_css\";s:9:\"em-banner\";s:10:\"inner_html\";s:92:\"<div class=\"container\"><div class=\"row\"><div class=\"col-sm-24\">{{content}}</div></div></div>\";s:10:\"outer_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:4:\"type\";s:14:\"container_free\";s:5:\"items\";a:1:{i:0;s:8:\"em_area6\";}}i:6;a:6:{s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:49:\"<div class=\"em-content-bottom\"> {{content}}</div>\";s:13:\"display_empty\";b:0;s:4:\"type\";s:12:\"container_24\";s:5:\"items\";a:5:{i:0;a:11:{s:6:\"column\";s:2:\"16\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:1:{i:0;s:8:\"em_area7\";}}i:1;a:11:{s:6:\"column\";s:1:\"8\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:1:{i:0;s:8:\"em_area8\";}}i:2;s:5:\"clear\";i:3;a:11:{s:6:\"column\";s:2:\"24\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:1:{i:0;s:9:\"em_area16\";}}i:4;s:5:\"clear\";}}i:7;a:6:{s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:41:\" <div class=\"em-footer\">{{content}}</div>\";s:13:\"display_empty\";b:0;s:4:\"type\";s:12:\"container_24\";s:5:\"items\";a:1:{i:0;a:11:{s:6:\"column\";s:2:\"24\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:1:{i:0;s:8:\"em_area9\";}}}}i:8;a:6:{s:10:\"custom_css\";s:19:\"em-promotion-banner\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:4:\"type\";s:14:\"container_free\";s:5:\"items\";a:1:{i:0;s:9:\"em_area17\";}}i:9;a:6:{s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:40:\"<div class=\"em-footer\">{{content}}</div>\";s:13:\"display_empty\";b:0;s:4:\"type\";s:12:\"container_24\";s:5:\"items\";a:1:{i:0;a:11:{s:6:\"column\";s:2:\"24\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:3:{i:0;s:9:\"em_area10\";i:1;s:9:\"em_area15\";i:2;s:6:\"footer\";}}}}i:10;a:6:{s:10:\"custom_css\";s:14:\"em-page-bottom\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:4:\"type\";s:14:\"container_free\";s:5:\"items\";a:1:{i:0;s:15:\"before_body_end\";}}}','2015-10-02 19:29:42','2015-10-02 19:29:42',0),
	(8,'default/em0120','2columns-right','a:11:{i:0;a:6:{s:10:\"custom_css\";s:9:\"em-header\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:4:\"type\";s:14:\"container_free\";s:5:\"items\";a:1:{i:0;s:6:\"header\";}}i:1;a:6:{s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:43:\"<div class=\"em-shipping\"> {{content}}</div>\";s:13:\"display_empty\";b:0;s:4:\"type\";s:12:\"container_24\";s:5:\"items\";a:2:{i:0;a:11:{s:6:\"column\";s:2:\"24\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:3:{i:0;s:8:\"em_area1\";i:1;s:15:\"global_messages\";i:2;s:11:\"breadcrumbs\";}}i:1;s:5:\"clear\";}}i:2;a:6:{s:10:\"custom_css\";s:12:\"em-slideshow\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:52:\"<div class=\"em-slideshow-wrapper\"> {{content}}</div>\";s:13:\"display_empty\";b:0;s:4:\"type\";s:12:\"container_24\";s:5:\"items\";a:1:{i:0;a:11:{s:6:\"column\";s:2:\"24\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:1:{i:0;s:8:\"em_area2\";}}}}i:3;a:6:{s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:41:\"<div class=\"em-content\">{{content}}</div>\";s:13:\"display_empty\";b:0;s:4:\"type\";s:12:\"container_24\";s:5:\"items\";a:3:{i:0;a:11:{s:6:\"column\";s:2:\"18\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:7:\"em-main\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:3:{i:0;s:8:\"em_area3\";i:1;s:7:\"content\";i:2;s:8:\"em_area4\";}}i:1;a:11:{s:6:\"column\";s:1:\"6\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:8:\"em-right\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:3:{i:0;s:9:\"em_area13\";i:1;s:5:\"right\";i:2;s:9:\"em_area14\";}}i:2;s:5:\"clear\";}}i:4;a:6:{s:10:\"custom_css\";s:11:\"em-products\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:4:\"type\";s:14:\"container_free\";s:5:\"items\";a:1:{i:0;s:8:\"em_area5\";}}i:5;a:6:{s:10:\"custom_css\";s:9:\"em-banner\";s:10:\"inner_html\";s:92:\"<div class=\"container\"><div class=\"row\"><div class=\"col-sm-24\">{{content}}</div></div></div>\";s:10:\"outer_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:4:\"type\";s:14:\"container_free\";s:5:\"items\";a:1:{i:0;s:8:\"em_area6\";}}i:6;a:6:{s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:49:\"<div class=\"em-content-bottom\"> {{content}}</div>\";s:13:\"display_empty\";b:0;s:4:\"type\";s:12:\"container_24\";s:5:\"items\";a:5:{i:0;a:11:{s:6:\"column\";s:2:\"16\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:1:{i:0;s:8:\"em_area7\";}}i:1;a:11:{s:6:\"column\";s:1:\"8\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:1:{i:0;s:8:\"em_area8\";}}i:2;s:5:\"clear\";i:3;a:11:{s:6:\"column\";s:2:\"24\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:1:{i:0;s:9:\"em_area16\";}}i:4;s:5:\"clear\";}}i:7;a:6:{s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:40:\"<div class=\"em-footer\">{{content}}</div>\";s:13:\"display_empty\";b:0;s:4:\"type\";s:12:\"container_24\";s:5:\"items\";a:1:{i:0;a:11:{s:6:\"column\";s:2:\"24\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:1:{i:0;s:8:\"em_area9\";}}}}i:8;a:6:{s:10:\"custom_css\";s:19:\"em-promotion-banner\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:4:\"type\";s:14:\"container_free\";s:5:\"items\";a:1:{i:0;s:9:\"em_area17\";}}i:9;a:6:{s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:40:\"<div class=\"em-footer\">{{content}}</div>\";s:13:\"display_empty\";b:0;s:4:\"type\";s:12:\"container_24\";s:5:\"items\";a:1:{i:0;a:11:{s:6:\"column\";s:2:\"24\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:3:{i:0;s:9:\"em_area10\";i:1;s:9:\"em_area15\";i:2;s:6:\"footer\";}}}}i:10;a:6:{s:10:\"custom_css\";s:14:\"em-page-bottom\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:4:\"type\";s:14:\"container_free\";s:5:\"items\";a:1:{i:0;s:15:\"before_body_end\";}}}','2015-10-02 19:29:44','2015-10-02 19:29:44',0),
	(9,'default/em0120','1column','a:10:{i:0;a:6:{s:10:\"custom_css\";s:9:\"em-header\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:4:\"type\";s:14:\"container_free\";s:5:\"items\";a:1:{i:0;s:6:\"header\";}}i:1;a:6:{s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:43:\"<div class=\"em-shipping\"> {{content}}</div>\";s:13:\"display_empty\";b:0;s:4:\"type\";s:12:\"container_24\";s:5:\"items\";a:2:{i:0;a:11:{s:6:\"column\";s:2:\"24\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:3:{i:0;s:8:\"em_area1\";i:1;s:15:\"global_messages\";i:2;s:11:\"breadcrumbs\";}}i:1;s:5:\"clear\";}}i:2;a:6:{s:10:\"custom_css\";s:12:\"em-slideshow\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:52:\"<div class=\"em-slideshow-wrapper\"> {{content}}</div>\";s:13:\"display_empty\";b:0;s:4:\"type\";s:12:\"container_24\";s:5:\"items\";a:1:{i:0;a:11:{s:6:\"column\";s:2:\"24\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:1:{i:0;s:8:\"em_area2\";}}}}i:3;a:6:{s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:41:\"<div class=\"em-content\">{{content}}</div>\";s:13:\"display_empty\";b:0;s:4:\"type\";s:12:\"container_24\";s:5:\"items\";a:3:{i:0;a:11:{s:6:\"column\";s:2:\"24\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:7:\"em-main\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:3:{i:0;s:8:\"em_area3\";i:1;s:7:\"content\";i:2;s:8:\"em_area4\";}}i:1;s:5:\"clear\";i:2;a:11:{s:6:\"column\";s:2:\"24\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:1:{i:0;s:8:\"em_area5\";}}}}i:4;a:6:{s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:49:\"<div class=\"em-content-bottom\"> {{content}}</div>\";s:13:\"display_empty\";b:0;s:4:\"type\";s:12:\"container_24\";s:5:\"items\";a:5:{i:0;a:11:{s:6:\"column\";s:2:\"16\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:1:{i:0;s:8:\"em_area7\";}}i:1;a:11:{s:6:\"column\";s:1:\"8\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:1:{i:0;s:8:\"em_area8\";}}i:2;s:5:\"clear\";i:3;a:11:{s:6:\"column\";s:2:\"24\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:1:{i:0;s:9:\"em_area16\";}}i:4;s:5:\"clear\";}}i:5;a:6:{s:10:\"custom_css\";s:9:\"em-banner\";s:10:\"inner_html\";s:92:\"<div class=\"container\"><div class=\"row\"><div class=\"col-sm-24\">{{content}}</div></div></div>\";s:10:\"outer_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:4:\"type\";s:14:\"container_free\";s:5:\"items\";a:1:{i:0;s:8:\"em_area6\";}}i:6;a:6:{s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:49:\"<div class=\"em-content-bottom\"> {{content}}</div>\";s:13:\"display_empty\";b:0;s:4:\"type\";s:12:\"container_24\";s:5:\"items\";a:1:{i:0;a:11:{s:6:\"column\";s:2:\"24\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:1:{i:0;s:8:\"em_area9\";}}}}i:7;a:6:{s:10:\"custom_css\";s:19:\"em-promotion-banner\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:4:\"type\";s:14:\"container_free\";s:5:\"items\";a:1:{i:0;s:9:\"em_area17\";}}i:8;a:6:{s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:40:\"<div class=\"em-footer\">{{content}}</div>\";s:13:\"display_empty\";b:0;s:4:\"type\";s:12:\"container_24\";s:5:\"items\";a:1:{i:0;a:11:{s:6:\"column\";s:2:\"24\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:3:{i:0;s:9:\"em_area10\";i:1;s:9:\"em_area15\";i:2;s:6:\"footer\";}}}}i:9;a:6:{s:10:\"custom_css\";s:14:\"em-page-bottom\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:4:\"type\";s:14:\"container_free\";s:5:\"items\";a:1:{i:0;s:15:\"before_body_end\";}}}','2015-10-02 19:29:45','2015-10-02 19:29:45',0),
	(10,'default/em0120','2columns-left','a:10:{i:0;a:6:{s:10:\"custom_css\";s:9:\"em-header\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:4:\"type\";s:14:\"container_free\";s:5:\"items\";a:1:{i:0;s:6:\"header\";}}i:1;a:6:{s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:43:\"<div class=\"em-shipping\"> {{content}}</div>\";s:13:\"display_empty\";b:0;s:4:\"type\";s:12:\"container_24\";s:5:\"items\";a:2:{i:0;a:11:{s:6:\"column\";s:2:\"24\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:3:{i:0;s:8:\"em_area1\";i:1;s:15:\"global_messages\";i:2;s:11:\"breadcrumbs\";}}i:1;s:5:\"clear\";}}i:2;a:6:{s:10:\"custom_css\";s:13:\"em-slideshow \";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:52:\"<div class=\"em-slideshow-wrapper\"> {{content}}</div>\";s:13:\"display_empty\";b:0;s:4:\"type\";s:12:\"container_24\";s:5:\"items\";a:1:{i:0;a:11:{s:6:\"column\";s:2:\"24\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:1:{i:0;s:8:\"em_area2\";}}}}i:3;a:6:{s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:41:\"<div class=\"em-content\">{{content}}</div>\";s:13:\"display_empty\";b:0;s:4:\"type\";s:12:\"container_24\";s:5:\"items\";a:4:{i:0;a:11:{s:6:\"column\";s:2:\"18\";s:4:\"push\";s:1:\"6\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:7:\"em-main\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:3:{i:0;s:8:\"em_area3\";i:1;s:7:\"content\";i:2;s:8:\"em_area4\";}}i:1;a:11:{s:6:\"column\";s:1:\"6\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:2:\"18\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:7:\"em-left\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:3:{i:0;s:9:\"em_area11\";i:1;s:4:\"left\";i:2;s:9:\"em_area12\";}}i:2;s:5:\"clear\";i:3;a:11:{s:6:\"column\";s:2:\"24\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:1:{i:0;s:8:\"em_area5\";}}}}i:4;a:6:{s:10:\"custom_css\";s:17:\"em-content-bottom\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:49:\"<div class=\"em-content-bottom\"> {{content}}</div>\";s:13:\"display_empty\";b:0;s:4:\"type\";s:12:\"container_24\";s:5:\"items\";a:5:{i:0;a:11:{s:6:\"column\";s:2:\"16\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:1:{i:0;s:8:\"em_area7\";}}i:1;a:11:{s:6:\"column\";s:1:\"8\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:1:{i:0;s:8:\"em_area8\";}}i:2;s:5:\"clear\";i:3;a:11:{s:6:\"column\";s:2:\"24\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:1:{i:0;s:9:\"em_area16\";}}i:4;s:5:\"clear\";}}i:5;a:6:{s:10:\"custom_css\";s:9:\"em-banner\";s:10:\"inner_html\";s:92:\"<div class=\"container\"><div class=\"row\"><div class=\"col-sm-24\">{{content}}</div></div></div>\";s:10:\"outer_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:4:\"type\";s:14:\"container_free\";s:5:\"items\";a:1:{i:0;s:8:\"em_area6\";}}i:6;a:6:{s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:49:\"<div class=\"em-content-bottom\"> {{content}}</div>\";s:13:\"display_empty\";b:0;s:4:\"type\";s:12:\"container_24\";s:5:\"items\";a:1:{i:0;a:11:{s:6:\"column\";s:2:\"24\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:1:{i:0;s:8:\"em_area9\";}}}}i:7;a:6:{s:10:\"custom_css\";s:19:\"em-promotion-banner\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:4:\"type\";s:14:\"container_free\";s:5:\"items\";a:1:{i:0;s:9:\"em_area17\";}}i:8;a:6:{s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:40:\"<div class=\"em-footer\">{{content}}</div>\";s:13:\"display_empty\";b:0;s:4:\"type\";s:12:\"container_24\";s:5:\"items\";a:1:{i:0;a:11:{s:6:\"column\";s:2:\"24\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:3:{i:0;s:9:\"em_area10\";i:1;s:9:\"em_area15\";i:2;s:6:\"footer\";}}}}i:9;a:6:{s:10:\"custom_css\";s:14:\"em-page-bottom\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:4:\"type\";s:14:\"container_free\";s:5:\"items\";a:1:{i:0;s:15:\"before_body_end\";}}}','2015-10-02 19:29:47','2015-10-02 19:29:47',0),
	(11,'default/em0120','3columns','a:10:{i:0;a:6:{s:10:\"custom_css\";s:9:\"em-header\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:4:\"type\";s:14:\"container_free\";s:5:\"items\";a:1:{i:0;s:6:\"header\";}}i:1;a:6:{s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:43:\"<div class=\"em-shipping\"> {{content}}</div>\";s:13:\"display_empty\";b:0;s:4:\"type\";s:12:\"container_24\";s:5:\"items\";a:2:{i:0;a:11:{s:6:\"column\";s:2:\"24\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:3:{i:0;s:8:\"em_area1\";i:1;s:15:\"global_messages\";i:2;s:11:\"breadcrumbs\";}}i:1;s:5:\"clear\";}}i:2;a:6:{s:10:\"custom_css\";s:12:\"em-slideshow\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:52:\"<div class=\"em-slideshow-wrapper\"> {{content}}</div>\";s:13:\"display_empty\";b:0;s:4:\"type\";s:12:\"container_24\";s:5:\"items\";a:1:{i:0;a:11:{s:6:\"column\";s:2:\"24\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:1:{i:0;s:8:\"em_area2\";}}}}i:3;a:6:{s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:41:\"<div class=\"em-content\">{{content}}</div>\";s:13:\"display_empty\";b:0;s:4:\"type\";s:12:\"container_24\";s:5:\"items\";a:5:{i:0;a:11:{s:6:\"column\";s:2:\"12\";s:4:\"push\";s:1:\"6\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:7:\"em-main\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:3:{i:0;s:8:\"em_area3\";i:1;s:7:\"content\";i:2;s:8:\"em_area4\";}}i:1;a:11:{s:6:\"column\";s:1:\"6\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:2:\"12\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:7:\"em-left\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:3:{i:0;s:9:\"em_area11\";i:1;s:4:\"left\";i:2;s:9:\"em_area12\";}}i:2;a:11:{s:6:\"column\";s:1:\"6\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:8:\"em-right\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:3:{i:0;s:9:\"em_area13\";i:1;s:5:\"right\";i:2;s:9:\"em_area14\";}}i:3;s:5:\"clear\";i:4;a:11:{s:6:\"column\";s:2:\"24\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:1:{i:0;s:8:\"em_area5\";}}}}i:4;a:6:{s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:49:\"<div class=\"em-content-bottom\"> {{content}}</div>\";s:13:\"display_empty\";b:0;s:4:\"type\";s:12:\"container_24\";s:5:\"items\";a:5:{i:0;a:11:{s:6:\"column\";s:2:\"16\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:1:{i:0;s:8:\"em_area7\";}}i:1;a:11:{s:6:\"column\";s:1:\"8\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:1:{i:0;s:8:\"em_area8\";}}i:2;s:5:\"clear\";i:3;a:11:{s:6:\"column\";s:2:\"24\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:1:{i:0;s:9:\"em_area16\";}}i:4;s:5:\"clear\";}}i:5;a:6:{s:10:\"custom_css\";s:9:\"em-banner\";s:10:\"inner_html\";s:92:\"<div class=\"container\"><div class=\"row\"><div class=\"col-sm-24\">{{content}}</div></div></div>\";s:10:\"outer_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:4:\"type\";s:14:\"container_free\";s:5:\"items\";a:1:{i:0;s:8:\"em_area6\";}}i:6;a:6:{s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:49:\"<div class=\"em-content-bottom\"> {{content}}</div>\";s:13:\"display_empty\";b:0;s:4:\"type\";s:12:\"container_24\";s:5:\"items\";a:1:{i:0;a:11:{s:6:\"column\";s:2:\"24\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:1:{i:0;s:8:\"em_area9\";}}}}i:7;a:6:{s:10:\"custom_css\";s:19:\"em-promotion-banner\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:4:\"type\";s:14:\"container_free\";s:5:\"items\";a:1:{i:0;s:9:\"em_area17\";}}i:8;a:6:{s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:41:\" <div class=\"em-footer\">{{content}}</div>\";s:13:\"display_empty\";b:0;s:4:\"type\";s:12:\"container_24\";s:5:\"items\";a:1:{i:0;a:11:{s:6:\"column\";s:2:\"24\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:3:{i:0;s:9:\"em_area10\";i:1;s:9:\"em_area15\";i:2;s:6:\"footer\";}}}}i:9;a:6:{s:10:\"custom_css\";s:14:\"em-page-bottom\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:4:\"type\";s:14:\"container_free\";s:5:\"items\";a:1:{i:0;s:15:\"before_body_end\";}}}','2015-10-02 19:29:48','2015-10-02 19:29:48',0),
	(12,'default/em0120','2columns-right','a:10:{i:0;a:6:{s:10:\"custom_css\";s:9:\"em-header\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:4:\"type\";s:14:\"container_free\";s:5:\"items\";a:1:{i:0;s:6:\"header\";}}i:1;a:6:{s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:43:\"<div class=\"em-shipping\"> {{content}}</div>\";s:13:\"display_empty\";b:0;s:4:\"type\";s:12:\"container_24\";s:5:\"items\";a:2:{i:0;a:11:{s:6:\"column\";s:2:\"24\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:3:{i:0;s:8:\"em_area1\";i:1;s:15:\"global_messages\";i:2;s:11:\"breadcrumbs\";}}i:1;s:5:\"clear\";}}i:2;a:6:{s:10:\"custom_css\";s:12:\"em-slideshow\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:52:\"<div class=\"em-slideshow-wrapper\"> {{content}}</div>\";s:13:\"display_empty\";b:0;s:4:\"type\";s:12:\"container_24\";s:5:\"items\";a:1:{i:0;a:11:{s:6:\"column\";s:2:\"24\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:1:{i:0;s:8:\"em_area2\";}}}}i:3;a:6:{s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:41:\"<div class=\"em-content\">{{content}}</div>\";s:13:\"display_empty\";b:0;s:4:\"type\";s:12:\"container_24\";s:5:\"items\";a:4:{i:0;a:11:{s:6:\"column\";s:2:\"18\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:7:\"em-main\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:3:{i:0;s:8:\"em_area3\";i:1;s:7:\"content\";i:2;s:8:\"em_area4\";}}i:1;a:11:{s:6:\"column\";s:1:\"6\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:8:\"em-right\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:3:{i:0;s:9:\"em_area13\";i:1;s:5:\"right\";i:2;s:9:\"em_area14\";}}i:2;s:5:\"clear\";i:3;a:11:{s:6:\"column\";s:2:\"24\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:1:{i:0;s:8:\"em_area5\";}}}}i:4;a:6:{s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:49:\"<div class=\"em-content-bottom\"> {{content}}</div>\";s:13:\"display_empty\";b:0;s:4:\"type\";s:12:\"container_24\";s:5:\"items\";a:5:{i:0;a:11:{s:6:\"column\";s:2:\"16\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:1:{i:0;s:8:\"em_area7\";}}i:1;a:11:{s:6:\"column\";s:1:\"8\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:1:{i:0;s:8:\"em_area8\";}}i:2;s:5:\"clear\";i:3;a:11:{s:6:\"column\";s:2:\"24\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:1:{i:0;s:9:\"em_area16\";}}i:4;s:5:\"clear\";}}i:5;a:6:{s:10:\"custom_css\";s:9:\"em-banner\";s:10:\"inner_html\";s:92:\"<div class=\"container\"><div class=\"row\"><div class=\"col-sm-24\">{{content}}</div></div></div>\";s:10:\"outer_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:4:\"type\";s:14:\"container_free\";s:5:\"items\";a:1:{i:0;s:8:\"em_area6\";}}i:6;a:6:{s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:49:\"<div class=\"em-content-bottom\"> {{content}}</div>\";s:13:\"display_empty\";b:0;s:4:\"type\";s:12:\"container_24\";s:5:\"items\";a:1:{i:0;a:11:{s:6:\"column\";s:2:\"24\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:1:{i:0;s:8:\"em_area9\";}}}}i:7;a:6:{s:10:\"custom_css\";s:19:\"em-promotion-banner\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:4:\"type\";s:14:\"container_free\";s:5:\"items\";a:1:{i:0;s:9:\"em_area17\";}}i:8;a:6:{s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:40:\"<div class=\"em-footer\">{{content}}</div>\";s:13:\"display_empty\";b:0;s:4:\"type\";s:12:\"container_24\";s:5:\"items\";a:1:{i:0;a:11:{s:6:\"column\";s:2:\"24\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:3:{i:0;s:9:\"em_area10\";i:1;s:6:\"footer\";i:2;s:9:\"em_area15\";}}}}i:9;a:6:{s:10:\"custom_css\";s:14:\"em-page-bottom\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:4:\"type\";s:14:\"container_free\";s:5:\"items\";a:1:{i:0;s:15:\"before_body_end\";}}}','2015-10-02 19:29:49','2015-10-02 19:29:49',0),
	(13,'default/em0120','1column','a:9:{i:0;a:6:{s:10:\"custom_css\";s:9:\"em-header\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:4:\"type\";s:14:\"container_free\";s:5:\"items\";a:1:{i:0;s:6:\"header\";}}i:1;a:6:{s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:43:\"<div class=\"em-shipping\"> {{content}}</div>\";s:13:\"display_empty\";b:0;s:4:\"type\";s:12:\"container_24\";s:5:\"items\";a:2:{i:0;a:11:{s:6:\"column\";s:2:\"24\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:3:{i:0;s:8:\"em_area1\";i:1;s:15:\"global_messages\";i:2;s:11:\"breadcrumbs\";}}i:1;s:5:\"clear\";}}i:2;a:6:{s:10:\"custom_css\";s:12:\"em-slideshow\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:52:\"<div class=\"em-slideshow-wrapper\"> {{content}}</div>\";s:13:\"display_empty\";b:0;s:4:\"type\";s:12:\"container_24\";s:5:\"items\";a:1:{i:0;a:11:{s:6:\"column\";s:2:\"24\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:1:{i:0;s:8:\"em_area2\";}}}}i:3;a:6:{s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:41:\"<div class=\"em-content\">{{content}}</div>\";s:13:\"display_empty\";b:0;s:4:\"type\";s:12:\"container_24\";s:5:\"items\";a:3:{i:0;a:11:{s:6:\"column\";s:2:\"24\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:1:{i:0;s:8:\"em_area5\";}}i:1;s:5:\"clear\";i:2;a:11:{s:6:\"column\";s:2:\"24\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:7:\"em-main\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:3:{i:0;s:8:\"em_area3\";i:1;s:7:\"content\";i:2;s:8:\"em_area4\";}}}}i:4;a:6:{s:10:\"custom_css\";s:9:\"em-banner\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:4:\"type\";s:14:\"container_free\";s:5:\"items\";a:1:{i:0;s:8:\"em_area6\";}}i:5;a:6:{s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:49:\"<div class=\"em-content-bottom\"> {{content}}</div>\";s:13:\"display_empty\";b:0;s:4:\"type\";s:12:\"container_24\";s:5:\"items\";a:5:{i:0;a:11:{s:6:\"column\";s:2:\"16\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:1:{i:0;s:8:\"em_area7\";}}i:1;a:11:{s:6:\"column\";s:1:\"8\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:1:{i:0;s:8:\"em_area8\";}}i:2;s:5:\"clear\";i:3;a:11:{s:6:\"column\";s:2:\"24\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:2:{i:0;s:9:\"em_area16\";i:1;s:8:\"em_area9\";}}i:4;s:5:\"clear\";}}i:6;a:6:{s:10:\"custom_css\";s:19:\"em-promotion-banner\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:4:\"type\";s:14:\"container_free\";s:5:\"items\";a:1:{i:0;s:9:\"em_area17\";}}i:7;a:6:{s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:40:\"<div class=\"em-footer\">{{content}}</div>\";s:13:\"display_empty\";b:0;s:4:\"type\";s:12:\"container_24\";s:5:\"items\";a:1:{i:0;a:11:{s:6:\"column\";s:2:\"24\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:3:{i:0;s:9:\"em_area10\";i:1;s:9:\"em_area15\";i:2;s:6:\"footer\";}}}}i:8;a:6:{s:10:\"custom_css\";s:14:\"em-page-bottom\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:4:\"type\";s:14:\"container_free\";s:5:\"items\";a:1:{i:0;s:15:\"before_body_end\";}}}','2015-10-02 19:29:51','2015-10-02 19:29:51',0),
	(14,'default/em0120','2columns-left','a:9:{i:0;a:6:{s:10:\"custom_css\";s:9:\"em-header\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:4:\"type\";s:14:\"container_free\";s:5:\"items\";a:1:{i:0;s:6:\"header\";}}i:1;a:6:{s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:43:\"<div class=\"em-shipping\"> {{content}}</div>\";s:13:\"display_empty\";b:0;s:4:\"type\";s:12:\"container_24\";s:5:\"items\";a:2:{i:0;a:11:{s:6:\"column\";s:2:\"24\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:3:{i:0;s:8:\"em_area1\";i:1;s:15:\"global_messages\";i:2;s:11:\"breadcrumbs\";}}i:1;s:5:\"clear\";}}i:2;a:6:{s:10:\"custom_css\";s:13:\"em-slideshow \";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:53:\"<div class=\"em-slideshow-wrapper\"> {{content}}</div> \";s:13:\"display_empty\";b:0;s:4:\"type\";s:12:\"container_24\";s:5:\"items\";a:1:{i:0;a:11:{s:6:\"column\";s:2:\"24\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:1:{i:0;s:8:\"em_area2\";}}}}i:3;a:6:{s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:41:\"<div class=\"em-content\">{{content}}</div>\";s:13:\"display_empty\";b:0;s:4:\"type\";s:12:\"container_24\";s:5:\"items\";a:4:{i:0;a:11:{s:6:\"column\";s:2:\"24\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:1:{i:0;s:8:\"em_area5\";}}i:1;s:5:\"clear\";i:2;a:11:{s:6:\"column\";s:2:\"18\";s:4:\"push\";s:1:\"6\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:7:\"em-main\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:3:{i:0;s:8:\"em_area3\";i:1;s:7:\"content\";i:2;s:8:\"em_area4\";}}i:3;a:11:{s:6:\"column\";s:1:\"6\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:2:\"18\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:7:\"em-left\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:3:{i:0;s:9:\"em_area11\";i:1;s:4:\"left\";i:2;s:9:\"em_area12\";}}}}i:4;a:6:{s:10:\"custom_css\";s:9:\"em-banner\";s:10:\"inner_html\";s:92:\"<div class=\"container\"><div class=\"row\"><div class=\"col-sm-24\">{{content}}</div></div></div>\";s:10:\"outer_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:4:\"type\";s:14:\"container_free\";s:5:\"items\";a:1:{i:0;s:8:\"em_area6\";}}i:5;a:6:{s:10:\"custom_css\";s:17:\"em-content-bottom\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:49:\"<div class=\"em-content-bottom\"> {{content}}</div>\";s:13:\"display_empty\";b:0;s:4:\"type\";s:12:\"container_24\";s:5:\"items\";a:5:{i:0;a:11:{s:6:\"column\";s:2:\"16\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:1:{i:0;s:8:\"em_area7\";}}i:1;a:11:{s:6:\"column\";s:1:\"8\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:1:{i:0;s:8:\"em_area8\";}}i:2;s:5:\"clear\";i:3;a:11:{s:6:\"column\";s:2:\"24\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:2:{i:0;s:9:\"em_area16\";i:1;s:8:\"em_area9\";}}i:4;s:5:\"clear\";}}i:6;a:6:{s:10:\"custom_css\";s:19:\"em-promotion-banner\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:4:\"type\";s:14:\"container_free\";s:5:\"items\";a:1:{i:0;s:9:\"em_area17\";}}i:7;a:6:{s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:40:\"<div class=\"em-footer\">{{content}}</div>\";s:13:\"display_empty\";b:0;s:4:\"type\";s:12:\"container_24\";s:5:\"items\";a:1:{i:0;a:11:{s:6:\"column\";s:2:\"24\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:3:{i:0;s:9:\"em_area10\";i:1;s:9:\"em_area15\";i:2;s:6:\"footer\";}}}}i:8;a:6:{s:10:\"custom_css\";s:14:\"em-page-bottom\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:4:\"type\";s:14:\"container_free\";s:5:\"items\";a:1:{i:0;s:15:\"before_body_end\";}}}','2015-10-02 19:29:52','2015-10-02 19:29:52',0),
	(15,'default/em0120','3columns','a:9:{i:0;a:6:{s:10:\"custom_css\";s:9:\"em-header\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:4:\"type\";s:14:\"container_free\";s:5:\"items\";a:1:{i:0;s:6:\"header\";}}i:1;a:6:{s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:43:\"<div class=\"em-shipping\"> {{content}}</div>\";s:13:\"display_empty\";b:0;s:4:\"type\";s:12:\"container_24\";s:5:\"items\";a:2:{i:0;a:11:{s:6:\"column\";s:2:\"24\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:3:{i:0;s:8:\"em_area1\";i:1;s:15:\"global_messages\";i:2;s:11:\"breadcrumbs\";}}i:1;s:5:\"clear\";}}i:2;a:6:{s:10:\"custom_css\";s:12:\"em-slideshow\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:52:\"<div class=\"em-slideshow-wrapper\"> {{content}}</div>\";s:13:\"display_empty\";b:0;s:4:\"type\";s:12:\"container_24\";s:5:\"items\";a:1:{i:0;a:11:{s:6:\"column\";s:2:\"24\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:1:{i:0;s:8:\"em_area2\";}}}}i:3;a:6:{s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:41:\"<div class=\"em-content\">{{content}}</div>\";s:13:\"display_empty\";b:0;s:4:\"type\";s:12:\"container_24\";s:5:\"items\";a:5:{i:0;a:11:{s:6:\"column\";s:2:\"24\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:1:{i:0;s:8:\"em_area5\";}}i:1;s:5:\"clear\";i:2;a:11:{s:6:\"column\";s:2:\"12\";s:4:\"push\";s:1:\"6\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:7:\"em-main\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:3:{i:0;s:8:\"em_area3\";i:1;s:7:\"content\";i:2;s:8:\"em_area4\";}}i:3;a:11:{s:6:\"column\";s:1:\"6\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:2:\"12\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:7:\"em-left\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:3:{i:0;s:9:\"em_area11\";i:1;s:4:\"left\";i:2;s:9:\"em_area12\";}}i:4;a:11:{s:6:\"column\";s:1:\"6\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:8:\"em-right\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:3:{i:0;s:9:\"em_area13\";i:1;s:5:\"right\";i:2;s:9:\"em_area14\";}}}}i:4;a:6:{s:10:\"custom_css\";s:9:\"em-banner\";s:10:\"inner_html\";s:92:\"<div class=\"container\"><div class=\"row\"><div class=\"col-sm-24\">{{content}}</div></div></div>\";s:10:\"outer_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:4:\"type\";s:14:\"container_free\";s:5:\"items\";a:1:{i:0;s:8:\"em_area6\";}}i:5;a:6:{s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:49:\"<div class=\"em-content-bottom\"> {{content}}</div>\";s:13:\"display_empty\";b:0;s:4:\"type\";s:12:\"container_24\";s:5:\"items\";a:5:{i:0;a:11:{s:6:\"column\";s:2:\"16\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:1:{i:0;s:8:\"em_area7\";}}i:1;a:11:{s:6:\"column\";s:1:\"8\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:1:{i:0;s:8:\"em_area8\";}}i:2;s:5:\"clear\";i:3;a:11:{s:6:\"column\";s:2:\"24\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:2:{i:0;s:9:\"em_area16\";i:1;s:8:\"em_area9\";}}i:4;s:5:\"clear\";}}i:6;a:6:{s:10:\"custom_css\";s:19:\"em-promotion-banner\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:4:\"type\";s:14:\"container_free\";s:5:\"items\";a:1:{i:0;s:9:\"em_area17\";}}i:7;a:6:{s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:41:\" <div class=\"em-footer\">{{content}}</div>\";s:13:\"display_empty\";b:0;s:4:\"type\";s:12:\"container_24\";s:5:\"items\";a:1:{i:0;a:11:{s:6:\"column\";s:2:\"24\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:3:{i:0;s:9:\"em_area10\";i:1;s:9:\"em_area15\";i:2;s:6:\"footer\";}}}}i:8;a:6:{s:10:\"custom_css\";s:14:\"em-page-bottom\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:4:\"type\";s:14:\"container_free\";s:5:\"items\";a:1:{i:0;s:15:\"before_body_end\";}}}','2015-10-02 19:29:54','2015-10-02 19:29:54',0),
	(16,'default/em0120','2columns-right','a:9:{i:0;a:6:{s:10:\"custom_css\";s:9:\"em-header\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:4:\"type\";s:14:\"container_free\";s:5:\"items\";a:1:{i:0;s:6:\"header\";}}i:1;a:6:{s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:43:\"<div class=\"em-shipping\"> {{content}}</div>\";s:13:\"display_empty\";b:0;s:4:\"type\";s:12:\"container_24\";s:5:\"items\";a:2:{i:0;a:11:{s:6:\"column\";s:2:\"24\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:3:{i:0;s:8:\"em_area1\";i:1;s:15:\"global_messages\";i:2;s:11:\"breadcrumbs\";}}i:1;s:5:\"clear\";}}i:2;a:6:{s:10:\"custom_css\";s:12:\"em-slideshow\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:52:\"<div class=\"em-slideshow-wrapper\"> {{content}}</div>\";s:13:\"display_empty\";b:0;s:4:\"type\";s:12:\"container_24\";s:5:\"items\";a:1:{i:0;a:11:{s:6:\"column\";s:2:\"24\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:1:{i:0;s:8:\"em_area2\";}}}}i:3;a:6:{s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:41:\"<div class=\"em-content\">{{content}}</div>\";s:13:\"display_empty\";b:0;s:4:\"type\";s:12:\"container_24\";s:5:\"items\";a:4:{i:0;a:11:{s:6:\"column\";s:2:\"24\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:1:{i:0;s:8:\"em_area5\";}}i:1;s:5:\"clear\";i:2;a:11:{s:6:\"column\";s:2:\"18\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:7:\"em-main\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:3:{i:0;s:8:\"em_area3\";i:1;s:7:\"content\";i:2;s:8:\"em_area4\";}}i:3;a:11:{s:6:\"column\";s:1:\"6\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:8:\"em-right\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:3:{i:0;s:9:\"em_area13\";i:1;s:5:\"right\";i:2;s:9:\"em_area14\";}}}}i:4;a:6:{s:10:\"custom_css\";s:9:\"em-banner\";s:10:\"inner_html\";s:92:\"<div class=\"container\"><div class=\"row\"><div class=\"col-sm-24\">{{content}}</div></div></div>\";s:10:\"outer_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:4:\"type\";s:14:\"container_free\";s:5:\"items\";a:1:{i:0;s:8:\"em_area6\";}}i:5;a:6:{s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:49:\"<div class=\"em-content-bottom\"> {{content}}</div>\";s:13:\"display_empty\";b:0;s:4:\"type\";s:12:\"container_24\";s:5:\"items\";a:5:{i:0;a:11:{s:6:\"column\";s:2:\"16\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:1:{i:0;s:8:\"em_area7\";}}i:1;a:11:{s:6:\"column\";s:1:\"8\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:1:{i:0;s:8:\"em_area8\";}}i:2;s:5:\"clear\";i:3;a:11:{s:6:\"column\";s:2:\"24\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:2:{i:0;s:9:\"em_area16\";i:1;s:8:\"em_area9\";}}i:4;s:5:\"clear\";}}i:6;a:6:{s:10:\"custom_css\";s:19:\"em-promotion-banner\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:4:\"type\";s:14:\"container_free\";s:5:\"items\";a:1:{i:0;s:9:\"em_area17\";}}i:7;a:6:{s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:40:\"<div class=\"em-footer\">{{content}}</div>\";s:13:\"display_empty\";b:0;s:4:\"type\";s:12:\"container_24\";s:5:\"items\";a:1:{i:0;a:11:{s:6:\"column\";s:2:\"24\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:3:{i:0;s:9:\"em_area10\";i:1;s:9:\"em_area15\";i:2;s:6:\"footer\";}}}}i:8;a:6:{s:10:\"custom_css\";s:14:\"em-page-bottom\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:4:\"type\";s:14:\"container_free\";s:5:\"items\";a:1:{i:0;s:15:\"before_body_end\";}}}','2015-10-02 19:29:55','2015-10-02 19:29:55',0),
	(17,'default/em0120','1column','a:9:{i:0;a:6:{s:10:\"custom_css\";s:9:\"em-header\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:4:\"type\";s:14:\"container_free\";s:5:\"items\";a:1:{i:0;s:6:\"header\";}}i:1;a:6:{s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:43:\"<div class=\"em-shipping\"> {{content}}</div>\";s:13:\"display_empty\";b:0;s:4:\"type\";s:12:\"container_24\";s:5:\"items\";a:2:{i:0;a:11:{s:6:\"column\";s:2:\"24\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:3:{i:0;s:8:\"em_area1\";i:1;s:15:\"global_messages\";i:2;s:11:\"breadcrumbs\";}}i:1;s:5:\"clear\";}}i:2;a:6:{s:10:\"custom_css\";s:12:\"em-slideshow\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:52:\"<div class=\"em-slideshow-wrapper\"> {{content}}</div>\";s:13:\"display_empty\";b:0;s:4:\"type\";s:12:\"container_24\";s:5:\"items\";a:1:{i:0;a:11:{s:6:\"column\";s:2:\"24\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:1:{i:0;s:8:\"em_area2\";}}}}i:3;a:6:{s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:41:\"<div class=\"em-content\">{{content}}</div>\";s:13:\"display_empty\";b:0;s:4:\"type\";s:12:\"container_24\";s:5:\"items\";a:3:{i:0;a:11:{s:6:\"column\";s:2:\"24\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:1:{i:0;s:8:\"em_area5\";}}i:1;s:5:\"clear\";i:2;a:11:{s:6:\"column\";s:2:\"24\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:7:\"em-main\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:3:{i:0;s:8:\"em_area3\";i:1;s:7:\"content\";i:2;s:8:\"em_area4\";}}}}i:4;a:6:{s:10:\"custom_css\";s:9:\"em-banner\";s:10:\"inner_html\";s:92:\"<div class=\"container\"><div class=\"row\"><div class=\"col-sm-24\">{{content}}</div></div></div>\";s:10:\"outer_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:4:\"type\";s:14:\"container_free\";s:5:\"items\";a:1:{i:0;s:8:\"em_area6\";}}i:5;a:6:{s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:49:\"<div class=\"em-content-bottom\"> {{content}}</div>\";s:13:\"display_empty\";b:0;s:4:\"type\";s:12:\"container_24\";s:5:\"items\";a:5:{i:0;a:11:{s:6:\"column\";s:2:\"16\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:1:{i:0;s:8:\"em_area7\";}}i:1;a:11:{s:6:\"column\";s:1:\"8\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:1:{i:0;s:8:\"em_area8\";}}i:2;s:5:\"clear\";i:3;a:11:{s:6:\"column\";s:2:\"24\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:2:{i:0;s:9:\"em_area16\";i:1;s:8:\"em_area9\";}}i:4;s:5:\"clear\";}}i:6;a:6:{s:10:\"custom_css\";s:19:\"em-promotion-banner\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:4:\"type\";s:14:\"container_free\";s:5:\"items\";a:1:{i:0;s:9:\"em_area17\";}}i:7;a:6:{s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:40:\"<div class=\"em-footer\">{{content}}</div>\";s:13:\"display_empty\";b:0;s:4:\"type\";s:12:\"container_24\";s:5:\"items\";a:1:{i:0;a:11:{s:6:\"column\";s:2:\"24\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:3:{i:0;s:9:\"em_area10\";i:1;s:9:\"em_area15\";i:2;s:6:\"footer\";}}}}i:8;a:6:{s:10:\"custom_css\";s:14:\"em-page-bottom\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:4:\"type\";s:14:\"container_free\";s:5:\"items\";a:1:{i:0;s:15:\"before_body_end\";}}}','2015-10-02 19:29:56','2015-10-02 19:29:56',0),
	(18,'default/em0120','2columns-left','a:9:{i:0;a:6:{s:10:\"custom_css\";s:9:\"em-header\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:4:\"type\";s:14:\"container_free\";s:5:\"items\";a:1:{i:0;s:6:\"header\";}}i:1;a:6:{s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:43:\"<div class=\"em-shipping\"> {{content}}</div>\";s:13:\"display_empty\";b:0;s:4:\"type\";s:12:\"container_24\";s:5:\"items\";a:2:{i:0;a:11:{s:6:\"column\";s:2:\"24\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:3:{i:0;s:8:\"em_area1\";i:1;s:15:\"global_messages\";i:2;s:11:\"breadcrumbs\";}}i:1;s:5:\"clear\";}}i:2;a:6:{s:10:\"custom_css\";s:13:\"em-slideshow \";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:52:\"<div class=\"em-slideshow-wrapper\"> {{content}}</div>\";s:13:\"display_empty\";b:0;s:4:\"type\";s:12:\"container_24\";s:5:\"items\";a:1:{i:0;a:11:{s:6:\"column\";s:2:\"24\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:1:{i:0;s:8:\"em_area2\";}}}}i:3;a:6:{s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:41:\"<div class=\"em-content\">{{content}}</div>\";s:13:\"display_empty\";b:0;s:4:\"type\";s:12:\"container_24\";s:5:\"items\";a:4:{i:0;a:11:{s:6:\"column\";s:2:\"24\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:1:{i:0;s:8:\"em_area5\";}}i:1;s:5:\"clear\";i:2;a:11:{s:6:\"column\";s:2:\"18\";s:4:\"push\";s:1:\"6\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:7:\"em-main\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:3:{i:0;s:8:\"em_area3\";i:1;s:7:\"content\";i:2;s:8:\"em_area4\";}}i:3;a:11:{s:6:\"column\";s:1:\"6\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:2:\"18\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:7:\"em-left\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:3:{i:0;s:9:\"em_area11\";i:1;s:4:\"left\";i:2;s:9:\"em_area12\";}}}}i:4;a:6:{s:10:\"custom_css\";s:9:\"em-banner\";s:10:\"inner_html\";s:92:\"<div class=\"container\"><div class=\"row\"><div class=\"col-sm-24\">{{content}}</div></div></div>\";s:10:\"outer_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:4:\"type\";s:14:\"container_free\";s:5:\"items\";a:1:{i:0;s:8:\"em_area6\";}}i:5;a:6:{s:10:\"custom_css\";s:17:\"em-content-bottom\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:49:\"<div class=\"em-content-bottom\"> {{content}}</div>\";s:13:\"display_empty\";b:0;s:4:\"type\";s:12:\"container_24\";s:5:\"items\";a:5:{i:0;a:11:{s:6:\"column\";s:2:\"16\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:1:{i:0;s:8:\"em_area7\";}}i:1;a:11:{s:6:\"column\";s:1:\"8\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:1:{i:0;s:8:\"em_area8\";}}i:2;s:5:\"clear\";i:3;a:11:{s:6:\"column\";s:2:\"24\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:2:{i:0;s:9:\"em_area16\";i:1;s:8:\"em_area9\";}}i:4;s:5:\"clear\";}}i:6;a:6:{s:10:\"custom_css\";s:19:\"em-promotion-banner\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:4:\"type\";s:14:\"container_free\";s:5:\"items\";a:1:{i:0;s:9:\"em_area17\";}}i:7;a:6:{s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:40:\"<div class=\"em-footer\">{{content}}</div>\";s:13:\"display_empty\";b:0;s:4:\"type\";s:12:\"container_24\";s:5:\"items\";a:1:{i:0;a:11:{s:6:\"column\";s:2:\"24\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:3:{i:0;s:9:\"em_area10\";i:1;s:9:\"em_area15\";i:2;s:6:\"footer\";}}}}i:8;a:6:{s:10:\"custom_css\";s:14:\"em-page-bottom\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:4:\"type\";s:14:\"container_free\";s:5:\"items\";a:1:{i:0;s:15:\"before_body_end\";}}}','2015-10-02 19:29:58','2015-10-02 19:29:58',0),
	(19,'default/em0120','3columns','a:9:{i:0;a:6:{s:10:\"custom_css\";s:9:\"em-header\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:4:\"type\";s:14:\"container_free\";s:5:\"items\";a:1:{i:0;s:6:\"header\";}}i:1;a:6:{s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:43:\"<div class=\"em-shipping\"> {{content}}</div>\";s:13:\"display_empty\";b:0;s:4:\"type\";s:12:\"container_24\";s:5:\"items\";a:2:{i:0;a:11:{s:6:\"column\";s:2:\"24\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:3:{i:0;s:8:\"em_area1\";i:1;s:15:\"global_messages\";i:2;s:11:\"breadcrumbs\";}}i:1;s:5:\"clear\";}}i:2;a:6:{s:10:\"custom_css\";s:12:\"em-slideshow\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:52:\"<div class=\"em-slideshow-wrapper\"> {{content}}</div>\";s:13:\"display_empty\";b:0;s:4:\"type\";s:12:\"container_24\";s:5:\"items\";a:1:{i:0;a:11:{s:6:\"column\";s:2:\"24\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:1:{i:0;s:8:\"em_area2\";}}}}i:3;a:6:{s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:41:\"<div class=\"em-content\">{{content}}</div>\";s:13:\"display_empty\";b:0;s:4:\"type\";s:12:\"container_24\";s:5:\"items\";a:5:{i:0;a:11:{s:6:\"column\";s:2:\"24\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:1:{i:0;s:8:\"em_area5\";}}i:1;s:5:\"clear\";i:2;a:11:{s:6:\"column\";s:2:\"12\";s:4:\"push\";s:1:\"6\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:7:\"em-main\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:3:{i:0;s:8:\"em_area3\";i:1;s:7:\"content\";i:2;s:8:\"em_area4\";}}i:3;a:11:{s:6:\"column\";s:1:\"6\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:2:\"12\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:7:\"em-left\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:3:{i:0;s:9:\"em_area11\";i:1;s:4:\"left\";i:2;s:9:\"em_area12\";}}i:4;a:11:{s:6:\"column\";s:1:\"6\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:8:\"em-right\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:3:{i:0;s:9:\"em_area13\";i:1;s:5:\"right\";i:2;s:9:\"em_area14\";}}}}i:4;a:6:{s:10:\"custom_css\";s:9:\"em-banner\";s:10:\"inner_html\";s:92:\"<div class=\"container\"><div class=\"row\"><div class=\"col-sm-24\">{{content}}</div></div></div>\";s:10:\"outer_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:4:\"type\";s:14:\"container_free\";s:5:\"items\";a:1:{i:0;s:8:\"em_area6\";}}i:5;a:6:{s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:49:\"<div class=\"em-content-bottom\"> {{content}}</div>\";s:13:\"display_empty\";b:0;s:4:\"type\";s:12:\"container_24\";s:5:\"items\";a:5:{i:0;a:11:{s:6:\"column\";s:2:\"16\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:1:{i:0;s:8:\"em_area7\";}}i:1;a:11:{s:6:\"column\";s:1:\"8\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:1:{i:0;s:8:\"em_area8\";}}i:2;s:5:\"clear\";i:3;a:11:{s:6:\"column\";s:2:\"24\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:2:{i:0;s:9:\"em_area16\";i:1;s:8:\"em_area9\";}}i:4;s:5:\"clear\";}}i:6;a:6:{s:10:\"custom_css\";s:19:\"em-promotion-banner\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:4:\"type\";s:14:\"container_free\";s:5:\"items\";a:1:{i:0;s:9:\"em_area17\";}}i:7;a:6:{s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:41:\" <div class=\"em-footer\">{{content}}</div>\";s:13:\"display_empty\";b:0;s:4:\"type\";s:12:\"container_24\";s:5:\"items\";a:1:{i:0;a:11:{s:6:\"column\";s:2:\"24\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:2:{i:0;s:9:\"em_area10\";i:1;s:9:\"em_area15\";}}}}i:8;a:6:{s:10:\"custom_css\";s:14:\"em-page-bottom\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:4:\"type\";s:14:\"container_free\";s:5:\"items\";a:1:{i:0;s:15:\"before_body_end\";}}}','2015-10-02 19:29:59','2015-10-02 19:29:59',0),
	(20,'default/em0120','2columns-right','a:9:{i:0;a:6:{s:10:\"custom_css\";s:9:\"em-header\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:4:\"type\";s:14:\"container_free\";s:5:\"items\";a:1:{i:0;s:6:\"header\";}}i:1;a:6:{s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:43:\"<div class=\"em-shipping\"> {{content}}</div>\";s:13:\"display_empty\";b:0;s:4:\"type\";s:12:\"container_24\";s:5:\"items\";a:2:{i:0;a:11:{s:6:\"column\";s:2:\"24\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:3:{i:0;s:8:\"em_area1\";i:1;s:15:\"global_messages\";i:2;s:11:\"breadcrumbs\";}}i:1;s:5:\"clear\";}}i:2;a:6:{s:10:\"custom_css\";s:12:\"em-slideshow\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:52:\"<div class=\"em-slideshow-wrapper\"> {{content}}</div>\";s:13:\"display_empty\";b:0;s:4:\"type\";s:12:\"container_24\";s:5:\"items\";a:1:{i:0;a:11:{s:6:\"column\";s:2:\"24\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:1:{i:0;s:8:\"em_area2\";}}}}i:3;a:6:{s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:41:\"<div class=\"em-content\">{{content}}</div>\";s:13:\"display_empty\";b:0;s:4:\"type\";s:12:\"container_24\";s:5:\"items\";a:4:{i:0;a:11:{s:6:\"column\";s:2:\"24\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:1:{i:0;s:8:\"em_area5\";}}i:1;s:5:\"clear\";i:2;a:11:{s:6:\"column\";s:2:\"18\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:7:\"em-main\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:3:{i:0;s:8:\"em_area3\";i:1;s:7:\"content\";i:2;s:8:\"em_area4\";}}i:3;a:11:{s:6:\"column\";s:1:\"6\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:8:\"em-right\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:3:{i:0;s:9:\"em_area13\";i:1;s:5:\"right\";i:2;s:9:\"em_area14\";}}}}i:4;a:6:{s:10:\"custom_css\";s:9:\"em-banner\";s:10:\"inner_html\";s:92:\"<div class=\"container\"><div class=\"row\"><div class=\"col-sm-24\">{{content}}</div></div></div>\";s:10:\"outer_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:4:\"type\";s:14:\"container_free\";s:5:\"items\";a:1:{i:0;s:8:\"em_area6\";}}i:5;a:6:{s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:49:\"<div class=\"em-content-bottom\"> {{content}}</div>\";s:13:\"display_empty\";b:0;s:4:\"type\";s:12:\"container_24\";s:5:\"items\";a:5:{i:0;a:11:{s:6:\"column\";s:2:\"16\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:1:{i:0;s:8:\"em_area7\";}}i:1;a:11:{s:6:\"column\";s:1:\"8\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:1:{i:0;s:8:\"em_area8\";}}i:2;s:5:\"clear\";i:3;a:11:{s:6:\"column\";s:2:\"24\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:2:{i:0;s:9:\"em_area16\";i:1;s:8:\"em_area9\";}}i:4;s:5:\"clear\";}}i:6;a:6:{s:10:\"custom_css\";s:19:\"em-promotion-banner\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:4:\"type\";s:14:\"container_free\";s:5:\"items\";a:1:{i:0;s:9:\"em_area17\";}}i:7;a:6:{s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:40:\"<div class=\"em-footer\">{{content}}</div>\";s:13:\"display_empty\";b:0;s:4:\"type\";s:12:\"container_24\";s:5:\"items\";a:1:{i:0;a:11:{s:6:\"column\";s:2:\"24\";s:4:\"push\";s:0:\"\";s:4:\"pull\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:5:\"first\";b:0;s:4:\"last\";b:0;s:10:\"custom_css\";s:0:\"\";s:10:\"inner_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:5:\"items\";a:3:{i:0;s:9:\"em_area10\";i:1;s:9:\"em_area15\";i:2;s:6:\"footer\";}}}}i:8;a:6:{s:10:\"custom_css\";s:14:\"em-page-bottom\";s:10:\"inner_html\";s:0:\"\";s:10:\"outer_html\";s:0:\"\";s:13:\"display_empty\";b:0;s:4:\"type\";s:14:\"container_free\";s:5:\"items\";a:1:{i:0;s:15:\"before_body_end\";}}}','2015-10-02 19:30:00','2015-10-02 19:30:00',0);

/*!40000 ALTER TABLE `themeframework_area` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table themeframework_area_store
# ------------------------------------------------------------

DROP TABLE IF EXISTS `themeframework_area_store`;

CREATE TABLE `themeframework_area_store` (
  `area_id` smallint(6) NOT NULL COMMENT 'Area ID',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store ID',
  PRIMARY KEY (`area_id`,`store_id`),
  KEY `IDX_THEMEFRAMEWORK_AREA_STORE_STORE_ID` (`store_id`),
  CONSTRAINT `FK_THEMEFRAMEWORK_AREA_STORE_AREA_ID_THEMEFRAMEWORK_AREA_AREA_ID` FOREIGN KEY (`area_id`) REFERENCES `themeframework_area` (`area_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_THEMEFRAMEWORK_AREA_STORE_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='EM ThemeFramework Area To Store Linkage Table';

LOCK TABLES `themeframework_area_store` WRITE;
/*!40000 ALTER TABLE `themeframework_area_store` DISABLE KEYS */;

INSERT INTO `themeframework_area_store` (`area_id`, `store_id`)
VALUES
	(1,0),
	(2,0),
	(3,0),
	(4,0),
	(5,0),
	(6,0),
	(7,0),
	(8,0),
	(9,0),
	(10,0),
	(11,0),
	(12,0),
	(13,0),
	(14,0),
	(15,0),
	(16,0),
	(17,0),
	(18,0),
	(19,0),
	(20,0);

/*!40000 ALTER TABLE `themeframework_area_store` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table themeframework_page
# ------------------------------------------------------------

DROP TABLE IF EXISTS `themeframework_page`;

CREATE TABLE `themeframework_page` (
  `page_id` smallint(6) NOT NULL AUTO_INCREMENT COMMENT 'Area ID',
  `title` varchar(255) DEFAULT NULL COMMENT 'Title',
  `handle` varchar(100) DEFAULT NULL COMMENT 'Handle',
  `custom_handle` varchar(100) DEFAULT NULL COMMENT 'Custom Handle',
  `layout` varchar(100) DEFAULT NULL COMMENT 'Layout',
  `layout_update_xml` text COMMENT 'Layout Update Xml',
  `status` smallint(6) NOT NULL DEFAULT '1' COMMENT 'Status',
  `sort` int(11) NOT NULL DEFAULT '0' COMMENT 'Sort',
  PRIMARY KEY (`page_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='EM ThemeFramework Page Table';



# Dump of table themeframework_page_store
# ------------------------------------------------------------

DROP TABLE IF EXISTS `themeframework_page_store`;

CREATE TABLE `themeframework_page_store` (
  `page_id` smallint(6) NOT NULL COMMENT 'Area ID',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store ID',
  PRIMARY KEY (`page_id`,`store_id`),
  KEY `IDX_THEMEFRAMEWORK_PAGE_STORE_STORE_ID` (`store_id`),
  CONSTRAINT `FK_THEMEFRAMEWORK_PAGE_STORE_PAGE_ID_THEMEFRAMEWORK_AREA_AREA_ID` FOREIGN KEY (`page_id`) REFERENCES `themeframework_page` (`page_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_THEMEFRAMEWORK_PAGE_STORE_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='EM ThemeFramework Page To Store Linkage Table';



# Dump of table weee_discount
# ------------------------------------------------------------

DROP TABLE IF EXISTS `weee_discount`;

CREATE TABLE `weee_discount` (
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Id',
  `website_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Website Id',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group Id',
  `value` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Value',
  KEY `IDX_WEEE_DISCOUNT_WEBSITE_ID` (`website_id`),
  KEY `IDX_WEEE_DISCOUNT_ENTITY_ID` (`entity_id`),
  KEY `IDX_WEEE_DISCOUNT_CUSTOMER_GROUP_ID` (`customer_group_id`),
  CONSTRAINT `FK_WEEE_DISCOUNT_CSTR_GROUP_ID_CSTR_GROUP_CSTR_GROUP_ID` FOREIGN KEY (`customer_group_id`) REFERENCES `customer_group` (`customer_group_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_WEEE_DISCOUNT_ENTITY_ID_CATALOG_PRODUCT_ENTITY_ENTITY_ID` FOREIGN KEY (`entity_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_WEEE_DISCOUNT_WEBSITE_ID_CORE_WEBSITE_WEBSITE_ID` FOREIGN KEY (`website_id`) REFERENCES `core_website` (`website_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Weee Discount';



# Dump of table weee_tax
# ------------------------------------------------------------

DROP TABLE IF EXISTS `weee_tax`;

CREATE TABLE `weee_tax` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value Id',
  `website_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Website Id',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Id',
  `country` varchar(2) DEFAULT NULL COMMENT 'Country',
  `value` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Value',
  `state` varchar(255) NOT NULL DEFAULT '*' COMMENT 'State',
  `attribute_id` smallint(5) unsigned NOT NULL COMMENT 'Attribute Id',
  `entity_type_id` smallint(5) unsigned NOT NULL COMMENT 'Entity Type Id',
  PRIMARY KEY (`value_id`),
  KEY `IDX_WEEE_TAX_WEBSITE_ID` (`website_id`),
  KEY `IDX_WEEE_TAX_ENTITY_ID` (`entity_id`),
  KEY `IDX_WEEE_TAX_COUNTRY` (`country`),
  KEY `IDX_WEEE_TAX_ATTRIBUTE_ID` (`attribute_id`),
  CONSTRAINT `FK_WEEE_TAX_COUNTRY_DIRECTORY_COUNTRY_COUNTRY_ID` FOREIGN KEY (`country`) REFERENCES `directory_country` (`country_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_WEEE_TAX_ENTITY_ID_CATALOG_PRODUCT_ENTITY_ENTITY_ID` FOREIGN KEY (`entity_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_WEEE_TAX_WEBSITE_ID_CORE_WEBSITE_WEBSITE_ID` FOREIGN KEY (`website_id`) REFERENCES `core_website` (`website_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_WEEE_TAX_ATTRIBUTE_ID_EAV_ATTRIBUTE_ATTRIBUTE_ID` FOREIGN KEY (`attribute_id`) REFERENCES `eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Weee Tax';



# Dump of table widget
# ------------------------------------------------------------

DROP TABLE IF EXISTS `widget`;

CREATE TABLE `widget` (
  `widget_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Widget Id',
  `widget_code` varchar(255) DEFAULT NULL COMMENT 'Widget code for template directive',
  `widget_type` varchar(255) DEFAULT NULL COMMENT 'Widget Type',
  `parameters` text COMMENT 'Parameters',
  PRIMARY KEY (`widget_id`),
  KEY `IDX_WIDGET_WIDGET_CODE` (`widget_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Preconfigured Widgets';



# Dump of table widget_instance
# ------------------------------------------------------------

DROP TABLE IF EXISTS `widget_instance`;

CREATE TABLE `widget_instance` (
  `instance_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Instance Id',
  `instance_type` varchar(255) DEFAULT NULL COMMENT 'Instance Type',
  `package_theme` varchar(255) DEFAULT NULL COMMENT 'Package Theme',
  `title` varchar(255) DEFAULT NULL COMMENT 'Widget Title',
  `store_ids` varchar(255) NOT NULL DEFAULT '0' COMMENT 'Store ids',
  `widget_parameters` text COMMENT 'Widget parameters',
  `sort_order` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Sort order',
  PRIMARY KEY (`instance_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Instances of Widget for Package Theme';

LOCK TABLES `widget_instance` WRITE;
/*!40000 ALTER TABLE `widget_instance` DISABLE KEYS */;

INSERT INTO `widget_instance` (`instance_id`, `instance_type`, `package_theme`, `title`, `store_ids`, `widget_parameters`, `sort_order`)
VALUES
	(1,'cmswidget/widget_block','default/em0120','Em0120 - Area 01 - Shipping','0','a:5:{s:8:\"block_id\";s:1:\"4\";s:12:\"custom_class\";s:15:\"area01-shipping\";s:25:\"custom_html_wrapper_class\";s:0:\"\";s:22:\"custom_html_wrapper_id\";s:0:\"\";s:11:\"block_title\";s:0:\"\";}',0),
	(2,'slideshow2/slideshow2','default/em0120','Em0120 - Area 02 - Main Slideshow','0','a:1:{s:9:\"slideshow\";s:1:\"1\";}',0),
	(3,'cmswidget/widget_block','default/em0120','Em0120 - Area 05 - Features','0','a:5:{s:8:\"block_id\";s:1:\"5\";s:12:\"custom_class\";s:15:\"area05-features\";s:25:\"custom_html_wrapper_class\";s:0:\"\";s:22:\"custom_html_wrapper_id\";s:0:\"\";s:11:\"block_title\";s:14:\"Theme Features\";}',0),
	(4,'cmswidget/widget_block','default/em0120','Em0120 - Area 05 - Three Banners','0','a:5:{s:8:\"block_id\";s:1:\"6\";s:12:\"custom_class\";s:20:\"area05-three-banners\";s:25:\"custom_html_wrapper_class\";s:0:\"\";s:22:\"custom_html_wrapper_id\";s:0:\"\";s:11:\"block_title\";s:0:\"\";}',1),
	(5,'cmswidget/widget_block','default/em0120','Em0120 - Area 06 - Banner Shipping','0','a:5:{s:8:\"block_id\";s:1:\"7\";s:12:\"custom_class\";s:22:\"area06-banner-shipping\";s:25:\"custom_html_wrapper_class\";s:0:\"\";s:22:\"custom_html_wrapper_id\";s:0:\"\";s:11:\"block_title\";s:0:\"\";}',0),
	(6,'cmswidget/widget_block','default/em0120','Em0120 - Area 07 - Featured Products','0','a:5:{s:8:\"block_id\";s:1:\"8\";s:12:\"custom_class\";s:24:\"area07-featured-products\";s:25:\"custom_html_wrapper_class\";s:0:\"\";s:22:\"custom_html_wrapper_id\";s:0:\"\";s:11:\"block_title\";s:17:\"Featured Products\";}',1),
	(7,'cmswidget/widget_block','default/em0120','Em0120 - Area 08 - Newsletter','0','a:5:{s:8:\"block_id\";s:1:\"9\";s:12:\"custom_class\";s:17:\"area08-newsletter\";s:25:\"custom_html_wrapper_class\";s:0:\"\";s:22:\"custom_html_wrapper_id\";s:0:\"\";s:11:\"block_title\";s:0:\"\";}',1),
	(8,'cmswidget/widget_block','default/em0120','Em0120 - Area 08 - Testimonial','0','a:5:{s:8:\"block_id\";s:2:\"10\";s:12:\"custom_class\";s:18:\"area08-testimonial\";s:25:\"custom_html_wrapper_class\";s:0:\"\";s:22:\"custom_html_wrapper_id\";s:0:\"\";s:11:\"block_title\";s:11:\"Testimonial\";}',2),
	(9,'cmswidget/widget_block','default/em0120','Em0120 - Area 09 - Brand','0','a:5:{s:8:\"block_id\";s:2:\"11\";s:12:\"custom_class\";s:12:\"area09-brand\";s:25:\"custom_html_wrapper_class\";s:0:\"\";s:22:\"custom_html_wrapper_id\";s:0:\"\";s:11:\"block_title\";s:0:\"\";}',3),
	(10,'cmswidget/widget_block','default/em0120','Em0120 - Area 10 - Links','0','a:5:{s:8:\"block_id\";s:2:\"13\";s:12:\"custom_class\";s:12:\"area10-links\";s:25:\"custom_html_wrapper_class\";s:0:\"\";s:22:\"custom_html_wrapper_id\";s:0:\"\";s:11:\"block_title\";s:0:\"\";}',2),
	(11,'cmswidget/widget_block','default/em0120','Em0120 - Footer - Payment','0','a:5:{s:8:\"block_id\";s:2:\"14\";s:12:\"custom_class\";s:14:\"footer-payment\";s:25:\"custom_html_wrapper_class\";s:0:\"\";s:22:\"custom_html_wrapper_id\";s:0:\"\";s:11:\"block_title\";s:0:\"\";}',0),
	(12,'megamenupro/megamenupro','default/em0120','Em0120 Main Megamenu','0','a:1:{s:4:\"menu\";s:1:\"1\";}',0),
	(13,'recentreviewproducts/list','default/em0120','Em0120 - Left - Latest Review','0','a:20:{s:11:\"limit_count\";s:1:\"3\";s:12:\"column_count\";s:0:\"\";s:8:\"order_by\";s:8:\"name asc\";s:12:\"custom_class\";s:0:\"\";s:14:\"frontend_title\";s:13:\"Latest Review\";s:10:\"item_width\";s:0:\"\";s:10:\"item_class\";s:0:\"\";s:11:\"item_height\";s:0:\"\";s:12:\"item_spacing\";s:0:\"\";s:15:\"thumbnail_width\";s:3:\"239\";s:16:\"thumbnail_height\";s:3:\"335\";s:17:\"show_product_name\";s:4:\"true\";s:14:\"show_thumbnail\";s:4:\"true\";s:10:\"show_price\";s:4:\"true\";s:7:\"alt_img\";s:0:\"\";s:14:\"show_addtocart\";s:5:\"false\";s:10:\"show_addto\";s:5:\"false\";s:10:\"show_label\";s:5:\"false\";s:15:\"choose_template\";s:48:\"em_recentviewproducts/grid_products_simple.phtml\";s:14:\"cache_lifetime\";s:0:\"\";}',0),
	(14,'cmswidget/widget_block','default/em0120','Em0120 - Area 3 - Sample Block','0','a:5:{s:8:\"block_id\";s:2:\"15\";s:12:\"custom_class\";s:0:\"\";s:25:\"custom_html_wrapper_class\";s:0:\"\";s:22:\"custom_html_wrapper_id\";s:0:\"\";s:11:\"block_title\";s:0:\"\";}',0),
	(15,'cmswidget/widget_block','default/em0120','Em0120 - Area 4 - Sample Block','0','a:5:{s:8:\"block_id\";s:2:\"16\";s:12:\"custom_class\";s:0:\"\";s:25:\"custom_html_wrapper_class\";s:0:\"\";s:22:\"custom_html_wrapper_id\";s:0:\"\";s:11:\"block_title\";s:0:\"\";}',0),
	(16,'cmswidget/widget_block','default/em0120','Em0120 - Sample Block - Alert Url','0','a:5:{s:8:\"block_id\";s:2:\"17\";s:12:\"custom_class\";s:0:\"\";s:25:\"custom_html_wrapper_class\";s:0:\"\";s:22:\"custom_html_wrapper_id\";s:0:\"\";s:11:\"block_title\";s:0:\"\";}',0),
	(17,'cmswidget/widget_block','default/em0120','Em0120 Sample Block - Extra Hint','0','a:5:{s:8:\"block_id\";s:2:\"18\";s:12:\"custom_class\";s:0:\"\";s:25:\"custom_html_wrapper_class\";s:0:\"\";s:22:\"custom_html_wrapper_id\";s:0:\"\";s:11:\"block_title\";s:0:\"\";}',0),
	(18,'cmswidget/widget_block','default/em0120','Em0120 Product Collateral Sample 1','0','a:5:{s:8:\"block_id\";s:2:\"19\";s:12:\"custom_class\";s:0:\"\";s:25:\"custom_html_wrapper_class\";s:0:\"\";s:22:\"custom_html_wrapper_id\";s:0:\"\";s:11:\"block_title\";s:13:\"Custom Tabs 1\";}',0),
	(19,'cmswidget/widget_block','default/em0120','Em0120  Product Collateral Sample 2','0','a:5:{s:8:\"block_id\";s:2:\"19\";s:12:\"custom_class\";s:0:\"\";s:25:\"custom_html_wrapper_class\";s:0:\"\";s:22:\"custom_html_wrapper_id\";s:0:\"\";s:11:\"block_title\";s:13:\"Custom Tabs N\";}',0),
	(20,'cmswidget/widget_block','default/em0120','Em0120 - Sidebar - Banner','0','a:5:{s:8:\"block_id\";s:2:\"20\";s:12:\"custom_class\";s:0:\"\";s:25:\"custom_html_wrapper_class\";s:0:\"\";s:22:\"custom_html_wrapper_id\";s:0:\"\";s:11:\"block_title\";s:0:\"\";}',0),
	(21,'cmswidget/widget_block','default/em0120','Em0120 - Sidebar - Banner Account','0','a:5:{s:8:\"block_id\";s:2:\"21\";s:12:\"custom_class\";s:0:\"\";s:25:\"custom_html_wrapper_class\";s:0:\"\";s:22:\"custom_html_wrapper_id\";s:0:\"\";s:11:\"block_title\";s:0:\"\";}',0),
	(22,'megamenupro/megamenupro','default/em0120','Sample Horizontal Menu','0','a:1:{s:4:\"menu\";N;}',0),
	(23,'megamenupro/megamenupro','default/em0120','Sample Menu Left','0','a:1:{s:4:\"menu\";N;}',0),
	(24,'megamenupro/megamenupro','default/em0120','Sample  Menu Right','0','a:1:{s:4:\"menu\";N;}',0),
	(25,'filterproducts/list','default/em0120','Em0120 - Main - All Products Tab','0','a:36:{s:11:\"type_filter\";s:1:\"5\";s:8:\"featured\";s:11:\"em_featured\";s:11:\"limit_count\";s:3:\"100\";s:12:\"column_count\";s:1:\"2\";s:8:\"order_by\";s:8:\"name asc\";s:12:\"custom_class\";s:0:\"\";s:14:\"frontend_title\";s:0:\"\";s:20:\"frontend_description\";s:0:\"\";s:10:\"item_class\";s:0:\"\";s:10:\"item_width\";s:0:\"\";s:11:\"item_height\";s:0:\"\";s:12:\"item_spacing\";s:0:\"\";s:4:\"show\";a:7:{i:0;s:5:\"thumb\";i:1;s:4:\"name\";i:2;s:3:\"sku\";i:3;s:5:\"price\";i:4;s:5:\"label\";i:5;s:9:\"addtocart\";i:6;s:5:\"addto\";}s:15:\"thumbnail_width\";s:3:\"283\";s:16:\"thumbnail_height\";s:3:\"396\";s:7:\"alt_img\";s:0:\"\";s:15:\"choose_template\";s:15:\"custom_template\";s:12:\"custom_theme\";s:41:\"em_filterproducts/home_product_grid.phtml\";s:14:\"cache_lifetime\";s:0:\"\";s:13:\"slider_enable\";s:1:\"1\";s:12:\"slider_items\";s:1:\"4\";s:20:\"slider_items_desktop\";s:1:\"4\";s:26:\"slider_items_desktop_small\";s:1:\"3\";s:19:\"slider_items_tablet\";s:1:\"2\";s:19:\"slider_items_mobile\";s:1:\"1\";s:12:\"slider_speed\";s:3:\"800\";s:18:\"slider_rewindspeed\";s:3:\"800\";s:15:\"slider_lazyload\";s:1:\"0\";s:15:\"slider_autoplay\";s:1:\"0\";s:18:\"slider_stoponhover\";s:1:\"0\";s:17:\"slider_navigation\";s:1:\"1\";s:17:\"slider_pagination\";s:1:\"0\";s:17:\"slider_mouse_drag\";s:1:\"0\";s:17:\"slider_touch_drag\";s:1:\"1\";s:20:\"slider_scrollperpage\";s:1:\"0\";s:16:\"slider_unique_id\";s:0:\"\";}',0),
	(26,'filterproducts/list','default/em0120','Em0120 - Main - Special Products Tab','0','a:36:{s:11:\"type_filter\";s:1:\"1\";s:8:\"featured\";s:7:\"em_deal\";s:11:\"limit_count\";s:3:\"100\";s:12:\"column_count\";s:1:\"2\";s:8:\"order_by\";s:8:\"name asc\";s:12:\"custom_class\";s:0:\"\";s:14:\"frontend_title\";s:0:\"\";s:20:\"frontend_description\";s:0:\"\";s:10:\"item_class\";s:0:\"\";s:10:\"item_width\";s:0:\"\";s:11:\"item_height\";s:0:\"\";s:12:\"item_spacing\";s:0:\"\";s:4:\"show\";a:7:{i:0;s:5:\"thumb\";i:1;s:4:\"name\";i:2;s:3:\"sku\";i:3;s:5:\"price\";i:4;s:5:\"label\";i:5;s:9:\"addtocart\";i:6;s:5:\"addto\";}s:15:\"thumbnail_width\";s:3:\"283\";s:16:\"thumbnail_height\";s:3:\"396\";s:7:\"alt_img\";s:0:\"\";s:15:\"choose_template\";s:15:\"custom_template\";s:12:\"custom_theme\";s:41:\"em_filterproducts/home_product_grid.phtml\";s:14:\"cache_lifetime\";s:0:\"\";s:13:\"slider_enable\";s:1:\"1\";s:12:\"slider_items\";s:1:\"4\";s:20:\"slider_items_desktop\";s:1:\"4\";s:26:\"slider_items_desktop_small\";s:1:\"3\";s:19:\"slider_items_tablet\";s:1:\"2\";s:19:\"slider_items_mobile\";s:1:\"1\";s:12:\"slider_speed\";s:3:\"800\";s:18:\"slider_rewindspeed\";s:3:\"800\";s:15:\"slider_lazyload\";s:1:\"0\";s:15:\"slider_autoplay\";s:1:\"0\";s:18:\"slider_stoponhover\";s:1:\"0\";s:17:\"slider_navigation\";s:1:\"1\";s:17:\"slider_pagination\";s:1:\"0\";s:17:\"slider_mouse_drag\";s:1:\"0\";s:17:\"slider_touch_drag\";s:1:\"1\";s:20:\"slider_scrollperpage\";s:1:\"0\";s:16:\"slider_unique_id\";s:0:\"\";}',0),
	(27,'filterproducts/list','default/em0120','Em0120 - Main - New Products Tab','0','a:36:{s:11:\"type_filter\";s:1:\"3\";s:8:\"featured\";s:11:\"em_featured\";s:11:\"limit_count\";s:3:\"100\";s:12:\"column_count\";s:1:\"2\";s:8:\"order_by\";s:8:\"name asc\";s:12:\"custom_class\";s:0:\"\";s:14:\"frontend_title\";s:0:\"\";s:20:\"frontend_description\";s:0:\"\";s:10:\"item_class\";s:0:\"\";s:10:\"item_width\";s:0:\"\";s:11:\"item_height\";s:0:\"\";s:12:\"item_spacing\";s:0:\"\";s:4:\"show\";a:7:{i:0;s:5:\"thumb\";i:1;s:4:\"name\";i:2;s:3:\"sku\";i:3;s:5:\"price\";i:4;s:5:\"label\";i:5;s:9:\"addtocart\";i:6;s:5:\"addto\";}s:15:\"thumbnail_width\";s:3:\"283\";s:16:\"thumbnail_height\";s:3:\"396\";s:7:\"alt_img\";s:0:\"\";s:15:\"choose_template\";s:15:\"custom_template\";s:12:\"custom_theme\";s:41:\"em_filterproducts/home_product_grid.phtml\";s:14:\"cache_lifetime\";s:0:\"\";s:13:\"slider_enable\";s:1:\"1\";s:12:\"slider_items\";s:1:\"4\";s:20:\"slider_items_desktop\";s:1:\"4\";s:26:\"slider_items_desktop_small\";s:1:\"3\";s:19:\"slider_items_tablet\";s:1:\"2\";s:19:\"slider_items_mobile\";s:1:\"1\";s:12:\"slider_speed\";s:3:\"800\";s:18:\"slider_rewindspeed\";s:3:\"800\";s:15:\"slider_lazyload\";s:1:\"1\";s:15:\"slider_autoplay\";s:1:\"0\";s:18:\"slider_stoponhover\";s:1:\"0\";s:17:\"slider_navigation\";s:1:\"1\";s:17:\"slider_pagination\";s:1:\"0\";s:17:\"slider_mouse_drag\";s:1:\"0\";s:17:\"slider_touch_drag\";s:1:\"1\";s:20:\"slider_scrollperpage\";s:1:\"0\";s:16:\"slider_unique_id\";s:0:\"\";}',0),
	(28,'tabs/group','default/em0120','Em0120 - Main - Products Tabs','0','a:35:{s:5:\"title\";s:0:\"\";s:17:\"short_description\";s:0:\"\";s:12:\"custom_class\";s:19:\"main-products-block\";s:14:\"tabs_unique_id\";s:0:\"\";s:7:\"title_1\";a:13:{i:0;s:11:\"All Product\";i:7;s:0:\"\";i:1;s:0:\"\";i:3;s:0:\"\";i:6;s:0:\"\";i:2;s:0:\"\";i:4;s:0:\"\";i:9;s:0:\"\";i:10;s:0:\"\";i:11;s:0:\"\";i:12;s:0:\"\";i:13;s:0:\"\";i:5;s:0:\"\";}s:7:\"block_1\";s:0:\"\";s:10:\"instance_1\";s:2:\"25\";s:7:\"title_2\";a:13:{i:0;s:7:\"Special\";i:7;s:0:\"\";i:1;s:0:\"\";i:3;s:0:\"\";i:6;s:0:\"\";i:2;s:0:\"\";i:4;s:0:\"\";i:9;s:0:\"\";i:10;s:0:\"\";i:11;s:0:\"\";i:12;s:0:\"\";i:13;s:0:\"\";i:5;s:0:\"\";}s:7:\"block_2\";s:0:\"\";s:10:\"instance_2\";s:2:\"26\";s:7:\"title_3\";a:13:{i:0;s:11:\"New Arrival\";i:7;s:0:\"\";i:1;s:0:\"\";i:3;s:0:\"\";i:6;s:0:\"\";i:2;s:0:\"\";i:4;s:0:\"\";i:9;s:0:\"\";i:10;s:0:\"\";i:11;s:0:\"\";i:12;s:0:\"\";i:13;s:0:\"\";i:5;s:0:\"\";}s:7:\"block_3\";s:0:\"\";s:10:\"instance_3\";s:2:\"27\";s:7:\"title_4\";a:13:{i:0;s:0:\"\";i:7;s:0:\"\";i:1;s:0:\"\";i:3;s:0:\"\";i:6;s:0:\"\";i:2;s:0:\"\";i:4;s:0:\"\";i:9;s:0:\"\";i:10;s:0:\"\";i:11;s:0:\"\";i:12;s:0:\"\";i:13;s:0:\"\";i:5;s:0:\"\";}s:7:\"block_4\";s:0:\"\";s:10:\"instance_4\";s:0:\"\";s:7:\"title_5\";a:13:{i:0;s:0:\"\";i:7;s:0:\"\";i:1;s:0:\"\";i:3;s:0:\"\";i:6;s:0:\"\";i:2;s:0:\"\";i:4;s:0:\"\";i:9;s:0:\"\";i:10;s:0:\"\";i:11;s:0:\"\";i:12;s:0:\"\";i:13;s:0:\"\";i:5;s:0:\"\";}s:7:\"block_5\";s:0:\"\";s:10:\"instance_5\";s:0:\"\";s:7:\"title_6\";a:13:{i:0;s:0:\"\";i:7;s:0:\"\";i:1;s:0:\"\";i:3;s:0:\"\";i:6;s:0:\"\";i:2;s:0:\"\";i:4;s:0:\"\";i:9;s:0:\"\";i:10;s:0:\"\";i:11;s:0:\"\";i:12;s:0:\"\";i:13;s:0:\"\";i:5;s:0:\"\";}s:7:\"block_6\";s:0:\"\";s:10:\"instance_6\";s:0:\"\";s:7:\"title_7\";a:13:{i:0;s:0:\"\";i:7;s:0:\"\";i:1;s:0:\"\";i:3;s:0:\"\";i:6;s:0:\"\";i:2;s:0:\"\";i:4;s:0:\"\";i:9;s:0:\"\";i:10;s:0:\"\";i:11;s:0:\"\";i:12;s:0:\"\";i:13;s:0:\"\";i:5;s:0:\"\";}s:7:\"block_7\";s:0:\"\";s:10:\"instance_7\";s:0:\"\";s:7:\"title_8\";a:13:{i:0;s:0:\"\";i:7;s:0:\"\";i:1;s:0:\"\";i:3;s:0:\"\";i:6;s:0:\"\";i:2;s:0:\"\";i:4;s:0:\"\";i:9;s:0:\"\";i:10;s:0:\"\";i:11;s:0:\"\";i:12;s:0:\"\";i:13;s:0:\"\";i:5;s:0:\"\";}s:7:\"block_8\";s:0:\"\";s:10:\"instance_8\";s:0:\"\";s:7:\"title_9\";a:13:{i:0;s:0:\"\";i:7;s:0:\"\";i:1;s:0:\"\";i:3;s:0:\"\";i:6;s:0:\"\";i:2;s:0:\"\";i:4;s:0:\"\";i:9;s:0:\"\";i:10;s:0:\"\";i:11;s:0:\"\";i:12;s:0:\"\";i:13;s:0:\"\";i:5;s:0:\"\";}s:7:\"block_9\";s:0:\"\";s:10:\"instance_9\";s:0:\"\";s:8:\"title_10\";a:13:{i:0;s:0:\"\";i:7;s:0:\"\";i:1;s:0:\"\";i:3;s:0:\"\";i:6;s:0:\"\";i:2;s:0:\"\";i:4;s:0:\"\";i:9;s:0:\"\";i:10;s:0:\"\";i:11;s:0:\"\";i:12;s:0:\"\";i:13;s:0:\"\";i:5;s:0:\"\";}s:8:\"block_10\";s:0:\"\";s:11:\"instance_10\";s:0:\"\";s:8:\"instance\";s:2:\"28\";}',0),
	(29,'cmswidget/widget_block','default/em0120','Em0120 - Area 17 - Promotion Banners','0','a:5:{s:8:\"block_id\";s:2:\"39\";s:12:\"custom_class\";s:24:\"area17-promotion-banners\";s:25:\"custom_html_wrapper_class\";s:0:\"\";s:22:\"custom_html_wrapper_id\";s:0:\"\";s:11:\"block_title\";s:0:\"\";}',0);

/*!40000 ALTER TABLE `widget_instance` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table widget_instance_page
# ------------------------------------------------------------

DROP TABLE IF EXISTS `widget_instance_page`;

CREATE TABLE `widget_instance_page` (
  `page_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Page Id',
  `instance_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Instance Id',
  `page_group` varchar(25) DEFAULT NULL COMMENT 'Block Group Type',
  `layout_handle` varchar(255) DEFAULT NULL COMMENT 'Layout Handle',
  `block_reference` varchar(255) DEFAULT NULL COMMENT 'Block Reference',
  `page_for` varchar(25) DEFAULT NULL COMMENT 'For instance entities',
  `entities` text COMMENT 'Catalog entities (comma separated)',
  `page_template` varchar(255) DEFAULT NULL COMMENT 'Path to widget template',
  PRIMARY KEY (`page_id`),
  KEY `IDX_WIDGET_INSTANCE_PAGE_INSTANCE_ID` (`instance_id`),
  CONSTRAINT `FK_WIDGET_INSTANCE_PAGE_INSTANCE_ID_WIDGET_INSTANCE_INSTANCE_ID` FOREIGN KEY (`instance_id`) REFERENCES `widget_instance` (`instance_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Instance of Widget on Page';

LOCK TABLES `widget_instance_page` WRITE;
/*!40000 ALTER TABLE `widget_instance_page` DISABLE KEYS */;

INSERT INTO `widget_instance_page` (`page_id`, `instance_id`, `page_group`, `layout_handle`, `block_reference`, `page_for`, `entities`, `page_template`)
VALUES
	(1,1,'all_pages','default','em_area1',NULL,'',''),
	(2,2,'pages','cms_index_index','em_area2',NULL,'',''),
	(3,3,'pages','cms_index_index','em_area5',NULL,'',''),
	(4,4,'pages','cms_index_index','em_area5',NULL,'',''),
	(5,5,'pages','cms_index_index','em_area6',NULL,'',''),
	(6,6,'pages','cms_index_index','em_area7',NULL,'',''),
	(7,7,'pages','cms_index_index','em_area8',NULL,'',''),
	(8,8,'pages','cms_index_index','em_area8',NULL,'',''),
	(9,9,'all_pages','default','em_area9',NULL,'',''),
	(10,10,'all_pages','default','em_area10',NULL,'',''),
	(11,11,'all_pages','default','bottom.container',NULL,'',''),
	(12,12,'all_pages','default','em0120.top.menu',NULL,'',''),
	(13,13,'all_products','catalog_product_view','left',NULL,'',''),
	(14,13,'notanchor_categories','catalog_category_default','left',NULL,'',''),
	(15,13,'anchor_categories','catalog_category_layered','left',NULL,'',''),
	(16,14,'all_products','catalog_product_view','em_area3',NULL,'',''),
	(17,15,'all_products','catalog_product_view','em_area4',NULL,'',''),
	(18,16,'all_products','catalog_product_view','alert.urls',NULL,'',''),
	(19,17,'all_products','catalog_product_view','product.info.extrahint',NULL,'',''),
	(20,18,'all_products','catalog_product_view','product.info.additonal_collateral',NULL,'',''),
	(21,19,'all_products','catalog_product_view','product.info.additonal_collateral',NULL,'',''),
	(22,20,'pages','checkout_onepage_index','em_area12',NULL,'',''),
	(23,20,'pages','customer_account_forgotpassword','em_area12',NULL,'',''),
	(24,20,'pages','customer_account_create','em_area12',NULL,'',''),
	(25,20,'pages','customer_account_logoutsuccess','em_area12',NULL,'',''),
	(26,20,'pages','customer_account_login','em_area12',NULL,'',''),
	(27,20,'pages','customer_account_edit','em_area12',NULL,'',''),
	(28,20,'pages','customer_account','em_area12',NULL,'',''),
	(29,20,'all_products','catalog_product_view','em_area12',NULL,'',''),
	(30,20,'notanchor_categories','catalog_category_default','em_area12',NULL,'',''),
	(31,20,'anchor_categories','catalog_category_layered','em_area12',NULL,'',''),
	(32,20,'pages','blog_tag_taglist','em_area12',NULL,'',''),
	(33,20,'pages','blog_tag_view','em_area12',NULL,'',''),
	(34,20,'pages','blog_index_index','em_area12',NULL,'',''),
	(35,20,'pages','blog_category_view','em_area12',NULL,'',''),
	(36,20,'pages','blog_post_view','em_area12',NULL,'',''),
	(37,20,'pages','page_two_columns_left','em_area1',NULL,'',''),
	(38,21,'pages','checkout_onepage_index','em_area12',NULL,'',''),
	(39,21,'pages','customer_account','em_area12',NULL,'',''),
	(40,21,'pages','customer_account_forgotpassword','em_area12',NULL,'',''),
	(41,21,'pages','customer_account_create','em_area12',NULL,'',''),
	(42,21,'pages','customer_account_logoutsuccess','em_area12',NULL,'',''),
	(43,21,'pages','customer_account_login','em_area12',NULL,'',''),
	(44,21,'pages','customer_account_edit','em_area12',NULL,'',''),
	(45,22,'all_pages','default','em0120.top.menu',NULL,'',''),
	(46,23,'all_pages','default','left',NULL,'',''),
	(47,24,'all_pages','default','right',NULL,'',''),
	(49,28,'pages','cms_index_index','content',NULL,'','emtabs/group.phtml'),
	(50,29,'all_pages','default','em_area17',NULL,'','');

/*!40000 ALTER TABLE `widget_instance_page` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table widget_instance_page_layout
# ------------------------------------------------------------

DROP TABLE IF EXISTS `widget_instance_page_layout`;

CREATE TABLE `widget_instance_page_layout` (
  `page_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Page Id',
  `layout_update_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Layout Update Id',
  UNIQUE KEY `UNQ_WIDGET_INSTANCE_PAGE_LAYOUT_LAYOUT_UPDATE_ID_PAGE_ID` (`layout_update_id`,`page_id`),
  KEY `IDX_WIDGET_INSTANCE_PAGE_LAYOUT_PAGE_ID` (`page_id`),
  KEY `IDX_WIDGET_INSTANCE_PAGE_LAYOUT_LAYOUT_UPDATE_ID` (`layout_update_id`),
  CONSTRAINT `FK_WIDGET_INSTANCE_PAGE_LYT_PAGE_ID_WIDGET_INSTANCE_PAGE_PAGE_ID` FOREIGN KEY (`page_id`) REFERENCES `widget_instance_page` (`page_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_0A5D06DCEC6A6845F50E5FAAC5A1C96D` FOREIGN KEY (`layout_update_id`) REFERENCES `core_layout_update` (`layout_update_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Layout updates';

LOCK TABLES `widget_instance_page_layout` WRITE;
/*!40000 ALTER TABLE `widget_instance_page_layout` DISABLE KEYS */;

INSERT INTO `widget_instance_page_layout` (`page_id`, `layout_update_id`)
VALUES
	(1,1),
	(2,2),
	(3,3),
	(4,4),
	(5,5),
	(6,6),
	(7,7),
	(8,8),
	(9,9),
	(10,10),
	(11,11),
	(12,12),
	(13,13),
	(14,14),
	(15,15),
	(16,16),
	(17,17),
	(18,18),
	(19,19),
	(20,20),
	(21,21),
	(22,22),
	(23,23),
	(24,24),
	(25,25),
	(26,26),
	(27,27),
	(28,28),
	(29,29),
	(30,30),
	(31,31),
	(32,32),
	(33,33),
	(34,34),
	(35,35),
	(36,36),
	(37,37),
	(38,38),
	(39,39),
	(40,40),
	(41,41),
	(42,42),
	(43,43),
	(44,44),
	(45,45),
	(46,46),
	(47,47),
	(49,49),
	(50,50);

/*!40000 ALTER TABLE `widget_instance_page_layout` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table wishlist
# ------------------------------------------------------------

DROP TABLE IF EXISTS `wishlist`;

CREATE TABLE `wishlist` (
  `wishlist_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Wishlist ID',
  `customer_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Customer ID',
  `shared` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Sharing flag (0 or 1)',
  `sharing_code` varchar(32) DEFAULT NULL COMMENT 'Sharing encrypted code',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'Last updated date',
  PRIMARY KEY (`wishlist_id`),
  UNIQUE KEY `UNQ_WISHLIST_CUSTOMER_ID` (`customer_id`),
  KEY `IDX_WISHLIST_SHARED` (`shared`),
  CONSTRAINT `FK_WISHLIST_CUSTOMER_ID_CUSTOMER_ENTITY_ENTITY_ID` FOREIGN KEY (`customer_id`) REFERENCES `customer_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Wishlist main Table';



# Dump of table wishlist_item
# ------------------------------------------------------------

DROP TABLE IF EXISTS `wishlist_item`;

CREATE TABLE `wishlist_item` (
  `wishlist_item_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Wishlist item ID',
  `wishlist_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Wishlist ID',
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product ID',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store ID',
  `added_at` timestamp NULL DEFAULT NULL COMMENT 'Add date and time',
  `description` text COMMENT 'Short description of wish list item',
  `qty` decimal(12,4) NOT NULL COMMENT 'Qty',
  PRIMARY KEY (`wishlist_item_id`),
  KEY `IDX_WISHLIST_ITEM_WISHLIST_ID` (`wishlist_id`),
  KEY `IDX_WISHLIST_ITEM_PRODUCT_ID` (`product_id`),
  KEY `IDX_WISHLIST_ITEM_STORE_ID` (`store_id`),
  CONSTRAINT `FK_WISHLIST_ITEM_WISHLIST_ID_WISHLIST_WISHLIST_ID` FOREIGN KEY (`wishlist_id`) REFERENCES `wishlist` (`wishlist_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_WISHLIST_ITEM_PRODUCT_ID_CATALOG_PRODUCT_ENTITY_ENTITY_ID` FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_WISHLIST_ITEM_STORE_ID_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `core_store` (`store_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Wishlist items';



# Dump of table wishlist_item_option
# ------------------------------------------------------------

DROP TABLE IF EXISTS `wishlist_item_option`;

CREATE TABLE `wishlist_item_option` (
  `option_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Option Id',
  `wishlist_item_id` int(10) unsigned NOT NULL COMMENT 'Wishlist Item Id',
  `product_id` int(10) unsigned NOT NULL COMMENT 'Product Id',
  `code` varchar(255) NOT NULL COMMENT 'Code',
  `value` text COMMENT 'Value',
  PRIMARY KEY (`option_id`),
  KEY `FK_A014B30B04B72DD0EAB3EECD779728D6` (`wishlist_item_id`),
  CONSTRAINT `FK_A014B30B04B72DD0EAB3EECD779728D6` FOREIGN KEY (`wishlist_item_id`) REFERENCES `wishlist_item` (`wishlist_item_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Wishlist Item Option Table';




/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
