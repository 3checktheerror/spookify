DROP DATABASE IF EXISTS spookify;
CREATE DATABASE spookify;
USE spookify;



-- ----------------------------
-- Table structure for product
-- ----------------------------
DROP TABLE IF EXISTS B2B_product_1;
CREATE TABLE B2B_product_1 (
                               `p_id` varchar(32) NOT NULL,
                               `pgroup_id` varchar(128) NOT NULL,
                               `p_name` varchar(32) NOT NULL,
                               `price` DECIMAL(10, 2)NOT NULL,
                               `quantity_in_stock` INT NOT NULL,
                               `md5` varchar(32),
                               `status` varchar(16),
                               `cs_create` timestamp NOT NULL DEFAULT '2023-01-01 00:00:00.000',
                               `cs_modified` timestamp NOT NULL DEFAULT '2023-01-01 00:00:00.000',
                               `op_type` char(10) DEFAULT NULL,
                               `data` JSON,
                               `token` varchar(128),
                               `session_id` varchar(128),
                               PRIMARY KEY (p_id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
CREATE INDEX B2B_product_1_pid_idx ON B2B_product_1(p_id);


-- ----------------------------
-- Table structure for order
-- ----------------------------
DROP TABLE IF EXISTS B2B_order_1;
CREATE TABLE B2B_order_1 (
                             `o_id` varchar(32) NOT NULL,
                             `ogroup_id` varchar(128) NOT NULL,
                             `total_amount`DECIMAL(10, 2) NOT NULL,
                             `pay_name`varchar(32),
                             `card_number`varchar(64),
                             `address` varchar(256),
                             `status` varchar(16),
                             `md5` varchar(32),
                             `od_create` timestamp NOT NULL DEFAULT '2023-01-01 00:00:00.000',
                             `od_modified` timestamp NOT NULL DEFAULT '2023-01-01 00:00:00.000',
                             `op_type` char(10) DEFAULT NULL,
                             `data` JSON,
                             `token` varchar(128),
                             `session_id` varchar(128),
                             PRIMARY KEY (o_id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
CREATE INDEX B2B_order_1_oid_idx ON B2B_order_1(o_id);


-- ----------------------------
-- Table structure for item (concrete info for an order)
-- ----------------------------
DROP TABLE IF EXISTS B2B_item_1;
CREATE TABLE B2B_item_1 (
                            `i_id` varchar(32) NOT NULL,
                            `igroup_id` varchar(128) NOT NULL,
                            `i_name` varchar(32) NOT NULL,
                            `unit_price`DECIMAL(10, 2)NOT NULL,
                            `quantity` INT NOT NULL,
                            `item_total_amount`DECIMAL(10, 2) NOT NULL,
                            `md5` varchar(32),
                            `it_create` timestamp NOT NULL DEFAULT '2023-01-01 00:00:00.000',
                            `it_modified` timestamp NOT NULL DEFAULT '2023-01-01 00:00:00.000',
                            `op_type` char(10) DEFAULT NULL,
                            `data` JSON,
                            `token` varchar(128),
                            `session_id` varchar(128),
                            `o_id_fk` varchar(32),
                            PRIMARY KEY (i_id),
                            FOREIGN KEY (o_id_fk) REFERENCES B2B_order_1(o_id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
CREATE INDEX B2B_item_1_iid_idx ON B2B_item_1(i_id);


