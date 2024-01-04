DROP DATABASE IF EXISTS spookify;
CREATE DATABASE spookify;
USE spookify;



-- ----------------------------
-- Table structure for product
-- ----------------------------

DROP TABLE IF EXISTS B2B_customer_1;
CREATE TABLE B2B_customer_1 (
                                    `c_id` varchar(32) NOT NULL,
                                    `cgroup_id` varchar(128),
                                    `name` varchar(32),
                                    `password` varchar(32),
                                    `age` INT,
                                    `gender` varchar(16),
                                    `md5` varchar(32),
                                    `cs_create` timestamp NOT NULL DEFAULT '2023-01-01 00:00:00.000',
                                    `cs_modified` timestamp NOT NULL DEFAULT '2023-01-01 00:00:00.000',
                                    `op_type` char(10) DEFAULT NULL,
                                    `data` JSON,
                                    `token` varchar(128),
                                    `session_id` varchar(128),
                                    PRIMARY KEY (c_id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
CREATE INDEX B2B_customer_1_cid_idx ON B2B_customer_1(c_id);

DROP TABLE IF EXISTS B2B_product_1;
CREATE TABLE B2B_product_1 (
                               `p_id` varchar(32) NOT NULL,
                               `pgroup_id` varchar(128),
                               `p_name` varchar(32) NOT NULL,
                               `price` DECIMAL(10, 2)NOT NULL,
                               `quantity_in_stock` INT NOT NULL,
                               `category` varchar(32) NOT NULL,
                               `manufacturer`varchar(32) NOT NULL,
                               `description` varchar(512) NOT NULL,
                               `md5` varchar(32),
                               `status` varchar(16),
                               `pd_create` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
                               `pd_modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
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
                             `ogroup_id` varchar(128),
                             `customer_id` varchar(32) NOT NULL,
                             `balance` DECIMAL(10, 2)NOT NULL,
                             `pay_name`varchar(32),
                             `card_number`varchar(64),
                             `address` varchar(256),
                             `shipping_method` varchar(128),
                             `product_price` DECIMAL(10, 2),
                             `tax` DECIMAL(10, 2),
                             `shipping_fee` DECIMAL(10, 2),
                             `total_amount`DECIMAL(10, 2),
                             `discount_amount`DECIMAL(10, 2),
                             `actual_amount`DECIMAL(10, 2),
                             `payment_status` varchar(16),
                             `md5` varchar(32),
                             `od_create` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
                             `od_modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
                             `op_type` char(10) DEFAULT NULL,
                             `data` JSON,
                             `token` varchar(128),
                             `session_id` varchar(128),
                             PRIMARY KEY (o_id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
CREATE INDEX B2B_order_1_oid_idx ON B2B_order_1(o_id);


-- ----------------------------
-- Table structure for detail (concrete info for an order)
-- ----------------------------
DROP TABLE IF EXISTS B2B_detail_1;
CREATE TABLE B2B_detail_1 (
                              `d_id` varchar(32) NOT NULL,
                              `dgroup_id` varchar(128),
                              `name` varchar(32) NOT NULL,
                              `unit_price`DECIMAL(10, 2)NOT NULL,
                              `quantity` INT NOT NULL,
                              `subtotal`DECIMAL(10, 2) NOT NULL,
                              `md5` varchar(32),
                              `dt_create` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
                              `dt_modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
                              `op_type` char(10) DEFAULT NULL,
                              `data` JSON,
                              `token` varchar(128),
                              `session_id` varchar(128),
                              `o_id_fk` varchar(32),
                              PRIMARY KEY (d_id),
                              FOREIGN KEY (o_id_fk) REFERENCES B2B_order_1(o_id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
CREATE INDEX B2B_detail_1_did_idx ON B2B_detail_1(d_id);


INSERT INTO B2B_product_1 (p_id, pgroup_id, p_name, price, quantity_in_stock, category, Manufacturer, description, md5, status, pd_create, pd_modified, op_type, data, token, session_id)
VALUES
    ('SPPD000001', 'PDG1', 'Running Shoes', 49.99, 100, 'Footwear', 'Nike', 'High-performance running shoes', '', 'In stock', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'Insert', '{
      "p_id": "SPPD000001",
      "pgroup_id": "PDG1",
      "p_name": "Running Shoes",
      "price": 49.99,
      "quantity_in_stock": 100,
      "category": "Footwear",
      "Manufacturer": "Nike",
      "description": "High-performance running shoes",
      "md5": "",
      "status": "In stock",
      "pd_create": "2024-01-01 00:00:00.000",
      "pd_modified": "2024-01-01 00:00:00.000",
      "op_type": "Insert",
      "token": "",
      "session_id": ""
    }', '', ''),
    ('SPPD000002', 'PDG1', 'Casual T-Shirt', 19.99, 150, 'Apparel', 'Nike', 'Comfortable and stylish T-shirt', '', 'In stock', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'Insert', '{
      "p_id": "SPPD000002",
      "pgroup_id": "PDG2",
      "p_name": "Casual T-Shirt",
      "price": 19.99,
      "quantity_in_stock": 150,
      "category": "Apparel",
      "Manufacturer": "Nike",
      "description": "Comfortable and stylish T-shirt",
      "md5": "",
      "status": "In stock",
      "pd_create": "2024-01-01 00:00:00.000",
      "pd_modified": "2024-01-01 00:00:00.000",
      "op_type": "Insert",
      "token": "",
      "session_id": ""
    }
    ', '', ''),
    ('SPPD000003', 'PDG1', 'Sports Bag', 29.99, 50, 'Accessories', 'Nike', 'Spacious sports bag for your gear', '', 'In stock', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'Insert', '{
      "p_id": "SPPD000003",
      "pgroup_id": "PDG3",
      "p_name": "Casual T-Shirt",
      "price": 19.99,
      "quantity_in_stock": 150,
      "category": "Apparel",
      "Manufacturer": "Nike",
      "description": "Comfortable and stylish T-shirt",
      "md5": "",
      "status": "In stock",
      "pd_create": "2024-01-01 00:00:00.000",
      "pd_modified": "2024-01-01 00:00:00.000",
      "op_type": "Insert",
      "token": "",
      "session_id": ""
    }
    ', '', '');


INSERT INTO B2B_order_1 (o_id, ogroup_id, customer_id, balance, pay_name, card_number, address, shipping_method, product_price, tax, `shipping_fee`, total_amount, discount_amount, actual_amount, payment_status, md5, od_create, od_modified, op_type, data, token, session_id)
VALUES
    ('SPOD000001', 'ODG1', 'SPCS000001', 0.00, 'Xu Zixiang', '1234-5678-9012-3456', '123 Main St', 'Express Shipping', 69.98, 5.00, 10.00, 84.98, 5.00, 79.98, 'pending', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'Insert', '{
      "o_id": "SPOD000001",
      "ogroup_id": "ODG1",
      "customer_id": "SPCS000001",
      "balance": 0.00,
      "pay_name": "Xu Zixiang",
      "card_number": "1234-5678-9012-3456",
      "address": "123 Main St",
      "shipping_method": "Express Shipping",
      "product_price": 99.98,
      "tax": 5.00,
      "shipping_fee": 10.00,
      "total_amount": 114.98,
      "discount_amount": 5.00,
      "actual_amount": 109.98,
      "payment_status": "pending",
      "md5": "",
      "od_create": "2024-01-01 00:00:00.000",
      "od_modified": "2024-01-01 00:00:00.000",
      "op_type": "Insert",
      "token": "",
      "session_id": ""
    }
    ', '', ''),
    ('SPOD000002', 'ODG1', 'SPCS000002', 0.00, 'Qiu Junyi', '9876-5432-1098-7654', '456 Oak St', 'Standard Shipping', 29.99, 2.00, 5.00, 36.99, 0.00, 36.99, 'completed', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'Insert', '{
      "o_id": "SPOD000002",
      "ogroup_id": "ODG2",
      "customer_id": "SPCS000002",
      "balance": 0.00,
      "pay_name": "Qiu Junyi",
      "card_number": "9876-5432-1098-7654",
      "address": "456 Oak St",
      "shipping_method": "Standard Shipping",
      "product_price": 59.97,
      "tax": 2.00,
      "shipping_fee": 5.00,
      "total_amount": 66.97,
      "discount_amount": 0.00,
      "actual_amount": 66.97,
      "payment_status": "completed",
      "md5": "",
      "od_create": "2024-01-01 00:00:00.000",
      "od_modified": "2024-01-01 00:00:00.000",
      "op_type": "Insert",
      "token": "",
      "session_id": ""
    }
    ', '', ''),
    ('SPOD000003', 'ODG1', 'SPCS000003', 0.00, 'Liu Can', '1111-2222-3333-4444', '789 Pine St', 'Express Shipping', 49.98, 3.00, 8.00, 60.98, 0.00, 60.98, 'completed', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'Insert', '{
      "o_id": "SPOD000003",
      "ogroup_id": "ODG3",
      "customer_id": "SPCS000003",
      "balance": 0.00,
      "pay_name": "Liu Can",
      "card_number": "1111-2222-3333-4444",
      "address": "789 Pine St",
      "shipping_method": "Express Shipping",
      "product_price": 29.99,
      "tax": 3.00,
      "shipping_fee": 8.00,
      "total_amount": 39.99,
      "discount_amount": 0.00,
      "actual_amount": 39.99,
      "payment_status": "completed",
      "md5": "",
      "od_create": "2024-01-01 00:00:00.000",
      "od_modified": "2024-01-01 00:00:00.000",
      "op_type": "Insert",
      "token": "",
      "session_id": ""
    }
    ', '', '');


INSERT INTO B2B_detail_1 (d_id, dgroup_id, name, unit_price, quantity, subtotal, md5, dt_create, dt_modified, op_type, data, token, session_id, o_id_fk)
VALUES
    ('SPDT000001', 'DTG1', 'Running Shoes', 49.99, 2, 99.98, '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'Insert', '{
      "d_id": "SPDT000001",
      "dgroup_id": "DTG1",
      "name": "Running Shoes",
      "unit_price": 49.99,
      "quantity": 2,
      "subtotal": 99.98,
      "md5": "",
      "dt_create": "2024-01-01 00:00:00.000",
      "dt_modified": "2024-01-01 00:00:00.000",
      "op_type": "Insert",
      "token": "",
      "session_id": "",
      "o_id_fk": "SPOD000001"
    }
    ', '', '', 'SPOD000001'),
    ('SPDT000002', 'DTG2', 'Casual T-Shirt', 19.99, 3, 59.97, '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'Insert', '{
      "d_id": "SPDT000002",
      "dgroup_id": "DTG2",
      "name": "Casual T-Shirt",
      "unit_price": 19.99,
      "quantity": 3,
      "subtotal": 59.97,
      "md5": "",
      "dt_create": "2024-01-01 00:00:00.000",
      "dt_modified": "2024-01-01 00:00:00.000",
      "op_type": "Insert",
      "token": "",
      "session_id": "",
      "o_id_fk": "SPOD000002"
    }
    ', '', '', 'SPOD000002'),
    ('SPDT000003', 'DTG3', 'Sports Bag', 29.99, 1, 29.99, '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'Insert', '{
      "d_id": "SPDT000003",
      "dgroup_id": "DTG3",
      "name": "Sports Bag",
      "unit_price": 29.99,
      "quantity": 1,
      "subtotal": 29.99,
      "md5": "",
      "dt_create": "2024-01-01 00:00:00.000",
      "dt_modified": "2024-01-01 00:00:00.000",
      "op_type": "Insert",
      "token": "",
      "session_id": "",
      "o_id_fk": "SPOD000003"
    }
    ', '', '', 'SPOD000003');

INSERT INTO B2B_customer_1 (c_id, cgroup_id, name, age, gender, md5, cs_create, cs_modified, op_type, data, token, session_id) VALUES ('SPCS000001','CSG1','Steve Jobs',21,'Male',NULL,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,'Insert',
                                                                                                                                       '{
                                                                                                                                         "name":"Steve Jobs",
                                                                                                                                         "gender":"Male",
                                                                                                                                         "age":66,
                                                                                                                                         "md5":"",
                                                                                                                                         "token":"",
                                                                                                                                         "op_type":"Insert",
                                                                                                                                         "session_id":""
                                                                                                                                       }',NULL,NULL);
