/*
SQLyog Enterprise v12.09 (64 bit)
MySQL - 5.6.29 : Database - adnew
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`adnew` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `adnew`;

/*Table structure for table `account_app_device_uuid` */

DROP TABLE IF EXISTS `account_app_device_uuid`;

CREATE TABLE `account_app_device_uuid` (
  `accountId` varchar(50) NOT NULL,
  `currentadpool` varchar(10) DEFAULT NULL,
  `currentoffset` varchar(10) DEFAULT NULL,
  `updatetime` timestamp NULL DEFAULT NULL,
  `createtime` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`accountId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

/*Data for the table `account_app_device_uuid` */

/*Table structure for table `registerapp` */

DROP TABLE IF EXISTS `registerapp`;

CREATE TABLE `registerapp` (
  `id` int(50) NOT NULL AUTO_INCREMENT,
  `appid` varchar(20) DEFAULT NULL,
  `batchnum` varchar(20) DEFAULT NULL,
  `channelid` varchar(30) DEFAULT NULL,
  `tel` varchar(20) DEFAULT NULL,
  `imei` varchar(20) DEFAULT NULL,
  `imsi` varchar(20) DEFAULT NULL,
  `language` varchar(20) DEFAULT NULL,
  `desity` varchar(10) DEFAULT NULL,
  `model` varchar(20) DEFAULT NULL,
  `mac` varchar(20) DEFAULT NULL,
  `packagename` varchar(30) DEFAULT NULL,
  `appname` varchar(20) DEFAULT NULL,
  `versioncode` varchar(10) DEFAULT NULL,
  `carrier` varchar(20) DEFAULT NULL,
  `createdate` timestamp NULL DEFAULT NULL,
  `androidversion` varchar(20) DEFAULT NULL,
  `ip` varchar(20) DEFAULT NULL,
  `iccid` varchar(50) DEFAULT NULL,
  `screen` varchar(20) DEFAULT NULL,
  `sim` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

/*Data for the table `registerapp` */

insert  into `registerapp`(`id`,`appid`,`batchnum`,`channelid`,`tel`,`imei`,`imsi`,`language`,`desity`,`model`,`mac`,`packagename`,`appname`,`versioncode`,`carrier`,`createdate`,`androidversion`,`ip`,`iccid`,`screen`,`sim`) values (1,'MidAutumnMeiZi','batchnum',NULL,'','868582020345094','è¯å¥½','zh','480*854',NULL,'003230197521','bai.dota.du','åè§£äººè¡£','1','CMCC','2016-09-29 00:00:00','5.1','','8986000615168a396807','',NULL),(2,'test','batchnum',NULL,'','866952020704404','è¯å¥½','zh','1080*1920',NULL,'e45aa25169d2','bai.dota.du','åè§£äººè¡£','1','CMCC','2016-09-29 00:00:00','4.4.4','','89860090249478460548','',NULL),(3,'test','batchnum',NULL,'8613165499568','862142031222174','è¯å¥½','zh','1080*1920',NULL,'020000000000','bai.dota.du','åè§£äººè¡£','1','CMCC','2016-09-29 00:00:00','6.0','','89860116817055735806','',NULL),(4,'MidAutumnMeiZi','batchnum',NULL,'','864870028786904','è¯å¥½','zh','480*854',NULL,'00130039798a','bai.dota.du','åè§£äººè¡£','1','CMCC','2016-09-29 00:00:00','4.4.3','','898600b8231486ef5506','',NULL),(5,'MidAutumnMeiZi','batchnum',NULL,'','865367022056221','è¯å¥½','zh','540*960',NULL,'7c70bc011769','bai.dota.du','åè§£äººè¡£','1','null','2016-09-29 00:00:00','5.1','','89860116841017653832','',NULL),(6,'MidAutumnMeiZi','batchnum',NULL,'','860779038047682','è¯å¥½','zh','480*854',NULL,'c8f2301e6c97','bai.dota.du','åè§£äººè¡£','1','CMCC','2016-09-29 00:00:00','4.4.4','','89860097189454795500','',NULL),(7,'MidAutumnMeiZi','batchnum',NULL,'','867085020544964','è¯å¥½','zh','480*854',NULL,'94fae831078c','bai.dota.du','åè§£äººè¡£','1','CMCC','2016-09-30 00:00:00','4.4.4','','89860034056958297515','',NULL),(8,'MidAutumnMeiZi','batchnum',NULL,'','357212075663005','è¯å¥½','zh','1080*1920',NULL,'9C2A83093A0F','bai.dota.du','åè§£äººè¡£','1','CMCC','2016-09-30 00:00:00','5.1.1','','898600e5151430079484','',NULL),(9,'MidAutumnMeiZi','batchnum',NULL,'','867863027027963','è¯å¥½','zh','540*960',NULL,'ec5a86b25c02','bai.dota.du','åè§£äººè¡£','1','CMCC','2016-09-30 00:00:00','4.4.4','','89860058101650131849','',NULL),(10,'MidAutumnMeiZi','batchnum',NULL,'8615544815574','866028029767781','è¯å¥½','zh','720*1280',NULL,'f42981cf9917','bai.dota.du','åè§£äººè¡£','1','CUC','2016-09-30 00:00:00','4.4.4','','89860115818037892930','',NULL),(11,'MidAutumnMeiZi','batchnum',NULL,'','866331022295952','è¯å¥½','zh','720*1280',NULL,'50a72b13e497','bai.dota.du','åè§£äººè¡£','1','CMCC','2016-09-30 00:00:00','4.4.2','','898600C222130A248074','',NULL),(12,'MidAutumnMeiZi','batchnum',NULL,'','864616024492181','è¯å¥½','zh','540*960',NULL,'a43d783819f0','bai.dota.du','åè§£äººè¡£','1','CMCC','2016-09-30 00:00:00','4.3','','89860004051957794986','',NULL),(13,'MidAutumnMeiZi','batchnum',NULL,'','864870028786904','è¯å¥½','zh','480*854',NULL,'00130039798a','bai.dota.du','åè§£äººè¡£','1','CMCC','2016-09-30 00:00:00','4.4.3','','898600b8231486ef5506','',NULL),(14,'MidAutumnMeiZi','batchnum',NULL,'','860294033586213','è¯å¥½','zh','720*1280',NULL,'000ce72fd2aa','bai.dota.du','åè§£äººè¡£','1','CMCC','2016-09-30 00:00:00','5.1','','89860040101650147313','',NULL),(15,'MidAutumnMeiZi','batchnum',NULL,'8615553492537','863242020032276','è¯å¥½','zh','540*960',NULL,'bce59f35f407','bai.dota.du','åè§£äººè¡£','1','CUC','2016-09-30 00:00:00','4.4.2','','89860116817041089011','',NULL),(16,'MidAutumnMeiZi','batchnum',NULL,'123456789','864203027230171','è¯å¥½','zh','480*854',NULL,'94d859de460c','bai.dota.du','åè§£äººè¡£','1','CMCC','2016-09-30 00:00:00','4.4.4','','898602a4088655084069','',NULL),(17,'MidAutumnVideo','batchnum',NULL,'','','è¯å¥½','zh','1080*1920',NULL,'020000000000','lm.ss.sn','Video','1','CNC','2016-09-30 00:00:00','6.0.1','','','',NULL),(18,'MidAutumnVideo','batchnum',NULL,'','','è¯å¥½','zh','1080*1920',NULL,'020000000000','lm.ss.sn','Video','1','CNC','2016-09-30 00:00:00','6.0.1','','','',NULL),(19,'MidAutumnVideo','batchnum',NULL,'','','è¯å¥½','zh','1080*1920',NULL,'020000000000','lm.ss.sn','Video','1','CNC','2016-09-30 00:00:00','6.0.1','','','',NULL),(20,'MidAutumnMeiZi','batchnum',NULL,'','867155022893402','è¯å¥½','zh','720*1280',NULL,'d05ba876f2b4','bai.dota.du','åè§£äººè¡£','1','CMCC','2016-09-30 00:00:00','5.1','','89860068271474055710','',NULL),(21,'MidAutumnMeiZi','batchnum',NULL,'','868612024945241','è¯å¥½','zh','720*1280',NULL,'9492bc3990cc','bai.dota.du','åè§£äººè¡£','1','CMCC','2016-09-30 00:00:00','5.1','','898600182214071f2661','',NULL),(22,'MidAutumnMeiZi','batchnum',NULL,'','861642031691691','è¯å¥½','zh','480*854',NULL,'4045da760288','bai.dota.du','åè§£äººè¡£','1','CMCC','2016-09-30 00:00:00','5.1','','898600f12315971b2303','',NULL),(23,'MidAutumnVideo','batchnum',NULL,'','','è¯å¥½','zh','480*854',NULL,'020000000000','lm.ss.sn','Video','1','CNC','2016-09-30 00:00:00','6.0.1','','','',NULL),(24,'MidAutumnVideo','batchnum',NULL,'','','è¯å¥½','zh','480*854',NULL,'020000000000','lm.ss.sn','Video','1','CNC','2016-09-30 00:00:00','6.0.1','','','',NULL),(25,'MidAutumnMeiZi','batchnum',NULL,'','860394030332106','è¯å¥½','zh','480*854',NULL,'','bai.dota.du','åè§£äººè¡£','1','CMCC','2016-09-30 00:00:00','5.1','','8986001615169a813375','',NULL),(26,'MidAutumnMeiZi','batchnum',NULL,'','869598027281701','è¯å¥½','zh','1080*1776',NULL,'4cfb45eac338','bai.dota.du','åè§£äººè¡£','1','CMCC','2016-09-30 00:00:00','5.1','','89860098243575812367','',NULL),(27,'MidAutumnMeiZi','batchnum',NULL,'8613296359155','864693022097619','è¯å¥½','zh','1080*1920',NULL,'b898f7aeac93','bai.dota.du','åè§£äººè¡£','1','CUC','2016-09-30 00:00:00','4.3','','89860116817030443443','',NULL),(28,'MidAutumnMeiZi','batchnum',NULL,'','860348031357173','è¯å¥½','zh','480*854',NULL,'4045dadd0e08','bai.dota.du','åè§£äººè¡£','1','CMCC','2016-09-30 00:00:00','5.1','','8986001615145a668374','',NULL),(29,'MidAutumnMeiZi','batchnum',NULL,'','860148030738492','è¯å¥½','zh','480*854',NULL,'4045da1becbb','bai.dota.du','åè§£äººè¡£','1','CMCC','2016-09-30 00:00:00','5.1','','898602a21235f5826646','',NULL),(30,'MidAutumnVideo','batchnum',NULL,'','355456061117573','è¯å¥½','zh','720*1184',NULL,'4480eb1e6d19','lm.ss.sn','Video','1','CMCC','2016-09-30 00:00:00','5.0.2','','89860067177677295520','',NULL),(31,'MidAutumnMeiZi','batchnum',NULL,'null','null','è¯å¥½','zh','720*1280',NULL,'b8b42e001c57','bai.dota.du','åè§£äººè¡£','1','CMCC','2016-09-30 00:00:00','5.0','','null','',NULL),(32,'MidAutumnVideo','batchnum',NULL,'13752970301','a10b948d144aeea','è¯å¥½','zh','480*640',NULL,'080027C446C0','lm.ss.sn','Video','1','null','2016-09-30 00:00:00','4.4.2','','133b1fd3b','',NULL),(33,'MidAutumnMeiZi','batchnum',NULL,'','869746023937376','è¯å¥½','zh','720*1280',NULL,'b8b42e001c57','bai.dota.du','åè§£äººè¡£','1','CMCC','2016-09-30 00:00:00','5.0','','89860024053958431301','',NULL),(34,'MidAutumnMeiZi','batchnum',NULL,'15377346328','A000005579E3DA','è¯å¥½','zh','720*1280',NULL,'f48e921849b2','bai.dota.du','åè§£äººè¡£','1','CNC','2016-09-30 00:00:00','4.4.4','','89860312907340108489','',NULL),(35,'MidAutumnMeiZi','batchnum',NULL,'8615255687007','867357029683931','è¯å¥½','zh','480*854',NULL,'0027150030e2','bai.dota.du','åè§£äººè¡£','1','CMCC','2016-09-30 00:00:00','5.1','','89860035120845483213','',NULL),(36,'MidAutumnMeiZi','batchnum',NULL,'','869918021330587','è¯å¥½','zh','720*1280',NULL,'fc1a11280eee','bai.dota.du','åè§£äººè¡£','1','CMCC','2016-09-30 00:00:00','5.0','','8986003915167a019553','',NULL),(37,'test','test','test',NULL,'861980034912387',NULL,'zh','1080*1920',NULL,'742344498420','wv.cl.sc','Wave_SourceCode','1',NULL,'2016-09-30 15:02:25','5.1.1','192.168.2.12',NULL,'','no sim card'),(38,'test','test','test',NULL,'861980034912387',NULL,'zh','1080*1920',NULL,'742344498420','wv.cl.sc','Wave_SourceCode','1',NULL,'2016-09-30 15:02:25','5.1.1','192.168.2.12',NULL,'','no sim card'),(39,'MidAutumnMeiZi','batchnum',NULL,'','863120026480725','è¯å¥½','zh','480*854',NULL,'04e08508799a','bai.dota.du','åè§£äººè¡£','1','CMCC','2016-09-30 00:00:00','4.4.2','','898600340616a5646202','',NULL),(40,'MidAutumnMeiZi','batchnum',NULL,'','861760039815177','è¯å¥½','zh','720*1280',NULL,'0456043a62c7','bai.dota.du','åè§£äººè¡£','1','CMCC','2016-09-30 00:00:00','5.1','','89860064061595152868','',NULL),(41,'MidAutumnVideo','batchnum',NULL,'','A10000496F2F40','è¯å¥½','zh','480*854',NULL,'000af5053d04','lm.ss.sn','Video','1','CMCC','2016-09-30 00:00:00','4.4.4','','898600','',NULL),(42,'MidAutumnMeiZi','batchnum',NULL,'','866983022368070','è¯å¥½','zh','480*854',NULL,'005043840d0c','bai.dota.du','åè§£äººè¡£','1','CMCC','2016-09-30 00:00:00','4.4.3','','898600c822168e855326','',NULL),(43,'MidAutumnMeiZi','batchnum',NULL,'8615255687007','867357029683931','è¯å¥½','zh','480*854',NULL,'0027150030e2','bai.dota.du','åè§£äººè¡£','1','CMCC','2016-09-30 00:00:00','5.1','','89860035120845483213','',NULL);

/*Table structure for table `statistics` */

DROP TABLE IF EXISTS `statistics`;

CREATE TABLE `statistics` (
  `id` int(50) NOT NULL AUTO_INCREMENT,
  `ad_pool_id` mediumint(20) DEFAULT NULL,
  `packagename` varchar(20) DEFAULT NULL,
  `channelid` varchar(30) DEFAULT NULL,
  `appid` varchar(20) DEFAULT NULL,
  `statistics_type` int(50) DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

/*Data for the table `statistics` */

insert  into `statistics`(`id`,`ad_pool_id`,`packagename`,`channelid`,`appid`,`statistics_type`,`create_date`) values (2,50,'报名','频道id','test1',4,'2016-09-26 10:01:54'),(3,57,'报名112332','testchannelid','MidAutumnMeiZi',4,'2016-09-29 10:13:17'),(4,50,'报名112332da','testchannelid','test2',4,'2016-09-26 10:20:59'),(7,57,'com.wandoujia.roshan','test','test',4,'2016-09-29 18:35:29'),(8,57,'com.wandoujia.roshan','test','test',4,'2016-09-29 18:35:32'),(9,57,'com.wandoujia.roshan','test','MidAutumnMeiZi',4,'2016-09-29 18:38:45'),(10,57,'com.xxx.sgrzllb','test','test',4,'2016-09-29 19:44:02'),(11,57,'com.ddd.mmazm','test','MidAutumnMeiZi',2,'2016-09-29 19:44:14'),(12,57,'com.ddd.mmazm','test','test',2,'2016-09-29 09:12:25'),(13,57,'com.ddd.mmazm','test','test',1,'2016-09-30 09:12:29'),(14,56,'com.xxx.sgrzllb','test','test',1,'2016-09-30 10:02:13'),(15,56,'com.xxx.sgrzllb','test','test',3,'2016-09-30 10:02:51'),(16,56,'com.xxx.sgrzllb','test','test',1,'2016-09-30 10:09:46'),(17,57,'com.ddd.mmazm','test','test',1,'2016-09-30 10:12:26'),(18,57,'com.ddd.mmazm','test','test',1,'2016-09-30 11:01:00'),(19,57,'com.ddd.mmazm','test','test',1,'2016-09-30 11:01:08'),(20,57,'com.ddd.mmazm','test','test',1,'2016-09-30 11:01:26'),(21,57,'com.ddd.mmazm','test','test',1,'2016-09-30 11:02:12'),(22,57,'com.ddd.mmazm','test','test',1,'2016-09-30 11:02:15'),(23,58,'com.xxx.sgrzllb','test','test',1,'2016-09-30 11:02:20'),(24,57,'com.ddd.mmazm','test','test',1,'2016-09-30 11:03:16'),(25,56,'com.ddd.mmazm','test','test',1,'2016-09-30 14:28:16');

/*Table structure for table `statistics_type` */

DROP TABLE IF EXISTS `statistics_type`;

CREATE TABLE `statistics_type` (
  `id` int(50) NOT NULL AUTO_INCREMENT,
  `type` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

/*Data for the table `statistics_type` */

insert  into `statistics_type`(`id`,`type`) values (1,'click'),(2,'show'),(3,'download'),(4,'installed');

/*Table structure for table `sys_fhbutton` */

DROP TABLE IF EXISTS `sys_fhbutton`;

CREATE TABLE `sys_fhbutton` (
  `FHBUTTON_ID` varchar(100) NOT NULL,
  `NAME` varchar(30) DEFAULT NULL COMMENT '名称',
  `QX_NAME` varchar(50) DEFAULT NULL COMMENT '权限标识',
  `BZ` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`FHBUTTON_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `sys_fhbutton` */

insert  into `sys_fhbutton`(`FHBUTTON_ID`,`NAME`,`QX_NAME`,`BZ`) values ('3542adfbda73410c976e185ffe50ad06','导出EXCEL','toExcel','导出EXCEL'),('46992ea280ba4b72b29dedb0d4bc0106','发邮件','email','发送电子邮件'),('4efa162fce8340f0bd2dcd3b11d327ec','导入EXCEL','FromExcel','导入EXCEL到系统用户'),('cc51b694d5344d28a9aa13c84b7166cd','发短信','sms','发送短信'),('da7fd386de0b49ce809984f5919022b8','站内信','FHSMS','发送站内信');

/*Table structure for table `sys_menu` */

DROP TABLE IF EXISTS `sys_menu`;

CREATE TABLE `sys_menu` (
  `MENU_ID` int(11) NOT NULL,
  `MENU_NAME` varchar(255) DEFAULT NULL,
  `MENU_URL` varchar(255) DEFAULT NULL,
  `PARENT_ID` varchar(100) DEFAULT NULL,
  `MENU_ORDER` varchar(100) DEFAULT NULL,
  `MENU_ICON` varchar(60) DEFAULT NULL,
  `MENU_TYPE` varchar(10) DEFAULT NULL,
  `MENU_STATE` int(1) DEFAULT NULL,
  PRIMARY KEY (`MENU_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `sys_menu` */

insert  into `sys_menu`(`MENU_ID`,`MENU_NAME`,`MENU_URL`,`PARENT_ID`,`MENU_ORDER`,`MENU_ICON`,`MENU_TYPE`,`MENU_STATE`) values (1,'系统管理','#','0','1','menu-icon fa fa-desktop blue','2',1),(2,'权限管理','#','1','1','menu-icon fa fa-lock black','1',1),(6,'信息管理','#','0','5','menu-icon fa fa-credit-card green','2',0),(7,'图片管理','pictures/list.do','6','1','menu-icon fa fa-folder-o pink','2',1),(15,'微信管理','#','0','4','menu-icon fa fa-comments purple','2',0),(16,'文本回复','textmsg/list.do','15','2','menu-icon fa fa-comment green','2',1),(17,'应用命令','command/list.do','15','4','menu-icon fa fa-comment grey','2',1),(18,'图文回复','imgmsg/list.do','15','3','menu-icon fa fa-comment pink','2',1),(19,'关注回复','textmsg/goSubscribe.do','15','1','menu-icon fa fa-comment orange','2',1),(36,'角色(基础权限)','role.do','2','1','menu-icon fa fa-key orange','1',1),(37,'按钮权限','buttonrights/list.do','2','2','menu-icon fa fa-key green','1',1),(38,'菜单管理','menu/listAllMenu.do','1','3','menu-icon fa fa-folder-open-o brown','1',1),(39,'按钮管理','fhbutton/list.do','1','2','menu-icon fa fa-download orange','1',1),(40,'用户管理','#','0','2','menu-icon fa fa-users blue','2',1),(41,'系统用户','user/listUsers.do','40','1','menu-icon fa fa-users green','1',1),(50,'站内信','fhsms/list.do','6','2','menu-icon fa fa-envelope green','1',1),(51,'广告池','#','0','7','menu-icon fa fa-home black','2',1),(52,'位置策略','#','0','8','menu-icon fa fa-leaf black','2',1),(73,'广告位','strategy/list.do','52','1','menu-icon fa fa-leaf black','1',1),(94,'广告列表','adpool/view','51','1','menu-icon fa fa-book black','1',1),(200,'推广设置','#','0','9','menu-icon fa fa-leaf black','2',1),(242,'运营位置','#','0','7','menu-icon fa fa-leaf black','2',1),(263,'HOT','operation/view.do','242','1','menu-icon fa fa-leaf black','1',1),(264,'渠道控制','channelControl/channel.do','200','2','menu-icon fa fa-leaf black','1',1),(265,'推广设置','settings/view','200','1','menu-icon fa fa-leaf black','1',1),(266,'开发者后台','#','0','9','menu-icon fa fa-leaf black','2',1),(267,'接入SDK','developer/accesssdk/view','266','1','menu-icon fa fa-leaf black','1',1),(268,'载体尺度','#','200','3','menu-icon fa fa-leaf black','1',1),(269,'PID控制','pid/view','200','4','menu-icon fa fa-leaf black','1',1),(270,'CRM','#','0','9','menu-icon fa fa-leaf black','2',1),(271,'开发者','crmfordev/view','270','1','menu-icon fa fa-leaf black','1',1),(272,'运营数据','#','0','9','menu-icon fa fa-leaf black','2',1),(273,'开发者收益系统','developer/operationData','272','3','menu-icon fa fa-leaf black','1',1),(274,'广告主','crmforadvertiser/view','270','2','menu-icon fa fa-leaf black','1',1),(275,'开发者报表','developer/report','266','2','menu-icon fa fa-leaf black','1',1),(276,'广告主','#','0','8','menu-icon fa fa-leaf black','2',1),(277,'广告主报表','/advertiser/report','276','1','menu-icon fa fa-leaf black','1',1),(278,'实时广告主运营数据','/advertiser/operations','272','1','menu-icon fa fa-leaf black','1',1),(279,'实时开发者运营数据','developer/operations','272','2','menu-icon fa fa-leaf black','1',1);

/*Table structure for table `sys_role` */

DROP TABLE IF EXISTS `sys_role`;

CREATE TABLE `sys_role` (
  `ROLE_ID` varchar(100) NOT NULL,
  `ROLE_NAME` varchar(100) DEFAULT NULL,
  `RIGHTS` varchar(255) DEFAULT NULL,
  `PARENT_ID` varchar(100) DEFAULT NULL,
  `ADD_QX` varchar(255) DEFAULT NULL,
  `DEL_QX` varchar(255) DEFAULT NULL,
  `EDIT_QX` varchar(255) DEFAULT NULL,
  `CHA_QX` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ROLE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `sys_role` */

insert  into `sys_role`(`ROLE_ID`,`ROLE_NAME`,`RIGHTS`,`PARENT_ID`,`ADD_QX`,`DEL_QX`,`EDIT_QX`,`CHA_QX`) values ('1','系统管理组','1942654070845374082705562833993815243583448836519504596029527407276938415688972730566','0','1','1','1','1'),('115b386ff04f4352b060dffcd2b5d1da','中级会员','498','2','0','0','0','0'),('1b67fc82ce89457a8347ae53e43a347e','初级会员','498','2','0','0','0','0'),('2','会员组','498','0','0','0','0','1'),('259185720a0e482c800fd50844a6ffc4','开发者','355713298137035352341210065946689252925245392892847812729213698072309134253883392','1','355713298137035352341210065946689252925245392892847812729213698072309134253883392','355713298137035352341210065946689252925245392892847812729213698072309134253883392','355713298137035352341210065946689252925245392892847812729213698072309134253883392','355713298137035352341210065946689252925245392892847812729213698072309134253883392'),('3264c8e83d0248bb9e3ea6195b4c0216','一级管理员','1526602911572164979579504122731990370384727503234081966208256896346339836296167424','1','1526602911572164979579504122731990370384727503234081966208256896346339836296167424','1882316209709200331920714188678679623309972896126929778937470594418648970550050816','19807040628568586885807440070','1526602911572164979579504122731990370384727503234081966208256896346339836296167424'),('46294b31a71c4600801724a6eb06bb26','职位组','','0','0','0','0','0'),('5466347ac07044cb8d82990ec7f3a90e','主管','','46294b31a71c4600801724a6eb06bb26','0','0','0','0'),('68f8e4a39efe47c7bb869e9d15ab925d','二级管理员','766247770433118653751037034068457284348676238568587270','1','2832273234722822','0','2251798773489606','2832273234722822'),('69f50399550a41e9b46af6af80d76654','广告主','','1','0','0','0','0'),('856849f422774ad390a4e564054d8cc8','经理','','46294b31a71c4600801724a6eb06bb26','0','0','0','0'),('8b70a7e67f2841e7aaba8a4d92e5ff6f','高级会员','498','2','0','0','0','0'),('c21cecf84048434b93383182b1d98cba','组长','','46294b31a71c4600801724a6eb06bb26','0','0','0','0'),('d449195cd8e7491080688c58e11452eb','总监','','46294b31a71c4600801724a6eb06bb26','0','0','0','0'),('de9de2f006e145a29d52dfadda295353','运营','2832273234722822','1','2832273234722822','2832273234722822','0','2832273234722822');

/*Table structure for table `sys_role_fhbutton` */

DROP TABLE IF EXISTS `sys_role_fhbutton`;

CREATE TABLE `sys_role_fhbutton` (
  `RB_ID` varchar(100) NOT NULL,
  `ROLE_ID` varchar(100) DEFAULT NULL,
  `BUTTON_ID` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`RB_ID`),
  KEY `角色表外键` (`ROLE_ID`) USING BTREE,
  KEY `fbutton` (`BUTTON_ID`),
  CONSTRAINT `fbutton` FOREIGN KEY (`BUTTON_ID`) REFERENCES `sys_fhbutton` (`FHBUTTON_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `frole` FOREIGN KEY (`ROLE_ID`) REFERENCES `sys_role` (`ROLE_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `sys_role_fhbutton` */

insert  into `sys_role_fhbutton`(`RB_ID`,`ROLE_ID`,`BUTTON_ID`) values ('14b5c28ea6ae4508b57d2d272ab3d5f1','3264c8e83d0248bb9e3ea6195b4c0216','46992ea280ba4b72b29dedb0d4bc0106'),('1743733f366240c693c4295b527d1b0e','de9de2f006e145a29d52dfadda295353','4efa162fce8340f0bd2dcd3b11d327ec'),('3768e60edd1c4b5c9f1dd861188ae2f9','3264c8e83d0248bb9e3ea6195b4c0216','cc51b694d5344d28a9aa13c84b7166cd'),('8231c216fb514b4188e4162e629c6237','3264c8e83d0248bb9e3ea6195b4c0216','4efa162fce8340f0bd2dcd3b11d327ec'),('9412d1d05162464c83658c7f89ab03f0','68f8e4a39efe47c7bb869e9d15ab925d','3542adfbda73410c976e185ffe50ad06'),('96567633dd3548c9b75d28f430adf5a3','3264c8e83d0248bb9e3ea6195b4c0216','da7fd386de0b49ce809984f5919022b8'),('a1478f27c852459fa9cad04b642f4fb7','de9de2f006e145a29d52dfadda295353','3542adfbda73410c976e185ffe50ad06'),('ba6696b8761044618e44c7e02c9ba89e','68f8e4a39efe47c7bb869e9d15ab925d','cc51b694d5344d28a9aa13c84b7166cd'),('f0329033d0914faf8ea6e9ff252cc5e6','68f8e4a39efe47c7bb869e9d15ab925d','46992ea280ba4b72b29dedb0d4bc0106'),('f627982cc9d4479dbc03af726dc6ac58','de9de2f006e145a29d52dfadda295353','cc51b694d5344d28a9aa13c84b7166cd');

/*Table structure for table `sys_user` */

DROP TABLE IF EXISTS `sys_user`;

CREATE TABLE `sys_user` (
  `USER_ID` varchar(100) NOT NULL,
  `USERNAME` varchar(255) DEFAULT NULL,
  `PASSWORD` varchar(255) DEFAULT NULL,
  `NAME` varchar(255) DEFAULT NULL,
  `RIGHTS` varchar(255) DEFAULT NULL COMMENT '权限',
  `ROLE_ID` varchar(100) DEFAULT NULL COMMENT '角色ID',
  `LAST_LOGIN` varchar(255) DEFAULT NULL,
  `IP` varchar(15) DEFAULT NULL,
  `STATUS` varchar(32) DEFAULT NULL,
  `BZ` varchar(255) DEFAULT NULL,
  `SKIN` varchar(100) DEFAULT NULL,
  `EMAIL` varchar(32) DEFAULT NULL,
  `NUMBER` varchar(100) DEFAULT NULL,
  `PHONE` varchar(32) DEFAULT NULL COMMENT '联系电话',
  `COMPANY` varchar(100) DEFAULT NULL COMMENT '公司',
  `linkman` varchar(100) DEFAULT NULL COMMENT '联系人',
  `qq` varchar(20) DEFAULT NULL COMMENT 'qq号',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`USER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `sys_user` */

insert  into `sys_user`(`USER_ID`,`USERNAME`,`PASSWORD`,`NAME`,`RIGHTS`,`ROLE_ID`,`LAST_LOGIN`,`IP`,`STATUS`,`BZ`,`SKIN`,`EMAIL`,`NUMBER`,`PHONE`,`COMPANY`,`linkman`,`qq`,`create_time`) values ('06b737e0824e4ac3bc5c2c8f4e6d8199','广告测试','a0000835a59009cd7e39b3fa8d21af1e76a40c3e','广告测试','','259185720a0e482c800fd50844a6ffc4','','','0',NULL,'default',NULL,NULL,'123456789','大公司','呵呵呵','1','2016-09-12 17:04:09'),('1','admin','de41b7fb99201d8334c23c014db35ecd92df81bc','系统管理员','1133671055321055258374707980945218933803269864762743594642571294','1','2016-09-30 16:03:21','0:0:0:0:0:0:0:1','0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2016-09-14 17:19:33'),('22f5df047d0e403386eb2b35200f74a0','广告','6fc7fa17f2a1f7b0193f5b769cfc9bda677962c4','广告','','259185720a0e482c800fd50844a6ffc4','2016-09-27 11:21:01','0:0:0:0:0:0:0:1','0',NULL,'default',NULL,NULL,'1','1','1','1','2016-09-12 16:34:50'),('3359727357d042f680137665262f9e98','re','32e377e240010fa0357f8242a5ace8ec42a0434e','re','','259185720a0e482c800fd50844a6ffc4','2016-09-18 19:08:06','127.0.0.1','0',NULL,'default',NULL,NULL,'11','re','re','11','2016-09-13 11:51:50'),('4b2a1a68fe0f4cfba06630d526db06c9','wxj','e0ad01c2822f916659d5157c5de9519ebcdaeb73','王晓杰','','3264c8e83d0248bb9e3ea6195b4c0216','2016-09-30 15:48:55','192.168.1.169','0','11','default','11@11.com','wxj','13281111111',NULL,NULL,NULL,'2016-09-26 10:22:59'),('5194e5c1deff4c3890b4981a4e64ba02','广告主测试4','77cb69f323f645183473fd6624bea3391838ffae','期12','','69f50399550a41e9b46af6af80d76654','2016-09-13 11:16:08','0:0:0:0:0:0:0:1','0',NULL,'default',NULL,NULL,'1','广告主测试的公司','1','1','2016-09-13 11:16:05'),('5beabb49ac1e485b9a8a8b90cf1ee6f9','qz','e6168435406765e8beae5da0d3ebd2aa9450a926','茄子','','259185720a0e482c800fd50844a6ffc4','','','0',NULL,'default',NULL,NULL,'13285145147','茄子公司','茄子','1212','2016-09-27 17:25:22'),('6ce7fada9c0c4898813e8dfa634b9677','xiaomingguanggaozhu','6a1b96b357473bb1f04c8d094b20c489b9f33c90','1','','69f50399550a41e9b46af6af80d76654','2016-09-29 17:04:56','192.168.1.110','0',NULL,'default',NULL,NULL,'','1','1','','2016-09-29 17:04:49'),('7470ac1118dd4c2d85e2bddf898059ee','testcc','c850544d2db42db2d7abe9d50946a8f68860c977','testcc','','259185720a0e482c800fd50844a6ffc4','','','0',NULL,'default',NULL,NULL,'','1','1','','2016-09-20 16:13:52'),('9991f4d7782a4ccfb8a65bd96ea7aafa','lisi','2612ade71c1e48cd7150b5f4df152faa699cedfe','李四','','3264c8e83d0248bb9e3ea6195b4c0216','2016-01-06 01:24:26','127.0.0.1','0','小李','default','313596790@qq.com','1102','13566233663',NULL,NULL,NULL,NULL),('d922389be8e84b6d95d55f1663e43207','广告主测试','2917242929cbbf6ae733200f1d2fbe42d3ca9485','广告主测试','','69f50399550a41e9b46af6af80d76654','2016-09-12 17:26:26','0:0:0:0:0:0:0:1','0',NULL,'default',NULL,NULL,'1212','广告主测试','1123','1','2016-09-12 17:25:46'),('e29149962e944589bb7da23ad18ddeed','zhangsan','c2da1419caf053885c492e10ebde421581cdc03f','张三','','3264c8e83d0248bb9e3ea6195b4c0216','','','0','小张','default','zhangsan@www.com','1101','2147483647',NULL,NULL,NULL,NULL),('f151fc2402d5456ea31bf663b01b42d4','xiaoming','ff8be880d80ffe171483de3a50bb0bca321829b8','1','','259185720a0e482c800fd50844a6ffc4','2016-09-29 17:00:13','192.168.1.110','0',NULL,'default',NULL,NULL,'','1','1','','2016-09-29 17:00:06');

/*Table structure for table `t_ad_channel_sheild` */

DROP TABLE IF EXISTS `t_ad_channel_sheild`;

CREATE TABLE `t_ad_channel_sheild` (
  `id` int(50) NOT NULL AUTO_INCREMENT COMMENT '渠道屏蔽',
  `channelid` varchar(100) DEFAULT NULL COMMENT '渠道号',
  `isSheild` int(1) DEFAULT '0' COMMENT '渠道屏蔽开关 ',
  `channelname` varchar(100) DEFAULT NULL COMMENT '渠道名称',
  `num` int(11) DEFAULT NULL COMMENT '数量控制',
  `provinceList` varchar(255) DEFAULT NULL COMMENT '省份列表',
  `start_time` time DEFAULT NULL COMMENT '开始时间',
  `end_time` time DEFAULT NULL COMMENT '结束时间',
  PRIMARY KEY (`id`),
  KEY `IDX_provincelist` (`isSheild`,`channelname`,`num`,`provinceList`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

/*Data for the table `t_ad_channel_sheild` */

insert  into `t_ad_channel_sheild`(`id`,`channelid`,`isSheild`,`channelname`,`num`,`provinceList`,`start_time`,`end_time`) values (3,'1222',1,'测试渠道',NULL,NULL,'00:00:01','00:00:02'),(7,'22',1,'渠道',NULL,NULL,'01:00:00','03:00:00'),(10,'222',0,'渠道',NULL,NULL,'01:00:00','03:00:00'),(11,'2221222',0,'渠道',NULL,NULL,'01:00:00','03:00:00');

/*Table structure for table `t_ad_developer_operation_data` */

DROP TABLE IF EXISTS `t_ad_developer_operation_data`;

CREATE TABLE `t_ad_developer_operation_data` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `developer` varchar(60) DEFAULT NULL,
  `price` double DEFAULT NULL COMMENT '开发者单价',
  `pid` varchar(100) DEFAULT NULL,
  `sdk_count` int(11) DEFAULT NULL,
  `new_count` int(11) DEFAULT NULL,
  `income` double(8,2) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `create_date` date NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;

/*Data for the table `t_ad_developer_operation_data` */

insert  into `t_ad_developer_operation_data`(`id`,`developer`,`price`,`pid`,`sdk_count`,`new_count`,`income`,`status`,`create_date`) values (1,'测试',NULL,'test1111',111,1111,11111.00,2,'2016-09-27'),(2,'测试',NULL,'test2222',111,2222,22222.00,2,'2016-09-27'),(3,'测试1',NULL,'test112344',222,3333,9999.11,2,'2016-09-28'),(4,'测试2',NULL,'test222222',333,4444,23333.00,2,'2016-09-28'),(7,'系统管理员',NULL,'MidAutumnMeiZi11',444,6,111.00,2,'2016-09-26'),(8,'系统管理员',NULL,'test1',4,4,222.00,2,'2016-09-26'),(21,'系统管理员',1,'MidAutumnMeiZi',4,222,1111.00,2,'2016-09-29'),(22,'系统管理员',1,'test',2,2,480.00,2,'2016-09-29');

/*Table structure for table `t_ad_global` */

DROP TABLE IF EXISTS `t_ad_global`;

CREATE TABLE `t_ad_global` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `init_time` varchar(45) DEFAULT NULL,
  `request_interval` varchar(45) DEFAULT NULL,
  `channel_protection` varchar(45) DEFAULT NULL,
  `display_limits` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=67 DEFAULT CHARSET=utf8;

/*Data for the table `t_ad_global` */

insert  into `t_ad_global`(`id`,`init_time`,`request_interval`,`channel_protection`,`display_limits`) values (1,'22','22','22','22222'),(2,'22','33','22','22222'),(3,'22','33','22','22222'),(4,'22','33','22','22222'),(7,'22','22','22','222'),(8,'22','22','22','222'),(9,'22','22','44','222'),(10,'22','22','44','222'),(11,'22','22','44','222'),(12,'22','22','44','222'),(13,'22','44','44','222'),(14,'22','44','44','222'),(15,'22','44','44','222'),(16,'22','44','546','222'),(17,'22','44','44','222'),(18,'22','44','456','222'),(19,'22','44','456','222'),(20,'22','44','456','222'),(21,'22','44','89','222'),(22,'22','44','89','222'),(23,'22','44','89','222'),(24,'22','44','89','222'),(25,'22','44','89','222'),(26,'22','44','89','222'),(27,'22','44','89','222'),(28,'22','44','89','222'),(29,'22','44','89','222'),(30,'22','44','89','222'),(31,'22','44','89','222'),(32,'22','44','89','222'),(33,'22','44','89','222'),(34,'22','44','89','222'),(35,'22','44','89','222'),(36,'22','44','89','222'),(37,'22','44','89','222'),(38,'22','44','89','222'),(39,'22','44','89','222'),(40,'22','44','89','222'),(41,'22','44','89','222'),(42,'22','44','45','222'),(43,'22','44','45','345'),(44,'22','44','45','345'),(45,'22','44','45','345'),(46,'22','44','45','345'),(47,'56','44','45','345'),(48,'34','44','45','345'),(49,'34','44','56','345'),(50,'34','44','56','345'),(51,'34','44','56','345'),(52,'34','44','56','345'),(53,'34','44','56','345'),(54,'34','44','56','345'),(55,'34','44','56','345'),(56,'34','44','56','345'),(57,'34','44','56','345'),(58,'34','44','56','345'),(59,'34','44','56','345'),(60,'3444','44444','4444456','34544444'),(61,'1','2','3','4'),(65,'5','1','100','1000000'),(66,'5','1','100','1000000');

/*Table structure for table `t_ad_pool` */

DROP TABLE IF EXISTS `t_ad_pool`;

CREATE TABLE `t_ad_pool` (
  `id` bigint(255) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL COMMENT '广告名称',
  `hostid` varchar(100) DEFAULT NULL COMMENT '广告主的id',
  `charge_type` int(10) DEFAULT NULL COMMENT '计费类型',
  `app_type` int(10) DEFAULT NULL COMMENT '应用类型',
  `cooperation_mode` int(10) DEFAULT NULL COMMENT '分成模式',
  `install_limit` int(10) DEFAULT NULL COMMENT '安装限额 0 不限制',
  `online_status` int(10) DEFAULT NULL COMMENT '状态',
  `delete_status` int(1) DEFAULT '0' COMMENT '删除状态 1：已删除 0：未删除',
  `uid` varchar(1000) DEFAULT NULL COMMENT '用户的唯一标识',
  `app_url` varchar(1000) DEFAULT NULL COMMENT '推广应用的地址，外链接url 或者文件服务器地址',
  `banner_pic_url` varchar(1000) DEFAULT NULL COMMENT 'banner广告图',
  `open_pic_url` varchar(1000) DEFAULT NULL COMMENT '开屏广告图',
  `lock_pic_url` varchar(1000) DEFAULT NULL COMMENT '锁屏广告图',
  `float_pic_url` varchar(1000) DEFAULT NULL COMMENT '悬浮广告图',
  `interstitial_pic_url` varchar(1000) DEFAULT NULL COMMENT '插屏广告图',
  `notification_bar_pic_url` varchar(1000) DEFAULT NULL COMMENT '通知栏广告图',
  `video_url` varchar(1000) DEFAULT NULL COMMENT '视频广告通url',
  `promote_start1` time DEFAULT NULL COMMENT '推广开始时间1',
  `promote_end1` time DEFAULT NULL COMMENT '推广结束时间1',
  `promote_start2` time DEFAULT NULL COMMENT '推广开始时间2',
  `promote_end2` time DEFAULT NULL COMMENT '推广结束时间2',
  `mobile_province` varchar(300) DEFAULT NULL COMMENT '移动屏蔽省份',
  `unicom_province` varchar(300) DEFAULT NULL COMMENT '联通屏蔽省份',
  `telecom_province` varchar(300) DEFAULT NULL COMMENT '电信屏蔽省份',
  `sdk_plan` int(10) DEFAULT NULL COMMENT 'sdk执行策略的方案',
  `notification_title` varchar(100) DEFAULT NULL COMMENT '通知栏标题',
  `notification_content` varchar(1000) DEFAULT NULL COMMENT '通知栏内容',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  `create_person` varchar(50) DEFAULT NULL COMMENT '创建人',
  `update_person` varchar(50) DEFAULT NULL COMMENT '修改人',
  `apk_version` varchar(50) DEFAULT NULL,
  `apk_packagename` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=79 DEFAULT CHARSET=utf8;

/*Data for the table `t_ad_pool` */

insert  into `t_ad_pool`(`id`,`name`,`hostid`,`charge_type`,`app_type`,`cooperation_mode`,`install_limit`,`online_status`,`delete_status`,`uid`,`app_url`,`banner_pic_url`,`open_pic_url`,`lock_pic_url`,`float_pic_url`,`interstitial_pic_url`,`notification_bar_pic_url`,`video_url`,`promote_start1`,`promote_end1`,`promote_start2`,`promote_end2`,`mobile_province`,`unicom_province`,`telecom_province`,`sdk_plan`,`notification_title`,`notification_content`,`create_time`,`update_time`,`create_person`,`update_person`,`apk_version`,`apk_packagename`) values (56,'Test','5194e5c1deff4c3890b4981a4e64ba02',1,1,1,11,0,1,'1','1475141571568','1475141571333','1475141571412',NULL,NULL,'1475141571485',NULL,NULL,'00:00:00','00:00:00','00:00:00','00:00:00','','','',1,'标题','内容','2016-09-29 17:32:51',NULL,'1',NULL,'1.1.5','com.wandoujia.roshan'),(57,'Test2','5194e5c1deff4c3890b4981a4e64ba02',1,1,1,1111,0,1,'1','1475142309909','1475142309671','1475142309747',NULL,NULL,'1475142309816',NULL,NULL,'00:00:00','00:00:00','00:00:00','00:00:00','','','',1,'标题','内容','2016-09-29 17:45:09',NULL,'1',NULL,'1.1.5','com.wandoujia.roshan'),(58,'122','5194e5c1deff4c3890b4981a4e64ba02',1,1,1,2,0,1,'1','1475143310778','1475143310704',NULL,NULL,NULL,NULL,NULL,NULL,'00:00:00','00:00:00','00:00:00','00:00:00','','','',1,'标题','内容','2016-09-29 18:01:50',NULL,'1',NULL,'6.2.487','com.qihoo360.contacts'),(59,'11','5194e5c1deff4c3890b4981a4e64ba02',1,1,1,2,0,1,'1','1475143698302','1475143698231',NULL,NULL,NULL,NULL,NULL,NULL,'00:00:00','00:00:00','00:00:00','00:00:00','','','',1,'标题','内容','2016-09-29 18:08:18',NULL,'1',NULL,'6.2.487','com.qihoo360.contacts'),(60,'测试!勿删！','5194e5c1deff4c3890b4981a4e64ba02',1,1,1,2,0,1,'1','1475143985475','1475143985396',NULL,NULL,NULL,NULL,NULL,NULL,'00:00:00','00:00:00','00:00:00','00:00:00','','','',1,'标题','内容','2016-09-29 18:13:05',NULL,'1',NULL,'6.2.487','com.qihoo360.contacts'),(62,'XiaomingTest1','5194e5c1deff4c3890b4981a4e64ba02',2,1,1,111,1,1,'1','1475215405867','1475215405635','1475215405708',NULL,NULL,'1475215405781',NULL,NULL,'00:00:00','00:00:00','00:00:00','00:00:00','','','',1,'','','2016-09-30 14:03:25',NULL,'1',NULL,'1.1.5','com.wandoujia.roshan'),(63,'XiaomingTest','5194e5c1deff4c3890b4981a4e64ba02',1,1,1,11,1,1,'1','1475217841748','1475217841539','1475217841609',NULL,NULL,'1475217841679',NULL,NULL,'00:00:00','00:00:00','00:00:00','00:00:00','','','',1,'','','2016-09-30 14:44:01',NULL,'1',NULL,NULL,NULL),(64,'XIaomingTest2','5194e5c1deff4c3890b4981a4e64ba02',1,1,1,1,1,1,'1','1475217939577','1475217939438','1475217939508',NULL,NULL,NULL,NULL,NULL,'00:00:00','00:00:00','00:00:00','00:00:00','','','',1,'','','2016-09-30 14:45:39',NULL,'1',NULL,NULL,NULL),(65,'XiaomingTest123','5194e5c1deff4c3890b4981a4e64ba02',2,1,1,12,1,1,'1','1475218020425','1475218020348',NULL,NULL,NULL,NULL,NULL,NULL,'00:00:00','00:00:00','00:00:00','00:00:00','','','',1,'','','2016-09-30 14:47:00',NULL,'1',NULL,NULL,NULL),(66,'XiaomingTest','5194e5c1deff4c3890b4981a4e64ba02',1,1,1,111,1,1,'1','1475219214367','1475219214143','1475219214214',NULL,NULL,'1475219214284',NULL,NULL,'00:00:00','00:00:00','00:00:00','00:00:00','','','',1,'','','2016-09-30 15:06:54',NULL,'1',NULL,'1.1.5','com.wandoujia.roshan'),(67,'XiaomingTest','5194e5c1deff4c3890b4981a4e64ba02',1,1,1,111,1,1,'1','1475221053264','1475221053169',NULL,NULL,NULL,NULL,NULL,NULL,'00:00:00','00:00:00','00:00:00','00:00:00','','','',1,'','','2016-09-30 15:37:33',NULL,'1',NULL,'1.1.5','com.wandoujia.roshan'),(68,'XiaomingTest','5194e5c1deff4c3890b4981a4e64ba02',1,1,1,0,1,1,'1','1475221098129','1475221098047',NULL,NULL,NULL,NULL,NULL,NULL,'00:00:00','00:00:00','00:00:00','00:00:00','','','',1,'','','2016-09-30 15:38:18',NULL,'1',NULL,'1.1.5','com.wandoujia.roshan'),(69,'1','5194e5c1deff4c3890b4981a4e64ba02',1,1,1,0,1,1,'1','1475221146038','1475221145954',NULL,NULL,NULL,NULL,NULL,NULL,'00:00:00','00:00:00','00:00:00','00:00:00','','','',1,'','','2016-09-30 15:39:06',NULL,'1',NULL,'1.1.5','com.wandoujia.roshan'),(70,'1','5194e5c1deff4c3890b4981a4e64ba02',1,1,1,1,1,1,'1','1475221288835','1475221288719',NULL,NULL,NULL,NULL,NULL,NULL,'03:00:00','03:55:15','23:00:00','23:01:30','','','',1,'','','2016-09-30 15:41:28',NULL,'1',NULL,'1.1.5','com.wandoujia.roshan'),(71,'1','5194e5c1deff4c3890b4981a4e64ba02',1,1,1,11,1,1,'1','1475221346306','1475221346218',NULL,NULL,NULL,NULL,NULL,NULL,'00:00:00','00:00:00','00:00:00','00:00:00','','','',1,'','','2016-09-30 15:42:26',NULL,'1',NULL,'1.1.5','com.wandoujia.roshan'),(72,'1','5194e5c1deff4c3890b4981a4e64ba02',1,1,1,11,1,1,'1','1475221398091','1475221398010',NULL,NULL,NULL,NULL,NULL,NULL,'00:00:00','23:58:00','00:00:00','00:00:00','','','',1,'','','2016-09-30 15:43:18',NULL,'1',NULL,'1.1.5','com.wandoujia.roshan'),(73,'1','5194e5c1deff4c3890b4981a4e64ba02',1,1,2,1,1,1,'1','1475221493755','1475221493660',NULL,NULL,NULL,NULL,NULL,NULL,'21:00:00','23:00:00','00:00:00','00:00:00','','','',1,'','','2016-09-30 15:44:53',NULL,'1',NULL,'1.1.5','com.wandoujia.roshan'),(74,'11','5194e5c1deff4c3890b4981a4e64ba02',1,2,1,0,1,1,'1','1475221567096','1475221567018',NULL,NULL,NULL,NULL,NULL,NULL,'00:00:00','00:00:00','00:00:00','00:00:00','','','',1,'','','2016-09-30 15:46:07',NULL,'1',NULL,'1.1.5','com.wandoujia.roshan'),(75,'121','5194e5c1deff4c3890b4981a4e64ba02',1,2,1,1,1,0,'1','1475221658373','1475221658293',NULL,NULL,NULL,NULL,NULL,NULL,'00:00:00','00:00:00','00:00:00','00:00:00','','','',1,'','','2016-09-30 15:47:38',NULL,'1',NULL,'1.1.5','com.wandoujia.roshan'),(76,'eee','5194e5c1deff4c3890b4981a4e64ba02',3,1,1,1,1,0,'4b2a1a68fe0f4cfba06630d526db06c9','1475221778578','1475221778508',NULL,NULL,NULL,NULL,NULL,NULL,'00:00:00','00:00:00','00:00:00','00:00:00','','','',1,'','','2016-09-30 15:49:38',NULL,'4b2a1a68fe0f4cfba06630d526db06c9',NULL,'1.0','lm.ss.sn'),(77,'ds','5194e5c1deff4c3890b4981a4e64ba02',1,1,1,11,1,0,'1','1475221865476','1475221865389',NULL,NULL,NULL,NULL,NULL,NULL,'00:00:00','00:00:00','00:00:00','00:00:00','','','',1,'','','2016-09-30 15:51:05',NULL,'1',NULL,'1.1.5','com.wandoujia.roshan'),(78,'测试勿删','d922389be8e84b6d95d55f1663e43207',1,3,1,2,1,0,'1','1475222122986','1475222122597','1475222122772','1475222122913','1475222122704','1475222122842','1475222123169',NULL,'00:00:00','00:00:00','00:00:00','00:00:00','','','',1,'刀塔','刀塔更新啦','2016-09-30 15:55:23',NULL,'1',NULL,'1.0','lm.ss.sn');

/*Table structure for table `t_ad_pool_another` */

DROP TABLE IF EXISTS `t_ad_pool_another`;

CREATE TABLE `t_ad_pool_another` (
  `id` int(255) NOT NULL AUTO_INCREMENT,
  `ad_pool_id` int(255) DEFAULT NULL,
  `position` int(10) DEFAULT NULL,
  `isonline` int(1) DEFAULT '0' COMMENT '是否已上架 1：已上架 0下架',
  `weight` int(10) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

/*Data for the table `t_ad_pool_another` */

/*Table structure for table `t_ad_pool_banner` */

DROP TABLE IF EXISTS `t_ad_pool_banner`;

CREATE TABLE `t_ad_pool_banner` (
  `id` int(255) NOT NULL AUTO_INCREMENT COMMENT 'banner 广告',
  `ad_pool_id` int(255) DEFAULT NULL,
  `position` int(10) DEFAULT NULL,
  `isonline` int(1) DEFAULT '0' COMMENT '是否已上架 1：已上架 0下架',
  `weight` int(10) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8;

/*Data for the table `t_ad_pool_banner` */

insert  into `t_ad_pool_banner`(`id`,`ad_pool_id`,`position`,`isonline`,`weight`) values (58,75,36,1,1122),(59,76,36,1,222),(60,77,36,1,2);

/*Table structure for table `t_ad_pool_floatad` */

DROP TABLE IF EXISTS `t_ad_pool_floatad`;

CREATE TABLE `t_ad_pool_floatad` (
  `id` int(255) NOT NULL AUTO_INCREMENT COMMENT '悬浮广告',
  `ad_pool_id` int(255) DEFAULT NULL,
  `position` int(10) DEFAULT NULL,
  `isonline` int(1) DEFAULT '0',
  `weight` int(10) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

/*Data for the table `t_ad_pool_floatad` */

/*Table structure for table `t_ad_pool_lockscreen` */

DROP TABLE IF EXISTS `t_ad_pool_lockscreen`;

CREATE TABLE `t_ad_pool_lockscreen` (
  `id` int(255) NOT NULL AUTO_INCREMENT COMMENT '锁屏广告',
  `ad_pool_id` int(255) DEFAULT NULL,
  `position` int(10) DEFAULT NULL,
  `isonline` int(1) DEFAULT '0',
  `weight` int(10) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

/*Data for the table `t_ad_pool_lockscreen` */

/*Table structure for table `t_ad_pool_notification` */

DROP TABLE IF EXISTS `t_ad_pool_notification`;

CREATE TABLE `t_ad_pool_notification` (
  `id` int(255) NOT NULL AUTO_INCREMENT COMMENT '通知栏广告',
  `ad_pool_id` int(255) DEFAULT NULL,
  `position` int(10) DEFAULT NULL,
  `isonline` int(1) DEFAULT '0' COMMENT '是否已上架 1：已上架 0下架',
  `icon` varchar(1000) DEFAULT NULL,
  `weight` int(10) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;

/*Data for the table `t_ad_pool_notification` */

/*Table structure for table `t_ad_pool_openscreen` */

DROP TABLE IF EXISTS `t_ad_pool_openscreen`;

CREATE TABLE `t_ad_pool_openscreen` (
  `id` int(255) NOT NULL AUTO_INCREMENT COMMENT '开屏广告',
  `ad_pool_id` int(255) DEFAULT NULL,
  `position` int(10) DEFAULT NULL,
  `isonline` int(1) DEFAULT '0',
  `weight` int(10) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

/*Data for the table `t_ad_pool_openscreen` */

/*Table structure for table `t_ad_pool_screen` */

DROP TABLE IF EXISTS `t_ad_pool_screen`;

CREATE TABLE `t_ad_pool_screen` (
  `id` int(255) NOT NULL AUTO_INCREMENT,
  `ad_pool_id` int(255) DEFAULT NULL,
  `position` int(10) DEFAULT NULL,
  `isonline` int(1) DEFAULT '0' COMMENT '是否已上架 1：已上架 0下架',
  `weight` int(10) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;

/*Data for the table `t_ad_pool_screen` */

insert  into `t_ad_pool_screen`(`id`,`ad_pool_id`,`position`,`isonline`,`weight`) values (19,56,39,1,90),(20,57,39,1,11),(21,62,39,0,0),(22,66,39,0,0);

/*Table structure for table `t_ad_pool_videoad` */

DROP TABLE IF EXISTS `t_ad_pool_videoad`;

CREATE TABLE `t_ad_pool_videoad` (
  `id` int(255) NOT NULL AUTO_INCREMENT COMMENT '视频广告',
  `ad_pool_id` int(255) DEFAULT NULL,
  `position` int(10) DEFAULT NULL,
  `isonline` int(1) DEFAULT '0',
  `weight` int(10) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_ad_pool_videoad` */

/*Table structure for table `t_ad_position` */

DROP TABLE IF EXISTS `t_ad_position`;

CREATE TABLE `t_ad_position` (
  `id` int(100) NOT NULL AUTO_INCREMENT,
  `position` varchar(20) DEFAULT NULL,
  `category` int(10) DEFAULT NULL,
  `description` varchar(20) DEFAULT NULL,
  `strategy` int(30) DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8;

/*Data for the table `t_ad_position` */

insert  into `t_ad_position`(`id`,`position`,`category`,`description`,`strategy`,`update_time`) values (18,'banner_top',0,'banner',8,'2016-09-19 16:03:37'),(36,'banner_bottom',0,'banner',13,'2016-09-20 14:15:18'),(37,'fullScreen',1,'fullScreen',14,'2016-09-20 14:46:42'),(38,'notify',5,'notify',17,'2016-09-20 16:51:38'),(39,'sizeScreen',2,'sizeScreen',15,'2016-09-20 16:13:54'),(40,'six_clock_test',5,'测试服务器部署测试用',18,'2016-09-20 18:04:47'),(41,'float',3,'float',18,'2016-09-21 18:06:30'),(42,'lock',4,'lock',18,'2016-09-21 18:06:30');

/*Table structure for table `t_ad_strategy` */

DROP TABLE IF EXISTS `t_ad_strategy`;

CREATE TABLE `t_ad_strategy` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `display_times` varchar(45) DEFAULT NULL,
  `display_alternates` varchar(45) DEFAULT NULL,
  `alternates_group` varchar(45) DEFAULT NULL,
  `group_loop` varchar(45) DEFAULT NULL,
  `inner_group_loop` varchar(45) DEFAULT NULL,
  `cancel_alternates` varchar(45) DEFAULT NULL,
  `type_alternates` varchar(45) DEFAULT NULL,
  `position_change` varchar(45) DEFAULT NULL,
  `loop_times` varchar(45) DEFAULT NULL,
  `custom_today` varchar(45) DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;

/*Data for the table `t_ad_strategy` */

insert  into `t_ad_strategy`(`id`,`display_times`,`display_alternates`,`alternates_group`,`group_loop`,`inner_group_loop`,`cancel_alternates`,`type_alternates`,`position_change`,`loop_times`,`custom_today`,`update_time`) values (8,'3','1','1','1','1','1','1','1','1','1','2016-09-26 14:25:44'),(13,'3','1','1','1','1','1','1','1','1','1','2016-09-26 14:25:48'),(14,'3','1','1','1','1','1','1','1','1','1','2016-09-26 14:25:25'),(15,'3','1','1','1','1','1','1','1','1','1','2016-09-26 14:25:55'),(17,'3','1','1','1','1','1','1','1','1','1','2016-09-26 16:08:12'),(18,'1','1','1','1','1','1','1','1','1','1','2016-09-23 17:26:38');

/*Table structure for table `t_advertiser_crm` */

DROP TABLE IF EXISTS `t_advertiser_crm`;

CREATE TABLE `t_advertiser_crm` (
  `id` int(255) NOT NULL AUTO_INCREMENT,
  `uid` varchar(100) DEFAULT NULL,
  `settlement_period` int(10) DEFAULT NULL COMMENT '结算周期',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

/*Data for the table `t_advertiser_crm` */

insert  into `t_advertiser_crm`(`id`,`uid`,`settlement_period`,`create_time`) values (1,'5194e5c1deff4c3890b4981a4e64ba02',1,'2016-09-28 18:41:50'),(5,'d922389be8e84b6d95d55f1663e43207',1,'2016-09-29 10:20:54');

/*Table structure for table `t_advertiser_operations` */

DROP TABLE IF EXISTS `t_advertiser_operations`;

CREATE TABLE `t_advertiser_operations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_name` varchar(100) DEFAULT NULL,
  `advertiser_name` varchar(100) DEFAULT NULL,
  `show_times` int(11) DEFAULT NULL,
  `click_times` int(11) DEFAULT NULL,
  `download_times` int(11) DEFAULT NULL,
  `install_times` int(11) DEFAULT NULL,
  `show_percent` double DEFAULT NULL COMMENT 'ssu/安装 展示比',
  `estimated_income` double DEFAULT NULL COMMENT '预估收入',
  `create_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

/*Data for the table `t_advertiser_operations` */

insert  into `t_advertiser_operations`(`id`,`app_name`,`advertiser_name`,`show_times`,`click_times`,`download_times`,`install_times`,`show_percent`,`estimated_income`,`create_date`) values (1,'test','test',11,11,11,11,11,11,'2016-09-29 18:37:30'),(2,'haha','haha',22,22,22,2233,33,22,'2016-09-28 18:46:57'),(3,'hehe','hehe',133,444,555,22,332,2222,'2016-09-27 18:47:13');

/*Table structure for table `t_app_type` */

DROP TABLE IF EXISTS `t_app_type`;

CREATE TABLE `t_app_type` (
  `id` int(100) NOT NULL AUTO_INCREMENT,
  `app_type_name` varchar(100) DEFAULT NULL COMMENT '软件类型名',
  `delete_status` int(1) DEFAULT '0' COMMENT '删除状态 1:删除 0：未删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

/*Data for the table `t_app_type` */

insert  into `t_app_type`(`id`,`app_type_name`,`delete_status`) values (1,'FPS射击游戏',0),(2,'消除类游戏',0),(3,'刀塔',0),(4,'lol',0),(5,'部落冲突',0);

/*Table structure for table `t_developer_crm` */

DROP TABLE IF EXISTS `t_developer_crm`;

CREATE TABLE `t_developer_crm` (
  `id` int(255) NOT NULL AUTO_INCREMENT,
  `uid` varchar(200) DEFAULT NULL,
  `price` float(10,2) DEFAULT NULL COMMENT '单价',
  `settlement_period` int(10) DEFAULT NULL COMMENT '结算周期',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

/*Data for the table `t_developer_crm` */

insert  into `t_developer_crm`(`id`,`uid`,`price`,`settlement_period`,`create_time`) values (1,'06b737e0824e4ac3bc5c2c8f4e6d8199',999.00,0,'2016-09-27 18:28:19'),(6,'3359727357d042f680137665262f9e98',0.10,0,'2016-09-28 09:31:49'),(7,'22f5df047d0e403386eb2b35200f74a0',1.30,0,'2016-09-28 09:32:10'),(10,'7470ac1118dd4c2d85e2bddf898059ee',0.50,0,'2016-09-28 14:17:22'),(11,'1',1.00,0,'2016-09-29 14:00:53');

/*Table structure for table `t_developer_sdk` */

DROP TABLE IF EXISTS `t_developer_sdk`;

CREATE TABLE `t_developer_sdk` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pid` varchar(100) DEFAULT NULL,
  `uid` varchar(100) DEFAULT NULL COMMENT '用户唯一标识',
  `appname` varchar(200) DEFAULT NULL,
  `adtypes` varchar(200) DEFAULT NULL COMMENT '配置广告种类',
  `apptypes` varchar(1000) DEFAULT NULL COMMENT '允许的app种类',
  `delete_status` int(1) DEFAULT '0' COMMENT '是否删除',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

/*Data for the table `t_developer_sdk` */

insert  into `t_developer_sdk`(`id`,`pid`,`uid`,`appname`,`adtypes`,`apptypes`,`delete_status`,`create_time`) values (1,'120fc602c350484ba06f8339372da064','22f5df047d0e403386eb2b35200f74a0','123','0,1,2,3','1',0,'2016-09-19 13:35:36'),(2,'3224d126417c4ffa97b2a7d9af35b9fe','22f5df047d0e403386eb2b35200f74a0','恐龙宝贝','0,1,2,3,4','2',0,'2016-09-19 14:13:08'),(5,'8bc0c0c4c07e479fab5a1cce7123bc64','22e8d13771e1465aae4fb60bc12a0d1a','xsd','1','1',0,'2016-09-20 16:08:43'),(6,'MidAutumnMeiZi','1','中秋妹子','1','1',0,'2016-09-29 13:27:58'),(7,'test','1','天天炫斗','1','1',0,'2016-09-29 13:41:59'),(8,'4000464a99e645ee9fae0b7680ba357b','1','test','0,2','4',0,'2016-09-29 16:26:32'),(9,'1a28dcf69ad3442cad7460caa9bce65f','f151fc2402d5456ea31bf663b01b42d4','小猪快跑','0,2,4,5','2,3,4',0,'2016-09-29 17:00:36'),(10,'6abbb43ddab5408baf1e31a35e588abc','f151fc2402d5456ea31bf663b01b42d4','西贝APP','1','2',0,'2016-09-29 17:03:07');

/*Table structure for table `t_pid_sheild` */

DROP TABLE IF EXISTS `t_pid_sheild`;

CREATE TABLE `t_pid_sheild` (
  `id` int(100) NOT NULL AUTO_INCREMENT,
  `uid` varchar(100) DEFAULT NULL COMMENT '开发者id',
  `pid` varchar(100) DEFAULT NULL COMMENT 'pid',
  `switchs` int(1) DEFAULT '0' COMMENT '屏蔽pid开关 1：屏蔽 0：不屏蔽',
  `start_time` time DEFAULT NULL COMMENT '屏蔽开始时间',
  `end_time` time DEFAULT NULL COMMENT '屏蔽结束时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

/*Data for the table `t_pid_sheild` */

insert  into `t_pid_sheild`(`id`,`uid`,`pid`,`switchs`,`start_time`,`end_time`) values (6,'22f5df047d0e403386eb2b35200f74a0','3224d126417c4ffa97b2a7d9af35b9fe',1,'03:00:00','06:00:00'),(7,'22e8d13771e1465aae4fb60bc12a0d1a','8bc0c0c4c07e479fab5a1cce7123bc64',0,'00:00:00','00:00:00');

/*Table structure for table `t_sys_dict` */

DROP TABLE IF EXISTS `t_sys_dict`;

CREATE TABLE `t_sys_dict` (
  `id` int(20) NOT NULL AUTO_INCREMENT,
  `label` varchar(100) DEFAULT NULL COMMENT '标签',
  `val` varchar(100) DEFAULT NULL COMMENT '值',
  `c_type` varchar(255) DEFAULT NULL COMMENT '字段类型',
  `description` varchar(100) DEFAULT NULL COMMENT '描述',
  `sort` int(11) DEFAULT NULL COMMENT '排序',
  `del_flag` char(1) DEFAULT '0' COMMENT '状态 1表示字典停用  0：正常使用',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `create_by` int(20) DEFAULT NULL COMMENT '创建人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `update_by` int(20) DEFAULT NULL COMMENT '更新人',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;

/*Data for the table `t_sys_dict` */

insert  into `t_sys_dict`(`id`,`label`,`val`,`c_type`,`description`,`sort`,`del_flag`,`create_time`,`create_by`,`update_time`,`update_by`) values (1,'开启','1','c_switch_status','开关状态',1,'0','2015-12-23 11:06:59',1,NULL,NULL),(2,'关闭','0','c_switch_status','开关状态',2,'0','2015-12-23 11:06:59',1,NULL,NULL),(3,'上线','1','c_online_status','推广状态',1,'0','2015-12-25 10:47:09',1,NULL,NULL),(4,'下线','0','c_online_status','推广状态',2,'0','2015-12-25 10:48:30',1,NULL,NULL),(5,'CPS','1','c_cooperation_mode','合作模式',1,'0','2015-12-25 10:56:23',1,NULL,NULL),(6,'CPA','2','c_cooperation_mode','合作模式',2,'0','2015-12-25 11:19:53',1,NULL,NULL),(7,'载体','1','c_ad_mode','广告主类别',1,'0','2015-12-25 11:23:19',1,NULL,NULL),(8,'广告主','2','c_ad_mode','广告主类别',2,'0','2015-12-25 11:23:40',1,NULL,NULL),(9,'短代计费','1','c_charge_mode','计费类型',1,'0',NULL,1,NULL,NULL),(10,'第三方计费','2','c_charge_mode','计费类型',2,'0','2016-08-23 14:18:34',1,NULL,NULL),(11,'免费','3','c_charge_mode','计费类型',3,'0','2016-08-23 14:18:31',1,NULL,NULL),(12,'方案1','1','c_sdk_method','sdk执行策略',1,'0','2016-09-01 10:04:41',1,NULL,NULL),(13,'方案2','2','c_sdk_method','sdk执行策略',2,'0','2016-09-01 10:05:11',1,NULL,NULL),(14,'banner广告','0','c_ad_type','广告分类',0,'0','2016-09-06 17:16:37',1,NULL,NULL),(15,'开屏广告','1','c_ad_type','广告分类',1,'0',NULL,NULL,NULL,NULL),(16,'插屏广告','2','c_ad_type','广告分类',2,'0',NULL,NULL,NULL,NULL),(17,'悬浮广告','3','c_ad_type','广告分类',3,'0',NULL,NULL,NULL,NULL),(18,'锁屏广告','4','c_ad_type','广告分类',4,'0',NULL,NULL,NULL,NULL),(19,'通知栏广告','5','c_ad_type','广告分类',5,'0',NULL,NULL,NULL,NULL),(20,'视频广告','6','c_ad_type','广告分类',6,'0',NULL,NULL,NULL,NULL),(21,'月结','0','c_settlement_period','结算周期',0,'0',NULL,NULL,NULL,NULL),(22,'周结','1','c_settlement_period','结算周期',1,'0',NULL,NULL,NULL,NULL);

/*Table structure for table `t_upload_file` */

DROP TABLE IF EXISTS `t_upload_file`;

CREATE TABLE `t_upload_file` (
  `id` int(100) NOT NULL AUTO_INCREMENT,
  `appName` varchar(255) DEFAULT NULL COMMENT '对应的上传的app的name',
  `fileId` varchar(100) DEFAULT NULL COMMENT '文件的ID',
  `file_name` varchar(255) DEFAULT NULL COMMENT '文件名',
  `STOREPATH` varchar(255) DEFAULT NULL COMMENT '文件服务器存储地址',
  `STORENAME` varchar(255) DEFAULT NULL COMMENT '文件服务器存储名称',
  `DELETE_STATUS` char(1) DEFAULT '0' COMMENT '文件是否被删除 0：未删除',
  `upload_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '文件上传时间',
  `file_size` double(255,0) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=243 DEFAULT CHARSET=utf8;

/*Data for the table `t_upload_file` */

insert  into `t_upload_file`(`id`,`appName`,`fileId`,`file_name`,`STOREPATH`,`STORENAME`,`DELETE_STATUS`,`upload_time`,`file_size`) values (1,'1','1473053384476','叉.png','20160905132944/banner_pic_urlcfccd1d8c1964e10a5d0f295d8ab03f6.png','banner_pic_urlcfccd1d8c1964e10a5d0f295d8ab03f6.png','0','2016-09-05 13:29:44',18302),(2,'1','1473053384586','带尾巴的实心圆叉.png','20160905132944/float_pic_urlda0579641c6e4a899bd25bbba0d5277b.png','float_pic_urlda0579641c6e4a899bd25bbba0d5277b.png','0','2016-09-05 13:29:44',18814),(3,'1','1473053384662','带尾巴的实心圆叉.png','20160905132944/open_pic_url1268f6dcdf8c4184b516a17eff4ea909.png','open_pic_url1268f6dcdf8c4184b516a17eff4ea909.png','0','2016-09-05 13:29:44',18814),(4,'1','1473053384850','2222.mp4','20160905132944/video_url7593fe659fb54ab49822809c988ec4f7.mp4','video_url7593fe659fb54ab49822809c988ec4f7.mp4','0','2016-09-05 13:29:44',57043612),(5,'1','1473053384921','叉.png','20160905132944/interstitial_pic_url0d1f83c343594e5c83108d139607557c.png','interstitial_pic_url0d1f83c343594e5c83108d139607557c.png','0','2016-09-05 13:29:44',18302),(6,'1','1473053384995','叉.png','20160905132944/lock_pic_url25cdebcef2c847bba7d31aa2535013a4.png','lock_pic_url25cdebcef2c847bba7d31aa2535013a4.png','0','2016-09-05 13:29:44',18302),(7,'1','1473053385073','新建日记本文档.apk','20160905132944/app_url783ea9d20cfe41b5bd4faeb523ee9540.apk','app_url783ea9d20cfe41b5bd4faeb523ee9540.apk','0','2016-09-05 13:29:45',4544),(8,'1','1473053385146','方叉.png','20160905132944/notification_bar_pic_urlaff6ce9ace344b71beaf81eff785da77.png','notification_bar_pic_urlaff6ce9ace344b71beaf81eff785da77.png','0','2016-09-05 13:29:45',18272),(9,'filetesting','1473053786404','叉.png','2016-09-05\\20160905133626/banner_pic_url587bbd669de949c8985f12d44cc864a6.png','banner_pic_url587bbd669de949c8985f12d44cc864a6.png','0','2016-09-05 13:36:26',18302),(10,'filetesting','1473053786482','带尾巴的实心圆叉.png','2016-09-05\\20160905133626/float_pic_urlb15e0204deff43e781c450a4392953da.png','float_pic_urlb15e0204deff43e781c450a4392953da.png','0','2016-09-05 13:36:26',18814),(11,'filetesting','1473053786573','带尾巴的实心圆叉.png','2016-09-05\\20160905133626/open_pic_url453bb79bd3694e62899f8db9e06aa0d2.png','open_pic_url453bb79bd3694e62899f8db9e06aa0d2.png','0','2016-09-05 13:36:26',18814),(12,'filetesting','1473053786799','2222.mp4','2016-09-05\\20160905133626/video_url282b837c5620442290a0d0d0937da8c5.mp4','video_url282b837c5620442290a0d0d0937da8c5.mp4','0','2016-09-05 13:36:26',57043612),(13,'filetesting','1473053786881','叉.png','2016-09-05\\20160905133626/interstitial_pic_urlbb22ce34a5c248fd9e4a010537d1b18c.png','interstitial_pic_urlbb22ce34a5c248fd9e4a010537d1b18c.png','0','2016-09-05 13:36:26',18302),(14,'filetesting','1473053786953','带尾巴的空心圆叉.png','2016-09-05\\20160905133626/lock_pic_urlf74061db991a48e2abd27954c5c173c1.png','lock_pic_urlf74061db991a48e2abd27954c5c173c1.png','0','2016-09-05 13:36:26',19181),(15,'filetesting','1473053787031','新建日记本文档.apk','2016-09-05\\20160905133626/app_url2666010809b940ec97c6502c159b70bb.apk','app_url2666010809b940ec97c6502c159b70bb.apk','0','2016-09-05 13:36:26',4544),(16,'filetesting','1473053787108','方叉.png','2016-09-05\\20160905133626/notification_bar_pic_url776afe45a142467b916db1e021f7204b.png','notification_bar_pic_url776afe45a142467b916db1e021f7204b.png','0','2016-09-05 13:36:27',18272),(17,'sd','1473055149666','带尾巴的空心圆叉.png','20160905\\20160905135909/banner_pic_urlf8a9bf54782b4d58bb739916b3ff6f55.png','banner_pic_urlf8a9bf54782b4d58bb739916b3ff6f55.png','0','2016-09-05 13:59:09',19181),(18,'sd','1473055149744','方叉.png','20160905\\20160905135909/float_pic_url2ce49b749ab2473a9fb8281db130b7da.png','float_pic_url2ce49b749ab2473a9fb8281db130b7da.png','0','2016-09-05 13:59:09',18272),(19,'sd','1473055149854','叉.png','20160905\\20160905135909/open_pic_url81fa9b248318445a992d265fc3d2a36c.png','open_pic_url81fa9b248318445a992d265fc3d2a36c.png','0','2016-09-05 13:59:09',18302),(20,'sd','1473055150050','2222.mp4','20160905\\20160905135909/video_url303301448be24d9aa3a85d0c284a6c8e.mp4','video_url303301448be24d9aa3a85d0c284a6c8e.mp4','0','2016-09-05 13:59:09',57043612),(21,'sd','1473055150126','带尾巴的实心圆叉.png','20160905\\20160905135909/interstitial_pic_url66a6ff0f879b4f288c0aa4dc9600c7cd.png','interstitial_pic_url66a6ff0f879b4f288c0aa4dc9600c7cd.png','0','2016-09-05 13:59:10',18814),(22,'sd','1473055150215','带尾巴的实心圆叉.png','20160905\\20160905135909/lock_pic_urlbed0c30c15d44f4892cc515ce714d341.png','lock_pic_urlbed0c30c15d44f4892cc515ce714d341.png','0','2016-09-05 13:59:10',18814),(23,'sd','1473055150292','新建日记本文档.apk','20160905\\20160905135909/app_url85c4f647ee664d249594c1c758d6dd97.apk','app_url85c4f647ee664d249594c1c758d6dd97.apk','0','2016-09-05 13:59:10',4544),(24,'开心消消乐','1473059258418','叉.png','20160905\\20160905150738/banner_pic_urle161f8ef5c1d40fbafba533519cf0a4d.png','banner_pic_urle161f8ef5c1d40fbafba533519cf0a4d.png','0','2016-09-05 15:07:38',18302),(25,'开心消消乐','1473059258522','圆叉.png','20160905\\20160905150738/float_pic_url89545be7cbe7442baca2dd5b6668cda0.png','float_pic_url89545be7cbe7442baca2dd5b6668cda0.png','0','2016-09-05 15:07:38',18462),(26,'开心消消乐','1473059258601','带尾巴的空心圆叉.png','20160905\\20160905150738/open_pic_url594a4b84a86f468d97e5a7a6f10f6758.png','open_pic_url594a4b84a86f468d97e5a7a6f10f6758.png','0','2016-09-05 15:07:38',19181),(27,'开心消消乐','1473059258784','2222.mp4','20160905\\20160905150738/video_urlc88cfb511dfa4d848bccc9d73a789fa0.mp4','video_urlc88cfb511dfa4d848bccc9d73a789fa0.mp4','0','2016-09-05 15:07:38',57043612),(28,'开心消消乐','1473059258857','方叉.png','20160905\\20160905150738/interstitial_pic_url6d0f4bd8a2254788badd081dd2aa4abe.png','interstitial_pic_url6d0f4bd8a2254788badd081dd2aa4abe.png','0','2016-09-05 15:07:38',18272),(29,'开心消消乐','1473059258927','叉.png','20160905\\20160905150738/lock_pic_url1e3ec276fb57475cbc60fb5ff880159a.png','lock_pic_url1e3ec276fb57475cbc60fb5ff880159a.png','0','2016-09-05 15:07:38',18302),(30,'开心消消乐','1473059258996','新建日记本文档.apk','20160905\\20160905150738/app_url16e1c520fad24fa08ff48d4b2a6d75d1.apk','app_url16e1c520fad24fa08ff48d4b2a6d75d1.apk','0','2016-09-05 15:07:38',4544),(31,'开心消消乐','1473059259068','带尾巴的实心圆叉.png','20160905\\20160905150738/notification_bar_pic_urlc275e1bf280942c5ac81fcbb599dac6b.png','notification_bar_pic_urlc275e1bf280942c5ac81fcbb599dac6b.png','0','2016-09-05 15:07:38',18814),(32,'11','1473059371846','叉.png','20160905\\20160905150931/banner_pic_url10eaa65c022f4fc2baed7c179acf7c62.png','banner_pic_url10eaa65c022f4fc2baed7c179acf7c62.png','0','2016-09-05 15:09:31',18302),(33,'11','1473059371976','带尾巴的空心圆叉.png','20160905\\20160905150931/float_pic_urlb7a6011f98944461b4fe1f6b359a3b68.png','float_pic_urlb7a6011f98944461b4fe1f6b359a3b68.png','0','2016-09-05 15:09:31',19181),(34,'11','1473059372046','带尾巴的实心圆叉.png','20160905\\20160905150931/open_pic_urlecc253d1f45648bc9b3754049826b95e.png','open_pic_urlecc253d1f45648bc9b3754049826b95e.png','0','2016-09-05 15:09:31',18814),(35,'11','1473059372259','2222.mp4','20160905\\20160905150931/video_urlaf61de75f35b45548192574135c7b829.mp4','video_urlaf61de75f35b45548192574135c7b829.mp4','0','2016-09-05 15:09:32',57043612),(36,'11','1473059372331','方叉.png','20160905\\20160905150931/interstitial_pic_urlfeda56558abf4af58edacd6486e74dae.png','interstitial_pic_urlfeda56558abf4af58edacd6486e74dae.png','0','2016-09-05 15:09:32',18272),(37,'11','1473059372417','叉.png','20160905\\20160905150931/lock_pic_urlff29238b82e24074acb9e14ccea9f67c.png','lock_pic_urlff29238b82e24074acb9e14ccea9f67c.png','0','2016-09-05 15:09:32',18302),(38,'11','1473059372487','新建日记本文档.apk','20160905\\20160905150931/app_urlbe13ea07ad734b8ebd389be87af7f06d.apk','app_urlbe13ea07ad734b8ebd389be87af7f06d.apk','0','2016-09-05 15:09:32',4544),(39,'11','1473059372559','带尾巴的实心圆叉.png','20160905\\20160905150931/notification_bar_pic_url002b3cf255ba4b148eb5ddf691ce76a9.png','notification_bar_pic_url002b3cf255ba4b148eb5ddf691ce76a9.png','0','2016-09-05 15:09:32',18814),(40,'新的','1473060519575','带尾巴的实心圆叉.png','20160905/20160905152839/banner_pic_url6adc06ff7b10428587f4a28ee95c0bf6.png','banner_pic_url6adc06ff7b10428587f4a28ee95c0bf6.png','0','2016-09-05 15:28:39',18814),(41,'新的','1473060519683','叉.png','20160905/20160905152839/float_pic_urlf37d6033afa342a7bb3450deadf2dfdd.png','float_pic_urlf37d6033afa342a7bb3450deadf2dfdd.png','0','2016-09-05 15:28:39',18302),(42,'新的','1473060519755','叉.png','20160905/20160905152839/open_pic_url51e5bc356b1d41dc8f9e1a3e366c055d.png','open_pic_url51e5bc356b1d41dc8f9e1a3e366c055d.png','0','2016-09-05 15:28:39',18302),(43,'新的','1473060519939','2222.mp4','20160905/20160905152839/video_urld443066c8dd142a089d52a2a4921e988.mp4','video_urld443066c8dd142a089d52a2a4921e988.mp4','0','2016-09-05 15:28:39',57043612),(44,'新的','1473060520021','方叉.png','20160905/20160905152839/interstitial_pic_url929415f6b33146c4ba10c9b7a6222e22.png','interstitial_pic_url929415f6b33146c4ba10c9b7a6222e22.png','0','2016-09-05 15:28:39',18272),(45,'新的','1473060520101','方叉.png','20160905/20160905152839/lock_pic_url6b81c98871b248b2bef70a20d65f46c1.png','lock_pic_url6b81c98871b248b2bef70a20d65f46c1.png','0','2016-09-05 15:28:40',18272),(46,'新的','1473060520176','新建日记本文档.apk','20160905/20160905152839/app_urlf45fb8bc38b4458e94bba8756c33dedc.apk','app_urlf45fb8bc38b4458e94bba8756c33dedc.apk','0','2016-09-05 15:28:40',4544),(47,'新的','1473060520254','带尾巴的空心圆叉.png','20160905/20160905152839/notification_bar_pic_urlb10f3a4b91eb4afd835639c121cdd821.png','notification_bar_pic_urlb10f3a4b91eb4afd835639c121cdd821.png','0','2016-09-05 15:28:40',19181),(48,'新的','1473060652192','叉.png','20160905/20160905153052/banner_pic_url899918cfa98a44c2a75ac2f945c76d14.png','banner_pic_url899918cfa98a44c2a75ac2f945c76d14.png','0','2016-09-05 15:30:52',18302),(49,'新的','1473060652306','带尾巴的空心圆叉.png','20160905/20160905153052/float_pic_url2babc20d778d4c5e89205896443e0621.png','float_pic_url2babc20d778d4c5e89205896443e0621.png','0','2016-09-05 15:30:52',19181),(50,'新的','1473060652379','带尾巴的实心圆叉.png','20160905/20160905153052/open_pic_urldb11967f05544f2fa52763cc75ce73b5.png','open_pic_urldb11967f05544f2fa52763cc75ce73b5.png','0','2016-09-05 15:30:52',18814),(51,'新的','1473060652556','2222.mp4','20160905/20160905153052/video_url57069144f3ae4df79b3176392e670b4f.mp4','video_url57069144f3ae4df79b3176392e670b4f.mp4','0','2016-09-05 15:30:52',57043612),(52,'新的','1473060652626','圆叉.png','20160905/20160905153052/interstitial_pic_urlb65898e9a23d44f3b2ef091afc3801a8.png','interstitial_pic_urlb65898e9a23d44f3b2ef091afc3801a8.png','0','2016-09-05 15:30:52',18462),(53,'新的','1473060652696','带尾巴的空心圆叉.png','20160905/20160905153052/lock_pic_urlebc0f59fdc984d12bc27eed8622a912a.png','lock_pic_urlebc0f59fdc984d12bc27eed8622a912a.png','0','2016-09-05 15:30:52',19181),(54,'新的','1473060652770','新建日记本文档.apk','20160905/20160905153052/app_url86fc3a590e0a4c0bae0e87a92cf53e88.apk','app_url86fc3a590e0a4c0bae0e87a92cf53e88.apk','0','2016-09-05 15:30:52',4544),(55,'新的','1473060652843','方叉.png','20160905/20160905153052/notification_bar_pic_urle14fb8e27daf477b8c1817b63a18b91a.png','notification_bar_pic_urle14fb8e27daf477b8c1817b63a18b91a.png','0','2016-09-05 15:30:52',18272),(56,'试试','1473131582081','叉.png','20160906/20160906111301/banner_pic_urlbe93f879f4084e60a704a3577fff288b.png','banner_pic_urlbe93f879f4084e60a704a3577fff288b.png','0','2016-09-06 11:13:03',18302),(57,'试试','1473131582221','带尾巴的空心圆叉.png','20160906/20160906111301/float_pic_url1026aa4d0d954b9cb0bc423cbac5f6d3.png','float_pic_url1026aa4d0d954b9cb0bc423cbac5f6d3.png','0','2016-09-06 11:13:04',19181),(58,'试试','1473131582301','方叉.png','20160906/20160906111301/open_pic_url47d50094a278478ca03fd860dcdc56b7.png','open_pic_url47d50094a278478ca03fd860dcdc56b7.png','0','2016-09-06 11:13:04',18272),(59,'试试','1473131582468','2222.mp4','20160906/20160906111301/video_urleb309bab91a947f8a39d92a0c47dd271.mp4','video_urleb309bab91a947f8a39d92a0c47dd271.mp4','0','2016-09-06 11:13:04',57043612),(60,'试试','1473131582535','圆叉.png','20160906/20160906111301/interstitial_pic_urla9721a9c38d0448cb805e56992c2649e.png','interstitial_pic_urla9721a9c38d0448cb805e56992c2649e.png','0','2016-09-06 11:13:04',18462),(61,'试试','1473131582606','叉.png','20160906/20160906111301/lock_pic_urlfcdb823c4f6149a1a005a60f6cc0026d.png','lock_pic_urlfcdb823c4f6149a1a005a60f6cc0026d.png','0','2016-09-06 11:13:04',18302),(62,'试试','1473131582675','方叉.png','20160906/20160906111301/notification_bar_pic_url62f105c74abd4923b68fd2fc3c1b6892.png','notification_bar_pic_url62f105c74abd4923b68fd2fc3c1b6892.png','0','2016-09-06 11:13:04',18272),(63,'试试','1473131729068','叉.png','20160906/20160906111529/banner_pic_urlb5b4c37be2114c6cb4ab8ce027cdf5c1.png','banner_pic_urlb5b4c37be2114c6cb4ab8ce027cdf5c1.png','0','2016-09-06 11:15:30',18302),(64,'试试','1473131729169','叉.png','20160906/20160906111529/float_pic_url34ce8aac0e8242dab60155ebfd7b25d4.png','float_pic_url34ce8aac0e8242dab60155ebfd7b25d4.png','0','2016-09-06 11:15:30',18302),(65,'试试','1473131729238','带尾巴的实心圆叉.png','20160906/20160906111529/open_pic_urlfc8d75d7cf4a41498d3763a2632ea89a.png','open_pic_urlfc8d75d7cf4a41498d3763a2632ea89a.png','0','2016-09-06 11:15:31',18814),(66,'试试','1473131729442','2222.mp4','20160906/20160906111529/video_urla0f414eb74b843d69dd9d08a240c4ba8.mp4','video_urla0f414eb74b843d69dd9d08a240c4ba8.mp4','0','2016-09-06 11:15:31',57043612),(67,'试试','1473131729518','方叉.png','20160906/20160906111529/interstitial_pic_url356274d44a2a4a6dac986ad1516cdb94.png','interstitial_pic_url356274d44a2a4a6dac986ad1516cdb94.png','0','2016-09-06 11:15:31',18272),(68,'试试','1473131729589','方叉.png','20160906/20160906111529/lock_pic_urlfde38a94b62e442a81e93e40def7c4be.png','lock_pic_urlfde38a94b62e442a81e93e40def7c4be.png','0','2016-09-06 11:15:31',18272),(69,'试试','1473131729659','圆叉.png','20160906/20160906111529/notification_bar_pic_url8c8313f0f99b4c7e971acc02bac42800.png','notification_bar_pic_url8c8313f0f99b4c7e971acc02bac42800.png','0','2016-09-06 11:15:31',18462),(70,'新','1473131949999','带尾巴的空心圆叉.png','20160906/20160906111909/banner_pic_url53046b0c676246519b278b9e4e5cb7c5.png','banner_pic_url53046b0c676246519b278b9e4e5cb7c5.png','0','2016-09-06 11:19:11',19181),(71,'新','1473131950106','圆叉.png','20160906/20160906111909/float_pic_url9b45918d98c948c19ffbd4a8b07f36d1.png','float_pic_url9b45918d98c948c19ffbd4a8b07f36d1.png','0','2016-09-06 11:19:11',18462),(72,'新','1473131950183','带尾巴的实心圆叉.png','20160906/20160906111909/open_pic_urla9404517c2e747619f88fd7941df3ffb.png','open_pic_urla9404517c2e747619f88fd7941df3ffb.png','0','2016-09-06 11:19:12',18814),(73,'新','1473131950363','2222.mp4','20160906/20160906111909/video_url52a80221e0c34a21897b49e902add683.mp4','video_url52a80221e0c34a21897b49e902add683.mp4','0','2016-09-06 11:19:12',57043612),(74,'新','1473131950435','叉.png','20160906/20160906111909/interstitial_pic_url83d6ab7cbdd34e0f91f054ab45f52eaf.png','interstitial_pic_url83d6ab7cbdd34e0f91f054ab45f52eaf.png','0','2016-09-06 11:19:12',18302),(75,'新','1473131950503','叉.png','20160906/20160906111909/lock_pic_url482e6795cf294771a387284e9410a516.png','lock_pic_url482e6795cf294771a387284e9410a516.png','0','2016-09-06 11:19:12',18302),(76,'新','1473131950576','方叉.png','20160906/20160906111909/notification_bar_pic_urldbccd0c72657488d838566e5377d435f.png','notification_bar_pic_urldbccd0c72657488d838566e5377d435f.png','0','2016-09-06 11:19:12',18272),(77,'联调测试','1474279098222','480x800.jpg','20160919/20160919175818/banner_pic_url243d9b86f9d24e65af4bd8303cce7bff.jpg','banner_pic_url243d9b86f9d24e65af4bd8303cce7bff.jpg','0','2016-09-19 17:58:18',105346),(78,'联调测试','1474279098350','waveTuo2.apk','20160919/20160919175818/app_url7511c029c1014843b5a7b3120b38df4f.apk','app_url7511c029c1014843b5a7b3120b38df4f.apk','0','2016-09-19 17:58:18',79762),(79,'联调测试','1474280300432','480x800.jpg','20160919/20160919181820/banner_pic_url85a71dc97b1f4cd381284a4b93037e53.jpg','banner_pic_url85a71dc97b1f4cd381284a4b93037e53.jpg','0','2016-09-19 18:18:20',105346),(80,'联调测试','1474280300511','waveTuo2.apk','20160919/20160919181820/app_url22d2fe93cfa54ff7bd0f36f7649d3a78.apk','app_url22d2fe93cfa54ff7bd0f36f7649d3a78.apk','0','2016-09-19 18:18:20',79762),(81,'全屏位广告','1474354253993','480x800.jpg','20160920/20160920145053/open_pic_urle39d5a2aabc5481fa7cda76551fe82dc.jpg','open_pic_urle39d5a2aabc5481fa7cda76551fe82dc.jpg','0','2016-09-20 14:50:53',105346),(82,'全屏位广告','1474354272193','Meizi.apk','20160920/20160920145053/app_url708a487f73fc45d2bd13a5a53bf595cf.apk','app_url708a487f73fc45d2bd13a5a53bf595cf.apk','0','2016-09-20 14:51:12',1174761),(83,'插屏位广告','1474358969294','800x1280.jpg','20160920/20160920160929/interstitial_pic_url9b3fce65a59d4b6ca9d20084fa645e50.jpg','interstitial_pic_url9b3fce65a59d4b6ca9d20084fa645e50.jpg','0','2016-09-20 16:09:29',138158),(84,'插屏位广告','1474358969400','Meizi_final.apk','20160920/20160920160929/app_url6cd30ab3d97545239698295630ac43e1.apk','app_url6cd30ab3d97545239698295630ac43e1.apk','0','2016-09-20 16:09:29',1302730),(85,'通知栏广告','1474360987487','Meizi.apk','20160920/20160920164307/app_urld3f1bb7af7a745d9a7b57de2d6e94b6c.apk','app_urld3f1bb7af7a745d9a7b57de2d6e94b6c.apk','0','2016-09-20 16:43:07',1174761),(86,'通知栏广告','1474360987557','icon_72.png','20160920/20160920164307/notification_bar_pic_urld70ecc7c5306423180b3f222ef658fd3.png','notification_bar_pic_urld70ecc7c5306423180b3f222ef658fd3.png','0','2016-09-20 16:43:07',3954),(87,'six_clock_test','1474395079058','Meizi.apk','20160921/20160921021119/app_urlf9f6fe6e83d54e72a78f3909a13efd6b.apk','app_urlf9f6fe6e83d54e72a78f3909a13efd6b.apk','0','2016-09-20 18:11:22',1174761),(88,'six_clock_test','1474395079132','icon_72.png','20160921/20160921021119/notification_bar_pic_url5d11d89c6e12480ebeaf6c1a148525e1.png','notification_bar_pic_url5d11d89c6e12480ebeaf6c1a148525e1.png','0','2016-09-20 18:11:22',3954),(89,'测试视频','1474451354268','480x800.jpg','20160921/20160921174913/banner_pic_url9ca20b6cbcfc41aa95a25feb28b2e518.jpg','banner_pic_url9ca20b6cbcfc41aa95a25feb28b2e518.jpg','0','2016-09-21 17:49:14',105346),(90,'测试游戏','1474451426597','800x1280.jpg','20160921/20160921175026/banner_pic_url214c2115e6494c6a94cdc2ec4b415d7d.jpg','banner_pic_url214c2115e6494c6a94cdc2ec4b415d7d.jpg','0','2016-09-21 17:50:26',138158),(91,'测试副','1474510154045','Meizi.apk','20160922/20160922100913/app_url8ce2051784504775b5f652d3201e7de8.apk','app_url8ce2051784504775b5f652d3201e7de8.apk','0','2016-09-22 10:09:14',1174761),(92,'测试视频2','1474540097686','480x800.jpg','20160922/20160922182817/banner_pic_url1a18adca965345ce8034a96204064f3f.jpg','banner_pic_url1a18adca965345ce8034a96204064f3f.jpg','0','2016-09-22 10:28:18',81534),(93,'测试视频2','1474540097775','9120291_signed.apk','20160922/20160922182817/app_url0e1f9047749b4aca95d2a63d0d759f88.apk','app_url0e1f9047749b4aca95d2a63d0d759f88.apk','0','2016-09-22 10:28:18',1664077),(94,'11','1474511921958','15091109384933016.png','20160922/20160922103841/banner_pic_urlcc5d13db760d47dc8824829282c90fb2.png','banner_pic_urlcc5d13db760d47dc8824829282c90fb2.png','0','2016-09-22 10:38:46',49457),(95,'11','1474511922038','150911093849798113.png','20160922/20160922103841/open_pic_urlb17d4630a7194b61a39b322c41f6ec01.png','open_pic_urlb17d4630a7194b61a39b322c41f6ec01.png','0','2016-09-22 10:38:46',43438),(96,'1','1474512067744','15091109384947018.png','20160922/20160922104107/banner_pic_urla8ae09bc5dfb45418ddf3c6aade1f221.png','banner_pic_urla8ae09bc5dfb45418ddf3c6aade1f221.png','0','2016-09-22 10:41:12',42614),(97,'测试视频3','1474541783861','480x800.jpg','20160922/20160922185623/banner_pic_url6c11c5b4a41747969d23e96ce8434924.jpg','banner_pic_url6c11c5b4a41747969d23e96ce8434924.jpg','0','2016-09-22 10:56:24',81534),(98,'测试视频3','1474541783982','9120291_signed.apk','20160922/20160922185623/app_url5ab5ae7d1af0444fa85baae1fed60c9f.apk','app_url5ab5ae7d1af0444fa85baae1fed60c9f.apk','0','2016-09-22 10:56:25',1664077),(99,'测试游戏3','1474542678909','800x1280.jpg','20160922/20160922191118/banner_pic_url4272375ea16b4451bf19c54a3c8b9e6a.jpg','banner_pic_url4272375ea16b4451bf19c54a3c8b9e6a.jpg','0','2016-09-22 11:11:19',167740),(100,'测试游戏3','1474542679005','1000432_signed.apk','20160922/20160922191118/app_url028ccae2ef0247c9b087573271e084f7.apk','app_url028ccae2ef0247c9b087573271e084f7.apk','0','2016-09-22 11:11:20',7272770),(101,'通知栏广告2','1474543680374','1000432_signed.apk','20160922/20160922192800/app_urld4a59cf27c3a480bb26ce7f642ae8ac7.apk','app_urld4a59cf27c3a480bb26ce7f642ae8ac7.apk','0','2016-09-22 11:28:01',7272770),(102,'通知栏广告2','1474543680484','icon_72.png','20160922/20160922192800/notification_bar_pic_url81e8e6e83c5048efaefd1fdcc0755901.png','notification_bar_pic_url81e8e6e83c5048efaefd1fdcc0755901.png','0','2016-09-22 11:28:01',3954),(103,'通知栏广告3','1474543810892','Meizi.apk','20160922/20160922193010/app_url7becd87b3c174f09900dcb50857114fc.apk','app_url7becd87b3c174f09900dcb50857114fc.apk','0','2016-09-22 11:30:11',1174761),(104,'通知栏广告3','1474543810962','icon_72.png','20160922/20160922193010/notification_bar_pic_urld65e808f827b4acdbcd9eca3a5632f6b.png','notification_bar_pic_urld65e808f827b4acdbcd9eca3a5632f6b.png','0','2016-09-22 11:30:11',3954),(105,'一只猪','1474626069785','480x600 2.jpg','20160923/20160923182109/interstitial_pic_urla64add8b423047c7892740631b1f9c77.jpg','interstitial_pic_urla64add8b423047c7892740631b1f9c77.jpg','0','2016-09-23 10:21:09',84335),(106,'一只猪','1474626069909','9140035_signed.apk','20160923/20160923182109/app_urle51fb8f0705a46958703382bbef61ba7.apk','app_urle51fb8f0705a46958703382bbef61ba7.apk','0','2016-09-23 10:21:09',2176456),(107,'两只猪','1474637062687','480X600.jpg','20160923/20160923212422/interstitial_pic_url6ea30b52b01c43c39061a8395c2c6db2.jpg','interstitial_pic_url6ea30b52b01c43c39061a8395c2c6db2.jpg','0','2016-09-23 13:24:22',51717),(108,'两只猪','1474637062792','9140027_signed.apk','20160923/20160923212422/app_url3e95771936454b5e8437805f4e794192.apk','app_url3e95771936454b5e8437805f4e794192.apk','0','2016-09-23 13:24:22',2312365),(109,'三只猪','1474637458280','1.jpg','20160923/20160923213058/open_pic_urldcfbc7597b7543d982dd007b7d78c579.jpg','open_pic_urldcfbc7597b7543d982dd007b7d78c579.jpg','0','2016-09-23 13:30:57',217342),(110,'三只猪','1474637458348','妹子换装.apk','20160923/20160923213058/app_url7d548c970be8425e8664fef88515b3a4.apk','app_url7d548c970be8425e8664fef88515b3a4.apk','0','2016-09-23 13:30:57',1659464),(111,'四只猪','1474640888647','2.jpg','20160923/20160923222808/open_pic_url22324ddc43584490808a6d4e859dc4e8.jpg','open_pic_url22324ddc43584490808a6d4e859dc4e8.jpg','0','2016-09-23 14:28:07',178117),(112,'四只猪','1474640888760','9140035_signed.apk','20160923/20160923222808/app_url10407a136f38482ab0fad587d547ecaa.apk','app_url10407a136f38482ab0fad587d547ecaa.apk','0','2016-09-23 14:28:08',2176456),(113,'五只猪','1474643045174','1080x290.jpg','20160923/20160923230405/banner_pic_url95925e0dbd5c4bc89715c7b9807e3337.jpg','banner_pic_url95925e0dbd5c4bc89715c7b9807e3337.jpg','0','2016-09-23 15:04:04',76598),(114,'五只猪','1474643045258','视频终极版.apk','20160923/20160923230405/app_url7427ec9b5ee345c79b1b55ab07c00ed5.apk','app_url7427ec9b5ee345c79b1b55ab07c00ed5.apk','0','2016-09-23 15:04:04',1181983),(115,'六只猪','1474643370839','1.jpg','20160923/20160923230930/banner_pic_url511a8facdade4b22bd140ca17d8e92e2.jpg','banner_pic_url511a8facdade4b22bd140ca17d8e92e2.jpg','0','2016-09-23 15:09:30',56315),(116,'六只猪','1474643370954','视频终极版.apk','20160923/20160923230930/app_url7b26013490184894b1a7f59caa96487a.apk','app_url7b26013490184894b1a7f59caa96487a.apk','0','2016-09-23 15:09:30',1181983),(117,'七只猪','1474643456496','2.jpg','20160923/20160923231056/banner_pic_urlc87a80e80e9e4a97af99a6d489b2017a.jpg','banner_pic_urlc87a80e80e9e4a97af99a6d489b2017a.jpg','0','2016-09-23 15:10:55',81730),(118,'七只猪','1474643456570','5.5哥哥坏死了_bai.wf.du_1号白包.apk','20160923/20160923231056/app_urleac1bdeea87043ad8852cd85b60287f5.apk','app_urleac1bdeea87043ad8852cd85b60287f5.apk','0','2016-09-23 15:10:55',657697),(119,'八只猪','1474643674634','2.jpg','20160923/20160923231434/banner_pic_url56a8e7ec13e04166bd71f141ab7c321c.jpg','banner_pic_url56a8e7ec13e04166bd71f141ab7c321c.jpg','0','2016-09-23 15:14:33',81730),(120,'八只猪','1474643674747','4.29情迷夜色_bai.ef.du_1号白包.apk','20160923/20160923231434/app_url87e61b5ca4ac48ecb340adb79e694ca4.apk','app_url87e61b5ca4ac48ecb340adb79e694ca4.apk','0','2016-09-23 15:14:33',658251),(121,'1','1474624126411','t.apk','20160923/20160923174846/app_url64ce1df3e89c43428f35434d9bf135f6.apk','app_url64ce1df3e89c43428f35434d9bf135f6.apk','0','2016-09-23 17:48:52',223630),(122,'123','1474624565234','t.apk','20160923/20160923175605/app_url25186c908faf41cf898d3be1d309dfcf.apk','app_url25186c908faf41cf898d3be1d309dfcf.apk','0','2016-09-23 17:56:11',223630),(123,'1212','1474624857921','t.apk','20160923/20160923180057/app_urld75966c65a694a50adc0712795769550.apk','app_urld75966c65a694a50adc0712795769550.apk','0','2016-09-23 18:01:03',223630),(124,'12','1474626073056','t.apk','20160923/20160923182113/app_urla0ee278ea888492c81a31779154e0a86.apk','app_urla0ee278ea888492c81a31779154e0a86.apk','0','2016-09-23 18:21:19',223630),(125,'12','1474626125542','t.apk','20160923/20160923182205/app_url67da641c0bf246b89e579b2815153a5a.apk','app_url67da641c0bf246b89e579b2815153a5a.apk','0','2016-09-23 18:22:11',223630),(126,'12','1474626177017','t.apk','20160923/20160923182257/app_url1b98e99c99ba42a3bd22a0e35285472a.apk','app_url1b98e99c99ba42a3bd22a0e35285472a.apk','0','2016-09-23 18:23:02',223630),(127,'12','1474626278349','t.apk','20160923/20160923182438/app_url485a8000d8a1420f8a96c31c6f529c2c.apk','app_url485a8000d8a1420f8a96c31c6f529c2c.apk','0','2016-09-23 18:24:44',223630),(128,'12','1474626388627','t.apk','20160923/20160923182628/app_url80e816605a0a425bb78c432d1f30b324.apk','app_url80e816605a0a425bb78c432d1f30b324.apk','0','2016-09-23 18:26:34',223630),(129,'1','1474626749765','t.apk','20160923/20160923183229/app_url8fc9c7ddd55b46a39e39df002832258c.apk','app_url8fc9c7ddd55b46a39e39df002832258c.apk','0','2016-09-23 18:32:35',223630),(130,'12','1474626892525','t.apk','20160923/20160923183452/app_url748ff62864674825829d1bf8264c1f50.apk','app_url748ff62864674825829d1bf8264c1f50.apk','0','2016-09-23 18:34:58',223630),(131,'12','1474627125880','t.apk','20160923/20160923183845/app_url74e6ef5f360b4f34abcf34563193782a.apk','app_url74e6ef5f360b4f34abcf34563193782a.apk','0','2016-09-23 18:38:51',223630),(132,'12','1474627787995','t.apk','20160923/20160923184947/app_url38c95d9373c249c9a673476b44fbce74.apk','app_url38c95d9373c249c9a673476b44fbce74.apk','0','2016-09-23 18:49:53',223630),(133,'12','1474627973579','t.apk','20160923/20160923185253/app_url863acb2e292a4d999ae1ed8ffc6bd829.apk','app_url863acb2e292a4d999ae1ed8ffc6bd829.apk','0','2016-09-23 18:52:59',223630),(134,'12','1474628038816','t.apk','20160923/20160923185358/app_url30859d3166e2439680df469b246e3354.apk','app_url30859d3166e2439680df469b246e3354.apk','0','2016-09-23 18:54:04',223630),(135,'928test','1475045124713','DZ8%G]$BHC)`M5`MA8XFM9Y.gif','20160928/20160928144524/banner_pic_url7079279f20854f19a9abca3a02e7110a.gif','banner_pic_url7079279f20854f19a9abca3a02e7110a.gif','0','2016-09-28 14:45:27',299008),(136,'928test','1475045124815','DZ8%G]$BHC)`M5`MA8XFM9Y.gif','20160928/20160928144524/float_pic_urled900b7f1f6243769c18b0736f170966.gif','float_pic_urled900b7f1f6243769c18b0736f170966.gif','0','2016-09-28 14:45:27',299008),(137,'928test','1475045124883','DZ8%G]$BHC)`M5`MA8XFM9Y.gif','20160928/20160928144524/open_pic_urld2fc8dec473c404c9376aa9dd5142503.gif','open_pic_urld2fc8dec473c404c9376aa9dd5142503.gif','0','2016-09-28 14:45:28',299008),(138,'928test','1475045124950','DZ8%G]$BHC)`M5`MA8XFM9Y.gif','20160928/20160928144524/interstitial_pic_url65320005d2ee4182be16dff60d0f6a32.gif','interstitial_pic_url65320005d2ee4182be16dff60d0f6a32.gif','0','2016-09-28 14:45:28',299008),(139,'928test','1475045125019','DZ8%G]$BHC)`M5`MA8XFM9Y.gif','20160928/20160928144524/lock_pic_url129178eaa13d4b728111623edffc6da7.gif','lock_pic_url129178eaa13d4b728111623edffc6da7.gif','0','2016-09-28 14:45:28',299008),(140,'928test','1475045125085','t.apk','20160928/20160928144524/app_urla9059e0d4df4459c9a491fec7c75758a.apk','app_urla9059e0d4df4459c9a491fec7c75758a.apk','0','2016-09-28 14:45:28',223630),(141,'嘿嘿嘿','1475113572675','480x800.jpg','20160929/20160929094612/interstitial_pic_url9664b356d3724b80a723f82d7352f997.jpg','interstitial_pic_url9664b356d3724b80a723f82d7352f997.jpg','0','2016-09-29 09:46:12',105346),(142,'嘿嘿嘿','1475113572781','Meizi_final.apk','20160929/20160929094612/app_urlf408efa0dd874032b518c7c7a6ee6e3b.apk','app_urlf408efa0dd874032b518c7c7a6ee6e3b.apk','0','2016-09-29 09:46:12',1302730),(143,'929test','1475155245789','480x800.jpg','20160929/20160929212045/banner_pic_url7e3acf2fae5248f3b32c4e335fe8c7cf.jpg','banner_pic_url7e3acf2fae5248f3b32c4e335fe8c7cf.jpg','0','2016-09-29 13:20:35',105346),(144,'929test','1475155245893','Meizi_final.apk','20160929/20160929212045/app_url00be7eafa23c4696b52c6ea380ce3d7e.apk','app_url00be7eafa23c4696b52c6ea380ce3d7e.apk','0','2016-09-29 13:20:35',1302730),(145,'929test','1475155245961','icon_72.png','20160929/20160929212045/notification_bar_pic_url054d8a58e6834dd89a28663f69c44f48.png','notification_bar_pic_url054d8a58e6834dd89a28663f69c44f48.png','0','2016-09-29 13:20:35',3954),(146,'测试广告1','1475156044850','480x800.jpg','20160929/20160929213404/banner_pic_urlc2773f795cda4c9c8cf01267f78f860d.jpg','banner_pic_urlc2773f795cda4c9c8cf01267f78f860d.jpg','0','2016-09-29 13:33:54',105346),(147,'测试广告1','1475156044946','480x800.jpg','20160929/20160929213404/open_pic_url6b278b53d44a48f3b3823525533c7e72.jpg','open_pic_url6b278b53d44a48f3b3823525533c7e72.jpg','0','2016-09-29 13:33:54',105346),(148,'测试广告1','1475156045012','480x800.jpg','20160929/20160929213404/interstitial_pic_url7e6cfd41a2994691bd31c6b9b417894b.jpg','interstitial_pic_url7e6cfd41a2994691bd31c6b9b417894b.jpg','0','2016-09-29 13:33:54',105346),(149,'测试广告1','1475156045076','Meizi_final.apk','20160929/20160929213404/app_urle3495fbdb49542a2ba05c6ea944bd42b.apk','app_urle3495fbdb49542a2ba05c6ea944bd42b.apk','0','2016-09-29 13:33:54',1302730),(150,'测试广告1','1475156045139','icon_72.png','20160929/20160929213404/notification_bar_pic_urlc0c578c2fe0941098a21d4019b7ba5a9.png','notification_bar_pic_urlc0c578c2fe0941098a21d4019b7ba5a9.png','0','2016-09-29 13:33:54',3954),(151,'包名测试','1475157128003','15091109384887711.png','20160929/20160929215208/banner_pic_url7dfc271f95934338a26769f500d5e492.png','banner_pic_url7dfc271f95934338a26769f500d5e492.png','0','2016-09-29 13:51:57',30086),(152,'包名测试','1475157128111','15091109384873610.png','20160929/20160929215208/float_pic_url1b3cf8350ea141338c51ef60ccc39481.png','float_pic_url1b3cf8350ea141338c51ef60ccc39481.png','0','2016-09-29 13:51:57',31594),(153,'包名测试','1475157128176','15091109384903313.png','20160929/20160929215208/open_pic_url1317fdbd36074259a2feaa75182df6b8.png','open_pic_url1317fdbd36074259a2feaa75182df6b8.png','0','2016-09-29 13:51:57',33966),(154,'包名测试','1475157128243','15091109384887711.png','20160929/20160929215208/interstitial_pic_urlf706aa6786104b2c8fd9f1fbe2618f84.png','interstitial_pic_urlf706aa6786104b2c8fd9f1fbe2618f84.png','0','2016-09-29 13:51:57',30086),(155,'包名测试','1475157128310','150911094132295196.png','20160929/20160929215208/lock_pic_urlf388e40dc0434d629ee2a5df1659dd60.png','lock_pic_urlf388e40dc0434d629ee2a5df1659dd60.png','0','2016-09-29 13:51:58',77153),(156,'包名测试','1475157128378','t.apk','20160929/20160929215208/app_url0709325e62454ab6883b3d487494d3f1.apk','app_url0709325e62454ab6883b3d487494d3f1.apk','0','2016-09-29 13:51:58',223630),(157,'包名测试','1475157128453','150911094130842164.png','20160929/20160929215208/notification_bar_pic_url347e49754dd04864be83f18ad176ca64.png','notification_bar_pic_url347e49754dd04864be83f18ad176ca64.png','0','2016-09-29 13:51:58',73394),(158,'包名再测一次','1475157474583','15091109384895512.png','20160929/20160929215754/banner_pic_urlddaa08c5aaa343d2b2d0d55d8a92e449.png','banner_pic_urlddaa08c5aaa343d2b2d0d55d8a92e449.png','0','2016-09-29 13:57:44',49513),(159,'包名再测一次','1475157474654','150911093849673111.png','20160929/20160929215754/float_pic_urle457178864274cb99b56f32f4c1267fe.png','float_pic_urle457178864274cb99b56f32f4c1267fe.png','0','2016-09-29 13:57:44',44783),(160,'包名再测一次','1475157474722','150911094132373198.png','20160929/20160929215754/open_pic_urlaf839ba89dc34cedab71d33b2be37d82.png','open_pic_urlaf839ba89dc34cedab71d33b2be37d82.png','0','2016-09-29 13:57:44',68495),(161,'包名再测一次','1475157474795','150911093850017119.png','20160929/20160929215754/interstitial_pic_urlc427100e60ed40ee842b27260a1fc5d9.png','interstitial_pic_urlc427100e60ed40ee842b27260a1fc5d9.png','0','2016-09-29 13:57:44',48594),(162,'包名再测一次','1475157474863','15091109384925215.png','20160929/20160929215754/lock_pic_urlb49bfb62cba044d0832f64ac30a0afb9.png','lock_pic_urlb49bfb62cba044d0832f64ac30a0afb9.png','0','2016-09-29 13:57:44',38419),(163,'包名再测一次','1475157474933','t.apk','20160929/20160929215754/app_url84f3a1de7386487c942be693812d3071.apk','app_url84f3a1de7386487c942be693812d3071.apk','0','2016-09-29 13:57:44',223630),(164,'包名再测一次','1475157475014','15091109384947018.png','20160929/20160929215754/notification_bar_pic_url7fb06cbff29e4dfaba5db4b7e610d45a.png','notification_bar_pic_url7fb06cbff29e4dfaba5db4b7e610d45a.png','0','2016-09-29 13:57:44',42614),(165,'121','1475158624272','15091109384903313.png','20160929/20160929221704/banner_pic_urlc95a20186a9142c1b423b96ee657d6e7.png','banner_pic_urlc95a20186a9142c1b423b96ee657d6e7.png','0','2016-09-29 14:16:53',33966),(166,'121','1475158624347','15091109384925215.png','20160929/20160929221704/float_pic_url2bbd6be7f65a46339cce9c9abdbabfe5.png','float_pic_url2bbd6be7f65a46339cce9c9abdbabfe5.png','0','2016-09-29 14:16:54',38419),(167,'121','1475158624420','15091109384937717.png','20160929/20160929221704/open_pic_url6b091532689e40b48ec6734630c48c2a.png','open_pic_url6b091532689e40b48ec6734630c48c2a.png','0','2016-09-29 14:16:54',66497),(168,'121','1475158624489','150911093849986118.png','20160929/20160929221704/interstitial_pic_url29aab9ef480c48e2b31cc2f1791c20ae.png','interstitial_pic_url29aab9ef480c48e2b31cc2f1791c20ae.png','0','2016-09-29 14:16:54',41757),(169,'121','1475158624558','15091109384947018.png','20160929/20160929221704/lock_pic_urla167ebeea2b243ac9f29fab6657ea3d1.png','lock_pic_urla167ebeea2b243ac9f29fab6657ea3d1.png','0','2016-09-29 14:16:54',42614),(170,'121','1475158624631','t.apk','20160929/20160929221704/app_url817e6040b2324807a6c9739bcd9c6c5b.apk','app_url817e6040b2324807a6c9739bcd9c6c5b.apk','0','2016-09-29 14:16:54',223630),(171,'121','1475158624709','150911094132483199.png','20160929/20160929221704/notification_bar_pic_urld916db542ce0407b88d208b41de925e1.png','notification_bar_pic_urld916db542ce0407b88d208b41de925e1.png','0','2016-09-29 14:16:54',70396),(172,'XiaomingTest','1475138283892','Screenshot from 2016-09-12 21:19:19.png','20160929/20160929163803/float_pic_urlba40d300510c423da9877464f130c2f3.png','float_pic_urlba40d300510c423da9877464f130c2f3.png','0','2016-09-29 16:38:03',25618),(173,'XiaomingTest','1475138283995','Screenshot from 2016-09-12 21:19:19.png','20160929/20160929163803/open_pic_urlc37205edd68045c89f5d73ac220673d0.png','open_pic_urlc37205edd68045c89f5d73ac220673d0.png','0','2016-09-29 16:38:03',25618),(174,'XiaomingTest','1475138284077','Screenshot from 2016-09-12 21:19:19.png','20160929/20160929163803/interstitial_pic_urlf9a31b85daef463fa2da453443c73f2d.png','interstitial_pic_urlf9a31b85daef463fa2da453443c73f2d.png','0','2016-09-29 16:38:04',25618),(175,'XiaomingTest','1475138284177','4314a770f18eaa2744c92a9a87f497f0.apk','20160929/20160929163803/app_urlcf504ebbfb07450f8333a742d599d018.apk','app_urlcf504ebbfb07450f8333a742d599d018.apk','0','2016-09-29 16:38:04',12299975),(176,'XiaomingTest','1475140607423','Screenshot from 2016-09-12 21:19:19.png','20160929/20160929171647/banner_pic_url5961712512d744f6993f0123bd852530.png','banner_pic_url5961712512d744f6993f0123bd852530.png','0','2016-09-29 17:16:47',25618),(177,'XiaomingTest','1475140607496','Screenshot from 2016-09-12 21:19:19.png','20160929/20160929171647/open_pic_urlb0fcee456cb74d238bc7fb79543ae2ed.png','open_pic_urlb0fcee456cb74d238bc7fb79543ae2ed.png','0','2016-09-29 17:16:47',25618),(178,'XiaomingTest','1475140607565','Screenshot from 2016-09-12 21:19:19.png','20160929/20160929171647/interstitial_pic_urla754d7534b034648888bc7439c2a24b3.png','interstitial_pic_urla754d7534b034648888bc7439c2a24b3.png','0','2016-09-29 17:16:47',25618),(179,'XiaomingTest','1475140607647','4314a770f18eaa2744c92a9a87f497f0.apk','20160929/20160929171647/app_urlc108764dc65d43949e9148efe927767c.apk','app_urlc108764dc65d43949e9148efe927767c.apk','0','2016-09-29 17:16:47',12299975),(180,'XiaomingTest','1475140607721','Screenshot from 2016-09-12 21:19:19.png','20160929/20160929171647/notification_bar_pic_url0b5f11f41c884ccc8f3e3a8df2206705.png','notification_bar_pic_url0b5f11f41c884ccc8f3e3a8df2206705.png','0','2016-09-29 17:16:47',25618),(181,'Test','1475141571333','lADOdrtWWMy0zQKA_640_180.jpg_620x10000q90g.jpg','20160929/20160929173251/banner_pic_url6387acc4efe14d56986a4fb0f24ad833.jpg','banner_pic_url6387acc4efe14d56986a4fb0f24ad833.jpg','0','2016-09-29 17:32:51',20539),(182,'Test','1475141571412','lADOdrtVcc0HgM0EOA_1080_1920.jpg_620x10000q90g.jpg','20160929/20160929173251/open_pic_urlebb6605479744c16912e43a1871e1c0f.jpg','open_pic_urlebb6605479744c16912e43a1871e1c0f.jpg','0','2016-09-29 17:32:51',144519),(183,'Test','1475141571485','lADOdru8mc0CWM0B4A_480_600.jpg_620x10000q90g.jpg','20160929/20160929173251/interstitial_pic_urlbbf591503a214efcac502dfe1f701045.jpg','interstitial_pic_urlbbf591503a214efcac502dfe1f701045.jpg','0','2016-09-29 17:32:51',104021),(184,'Test','1475141571568','4314a770f18eaa2744c92a9a87f497f0.apk','20160929/20160929173251/app_url2565b322ddce461dbb2fac7ad0857d61.apk','app_url2565b322ddce461dbb2fac7ad0857d61.apk','0','2016-09-29 17:32:51',12299975),(185,'Test2','1475142309671','lADOdrtWWMy0zQKA_640_180.jpg_620x10000q90g.jpg','20160929/20160929174509/banner_pic_urle8e379faf81e4507bd3f138a75c523bc.jpg','banner_pic_urle8e379faf81e4507bd3f138a75c523bc.jpg','0','2016-09-29 17:45:09',20539),(186,'Test2','1475142309747','lADOdrtVcc0HgM0EOA_1080_1920.jpg_620x10000q90g.jpg','20160929/20160929174509/open_pic_urld536a95696b846178c001b7b8f57a40d.jpg','open_pic_urld536a95696b846178c001b7b8f57a40d.jpg','0','2016-09-29 17:45:09',144519),(187,'Test2','1475142309816','lADOdru8mc0CWM0B4A_480_600.jpg_620x10000q90g.jpg','20160929/20160929174509/interstitial_pic_urle60026f50acd4e85ad4c3c747c7d0289.jpg','interstitial_pic_urle60026f50acd4e85ad4c3c747c7d0289.jpg','0','2016-09-29 17:45:09',104021),(188,'Test2','1475142309909','4314a770f18eaa2744c92a9a87f497f0.apk','20160929/20160929174509/app_urle75d0057466d4053bee651c2b80e3885.apk','app_urle75d0057466d4053bee651c2b80e3885.apk','0','2016-09-29 17:45:09',12299975),(189,'122','1475143310704','15091109384903313.png','20160929/20160929180150/banner_pic_url15091109384903313.png','banner_pic_url15091109384903313.png','0','2016-09-29 18:01:54',33966),(190,'122','1475143310778','t.apk','20160929/20160929180150/app_urlt.apk','app_urlt.apk','0','2016-09-29 18:01:54',223630),(191,'11','1475143698231','150911094131764187.png','20160929/20160929180818/banner_pic_url_150911094131764187.png','banner_pic_url_150911094131764187.png','0','2016-09-29 18:08:22',70226),(192,'11','1475143698302','t.apk','20160929/20160929180818/app_url_t.apk','app_url_t.apk','0','2016-09-29 18:08:22',223630),(193,'1','1475143985396','150911094131920192.png','20160929/20160929181305/banner_pic_url_150911094131920192.png','banner_pic_url_150911094131920192.png','0','2016-09-29 18:13:09',63294),(194,'1','1475143985475','t.apk','20160929/20160929181305/app_url_t.apk','app_url_t.apk','0','2016-09-29 18:13:09',223630),(195,'1','1475144265474','15091109384947018.png','20160929/20160929181554200/banner_pic_url_15091109384947018.png','banner_pic_url_15091109384947018.png','0','2016-09-29 18:17:51',42614),(196,'1','1475144267347','t.apk','20160929/20160929181554200/app_url_t.apk','app_url_t.apk','0','2016-09-29 18:17:51',223630),(197,'XiaomingTest1','1475215405635','lADOdrtWWMy0zQKA_640_180.jpg_620x10000q90g.jpg','20160930/20160930140325631/banner_pic_url_lADOdrtWWMy0zQKA_640_180.jpg_620x10000q90g.jpg','banner_pic_url_lADOdrtWWMy0zQKA_640_180.jpg_620x10000q90g.jpg','0','2016-09-30 14:03:24',20539),(198,'XiaomingTest1','1475215405708','lADOdrtVcc0HgM0EOA_1080_1920.jpg_620x10000q90g.jpg','20160930/20160930140325631/open_pic_url_lADOdrtVcc0HgM0EOA_1080_1920.jpg_620x10000q90g.jpg','open_pic_url_lADOdrtVcc0HgM0EOA_1080_1920.jpg_620x10000q90g.jpg','0','2016-09-30 14:03:24',144519),(199,'XiaomingTest1','1475215405781','lADOdru8mc0CWM0B4A_480_600.jpg_620x10000q90g.jpg','20160930/20160930140325631/interstitial_pic_url_lADOdru8mc0CWM0B4A_480_600.jpg_620x10000q90g.jpg','interstitial_pic_url_lADOdru8mc0CWM0B4A_480_600.jpg_620x10000q90g.jpg','0','2016-09-30 14:03:24',104021),(200,'XiaomingTest1','1475215405867','4314a770f18eaa2744c92a9a87f497f0.apk','20160930/20160930140325631/app_url_4314a770f18eaa2744c92a9a87f497f0.apk','app_url_4314a770f18eaa2744c92a9a87f497f0.apk','0','2016-09-30 14:03:24',12299975),(201,'XiaomingTest','1475217841539','lADOdrtWWMy0zQKA_640_180.jpg_620x10000q90g.jpg','20160930/20160930144401504/banner_pic_url_lADOdrtWWMy0zQKA_640_180.jpg_620x10000q90g.jpg','banner_pic_url_lADOdrtWWMy0zQKA_640_180.jpg_620x10000q90g.jpg','0','2016-09-30 14:44:07',20539),(202,'XiaomingTest','1475217841609','lADOdrtVcc0HgM0EOA_1080_1920.jpg_620x10000q90g.jpg','20160930/20160930144401504/open_pic_url_lADOdrtVcc0HgM0EOA_1080_1920.jpg_620x10000q90g.jpg','open_pic_url_lADOdrtVcc0HgM0EOA_1080_1920.jpg_620x10000q90g.jpg','0','2016-09-30 14:44:07',144519),(203,'XiaomingTest','1475217841679','lADOdru8mc0CWM0B4A_480_600.jpg_620x10000q90g.jpg','20160930/20160930144401504/interstitial_pic_url_lADOdru8mc0CWM0B4A_480_600.jpg_620x10000q90g.jpg','interstitial_pic_url_lADOdru8mc0CWM0B4A_480_600.jpg_620x10000q90g.jpg','0','2016-09-30 14:44:07',104021),(204,'XiaomingTest','1475217841748','4314a770f18eaa2744c92a9a87f497f0.apk','20160930/20160930144401504/app_url_4314a770f18eaa2744c92a9a87f497f0.apk','app_url_4314a770f18eaa2744c92a9a87f497f0.apk','0','2016-09-30 14:44:08',12299975),(205,'XIaomingTest2','1475217939438','lADOdrtWWMy0zQKA_640_180.jpg_620x10000q90g.jpg','20160930/20160930144539437/banner_pic_url_lADOdrtWWMy0zQKA_640_180.jpg_620x10000q90g.jpg','banner_pic_url_lADOdrtWWMy0zQKA_640_180.jpg_620x10000q90g.jpg','0','2016-09-30 14:45:45',20539),(206,'XIaomingTest2','1475217939508','lADOdrtVcc0HgM0EOA_1080_1920.jpg_620x10000q90g.jpg','20160930/20160930144539437/open_pic_url_lADOdrtVcc0HgM0EOA_1080_1920.jpg_620x10000q90g.jpg','open_pic_url_lADOdrtVcc0HgM0EOA_1080_1920.jpg_620x10000q90g.jpg','0','2016-09-30 14:45:45',144519),(207,'XIaomingTest2','1475217939577','4314a770f18eaa2744c92a9a87f497f0.apk','20160930/20160930144539437/app_url_4314a770f18eaa2744c92a9a87f497f0.apk','app_url_4314a770f18eaa2744c92a9a87f497f0.apk','0','2016-09-30 14:45:45',12299975),(208,'XiaomingTest123','1475218020348','lADOdrtWWMy0zQKA_640_180.jpg_620x10000q90g.jpg','20160930/20160930144700348/banner_pic_url_lADOdrtWWMy0zQKA_640_180.jpg_620x10000q90g.jpg','banner_pic_url_lADOdrtWWMy0zQKA_640_180.jpg_620x10000q90g.jpg','0','2016-09-30 14:47:06',20539),(209,'XiaomingTest123','1475218020425','4314a770f18eaa2744c92a9a87f497f0.apk','20160930/20160930144700348/app_url_4314a770f18eaa2744c92a9a87f497f0.apk','app_url_4314a770f18eaa2744c92a9a87f497f0.apk','0','2016-09-30 14:47:06',12299975),(210,'XiaomingTest','1475219214143','lADOdrtWWMy0zQKA_640_180.jpg_620x10000q90g.jpg','20160930/20160930150654139/banner_pic_url_lADOdrtWWMy0zQKA_640_180.jpg_620x10000q90g.jpg','banner_pic_url_lADOdrtWWMy0zQKA_640_180.jpg_620x10000q90g.jpg','0','2016-09-30 15:06:52',20539),(211,'XiaomingTest','1475219214214','lADOdrtVcc0HgM0EOA_1080_1920.jpg_620x10000q90g.jpg','20160930/20160930150654139/open_pic_url_lADOdrtVcc0HgM0EOA_1080_1920.jpg_620x10000q90g.jpg','open_pic_url_lADOdrtVcc0HgM0EOA_1080_1920.jpg_620x10000q90g.jpg','0','2016-09-30 15:06:52',144519),(212,'XiaomingTest','1475219214284','lADOdru8mc0CWM0B4A_480_600.jpg_620x10000q90g.jpg','20160930/20160930150654139/interstitial_pic_url_lADOdru8mc0CWM0B4A_480_600.jpg_620x10000q90g.jpg','interstitial_pic_url_lADOdru8mc0CWM0B4A_480_600.jpg_620x10000q90g.jpg','0','2016-09-30 15:06:52',104021),(213,'XiaomingTest','1475219214367','4314a770f18eaa2744c92a9a87f497f0.apk','20160930/20160930150654139/app_url_4314a770f18eaa2744c92a9a87f497f0.apk','app_url_4314a770f18eaa2744c92a9a87f497f0.apk','0','2016-09-30 15:06:52',12299975),(214,'XiaomingTest','1475221053169','lADOdrtWWMy0zQKA_640_180.jpg_620x10000q90g.jpg','20160930/20160930153733167/banner_pic_url_lADOdrtWWMy0zQKA_640_180.jpg_620x10000q90g.jpg','banner_pic_url_lADOdrtWWMy0zQKA_640_180.jpg_620x10000q90g.jpg','0','2016-09-30 15:37:31',20539),(215,'XiaomingTest','1475221053264','4314a770f18eaa2744c92a9a87f497f0.apk','20160930/20160930153733167/app_url_4314a770f18eaa2744c92a9a87f497f0.apk','app_url_4314a770f18eaa2744c92a9a87f497f0.apk','0','2016-09-30 15:37:31',12299975),(216,'XiaomingTest','1475221098047','lADOdrtWWMy0zQKA_640_180.jpg_620x10000q90g.jpg','20160930/20160930153818046/banner_pic_url_lADOdrtWWMy0zQKA_640_180.jpg_620x10000q90g.jpg','banner_pic_url_lADOdrtWWMy0zQKA_640_180.jpg_620x10000q90g.jpg','0','2016-09-30 15:38:16',20539),(217,'XiaomingTest','1475221098129','4314a770f18eaa2744c92a9a87f497f0.apk','20160930/20160930153818046/app_url_4314a770f18eaa2744c92a9a87f497f0.apk','app_url_4314a770f18eaa2744c92a9a87f497f0.apk','0','2016-09-30 15:38:16',12299975),(218,'1','1475221145954','lADOdrtWWMy0zQKA_640_180.jpg_620x10000q90g.jpg','20160930/20160930153905953/banner_pic_url_lADOdrtWWMy0zQKA_640_180.jpg_620x10000q90g.jpg','banner_pic_url_lADOdrtWWMy0zQKA_640_180.jpg_620x10000q90g.jpg','0','2016-09-30 15:39:04',20539),(219,'1','1475221146038','4314a770f18eaa2744c92a9a87f497f0.apk','20160930/20160930153905953/app_url_4314a770f18eaa2744c92a9a87f497f0.apk','app_url_4314a770f18eaa2744c92a9a87f497f0.apk','0','2016-09-30 15:39:04',12299975),(220,'1','1475221288719','lADOdrtWWMy0zQKA_640_180.jpg_620x10000q90g.jpg','20160930/20160930154128719/banner_pic_url_lADOdrtWWMy0zQKA_640_180.jpg_620x10000q90g.jpg','banner_pic_url_lADOdrtWWMy0zQKA_640_180.jpg_620x10000q90g.jpg','0','2016-09-30 15:41:27',20539),(221,'1','1475221288835','4314a770f18eaa2744c92a9a87f497f0.apk','20160930/20160930154128719/app_url_4314a770f18eaa2744c92a9a87f497f0.apk','app_url_4314a770f18eaa2744c92a9a87f497f0.apk','0','2016-09-30 15:41:27',12299975),(222,'1','1475221346218','lADOdrtWWMy0zQKA_640_180.jpg_620x10000q90g.jpg','20160930/20160930154226218/banner_pic_url_lADOdrtWWMy0zQKA_640_180.jpg_620x10000q90g.jpg','banner_pic_url_lADOdrtWWMy0zQKA_640_180.jpg_620x10000q90g.jpg','0','2016-09-30 15:42:24',20539),(223,'1','1475221346306','4314a770f18eaa2744c92a9a87f497f0.apk','20160930/20160930154226218/app_url_4314a770f18eaa2744c92a9a87f497f0.apk','app_url_4314a770f18eaa2744c92a9a87f497f0.apk','0','2016-09-30 15:42:24',12299975),(224,'1','1475221398010','lADOdrtWWMy0zQKA_640_180.jpg_620x10000q90g.jpg','20160930/20160930154318010/banner_pic_url_lADOdrtWWMy0zQKA_640_180.jpg_620x10000q90g.jpg','banner_pic_url_lADOdrtWWMy0zQKA_640_180.jpg_620x10000q90g.jpg','0','2016-09-30 15:43:16',20539),(225,'1','1475221398091','4314a770f18eaa2744c92a9a87f497f0.apk','20160930/20160930154318010/app_url_4314a770f18eaa2744c92a9a87f497f0.apk','app_url_4314a770f18eaa2744c92a9a87f497f0.apk','0','2016-09-30 15:43:16',12299975),(226,'1','1475221493660','lADOdrtWWMy0zQKA_640_180.jpg_620x10000q90g.jpg','20160930/20160930154453659/banner_pic_url_lADOdrtWWMy0zQKA_640_180.jpg_620x10000q90g.jpg','banner_pic_url_lADOdrtWWMy0zQKA_640_180.jpg_620x10000q90g.jpg','0','2016-09-30 15:44:52',20539),(227,'1','1475221493755','4314a770f18eaa2744c92a9a87f497f0.apk','20160930/20160930154453659/app_url_4314a770f18eaa2744c92a9a87f497f0.apk','app_url_4314a770f18eaa2744c92a9a87f497f0.apk','0','2016-09-30 15:44:52',12299975),(228,'11','1475221567018','lADOdrtWWMy0zQKA_640_180.jpg_620x10000q90g.jpg','20160930/20160930154607018/banner_pic_url_lADOdrtWWMy0zQKA_640_180.jpg_620x10000q90g.jpg','banner_pic_url_lADOdrtWWMy0zQKA_640_180.jpg_620x10000q90g.jpg','0','2016-09-30 15:46:05',20539),(229,'11','1475221567096','4314a770f18eaa2744c92a9a87f497f0.apk','20160930/20160930154607018/app_url_4314a770f18eaa2744c92a9a87f497f0.apk','app_url_4314a770f18eaa2744c92a9a87f497f0.apk','0','2016-09-30 15:46:05',12299975),(230,'121','1475221658293','lADOdrtWWMy0zQKA_640_180.jpg_620x10000q90g.jpg','20160930/20160930154738292/banner_pic_url_lADOdrtWWMy0zQKA_640_180.jpg_620x10000q90g.jpg','banner_pic_url_lADOdrtWWMy0zQKA_640_180.jpg_620x10000q90g.jpg','0','2016-09-30 15:47:36',20539),(231,'121','1475221658373','4314a770f18eaa2744c92a9a87f497f0.apk','20160930/20160930154738292/app_url_4314a770f18eaa2744c92a9a87f497f0.apk','app_url_4314a770f18eaa2744c92a9a87f497f0.apk','0','2016-09-30 15:47:36',12299975),(232,'eee','1475221778508','480x800.jpg','20160930/20160930154938508/banner_pic_url_480x800.jpg','banner_pic_url_480x800.jpg','0','2016-09-30 15:49:36',105346),(233,'eee','1475221778578','Meizi_final.apk','20160930/20160930154938508/app_url_Meizi_final.apk','app_url_Meizi_final.apk','0','2016-09-30 15:49:37',1302730),(234,'ds','1475221865389','lADOdrtWWMy0zQKA_640_180.jpg_620x10000q90g.jpg','20160930/20160930155105388/banner_pic_url_lADOdrtWWMy0zQKA_640_180.jpg_620x10000q90g.jpg','banner_pic_url_lADOdrtWWMy0zQKA_640_180.jpg_620x10000q90g.jpg','0','2016-09-30 15:51:03',20539),(235,'ds','1475221865476','4314a770f18eaa2744c92a9a87f497f0.apk','20160930/20160930155105388/app_url_4314a770f18eaa2744c92a9a87f497f0.apk','app_url_4314a770f18eaa2744c92a9a87f497f0.apk','0','2016-09-30 15:51:03',12299975),(236,'测试勿删','1475222122597','150911094132373198.png','20160930/20160930155522582/banner_pic_url_150911094132373198.png','banner_pic_url_150911094132373198.png','0','2016-09-30 15:55:28',68495),(237,'测试勿删','1475222122704','150911094132233194.png','20160930/20160930155522582/float_pic_url_150911094132233194.png','float_pic_url_150911094132233194.png','0','2016-09-30 15:55:29',75060),(238,'测试勿删','1475222122772','15091109384937717.png','20160930/20160930155522582/open_pic_url_15091109384937717.png','open_pic_url_15091109384937717.png','0','2016-09-30 15:55:29',66497),(239,'测试勿删','1475222122842','150911094132295196.png','20160930/20160930155522582/interstitial_pic_url_150911094132295196.png','interstitial_pic_url_150911094132295196.png','0','2016-09-30 15:55:29',77153),(240,'测试勿删','1475222122913','150911094132186193.png','20160930/20160930155522582/lock_pic_url_150911094132186193.png','lock_pic_url_150911094132186193.png','0','2016-09-30 15:55:29',63503),(241,'测试勿删','1475222122986','9140056_signed.apk','20160930/20160930155522582/app_url_9140056_signed.apk','app_url_9140056_signed.apk','0','2016-09-30 15:55:29',2241522),(242,'测试勿删','1475222123169','150911094131920192.png','20160930/20160930155522582/notification_bar_pic_url_150911094131920192.png','notification_bar_pic_url_150911094131920192.png','0','2016-09-30 15:55:29',63294);

/* Function  structure for function  `F_GETDICT_LABEL` */

/*!50003 DROP FUNCTION IF EXISTS `F_GETDICT_LABEL` */;
DELIMITER $$

/*!50003 CREATE DEFINER=`advert`@`%` FUNCTION `F_GETDICT_LABEL`( DICVAL VARCHAR(100), DICTYPE VARCHAR(100)) RETURNS varchar(100) CHARSET utf8
    READS SQL DATA
    SQL SECURITY INVOKER
BEGIN
 DECLARE result VARCHAR(100); 
SELECT label INTO result FROM t_sys_dict WHERE c_TYPE=DICTYPE AND VAL = DICVAL AND del_flag ='0';
 IF result IS NULL THEN
 SET result =' ';
 END IF;
 RETURN result;
/**function body**/
END */$$
DELIMITER ;

/* Function  structure for function  `F_GET_FILEPATH` */

/*!50003 DROP FUNCTION IF EXISTS `F_GET_FILEPATH` */;
DELIMITER $$

/*!50003 CREATE DEFINER=`advert`@`%` FUNCTION `F_GET_FILEPATH`( DOMAIN VARCHAR(100), FILE_ID VARCHAR(100)) RETURNS varchar(255) CHARSET utf8
BEGIN
DECLARE FILE_PATH VARCHAR(255);
IF FILE_ID LIKE "http://%"
THEN SELECT FILE_ID INTO FILE_PATH;
RETURN FILE_PATH;
ELSE
SELECT CONCAT(DOMAIN,'/',f.storepath)INTO FILE_PATH  FROM t_upload_file f WHERE f.fileid=FILE_ID;
END IF ;
RETURN FILE_PATH;
END */$$
DELIMITER ;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
