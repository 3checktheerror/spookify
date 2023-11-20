DROP DATABASE IF EXISTS spookify;
CREATE DATABASE spookify;
USE spookify;

-- ----------------------------
-- Table structure for customer
-- ----------------------------
DROP TABLE IF EXISTS contact_customer_1;
CREATE TABLE contact_customer_1 (
                                    `c_id` varchar(32) NOT NULL,
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
-- Table structure for visitor
-- ----------------------------
DROP TABLE IF EXISTS contact_visitor_1;
CREATE TABLE contact_visitor_1 (
                                   `v_id` varchar(32) NOT NULL,
                                   `vgroup_id` varchar(128) NOT NULL,
                                   `name` varchar(32) NOT NULL,
                                   `username` varchar(32) NOT NULL,
                                   `password` varchar(32) NOT NULL,
                                   `age` INT NOT NULL,
                                   `gender` varchar(16),
                                   `file` BLOB,
                                   `md5` varchar(32),
                                   `vt_create` timestamp NOT NULL DEFAULT '2023-01-01 00:00:00.000',
                                   `vt_modified` timestamp NOT NULL DEFAULT '2023-01-01 00:00:00.000',
                                   `op_type` char(10) DEFAULT NULL,
                                   `data` JSON,
                                   `token` varchar(128),
                                   `session_id` varchar(128),
                                   PRIMARY KEY (v_id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;;

CREATE INDEX contact_visitor_1_vid_idx ON contact_visitor_1(v_id);

-- ----------------------------
-- Table structure for item
-- ----------------------------

DROP TABLE IF EXISTS contact_item_1;
CREATE TABLE contact_item_1 (
                                `i_id` varchar(32) NOT NULL,
                                `igroup_id` varchar(128) NOT NULL,
                                `name` varchar(32) NOT NULL,
                                `gender` varchar(16),
                                `email` varchar(128),
                                `file` LONGBLOB,
                                `file_name` VARCHAR(128),
                                `md5` varchar(32),
                                `it_create` timestamp NOT NULL DEFAULT '2023-01-01 00:00:00.000',
                                `it_modified` timestamp NOT NULL DEFAULT '2023-01-01 00:00:00.000',
                                `op_type` char(10) DEFAULT NULL,
                                `data` JSON,
                                `token` varchar(128),
                                `session_id` varchar(128),
                                `status` varchar(16),
                                `v_id_fk` varchar(32),
                                PRIMARY KEY (i_id),
                                FOREIGN KEY (v_id_fk) REFERENCES contact_visitor_1(v_id)

)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE INDEX contact_item_1_iid_idx ON contact_item_1(i_id);


-- v_id: 2位应用名(SP) + 2位简写(VT) + 6位自增长数字
INSERT INTO contact_visitor_1 (v_id, vgroup_id, name, username, password, age, gender, file, md5, vt_create, vt_modified, op_type, data, token, session_id) VALUES ('SPVT000001','VTG1','Qiu Junyi','Ellen','123456',21,'Male',NULL,NULL,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,'Insert',
                                                                                                                                                                    '{
                                                                                                                                                                      "name":"Qiu Junyi",
                                                                                                                                                                      "username":"Ellen",
                                                                                                                                                                      "password":"123456",
                                                                                                                                                                      "gender":"Male",
                                                                                                                                                                      "age":21,
                                                                                                                                                                      "file":"",
                                                                                                                                                                      "md5":"",
                                                                                                                                                                      "token":"",
                                                                                                                                                                      "op_type":"Insert",
                                                                                                                                                                      "session_id":""
                                                                                                                                                                    }',NULL,NULL);

INSERT INTO contact_visitor_1 (v_id, vgroup_id, name, username, password, age, gender, file, md5, vt_create, vt_modified, op_type, data, token, session_id) VALUES ('SPVT000002','VTG1','Xu Zixiang','Watson','book659',20,'Male',NULL,NULL,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,'Insert',
                                                                                                                                                                    '{
                                                                                                                                                                      "name":"Xu Zixiang",
                                                                                                                                                                      "username":"Watson",
                                                                                                                                                                      "password":"book659",
                                                                                                                                                                      "gender":"Male",
                                                                                                                                                                      "age":20,
                                                                                                                                                                      "file":"",
                                                                                                                                                                      "md5":"",
                                                                                                                                                                      "token":"",
                                                                                                                                                                      "op_type":"Insert",
                                                                                                                                                                      "session_id":""
                                                                                                                                                                    }',NULL,NULL);
INSERT INTO contact_visitor_1 (v_id, vgroup_id, name, username, password, age, gender, file, md5, vt_create, vt_modified, op_type, data, token, session_id) VALUES ('SPVT000003','VTG1','Luo Xudong','BrightFall','victor',20,'Male',NULL,NULL,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,'Insert',
                                                                                                                                                                    '{
                                                                                                                                                                      "name":"Luo Xudong",
                                                                                                                                                                      "username":"BrightFall",
                                                                                                                                                                      "password":"victor",
                                                                                                                                                                      "gender":"Male",
                                                                                                                                                                      "age":20,
                                                                                                                                                                      "file":"",
                                                                                                                                                                      "md5":"",
                                                                                                                                                                      "token":"",
                                                                                                                                                                      "op_type":"Insert",
                                                                                                                                                                      "session_id":""
                                                                                                                                                                    }',NULL,NULL);
INSERT INTO contact_visitor_1 (v_id, vgroup_id, name, username, password, age, gender, file, md5, vt_create, vt_modified, op_type, data, token, session_id) VALUES ('SPVT000004','VTG1','Zhou Ziwei','HookWei','dggbb',20,'Male',NULL,NULL,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,'Insert',
                                                                                                                                                                    '{
                                                                                                                                                                      "name":"Zhou Ziwei",
                                                                                                                                                                      "username":"HookWei",
                                                                                                                                                                      "password":"dggbb",
                                                                                                                                                                      "gender":"Male",
                                                                                                                                                                      "age":20,
                                                                                                                                                                      "file":"",
                                                                                                                                                                      "md5":"",
                                                                                                                                                                      "token":"",
                                                                                                                                                                      "op_type":"Insert",
                                                                                                                                                                      "session_id":""
                                                                                                                                                                    }',NULL,NULL);
INSERT INTO contact_visitor_1 (v_id, vgroup_id, name, username, password, age, gender, file, md5, vt_create, vt_modified, op_type, data, token, session_id) VALUES ('SPVT000005','VTG1','Liu Can','Can.View','footprint659',20,'Male',NULL,NULL,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,'Insert',
                                                                                                                                                                    '{
                                                                                                                                                                      "name":"Liu Can",
                                                                                                                                                                      "username":"Can.View",
                                                                                                                                                                      "password":"footprint659",
                                                                                                                                                                      "gender":"Male",
                                                                                                                                                                      "age":20,
                                                                                                                                                                      "file":"",
                                                                                                                                                                      "md5":"",
                                                                                                                                                                      "token":"",
                                                                                                                                                                      "op_type":"Insert",
                                                                                                                                                                      "session_id":""
                                                                                                                                                                    }',NULL,NULL);
-- i_id: 2位应用名(SP) + 2位简写(IT) + 6位自增长数字
INSERT INTO contact_item_1 (i_id, igroup_id, name, gender, email, file, file_name, md5, it_create, it_modified, op_type, data, token, session_id, status, v_id_fk) VALUES ('SPIT000001', 'ITG1', 'QIU_FORM', 'Male', 'swe2109562@xmu.edu.my',NULL,NULL,NULL,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,'Insert','{
  "i_id":"SPIT000001",
  "igroup_id":"ITG1",
  "name":"QIU_FORM",
  "gender":"Male",
  "email":"swe2109562@xmu.edu.my",
  "file":"",
  "file_name":"",
  "md5":"",
  "token":"",
  "op_type":"Insert",
  "session_id":"",
  "status":"Submit"
}',NULL,NULL,'Submit','SPVT000001');

INSERT INTO contact_item_1 (i_id, igroup_id, name, gender, email, file, file_name, md5, it_create, it_modified, op_type, data, token, session_id, status, v_id_fk) VALUES ('SPIT000002', 'ITG1', 'Xu_FORM', 'Male', 'swe2109568@xmu.edu.my',NULL,NULL,NULL,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,'Insert','{
  "i_id":"SPIT000002",
  "igroup_id":"ITG2",
  "name":"Xu_FORM",
  "gender":"Male",
  "email":"swe2109568@xmu.edu.my",
  "file":"",
  "file_name":"",
  "md5":"",
  "token":"",
  "op_type":"Insert",
  "session_id":"",
  "status":"Submit"
}',NULL,NULL,'Submit','SPVT000001');

INSERT INTO contact_item_1 (i_id, igroup_id, name, gender, email, file, file_name, md5, it_create, it_modified, op_type, data, token, session_id, status, v_id_fk) VALUES ('SPIT000003', 'ITG1', 'Liu_FORM', 'Male', 'swe2109560@xmu.edu.my',NULL,NULL,NULL,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,'Insert','{
  "i_id":"SPIT000003",
  "igroup_id":"ITG2",
  "name":"Liu_FORM",
  "gender":"Male",
  "email":"swe2109560@xmu.edu.my",
  "file":"",
  "file_name":"",
  "md5":"",
  "token":"",
  "op_type":"Insert",
  "session_id":"",
  "status":"Submit"
}',NULL,NULL,'Submit','SPVT000001');
-- c_id: 2位应用名(SP) + 2位简写(CS) + 6位自增长数字

INSERT INTO contact_customer_1 (c_id, cgroup_id, name, age, gender, file, md5, cs_create, cs_modified, op_type, data, token, session_id) VALUES ('SPCS000001','CSG1','Steve Jobs',21,'Male',NULL,NULL,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,'Insert',
                                                                                                                                                 '{
                                                                                                                                                   "name":"Steve Jobs",
                                                                                                                                                   "gender":"Male",
                                                                                                                                                   "age":66,
                                                                                                                                                   "file":"",
                                                                                                                                                   "md5":"",
                                                                                                                                                   "token":"",
                                                                                                                                                   "op_type":"Insert",
                                                                                                                                                   "session_id":""
                                                                                                                                                 }',NULL,NULL);





