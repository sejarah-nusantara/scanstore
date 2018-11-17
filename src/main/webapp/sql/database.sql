SET NAMES utf8;
SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS `scanstore_roles`;
CREATE TABLE `scanstore_roles` (
  `roleid` int(11) NOT NULL auto_increment,
  `role_name` varchar(255) NOT NULL,
  `role_description` varchar(255) default NULL,
  PRIMARY KEY  (`roleid`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

INSERT INTO `scanstore_roles` VALUES ('1', 'SYS_ADMIN', 'System administrator'), ('2', 'SYS_USER', 'System user');

DROP TABLE IF EXISTS `scanstore_user_roles`;
CREATE TABLE `scanstore_user_roles` (
  `user_roles_id` int(11) NOT NULL auto_increment,
  `user_id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  PRIMARY KEY  (`user_roles_id`),
  UNIQUE KEY `unique role_user` USING BTREE (`user_id`,`role_id`),
  KEY `user_id` (`user_id`),
  KEY `role_id` (`role_id`)
) ENGINE=MyISAM AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;

INSERT INTO `scanstore_user_roles` VALUES ('1', '1', '1');

DROP TABLE IF EXISTS `scanstore_users`;
CREATE TABLE `scanstore_users` (
  `user_id` int(11) NOT NULL auto_increment,
  `user_name` varchar(255) NOT NULL,
  `user_password` varchar(255) NOT NULL,
  `user_firstname` varchar(255) NOT NULL,
  `user_lastname` varchar(255) NOT NULL,
  `user_email` varchar(255) NOT NULL,
  `user_institution` varchar(255) NOT NULL,
  `user_deleted` bit(1) NOT NULL default '\0',
  PRIMARY KEY  (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

INSERT INTO `scanstore_users` VALUES ('1', 'admin', '%NEWPASSWORD%', 'Scanstore', 'Administrator', 'info@cortsfoundation.org', 'ID-ANRI', b'0');

SET FOREIGN_KEY_CHECKS = 1;