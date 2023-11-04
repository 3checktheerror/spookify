CREATE DATABASE spookify;
USE spookify;

DROP TABLE IF EXISTS t_test;
CREATE TABLE `t_test`
(
    `number`     INT NOT NULL AUTO_INCREMENT COMMENT 'number',
    `user_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT 'userName',
    `user_age`       INT NOT NULL COMMENT 'age',
    PRIMARY KEY (`number`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = 'testTable' ROW_FORMAT = Dynamic;