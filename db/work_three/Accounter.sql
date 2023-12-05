drop database if exists account;
create database if not exists account default character set UTF8MB4;
use account;
SET FOREIGN_KEY_CHECKS = 0;
-- ----------------------------
-- Table structure for t_auth
-- ----------------------------
DROP TABLE IF EXISTS `t_auth`;
CREATE TABLE `t_auth`
(
    `auth_id`   int(10) unsigned NOT NULL,
    `auth_name` varchar(16)      NOT NULL DEFAULT 'user'
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8
  ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for t_budget
-- ----------------------------
DROP TABLE IF EXISTS `t_budget`;
CREATE TABLE `t_budget`
(
    `budget_id`          int(11)        NOT NULL AUTO_INCREMENT,
    `budget_name`        varchar(36)    NOT NULL DEFAULT '一个小目标～',
    `money`              decimal(12, 2) NOT NULL DEFAULT '0.00',
    `begin_date`         datetime                DEFAULT NULL,
    `budget_cycle`       int(11)        NOT NULL DEFAULT '0' COMMENT '预算周期，表示周期的天数',
    `budget_description` varchar(255)            DEFAULT NULL,
    PRIMARY KEY (`budget_id`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 4
  DEFAULT CHARSET = utf8;

-- ----------------------------
-- Table structure for t_consumption
-- ----------------------------
DROP TABLE IF EXISTS `t_consumption`;
CREATE TABLE `t_consumption`
(
    `consumption_id`   bigint(20)     NOT NULL AUTO_INCREMENT,
    `amount`           decimal(14, 2) NOT NULL,
    `consumption_name` varchar(256)   NOT NULL DEFAULT '一条消费记录',
    `description`      varchar(256)   NOT NULL DEFAULT '暂无描述',
    `type_id`          int(10)        NOT NULL DEFAULT '9',
    `store`            varchar(256)   NOT NULL DEFAULT '暂无',
    `consume_time`     datetime       NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `credential`       varchar(100)   NOT NULL,
    PRIMARY KEY (`consumption_id`) USING BTREE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;

-- ----------------------------
-- Table structure for t_goal
-- ----------------------------
DROP TABLE IF EXISTS `t_goal`;
CREATE TABLE `t_goal`
(
    `goal_id`     int(11)        NOT NULL AUTO_INCREMENT,
    `goal_name`   varchar(36)    NOT NULL DEFAULT '一个小目标～',
    `money`       decimal(12, 2) NOT NULL DEFAULT '0.00',
    `create_date` datetime                DEFAULT NULL,
    `deadline`    datetime                DEFAULT NULL,
    `user_id`     bigint(20)     NOT NULL,
    PRIMARY KEY (`goal_id`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 4
  DEFAULT CHARSET = utf8;

-- ----------------------------
-- Table structure for t_guardianship
-- ----------------------------
DROP TABLE IF EXISTS `t_guardianship`;
CREATE TABLE `t_guardianship`
(
    `guardianship_id` int(10) unsigned    NOT NULL AUTO_INCREMENT,
    `guardian_id`     bigint(20) unsigned NOT NULL,
    `ward_id`         bigint(20) unsigned NOT NULL,
    `relationship`    varchar(20)         NOT NULL DEFAULT '监护人',
    `bind_date`       datetime            NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`guardianship_id`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 3
  DEFAULT CHARSET = utf8;

-- ----------------------------
-- Table structure for t_ledger
-- ----------------------------
DROP TABLE IF EXISTS `t_ledger`;
CREATE TABLE `t_ledger`
(
    `ledger_id`   int(11)             NOT NULL AUTO_INCREMENT,
    `create_time` datetime                     DEFAULT NULL,
    `update_time` datetime                     DEFAULT NULL,
    `cover`       varchar(100)        NOT NULL DEFAULT 'default',
    `user_id`     bigint(20) unsigned NOT NULL,
    `ledger_name` varchar(36)         NOT NULL DEFAULT '一本账本',
    PRIMARY KEY (`ledger_id`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 9
  DEFAULT CHARSET = utf8;

-- ----------------------------
-- Table structure for t_ledger_consumption
-- ----------------------------
DROP TABLE IF EXISTS `t_ledger_consumption`;
CREATE TABLE `t_ledger_consumption`
(
    `ledger_id`      int(11)             NOT NULL,
    `consumption_id` bigint(20) unsigned NOT NULL
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;

-- ----------------------------
-- Table structure for t_multi_ledger
-- ----------------------------
DROP TABLE IF EXISTS `t_multi_ledger`;
CREATE TABLE `t_multi_ledger`
(
    `multi_ledger_id`   int(10) unsigned NOT NULL AUTO_INCREMENT,
    `multi_ledger_name` varchar(50)      NOT NULL DEFAULT '一本多人账本～',
    `description`       varchar(256)     NOT NULL DEFAULT '暂无介绍～',
    `password`          varchar(16)      NOT NULL,
    `modify_time`       datetime         NOT NULL ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`multi_ledger_id`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 6
  DEFAULT CHARSET = utf8;

-- ----------------------------
-- Table structure for t_multi_ledger_consumption
-- ----------------------------
DROP TABLE IF EXISTS `t_multi_ledger_consumption`;
CREATE TABLE `t_multi_ledger_consumption`
(
    `multi_ledger_id` int(10) unsigned    NOT NULL,
    `consumption_id`  bigint(20) unsigned NOT NULL,
    `user_id`         bigint(20)          NOT NULL
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;

-- ----------------------------
-- Table structure for t_multi_ledger_user
-- ----------------------------
DROP TABLE IF EXISTS `t_multi_ledger_user`;
CREATE TABLE `t_multi_ledger_user`
(
    `multi_ledger_id` int(10) unsigned    NOT NULL,
    `user_id`         bigint(20) unsigned NOT NULL
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;

-- ----------------------------
-- Table structure for t_type
-- ----------------------------
DROP TABLE IF EXISTS `t_type`;
CREATE TABLE `t_type`
(
    `type_id`   int(10) unsigned NOT NULL AUTO_INCREMENT,
    `type_name` varchar(16)      NOT NULL DEFAULT '暂无',
    PRIMARY KEY (`type_id`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 17
  DEFAULT CHARSET = utf8
  ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for t_user
-- ----------------------------
DROP TABLE IF EXISTS `t_user`;
CREATE TABLE `t_user`
(
    `user_id`  bigint(20) unsigned NOT NULL auto_increment,
    `username` varchar(30)         NOT NULL,
    `password` varchar(30)         NOT NULL,
    `mobile`   varchar(30) DEFAULT NULL,
    `nickname` varchar(30) DEFAULT NULL,
    PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;

-- ----------------------------
-- Table structure for t_user_auth
-- ----------------------------
DROP TABLE IF EXISTS `t_user_auth`;
CREATE TABLE `t_user_auth`
(
    `user_id` bigint(20) unsigned NOT NULL,
    `auth_id` int(10) unsigned    NOT NULL
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8
  ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for t_user_budget
-- ----------------------------
DROP TABLE IF EXISTS `t_user_budget`;
CREATE TABLE `t_user_budget`
(
    `budget_id` int(11)             NOT NULL,
    `user_id`   bigint(20) unsigned NOT NULL
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;

-- ----------------------------
-- Table structure for t_user_consumption
-- ----------------------------
DROP TABLE IF EXISTS `t_user_consumption`;
CREATE TABLE `t_user_consumption`
(
    `consumption_id` bigint(20) unsigned NOT NULL,
    `user_id`        bigint(20) unsigned NOT NULL
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;


# update ledger updatetime
create trigger ledger_update_time
    before update
    on t_ledger
    for each row set new.update_time = now();

-- ----------------------------
-- Procedure structure for addTestData
-- ----------------------------
DROP PROCEDURE IF EXISTS `addTestData`;
delimiter ;;
CREATE PROCEDURE `addTestData`()
begin
    declare number int;
    set number = 1;
    while number <= 2000 #插入N条数据
        do
            insert into t_consumption(consumption_id, consumption_name, description, amount, type_id, store,
                                      consume_time)
            values (number, CONCAT('testname', number), '暂无', amount, 1, 'test store',
                    CURRENT_TIMESTAMP); # 为了区分姓名，我们加上后缀
            set number = number + 1;
        end while;
end
;;
delimiter ;

-- ----------------------------
-- Procedure structure for pre
-- ----------------------------
DROP PROCEDURE IF EXISTS `pre`;
delimiter ;;
CREATE PROCEDURE `pre`()
begin
    declare i int; #定义i变量
    set i = 10535;
    while i < 12670
        do
            #对i的值配置
            insert into t_user_consumption (user_id, consumption_id)
            values (1, i);
            set i = i + 1; #自增循环
        end while;
end
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
