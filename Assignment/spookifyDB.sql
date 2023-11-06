CREATE DATABASE spookify;
USE spookify;

-- ----------------------------
-- Table structure for MyBatis test
-- ----------------------------
DROP TABLE IF EXISTS t_test;
CREATE TABLE `t_test`
(
    `number`     INT NOT NULL AUTO_INCREMENT COMMENT 'number',
    `user_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT 'userName',
    `user_age`       INT NOT NULL COMMENT 'age',
    PRIMARY KEY (`number`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = 'testTable' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for MyBatis_Plus test
-- ----------------------------
DROP TABLE IF EXISTS t_testPlus;
CREATE TABLE `t_testPlus`
(
    `number`     INT NOT NULL AUTO_INCREMENT COMMENT 'number',
    `user_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT 'userName',
    PRIMARY KEY (`number`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = 'testTable' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for customer
-- ----------------------------
DROP TABLE IF EXISTS contact_customer_1;
CREATE TABLE contact_customer_1 (
                                    `c_id` bigint NOT NULL,
                                    `cgroup_id` varchar(128) NOT NULL,
                                    `name` varchar(32) NOT NULL,
                                    `age` INT NOT NULL,
                                    `gender` varchar(16),
                                    `file` BLOB,
                                    `md5` varchar(32),
                                    `cs_create` timestamp NOT NULL DEFAULT '2023-01-01 00:00:00.000',
                                    `cs_modified` timestamp NOT NULL DEFAULT '2023-01-01 00:00:00.000',
                                    `op_type` char(10) DEFAULT NULL,
                                    `data` JSON,
                                    `token` varchar(128),
                                    `session_id` varchar(128),
                                    PRIMARY KEY (c_id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;;

CREATE INDEX contact_customer_1_cid_idx ON contact_customer_1(c_id);

-- ----------------------------
-- Table structure for item
-- ----------------------------
DROP TABLE IF EXISTS contact_item_1;
CREATE TABLE contact_item_1 (
                                `i_id` bigint NOT NULL,
                                `igroup_id` varchar(128) NOT NULL,
                                `name` varchar(32) NOT NULL,
                                `gender` varchar(16),
                                `email` varchar(128),
                                `file` BLOB,
                                `md5` varchar(32),
                                `cs_create` timestamp NOT NULL DEFAULT '2023-01-01 00:00:00.000',
                                `cs_modified` timestamp NOT NULL DEFAULT '2023-01-01 00:00:00.000',
                                `op_type` char(10) DEFAULT NULL,
                                `data` JSON,
                                `token` varchar(128),
                                `session_id` varchar(128),
                                `status` varchar(16),
                                PRIMARY KEY (i_id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE INDEX contact_item_1_iid_idx ON contact_item_1(i_id);

-- ----------------------------
-- Table structure for visitor
-- ----------------------------
DROP TABLE IF EXISTS contact_visitor_1;
CREATE TABLE contact_visitor_1 (
                                   `v_id` bigint NOT NULL,
                                   `vgroup_id` varchar(128) NOT NULL,
                                   `name` varchar(32) NOT NULL,
                                   `username` varchar(32) NOT NULL,
                                   `password` varchar(32) NOT NULL,
                                   `age` INT NOT NULL,
                                   `gender` varchar(16),
                                   `file` BLOB,
                                   `md5` varchar(32),
                                   `cs_create` timestamp NOT NULL DEFAULT '2023-01-01 00:00:00.000',
                                   `cs_modified` timestamp NOT NULL DEFAULT '2023-01-01 00:00:00.000',
                                   `op_type` char(10) DEFAULT NULL,
                                   `data` JSON,
                                   `token` varchar(128),
                                   `session_id` varchar(128),
                                   `i_id` bigint NOT NULL,
                                   PRIMARY KEY (v_id),
                                   FOREIGN KEY (i_id) REFERENCES contact_item_1(i_id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;;

CREATE INDEX contact_visitor_1_vid_idx ON contact_visitor_1(v_id);


