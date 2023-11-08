/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 80027
 Source Host           : localhost:3306
 Source Schema         : ares

 Target Server Type    : MySQL
 Target Server Version : 80027
 File Encoding         : 65001

 Date: 08/08/2023 14:02:40
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for act_app_appdef
-- ----------------------------
DROP TABLE IF EXISTS `act_app_appdef`;
CREATE TABLE `act_app_appdef` (
                                  `ID_` varchar(255) NOT NULL,
                                  `REV_` int NOT NULL,
                                  `NAME_` varchar(255) DEFAULT NULL,
                                  `KEY_` varchar(255) NOT NULL,
                                  `VERSION_` int NOT NULL,
                                  `CATEGORY_` varchar(255) DEFAULT NULL,
                                  `DEPLOYMENT_ID_` varchar(255) DEFAULT NULL,
                                  `RESOURCE_NAME_` varchar(4000) DEFAULT NULL,
                                  `DESCRIPTION_` varchar(4000) DEFAULT NULL,
                                  `TENANT_ID_` varchar(255) DEFAULT '',
                                  PRIMARY KEY (`ID_`),
                                  UNIQUE KEY `ACT_IDX_APP_DEF_UNIQ` (`KEY_`,`VERSION_`,`TENANT_ID_`),
                                  KEY `ACT_IDX_APP_DEF_DPLY` (`DEPLOYMENT_ID_`),
                                  CONSTRAINT `ACT_FK_APP_DEF_DPLY` FOREIGN KEY (`DEPLOYMENT_ID_`) REFERENCES `act_app_deployment` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of act_app_appdef
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for act_app_databasechangelog
-- ----------------------------
DROP TABLE IF EXISTS `act_app_databasechangelog`;
CREATE TABLE `act_app_databasechangelog` (
                                             `ID` varchar(255) NOT NULL,
                                             `AUTHOR` varchar(255) NOT NULL,
                                             `FILENAME` varchar(255) NOT NULL,
                                             `DATEEXECUTED` datetime NOT NULL,
                                             `ORDEREXECUTED` int NOT NULL,
                                             `EXECTYPE` varchar(10) NOT NULL,
                                             `MD5SUM` varchar(35) DEFAULT NULL,
                                             `DESCRIPTION` varchar(255) DEFAULT NULL,
                                             `COMMENTS` varchar(255) DEFAULT NULL,
                                             `TAG` varchar(255) DEFAULT NULL,
                                             `LIQUIBASE` varchar(20) DEFAULT NULL,
                                             `CONTEXTS` varchar(255) DEFAULT NULL,
                                             `LABELS` varchar(255) DEFAULT NULL,
                                             `DEPLOYMENT_ID` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of act_app_databasechangelog
-- ----------------------------
BEGIN;
INSERT INTO `act_app_databasechangelog` (`ID`, `AUTHOR`, `FILENAME`, `DATEEXECUTED`, `ORDEREXECUTED`, `EXECTYPE`, `MD5SUM`, `DESCRIPTION`, `COMMENTS`, `TAG`, `LIQUIBASE`, `CONTEXTS`, `LABELS`, `DEPLOYMENT_ID`) VALUES ('1', 'flowable', 'org/flowable/app/db/liquibase/flowable-app-db-changelog.xml', '2022-01-12 07:20:46', 1, 'EXECUTED', '8:496fc778bdf2ab13f2e1926d0e63e0a2', 'createTable tableName=ACT_APP_DEPLOYMENT; createTable tableName=ACT_APP_DEPLOYMENT_RESOURCE; addForeignKeyConstraint baseTableName=ACT_APP_DEPLOYMENT_RESOURCE, constraintName=ACT_FK_APP_RSRC_DPL, referencedTableName=ACT_APP_DEPLOYMENT; createIndex...', '', NULL, '3.8.9', NULL, NULL, '1972046503');
INSERT INTO `act_app_databasechangelog` (`ID`, `AUTHOR`, `FILENAME`, `DATEEXECUTED`, `ORDEREXECUTED`, `EXECTYPE`, `MD5SUM`, `DESCRIPTION`, `COMMENTS`, `TAG`, `LIQUIBASE`, `CONTEXTS`, `LABELS`, `DEPLOYMENT_ID`) VALUES ('2', 'flowable', 'org/flowable/app/db/liquibase/flowable-app-db-changelog.xml', '2022-01-12 07:20:46', 2, 'EXECUTED', '8:ccea9ebfb6c1f8367ca4dd473fcbb7db', 'modifyDataType columnName=DEPLOY_TIME_, tableName=ACT_APP_DEPLOYMENT', '', NULL, '3.8.9', NULL, NULL, '1972046503');
INSERT INTO `act_app_databasechangelog` (`ID`, `AUTHOR`, `FILENAME`, `DATEEXECUTED`, `ORDEREXECUTED`, `EXECTYPE`, `MD5SUM`, `DESCRIPTION`, `COMMENTS`, `TAG`, `LIQUIBASE`, `CONTEXTS`, `LABELS`, `DEPLOYMENT_ID`) VALUES ('3', 'flowable', 'org/flowable/app/db/liquibase/flowable-app-db-changelog.xml', '2022-01-12 07:20:46', 3, 'EXECUTED', '8:f1f8aff320aade831944ebad24355f3d', 'createIndex indexName=ACT_IDX_APP_DEF_UNIQ, tableName=ACT_APP_APPDEF', '', NULL, '3.8.9', NULL, NULL, '1972046503');
COMMIT;

-- ----------------------------
-- Table structure for act_app_databasechangeloglock
-- ----------------------------
DROP TABLE IF EXISTS `act_app_databasechangeloglock`;
CREATE TABLE `act_app_databasechangeloglock` (
                                                 `ID` int NOT NULL,
                                                 `LOCKED` bit(1) NOT NULL,
                                                 `LOCKGRANTED` datetime DEFAULT NULL,
                                                 `LOCKEDBY` varchar(255) DEFAULT NULL,
                                                 PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of act_app_databasechangeloglock
-- ----------------------------
BEGIN;
INSERT INTO `act_app_databasechangeloglock` (`ID`, `LOCKED`, `LOCKGRANTED`, `LOCKEDBY`) VALUES (1, b'0', NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for act_app_deployment
-- ----------------------------
DROP TABLE IF EXISTS `act_app_deployment`;
CREATE TABLE `act_app_deployment` (
                                      `ID_` varchar(255) NOT NULL,
                                      `NAME_` varchar(255) DEFAULT NULL,
                                      `CATEGORY_` varchar(255) DEFAULT NULL,
                                      `KEY_` varchar(255) DEFAULT NULL,
                                      `DEPLOY_TIME_` datetime(3) DEFAULT NULL,
                                      `TENANT_ID_` varchar(255) DEFAULT '',
                                      PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of act_app_deployment
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for act_app_deployment_resource
-- ----------------------------
DROP TABLE IF EXISTS `act_app_deployment_resource`;
CREATE TABLE `act_app_deployment_resource` (
                                               `ID_` varchar(255) NOT NULL,
                                               `NAME_` varchar(255) DEFAULT NULL,
                                               `DEPLOYMENT_ID_` varchar(255) DEFAULT NULL,
                                               `RESOURCE_BYTES_` longblob,
                                               PRIMARY KEY (`ID_`),
                                               KEY `ACT_IDX_APP_RSRC_DPL` (`DEPLOYMENT_ID_`),
                                               CONSTRAINT `ACT_FK_APP_RSRC_DPL` FOREIGN KEY (`DEPLOYMENT_ID_`) REFERENCES `act_app_deployment` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of act_app_deployment_resource
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for act_cmmn_casedef
-- ----------------------------
DROP TABLE IF EXISTS `act_cmmn_casedef`;
CREATE TABLE `act_cmmn_casedef` (
                                    `ID_` varchar(255) NOT NULL,
                                    `REV_` int NOT NULL,
                                    `NAME_` varchar(255) DEFAULT NULL,
                                    `KEY_` varchar(255) NOT NULL,
                                    `VERSION_` int NOT NULL,
                                    `CATEGORY_` varchar(255) DEFAULT NULL,
                                    `DEPLOYMENT_ID_` varchar(255) DEFAULT NULL,
                                    `RESOURCE_NAME_` varchar(4000) DEFAULT NULL,
                                    `DESCRIPTION_` varchar(4000) DEFAULT NULL,
                                    `HAS_GRAPHICAL_NOTATION_` bit(1) DEFAULT NULL,
                                    `TENANT_ID_` varchar(255) DEFAULT '',
                                    `DGRM_RESOURCE_NAME_` varchar(4000) DEFAULT NULL,
                                    `HAS_START_FORM_KEY_` bit(1) DEFAULT NULL,
                                    PRIMARY KEY (`ID_`),
                                    UNIQUE KEY `ACT_IDX_CASE_DEF_UNIQ` (`KEY_`,`VERSION_`,`TENANT_ID_`),
                                    KEY `ACT_IDX_CASE_DEF_DPLY` (`DEPLOYMENT_ID_`),
                                    CONSTRAINT `ACT_FK_CASE_DEF_DPLY` FOREIGN KEY (`DEPLOYMENT_ID_`) REFERENCES `act_cmmn_deployment` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of act_cmmn_casedef
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for act_cmmn_databasechangelog
-- ----------------------------
DROP TABLE IF EXISTS `act_cmmn_databasechangelog`;
CREATE TABLE `act_cmmn_databasechangelog` (
                                              `ID` varchar(255) NOT NULL,
                                              `AUTHOR` varchar(255) NOT NULL,
                                              `FILENAME` varchar(255) NOT NULL,
                                              `DATEEXECUTED` datetime NOT NULL,
                                              `ORDEREXECUTED` int NOT NULL,
                                              `EXECTYPE` varchar(10) NOT NULL,
                                              `MD5SUM` varchar(35) DEFAULT NULL,
                                              `DESCRIPTION` varchar(255) DEFAULT NULL,
                                              `COMMENTS` varchar(255) DEFAULT NULL,
                                              `TAG` varchar(255) DEFAULT NULL,
                                              `LIQUIBASE` varchar(20) DEFAULT NULL,
                                              `CONTEXTS` varchar(255) DEFAULT NULL,
                                              `LABELS` varchar(255) DEFAULT NULL,
                                              `DEPLOYMENT_ID` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of act_cmmn_databasechangelog
-- ----------------------------
BEGIN;
INSERT INTO `act_cmmn_databasechangelog` (`ID`, `AUTHOR`, `FILENAME`, `DATEEXECUTED`, `ORDEREXECUTED`, `EXECTYPE`, `MD5SUM`, `DESCRIPTION`, `COMMENTS`, `TAG`, `LIQUIBASE`, `CONTEXTS`, `LABELS`, `DEPLOYMENT_ID`) VALUES ('1', 'flowable', 'org/flowable/cmmn/db/liquibase/flowable-cmmn-db-changelog.xml', '2022-01-12 07:20:43', 1, 'EXECUTED', '8:8b4b922d90b05ff27483abefc9597aa6', 'createTable tableName=ACT_CMMN_DEPLOYMENT; createTable tableName=ACT_CMMN_DEPLOYMENT_RESOURCE; addForeignKeyConstraint baseTableName=ACT_CMMN_DEPLOYMENT_RESOURCE, constraintName=ACT_FK_CMMN_RSRC_DPL, referencedTableName=ACT_CMMN_DEPLOYMENT; create...', '', NULL, '3.8.9', NULL, NULL, '1972041811');
INSERT INTO `act_cmmn_databasechangelog` (`ID`, `AUTHOR`, `FILENAME`, `DATEEXECUTED`, `ORDEREXECUTED`, `EXECTYPE`, `MD5SUM`, `DESCRIPTION`, `COMMENTS`, `TAG`, `LIQUIBASE`, `CONTEXTS`, `LABELS`, `DEPLOYMENT_ID`) VALUES ('2', 'flowable', 'org/flowable/cmmn/db/liquibase/flowable-cmmn-db-changelog.xml', '2022-01-12 07:20:43', 2, 'EXECUTED', '8:65e39b3d385706bb261cbeffe7533cbe', 'addColumn tableName=ACT_CMMN_CASEDEF; addColumn tableName=ACT_CMMN_DEPLOYMENT_RESOURCE; addColumn tableName=ACT_CMMN_RU_CASE_INST; addColumn tableName=ACT_CMMN_RU_PLAN_ITEM_INST', '', NULL, '3.8.9', NULL, NULL, '1972041811');
INSERT INTO `act_cmmn_databasechangelog` (`ID`, `AUTHOR`, `FILENAME`, `DATEEXECUTED`, `ORDEREXECUTED`, `EXECTYPE`, `MD5SUM`, `DESCRIPTION`, `COMMENTS`, `TAG`, `LIQUIBASE`, `CONTEXTS`, `LABELS`, `DEPLOYMENT_ID`) VALUES ('3', 'flowable', 'org/flowable/cmmn/db/liquibase/flowable-cmmn-db-changelog.xml', '2022-01-12 07:20:43', 3, 'EXECUTED', '8:c01f6e802b49436b4489040da3012359', 'addColumn tableName=ACT_CMMN_RU_PLAN_ITEM_INST; addColumn tableName=ACT_CMMN_RU_CASE_INST; createIndex indexName=ACT_IDX_PLAN_ITEM_STAGE_INST, tableName=ACT_CMMN_RU_PLAN_ITEM_INST; addColumn tableName=ACT_CMMN_RU_PLAN_ITEM_INST; addColumn tableNam...', '', NULL, '3.8.9', NULL, NULL, '1972041811');
INSERT INTO `act_cmmn_databasechangelog` (`ID`, `AUTHOR`, `FILENAME`, `DATEEXECUTED`, `ORDEREXECUTED`, `EXECTYPE`, `MD5SUM`, `DESCRIPTION`, `COMMENTS`, `TAG`, `LIQUIBASE`, `CONTEXTS`, `LABELS`, `DEPLOYMENT_ID`) VALUES ('4', 'flowable', 'org/flowable/cmmn/db/liquibase/flowable-cmmn-db-changelog.xml', '2022-01-12 07:20:43', 4, 'EXECUTED', '8:e40d29cb79345b7fb5afd38a7f0ba8fc', 'createTable tableName=ACT_CMMN_HI_PLAN_ITEM_INST; addColumn tableName=ACT_CMMN_RU_MIL_INST; addColumn tableName=ACT_CMMN_HI_MIL_INST', '', NULL, '3.8.9', NULL, NULL, '1972041811');
INSERT INTO `act_cmmn_databasechangelog` (`ID`, `AUTHOR`, `FILENAME`, `DATEEXECUTED`, `ORDEREXECUTED`, `EXECTYPE`, `MD5SUM`, `DESCRIPTION`, `COMMENTS`, `TAG`, `LIQUIBASE`, `CONTEXTS`, `LABELS`, `DEPLOYMENT_ID`) VALUES ('5', 'flowable', 'org/flowable/cmmn/db/liquibase/flowable-cmmn-db-changelog.xml', '2022-01-12 07:20:45', 5, 'EXECUTED', '8:70349de472f87368dcdec971a10311a0', 'modifyDataType columnName=DEPLOY_TIME_, tableName=ACT_CMMN_DEPLOYMENT; modifyDataType columnName=START_TIME_, tableName=ACT_CMMN_RU_CASE_INST; modifyDataType columnName=START_TIME_, tableName=ACT_CMMN_RU_PLAN_ITEM_INST; modifyDataType columnName=T...', '', NULL, '3.8.9', NULL, NULL, '1972041811');
INSERT INTO `act_cmmn_databasechangelog` (`ID`, `AUTHOR`, `FILENAME`, `DATEEXECUTED`, `ORDEREXECUTED`, `EXECTYPE`, `MD5SUM`, `DESCRIPTION`, `COMMENTS`, `TAG`, `LIQUIBASE`, `CONTEXTS`, `LABELS`, `DEPLOYMENT_ID`) VALUES ('6', 'flowable', 'org/flowable/cmmn/db/liquibase/flowable-cmmn-db-changelog.xml', '2022-01-12 07:20:45', 6, 'EXECUTED', '8:10e82e26a7fee94c32a92099c059c18c', 'createIndex indexName=ACT_IDX_CASE_DEF_UNIQ, tableName=ACT_CMMN_CASEDEF', '', NULL, '3.8.9', NULL, NULL, '1972041811');
INSERT INTO `act_cmmn_databasechangelog` (`ID`, `AUTHOR`, `FILENAME`, `DATEEXECUTED`, `ORDEREXECUTED`, `EXECTYPE`, `MD5SUM`, `DESCRIPTION`, `COMMENTS`, `TAG`, `LIQUIBASE`, `CONTEXTS`, `LABELS`, `DEPLOYMENT_ID`) VALUES ('7', 'flowable', 'org/flowable/cmmn/db/liquibase/flowable-cmmn-db-changelog.xml', '2022-01-12 07:20:45', 7, 'EXECUTED', '8:530bc81a1e30618ccf4a2da1f7c6c043', 'renameColumn newColumnName=CREATE_TIME_, oldColumnName=START_TIME_, tableName=ACT_CMMN_RU_PLAN_ITEM_INST; renameColumn newColumnName=CREATE_TIME_, oldColumnName=CREATED_TIME_, tableName=ACT_CMMN_HI_PLAN_ITEM_INST; addColumn tableName=ACT_CMMN_RU_P...', '', NULL, '3.8.9', NULL, NULL, '1972041811');
INSERT INTO `act_cmmn_databasechangelog` (`ID`, `AUTHOR`, `FILENAME`, `DATEEXECUTED`, `ORDEREXECUTED`, `EXECTYPE`, `MD5SUM`, `DESCRIPTION`, `COMMENTS`, `TAG`, `LIQUIBASE`, `CONTEXTS`, `LABELS`, `DEPLOYMENT_ID`) VALUES ('8', 'flowable', 'org/flowable/cmmn/db/liquibase/flowable-cmmn-db-changelog.xml', '2022-01-12 07:20:45', 8, 'EXECUTED', '8:e8c2eb1ce28bc301efe07e0e29757781', 'addColumn tableName=ACT_CMMN_HI_PLAN_ITEM_INST', '', NULL, '3.8.9', NULL, NULL, '1972041811');
INSERT INTO `act_cmmn_databasechangelog` (`ID`, `AUTHOR`, `FILENAME`, `DATEEXECUTED`, `ORDEREXECUTED`, `EXECTYPE`, `MD5SUM`, `DESCRIPTION`, `COMMENTS`, `TAG`, `LIQUIBASE`, `CONTEXTS`, `LABELS`, `DEPLOYMENT_ID`) VALUES ('9', 'flowable', 'org/flowable/cmmn/db/liquibase/flowable-cmmn-db-changelog.xml', '2022-01-12 07:20:45', 9, 'EXECUTED', '8:4cb4782b9bdec5ced2a64c525aa7b3a0', 'addColumn tableName=ACT_CMMN_RU_PLAN_ITEM_INST; addColumn tableName=ACT_CMMN_HI_PLAN_ITEM_INST', '', NULL, '3.8.9', NULL, NULL, '1972041811');
INSERT INTO `act_cmmn_databasechangelog` (`ID`, `AUTHOR`, `FILENAME`, `DATEEXECUTED`, `ORDEREXECUTED`, `EXECTYPE`, `MD5SUM`, `DESCRIPTION`, `COMMENTS`, `TAG`, `LIQUIBASE`, `CONTEXTS`, `LABELS`, `DEPLOYMENT_ID`) VALUES ('10', 'flowable', 'org/flowable/cmmn/db/liquibase/flowable-cmmn-db-changelog.xml', '2022-01-12 07:20:46', 10, 'EXECUTED', '8:341c16be247f5d17badc9809da8691f9', 'addColumn tableName=ACT_CMMN_RU_CASE_INST; addColumn tableName=ACT_CMMN_RU_CASE_INST; createIndex indexName=ACT_IDX_CASE_INST_REF_ID_, tableName=ACT_CMMN_RU_CASE_INST; addColumn tableName=ACT_CMMN_HI_CASE_INST; addColumn tableName=ACT_CMMN_HI_CASE...', '', NULL, '3.8.9', NULL, NULL, '1972041811');
INSERT INTO `act_cmmn_databasechangelog` (`ID`, `AUTHOR`, `FILENAME`, `DATEEXECUTED`, `ORDEREXECUTED`, `EXECTYPE`, `MD5SUM`, `DESCRIPTION`, `COMMENTS`, `TAG`, `LIQUIBASE`, `CONTEXTS`, `LABELS`, `DEPLOYMENT_ID`) VALUES ('11', 'flowable', 'org/flowable/cmmn/db/liquibase/flowable-cmmn-db-changelog.xml', '2022-01-12 07:20:46', 11, 'EXECUTED', '8:d7c4da9276bcfffbfb0ebfb25e3f7b05', 'addColumn tableName=ACT_CMMN_RU_PLAN_ITEM_INST; addColumn tableName=ACT_CMMN_HI_PLAN_ITEM_INST', '', NULL, '3.8.9', NULL, NULL, '1972041811');
INSERT INTO `act_cmmn_databasechangelog` (`ID`, `AUTHOR`, `FILENAME`, `DATEEXECUTED`, `ORDEREXECUTED`, `EXECTYPE`, `MD5SUM`, `DESCRIPTION`, `COMMENTS`, `TAG`, `LIQUIBASE`, `CONTEXTS`, `LABELS`, `DEPLOYMENT_ID`) VALUES ('12', 'flowable', 'org/flowable/cmmn/db/liquibase/flowable-cmmn-db-changelog.xml', '2022-01-12 07:20:46', 12, 'EXECUTED', '8:adf4ecc45f2aa9a44a5626b02e1d6f98', 'addColumn tableName=ACT_CMMN_RU_CASE_INST', '', NULL, '3.8.9', NULL, NULL, '1972041811');
INSERT INTO `act_cmmn_databasechangelog` (`ID`, `AUTHOR`, `FILENAME`, `DATEEXECUTED`, `ORDEREXECUTED`, `EXECTYPE`, `MD5SUM`, `DESCRIPTION`, `COMMENTS`, `TAG`, `LIQUIBASE`, `CONTEXTS`, `LABELS`, `DEPLOYMENT_ID`) VALUES ('13', 'flowable', 'org/flowable/cmmn/db/liquibase/flowable-cmmn-db-changelog.xml', '2022-01-12 07:20:46', 13, 'EXECUTED', '8:7550626f964ab5518464709408333ec1', 'addColumn tableName=ACT_CMMN_RU_PLAN_ITEM_INST; addColumn tableName=ACT_CMMN_HI_PLAN_ITEM_INST', '', NULL, '3.8.9', NULL, NULL, '1972041811');
INSERT INTO `act_cmmn_databasechangelog` (`ID`, `AUTHOR`, `FILENAME`, `DATEEXECUTED`, `ORDEREXECUTED`, `EXECTYPE`, `MD5SUM`, `DESCRIPTION`, `COMMENTS`, `TAG`, `LIQUIBASE`, `CONTEXTS`, `LABELS`, `DEPLOYMENT_ID`) VALUES ('14', 'flowable', 'org/flowable/cmmn/db/liquibase/flowable-cmmn-db-changelog.xml', '2022-01-12 07:20:46', 14, 'EXECUTED', '8:086b40b3a05596dcc8a8d7479922d494', 'addColumn tableName=ACT_CMMN_RU_CASE_INST; addColumn tableName=ACT_CMMN_HI_CASE_INST', '', NULL, '3.8.9', NULL, NULL, '1972041811');
INSERT INTO `act_cmmn_databasechangelog` (`ID`, `AUTHOR`, `FILENAME`, `DATEEXECUTED`, `ORDEREXECUTED`, `EXECTYPE`, `MD5SUM`, `DESCRIPTION`, `COMMENTS`, `TAG`, `LIQUIBASE`, `CONTEXTS`, `LABELS`, `DEPLOYMENT_ID`) VALUES ('16', 'flowable', 'org/flowable/cmmn/db/liquibase/flowable-cmmn-db-changelog.xml', '2022-01-12 07:20:46', 15, 'EXECUTED', '8:a697a222ddd99dd15b36516a252f1c63', 'addColumn tableName=ACT_CMMN_RU_CASE_INST; addColumn tableName=ACT_CMMN_HI_CASE_INST', '', NULL, '3.8.9', NULL, NULL, '1972041811');
INSERT INTO `act_cmmn_databasechangelog` (`ID`, `AUTHOR`, `FILENAME`, `DATEEXECUTED`, `ORDEREXECUTED`, `EXECTYPE`, `MD5SUM`, `DESCRIPTION`, `COMMENTS`, `TAG`, `LIQUIBASE`, `CONTEXTS`, `LABELS`, `DEPLOYMENT_ID`) VALUES ('17', 'flowable', 'org/flowable/cmmn/db/liquibase/flowable-cmmn-db-changelog.xml', '2023-09-06 01:36:24', 16, 'EXECUTED', '8:d3706c5813a9b97fd2a59d12a9523946', 'createIndex indexName=ACT_IDX_HI_CASE_INST_END, tableName=ACT_CMMN_HI_CASE_INST', '', NULL, '4.20.0', NULL, NULL, '3964184563');
COMMIT;

-- ----------------------------
-- Table structure for act_cmmn_databasechangeloglock
-- ----------------------------
DROP TABLE IF EXISTS `act_cmmn_databasechangeloglock`;
CREATE TABLE `act_cmmn_databasechangeloglock` (
                                                  `ID` int NOT NULL,
                                                  `LOCKED` bit(1) NOT NULL,
                                                  `LOCKGRANTED` datetime DEFAULT NULL,
                                                  `LOCKEDBY` varchar(255) DEFAULT NULL,
                                                  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of act_cmmn_databasechangeloglock
-- ----------------------------
BEGIN;
INSERT INTO `act_cmmn_databasechangeloglock` (`ID`, `LOCKED`, `LOCKGRANTED`, `LOCKEDBY`) VALUES (1, b'0', NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for act_cmmn_deployment
-- ----------------------------
DROP TABLE IF EXISTS `act_cmmn_deployment`;
CREATE TABLE `act_cmmn_deployment` (
                                       `ID_` varchar(255) NOT NULL,
                                       `NAME_` varchar(255) DEFAULT NULL,
                                       `CATEGORY_` varchar(255) DEFAULT NULL,
                                       `KEY_` varchar(255) DEFAULT NULL,
                                       `DEPLOY_TIME_` datetime(3) DEFAULT NULL,
                                       `PARENT_DEPLOYMENT_ID_` varchar(255) DEFAULT NULL,
                                       `TENANT_ID_` varchar(255) DEFAULT '',
                                       PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of act_cmmn_deployment
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for act_cmmn_deployment_resource
-- ----------------------------
DROP TABLE IF EXISTS `act_cmmn_deployment_resource`;
CREATE TABLE `act_cmmn_deployment_resource` (
                                                `ID_` varchar(255) NOT NULL,
                                                `NAME_` varchar(255) DEFAULT NULL,
                                                `DEPLOYMENT_ID_` varchar(255) DEFAULT NULL,
                                                `RESOURCE_BYTES_` longblob,
                                                `GENERATED_` bit(1) DEFAULT NULL,
                                                PRIMARY KEY (`ID_`),
                                                KEY `ACT_IDX_CMMN_RSRC_DPL` (`DEPLOYMENT_ID_`),
                                                CONSTRAINT `ACT_FK_CMMN_RSRC_DPL` FOREIGN KEY (`DEPLOYMENT_ID_`) REFERENCES `act_cmmn_deployment` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of act_cmmn_deployment_resource
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for act_cmmn_hi_case_inst
-- ----------------------------
DROP TABLE IF EXISTS `act_cmmn_hi_case_inst`;
CREATE TABLE `act_cmmn_hi_case_inst` (
                                         `ID_` varchar(255) NOT NULL,
                                         `REV_` int NOT NULL,
                                         `BUSINESS_KEY_` varchar(255) DEFAULT NULL,
                                         `NAME_` varchar(255) DEFAULT NULL,
                                         `PARENT_ID_` varchar(255) DEFAULT NULL,
                                         `CASE_DEF_ID_` varchar(255) DEFAULT NULL,
                                         `STATE_` varchar(255) DEFAULT NULL,
                                         `START_TIME_` datetime(3) DEFAULT NULL,
                                         `END_TIME_` datetime(3) DEFAULT NULL,
                                         `START_USER_ID_` varchar(255) DEFAULT NULL,
                                         `CALLBACK_ID_` varchar(255) DEFAULT NULL,
                                         `CALLBACK_TYPE_` varchar(255) DEFAULT NULL,
                                         `TENANT_ID_` varchar(255) DEFAULT '',
                                         `REFERENCE_ID_` varchar(255) DEFAULT NULL,
                                         `REFERENCE_TYPE_` varchar(255) DEFAULT NULL,
                                         `LAST_REACTIVATION_TIME_` datetime(3) DEFAULT NULL,
                                         `LAST_REACTIVATION_USER_ID_` varchar(255) DEFAULT NULL,
                                         `BUSINESS_STATUS_` varchar(255) DEFAULT NULL,
                                         PRIMARY KEY (`ID_`),
                                         KEY `ACT_IDX_HI_CASE_INST_END` (`END_TIME_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of act_cmmn_hi_case_inst
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for act_cmmn_hi_mil_inst
-- ----------------------------
DROP TABLE IF EXISTS `act_cmmn_hi_mil_inst`;
CREATE TABLE `act_cmmn_hi_mil_inst` (
                                        `ID_` varchar(255) NOT NULL,
                                        `REV_` int NOT NULL,
                                        `NAME_` varchar(255) NOT NULL,
                                        `TIME_STAMP_` datetime(3) DEFAULT NULL,
                                        `CASE_INST_ID_` varchar(255) NOT NULL,
                                        `CASE_DEF_ID_` varchar(255) NOT NULL,
                                        `ELEMENT_ID_` varchar(255) NOT NULL,
                                        `TENANT_ID_` varchar(255) DEFAULT '',
                                        PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of act_cmmn_hi_mil_inst
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for act_cmmn_hi_plan_item_inst
-- ----------------------------
DROP TABLE IF EXISTS `act_cmmn_hi_plan_item_inst`;
CREATE TABLE `act_cmmn_hi_plan_item_inst` (
                                              `ID_` varchar(255) NOT NULL,
                                              `REV_` int NOT NULL,
                                              `NAME_` varchar(255) DEFAULT NULL,
                                              `STATE_` varchar(255) DEFAULT NULL,
                                              `CASE_DEF_ID_` varchar(255) DEFAULT NULL,
                                              `CASE_INST_ID_` varchar(255) DEFAULT NULL,
                                              `STAGE_INST_ID_` varchar(255) DEFAULT NULL,
                                              `IS_STAGE_` bit(1) DEFAULT NULL,
                                              `ELEMENT_ID_` varchar(255) DEFAULT NULL,
                                              `ITEM_DEFINITION_ID_` varchar(255) DEFAULT NULL,
                                              `ITEM_DEFINITION_TYPE_` varchar(255) DEFAULT NULL,
                                              `CREATE_TIME_` datetime(3) DEFAULT NULL,
                                              `LAST_AVAILABLE_TIME_` datetime(3) DEFAULT NULL,
                                              `LAST_ENABLED_TIME_` datetime(3) DEFAULT NULL,
                                              `LAST_DISABLED_TIME_` datetime(3) DEFAULT NULL,
                                              `LAST_STARTED_TIME_` datetime(3) DEFAULT NULL,
                                              `LAST_SUSPENDED_TIME_` datetime(3) DEFAULT NULL,
                                              `COMPLETED_TIME_` datetime(3) DEFAULT NULL,
                                              `OCCURRED_TIME_` datetime(3) DEFAULT NULL,
                                              `TERMINATED_TIME_` datetime(3) DEFAULT NULL,
                                              `EXIT_TIME_` datetime(3) DEFAULT NULL,
                                              `ENDED_TIME_` datetime(3) DEFAULT NULL,
                                              `LAST_UPDATED_TIME_` datetime(3) DEFAULT NULL,
                                              `START_USER_ID_` varchar(255) DEFAULT NULL,
                                              `REFERENCE_ID_` varchar(255) DEFAULT NULL,
                                              `REFERENCE_TYPE_` varchar(255) DEFAULT NULL,
                                              `TENANT_ID_` varchar(255) DEFAULT '',
                                              `ENTRY_CRITERION_ID_` varchar(255) DEFAULT NULL,
                                              `EXIT_CRITERION_ID_` varchar(255) DEFAULT NULL,
                                              `SHOW_IN_OVERVIEW_` bit(1) DEFAULT NULL,
                                              `EXTRA_VALUE_` varchar(255) DEFAULT NULL,
                                              `DERIVED_CASE_DEF_ID_` varchar(255) DEFAULT NULL,
                                              `LAST_UNAVAILABLE_TIME_` datetime(3) DEFAULT NULL,
                                              PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of act_cmmn_hi_plan_item_inst
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for act_cmmn_ru_case_inst
-- ----------------------------
DROP TABLE IF EXISTS `act_cmmn_ru_case_inst`;
CREATE TABLE `act_cmmn_ru_case_inst` (
                                         `ID_` varchar(255) NOT NULL,
                                         `REV_` int NOT NULL,
                                         `BUSINESS_KEY_` varchar(255) DEFAULT NULL,
                                         `NAME_` varchar(255) DEFAULT NULL,
                                         `PARENT_ID_` varchar(255) DEFAULT NULL,
                                         `CASE_DEF_ID_` varchar(255) DEFAULT NULL,
                                         `STATE_` varchar(255) DEFAULT NULL,
                                         `START_TIME_` datetime(3) DEFAULT NULL,
                                         `START_USER_ID_` varchar(255) DEFAULT NULL,
                                         `CALLBACK_ID_` varchar(255) DEFAULT NULL,
                                         `CALLBACK_TYPE_` varchar(255) DEFAULT NULL,
                                         `TENANT_ID_` varchar(255) DEFAULT '',
                                         `LOCK_TIME_` datetime(3) DEFAULT NULL,
                                         `IS_COMPLETEABLE_` bit(1) DEFAULT NULL,
                                         `REFERENCE_ID_` varchar(255) DEFAULT NULL,
                                         `REFERENCE_TYPE_` varchar(255) DEFAULT NULL,
                                         `LOCK_OWNER_` varchar(255) DEFAULT NULL,
                                         `LAST_REACTIVATION_TIME_` datetime(3) DEFAULT NULL,
                                         `LAST_REACTIVATION_USER_ID_` varchar(255) DEFAULT NULL,
                                         `BUSINESS_STATUS_` varchar(255) DEFAULT NULL,
                                         PRIMARY KEY (`ID_`),
                                         KEY `ACT_IDX_CASE_INST_CASE_DEF` (`CASE_DEF_ID_`),
                                         KEY `ACT_IDX_CASE_INST_PARENT` (`PARENT_ID_`),
                                         KEY `ACT_IDX_CASE_INST_REF_ID_` (`REFERENCE_ID_`),
                                         CONSTRAINT `ACT_FK_CASE_INST_CASE_DEF` FOREIGN KEY (`CASE_DEF_ID_`) REFERENCES `act_cmmn_casedef` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of act_cmmn_ru_case_inst
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for act_cmmn_ru_mil_inst
-- ----------------------------
DROP TABLE IF EXISTS `act_cmmn_ru_mil_inst`;
CREATE TABLE `act_cmmn_ru_mil_inst` (
                                        `ID_` varchar(255) NOT NULL,
                                        `NAME_` varchar(255) NOT NULL,
                                        `TIME_STAMP_` datetime(3) DEFAULT NULL,
                                        `CASE_INST_ID_` varchar(255) NOT NULL,
                                        `CASE_DEF_ID_` varchar(255) NOT NULL,
                                        `ELEMENT_ID_` varchar(255) NOT NULL,
                                        `TENANT_ID_` varchar(255) DEFAULT '',
                                        PRIMARY KEY (`ID_`),
                                        KEY `ACT_IDX_MIL_CASE_DEF` (`CASE_DEF_ID_`),
                                        KEY `ACT_IDX_MIL_CASE_INST` (`CASE_INST_ID_`),
                                        CONSTRAINT `ACT_FK_MIL_CASE_DEF` FOREIGN KEY (`CASE_DEF_ID_`) REFERENCES `act_cmmn_casedef` (`ID_`),
                                        CONSTRAINT `ACT_FK_MIL_CASE_INST` FOREIGN KEY (`CASE_INST_ID_`) REFERENCES `act_cmmn_ru_case_inst` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of act_cmmn_ru_mil_inst
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for act_cmmn_ru_plan_item_inst
-- ----------------------------
DROP TABLE IF EXISTS `act_cmmn_ru_plan_item_inst`;
CREATE TABLE `act_cmmn_ru_plan_item_inst` (
                                              `ID_` varchar(255) NOT NULL,
                                              `REV_` int NOT NULL,
                                              `CASE_DEF_ID_` varchar(255) DEFAULT NULL,
                                              `CASE_INST_ID_` varchar(255) DEFAULT NULL,
                                              `STAGE_INST_ID_` varchar(255) DEFAULT NULL,
                                              `IS_STAGE_` bit(1) DEFAULT NULL,
                                              `ELEMENT_ID_` varchar(255) DEFAULT NULL,
                                              `NAME_` varchar(255) DEFAULT NULL,
                                              `STATE_` varchar(255) DEFAULT NULL,
                                              `CREATE_TIME_` datetime(3) DEFAULT NULL,
                                              `START_USER_ID_` varchar(255) DEFAULT NULL,
                                              `REFERENCE_ID_` varchar(255) DEFAULT NULL,
                                              `REFERENCE_TYPE_` varchar(255) DEFAULT NULL,
                                              `TENANT_ID_` varchar(255) DEFAULT '',
                                              `ITEM_DEFINITION_ID_` varchar(255) DEFAULT NULL,
                                              `ITEM_DEFINITION_TYPE_` varchar(255) DEFAULT NULL,
                                              `IS_COMPLETEABLE_` bit(1) DEFAULT NULL,
                                              `IS_COUNT_ENABLED_` bit(1) DEFAULT NULL,
                                              `VAR_COUNT_` int DEFAULT NULL,
                                              `SENTRY_PART_INST_COUNT_` int DEFAULT NULL,
                                              `LAST_AVAILABLE_TIME_` datetime(3) DEFAULT NULL,
                                              `LAST_ENABLED_TIME_` datetime(3) DEFAULT NULL,
                                              `LAST_DISABLED_TIME_` datetime(3) DEFAULT NULL,
                                              `LAST_STARTED_TIME_` datetime(3) DEFAULT NULL,
                                              `LAST_SUSPENDED_TIME_` datetime(3) DEFAULT NULL,
                                              `COMPLETED_TIME_` datetime(3) DEFAULT NULL,
                                              `OCCURRED_TIME_` datetime(3) DEFAULT NULL,
                                              `TERMINATED_TIME_` datetime(3) DEFAULT NULL,
                                              `EXIT_TIME_` datetime(3) DEFAULT NULL,
                                              `ENDED_TIME_` datetime(3) DEFAULT NULL,
                                              `ENTRY_CRITERION_ID_` varchar(255) DEFAULT NULL,
                                              `EXIT_CRITERION_ID_` varchar(255) DEFAULT NULL,
                                              `EXTRA_VALUE_` varchar(255) DEFAULT NULL,
                                              `DERIVED_CASE_DEF_ID_` varchar(255) DEFAULT NULL,
                                              `LAST_UNAVAILABLE_TIME_` datetime(3) DEFAULT NULL,
                                              PRIMARY KEY (`ID_`),
                                              KEY `ACT_IDX_PLAN_ITEM_CASE_DEF` (`CASE_DEF_ID_`),
                                              KEY `ACT_IDX_PLAN_ITEM_CASE_INST` (`CASE_INST_ID_`),
                                              KEY `ACT_IDX_PLAN_ITEM_STAGE_INST` (`STAGE_INST_ID_`),
                                              CONSTRAINT `ACT_FK_PLAN_ITEM_CASE_DEF` FOREIGN KEY (`CASE_DEF_ID_`) REFERENCES `act_cmmn_casedef` (`ID_`),
                                              CONSTRAINT `ACT_FK_PLAN_ITEM_CASE_INST` FOREIGN KEY (`CASE_INST_ID_`) REFERENCES `act_cmmn_ru_case_inst` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of act_cmmn_ru_plan_item_inst
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for act_cmmn_ru_sentry_part_inst
-- ----------------------------
DROP TABLE IF EXISTS `act_cmmn_ru_sentry_part_inst`;
CREATE TABLE `act_cmmn_ru_sentry_part_inst` (
                                                `ID_` varchar(255) NOT NULL,
                                                `REV_` int NOT NULL,
                                                `CASE_DEF_ID_` varchar(255) DEFAULT NULL,
                                                `CASE_INST_ID_` varchar(255) DEFAULT NULL,
                                                `PLAN_ITEM_INST_ID_` varchar(255) DEFAULT NULL,
                                                `ON_PART_ID_` varchar(255) DEFAULT NULL,
                                                `IF_PART_ID_` varchar(255) DEFAULT NULL,
                                                `TIME_STAMP_` datetime(3) DEFAULT NULL,
                                                PRIMARY KEY (`ID_`),
                                                KEY `ACT_IDX_SENTRY_CASE_DEF` (`CASE_DEF_ID_`),
                                                KEY `ACT_IDX_SENTRY_CASE_INST` (`CASE_INST_ID_`),
                                                KEY `ACT_IDX_SENTRY_PLAN_ITEM` (`PLAN_ITEM_INST_ID_`),
                                                CONSTRAINT `ACT_FK_SENTRY_CASE_DEF` FOREIGN KEY (`CASE_DEF_ID_`) REFERENCES `act_cmmn_casedef` (`ID_`),
                                                CONSTRAINT `ACT_FK_SENTRY_CASE_INST` FOREIGN KEY (`CASE_INST_ID_`) REFERENCES `act_cmmn_ru_case_inst` (`ID_`),
                                                CONSTRAINT `ACT_FK_SENTRY_PLAN_ITEM` FOREIGN KEY (`PLAN_ITEM_INST_ID_`) REFERENCES `act_cmmn_ru_plan_item_inst` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of act_cmmn_ru_sentry_part_inst
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for act_co_content_item
-- ----------------------------
DROP TABLE IF EXISTS `act_co_content_item`;
CREATE TABLE `act_co_content_item` (
                                       `ID_` varchar(255) NOT NULL,
                                       `NAME_` varchar(255) NOT NULL,
                                       `MIME_TYPE_` varchar(255) DEFAULT NULL,
                                       `TASK_ID_` varchar(255) DEFAULT NULL,
                                       `PROC_INST_ID_` varchar(255) DEFAULT NULL,
                                       `CONTENT_STORE_ID_` varchar(255) DEFAULT NULL,
                                       `CONTENT_STORE_NAME_` varchar(255) DEFAULT NULL,
                                       `FIELD_` varchar(400) DEFAULT NULL,
                                       `CONTENT_AVAILABLE_` bit(1) DEFAULT b'0',
                                       `CREATED_` timestamp(6) NULL DEFAULT NULL,
                                       `CREATED_BY_` varchar(255) DEFAULT NULL,
                                       `LAST_MODIFIED_` timestamp(6) NULL DEFAULT NULL,
                                       `LAST_MODIFIED_BY_` varchar(255) DEFAULT NULL,
                                       `CONTENT_SIZE_` bigint DEFAULT '0',
                                       `TENANT_ID_` varchar(255) DEFAULT NULL,
                                       `SCOPE_ID_` varchar(255) DEFAULT NULL,
                                       `SCOPE_TYPE_` varchar(255) DEFAULT NULL,
                                       PRIMARY KEY (`ID_`),
                                       KEY `idx_contitem_taskid` (`TASK_ID_`),
                                       KEY `idx_contitem_procid` (`PROC_INST_ID_`),
                                       KEY `idx_contitem_scope` (`SCOPE_ID_`,`SCOPE_TYPE_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of act_co_content_item
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for act_co_databasechangelog
-- ----------------------------
DROP TABLE IF EXISTS `act_co_databasechangelog`;
CREATE TABLE `act_co_databasechangelog` (
                                            `ID` varchar(255) NOT NULL,
                                            `AUTHOR` varchar(255) NOT NULL,
                                            `FILENAME` varchar(255) NOT NULL,
                                            `DATEEXECUTED` datetime NOT NULL,
                                            `ORDEREXECUTED` int NOT NULL,
                                            `EXECTYPE` varchar(10) NOT NULL,
                                            `MD5SUM` varchar(35) DEFAULT NULL,
                                            `DESCRIPTION` varchar(255) DEFAULT NULL,
                                            `COMMENTS` varchar(255) DEFAULT NULL,
                                            `TAG` varchar(255) DEFAULT NULL,
                                            `LIQUIBASE` varchar(20) DEFAULT NULL,
                                            `CONTEXTS` varchar(255) DEFAULT NULL,
                                            `LABELS` varchar(255) DEFAULT NULL,
                                            `DEPLOYMENT_ID` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of act_co_databasechangelog
-- ----------------------------
BEGIN;
INSERT INTO `act_co_databasechangelog` (`ID`, `AUTHOR`, `FILENAME`, `DATEEXECUTED`, `ORDEREXECUTED`, `EXECTYPE`, `MD5SUM`, `DESCRIPTION`, `COMMENTS`, `TAG`, `LIQUIBASE`, `CONTEXTS`, `LABELS`, `DEPLOYMENT_ID`) VALUES ('1', 'activiti', 'org/flowable/content/db/liquibase/flowable-content-db-changelog.xml', '2022-01-12 07:20:41', 1, 'EXECUTED', '8:7644d7165cfe799200a2abdd3419e8b6', 'createTable tableName=ACT_CO_CONTENT_ITEM; createIndex indexName=idx_contitem_taskid, tableName=ACT_CO_CONTENT_ITEM; createIndex indexName=idx_contitem_procid, tableName=ACT_CO_CONTENT_ITEM', '', NULL, '3.8.9', NULL, NULL, '1972041334');
INSERT INTO `act_co_databasechangelog` (`ID`, `AUTHOR`, `FILENAME`, `DATEEXECUTED`, `ORDEREXECUTED`, `EXECTYPE`, `MD5SUM`, `DESCRIPTION`, `COMMENTS`, `TAG`, `LIQUIBASE`, `CONTEXTS`, `LABELS`, `DEPLOYMENT_ID`) VALUES ('2', 'flowable', 'org/flowable/content/db/liquibase/flowable-content-db-changelog.xml', '2022-01-12 07:20:41', 2, 'EXECUTED', '8:fe7b11ac7dbbf9c43006b23bbab60bab', 'addColumn tableName=ACT_CO_CONTENT_ITEM; createIndex indexName=idx_contitem_scope, tableName=ACT_CO_CONTENT_ITEM', '', NULL, '3.8.9', NULL, NULL, '1972041334');
COMMIT;

-- ----------------------------
-- Table structure for act_co_databasechangeloglock
-- ----------------------------
DROP TABLE IF EXISTS `act_co_databasechangeloglock`;
CREATE TABLE `act_co_databasechangeloglock` (
                                                `ID` int NOT NULL,
                                                `LOCKED` bit(1) NOT NULL,
                                                `LOCKGRANTED` datetime DEFAULT NULL,
                                                `LOCKEDBY` varchar(255) DEFAULT NULL,
                                                PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of act_co_databasechangeloglock
-- ----------------------------
BEGIN;
INSERT INTO `act_co_databasechangeloglock` (`ID`, `LOCKED`, `LOCKGRANTED`, `LOCKEDBY`) VALUES (1, b'0', NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for act_dmn_databasechangelog
-- ----------------------------
DROP TABLE IF EXISTS `act_dmn_databasechangelog`;
CREATE TABLE `act_dmn_databasechangelog` (
                                             `ID` varchar(255) NOT NULL,
                                             `AUTHOR` varchar(255) NOT NULL,
                                             `FILENAME` varchar(255) NOT NULL,
                                             `DATEEXECUTED` datetime NOT NULL,
                                             `ORDEREXECUTED` int NOT NULL,
                                             `EXECTYPE` varchar(10) NOT NULL,
                                             `MD5SUM` varchar(35) DEFAULT NULL,
                                             `DESCRIPTION` varchar(255) DEFAULT NULL,
                                             `COMMENTS` varchar(255) DEFAULT NULL,
                                             `TAG` varchar(255) DEFAULT NULL,
                                             `LIQUIBASE` varchar(20) DEFAULT NULL,
                                             `CONTEXTS` varchar(255) DEFAULT NULL,
                                             `LABELS` varchar(255) DEFAULT NULL,
                                             `DEPLOYMENT_ID` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of act_dmn_databasechangelog
-- ----------------------------
BEGIN;
INSERT INTO `act_dmn_databasechangelog` (`ID`, `AUTHOR`, `FILENAME`, `DATEEXECUTED`, `ORDEREXECUTED`, `EXECTYPE`, `MD5SUM`, `DESCRIPTION`, `COMMENTS`, `TAG`, `LIQUIBASE`, `CONTEXTS`, `LABELS`, `DEPLOYMENT_ID`) VALUES ('1', 'activiti', 'org/flowable/dmn/db/liquibase/flowable-dmn-db-changelog.xml', '2022-01-12 07:20:39', 1, 'EXECUTED', '8:c8701f1c71018b55029f450b2e9a10a1', 'createTable tableName=ACT_DMN_DEPLOYMENT; createTable tableName=ACT_DMN_DEPLOYMENT_RESOURCE; createTable tableName=ACT_DMN_DECISION_TABLE', '', NULL, '3.8.9', NULL, NULL, '1972039571');
INSERT INTO `act_dmn_databasechangelog` (`ID`, `AUTHOR`, `FILENAME`, `DATEEXECUTED`, `ORDEREXECUTED`, `EXECTYPE`, `MD5SUM`, `DESCRIPTION`, `COMMENTS`, `TAG`, `LIQUIBASE`, `CONTEXTS`, `LABELS`, `DEPLOYMENT_ID`) VALUES ('2', 'flowable', 'org/flowable/dmn/db/liquibase/flowable-dmn-db-changelog.xml', '2022-01-12 07:20:39', 2, 'EXECUTED', '8:47f94b27feb7df8a30d4e338c7bd5fb8', 'createTable tableName=ACT_DMN_HI_DECISION_EXECUTION', '', NULL, '3.8.9', NULL, NULL, '1972039571');
INSERT INTO `act_dmn_databasechangelog` (`ID`, `AUTHOR`, `FILENAME`, `DATEEXECUTED`, `ORDEREXECUTED`, `EXECTYPE`, `MD5SUM`, `DESCRIPTION`, `COMMENTS`, `TAG`, `LIQUIBASE`, `CONTEXTS`, `LABELS`, `DEPLOYMENT_ID`) VALUES ('3', 'flowable', 'org/flowable/dmn/db/liquibase/flowable-dmn-db-changelog.xml', '2022-01-12 07:20:39', 3, 'EXECUTED', '8:ac17eae89fbdccb6e08daf3c7797b579', 'addColumn tableName=ACT_DMN_HI_DECISION_EXECUTION', '', NULL, '3.8.9', NULL, NULL, '1972039571');
INSERT INTO `act_dmn_databasechangelog` (`ID`, `AUTHOR`, `FILENAME`, `DATEEXECUTED`, `ORDEREXECUTED`, `EXECTYPE`, `MD5SUM`, `DESCRIPTION`, `COMMENTS`, `TAG`, `LIQUIBASE`, `CONTEXTS`, `LABELS`, `DEPLOYMENT_ID`) VALUES ('4', 'flowable', 'org/flowable/dmn/db/liquibase/flowable-dmn-db-changelog.xml', '2022-01-12 07:20:39', 4, 'EXECUTED', '8:f73aabc4529e7292c2942073d1cff6f9', 'dropColumn columnName=PARENT_DEPLOYMENT_ID_, tableName=ACT_DMN_DECISION_TABLE', '', NULL, '3.8.9', NULL, NULL, '1972039571');
INSERT INTO `act_dmn_databasechangelog` (`ID`, `AUTHOR`, `FILENAME`, `DATEEXECUTED`, `ORDEREXECUTED`, `EXECTYPE`, `MD5SUM`, `DESCRIPTION`, `COMMENTS`, `TAG`, `LIQUIBASE`, `CONTEXTS`, `LABELS`, `DEPLOYMENT_ID`) VALUES ('5', 'flowable', 'org/flowable/dmn/db/liquibase/flowable-dmn-db-changelog.xml', '2022-01-12 07:20:40', 5, 'EXECUTED', '8:3e03528582dd4eeb4eb41f9b9539140d', 'modifyDataType columnName=DEPLOY_TIME_, tableName=ACT_DMN_DEPLOYMENT; modifyDataType columnName=START_TIME_, tableName=ACT_DMN_HI_DECISION_EXECUTION; modifyDataType columnName=END_TIME_, tableName=ACT_DMN_HI_DECISION_EXECUTION', '', NULL, '3.8.9', NULL, NULL, '1972039571');
INSERT INTO `act_dmn_databasechangelog` (`ID`, `AUTHOR`, `FILENAME`, `DATEEXECUTED`, `ORDEREXECUTED`, `EXECTYPE`, `MD5SUM`, `DESCRIPTION`, `COMMENTS`, `TAG`, `LIQUIBASE`, `CONTEXTS`, `LABELS`, `DEPLOYMENT_ID`) VALUES ('6', 'flowable', 'org/flowable/dmn/db/liquibase/flowable-dmn-db-changelog.xml', '2022-01-12 07:20:40', 6, 'EXECUTED', '8:646c6a061e0b6e8a62e69844ff96abb0', 'createIndex indexName=ACT_IDX_DEC_TBL_UNIQ, tableName=ACT_DMN_DECISION_TABLE', '', NULL, '3.8.9', NULL, NULL, '1972039571');
INSERT INTO `act_dmn_databasechangelog` (`ID`, `AUTHOR`, `FILENAME`, `DATEEXECUTED`, `ORDEREXECUTED`, `EXECTYPE`, `MD5SUM`, `DESCRIPTION`, `COMMENTS`, `TAG`, `LIQUIBASE`, `CONTEXTS`, `LABELS`, `DEPLOYMENT_ID`) VALUES ('7', 'flowable', 'org/flowable/dmn/db/liquibase/flowable-dmn-db-changelog.xml', '2022-01-12 07:20:40', 7, 'EXECUTED', '8:215a499ff7ae77685b55355245b8b708', 'dropIndex indexName=ACT_IDX_DEC_TBL_UNIQ, tableName=ACT_DMN_DECISION_TABLE; renameTable newTableName=ACT_DMN_DECISION, oldTableName=ACT_DMN_DECISION_TABLE; createIndex indexName=ACT_IDX_DMN_DEC_UNIQ, tableName=ACT_DMN_DECISION', '', NULL, '3.8.9', NULL, NULL, '1972039571');
INSERT INTO `act_dmn_databasechangelog` (`ID`, `AUTHOR`, `FILENAME`, `DATEEXECUTED`, `ORDEREXECUTED`, `EXECTYPE`, `MD5SUM`, `DESCRIPTION`, `COMMENTS`, `TAG`, `LIQUIBASE`, `CONTEXTS`, `LABELS`, `DEPLOYMENT_ID`) VALUES ('8', 'flowable', 'org/flowable/dmn/db/liquibase/flowable-dmn-db-changelog.xml', '2022-01-12 07:20:40', 8, 'EXECUTED', '8:5355bee389318afed91a11702f2df032', 'addColumn tableName=ACT_DMN_DECISION', '', NULL, '3.8.9', NULL, NULL, '1972039571');
INSERT INTO `act_dmn_databasechangelog` (`ID`, `AUTHOR`, `FILENAME`, `DATEEXECUTED`, `ORDEREXECUTED`, `EXECTYPE`, `MD5SUM`, `DESCRIPTION`, `COMMENTS`, `TAG`, `LIQUIBASE`, `CONTEXTS`, `LABELS`, `DEPLOYMENT_ID`) VALUES ('9', 'flowable', 'org/flowable/dmn/db/liquibase/flowable-dmn-db-changelog.xml', '2023-09-06 01:36:24', 9, 'EXECUTED', '8:0fe82086431b1953d293f0199f805876', 'createIndex indexName=ACT_IDX_DMN_INSTANCE_ID, tableName=ACT_DMN_HI_DECISION_EXECUTION', '', NULL, '4.20.0', NULL, NULL, '3964184334');
COMMIT;

-- ----------------------------
-- Table structure for act_dmn_databasechangeloglock
-- ----------------------------
DROP TABLE IF EXISTS `act_dmn_databasechangeloglock`;
CREATE TABLE `act_dmn_databasechangeloglock` (
                                                 `ID` int NOT NULL,
                                                 `LOCKED` bit(1) NOT NULL,
                                                 `LOCKGRANTED` datetime DEFAULT NULL,
                                                 `LOCKEDBY` varchar(255) DEFAULT NULL,
                                                 PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of act_dmn_databasechangeloglock
-- ----------------------------
BEGIN;
INSERT INTO `act_dmn_databasechangeloglock` (`ID`, `LOCKED`, `LOCKGRANTED`, `LOCKEDBY`) VALUES (1, b'0', NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for act_dmn_decision
-- ----------------------------
DROP TABLE IF EXISTS `act_dmn_decision`;
CREATE TABLE `act_dmn_decision` (
                                    `ID_` varchar(255) NOT NULL,
                                    `NAME_` varchar(255) DEFAULT NULL,
                                    `VERSION_` int DEFAULT NULL,
                                    `KEY_` varchar(255) DEFAULT NULL,
                                    `CATEGORY_` varchar(255) DEFAULT NULL,
                                    `DEPLOYMENT_ID_` varchar(255) DEFAULT NULL,
                                    `TENANT_ID_` varchar(255) DEFAULT NULL,
                                    `RESOURCE_NAME_` varchar(255) DEFAULT NULL,
                                    `DESCRIPTION_` varchar(255) DEFAULT NULL,
                                    `DECISION_TYPE_` varchar(255) DEFAULT NULL,
                                    PRIMARY KEY (`ID_`),
                                    UNIQUE KEY `ACT_IDX_DMN_DEC_UNIQ` (`KEY_`,`VERSION_`,`TENANT_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of act_dmn_decision
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for act_dmn_deployment
-- ----------------------------
DROP TABLE IF EXISTS `act_dmn_deployment`;
CREATE TABLE `act_dmn_deployment` (
                                      `ID_` varchar(255) NOT NULL,
                                      `NAME_` varchar(255) DEFAULT NULL,
                                      `CATEGORY_` varchar(255) DEFAULT NULL,
                                      `DEPLOY_TIME_` datetime(3) DEFAULT NULL,
                                      `TENANT_ID_` varchar(255) DEFAULT NULL,
                                      `PARENT_DEPLOYMENT_ID_` varchar(255) DEFAULT NULL,
                                      PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of act_dmn_deployment
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for act_dmn_deployment_resource
-- ----------------------------
DROP TABLE IF EXISTS `act_dmn_deployment_resource`;
CREATE TABLE `act_dmn_deployment_resource` (
                                               `ID_` varchar(255) NOT NULL,
                                               `NAME_` varchar(255) DEFAULT NULL,
                                               `DEPLOYMENT_ID_` varchar(255) DEFAULT NULL,
                                               `RESOURCE_BYTES_` longblob,
                                               PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of act_dmn_deployment_resource
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for act_dmn_hi_decision_execution
-- ----------------------------
DROP TABLE IF EXISTS `act_dmn_hi_decision_execution`;
CREATE TABLE `act_dmn_hi_decision_execution` (
                                                 `ID_` varchar(255) NOT NULL,
                                                 `DECISION_DEFINITION_ID_` varchar(255) DEFAULT NULL,
                                                 `DEPLOYMENT_ID_` varchar(255) DEFAULT NULL,
                                                 `START_TIME_` datetime(3) DEFAULT NULL,
                                                 `END_TIME_` datetime(3) DEFAULT NULL,
                                                 `INSTANCE_ID_` varchar(255) DEFAULT NULL,
                                                 `EXECUTION_ID_` varchar(255) DEFAULT NULL,
                                                 `ACTIVITY_ID_` varchar(255) DEFAULT NULL,
                                                 `FAILED_` bit(1) DEFAULT b'0',
                                                 `TENANT_ID_` varchar(255) DEFAULT NULL,
                                                 `EXECUTION_JSON_` longtext,
                                                 `SCOPE_TYPE_` varchar(255) DEFAULT NULL,
                                                 PRIMARY KEY (`ID_`),
                                                 KEY `ACT_IDX_DMN_INSTANCE_ID` (`INSTANCE_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of act_dmn_hi_decision_execution
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for act_evt_log
-- ----------------------------
DROP TABLE IF EXISTS `act_evt_log`;
CREATE TABLE `act_evt_log` (
                               `LOG_NR_` bigint NOT NULL AUTO_INCREMENT,
                               `TYPE_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                               `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                               `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                               `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                               `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                               `TIME_STAMP_` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
                               `USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                               `DATA_` longblob,
                               `LOCK_OWNER_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                               `LOCK_TIME_` timestamp(3) NULL DEFAULT NULL,
                               `IS_PROCESSED_` tinyint DEFAULT '0',
                               PRIMARY KEY (`LOG_NR_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_evt_log
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for act_fo_databasechangelog
-- ----------------------------
DROP TABLE IF EXISTS `act_fo_databasechangelog`;
CREATE TABLE `act_fo_databasechangelog` (
                                            `ID` varchar(255) NOT NULL,
                                            `AUTHOR` varchar(255) NOT NULL,
                                            `FILENAME` varchar(255) NOT NULL,
                                            `DATEEXECUTED` datetime NOT NULL,
                                            `ORDEREXECUTED` int NOT NULL,
                                            `EXECTYPE` varchar(10) NOT NULL,
                                            `MD5SUM` varchar(35) DEFAULT NULL,
                                            `DESCRIPTION` varchar(255) DEFAULT NULL,
                                            `COMMENTS` varchar(255) DEFAULT NULL,
                                            `TAG` varchar(255) DEFAULT NULL,
                                            `LIQUIBASE` varchar(20) DEFAULT NULL,
                                            `CONTEXTS` varchar(255) DEFAULT NULL,
                                            `LABELS` varchar(255) DEFAULT NULL,
                                            `DEPLOYMENT_ID` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of act_fo_databasechangelog
-- ----------------------------
BEGIN;
INSERT INTO `act_fo_databasechangelog` (`ID`, `AUTHOR`, `FILENAME`, `DATEEXECUTED`, `ORDEREXECUTED`, `EXECTYPE`, `MD5SUM`, `DESCRIPTION`, `COMMENTS`, `TAG`, `LIQUIBASE`, `CONTEXTS`, `LABELS`, `DEPLOYMENT_ID`) VALUES ('1', 'activiti', 'org/flowable/form/db/liquibase/flowable-form-db-changelog.xml', '2022-01-12 07:20:40', 1, 'EXECUTED', '8:033ebf9380889aed7c453927ecc3250d', 'createTable tableName=ACT_FO_FORM_DEPLOYMENT; createTable tableName=ACT_FO_FORM_RESOURCE; createTable tableName=ACT_FO_FORM_DEFINITION; createTable tableName=ACT_FO_FORM_INSTANCE', '', NULL, '3.8.9', NULL, NULL, '1972040535');
INSERT INTO `act_fo_databasechangelog` (`ID`, `AUTHOR`, `FILENAME`, `DATEEXECUTED`, `ORDEREXECUTED`, `EXECTYPE`, `MD5SUM`, `DESCRIPTION`, `COMMENTS`, `TAG`, `LIQUIBASE`, `CONTEXTS`, `LABELS`, `DEPLOYMENT_ID`) VALUES ('2', 'flowable', 'org/flowable/form/db/liquibase/flowable-form-db-changelog.xml', '2022-01-12 07:20:40', 2, 'EXECUTED', '8:986365ceb40445ce3b27a8e6b40f159b', 'addColumn tableName=ACT_FO_FORM_INSTANCE', '', NULL, '3.8.9', NULL, NULL, '1972040535');
INSERT INTO `act_fo_databasechangelog` (`ID`, `AUTHOR`, `FILENAME`, `DATEEXECUTED`, `ORDEREXECUTED`, `EXECTYPE`, `MD5SUM`, `DESCRIPTION`, `COMMENTS`, `TAG`, `LIQUIBASE`, `CONTEXTS`, `LABELS`, `DEPLOYMENT_ID`) VALUES ('3', 'flowable', 'org/flowable/form/db/liquibase/flowable-form-db-changelog.xml', '2022-01-12 07:20:40', 3, 'EXECUTED', '8:abf482518ceb09830ef674e52c06bf15', 'dropColumn columnName=PARENT_DEPLOYMENT_ID_, tableName=ACT_FO_FORM_DEFINITION', '', NULL, '3.8.9', NULL, NULL, '1972040535');
INSERT INTO `act_fo_databasechangelog` (`ID`, `AUTHOR`, `FILENAME`, `DATEEXECUTED`, `ORDEREXECUTED`, `EXECTYPE`, `MD5SUM`, `DESCRIPTION`, `COMMENTS`, `TAG`, `LIQUIBASE`, `CONTEXTS`, `LABELS`, `DEPLOYMENT_ID`) VALUES ('4', 'flowable', 'org/flowable/form/db/liquibase/flowable-form-db-changelog.xml', '2022-01-12 07:20:40', 4, 'EXECUTED', '8:2087829f22a4b2298dbf530681c74854', 'modifyDataType columnName=DEPLOY_TIME_, tableName=ACT_FO_FORM_DEPLOYMENT; modifyDataType columnName=SUBMITTED_DATE_, tableName=ACT_FO_FORM_INSTANCE', '', NULL, '3.8.9', NULL, NULL, '1972040535');
INSERT INTO `act_fo_databasechangelog` (`ID`, `AUTHOR`, `FILENAME`, `DATEEXECUTED`, `ORDEREXECUTED`, `EXECTYPE`, `MD5SUM`, `DESCRIPTION`, `COMMENTS`, `TAG`, `LIQUIBASE`, `CONTEXTS`, `LABELS`, `DEPLOYMENT_ID`) VALUES ('5', 'flowable', 'org/flowable/form/db/liquibase/flowable-form-db-changelog.xml', '2022-01-12 07:20:41', 5, 'EXECUTED', '8:b4be732b89e5ca028bdd520c6ad4d446', 'createIndex indexName=ACT_IDX_FORM_DEF_UNIQ, tableName=ACT_FO_FORM_DEFINITION', '', NULL, '3.8.9', NULL, NULL, '1972040535');
INSERT INTO `act_fo_databasechangelog` (`ID`, `AUTHOR`, `FILENAME`, `DATEEXECUTED`, `ORDEREXECUTED`, `EXECTYPE`, `MD5SUM`, `DESCRIPTION`, `COMMENTS`, `TAG`, `LIQUIBASE`, `CONTEXTS`, `LABELS`, `DEPLOYMENT_ID`) VALUES ('6', 'flowable', 'org/flowable/form/db/liquibase/flowable-form-db-changelog.xml', '2022-01-12 07:20:41', 6, 'EXECUTED', '8:384bbd364a649b67c3ca1bcb72fe537f', 'createIndex indexName=ACT_IDX_FORM_TASK, tableName=ACT_FO_FORM_INSTANCE; createIndex indexName=ACT_IDX_FORM_PROC, tableName=ACT_FO_FORM_INSTANCE; createIndex indexName=ACT_IDX_FORM_SCOPE, tableName=ACT_FO_FORM_INSTANCE', '', NULL, '3.8.9', NULL, NULL, '1972040535');
COMMIT;

-- ----------------------------
-- Table structure for act_fo_databasechangeloglock
-- ----------------------------
DROP TABLE IF EXISTS `act_fo_databasechangeloglock`;
CREATE TABLE `act_fo_databasechangeloglock` (
                                                `ID` int NOT NULL,
                                                `LOCKED` bit(1) NOT NULL,
                                                `LOCKGRANTED` datetime DEFAULT NULL,
                                                `LOCKEDBY` varchar(255) DEFAULT NULL,
                                                PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of act_fo_databasechangeloglock
-- ----------------------------
BEGIN;
INSERT INTO `act_fo_databasechangeloglock` (`ID`, `LOCKED`, `LOCKGRANTED`, `LOCKEDBY`) VALUES (1, b'0', NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for act_fo_form_definition
-- ----------------------------
DROP TABLE IF EXISTS `act_fo_form_definition`;
CREATE TABLE `act_fo_form_definition` (
                                          `ID_` varchar(255) NOT NULL,
                                          `NAME_` varchar(255) DEFAULT NULL,
                                          `VERSION_` int DEFAULT NULL,
                                          `KEY_` varchar(255) DEFAULT NULL,
                                          `CATEGORY_` varchar(255) DEFAULT NULL,
                                          `DEPLOYMENT_ID_` varchar(255) DEFAULT NULL,
                                          `TENANT_ID_` varchar(255) DEFAULT NULL,
                                          `RESOURCE_NAME_` varchar(255) DEFAULT NULL,
                                          `DESCRIPTION_` varchar(255) DEFAULT NULL,
                                          PRIMARY KEY (`ID_`),
                                          UNIQUE KEY `ACT_IDX_FORM_DEF_UNIQ` (`KEY_`,`VERSION_`,`TENANT_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of act_fo_form_definition
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for act_fo_form_deployment
-- ----------------------------
DROP TABLE IF EXISTS `act_fo_form_deployment`;
CREATE TABLE `act_fo_form_deployment` (
                                          `ID_` varchar(255) NOT NULL,
                                          `NAME_` varchar(255) DEFAULT NULL,
                                          `CATEGORY_` varchar(255) DEFAULT NULL,
                                          `DEPLOY_TIME_` datetime(3) DEFAULT NULL,
                                          `TENANT_ID_` varchar(255) DEFAULT NULL,
                                          `PARENT_DEPLOYMENT_ID_` varchar(255) DEFAULT NULL,
                                          PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of act_fo_form_deployment
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for act_fo_form_instance
-- ----------------------------
DROP TABLE IF EXISTS `act_fo_form_instance`;
CREATE TABLE `act_fo_form_instance` (
                                        `ID_` varchar(255) NOT NULL,
                                        `FORM_DEFINITION_ID_` varchar(255) NOT NULL,
                                        `TASK_ID_` varchar(255) DEFAULT NULL,
                                        `PROC_INST_ID_` varchar(255) DEFAULT NULL,
                                        `PROC_DEF_ID_` varchar(255) DEFAULT NULL,
                                        `SUBMITTED_DATE_` datetime(3) DEFAULT NULL,
                                        `SUBMITTED_BY_` varchar(255) DEFAULT NULL,
                                        `FORM_VALUES_ID_` varchar(255) DEFAULT NULL,
                                        `TENANT_ID_` varchar(255) DEFAULT NULL,
                                        `SCOPE_ID_` varchar(255) DEFAULT NULL,
                                        `SCOPE_TYPE_` varchar(255) DEFAULT NULL,
                                        `SCOPE_DEFINITION_ID_` varchar(255) DEFAULT NULL,
                                        PRIMARY KEY (`ID_`),
                                        KEY `ACT_IDX_FORM_TASK` (`TASK_ID_`),
                                        KEY `ACT_IDX_FORM_PROC` (`PROC_INST_ID_`),
                                        KEY `ACT_IDX_FORM_SCOPE` (`SCOPE_ID_`,`SCOPE_TYPE_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of act_fo_form_instance
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for act_fo_form_resource
-- ----------------------------
DROP TABLE IF EXISTS `act_fo_form_resource`;
CREATE TABLE `act_fo_form_resource` (
                                        `ID_` varchar(255) NOT NULL,
                                        `NAME_` varchar(255) DEFAULT NULL,
                                        `DEPLOYMENT_ID_` varchar(255) DEFAULT NULL,
                                        `RESOURCE_BYTES_` longblob,
                                        PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of act_fo_form_resource
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for act_ge_bytearray
-- ----------------------------
DROP TABLE IF EXISTS `act_ge_bytearray`;
CREATE TABLE `act_ge_bytearray` (
                                    `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                    `REV_` int DEFAULT NULL,
                                    `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                    `DEPLOYMENT_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                    `BYTES_` longblob,
                                    `GENERATED_` tinyint DEFAULT NULL,
                                    PRIMARY KEY (`ID_`),
                                    KEY `ACT_FK_BYTEARR_DEPL` (`DEPLOYMENT_ID_`),
                                    CONSTRAINT `ACT_FK_BYTEARR_DEPL` FOREIGN KEY (`DEPLOYMENT_ID_`) REFERENCES `act_re_deployment` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_ge_bytearray
-- ----------------------------
BEGIN;
INSERT INTO `act_ge_bytearray` (`ID_`, `REV_`, `NAME_`, `DEPLOYMENT_ID_`, `BYTES_`, `GENERATED_`) VALUES ('11889ab1-b33f-11ed-b511-ce4fe10f37b8', 1, 'var-leavetime', NULL, 0xACED0005737200136A6176612E7574696C2E41727261794C6973747881D21D99C7619D03000149000473697A6578700000000277040000000274000A323032332D30322D323374000A323032332D30322D323478, NULL);
INSERT INTO `act_ge_bytearray` (`ID_`, `REV_`, `NAME_`, `DEPLOYMENT_ID_`, `BYTES_`, `GENERATED_`) VALUES ('11889ab3-b33f-11ed-b511-ce4fe10f37b8', 1, 'hist.var-leavetime', NULL, 0xACED0005737200136A6176612E7574696C2E41727261794C6973747881D21D99C7619D03000149000473697A6578700000000277040000000274000A323032332D30322D323374000A323032332D30322D323478, NULL);
INSERT INTO `act_ge_bytearray` (`ID_`, `REV_`, `NAME_`, `DEPLOYMENT_ID_`, `BYTES_`, `GENERATED_`) VALUES ('1188c1c6-b33f-11ed-b511-ce4fe10f37b8', 1, 'var-variables', NULL, 0xACED0005737200176A6176612E7574696C2E4C696E6B6564486173684D617034C04E5C106CC0FB0200015A000B6163636573734F72646572787200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000B740007666F726D5265667400056C65617665740006677574746572737200116A6176612E6C616E672E496E746567657212E2A0A4F781873802000149000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B02000078700000000F74000473697A657400066D656469756D740009666F726D52756C657374000572756C657374000D6C6162656C506F736974696F6E7400057269676874740008666F726D42746E73737200116A6176612E6C616E672E426F6F6C65616ECD207280D59CFAEE0200015A000576616C756578700074000A6C6162656C57696474687371007E00060000006474000864697361626C65647371007E001001740009666F726D4D6F64656C7400096C65617665466F726D7400066669656C6473737200136A6176612E7574696C2E41727261794C6973747881D21D99C7619D03000149000473697A657870000000037704000000037371007E00003F4000000000000C7708000000100000000C740009636C65617261626C6571007E001574000A5F5F636F6E6669675F5F7371007E00003F400000000000187708000000200000000E740006666F726D49647371007E00060000006574000C64656661756C7456616C75657371007E00190000000277040000000274000A323032332D30322D323374000A323032332D30322D323478740008646F63756D656E7474003668747470733A2F2F656C656D656E742E656C656D652E636E2F232F7A682D434E2F636F6D706F6E656E742F646174652D7069636B657271007E0012707400056C6162656C74000CE8AFB7E58187E697B6E997B474000973686F774C6162656C71007E0015740008726571756972656471007E001574000972656E6465724B6579740010313031313634323133383830383939347400066C61796F757474000B636F6C466F726D4974656D74000774616749636F6E74000A646174652D72616E67657400096368616E676554616771007E001574000374616774000E656C2D646174652D7069636B65727400077265674C6973747371007E0019000000017704000000017371007E00003F4000000000000C7708000000100000000371007E002A71007E00157400076D657373616765740018E8AFB7E58187E697B6E997B4E4B88DE883BDE4B8BAE7A9BA740007747269676765727400066368616E67657800787400047370616E7371007E000600000018780074000F72616E67652D736570617261746F72740003E887B3740008726561646F6E6C7971007E001174001173746172742D706C616365686F6C64657274000CE5BC80E5A78BE697A5E69C9F740006666F726D617474000A797979792D4D4D2D646474000C76616C75652D666F726D617474000A797979792D4D4D2D646474000A5F5F764D6F64656C5F5F7400096C6561766574696D657400057374796C657371007E00003F4000000000000177080000000200000001740005776964746874000431303025780071007E001471007E0011740004747970657400096461746572616E676574000F656E642D706C616365686F6C64657274000CE7BB93E69D9FE697A5E69C9F78007371007E00003F4000000000000C7708000000100000000974000A66696C74657261626C6571007E001171007E001C71007E001571007E001D7371007E00003F400000000000187708000000200000000E71007E001F7371007E00060000006671007E002574003168747470733A2F2F656C656D656E742E656C656D652E636E2F232F7A682D434E2F636F6D706F6E656E742F73656C65637471007E00127071007E002774000CE8AFB7E58187E7B1BBE59E8B71007E002971007E001571007E002A71007E001571007E002B7400103130323136343231333837383439313071007E002D74000B636F6C466F726D4974656D71007E002F74000673656C65637471007E003171007E001571007E0032740009656C2D73656C65637471007E00347371007E0019000000017704000000017371007E00003F4000000000000C7708000000100000000371007E002A71007E001571007E0037740012E98089E68BA9E8AFB7E58187E7B1BBE59E8B71007E00397400066368616E676578007871007E003B71007E003C71007E00217371007E00060000000178007400086D756C7469706C6571007E001171007E00467400096C656176657479706571007E00487371007E00003F400000000000017708000000020000000171007E004A74000431303025780071007E001471007E001174000B706C616365686F6C646572740012E98089E68BA9E8AFB7E58187E7B1BBE59E8B7400085F5F736C6F745F5F7371007E00003F40000000000001770800000002000000017400076F7074696F6E737371007E0019000000027704000000027371007E00003F400000000000037708000000040000000271007E0027740006E5B9B4E5818774000576616C756571007E005E78007371007E00003F400000000000037708000000040000000271007E0027740006E8B083E4BC9171007E006B7371007E000600000002780078780078007371007E00003F4000000000000C7708000000100000000A71007E001D7371007E00003F400000000000187708000000200000000E71007E001F71007E002071007E002574003068747470733A2F2F656C656D656E742E656C656D652E636E2F232F7A682D434E2F636F6D706F6E656E742F696E70757471007E00127071007E002774000CE8AFB7E58187E4BA8BE794B171007E002971007E001571007E002A71007E001571007E002B7400103130313136343231333837323630383771007E002D74000B636F6C466F726D4974656D71007E002F740008746578746172656171007E003171007E001571007E0032740008656C2D696E70757471007E00347371007E0019000000017704000000017371007E00003F4000000000000C7708000000100000000371007E002A71007E001571007E0037740015E8AFB7E8BE93E585A5E8AFB7E58187E4BA8BE794B171007E0039740004626C757278007871007E003B71007E003C71007E0021740003313131780071007E003F71007E00117400096D61786C656E6774687071007E004674000B6C65617665726561736F6E71007E00487371007E00003F400000000000017708000000020000000171007E004A74000431303025780071007E001471007E001171007E0063740015E8AFB7E8BE93E585A5E8AFB7E58187E4BA8BE794B174000F73686F772D776F72642D6C696D697471007E001171007E004C74000874657874617265617400086175746F73697A657371007E00003F40000000000003770800000004000000027400076D696E526F77737371007E0006000000047400076D6178526F777371007E0086780078007871007E003B71007E003C7800, NULL);
INSERT INTO `act_ge_bytearray` (`ID_`, `REV_`, `NAME_`, `DEPLOYMENT_ID_`, `BYTES_`, `GENERATED_`) VALUES ('1188c1c8-b33f-11ed-b511-ce4fe10f37b8', 1, 'hist.var-variables', NULL, 0xACED0005737200176A6176612E7574696C2E4C696E6B6564486173684D617034C04E5C106CC0FB0200015A000B6163636573734F72646572787200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000B740007666F726D5265667400056C65617665740006677574746572737200116A6176612E6C616E672E496E746567657212E2A0A4F781873802000149000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B02000078700000000F74000473697A657400066D656469756D740009666F726D52756C657374000572756C657374000D6C6162656C506F736974696F6E7400057269676874740008666F726D42746E73737200116A6176612E6C616E672E426F6F6C65616ECD207280D59CFAEE0200015A000576616C756578700074000A6C6162656C57696474687371007E00060000006474000864697361626C65647371007E001001740009666F726D4D6F64656C7400096C65617665466F726D7400066669656C6473737200136A6176612E7574696C2E41727261794C6973747881D21D99C7619D03000149000473697A657870000000037704000000037371007E00003F4000000000000C7708000000100000000C740009636C65617261626C6571007E001574000A5F5F636F6E6669675F5F7371007E00003F400000000000187708000000200000000E740006666F726D49647371007E00060000006574000C64656661756C7456616C75657371007E00190000000277040000000274000A323032332D30322D323374000A323032332D30322D323478740008646F63756D656E7474003668747470733A2F2F656C656D656E742E656C656D652E636E2F232F7A682D434E2F636F6D706F6E656E742F646174652D7069636B657271007E0012707400056C6162656C74000CE8AFB7E58187E697B6E997B474000973686F774C6162656C71007E0015740008726571756972656471007E001574000972656E6465724B6579740010313031313634323133383830383939347400066C61796F757474000B636F6C466F726D4974656D74000774616749636F6E74000A646174652D72616E67657400096368616E676554616771007E001574000374616774000E656C2D646174652D7069636B65727400077265674C6973747371007E0019000000017704000000017371007E00003F4000000000000C7708000000100000000371007E002A71007E00157400076D657373616765740018E8AFB7E58187E697B6E997B4E4B88DE883BDE4B8BAE7A9BA740007747269676765727400066368616E67657800787400047370616E7371007E000600000018780074000F72616E67652D736570617261746F72740003E887B3740008726561646F6E6C7971007E001174001173746172742D706C616365686F6C64657274000CE5BC80E5A78BE697A5E69C9F740006666F726D617474000A797979792D4D4D2D646474000C76616C75652D666F726D617474000A797979792D4D4D2D646474000A5F5F764D6F64656C5F5F7400096C6561766574696D657400057374796C657371007E00003F4000000000000177080000000200000001740005776964746874000431303025780071007E001471007E0011740004747970657400096461746572616E676574000F656E642D706C616365686F6C64657274000CE7BB93E69D9FE697A5E69C9F78007371007E00003F4000000000000C7708000000100000000974000A66696C74657261626C6571007E001171007E001C71007E001571007E001D7371007E00003F400000000000187708000000200000000E71007E001F7371007E00060000006671007E002574003168747470733A2F2F656C656D656E742E656C656D652E636E2F232F7A682D434E2F636F6D706F6E656E742F73656C65637471007E00127071007E002774000CE8AFB7E58187E7B1BBE59E8B71007E002971007E001571007E002A71007E001571007E002B7400103130323136343231333837383439313071007E002D74000B636F6C466F726D4974656D71007E002F74000673656C65637471007E003171007E001571007E0032740009656C2D73656C65637471007E00347371007E0019000000017704000000017371007E00003F4000000000000C7708000000100000000371007E002A71007E001571007E0037740012E98089E68BA9E8AFB7E58187E7B1BBE59E8B71007E00397400066368616E676578007871007E003B71007E003C71007E00217371007E00060000000178007400086D756C7469706C6571007E001171007E00467400096C656176657479706571007E00487371007E00003F400000000000017708000000020000000171007E004A74000431303025780071007E001471007E001174000B706C616365686F6C646572740012E98089E68BA9E8AFB7E58187E7B1BBE59E8B7400085F5F736C6F745F5F7371007E00003F40000000000001770800000002000000017400076F7074696F6E737371007E0019000000027704000000027371007E00003F400000000000037708000000040000000271007E0027740006E5B9B4E5818774000576616C756571007E005E78007371007E00003F400000000000037708000000040000000271007E0027740006E8B083E4BC9171007E006B7371007E000600000002780078780078007371007E00003F4000000000000C7708000000100000000A71007E001D7371007E00003F400000000000187708000000200000000E71007E001F71007E002071007E002574003068747470733A2F2F656C656D656E742E656C656D652E636E2F232F7A682D434E2F636F6D706F6E656E742F696E70757471007E00127071007E002774000CE8AFB7E58187E4BA8BE794B171007E002971007E001571007E002A71007E001571007E002B7400103130313136343231333837323630383771007E002D74000B636F6C466F726D4974656D71007E002F740008746578746172656171007E003171007E001571007E0032740008656C2D696E70757471007E00347371007E0019000000017704000000017371007E00003F4000000000000C7708000000100000000371007E002A71007E001571007E0037740015E8AFB7E8BE93E585A5E8AFB7E58187E4BA8BE794B171007E0039740004626C757278007871007E003B71007E003C71007E0021740003313131780071007E003F71007E00117400096D61786C656E6774687071007E004674000B6C65617665726561736F6E71007E00487371007E00003F400000000000017708000000020000000171007E004A74000431303025780071007E001471007E001171007E0063740015E8AFB7E8BE93E585A5E8AFB7E58187E4BA8BE794B174000F73686F772D776F72642D6C696D697471007E001171007E004C74000874657874617265617400086175746F73697A657371007E00003F40000000000003770800000004000000027400076D696E526F77737371007E0006000000047400076D6178526F777371007E0086780078007871007E003B71007E003C7800, NULL);
INSERT INTO `act_ge_bytearray` (`ID_`, `REV_`, `NAME_`, `DEPLOYMENT_ID_`, `BYTES_`, `GENERATED_`) VALUES ('1e4bc78f-584e-11ee-9923-f22f4b0aefad', 1, 'test_vue3.bpmn', '1e4bc78e-584e-11ee-9923-f22f4b0aefad', 0x3C3F786D6C2076657273696F6E3D22312E302220656E636F64696E673D225554462D38223F3E0A3C646566696E6974696F6E7320786D6C6E733D22687474703A2F2F7777772E6F6D672E6F72672F737065632F42504D4E2F32303130303532342F4D4F44454C2220786D6C6E733A7873693D22687474703A2F2F7777772E77332E6F72672F323030312F584D4C536368656D612D696E7374616E63652220786D6C6E733A62706D6E64693D22687474703A2F2F7777772E6F6D672E6F72672F737065632F42504D4E2F32303130303532342F44492220786D6C6E733A6F6D6764633D22687474703A2F2F7777772E6F6D672E6F72672F737065632F44442F32303130303532342F44432220786D6C6E733A62696F633D22687474703A2F2F62706D6E2E696F2F736368656D612F62706D6E2F62696F636F6C6F722F312E302220786D6C6E733A666C6F7761626C653D22687474703A2F2F666C6F7761626C652E6F72672F62706D6E2220786D6C6E733A64693D22687474703A2F2F7777772E6F6D672E6F72672F737065632F44442F32303130303532342F44492220786D6C6E733A7873643D22687474703A2F2F7777772E77332E6F72672F323030312F584D4C536368656D6122207461726765744E616D6573706163653D22687474703A2F2F7777772E666C6F7761626C652E6F72672F70726F63657373646566223E0A20203C70726F636573732069643D22746573747675653322206E616D653D22746573745F767565332220666C6F7761626C653A70726F6365737343617465676F72793D2232223E0A202020203C73746172744576656E742069643D2273746172744E6F64653122206E616D653D22E5BC80E5A78B2220666C6F7761626C653A696E69746961746F723D22494E49544941544F52223E0A2020202020203C6F7574676F696E673E466C6F775F306B366B3631353C2F6F7574676F696E673E0A202020203C2F73746172744576656E743E0A202020203C73657175656E6365466C6F772069643D22466C6F775F306B366B3631352220736F757263655265663D2273746172744E6F64653122207461726765745265663D2241637469766974795F313765736C306122202F3E0A202020203C757365725461736B2069643D2241637469766974795F313765736C306122206E616D653D226161612220666C6F7761626C653A6173796E633D22747275652220666C6F7761626C653A726573756C745661726961626C653D226E756C6C2220666C6F7761626C653A72756C65733D226E756C6C2220666C6F7761626C653A72756C655661726961626C6573496E7075743D226E756C6C2220666C6F7761626C653A6578636C7564653D226E756C6C2220666C6F7761626C653A6175746F53746F72655661726961626C65733D226E756C6C2220666C6F7761626C653A636C6173733D226E756C6C2220666C6F7761626C653A7472696767657261626C653D226E756C6C2220666C6F7761626C653A736B697045787072657373696F6E3D226E756C6C2220666C6F7761626C653A64617461547970653D222220666C6F7761626C653A61737369676E65653D2231223E0A2020202020203C696E636F6D696E673E466C6F775F306B366B3631353C2F696E636F6D696E673E0A2020202020203C6F7574676F696E673E466C6F775F3073756D7364393C2F6F7574676F696E673E0A202020203C2F757365725461736B3E0A202020203C656E644576656E742069643D224576656E745F3170307768316422206E616D653D222220666C6F7761626C653A666F726D4B65793D226E756C6C2220666C6F7761626C653A696E69746961746F723D22494E49544941544F52223E0A2020202020203C696E636F6D696E673E466C6F775F3073756D7364393C2F696E636F6D696E673E0A202020203C2F656E644576656E743E0A202020203C73657175656E6365466C6F772069643D22466C6F775F3073756D7364392220736F757263655265663D2241637469766974795F313765736C306122207461726765745265663D224576656E745F3170307768316422202F3E0A20203C2F70726F636573733E0A20203C62706D6E64693A42504D4E4469616772616D2069643D2242504D4E4469616772616D5F666C6F77223E0A202020203C62706D6E64693A42504D4E506C616E652069643D2242504D4E506C616E655F666C6F77222062706D6E456C656D656E743D227465737476756533223E0A2020202020203C62706D6E64693A42504D4E456467652069643D22466C6F775F3073756D7364395F6469222062706D6E456C656D656E743D22466C6F775F3073756D736439223E0A20202020202020203C64693A776179706F696E7420783D223136302220793D2231333022202F3E0A20202020202020203C64693A776179706F696E7420783D223232322220793D2231333022202F3E0A2020202020203C2F62706D6E64693A42504D4E456467653E0A2020202020203C62706D6E64693A42504D4E456467652069643D22466C6F775F306B366B3631355F6469222062706D6E456C656D656E743D22466C6F775F306B366B363135223E0A20202020202020203C64693A776179706F696E7420783D22352220793D2231333022202F3E0A20202020202020203C64693A776179706F696E7420783D2236302220793D2231333022202F3E0A2020202020203C2F62706D6E64693A42504D4E456467653E0A2020202020203C62706D6E64693A42504D4E53686170652069643D2242504D4E53686170655F73746172744E6F646531222062706D6E456C656D656E743D2273746172744E6F646531222062696F633A7374726F6B653D22223E0A20202020202020203C6F6D6764633A426F756E647320783D222D32352220793D22313135222077696474683D22333022206865696768743D22333022202F3E0A20202020202020203C62706D6E64693A42504D4E4C6162656C3E0A202020202020202020203C6F6D6764633A426F756E647320783D222D32322220793D22313532222077696474683D22323222206865696768743D22313422202F3E0A20202020202020203C2F62706D6E64693A42504D4E4C6162656C3E0A2020202020203C2F62706D6E64693A42504D4E53686170653E0A2020202020203C62706D6E64693A42504D4E53686170652069643D2241637469766974795F30396165636F385F6469222062706D6E456C656D656E743D2241637469766974795F313765736C3061223E0A20202020202020203C6F6D6764633A426F756E647320783D2236302220793D223930222077696474683D2231303022206865696768743D22383022202F3E0A2020202020203C2F62706D6E64693A42504D4E53686170653E0A2020202020203C62706D6E64693A42504D4E53686170652069643D224576656E745F317030776831645F6469222062706D6E456C656D656E743D224576656E745F31703077683164223E0A20202020202020203C6F6D6764633A426F756E647320783D223232322220793D22313132222077696474683D22333622206865696768743D22333622202F3E0A2020202020203C2F62706D6E64693A42504D4E53686170653E0A202020203C2F62706D6E64693A42504D4E506C616E653E0A20203C2F62706D6E64693A42504D4E4469616772616D3E0A3C2F646566696E6974696F6E733E0A, 0);
INSERT INTO `act_ge_bytearray` (`ID_`, `REV_`, `NAME_`, `DEPLOYMENT_ID_`, `BYTES_`, `GENERATED_`) VALUES ('1e8ca120-584e-11ee-9923-f22f4b0aefad', 1, 'test_vue3.testvue3.png', '1e4bc78e-584e-11ee-9923-f22f4b0aefad', 0x89504E470D0A1A0A0000000D4948445200000125000000B40806000000D22A3A2500000BD649444154785EEDDDEF4F54D91DC7F1DD7D504DF6C9F691898D8FDA07FB2FF4994D5AFBC0C44DEB0F068DC61F18C01535D16A42342B0513351B1FACAD8D8DC946230DA98ABF52D4D541A42E20EABADB052BEB82282A22E0EF8A88707ABEC35CF67A66C03B33309C99F37E25DF2077EE9C7399B9F7E3B977EEDCFBDE7B000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000C0A4534AFDACADADED9FF5F5F5AFC3E1B03A7BF62C95E6D2AFFB506D6DEDFDEAEAEA4FCCF707708E0EA4437A83505D5D5DAAAFAF4FF5F7F753692E79DDE5F5AFA9A979AA436AB6F91E014E9111926C10E68642A5BF3A3B3B7B7428359AEF11E014D96563846447C9FBA043E995F91E014E91631AE6C6414D5EC9FB61BE4780538286D28B279DAAEDF297AAF9DC9F2325FF9669E67C546A4528C1794142E9F9E37BAAE9CC16F5DDBFFEF456C93479CC9C9F4ABE0825382F482875349F880924AFEE369F8C999F4ABE0825382F4828FDF7FC8E9830F24A1E33E7A7922F4209CE0B124A4D67B7C6849157F298393F957C114A701EA16457114A705E9050924FDBCC30F24A1E33E7A7922F4209CE0B124A37BFFE4B4C1879258F99F353C917A104E70509A5DE7BFF514D5F7D161348324D1E33E7A7922F4209CE0B124A52B7AE1C8809259966CE47A55684129C1728945EBD5237EBFE16134A324D1E8B999F4ABA082538EF5DA124676CFFF0F5EE9840F24A1EE3ACEEF12B4209CE1B3594F408A8F366B5FAFE74714C109925F3C8BC8C9A522F4209CE8B174AEF1A1D8D568C9A522F4209CE8B174A414647A3953CD76C8F0A5E84129C172F94CCA049B4CCF6A8E04528C179F142899ABC22948259BA74E947A150685E4E4ECE17FA6758D72D5D2F75A9E84FF93D1C7D7C9ECC6FB6014B114A7615A134B6DCDCDCDFE990A9D4D51F0DA0A025F357CAF3CD36611942C9AE2294E2D361F26B1D2A0D71C226996A90F6CC3E600942C9AE2294DEA677BBA6EA5DB0BFEA201932C365DDBA75AABCBC5C5DBD7A55B5B6B6AADEDE5E25E4A7FC2ED3E57199CF7CAEB427ED4AFB669FE34E2FD307F5F5F57F3C70E0C0572525253D9B366DEA2B2C2C8CFC41050505031B366C78A6A7FD585A5AFAF9B265CB6698CF770DA16457114A3FD1DBEC0C3DA2F9CE1F260B172E547BF7EE5577EFDE8D04505032BF3C4F9E6F84D3B7D28FD9F7B8D0FD4E3D7DFAF4DFB76CD9F23A2F2F4FEDD9B347353434C44D50992E8FAF58B162B0A8A8A86DE5CA95BF37DB7305A16457114AC374187DACEB9E3F4076ECD8A13A3A3ADE4E9B04C9F3A51D23983AA43F731952A243E6533DF2E993619A1E25A9C1C1417359E292F964FE356BD60CAC5AB5EA1B3D9CFBA5D976B62394EC2A4269648434124832BA3971E284B9F9A644DA33464D1DE33262D26DBF7FE6CC99F2FCFC7C555555A5DEBC7963F61D883C4F9EAFF72F5FB876749E50B2AB5C0F2539C6E3DF655BB66C99BA76ED9AB9C98E0B6957DAF705D3B7291D63D26DBE5F595979A9B0B050DDB871C3EC2F29D28EDEF57BA9137485D95FB62294EC2AD743297A507B6484345181E491F6FD2326E9DF5CA6C06484545050A0BABABACC7E5222EDE9F47CBE60C182DF9A7D662342C9AE723994A21FFB0F7A0171F2E44973F39C10D28F6FB43498D4E9027575759F4A208DD708C9A4DB1D5AB264C9E3F9F3E7FFCAEC3BDB104A7695CBA114F29D872407A3D3C938F8DD602EDB98F4F3A7969595F5C931A08974FCF8F1C77A5877DAEC3FDB104A7695ABA1247B26FEDDB6543F654B94F4E7DF8D4B684FE9D4A9537BE553B6640F6A0725EDE7E5E575EB85FB8DB90CD98450B2AB5C0DA5D0F05747228120E7134D06E9D7375AAA3497312EFDBC0F366FDEFC5A3EC64F878B172F3ED10BF76F7339B209A16457B9184A7A84F2F390EFBB6CE91E2579A45F5F28F5CB7299CB1AA3AEAEEE0F2B57AE0C7C1E52AAA49F458B163D993F7FFE2FCC65B19D7E51CFEB9A694E37114A7655B6855290F5503F3ECF0B03D90B9A4CC65752E699CB1A63FFFEFD67E54CEC742A292969CAC9C9293497C576BE1776CC958250B2ABB23094DEB91EEAE9BBBDF90E1E3C686E826925FDFB9679B7B9AC314A4B4BBBD3B5EBE63977EE5C7328E8FEA5457C2FEC982B05A164576571288DBA1EE6E6E6567B8F5FB972C5DC04D34AFAF7964596CBBF9C716DDCB8B1AFADADCD6C6742B5B4B4B4EB05BC6C2E8BEDE2AC0C71570A42C9AE72209462D643FDF38E373DDDDBB749FAF72DE31DE3CF8955505030F4E8D123B39D09D5DBDBFB5C2FDC3D73596C176725302BB252104A769543A1E45F0FFFE7FD9EEEEDDB24FD7BCBA2474ACFCCBF27C6E2C58BD5C0C080D9CE84D2FD3D8BF342664D114A7695F9FEB856E9DEBE4DD2BF6F79DE981914233F3F7F20DD49DADDDDFD6328BB464AE743ECBE595B0E8D9446D643199178D3D3BD7D9B121E29AD5FBFFE59BAF739AF5FBF7E25941DC794DE0A230FA1645739104A31EB6128938F29151717FF90EE4FDF8E1E3D7A2294D99FBEC5AC047E84925D95C5A134EA7A98D19FBE9594947C9EEEF39456AF5E5D95A1E7298DBA12F8114A76551686D23BD7C350269FA724D7D4CECBCB1B4CE319DD0FF4827567E219DD416542283D78F040CD9A354B4D9B364D4D993245CD9D3B573D7CF830E1E966BB3656B6855210218BCEE85EBB76ADFF0605EF3EA35B141515DD4AD72E5C4545C5C110DF7D9BF49240D9BE7DBBBA74E992DAB66D9B6CB46ADFBE7D094F37DBB5B15C0CA58CFEEE9B908BFCCB35B5D3709500B966EF4DAE126047353636AA5DBB76A93973E64442A6ACAC2CA9E9B6978BA12442997A9500CFEAD5ABBFA9AAAA1A321B1D47433B77EEFC522F5895D977B6C984503A74E850245866CF9EAD366DDA14F977696969C2D3CD766D2C5743C986EB29E5E6E68EECBA25743D25215784944BD64ED495272F5CB8B05F2F5827579EB4A3F4C838122C870F1F56C5C5C5917FCB89B4894E37DBB5B15C0D2511CAD42B4F7AE4AE23CB972F7F39DED7E86E6F6F3FA917EA7EC24999A13221942E5FBEACA64F9FAE3EFCF043B56AD52A3573E6CC48D01C397224A1E94D4D4D316DDB562E8752465FA3DB23771DD123A667E335628A8E90E47E53CBCDBEB255268492545F5F5FE466A2DEEF72C7D364A6DB5E2E8792988CBB99F877DB52BA9B894746347A68FE58AEA99DECC16F39A81D3D86F4C0951192275342C995723D94E4BE6BA1E15B69474262A2EFFBA6FB1B199949BF29DDF7CD4FEE6CAB53F58C5C535B2E611BF43C263D5F57454545B95E989BBA4E71875C6AB2CBF550127A5B9C111ABE63EDC8886922EE90EB1F2145FB4BFD0EB926F9F85E375CBB68D1A2A75BB76EFD3E1C0E37B5B4B4DCE9E9E979A197E3F9C3870FDB9A9B9BAF1C3B76EC785151D1293D6F8FCC9FED1FFB8F8550B2AB08A5613A303EF60793941C8C4EF5533979BE71503B1248D29FB90CE34ACEC0D61D15E8918F7C6FADD1F7C7C9CFC6E8F4826C3E533B2842C9AE22947E121A1E318DECCA49C9A849CE279263848990F9E579C6E828B2CB26FD987D6312114A7615A1F43639C6133DF86D8649E42B29E5E5E5EAEAD5ABAAB5B535F2C186909FF2BB4C97C78DAF8E783524ED8EDB31248C1F42C9AE2294E28B9E2E30721E538AD590D2C7FE985884925D45288D4DCE4F0C0D7F2565E4BB72014BE6AF94E79B6DC23284925D452805A377BB3ED221334FEF827DA17F8675DDD2F5321A40F2537E0F471F9F27F39B6DC05284925D4528C17984925D4528C17984925D4528C17984925D4528C17984925D4528C17984925D4528C17984925D4528C17984925D4528C17984925D4528C17984925D4528C17984925D4528C17984925D4528C17984925D4528C17984925D4528C17984925D4528C17984925D4528C17984925D4528C179E1707848EE266B6E1C54FA4BBF0FF77528BD32DF23C029B5B5B5F7BBBABA6236102AFD75FBF6ED0A1D4A8DE67B0438A5BABAFA939A9A9AA79D9D9D3D8C9826A7F4EBDED9DEDEFE0F1D487774CD36DF23C039B221C8FFD0BAFAE5980695F692D75D5E7F0209000000000000000000000000000000F6FA3F1E34D913287505260000000049454E44AE426082, 1);
INSERT INTO `act_ge_bytearray` (`ID_`, `REV_`, `NAME_`, `DEPLOYMENT_ID_`, `BYTES_`, `GENERATED_`) VALUES ('23cbb546-584e-11ee-9923-f22f4b0aefad', 1, 'var-variables', NULL, 0xACED0005737200136A6176612E7574696C2E41727261794C6973747881D21D99C7619D03000149000473697A65787000000001770400000001737200176A6176612E7574696C2E4C696E6B6564486173684D617034C04E5C106CC0FB0200015A000B6163636573734F72646572787200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F400000000000187708000000200000000D740009247265717569726564737200116A6176612E6C616E672E426F6F6C65616ECD207280D59CFAEE0200015A000576616C756578700074000C5F66635F647261675F746167740005696E7075747400056669656C647400046E616D6574000668696464656E71007E0007740007646973706C61797371007E00060174000474797065740005696E7075747400057469746C65740006E5908DE7A7B0740004696E666F74000074000570726F70737371007E00023F400000000000007708000000100000000078007400026F6E7371007E00023F400000000000007708000000100000000078007400076F7074696F6E737371007E000000000000770400000000787400086368696C6472656E7371007E0000000000007704000000007874000576616C756574000433333333780078, NULL);
INSERT INTO `act_ge_bytearray` (`ID_`, `REV_`, `NAME_`, `DEPLOYMENT_ID_`, `BYTES_`, `GENERATED_`) VALUES ('23cbb548-584e-11ee-9923-f22f4b0aefad', 1, 'hist.var-variables', NULL, 0xACED0005737200136A6176612E7574696C2E41727261794C6973747881D21D99C7619D03000149000473697A65787000000001770400000001737200176A6176612E7574696C2E4C696E6B6564486173684D617034C04E5C106CC0FB0200015A000B6163636573734F72646572787200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F400000000000187708000000200000000D740009247265717569726564737200116A6176612E6C616E672E426F6F6C65616ECD207280D59CFAEE0200015A000576616C756578700074000C5F66635F647261675F746167740005696E7075747400056669656C647400046E616D6574000668696464656E71007E0007740007646973706C61797371007E00060174000474797065740005696E7075747400057469746C65740006E5908DE7A7B0740004696E666F74000074000570726F70737371007E00023F400000000000007708000000100000000078007400026F6E7371007E00023F400000000000007708000000100000000078007400076F7074696F6E737371007E000000000000770400000000787400086368696C6472656E7371007E0000000000007704000000007874000576616C756574000433333333780078, NULL);
INSERT INTO `act_ge_bytearray` (`ID_`, `REV_`, `NAME_`, `DEPLOYMENT_ID_`, `BYTES_`, `GENERATED_`) VALUES ('28c75a31-5852-11ee-9923-f22f4b0aefad', 1, 'var-fields', NULL, 0xACED0005737200136A6176612E7574696C2E41727261794C6973747881D21D99C7619D03000149000473697A65787000000001770400000001737200176A6176612E7574696C2E4C696E6B6564486173684D617034C04E5C106CC0FB0200015A000B6163636573734F72646572787200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000274000A5F5F636F6E6669675F5F7371007E00023F4000000000000C77080000001000000008740009247265717569726564737200116A6176612E6C616E672E426F6F6C65616ECD207280D59CFAEE0200015A000576616C756578700074000C5F66635F647261675F746167740005696E7075747400056669656C647400046E616D6574000668696464656E71007E0009740007646973706C61797371007E00080174000474797065740005696E7075747400057469746C65740006E5908DE7A7B0740004696E666F740000780074000A5F5F764D6F64656C5F5F7400046E616D65780078, NULL);
INSERT INTO `act_ge_bytearray` (`ID_`, `REV_`, `NAME_`, `DEPLOYMENT_ID_`, `BYTES_`, `GENERATED_`) VALUES ('28c75a33-5852-11ee-9923-f22f4b0aefad', 1, 'hist.var-fields', NULL, 0xACED0005737200136A6176612E7574696C2E41727261794C6973747881D21D99C7619D03000149000473697A65787000000001770400000001737200176A6176612E7574696C2E4C696E6B6564486173684D617034C04E5C106CC0FB0200015A000B6163636573734F72646572787200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000274000A5F5F636F6E6669675F5F7371007E00023F4000000000000C77080000001000000008740009247265717569726564737200116A6176612E6C616E672E426F6F6C65616ECD207280D59CFAEE0200015A000576616C756578700074000C5F66635F647261675F746167740005696E7075747400056669656C647400046E616D6574000668696464656E71007E0009740007646973706C61797371007E00080174000474797065740005696E7075747400057469746C65740006E5908DE7A7B0740004696E666F740000780074000A5F5F764D6F64656C5F5F7400046E616D65780078, NULL);
INSERT INTO `act_ge_bytearray` (`ID_`, `REV_`, `NAME_`, `DEPLOYMENT_ID_`, `BYTES_`, `GENERATED_`) VALUES ('28c75a35-5852-11ee-9923-f22f4b0aefad', 1, 'var-variables', NULL, 0xACED0005737200136A6176612E7574696C2E41727261794C6973747881D21D99C7619D03000149000473697A65787000000001770400000001737200176A6176612E7574696C2E4C696E6B6564486173684D617034C04E5C106CC0FB0200015A000B6163636573734F72646572787200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F400000000000187708000000200000000D740009247265717569726564737200116A6176612E6C616E672E426F6F6C65616ECD207280D59CFAEE0200015A000576616C756578700074000C5F66635F647261675F746167740005696E7075747400056669656C647400046E616D6574000668696464656E71007E0007740007646973706C61797371007E00060174000474797065740005696E7075747400057469746C65740006E5908DE7A7B0740004696E666F74000074000570726F70737371007E00023F400000000000007708000000100000000078007400026F6E7371007E00023F400000000000007708000000100000000078007400076F7074696F6E737371007E000000000000770400000000787400086368696C6472656E7371007E0000000000007704000000007874000576616C7565740003343434780078, NULL);
INSERT INTO `act_ge_bytearray` (`ID_`, `REV_`, `NAME_`, `DEPLOYMENT_ID_`, `BYTES_`, `GENERATED_`) VALUES ('28c75a37-5852-11ee-9923-f22f4b0aefad', 1, 'hist.var-variables', NULL, 0xACED0005737200136A6176612E7574696C2E41727261794C6973747881D21D99C7619D03000149000473697A65787000000001770400000001737200176A6176612E7574696C2E4C696E6B6564486173684D617034C04E5C106CC0FB0200015A000B6163636573734F72646572787200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F400000000000187708000000200000000D740009247265717569726564737200116A6176612E6C616E672E426F6F6C65616ECD207280D59CFAEE0200015A000576616C756578700074000C5F66635F647261675F746167740005696E7075747400056669656C647400046E616D6574000668696464656E71007E0007740007646973706C61797371007E00060174000474797065740005696E7075747400057469746C65740006E5908DE7A7B0740004696E666F74000074000570726F70737371007E00023F400000000000007708000000100000000078007400026F6E7371007E00023F400000000000007708000000100000000078007400076F7074696F6E737371007E000000000000770400000000787400086368696C6472656E7371007E0000000000007704000000007874000576616C7565740003343434780078, NULL);
INSERT INTO `act_ge_bytearray` (`ID_`, `REV_`, `NAME_`, `DEPLOYMENT_ID_`, `BYTES_`, `GENERATED_`) VALUES ('2a913e7f-56c2-11ee-ae41-f22f4b0aefad', 1, 'test_vue3.bpmn', '2a913e7e-56c2-11ee-ae41-f22f4b0aefad', 0x3C3F786D6C2076657273696F6E3D22312E302220656E636F64696E673D225554462D38223F3E0A3C646566696E6974696F6E7320786D6C6E733D22687474703A2F2F7777772E6F6D672E6F72672F737065632F42504D4E2F32303130303532342F4D4F44454C2220786D6C6E733A7873693D22687474703A2F2F7777772E77332E6F72672F323030312F584D4C536368656D612D696E7374616E63652220786D6C6E733A62706D6E64693D22687474703A2F2F7777772E6F6D672E6F72672F737065632F42504D4E2F32303130303532342F44492220786D6C6E733A6F6D6764633D22687474703A2F2F7777772E6F6D672E6F72672F737065632F44442F32303130303532342F44432220786D6C6E733A62696F633D22687474703A2F2F62706D6E2E696F2F736368656D612F62706D6E2F62696F636F6C6F722F312E302220786D6C6E733A666C6F7761626C653D22687474703A2F2F666C6F7761626C652E6F72672F62706D6E2220786D6C6E733A64693D22687474703A2F2F7777772E6F6D672E6F72672F737065632F44442F32303130303532342F44492220786D6C6E733A7873643D22687474703A2F2F7777772E77332E6F72672F323030312F584D4C536368656D6122207461726765744E616D6573706163653D22687474703A2F2F7777772E666C6F7761626C652E6F72672F70726F63657373646566223E0A20203C70726F636573732069643D22746573747675653322206E616D653D22746573745F767565332220666C6F7761626C653A70726F6365737343617465676F72793D2232223E0A202020203C73746172744576656E742069643D2273746172744E6F64653122206E616D653D22E5BC80E5A78B2220666C6F7761626C653A696E69746961746F723D22494E49544941544F52223E0A2020202020203C6F7574676F696E673E466C6F775F306B366B3631353C2F6F7574676F696E673E0A202020203C2F73746172744576656E743E0A202020203C73657175656E6365466C6F772069643D22466C6F775F306B366B3631352220736F757263655265663D2273746172744E6F64653122207461726765745265663D2241637469766974795F313765736C306122202F3E0A202020203C757365725461736B2069643D2241637469766974795F313765736C306122206E616D653D226161612220666C6F7761626C653A6173796E633D22747275652220666C6F7761626C653A726573756C745661726961626C653D226E756C6C2220666C6F7761626C653A72756C65733D226E756C6C2220666C6F7761626C653A72756C655661726961626C6573496E7075743D226E756C6C2220666C6F7761626C653A6578636C7564653D226E756C6C2220666C6F7761626C653A6175746F53746F72655661726961626C65733D226E756C6C2220666C6F7761626C653A636C6173733D226E756C6C2220666C6F7761626C653A7472696767657261626C653D226E756C6C2220666C6F7761626C653A736B697045787072657373696F6E3D226E756C6C2220666C6F7761626C653A64617461547970653D22223E0A2020202020203C696E636F6D696E673E466C6F775F306B366B3631353C2F696E636F6D696E673E0A2020202020203C6F7574676F696E673E466C6F775F3073756D7364393C2F6F7574676F696E673E0A202020203C2F757365725461736B3E0A202020203C656E644576656E742069643D224576656E745F3170307768316422206E616D653D222220666C6F7761626C653A666F726D4B65793D226E756C6C2220666C6F7761626C653A696E69746961746F723D22494E49544941544F52223E0A2020202020203C696E636F6D696E673E466C6F775F3073756D7364393C2F696E636F6D696E673E0A202020203C2F656E644576656E743E0A202020203C73657175656E6365466C6F772069643D22466C6F775F3073756D7364392220736F757263655265663D2241637469766974795F313765736C306122207461726765745265663D224576656E745F3170307768316422202F3E0A20203C2F70726F636573733E0A20203C62706D6E64693A42504D4E4469616772616D2069643D2242504D4E4469616772616D5F666C6F77223E0A202020203C62706D6E64693A42504D4E506C616E652069643D2242504D4E506C616E655F666C6F77222062706D6E456C656D656E743D227465737476756533223E0A2020202020203C62706D6E64693A42504D4E456467652069643D22466C6F775F306B366B3631355F6469222062706D6E456C656D656E743D22466C6F775F306B366B363135223E0A20202020202020203C64693A776179706F696E7420783D22352220793D2231333022202F3E0A20202020202020203C64693A776179706F696E7420783D2236302220793D2231333022202F3E0A2020202020203C2F62706D6E64693A42504D4E456467653E0A2020202020203C62706D6E64693A42504D4E456467652069643D22466C6F775F3073756D7364395F6469222062706D6E456C656D656E743D22466C6F775F3073756D736439223E0A20202020202020203C64693A776179706F696E7420783D223136302220793D2231333022202F3E0A20202020202020203C64693A776179706F696E7420783D223232322220793D2231333022202F3E0A2020202020203C2F62706D6E64693A42504D4E456467653E0A2020202020203C62706D6E64693A42504D4E53686170652069643D2242504D4E53686170655F73746172744E6F646531222062706D6E456C656D656E743D2273746172744E6F646531222062696F633A7374726F6B653D22223E0A20202020202020203C6F6D6764633A426F756E647320783D222D32352220793D22313135222077696474683D22333022206865696768743D22333022202F3E0A20202020202020203C62706D6E64693A42504D4E4C6162656C3E0A202020202020202020203C6F6D6764633A426F756E647320783D222D32322220793D22313532222077696474683D22323222206865696768743D22313422202F3E0A20202020202020203C2F62706D6E64693A42504D4E4C6162656C3E0A2020202020203C2F62706D6E64693A42504D4E53686170653E0A2020202020203C62706D6E64693A42504D4E53686170652069643D2241637469766974795F30396165636F385F6469222062706D6E456C656D656E743D2241637469766974795F313765736C3061223E0A20202020202020203C6F6D6764633A426F756E647320783D2236302220793D223930222077696474683D2231303022206865696768743D22383022202F3E0A2020202020203C2F62706D6E64693A42504D4E53686170653E0A2020202020203C62706D6E64693A42504D4E53686170652069643D224576656E745F317030776831645F6469222062706D6E456C656D656E743D224576656E745F31703077683164223E0A20202020202020203C6F6D6764633A426F756E647320783D223232322220793D22313132222077696474683D22333622206865696768743D22333622202F3E0A2020202020203C2F62706D6E64693A42504D4E53686170653E0A202020203C2F62706D6E64693A42504D4E506C616E653E0A20203C2F62706D6E64693A42504D4E4469616772616D3E0A3C2F646566696E6974696F6E733E0A, 0);
INSERT INTO `act_ge_bytearray` (`ID_`, `REV_`, `NAME_`, `DEPLOYMENT_ID_`, `BYTES_`, `GENERATED_`) VALUES ('2ae9bec0-56c2-11ee-ae41-f22f4b0aefad', 1, 'test_vue3.testvue3.png', '2a913e7e-56c2-11ee-ae41-f22f4b0aefad', 0x89504E470D0A1A0A0000000D4948445200000125000000B40806000000D22A3A2500000BD649444154785EEDDDEF4F54D91DC7F1DD7D504DF6C9F691898D8FDA07FB2FF4994D5AFBC0C44DEB0F068DC61F18C01535D16A42342B0513351B1FACAD8D8DC946230DA98ABF52D4D541A42E20EABADB052BEB82282A22E0EF8A88707ABEC35CF67A66C03B33309C99F37E25DF2077EE9C7399B9F7E3B977EEDCFBDE7B000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000C0A4534AFDACADADED9FF5F5F5AFC3E1B03A7BF62C95E6D2AFFB506D6DEDFDEAEAEA4FCCF707708E0EA4437A83505D5D5DAAAFAF4FF5F7F753692E79DDE5F5AFA9A979AA436AB6F91E014E9111926C10E68642A5BF3A3B3B7B7428359AEF11E014D96563846447C9FBA043E995F91E014E91631AE6C6414D5EC9FB61BE4780538286D28B279DAAEDF297AAF9DC9F2325FF9669E67C546A4528C1794142E9F9E37BAAE9CC16F5DDBFFEF456C93479CC9C9F4ABE0825382F482875349F880924AFEE369F8C999F4ABE0825382F4828FDF7FC8E9830F24A1E33E7A7922F4209CE0B124A4D67B7C6849157F298393F957C114A701EA16457114A705E9050924FDBCC30F24A1E33E7A7922F4209CE0B124A37BFFE4B4C1879258F99F353C917A104E70509A5DE7BFF514D5F7D161348324D1E33E7A7922F4209CE0B124A52B7AE1C8809259966CE47A55684129C1728945EBD5237EBFE16134A324D1E8B999F4ABA082538EF5DA124676CFFF0F5EE9840F24A1EE3ACEEF12B4209CE1B3594F408A8F366B5FAFE74714C109925F3C8BC8C9A522F4209CE8B174AEF1A1D8D568C9A522F4209CE8B174A414647A3953CD76C8F0A5E84129C172F94CCA049B4CCF6A8E04528C179F142899ABC22948259BA74E947A150685E4E4ECE17FA6758D72D5D2F75A9E84FF93D1C7D7C9ECC6FB6014B114A7615A134B6DCDCDCDFE990A9D4D51F0DA0A025F357CAF3CD36611942C9AE2294E2D361F26B1D2A0D71C226996A90F6CC3E600942C9AE2294DEA677BBA6EA5DB0BFEA201932C365DDBA75AABCBC5C5DBD7A55B5B6B6AADEDE5E25E4A7FC2ED3E57199CF7CAEB427ED4AFB669FE34E2FD307F5F5F57F3C70E0C0572525253D9B366DEA2B2C2C8CFC41050505031B366C78A6A7FD585A5AFAF9B265CB6698CF770DA16457114A3FD1DBEC0C3DA2F9CE1F260B172E547BF7EE5577EFDE8D04505032BF3C4F9E6F84D3B7D28FD9F7B8D0FD4E3D7DFAF4DFB76CD9F23A2F2F4FEDD9B347353434C44D50992E8FAF58B162B0A8A8A86DE5CA95BF37DB7305A16457114AC374187DACEB9E3F4076ECD8A13A3A3ADE4E9B04C9F3A51D23983AA43F731952A243E6533DF2E993619A1E25A9C1C1417359E292F964FE356BD60CAC5AB5EA1B3D9CFBA5D976B62394EC2A4269648434124832BA3971E284B9F9A644DA33464D1DE33262D26DBF7FE6CC99F2FCFC7C555555A5DEBC7963F61D883C4F9EAFF72F5FB876749E50B2AB5C0F2539C6E3DF655BB66C99BA76ED9AB9C98E0B6957DAF705D3B7291D63D26DBE5F595979A9B0B050DDB871C3EC2F29D28EDEF57BA9137485D95FB62294EC2AD743297A507B6484345181E491F6FD2326E9DF5CA6C06484545050A0BABABACC7E5222EDE9F47CBE60C182DF9A7D662342C9AE723994A21FFB0F7A0171F2E44973F39C10D28F6FB43498D4E9027575759F4A208DD708C9A4DB1D5AB264C9E3F9F3E7FFCAEC3BDB104A7695CBA114F29D872407A3D3C938F8DD602EDB98F4F3A7969595F5C931A08974FCF8F1C77A5877DAEC3FDB104A7695ABA1247B26FEDDB6543F654B94F4E7DF8D4B684FE9D4A9537BE553B6640F6A0725EDE7E5E575EB85FB8DB90CD98450B2AB5C0DA5D0F05747228120E7134D06E9D7375AAA3497312EFDBC0F366FDEFC5A3EC64F878B172F3ED10BF76F7339B209A16457B9184A7A84F2F390EFBB6CE91E2579A45F5F28F5CB7299CB1AA3AEAEEE0F2B57AE0C7C1E52AAA49F458B163D993F7FFE2FCC65B19D7E51CFEB9A694E37114A7655B6855290F5503F3ECF0B03D90B9A4CC65752E699CB1A63FFFEFD67E54CEC742A292969CAC9C9293497C576BE1776CC958250B2ABB23094DEB91EEAE9BBBDF90E1E3C686E826925FDFB9679B7B9AC314A4B4BBBD3B5EBE63977EE5C7328E8FEA5457C2FEC982B05A164576571288DBA1EE6E6E6567B8F5FB972C5DC04D34AFAF7964596CBBF9C716DDCB8B1AFADADCD6C6742B5B4B4B4EB05BC6C2E8BEDE2AC0C71570A42C9AE72209462D643FDF38E373DDDDBB749FAF72DE31DE3CF8955505030F4E8D123B39D09D5DBDBFB5C2FDC3D73596C176725302BB252104A769543A1E45F0FFFE7FD9EEEEDDB24FD7BCBA2474ACFCCBF27C6E2C58BD5C0C080D9CE84D2FD3D8BF342664D114A7695F9FEB856E9DEBE4DD2BF6F79DE981914233F3F7F20DD49DADDDDFD6328BB464AE743ECBE595B0E8D9446D643199178D3D3BD7D9B121E29AD5FBFFE59BAF739AF5FBF7E25941DC794DE0A230FA1645739104A31EB6128938F29151717FF90EE4FDF8E1E3D7A2294D99FBEC5AC047E84925D95C5A134EA7A98D19FBE9594947C9EEEF39456AF5E5D95A1E7298DBA12F8114A76551686D23BD7C350269FA724D7D4CECBCB1B4CE319DD0FF4827567E219DD416542283D78F040CD9A354B4D9B364D4D993245CD9D3B573D7CF830E1E966BB3656B6855210218BCEE85EBB76ADFF0605EF3EA35B141515DD4AD72E5C4545C5C110DF7D9BF49240D9BE7DBBBA74E992DAB66D9B6CB46ADFBE7D094F37DBB5B15C0CA58CFEEE9B908BFCCB35B5D3709500B966EF4DAE126047353636AA5DBB76A93973E64442A6ACAC2CA9E9B6978BA12442997A9500CFEAD5ABBFA9AAAA1A321B1D47433B77EEFC522F5895D977B6C984503A74E850245866CF9EAD366DDA14F977696969C2D3CD766D2C5743C986EB29E5E6E68EECBA25743D25215784944BD64ED495272F5CB8B05F2F5827579EB4A3F4C838122C870F1F56C5C5C5917FCB89B4894E37DBB5B15C0D2511CAD42B4F7AE4AE23CB972F7F39DED7E86E6F6F3FA917EA7EC24999A13221942E5FBEACA64F9FAE3EFCF043B56AD52A3573E6CC48D01C397224A1E94D4D4D316DDB562E8752465FA3DB23771DD123A667E335628A8E90E47E53CBCDBEB255268492545F5F5FE466A2DEEF72C7D364A6DB5E2E8792988CBB99F877DB52BA9B894746347A68FE58AEA99DECC16F39A81D3D86F4C0951192275342C995723D94E4BE6BA1E15B69474262A2EFFBA6FB1B199949BF29DDF7CD4FEE6CAB53F58C5C535B2E611BF43C263D5F57454545B95E989BBA4E71875C6AB2CBF550127A5B9C111ABE63EDC8886922EE90EB1F2145FB4BFD0EB926F9F85E375CBB68D1A2A75BB76EFD3E1C0E37B5B4B4DCE9E9E979A197E3F9C3870FDB9A9B9BAF1C3B76EC785151D1293D6F8FCC9FED1FFB8F8550B2AB08A5613A303EF60793941C8C4EF5533979BE71503B1248D29FB90CE34ACEC0D61D15E8918F7C6FADD1F7C7C9CFC6E8F4826C3E533B2842C9AE22947E121A1E318DECCA49C9A849CE279263848990F9E579C6E828B2CB26FD987D6312114A7615A1F43639C6133DF86D8649E42B29E5E5E5EAEAD5ABAAB5B535F2C186909FF2BB4C97C78DAF8E783524ED8EDB31248C1F42C9AE2294E28B9E2E30721E538AD590D2C7FE985884925D45288D4DCE4F0C0D7F2565E4BB72014BE6AF94E79B6DC23284925D452805A377BB3ED221334FEF827DA17F8675DDD2F5321A40F2537E0F471F9F27F39B6DC05284925D4528C17984925D4528C17984925D4528C17984925D4528C17984925D4528C17984925D4528C17984925D4528C17984925D4528C17984925D4528C17984925D4528C17984925D4528C17984925D4528C17984925D4528C17984925D4528C17984925D4528C17984925D4528C17984925D4528C179E1707848EE266B6E1C54FA4BBF0FF77528BD32DF23C029B5B5B5F7BBBABA6236102AFD75FBF6ED0A1D4A8DE67B0438A5BABAFA939A9A9AA79D9D9D3D8C9826A7F4EBDED9DEDEFE0F1D487774CD36DF23C039B221C8FFD0BAFAE5980695F692D75D5E7F0209000000000000000000000000000000F6FA3F1E34D913287505260000000049454E44AE426082, 1);
INSERT INTO `act_ge_bytearray` (`ID_`, `REV_`, `NAME_`, `DEPLOYMENT_ID_`, `BYTES_`, `GENERATED_`) VALUES ('3478d1ce-b342-11ed-abc3-869ef1607803', 1, 'hist.var-leavetime', NULL, 0xACED0005737200136A6176612E7574696C2E41727261794C6973747881D21D99C7619D03000149000473697A6578700000000277040000000274000A323032332D30322D323374000A323032332D30322D323478, NULL);
INSERT INTO `act_ge_bytearray` (`ID_`, `REV_`, `NAME_`, `DEPLOYMENT_ID_`, `BYTES_`, `GENERATED_`) VALUES ('3478f8e3-b342-11ed-abc3-869ef1607803', 1, 'hist.var-variables', NULL, 0xACED0005737200176A6176612E7574696C2E4C696E6B6564486173684D617034C04E5C106CC0FB0200015A000B6163636573734F72646572787200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000B740007666F726D5265667400056C65617665740006677574746572737200116A6176612E6C616E672E496E746567657212E2A0A4F781873802000149000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B02000078700000000F74000473697A657400066D656469756D740009666F726D52756C657374000572756C657374000D6C6162656C506F736974696F6E7400057269676874740008666F726D42746E73737200116A6176612E6C616E672E426F6F6C65616ECD207280D59CFAEE0200015A000576616C756578700074000A6C6162656C57696474687371007E00060000006474000864697361626C65647371007E001001740009666F726D4D6F64656C7400096C65617665466F726D7400066669656C6473737200136A6176612E7574696C2E41727261794C6973747881D21D99C7619D03000149000473697A657870000000037704000000037371007E00003F4000000000000C7708000000100000000C740009636C65617261626C6571007E001574000A5F5F636F6E6669675F5F7371007E00003F400000000000187708000000200000000E740006666F726D49647371007E00060000006574000C64656661756C7456616C75657371007E00190000000277040000000274000A323032332D30322D323374000A323032332D30322D323478740008646F63756D656E7474003668747470733A2F2F656C656D656E742E656C656D652E636E2F232F7A682D434E2F636F6D706F6E656E742F646174652D7069636B657271007E0012707400056C6162656C74000CE8AFB7E58187E697B6E997B474000973686F774C6162656C71007E0015740008726571756972656471007E001574000972656E6465724B6579740010313031313634323133383830383939347400066C61796F757474000B636F6C466F726D4974656D74000774616749636F6E74000A646174652D72616E67657400096368616E676554616771007E001574000374616774000E656C2D646174652D7069636B65727400077265674C6973747371007E0019000000017704000000017371007E00003F4000000000000C7708000000100000000371007E002A71007E00157400076D657373616765740018E8AFB7E58187E697B6E997B4E4B88DE883BDE4B8BAE7A9BA740007747269676765727400066368616E67657800787400047370616E7371007E000600000018780074000F72616E67652D736570617261746F72740003E887B3740008726561646F6E6C7971007E001174001173746172742D706C616365686F6C64657274000CE5BC80E5A78BE697A5E69C9F740006666F726D617474000A797979792D4D4D2D646474000C76616C75652D666F726D617474000A797979792D4D4D2D646474000A5F5F764D6F64656C5F5F7400096C6561766574696D657400057374796C657371007E00003F4000000000000177080000000200000001740005776964746874000431303025780071007E001471007E0011740004747970657400096461746572616E676574000F656E642D706C616365686F6C64657274000CE7BB93E69D9FE697A5E69C9F78007371007E00003F4000000000000C7708000000100000000974000A66696C74657261626C6571007E001171007E001C71007E001571007E001D7371007E00003F400000000000187708000000200000000E71007E001F7371007E00060000006671007E002574003168747470733A2F2F656C656D656E742E656C656D652E636E2F232F7A682D434E2F636F6D706F6E656E742F73656C65637471007E00127071007E002774000CE8AFB7E58187E7B1BBE59E8B71007E002971007E001571007E002A71007E001571007E002B7400103130323136343231333837383439313071007E002D74000B636F6C466F726D4974656D71007E002F74000673656C65637471007E003171007E001571007E0032740009656C2D73656C65637471007E00347371007E0019000000017704000000017371007E00003F4000000000000C7708000000100000000371007E002A71007E001571007E0037740012E98089E68BA9E8AFB7E58187E7B1BBE59E8B71007E00397400066368616E676578007871007E003B71007E003C71007E00217371007E00060000000178007400086D756C7469706C6571007E001171007E00467400096C656176657479706571007E00487371007E00003F400000000000017708000000020000000171007E004A74000431303025780071007E001471007E001174000B706C616365686F6C646572740012E98089E68BA9E8AFB7E58187E7B1BBE59E8B7400085F5F736C6F745F5F7371007E00003F40000000000001770800000002000000017400076F7074696F6E737371007E0019000000027704000000027371007E00003F400000000000037708000000040000000271007E0027740006E5B9B4E5818774000576616C756571007E005E78007371007E00003F400000000000037708000000040000000271007E0027740006E8B083E4BC9171007E006B7371007E000600000002780078780078007371007E00003F4000000000000C7708000000100000000A71007E001D7371007E00003F400000000000187708000000200000000E71007E001F71007E002071007E002574003068747470733A2F2F656C656D656E742E656C656D652E636E2F232F7A682D434E2F636F6D706F6E656E742F696E70757471007E00127071007E002774000CE8AFB7E58187E4BA8BE794B171007E002971007E001571007E002A71007E001571007E002B7400103130313136343231333837323630383771007E002D74000B636F6C466F726D4974656D71007E002F740008746578746172656171007E003171007E001571007E0032740008656C2D696E70757471007E00347371007E0019000000017704000000017371007E00003F4000000000000C7708000000100000000371007E002A71007E001571007E0037740015E8AFB7E8BE93E585A5E8AFB7E58187E4BA8BE794B171007E0039740004626C757278007871007E003B71007E003C71007E0021740003323232780071007E003F71007E00117400096D61786C656E6774687071007E004674000B6C65617665726561736F6E71007E00487371007E00003F400000000000017708000000020000000171007E004A74000431303025780071007E001471007E001171007E0063740015E8AFB7E8BE93E585A5E8AFB7E58187E4BA8BE794B174000F73686F772D776F72642D6C696D697471007E001171007E004C74000874657874617265617400086175746F73697A657371007E00003F40000000000003770800000004000000027400076D696E526F77737371007E0006000000047400076D6178526F777371007E0086780078007871007E003B71007E003C7800, NULL);
INSERT INTO `act_ge_bytearray` (`ID_`, `REV_`, `NAME_`, `DEPLOYMENT_ID_`, `BYTES_`, `GENERATED_`) VALUES ('3ef44d2a-b340-11ed-9d23-869ef1607803', 1, 'var-leavetime', NULL, 0xACED0005737200136A6176612E7574696C2E41727261794C6973747881D21D99C7619D03000149000473697A6578700000000277040000000274000A323032332D30322D323374000A323032332D30322D323478, NULL);
INSERT INTO `act_ge_bytearray` (`ID_`, `REV_`, `NAME_`, `DEPLOYMENT_ID_`, `BYTES_`, `GENERATED_`) VALUES ('3ef44d2c-b340-11ed-9d23-869ef1607803', 1, 'hist.var-leavetime', NULL, 0xACED0005737200136A6176612E7574696C2E41727261794C6973747881D21D99C7619D03000149000473697A6578700000000277040000000274000A323032332D30322D323374000A323032332D30322D323478, NULL);
INSERT INTO `act_ge_bytearray` (`ID_`, `REV_`, `NAME_`, `DEPLOYMENT_ID_`, `BYTES_`, `GENERATED_`) VALUES ('3ef44d2f-b340-11ed-9d23-869ef1607803', 1, 'var-variables', NULL, 0xACED0005737200176A6176612E7574696C2E4C696E6B6564486173684D617034C04E5C106CC0FB0200015A000B6163636573734F72646572787200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000B740007666F726D5265667400056C65617665740006677574746572737200116A6176612E6C616E672E496E746567657212E2A0A4F781873802000149000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B02000078700000000F74000473697A657400066D656469756D740009666F726D52756C657374000572756C657374000D6C6162656C506F736974696F6E7400057269676874740008666F726D42746E73737200116A6176612E6C616E672E426F6F6C65616ECD207280D59CFAEE0200015A000576616C756578700074000A6C6162656C57696474687371007E00060000006474000864697361626C65647371007E001001740009666F726D4D6F64656C7400096C65617665466F726D7400066669656C6473737200136A6176612E7574696C2E41727261794C6973747881D21D99C7619D03000149000473697A657870000000037704000000037371007E00003F4000000000000C7708000000100000000C740009636C65617261626C6571007E001574000A5F5F636F6E6669675F5F7371007E00003F400000000000187708000000200000000E740006666F726D49647371007E00060000006574000C64656661756C7456616C75657371007E00190000000277040000000274000A323032332D30322D323374000A323032332D30322D323478740008646F63756D656E7474003668747470733A2F2F656C656D656E742E656C656D652E636E2F232F7A682D434E2F636F6D706F6E656E742F646174652D7069636B657271007E0012707400056C6162656C74000CE8AFB7E58187E697B6E997B474000973686F774C6162656C71007E0015740008726571756972656471007E001574000972656E6465724B6579740010313031313634323133383830383939347400066C61796F757474000B636F6C466F726D4974656D74000774616749636F6E74000A646174652D72616E67657400096368616E676554616771007E001574000374616774000E656C2D646174652D7069636B65727400077265674C6973747371007E0019000000017704000000017371007E00003F4000000000000C7708000000100000000371007E002A71007E00157400076D657373616765740018E8AFB7E58187E697B6E997B4E4B88DE883BDE4B8BAE7A9BA740007747269676765727400066368616E67657800787400047370616E7371007E000600000018780074000F72616E67652D736570617261746F72740003E887B3740008726561646F6E6C7971007E001174001173746172742D706C616365686F6C64657274000CE5BC80E5A78BE697A5E69C9F740006666F726D617474000A797979792D4D4D2D646474000C76616C75652D666F726D617474000A797979792D4D4D2D646474000A5F5F764D6F64656C5F5F7400096C6561766574696D657400057374796C657371007E00003F4000000000000177080000000200000001740005776964746874000431303025780071007E001471007E0011740004747970657400096461746572616E676574000F656E642D706C616365686F6C64657274000CE7BB93E69D9FE697A5E69C9F78007371007E00003F4000000000000C7708000000100000000974000A66696C74657261626C6571007E001171007E001C71007E001571007E001D7371007E00003F400000000000187708000000200000000E71007E001F7371007E00060000006671007E002574003168747470733A2F2F656C656D656E742E656C656D652E636E2F232F7A682D434E2F636F6D706F6E656E742F73656C65637471007E00127071007E002774000CE8AFB7E58187E7B1BBE59E8B71007E002971007E001571007E002A71007E001571007E002B7400103130323136343231333837383439313071007E002D74000B636F6C466F726D4974656D71007E002F74000673656C65637471007E003171007E001571007E0032740009656C2D73656C65637471007E00347371007E0019000000017704000000017371007E00003F4000000000000C7708000000100000000371007E002A71007E001571007E0037740012E98089E68BA9E8AFB7E58187E7B1BBE59E8B71007E00397400066368616E676578007871007E003B71007E003C71007E00217371007E00060000000178007400086D756C7469706C6571007E001171007E00467400096C656176657479706571007E00487371007E00003F400000000000017708000000020000000171007E004A74000431303025780071007E001471007E001174000B706C616365686F6C646572740012E98089E68BA9E8AFB7E58187E7B1BBE59E8B7400085F5F736C6F745F5F7371007E00003F40000000000001770800000002000000017400076F7074696F6E737371007E0019000000027704000000027371007E00003F400000000000037708000000040000000271007E0027740006E5B9B4E5818774000576616C756571007E005E78007371007E00003F400000000000037708000000040000000271007E0027740006E8B083E4BC9171007E006B7371007E000600000002780078780078007371007E00003F4000000000000C7708000000100000000A71007E001D7371007E00003F400000000000187708000000200000000E71007E001F71007E002071007E002574003068747470733A2F2F656C656D656E742E656C656D652E636E2F232F7A682D434E2F636F6D706F6E656E742F696E70757471007E00127071007E002774000CE8AFB7E58187E4BA8BE794B171007E002971007E001571007E002A71007E001571007E002B7400103130313136343231333837323630383771007E002D74000B636F6C466F726D4974656D71007E002F740008746578746172656171007E003171007E001571007E0032740008656C2D696E70757471007E00347371007E0019000000017704000000017371007E00003F4000000000000C7708000000100000000371007E002A71007E001571007E0037740015E8AFB7E8BE93E585A5E8AFB7E58187E4BA8BE794B171007E0039740004626C757278007871007E003B71007E003C71007E0021740003313131780071007E003F71007E00117400096D61786C656E6774687071007E004674000B6C65617665726561736F6E71007E00487371007E00003F400000000000017708000000020000000171007E004A74000431303025780071007E001471007E001171007E0063740015E8AFB7E8BE93E585A5E8AFB7E58187E4BA8BE794B174000F73686F772D776F72642D6C696D697471007E001171007E004C74000874657874617265617400086175746F73697A657371007E00003F40000000000003770800000004000000027400076D696E526F77737371007E0006000000047400076D6178526F777371007E0086780078007871007E003B71007E003C7800, NULL);
INSERT INTO `act_ge_bytearray` (`ID_`, `REV_`, `NAME_`, `DEPLOYMENT_ID_`, `BYTES_`, `GENERATED_`) VALUES ('3ef44d31-b340-11ed-9d23-869ef1607803', 1, 'hist.var-variables', NULL, 0xACED0005737200176A6176612E7574696C2E4C696E6B6564486173684D617034C04E5C106CC0FB0200015A000B6163636573734F72646572787200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000B740007666F726D5265667400056C65617665740006677574746572737200116A6176612E6C616E672E496E746567657212E2A0A4F781873802000149000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B02000078700000000F74000473697A657400066D656469756D740009666F726D52756C657374000572756C657374000D6C6162656C506F736974696F6E7400057269676874740008666F726D42746E73737200116A6176612E6C616E672E426F6F6C65616ECD207280D59CFAEE0200015A000576616C756578700074000A6C6162656C57696474687371007E00060000006474000864697361626C65647371007E001001740009666F726D4D6F64656C7400096C65617665466F726D7400066669656C6473737200136A6176612E7574696C2E41727261794C6973747881D21D99C7619D03000149000473697A657870000000037704000000037371007E00003F4000000000000C7708000000100000000C740009636C65617261626C6571007E001574000A5F5F636F6E6669675F5F7371007E00003F400000000000187708000000200000000E740006666F726D49647371007E00060000006574000C64656661756C7456616C75657371007E00190000000277040000000274000A323032332D30322D323374000A323032332D30322D323478740008646F63756D656E7474003668747470733A2F2F656C656D656E742E656C656D652E636E2F232F7A682D434E2F636F6D706F6E656E742F646174652D7069636B657271007E0012707400056C6162656C74000CE8AFB7E58187E697B6E997B474000973686F774C6162656C71007E0015740008726571756972656471007E001574000972656E6465724B6579740010313031313634323133383830383939347400066C61796F757474000B636F6C466F726D4974656D74000774616749636F6E74000A646174652D72616E67657400096368616E676554616771007E001574000374616774000E656C2D646174652D7069636B65727400077265674C6973747371007E0019000000017704000000017371007E00003F4000000000000C7708000000100000000371007E002A71007E00157400076D657373616765740018E8AFB7E58187E697B6E997B4E4B88DE883BDE4B8BAE7A9BA740007747269676765727400066368616E67657800787400047370616E7371007E000600000018780074000F72616E67652D736570617261746F72740003E887B3740008726561646F6E6C7971007E001174001173746172742D706C616365686F6C64657274000CE5BC80E5A78BE697A5E69C9F740006666F726D617474000A797979792D4D4D2D646474000C76616C75652D666F726D617474000A797979792D4D4D2D646474000A5F5F764D6F64656C5F5F7400096C6561766574696D657400057374796C657371007E00003F4000000000000177080000000200000001740005776964746874000431303025780071007E001471007E0011740004747970657400096461746572616E676574000F656E642D706C616365686F6C64657274000CE7BB93E69D9FE697A5E69C9F78007371007E00003F4000000000000C7708000000100000000974000A66696C74657261626C6571007E001171007E001C71007E001571007E001D7371007E00003F400000000000187708000000200000000E71007E001F7371007E00060000006671007E002574003168747470733A2F2F656C656D656E742E656C656D652E636E2F232F7A682D434E2F636F6D706F6E656E742F73656C65637471007E00127071007E002774000CE8AFB7E58187E7B1BBE59E8B71007E002971007E001571007E002A71007E001571007E002B7400103130323136343231333837383439313071007E002D74000B636F6C466F726D4974656D71007E002F74000673656C65637471007E003171007E001571007E0032740009656C2D73656C65637471007E00347371007E0019000000017704000000017371007E00003F4000000000000C7708000000100000000371007E002A71007E001571007E0037740012E98089E68BA9E8AFB7E58187E7B1BBE59E8B71007E00397400066368616E676578007871007E003B71007E003C71007E00217371007E00060000000178007400086D756C7469706C6571007E001171007E00467400096C656176657479706571007E00487371007E00003F400000000000017708000000020000000171007E004A74000431303025780071007E001471007E001174000B706C616365686F6C646572740012E98089E68BA9E8AFB7E58187E7B1BBE59E8B7400085F5F736C6F745F5F7371007E00003F40000000000001770800000002000000017400076F7074696F6E737371007E0019000000027704000000027371007E00003F400000000000037708000000040000000271007E0027740006E5B9B4E5818774000576616C756571007E005E78007371007E00003F400000000000037708000000040000000271007E0027740006E8B083E4BC9171007E006B7371007E000600000002780078780078007371007E00003F4000000000000C7708000000100000000A71007E001D7371007E00003F400000000000187708000000200000000E71007E001F71007E002071007E002574003068747470733A2F2F656C656D656E742E656C656D652E636E2F232F7A682D434E2F636F6D706F6E656E742F696E70757471007E00127071007E002774000CE8AFB7E58187E4BA8BE794B171007E002971007E001571007E002A71007E001571007E002B7400103130313136343231333837323630383771007E002D74000B636F6C466F726D4974656D71007E002F740008746578746172656171007E003171007E001571007E0032740008656C2D696E70757471007E00347371007E0019000000017704000000017371007E00003F4000000000000C7708000000100000000371007E002A71007E001571007E0037740015E8AFB7E8BE93E585A5E8AFB7E58187E4BA8BE794B171007E0039740004626C757278007871007E003B71007E003C71007E0021740003313131780071007E003F71007E00117400096D61786C656E6774687071007E004674000B6C65617665726561736F6E71007E00487371007E00003F400000000000017708000000020000000171007E004A74000431303025780071007E001471007E001171007E0063740015E8AFB7E8BE93E585A5E8AFB7E58187E4BA8BE794B174000F73686F772D776F72642D6C696D697471007E001171007E004C74000874657874617265617400086175746F73697A657371007E00003F40000000000003770800000004000000027400076D696E526F77737371007E0006000000047400076D6178526F777371007E0086780078007871007E003B71007E003C7800, NULL);
INSERT INTO `act_ge_bytearray` (`ID_`, `REV_`, `NAME_`, `DEPLOYMENT_ID_`, `BYTES_`, `GENERATED_`) VALUES ('4125bf12-584e-11ee-9923-f22f4b0aefad', 1, 'var-variables', NULL, 0xACED0005737200136A6176612E7574696C2E41727261794C6973747881D21D99C7619D03000149000473697A65787000000001770400000001737200176A6176612E7574696C2E4C696E6B6564486173684D617034C04E5C106CC0FB0200015A000B6163636573734F72646572787200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F400000000000187708000000200000000D740009247265717569726564737200116A6176612E6C616E672E426F6F6C65616ECD207280D59CFAEE0200015A000576616C756578700074000C5F66635F647261675F746167740005696E7075747400056669656C647400046E616D6574000668696464656E71007E0007740007646973706C61797371007E00060174000474797065740005696E7075747400057469746C65740006E5908DE7A7B0740004696E666F74000074000570726F70737371007E00023F400000000000007708000000100000000078007400026F6E7371007E00023F400000000000007708000000100000000078007400076F7074696F6E737371007E000000000000770400000000787400086368696C6472656E7371007E0000000000007704000000007874000576616C7565740003313131780078, NULL);
INSERT INTO `act_ge_bytearray` (`ID_`, `REV_`, `NAME_`, `DEPLOYMENT_ID_`, `BYTES_`, `GENERATED_`) VALUES ('4125bf14-584e-11ee-9923-f22f4b0aefad', 1, 'hist.var-variables', NULL, 0xACED0005737200136A6176612E7574696C2E41727261794C6973747881D21D99C7619D03000149000473697A65787000000001770400000001737200176A6176612E7574696C2E4C696E6B6564486173684D617034C04E5C106CC0FB0200015A000B6163636573734F72646572787200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F400000000000187708000000200000000D740009247265717569726564737200116A6176612E6C616E672E426F6F6C65616ECD207280D59CFAEE0200015A000576616C756578700074000C5F66635F647261675F746167740005696E7075747400056669656C647400046E616D6574000668696464656E71007E0007740007646973706C61797371007E00060174000474797065740005696E7075747400057469746C65740006E5908DE7A7B0740004696E666F74000074000570726F70737371007E00023F400000000000007708000000100000000078007400026F6E7371007E00023F400000000000007708000000100000000078007400076F7074696F6E737371007E000000000000770400000000787400086368696C6472656E7371007E0000000000007704000000007874000576616C7565740003313131780078, NULL);
INSERT INTO `act_ge_bytearray` (`ID_`, `REV_`, `NAME_`, `DEPLOYMENT_ID_`, `BYTES_`, `GENERATED_`) VALUES ('65359e7e-584e-11ee-9923-f22f4b0aefad', 1, 'var-variables', NULL, 0xACED0005737200136A6176612E7574696C2E41727261794C6973747881D21D99C7619D03000149000473697A65787000000001770400000001737200176A6176612E7574696C2E4C696E6B6564486173684D617034C04E5C106CC0FB0200015A000B6163636573734F72646572787200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F400000000000187708000000200000000D740009247265717569726564737200116A6176612E6C616E672E426F6F6C65616ECD207280D59CFAEE0200015A000576616C756578700074000C5F66635F647261675F746167740005696E7075747400056669656C647400046E616D6574000668696464656E71007E0007740007646973706C61797371007E00060174000474797065740005696E7075747400057469746C65740006E5908DE7A7B0740004696E666F74000074000570726F70737371007E00023F400000000000007708000000100000000078007400026F6E7371007E00023F400000000000007708000000100000000078007400076F7074696F6E737371007E000000000000770400000000787400086368696C6472656E7371007E0000000000007704000000007874000576616C7565740003323232780078, NULL);
INSERT INTO `act_ge_bytearray` (`ID_`, `REV_`, `NAME_`, `DEPLOYMENT_ID_`, `BYTES_`, `GENERATED_`) VALUES ('65359e80-584e-11ee-9923-f22f4b0aefad', 1, 'hist.var-variables', NULL, 0xACED0005737200136A6176612E7574696C2E41727261794C6973747881D21D99C7619D03000149000473697A65787000000001770400000001737200176A6176612E7574696C2E4C696E6B6564486173684D617034C04E5C106CC0FB0200015A000B6163636573734F72646572787200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F400000000000187708000000200000000D740009247265717569726564737200116A6176612E6C616E672E426F6F6C65616ECD207280D59CFAEE0200015A000576616C756578700074000C5F66635F647261675F746167740005696E7075747400056669656C647400046E616D6574000668696464656E71007E0007740007646973706C61797371007E00060174000474797065740005696E7075747400057469746C65740006E5908DE7A7B0740004696E666F74000074000570726F70737371007E00023F400000000000007708000000100000000078007400026F6E7371007E00023F400000000000007708000000100000000078007400076F7074696F6E737371007E000000000000770400000000787400086368696C6472656E7371007E0000000000007704000000007874000576616C7565740003323232780078, NULL);
INSERT INTO `act_ge_bytearray` (`ID_`, `REV_`, `NAME_`, `DEPLOYMENT_ID_`, `BYTES_`, `GENERATED_`) VALUES ('987c71d1-b33e-11ed-b511-ce4fe10f37b8', 1, 'test.bpmn', '987c4ac0-b33e-11ed-b511-ce4fe10f37b8', 0x3C3F786D6C2076657273696F6E3D22312E302220656E636F64696E673D225554462D38223F3E0A3C646566696E6974696F6E7320786D6C6E733D22687474703A2F2F7777772E6F6D672E6F72672F737065632F42504D4E2F32303130303532342F4D4F44454C2220786D6C6E733A7873693D22687474703A2F2F7777772E77332E6F72672F323030312F584D4C536368656D612D696E7374616E63652220786D6C6E733A62706D6E64693D22687474703A2F2F7777772E6F6D672E6F72672F737065632F42504D4E2F32303130303532342F44492220786D6C6E733A6F6D6764633D22687474703A2F2F7777772E6F6D672E6F72672F737065632F44442F32303130303532342F44432220786D6C6E733A62696F633D22687474703A2F2F62706D6E2E696F2F736368656D612F62706D6E2F62696F636F6C6F722F312E302220786D6C6E733A666C6F7761626C653D22687474703A2F2F666C6F7761626C652E6F72672F62706D6E2220786D6C6E733A64693D22687474703A2F2F7777772E6F6D672E6F72672F737065632F44442F32303130303532342F44492220786D6C6E733A7873643D22687474703A2F2F7777772E77332E6F72672F323030312F584D4C536368656D6122207461726765744E616D6573706163653D22687474703A2F2F7777772E666C6F7761626C652E6F72672F70726F63657373646566223E0A20203C70726F636573732069643D22746573746F6122206E616D653D22746573742220666C6F7761626C653A70726F6365737343617465676F72793D2231223E0A202020203C73746172744576656E742069643D2273746172744E6F64653122206E616D653D22E5BC80E5A78B223E0A2020202020203C6F7574676F696E673E466C6F775F31396C696770753C2F6F7574676F696E673E0A202020203C2F73746172744576656E743E0A202020203C73657175656E6365466C6F772069643D22466C6F775F31396C696770752220736F757263655265663D2273746172744E6F64653122207461726765745265663D2241637469766974795F31716F3865736622202F3E0A202020203C73657175656E6365466C6F772069643D22466C6F775F31317835777A6A2220736F757263655265663D2241637469766974795F3171666B6F663622207461726765745265663D2241637469766974795F31716F3865736622202F3E0A202020203C757365725461736B2069643D2241637469766974795F31716F3865736622206E616D653D22E7BB8FE79086E5AEA1E689B92220666C6F7761626C653A63616E64696461746547726F7570733D223634313834353132343536393130383438302C312220666C6F7761626C653A64617461547970653D2266697865642220666C6F7761626C653A75736572547970653D2263616E64696461746547726F757073223E0A2020202020203C696E636F6D696E673E466C6F775F31396C696770753C2F696E636F6D696E673E0A2020202020203C696E636F6D696E673E466C6F775F31317835777A6A3C2F696E636F6D696E673E0A2020202020203C6F7574676F696E673E466C6F775F313470676537393C2F6F7574676F696E673E0A202020203C2F757365725461736B3E0A202020203C757365725461736B2069643D2241637469766974795F3171666B6F663622206E616D653D22E9878DE696B0E58F91E8B5B72220666C6F7761626C653A64617461547970653D2266697865642220666C6F7761626C653A61737369676E65653D22247B494E49544941544F527D223E0A2020202020203C696E636F6D696E673E466C6F775F31767573726E733C2F696E636F6D696E673E0A2020202020203C6F7574676F696E673E466C6F775F31317835777A6A3C2F6F7574676F696E673E0A202020203C2F757365725461736B3E0A202020203C6578636C7573697665476174657761792069643D22476174657761795F316E756F753339223E0A2020202020203C696E636F6D696E673E466C6F775F313470676537393C2F696E636F6D696E673E0A2020202020203C6F7574676F696E673E466C6F775F31767573726E733C2F6F7574676F696E673E0A2020202020203C6F7574676F696E673E466C6F775F30347733686A643C2F6F7574676F696E673E0A202020203C2F6578636C7573697665476174657761793E0A202020203C73657175656E6365466C6F772069643D22466C6F775F313470676537392220736F757263655265663D2241637469766974795F31716F3865736622207461726765745265663D22476174657761795F316E756F75333922202F3E0A202020203C73657175656E6365466C6F772069643D22466C6F775F31767573726E7322206E616D653D22E9A9B3E59B9E2220736F757263655265663D22476174657761795F316E756F75333922207461726765745265663D2241637469766974795F3171666B6F6636223E0A2020202020203C636F6E646974696F6E45787072657373696F6E207873693A747970653D2274466F726D616C45787072657373696F6E223E247B617070726F76653D3D27E68B92E7BB9D277D3C2F636F6E646974696F6E45787072657373696F6E3E0A202020203C2F73657175656E6365466C6F773E0A202020203C73657175656E6365466C6F772069643D22466C6F775F30347733686A6422206E616D653D22E5908CE6848F2220736F757263655265663D22476174657761795F316E756F75333922207461726765745265663D2241637469766974795F3065786866797A223E0A2020202020203C636F6E646974696F6E45787072657373696F6E207873693A747970653D2274466F726D616C45787072657373696F6E223E247B617070726F76653D3D27E5908CE6848F277D3C2F636F6E646974696F6E45787072657373696F6E3E0A202020203C2F73657175656E6365466C6F773E0A202020203C757365725461736B2069643D2241637469766974795F3065786866797A22206E616D653D22E9AA8CE694B62220666C6F7761626C653A64617461547970653D2266697865642220666C6F7761626C653A61737369676E65653D22247B494E49544941544F527D223E0A2020202020203C696E636F6D696E673E466C6F775F30347733686A643C2F696E636F6D696E673E0A2020202020203C6F7574676F696E673E466C6F775F316E6D3862646D3C2F6F7574676F696E673E0A202020203C2F757365725461736B3E0A202020203C656E644576656E742069643D224576656E745F30703031623764223E0A2020202020203C696E636F6D696E673E466C6F775F316E6D3862646D3C2F696E636F6D696E673E0A202020203C2F656E644576656E743E0A202020203C73657175656E6365466C6F772069643D22466C6F775F316E6D3862646D2220736F757263655265663D2241637469766974795F3065786866797A22207461726765745265663D224576656E745F3070303162376422202F3E0A20203C2F70726F636573733E0A20203C62706D6E64693A42504D4E4469616772616D2069643D2242504D4E4469616772616D5F666C6F77223E0A202020203C62706D6E64693A42504D4E506C616E652069643D2242504D4E506C616E655F666C6F77222062706D6E456C656D656E743D22746573746F61223E0A2020202020203C62706D6E64693A42504D4E456467652069643D22466C6F775F31767573726E735F6469222062706D6E456C656D656E743D22466C6F775F31767573726E73223E0A20202020202020203C64693A776179706F696E7420783D223232302220793D2232313522202F3E0A20202020202020203C64693A776179706F696E7420783D223232302220793D2233343022202F3E0A20202020202020203C62706D6E64693A42504D4E4C6162656C3E0A202020202020202020203C6F6D6764633A426F756E647320783D223232342220793D22323735222077696474683D22323222206865696768743D22313422202F3E0A20202020202020203C2F62706D6E64693A42504D4E4C6162656C3E0A2020202020203C2F62706D6E64693A42504D4E456467653E0A2020202020203C62706D6E64693A42504D4E456467652069643D22466C6F775F313470676537395F6469222062706D6E456C656D656E743D22466C6F775F31347067653739223E0A20202020202020203C64693A776179706F696E7420783D223130302220793D2231393022202F3E0A20202020202020203C64693A776179706F696E7420783D223139352220793D2231393022202F3E0A2020202020203C2F62706D6E64693A42504D4E456467653E0A2020202020203C62706D6E64693A42504D4E456467652069643D22466C6F775F31317835777A6A5F6469222062706D6E456C656D656E743D22466C6F775F31317835777A6A223E0A20202020202020203C64693A776179706F696E7420783D223137302220793D2233383022202F3E0A20202020202020203C64693A776179706F696E7420783D2234302220793D2233383022202F3E0A20202020202020203C64693A776179706F696E7420783D2234302220793D2232333022202F3E0A2020202020203C2F62706D6E64693A42504D4E456467653E0A2020202020203C62706D6E64693A42504D4E456467652069643D22466C6F775F31396C696770755F6469222062706D6E456C656D656E743D22466C6F775F31396C69677075223E0A20202020202020203C64693A776179706F696E7420783D222D36352220793D2231393022202F3E0A20202020202020203C64693A776179706F696E7420783D22302220793D2231393022202F3E0A2020202020203C2F62706D6E64693A42504D4E456467653E0A2020202020203C62706D6E64693A42504D4E456467652069643D22466C6F775F30347733686A645F6469222062706D6E456C656D656E743D22466C6F775F30347733686A64223E0A20202020202020203C64693A776179706F696E7420783D223234352220793D2231393022202F3E0A20202020202020203C64693A776179706F696E7420783D223334302220793D2231393022202F3E0A20202020202020203C62706D6E64693A42504D4E4C6162656C3E0A202020202020202020203C6F6D6764633A426F756E647320783D223238322220793D22313732222077696474683D22323222206865696768743D22313422202F3E0A20202020202020203C2F62706D6E64693A42504D4E4C6162656C3E0A2020202020203C2F62706D6E64693A42504D4E456467653E0A2020202020203C62706D6E64693A42504D4E456467652069643D22466C6F775F316E6D3862646D5F6469222062706D6E456C656D656E743D22466C6F775F316E6D3862646D223E0A20202020202020203C64693A776179706F696E7420783D223434302220793D2231393022202F3E0A20202020202020203C64693A776179706F696E7420783D223534322220793D2231393022202F3E0A2020202020203C2F62706D6E64693A42504D4E456467653E0A2020202020203C62706D6E64693A42504D4E53686170652069643D2242504D4E53686170655F73746172744E6F646531222062706D6E456C656D656E743D2273746172744E6F646531222062696F633A7374726F6B653D22223E0A20202020202020203C6F6D6764633A426F756E647320783D222D39352220793D22313735222077696474683D22333022206865696768743D22333022202F3E0A20202020202020203C62706D6E64693A42504D4E4C6162656C3E0A202020202020202020203C6F6D6764633A426F756E647320783D222D39322220793D22323132222077696474683D22323222206865696768743D22313422202F3E0A20202020202020203C2F62706D6E64693A42504D4E4C6162656C3E0A2020202020203C2F62706D6E64693A42504D4E53686170653E0A2020202020203C62706D6E64693A42504D4E53686170652069643D2241637469766974795F3069696D6770705F6469222062706D6E456C656D656E743D2241637469766974795F31716F38657366223E0A20202020202020203C6F6D6764633A426F756E647320783D22302220793D22313530222077696474683D2231303022206865696768743D22383022202F3E0A2020202020203C2F62706D6E64693A42504D4E53686170653E0A2020202020203C62706D6E64693A42504D4E53686170652069643D2241637469766974795F3179636A3876795F6469222062706D6E456C656D656E743D2241637469766974795F3171666B6F6636223E0A20202020202020203C6F6D6764633A426F756E647320783D223137302220793D22333430222077696474683D2231303022206865696768743D22383022202F3E0A2020202020203C2F62706D6E64693A42504D4E53686170653E0A2020202020203C62706D6E64693A42504D4E53686170652069643D22476174657761795F303131726C30345F6469222062706D6E456C656D656E743D22476174657761795F316E756F753339222069734D61726B657256697369626C653D2274727565223E0A20202020202020203C6F6D6764633A426F756E647320783D223139352220793D22313635222077696474683D22353022206865696768743D22353022202F3E0A2020202020203C2F62706D6E64693A42504D4E53686170653E0A2020202020203C62706D6E64693A42504D4E53686170652069643D2241637469766974795F31306F3563626E5F6469222062706D6E456C656D656E743D2241637469766974795F3065786866797A223E0A20202020202020203C6F6D6764633A426F756E647320783D223334302220793D22313530222077696474683D2231303022206865696768743D22383022202F3E0A2020202020203C2F62706D6E64693A42504D4E53686170653E0A2020202020203C62706D6E64693A42504D4E53686170652069643D224576656E745F307030316237645F6469222062706D6E456C656D656E743D224576656E745F30703031623764223E0A20202020202020203C6F6D6764633A426F756E647320783D223534322220793D22313732222077696474683D22333622206865696768743D22333622202F3E0A2020202020203C2F62706D6E64693A42504D4E53686170653E0A202020203C2F62706D6E64693A42504D4E506C616E653E0A20203C2F62706D6E64693A42504D4E4469616772616D3E0A3C2F646566696E6974696F6E733E0A, 0);
INSERT INTO `act_ge_bytearray` (`ID_`, `REV_`, `NAME_`, `DEPLOYMENT_ID_`, `BYTES_`, `GENERATED_`) VALUES ('9891a782-b33e-11ed-b511-ce4fe10f37b8', 1, 'test.testoa.png', '987c4ac0-b33e-11ed-b511-ce4fe10f37b8', 0x89504E470D0A1A0A0000000D49484452000002AB000001AE0806000000B73E4FDF000030C949444154785EEDDD09981C659D3F704045C49367BD1114C55BD76B3D50D1A028B02C782C934E0F08E1904B42260B82A268B8548447CC84437415C48BC5150414B966062397281EC88D2077C81F100434A048FDDF5F319DEDBCD38149329954577F3ECFF37B7AFAEDEAEA4AA6E757DF79BBAA6695550000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000060521545B1FA0D37DC70D245175DF4F7A1A1A1E29C73CE51935CE9FFFD9179F3E6DD3E3C3CFCA1FCFB03740FFD74E5977E0A35941AEB0FD30F76B160C18262E1C285C5430F3DA426B9E2FF3DFEFFCF3BEFBCBFA466BB79FE3D02BA837EBAF24B3F851A8A1980F8C1CE7FE0D5E4D7FCF9F3EF4ACDF592FC7B047407FDB43AA59F428DC447556600AA51F17D48CDF5C1FC7B047407FDB43AA59F428DC4313EF90FB95A7915DF8FFC7B047407FDB45AA59F424D8CB7B93E70EFFCE2865F1D575C71EE8165C5D731962FA796AF3457E85EFA69B54A3F859A184F73BDFF9EDB8ACBCFDABFF8FD4F3FB958C5583C962FAF96BD3457E85EFA69B54A3F859A184F73BDE58AD3C634D656DD7AC5E9639657CB5E9A2B742FFDB45AA59F424D8CA7B95E3572E898A6DAAA782C5F5E2D7B69AED0BDF4D36A957E0A35319EE67AF939B3C734D556C563F9F26AD94B7385EEA59F56ABF453A809CDB55AA5B942F7D24FAB55FA29D4C4789A6B9CAD9A37D556C563F9F26AD94B7385EEA59F56ABF453A889F134D7EB2E38724C536D553C962FAF96BD3457E85EFA69B54A3F859A184F73BDFBB6CB8ACBCFFEFC98C61A63F158BEBC5AF6D25CA17BE9A7D52AFD146A623CCD35EA4FBF3E614C738DB17C39B57CA5B9D6DE9AF900F5A19F56ABF453A8897135D7071F2CAEBBF09831CD35C6E2B131CBAB652ECDB5D6DE9B6AC1E82D35A49F56ABF453A889C76BAEF11755AEBD60EE98C6DAAA78CC5F5D99B8D25C6BAB1554F71EBD15586B483FAD56E9A750134B6CAEE937FCF9D70D177F3873BF310D35AF582696352BB0FCA5B9D6523EA39ADFA726F4D36A957E0A35D1A9B93EDE6FFF4B2AB302CB5F9A6BED2C29982E699C2EA69F56ABF453A8894ECD753CBFFD2FA9E2B9F9FAD4F84B73AD95C70BA48FF7385D463FAD56E9A750139D9A6BDE3097B6F2F5A9F197E65A1BE30DA2E35D8E2EA09F56ABF453A8894ECD55ADBCD25C6B616903E8D22E4F45E9A7D52AFDB41EA64F9FFEAC69D3A66DD5683406D3ED50AA3FA5FA5BAA62F436EE0F8D3EBE552C9FAF832EA7B956AB34D7AEB7ACC173599F4785E8A7D52AFDB4BB359BCD0FA4F07972AA874683E9782B963F399E9FAF932EA5B956AB34D7AEB6BC8173799F5F59B367CF5E6DE0889137CE3A72F8B59D2A1EEB3BE9A427E4CF9B3577B87FCF39C3EFCFC7AB4A3FAD56E9A7DD2985CC0D52D8BCB843085D96BA38D697BF065D4673AD5669AE5D6BA282E644ADA752F63EECACA70E0C0EDF3C3077E8E04E356B70F8861458CB8FEE06E60E7F61D6E0C849330787AF4ACFF9D1FF7D3DF4C38139435FCDD75D25FA69B54A3FED2ED3A74F5FA3D1681C9502E62379E81C181828BEF7BDEF15975E7A6971FDF5D71777DF7D7711E236EEC7783C1ECBE5CF8DF5C57A63FDF96B4EB8B44DAB5D74D1451F3DE18413CE3EE08003EEDA77DF7D17EEB6DB6EE53F68D75D77FDC7DE7BEF7D5F1AFBE341071D74F8F6DB6FBF4EFE7C3AD35CAB559A6B579AE88039D1EB5BE9660C9EF1E4143C47660E8EEC32303872C462356768EF81392367EF7ED4C8D3F69C33F4CE8139C39F4EE1F49369F9DBE2363D67DFF4F582726CEEF03E33BF3AF49E7CFD55A19F56ABF4D3EE91B2DC3ACD66F3F7ED21B3BFBFBF38F6D8638B5B6FBDB50CA6E315CBC7F3E2F95968FD5DBC4EFEDA1322BDEE1A679E79E6D7F7DF7FFFBFEFB4D34EC5D1471F5D5C7CF1C51D93758CC7E33BEEB8E33F67CC9871C3C73FFEF14DF2F5B138CDB55AA5B9769D15152C57D47A578A56589D3138EF397B1F73D673F36A85D5787CD6E0B91BA660FAB908ADED558ECD1D7ED7CCAF9EFBBC7CFD55A19F56ABF4D3EE9042EAAB52DDD61E2C0F3DF4D0E2965B6E593C852EA5787EAC270BACB7C4EBE5DBB05C52F8FCC441071DB430A6752FBAE8A2E29FFFFC67BE2D1DC572B1FC9E7BEEF98FDD77DFFD378D46E365F9BA7994E65AADD25CBBCA8A0E942B7AFD93A61556E3EB74FBBB9973877F1A3530387459793CEB68588DC7F79C33FC9681C1913366CD19DEB9BDD2F3CE9A35F7E7AF5F7CCDD5A29F56ABF4D3EA1B9D515D14546336F4B4D34ECB63DD7289F565B3ACB74CC80C6B5AF7AA679D75D6F776D96597E28C33CE281E7EF8E1FCB5C7259E17CF9F3E7DFA03CE0AEB4C73AD5669AE5DA33D48AE9A6ABBD1DBE5D1693DB508AC59583DAB353E6B70F8DC72AC2DACC6C95669995F0DCC1D1E5CAC06872F8D93B15ACFAD22FDB45AA59F565B1C43DAFED1FFF6DB6F5FFCF6B7BFCDA3DC8488F5C6FADB02EBEF96EB18D6B4CE554F3EF9E45FEEB6DB6EC5D5575F9DBFDE3289F5ECB4D34E7F4BC97AC7FCF57A9DE65AADD25CBB421E54BF992ABE6F71BBAC81F5B1D6D3F58175B1B03A77F8E28123CFDDA0AC144ACBB1B6B0FA5F83C36F886566CE1DFAC1AC39C3FF1BB751B1ACB0AA96A6F4D36A1B3D996AD18CEA8A0AAA2DB1FEF619D678FD7C9BC62D665477DD75D762C18205F9EB2C97585F4AD5F74F9D3A75E3FC357B99E65AADD25C2B2F0F8EDBADF268C06C551E34C7A33DA8B66ADBC59618FBBA5D250BABD7A770FA99B2E60EEFBF4A51ACBAD8CCEA9CA119B3E68C6C1A67FECF1A1CDE6FE6E0D01EBB1DFD8BB5E204AB597387775F7CCDD5A29F56ABF4D3EA1ABD3CD53F5BC1F1F4D34FCF63DB0A11AFD336BBFACF65BAACD585175EF88908AA1335A39A4BEB7D64DB6DB7BDA7AFAF6FFDFCB57B95E65AADD25C2BAD5360EC14349726B0767AFE7F8F8EE73ABD7E57987DDCC81A2998FE3C82E9ACC1A12D5AE3318B3A7A8CEA253B1F7BFA9AB38E1A593F6650670C8EBC2885D39FED31F7EC170ECC193E303D3E3D05D703D263A70ECC1D99D2B6EA4AD14FAB55FA69754D6BBB8E6A9C043599B293AE2ECEB7ED31A5E7AF71F0C1072F8C634C57A4534F3DF59EFEFEFE33F3D7EF559A6BB54A73ADACC70A8A9D02E778026BA7E72D29A8B63CD6765456CC9ACE1A1C999B8FA7E0F9E1F23AAB7386778EFB115EA3E2EBD1CB571D1995BE3E64D65786D68EAB05CC9C73CEBA8BAFA53AF4D36A957E5A4DF10977FBC7FFCB7BD6FFD28AD76B3F1C60A93E71FFD9CF7E766C9CF5BFAC27538D57AC7FA79D76BA336DDC46F936F422CDB55AA5B956D2780262A7E0F95881B5D3F28F17545BC6B33DAC04FA69B54A3FADA6698FFE09D53228C6F550578678DDB6D9D593F36DEC283D6FB5CF7EF6B37F8FCB4D4D86F3CF3FFFDEB471BFC8B7A31769AED52ACDB572962618760AA09D026BA7E5C61B545B9666BB9824FA69B54A3FAD9EFEFEFEB552FE7AA81514277B56B5255EB72DAC3E14DB956FEB18175E78E1473EFEF18F8FFB3AAACB2B5E67EBADB7BEB7AFAF6FED7C5BEA22FDE78FA49A928FE734D76A95E63AF1C6FBB3D0C1B204C24E41B43DB0767A7C69836ACBB26C1FCB60BCEF21FDB45AA59F4EAEF1FC9CA4C7B76A85C4F8347D65CAFE34EB56F9B68EF1ED6F7FFB9CF8CB5393E980030EB8BCD168EC966F4B5DB47D031EF3CDA3B956AB34D78937DE9F85CCF204C14E8134EEAFD6617C59836ACBF26C27E334DEF7907E5AADD24F27D7787E4ED2F8DCD672DFFDEE77F36836A9E2F5DBB679CC31F5631C74D041774ED621002DE79E7BEE15D3C67B9C42176AFB063CE69B4773AD5669AE136FBC3F0B6D262200760AACD764F79737A8B64CC4F6F218C6FB1ED24FAB55FAE9E41ACFCF49B3D91C6E3DFEEB5FFF3A8F66932A5EBFB52DB15DEDDBD9D13EFBECB3F0861B6EC8D7B3425D73CD3537A60D2C2F485D471DDE341DDF3C9A6BB54A739D781D7E063AFE2C8C9AC8E0D729B04E74506D99C8ED26D3E1BDD3F13DA49F56ABF4D3C9D5E1E763CCCF49BABDB9353ED9B92F17AFDFB68D3767FF9CB176DD75D747FEFCE73FE7EB59A1EEBEFBEEFBD3C6DD966F4B5D7478B3E455BE7934D76A95E63AF13ABCF7F32A7F16565931812F3EFACF6754E37E8C4FB415B1FDAC32FEF7907E5AADD24F2757879F8BBCE2E7E4AFADFB939DFB72F1FAAD6D69369BF7E5FF9E313EF6B18F15FFF8C73FF2F5AC50E9F5EEEBF01FD973A5B956ABF2EF8F9A9CEAEBEB2BD658638DD8B1ED9DF7A7E5F05833AB9DAE123011F6CEFF6D6AF24A3FAD56E5DF1F55AD9AECDC978BD76FDB9E87F3663AC62EBBECF28FC94ED877DE79E71FA7F5E6CCEAC8B40A7C6CF59BDFFCA678F0C107C78C4F545D70C105C59C3973C68CB7EAAAABAE2A4E39E594F2EBD8965B6FBDB5DC9E5FFEF297E59FE6CD979FAC321330F13AFC0C74FC5958656267263B05D57C8675A203EB446E3F6D3ABC773ABE8756563F5D9EBAECB2CB8AAF7DED6BC5DFFEF6B7318F45FDEFFFFE6FB94C7C1D3DF5D24B2F1DB34C554B3F9D5C1D7E3EC6FC9CC40C666B7CB2735F6EA96756F7DA6BAFFB26FBD8852BAFBCF2D7D37AEB98D5C59A6ACBCA68AE110663166BF6ECD9E5FDF7BEF7BDC53BDEF18EB2DEFCE6372F1ADF7BEFBD8B57BDEA55C56B5EF39A62BDF5D62B5EFDEA5717CF78C6338A673EF3998BEAA94F7D6A71E18517167182DE1E7BEC51CC9C39B3AC785EFAE715F1E77B5B63F1782C1BEB3EE698638A673DEB59E5D72F7EF18B8B2F7CE10BE5D7ABAFBE7AF1FDEF7F7FCC364F5669AE136FBC3F0BA32622F0750AAA718C6AA7AB014C54609D88ED6609C6FB1E5A19FD74BCF5F9CF7FBEECBB6BAEB966F194A73CA5FC77C4F8565B6D55BE178F3AEAA845CBDE77DF7D65488D5FE29FF39CE7145FF9CA578ADB6EBBAD5CEEB8E38E1BB3EEAA967E3AB9C6F37332AD9B8F59DD6FBFFDAE9DECAB019C72CA29A74DEB8DAB018C79B3B45B19CD75C68C1965509C376F5E71CF3DF714071E7860D948A74E9D5A36C34F7CE213E572C3C3C3C58E3BEE5806D4F86B136F7CE31BCB7F537C64FBF297BFBCFC2D3F96BFE4924B8A1FFCE007C5AAABAE5A2E1FF5A10F7DA86CB28D4663D1D86AABAD565EAAE2E73FFF79B1FDF6DB174F7BDAD38AFFF99FFF295EF9CA5716871D7658F99AD1C84F3EF9E4E217BFF8C5A2D984C92CCD75E28DF767A1CDF204BF2505D5C7BACEEAF206D6E5D95EC661BCEFA195D14FC75B7111F4B8AEE449279D54FCDBBFFD5B91F6BBC5DCB9738B273EF189654F7ED2939E54C4252463D9BBEEBAAB7C6F9E75D659C58B5EF4A2B2D7468F8CB14D36D92466A1CADEFA589F5E55A1F4D3C9359E9F93AEBE1AC001071C70F8645F67758F3DF638A3E6D7595DE29BA5DD6437D7134E38A10C959B6DB659194223A43EF0C003E5C75071FFE94F7F7AF1D39FFEB45CF6DE7BEF2D67402374C66CECDBDEF6B6E2D9CF7E76793F66065EF6B29795CDF357BFFA55F1D7BFFEB5D8679F7D8A8D36DAA878FFFBDF5FBCF5AD6F2D1F7BD7BBDE55DE7FDFFBDE577CEA539F2AEEBFFFFEE2C73FFE71F19FFFF99F65308D661B6135D61DB3AF31B6CD36DB948D3B1A79BEFD2BBA34D78937DE9F85CCB204C04E41B4D359FF9D965BD6C0BA2CDBC9521AEF7B68B2FBE9D2567C1A15FD75FDF5D72F9EFFFCE797EFBD97BCE425C576DB6D57ACB3CE3AE5FD980C8899D5F87A6868A80CAB9FFDEC67CB09868F7CE423E56CD4942953CAC01A33AFF96B54A9F4D3C9359E9F9369DD7C9DD5EDB7DF7E9D9D76DAE99F93F817ACEE481B76679DFF82D5784D76738D70184D2FBD74F1DAD7BEB69C3D7DE10B5F58CE7AEEB6DB6EC5BBDFFDEEF2B1985D3DF8E08317EDCC239846008D43043EF399CF945FC7CC673C166135D6BDCB2EBB948D77DF7DF72DB6DD76DBF2B1DD77DFBDBC1FE37148406B3BBEFEF5AF17FFF22FFF525C77DD7565587DE94B5F5ABE6123ACB65E3FDFF6C928CDB552962608760AA09D826A4BA7E59736B02ECDF6310926BB9F2E4DB502681C73FAE4273FB90C9BD3A74F2F674A37DF7CF3F2363E813AF4D043C784D538DC2AEE471F8D7545BF3CE49043C6BC46D54A3FAD9E6915FA0B563367CE7CA42DAC3EFE5FB00A3366CCF8D3641D0A70E289277E376DD82FF26DE8452BA3B97EF18B5F2C67467FFBDBDF96339D1FFEF087CBDFF6E3A3A73BEFBCB37CFCF4D34F2FAEBDF6DA3298AEB5D65AE531A96F7AD39BDA77EC8B2A1E8BF546185D7BEDB58B1D76D8A1F8F77FFFF7F2B17813C6FD08C4ADB01AAFBBF5D65B978F4750CD0F0348BF388DD9E6C92ACDB572C613083B05CFC70AAA2D9D9E37DEC03A9EED6292AD8C7E3ADEBAE69A6BCAF7581C2215B7D177E390806F7EF39BC5EB5FFFFA7299E8B171726A1E56E3BC81F8C429C6E2D3AEB88D43A8F2D7A85AE9A7D5D3DFDFBF56DA2F3FD40A897178CACA10AFDB16541F8AEDCAB7B5A38F7FFCE39BECB9E79EFF78F8E187F3754EA8B4FE5BD2865D3775EAD48DF26DE84593DD5CE378D098458DE345D75D77DD62D6AC59E56101AB2CBEC32EFEF8C73F96CB1F7FFCF1E5C7FEF1317F9CB57FF1C51797B39E6F78C31BCAAFE384A9BBEFBEBB5C36C26834D6B8FDE8473F5AAE271A6CFB782C97DE6BE563114CCF3FFFFC316135B671455EA9E0B14A73ADA4C70A869D02E778826A4BA7E73F5E607DACED61259AEC7EBA3475E59557969F3445FF8C43A35EF08217948702C4E15169D36312A7ECC57FFAD39F1685D5EF7DEF7BE5A157471C7144B170E1C262C30D372C0F918AFEDDEABB552EFDB49A52063BB91514E37C9495215EB72DAC2EDDF94B7BECB1C76FCE38E38C47F2954EA047BEFCE52F1F9736EC8CFCB57BD56437D738B9E99DEF7C6711D7D68D8FF4E300E79FFDEC67E581FD69738A1FFDE847E52C6B1CAF1ACBC799A77102409CB1FFBAD7BDAEFC382ACED88F65E3EB38BB351A6A2C1B61348EC58AF5C6C759B1CC5E7BED55DE8FC3085A61F5EAABAF2E0E3FFCF0F23080B8DF29ACC62108FBEFBFFF98ED5FD1A5B956D69202E276AB2C7B506DE91458B75D6C89FFB3A4EDA00226BB9F2E4D4508FDCE77BE539E18152758C52C6A1CA7BFF1C61B971FEBC72FF46F7FFBDBCB65A3EFAED2F67E6C9D4815570888FB9B6EBAE998F557B1F4D36A9A3A75EAC6ADA0D8DFDF3FE9B3ABF17ACD6673D12100B13DF9363EA6BEBEBEF5B7DF7EFBFB234CAC0829287D3B6DD8FC789DFCB57BD56437D7F8ED3C664DCF3EFBECF2E3FE6F7CE31BE5787C949F36A7983F7FFEA2652330C66FF0114E77DE79E732C446988DD9D2B834557C1D1F63C501FFB17C04D408A01FFCE007CBCB60C5FADEF39EF794F763BCFDE3FDD631ABF17584D5B83A40BC5E2BACC68C6F5C9D20DFFE155D9A6BA5750A8AED417359826ACB78D6D3E9F5A990C9EEA74B537152547CAA1581347A6204CEE8C3D1FBE2D0A898698D8FF863D9389675830D362843EBF39EF7BC32ACDE71C71D8B1D8A15C71B2EE9DAAC5529FDB4BA5216BBB81516E338E9C914AFD736AB7A71BE6DE392D2EE0776D86187BFC5D9DF13E9C61B6F3C3D6DD4ED4B9DA06B6EB29B6B9CB1BFCA68B37BEE739F5B36CCB8CE5F9CAD1F63713C559CA91FD7FC8BFADCE73E57DC7CF3CDC5B7BEF5AD724620DE5C71084004CDD69BEDA0830E2AD71D979B8A13B65A5FC7FA623621EEC7BFB3758DD5B88D99DDF8782B6616E2F8D9F8F82B4E3888701C330D31931BC7CBE6DBBFA24B73ADBC4E81318265CC84760A984BE3B1D6D3E975A998C9EEA74B5371226A9C501AC7A8C66500DFFBDEF796275645BF8DABA8A4CD2F7B5F9C211DE712B49E17C7FB6FB1C51665688D5FE6E37C82582E968F63FFF3D7A952E9A7D595F6B71BA4FDF73F5BFBF1785F4D86789DB6A0FACFD88E7CDBC6ADBFBF7FC7F4DBDE7D1335C33A3AA37A5BAA1DF2D7EA7593DD5C7FFFFBDF973397E99787F2FE79E79D575EE32F7E4B6F5504C8F8B8AAFD797130FF9E7BEEB9D872AD65DB2F66DDAA586F04DA384E2B7F2C9AF57AEBAD575E7D202EC9F2A52F7D69D131B25FFEF297CB061E2765C54705F973577469AE5D61B283E364BF1ECB68B2FBE9D2561CFB1F274BC56100F1917E1CBF1A874AB52A7AEC19679CB1D8736236F5D39FFE74F929559C3710631166E3EA2BB18EFC35AA54FA69B5351A8DA35AC1310E078819FE1529D6DFFEF17FBC7EBE4D4B2D66403FF6B18FDD73EAA9A7DEB3AC275DC5C954A3C7A8DE6146B5B3AA37D75E2BCDB56B4C56809CACD76102E8A7D52AFDB4DAA64F9FBE46CA67BF6B85C7D621292B42AC37BDDEA299DC78DD78FD7C9B96494ABD2F4B69FBAC9D76DAE9CEF3CF3FFFDEF15E87352DB7E0C4134FFC5EDA98EB52FD2CD693AF9B4769AED52ACDB5ABACE820B9A2D7CF04D34FAB55FA69F5A58CB64EAAB84AD3A219D6D34E3B2D8F75CB25D6D73EA33AFA7AEBE4DBB2DCE2325369C5F3B6DE7AEBBFCC9E3DFB0F434343975F73CD3537DF75D75D0FA4EDB8FFFFFDBFFF77C315575CF1EB1FFFF8C7A7CE9831E36769D9BB627997A77A7C9A6BB54A73ED3A2B2A50AEA8F5B202E9A7D52AFDB43BA420F9AAF6C01A1527412DEF5502E2F9D9C95465508DD7CBB76142C55F9C4A2FB46BA3D1382DDD5ED2F68F8BDB4B46C777F597A9C64F73AD5669AE5D69A283E544AF8F49A29F56ABF4D3EE31EDD119D645870444C52C6B5C0F35FEACEFD288E5E379D96C6AF9D17FBC4EFEDA7401CDB55AA5B976AD890A9813B51E5602FDB45AA59F7697388674F4A4AB3C64962754C735D5E3CF055F7FFDF5E51FA508711BF7633C1ECFFE846AAB1E89F54ED831AA4C3ECDB55AA5B976B5E50D9ACBFB7C5632FDB45AA59F76A7D1CB5A2DBA0EEB72D6C5CB75792AAA4173AD5669AE5D6F5903E7B23E8F0AD14FAB55FA69778BEBEE4F7BF44FB33ED421843E56C5F227C7F3F375D2A534D76A95E65A0B4B1B3C9776792A4A3FAD56E9A7F5307DFAF467A5F0B955A3D1184CB743A9FE94EA6FA3C1346EE3FED0E8E35BC5F2F93AE8729A6BB54A73AD8DF106D0F12E4717D04FAB55FA29D484E65AADD25C6BE5F182E8E33D4E97D14FAB55FA29D484E65AADD25C6B6749817449E37431FDB45AA59F424D68AED52ACDB596F2609ADFA726F4D36A957E0A35A1B956AB34D7DA6A05D4BD476F05D51AD24FAB55FA29D484E65AADD25C6BEDBD71F66ADCE60F500FFA69B54A3F859AD05CAB559A6BBD8D86556A4A3FAD56E9A750139A6BB54A73AD3761B5DEF4D36A957E0A35A1B956AB34D77A1356EB4D3FAD56E9A750139A6BB54A73AD3761B5DEF4D36A957E0A35A1B956AB34D77A1356EB4D3FAD56E9A750139A6BB54A73AD3761B5DEF4D36A957E0A35A1B956AB34D77A1356EB4D3FAD56E9A750139A6BB54A73AD3761B5DEF4D36A957E0A35A1B956AB34D77A1356EB4D3FAD56E9A750139A6BB54A73AD3761B5DEF4D36A957E0A35A1B956AB34D77A1356EB4D3FAD56E9A750134343438F2C5CB870CC0FB99AFC4ADF87DB53737D30FF1E511FC26ABDE9A7D529FD146A64DEBC79B72F58B060CC0FBA9AFCBAE9A69B4E4CCDF592FC7B447D08ABF5A69F56A7F453A891E1E1E10F9D77DE797F993F7FFE5DDD3823F0E0830F8E19EBB64AFFEFF36FBCF1C6EFA7C67A73AACDF3EF11F521ACD65BB7F7D33A947E0A35153FD0F11B68AA87E2189F6EA96F7DEB5B457F7F7F71F6D9678F79ACCB2AFEDFE3FF5F63AD3961B5FEE2E778F4E7B9ABFA698D4A3F05AA61CA94294F6C369B57A59DFFDFF3C7A0AA845500E81169A7FF89D8F1371A8D47FAFAFAD6CE1F872A125601A007F4F7F7AF9576FA77C68E7FB40EC997812A125601A007A41DFE57DA826AD49D7D7D7D4FC99783AA115601A0E61A8DC62BD20EFFA12CAC16CD6673A77C59A81A6115006A2EEDEC4FCD836A540AB197E5CB42D508AB0050636947FFFE3CA466F5FEFC395025C22A00D4545F5FDF13D28EFEF71D026AFBECEA69F9F3A04A845500A8A966B3F9DEB4A31F49B757A7DB3FA5BA3B0FABA9FE9942EDFAF973A12A845500E82169C7FFA5145E3F9D6E5F12D56834DE916E5F982F075521AC02400F493BFEA35340DD2D1F87AA125601A087349BCDEFA6DA261F87AA125601A0874C7BF432565BE6E35055C22A00F490B4E31F4935251F87AA125601A087A41DFFA5FDFDFD6FC9C7A1AA845500E82169C77F6D0AAB2FCFC7A1AA845500E82169C77F47B3D97C5E3E0E5525AC02400F493BFEBF6DB1C5166BE6E35055C22A00F4882953A63C31EDF8FF918F439509AB00D023FAFBFBD74A3BFE3FE7E35065C22A00F48814565F9C76FC37E5E35065C22A00F48846A3F1BAB4E3FF433E0E5526AC02408F483BFD77A6BA201F872A135601A047349BCD4D1B8DC699F9385499B00A003D2205D5BE14584FCAC7A1CA845500E81169A7BF63AAFFCEC7A1CA845500E81169A73FABD1681C918F439509AB00D0235250FD5CB3D93C201F872A135601A047A4B07A780AAB7BE5E35065C22A00F488B4D3FF7AAA9DF371A8326115007A44B3D9FC41A3D198968F439509AB00D0235250FD69DAF16F9E8F439509AB00D023D24EFF17A936CCC7A1CA845500E81169A7FFBB46A3F1867C1CAA4C5805801E9176FA37F4F7F7BF341F872A135601A047A49DFE9DCD66F3D9F9385499B00A003D22EDF41FEAEBEB5B3D1F872A135601A0076CB6D9664F8EB09A8F43D509AB00D003E2E3FF380C201F87AA135601A007C4895569A77F7D3E0E5527AC02400F4861F58D71E9AA7C1CAA4E5805801E9076F81BA69A978F43D509AB00D003D20E7FF3543FC9C7A1EA845500E801CD47FD201F87AA135601A007A41DFECEA98ECDC7A1EA845500E8016987BF77AAC3F271A8BA3CAC0E1C31F2AC1983432F9B39E79C75E376F6EC93569FF5950B9F128FCD9E3D7BB581C191AD56298A55637CC6E0B9AF9975D4C8FA9D2A1E9B3178C693DBD70D00AC2469877F60A3D1F85C3E0E553726ACCE1D993273CEF051037386BE3A3077F8FA81237EFEEA81C1E191F4F5FEE9F6E899834387C772FF75E4B9AF48F7AF4ECB1FD6A9660D0E5FB1D7DC9157B5AF1B00584952503DA2D96C0EE4E3507579580D29849E15B3A7037346CE8EFB3306475E343038746D1ABF6DE691E77E20C662E63585DAEF95CB1F31EF057B1D3EF2EC1983F39EF3C9A3469E1F63B3E60C7D67E08891972C5A2900B0F2A41DFE3753ED908F43D52D21AC9ED3BA1D181C993E3077F8E2997346DEBDF731673D378D0DFDD7E0C83B160BAB83C3B7A430FB8D476BF88F3126AC024085A41DFE0F1B8D465F3E0E55D729ACCE1A1C3E376E6386358E3B8D8FFE63E674F7A3469E9682EBF1F1587B586D2DDFFEB5B00A00159282EA99FDFDFD9BE4E3507579582D03E9E0F0D0CCB9C33F1D181CBA6CD69CE19D5358DD6360CED0EC81C191AD670E0E7F3296135601A08BA41DFE85CD6673837C1CAA2E0FAB61F6EC9127CE9A33B2E9C09C91CFCC9C3BD41767FEA7A07A490AA21744988D65DAC36A0AB05745B87D34E00EFF21C6845500A890B4C3BFBCD168BC2E1F87AACBC3EAC09CE14FA7C079E9C0DCE12FA4107A485C1DA01C1F1C3E3102EBECE346D688FBED61B5136115002A24EDF06FEAEBEB5B371F87AACBC3EA3E879EFFF4B88DCB4E0D0C0E9DB2E79CE1B7CC9C3BF483F252568343BBA5007BD1CCAF9EFBD6BD8E1C7A715C9E2A426DC71A1CBE7CD611E7BEB47DDD00C04AD26834EE993E7DFAB3F271A8BA3CACB6A450FAB9547BCE9A3B3C2B05CF8FB6C6FF6BF0E76F8A3F0C1033ABE5F5548F1C7E6DA78A93B2F698FBF3F5DAD70900AC246987FF705F5FDF13F271A8BA25855500A026B6D8628B35D30EFFAFF93874036115006AAEAFAFEFF969877F473E0EDD405805809AEBEFEF7F79DAE15F9B8F4337105601A0E652587D4BDAE1FF3A1F876E20AC0240CD4D9D3A75A3B4C31FC9C7A11B08AB0050736967BF65AA53F371E806C22A00D45CB3D9DC26EDF0BF938F4337105601A0E65258DD3DEDF08FCEC7A11B08AB0050736967BF6FAA2FE5E3D00D845500A8B9B4B33F24D57EF93874036115006A2EEDECE7369BCD19F93874036115006A2EEDEC8F4F6175BB7C1CBA81B00A00359776F627A7FA483E0EDD405805809A4B3BFB73A74E9DBA713E0EDD405805809A4B3BFB5FF6F7F7BF2D1F876E20AC0240CDA59DFD55CD66F355F93874036115006A2EEDEC6FEBEBEB5B3B1F876E20AC0240CD359BCDFBB6DC72CBA7E7E3D00D845500A8B755D3CEFEE1B8CD1F806E20AC02408D6DBDF5D6CF8899D57C1CBA85B00A003516C7AAA69DFDADF938740B6115006AACD168BC3AEDECAFCCC7A15B08AB0050636947FFF6B8CE6A3E0EDD425805801A8BBF5CD56C36CFC9C7A15B08AB0050638D46E3A36967FFA37C1CBA85B00A00359676F4D3531D9F8F43B7105601A0C69ACDE68C46A331988F43B7105601A0C65250FD4CDAD91F928F43B7105601A0C6D28EFE4BA9F6CDC7A15B08AB00506369477F74A3D1D82D1F876E21AC02408D359BCDEFA6DA261F876E21AC02408DA51DFDA9A9B6CCC7A15B08AB00506369473F926A4A3E0EDD425805801A4B3BFA4BFBFBFBDF928F43B7105601A0C6D28EFEDA14565F9E8F43B7105601A0C6D28EFE8E66B3F9BC7C1CBA85B00A00359676F47FDB628B2DD6CCC7A15B08AB00505353A64C7962DAD1FF231F876E22AC02404DF5F7F7AF9576F47FCEC7A19B08AB00505329ACBE38EDE86FCAC7A19B08AB0050538D46E3756947FF877C1CBA89B00A00359576F2EF4C75413E0EDD445805809A6A369B9B361A8D33F371E826C22A00D4540AAA7D29B09E948F43554D7BF4CF03178F5323F9F300802E9476EA3BA6FAEF7C1CAA2ABD5FA77408A7794DC99F070074A1B4539FD568348EC8C7A1CA62E6B4434035AB0A00759382EAE79ACDE601F9385459CC9C7608A9665501A06E52583D3C85D5BDF271A8BA25CCAE9A5505803A493BF7AFA7DA391F87AA5BC2ECEA947C3900A08B359BCD1F341A8D69F93874836C76D5AC2A00D44D0AAA3F4D3BF9CDF371E806D9ECEA94FC7100A0CBA51DFC2F526D988F43B768CDAEE6E300400DA49DFCEF1A8DC61BF271E816ADD9D57C1C00A881B493BFA1BFBFFFA5F938BDA1288AD56FB8E186932EBAE8A2BF0F0D0D15E79C734E575684D57CAC5B2AFDBF3F326FDEBCDB8787873F947F7F00A0E7A59DFC9DCD66F3D9F938BD2105D51FA6A0542C58B0A058B87061F1D0430FA949AEF87F8FFFFFF3CE3BEF2F29BC3A7E1C00DAA5B0FA505F5FDFEAF938BD2166542328E5014A4D7ECD9F3FFFAE14562FC9BF4700D0B336DB6CB3274758CDC7E91DF1D1BF19D56A547C1F52587D30FF1E0140CF8A8FFFE330807C9CDE11C74CE6A149ADBC8AEF47FE3D02809E152756A5B07A7D3E4EEF186F587DE0DEF9C50DBF3AAEB8E2DC03CB8AAF632C5F4E2D5F09AB00D02685D537C6A5ABF2717AC778C2EAFDF7DC565C7ED6FEC5EF7FFAC9C52AC6E2B17C79B5EC25AC02409BF86300A9E6E5E3F48EF184D55BAE386D4C506DD5AD579C3E6679B5EC25AC02409B1454374FF5937C9CDE319EB07AD5C8A163426AABE2B17C79B5EC25AC02409BE6A37E908FD33BC613562F3F67F69890DAAA782C5F5E2D7B09AB00D066DAB4693BA73A361FA77708ABD52A611500DAA4A0BA77AAC3F2717AC778C26A9CFD9F87D456C563F9F26AD94B5805803629A81ED868343E978FD33BC61356AFBBE0C83121B555F158BEBC5AF6125601A04D0AAA47349BCD817C9CDE319EB07AF76D9715979FFDF9314135C6E2B17C79B5EC25AC02409B69D3A67D33D50EF938BD633C6135EA4FBF3E614C588DB17C39B57C25AC02409B14547FD86834FAF2717AC7B8C2EA830F16D75D78CC98B01A63F1D898E5D53297B00A006D52503DB3BFBF7F937C9CDEF1786135FE42D5B517CC1D13545B158FF92B561357C22A00B499366DDA85CD6673837C9CDEB1C4B0FAE083C5FCEB868B3F9CB9DF98809A572C13CB9A655DFE125601A04D0AAB97371A8DD7E5E3F48E4E61F5F166539754665997BF8455006893C2EA4D7D7D7DEBE6E3F48E4E61753CB3A94BAA786EBE3E35FE125601A04DA3D1B867FAF4E9CFCAC7E91D9DC26A1E4097B6F2F5A9F197B00A006DA64D9BF6705F5FDF13F2717A47A7B0AA565E09AB00306A8B2DB6583385D5BFE6E3F41661B55A25AC02C0A8BEBEBEE7A7B07A473E4E6F1156AB55C22A008CEAEFEF7F790AABD7E6E3F41661B55A25AC02C0A81456DF92C2EAAFF3717A8BB05AAD12560160D4D4A953374A6175241FA7B708ABD52A61150046A5A0BA65AA53F3717A8BB05AAD1256016054B3D9DC2685D5EFE4E3F41661B55A25AC02C0A81456774F61F5E87C9CDE22AC56AB845500189582EABEA9BE948FD35B84D56A95B00A00A352503D24D57EF938BD4558AD5609AB00302A05D5B9CD6673463E4E6F1156AB55C22A008C4A61F5F81456B7CBC7E92DC26AB54A5805805129AC9E9CEA23F938BD4558AD5609AB00302A05D573A74E9DBA713E4E6F1156AB55C22A008C4A61F597FDFDFD6FCBC7E92DC26AB54A5805805129AC5ED56C365F958FD35B84D56A95B00A00A35258BDADAFAF6FED7C9CDE22AC56AB84550018D56C36EFDB72CB2D9F9E8FD35B84D56A95B00A008F5A75DAB4698552517960522BAF845500F83FABE603F49E2ACCACDE7BEFBDC5F5D75F5F9C75D659C511471C51DC73CF3D8B3D3E6FDEBCE25BDFFAD698E7DD7FFFFDC5A9A79EBAE8FEFCF9F38BCB2FBFBC58B8706171ECB1C796C12FC6AFBEFAEAE2B6DB6E1BF3FC2BAFBCB238E38C33C68CAFCC12560100DAAC8CB0BAD1461B15CF79CE738AB5D65AAB58638D35229C154F78C2138AE73FFFF9C5DBDFFEF6E2A4934E2A97BBF4D24B8B430F3DB478DFFBDE572EFBE52F7FB9F8CE77BE53ECBAEBAEE53A9EF18C6794CFFDE637BF592E7FD4514715ABAEBA6A71FBEDB7172F78C10B8A7DF6D9A70CB46F78C31B8A17BEF08565906D6D4304DA2F7EF18BC57AEBAD57DEBFF0C20B8BB7BDED6DC57BDEF39EB236D86083E281071E18B3ED2BBA8455008036931D564746468A6DB6D9A6D86AABADCADB2DB6D8A20C9C7BEFBD77B1FFFEFB97F5A94F7DAA181A1A2A675A23D4BEE4252F2936DC70C372B9FDF6DBAFBC6D341AC537BEF18DE2DA6BAF5DB4EE187BDEF39E57CEAA4608EEEBEB2BBF3EECB0C38AA73EF5A965C81D1E1E2E43EBBAEBAE5BAE3B42F2CB5EF6B2F2F50F39E49072D91D77DCB17C8D08B4F9F6AFE812560100DA4C76585DB06041393B3A7DFAF462871D7628FEE33FFEA30C86FDFDFDE5FD183FE18413CAE57EF5AB5F95C7D4BEE635AF293EFCE10F176F7AD39B8A9FFCE427E5F2DB6EBB6DF1D9CF7EB6F8CC673E53CEA8C6BA6316F6A0830E2AB6DB6EBB729999336716071F7CF0A23AF0C0038B1FFDE847C525975C529C78E289E57231031B33B9A79D765A1954E330849D77DE59580500A882C90EAB51C71C73CCA299CE8F7EF4A365308CA01AF7D75C73CDE2E8A38F2E97DB69A79DCAC7DAEBCD6F7E7379BBF6DA6B97CB3EF399CF2CB6DE7AEBC5D6FFD5AF7EB55C263ECE7FFFFBDF5FD6C61B6F5CDC72CB2DE5E3ADD9D93864A075FBEE77BFBBFC3A0E178899DC17BDE8450E03000058D95656584D2F5D7E54BFFAEAAB975FC76DEBF8D5783C96BBF8E28B8B1FFFF8C7E56C6B04C8F83A66656399DFFEF6B7C5073FF8C1E2139FF8C498F5BFF5AD6F2D9789635D639634666423905E76D965E5E37FFDEB5FCBE7C54C6A04DE071F7CB03C34A0B5DE58E69A6BAE29C7F375AFE812560100DAACACB0FAB4A73DAD9831634679EC6ADA8C62975D7629EF3FFDE94F5F34B3DAFA38BEBDD65F7FFDF2360E13E81456E398D8783C4EBE8A93B0E24A03AF7EF5AB8B66B3B9689998318DF01AC7A9AEB6DA6AC5EB5FFFFA45AFD50AAB31E33B30303066DB577409AB00006D5646588DE346E323FEF8D8FF231FF9481912B7DF7EFBF27E8CB7AE0670C71D77149FFFFCE71705D557BCE215E571A9311B1A8F6FB2C9268B85D538C6343ECE8F99D5F3CE3BAF78D2939E54BCF8C52F2E0F15B8F9E69B172D1797C96ABD669C60152775CD9933A71C8B59DC7DF7DDB7BCFA401C139B6FFB8A2E611500A0CDCA08AB71C2D42AD98C697BBDF295AF2C973BFEF8E3CB19D038096A9D75D62983E7BBDEF5AE32B4C6E3F9CC6A5CAA2A968F7FD31FFFF8C7E25FFFF55FCBF5C571A87162566BB96F7FFBDB8B5EAB157CE3125731131BAFF3D297BEB478E73BDF59FCE10F7F18B3ED2BBA8455008036931D56E322FE71667F5C662A3E9AFFC0073E5086C6F8D83DEEC7787C7DCA29A794B3ACB16C9CC91FC1F3AAABAE2A9EFDEC679733A1B1AEF6B01A570588F56CBEF9E6E56CED539EF294F2908108A6EF78C73BCAC7E2FEDCB973CB6359E3A4AB3DF7DCB31C8F93B6E23257718581B842405C9960B3CD362B4FFACAB77F4597B00A00D066B2C3EA91471E596CBAE9A6E525AB9654F1F8E0E060795C6A7CB41F7F0C2002E775D75D579EE17FEBADB796EB8A65F7D8638FF2EB98493DFCF0C3CBCB52C561005FFBDAD78ABFFCE52FE563B18E934F3EB90CA0679F7D7671FAE9A7978722C463F1870722FC46308E901A97CA8AD01CD7803DEEB8E3C66CFF8A2E611500A0CD648755F5D825AC0200B41156AB55C22A00401B61B55A25AC0200B41156AB55C22A00401B61B55A25AC0200B41156AB55C22A00401B61B55A25AC0200B41156AB55C22A00401B61B55A25AC0200B41156AB55C22A00401B61B55A25AC0200B41156AB55C22A00401B61B55A25AC0200B41156AB55C22A00401B61B55A25AC0200B41156AB55C22A00401B61B55A25AC0200B41156AB55C22A00401B61B55A25AC0200B41156AB55C22A00401B61B55A25AC0200B41156AB55C22A00401B61B55A25AC0200B41156AB55C22A00401B61B55A25AC0200B4191A1A7A64E1C2856342939AFC4ADF87DB53587D30FF1E0100F4AC79F3E6DDBE60C18231C1494D7EDD74D34D27A6B07A49FE3D0200E859C3C3C31F3AEFBCF3FE327FFEFCBBCCB0AE9C4AFFEFF36FBCF1C6EFA7A07A73AACDF3EF1100404F8B8014337AA91E8A6326D5A457FCBFC7FFBFA00A0000000000000000000000000000000000000000000000004C8CFF0FE9C8BDD722AA47240000000049454E44AE426082, 1);
INSERT INTO `act_ge_bytearray` (`ID_`, `REV_`, `NAME_`, `DEPLOYMENT_ID_`, `BYTES_`, `GENERATED_`) VALUES ('a5742598-b33e-11ed-b511-ce4fe10f37b8', 1, 'hist.var-leavetime', NULL, 0xACED0005737200136A6176612E7574696C2E41727261794C6973747881D21D99C7619D03000149000473697A6578700000000277040000000274000A323032332D30322D323374000A323032332D30322D323578, NULL);
INSERT INTO `act_ge_bytearray` (`ID_`, `REV_`, `NAME_`, `DEPLOYMENT_ID_`, `BYTES_`, `GENERATED_`) VALUES ('a574259d-b33e-11ed-b511-ce4fe10f37b8', 1, 'hist.var-variables', NULL, 0xACED0005737200176A6176612E7574696C2E4C696E6B6564486173684D617034C04E5C106CC0FB0200015A000B6163636573734F72646572787200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000B740007666F726D5265667400056C65617665740006677574746572737200116A6176612E6C616E672E496E746567657212E2A0A4F781873802000149000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B02000078700000000F74000473697A657400066D656469756D740009666F726D52756C657374000572756C657374000D6C6162656C506F736974696F6E7400057269676874740008666F726D42746E73737200116A6176612E6C616E672E426F6F6C65616ECD207280D59CFAEE0200015A000576616C756578700074000A6C6162656C57696474687371007E00060000006474000864697361626C65647371007E001001740009666F726D4D6F64656C7400096C65617665466F726D7400066669656C6473737200136A6176612E7574696C2E41727261794C6973747881D21D99C7619D03000149000473697A657870000000037704000000037371007E00003F4000000000000C7708000000100000000C740009636C65617261626C6571007E001574000A5F5F636F6E6669675F5F7371007E00003F400000000000187708000000200000000E740006666F726D49647371007E00060000006574000C64656661756C7456616C75657371007E00190000000277040000000274000A323032332D30322D323374000A323032332D30322D323578740008646F63756D656E7474003668747470733A2F2F656C656D656E742E656C656D652E636E2F232F7A682D434E2F636F6D706F6E656E742F646174652D7069636B657271007E0012707400056C6162656C74000CE8AFB7E58187E697B6E997B474000973686F774C6162656C71007E0015740008726571756972656471007E001574000972656E6465724B6579740010313031313634323133383830383939347400066C61796F757474000B636F6C466F726D4974656D74000774616749636F6E74000A646174652D72616E67657400096368616E676554616771007E001574000374616774000E656C2D646174652D7069636B65727400077265674C6973747371007E0019000000017704000000017371007E00003F4000000000000C7708000000100000000371007E002A71007E00157400076D657373616765740018E8AFB7E58187E697B6E997B4E4B88DE883BDE4B8BAE7A9BA740007747269676765727400066368616E67657800787400047370616E7371007E000600000018780074000F72616E67652D736570617261746F72740003E887B3740008726561646F6E6C7971007E001174001173746172742D706C616365686F6C64657274000CE5BC80E5A78BE697A5E69C9F740006666F726D617474000A797979792D4D4D2D646474000C76616C75652D666F726D617474000A797979792D4D4D2D646474000A5F5F764D6F64656C5F5F7400096C6561766574696D657400057374796C657371007E00003F4000000000000177080000000200000001740005776964746874000431303025780071007E001471007E0011740004747970657400096461746572616E676574000F656E642D706C616365686F6C64657274000CE7BB93E69D9FE697A5E69C9F78007371007E00003F4000000000000C7708000000100000000974000A66696C74657261626C6571007E001171007E001C71007E001571007E001D7371007E00003F400000000000187708000000200000000E71007E001F7371007E00060000006671007E002574003168747470733A2F2F656C656D656E742E656C656D652E636E2F232F7A682D434E2F636F6D706F6E656E742F73656C65637471007E00127071007E002774000CE8AFB7E58187E7B1BBE59E8B71007E002971007E001571007E002A71007E001571007E002B7400103130323136343231333837383439313071007E002D74000B636F6C466F726D4974656D71007E002F74000673656C65637471007E003171007E001571007E0032740009656C2D73656C65637471007E00347371007E0019000000017704000000017371007E00003F4000000000000C7708000000100000000371007E002A71007E001571007E0037740012E98089E68BA9E8AFB7E58187E7B1BBE59E8B71007E00397400066368616E676578007871007E003B71007E003C71007E00217371007E00060000000178007400086D756C7469706C6571007E001171007E00467400096C656176657479706571007E00487371007E00003F400000000000017708000000020000000171007E004A74000431303025780071007E001471007E001174000B706C616365686F6C646572740012E98089E68BA9E8AFB7E58187E7B1BBE59E8B7400085F5F736C6F745F5F7371007E00003F40000000000001770800000002000000017400076F7074696F6E737371007E0019000000027704000000027371007E00003F400000000000037708000000040000000271007E0027740006E5B9B4E5818774000576616C756571007E005E78007371007E00003F400000000000037708000000040000000271007E0027740006E8B083E4BC9171007E006B7371007E000600000002780078780078007371007E00003F4000000000000C7708000000100000000A71007E001D7371007E00003F400000000000187708000000200000000E71007E001F71007E002071007E002574003068747470733A2F2F656C656D656E742E656C656D652E636E2F232F7A682D434E2F636F6D706F6E656E742F696E70757471007E00127071007E002774000CE8AFB7E58187E4BA8BE794B171007E002971007E001571007E002A71007E001571007E002B7400103130313136343231333837323630383771007E002D74000B636F6C466F726D4974656D71007E002F740008746578746172656171007E003171007E001571007E0032740008656C2D696E70757471007E00347371007E0019000000017704000000017371007E00003F4000000000000C7708000000100000000371007E002A71007E001571007E0037740015E8AFB7E8BE93E585A5E8AFB7E58187E4BA8BE794B171007E0039740004626C757278007871007E003B71007E003C71007E0021740003313131780071007E003F71007E00117400096D61786C656E6774687071007E004674000B6C65617665726561736F6E71007E00487371007E00003F400000000000017708000000020000000171007E004A74000431303025780071007E001471007E001171007E0063740015E8AFB7E8BE93E585A5E8AFB7E58187E4BA8BE794B174000F73686F772D776F72642D6C696D697471007E001171007E004C74000874657874617265617400086175746F73697A657371007E00003F40000000000003770800000004000000027400076D696E526F77737371007E0006000000047400076D6178526F777371007E0086780078007871007E003B71007E003C7800, NULL);
INSERT INTO `act_ge_bytearray` (`ID_`, `REV_`, `NAME_`, `DEPLOYMENT_ID_`, `BYTES_`, `GENERATED_`) VALUES ('b7a60496-5851-11ee-9923-f22f4b0aefad', 1, 'var-variables', NULL, 0xACED0005737200136A6176612E7574696C2E41727261794C6973747881D21D99C7619D03000149000473697A65787000000001770400000001737200176A6176612E7574696C2E4C696E6B6564486173684D617034C04E5C106CC0FB0200015A000B6163636573734F72646572787200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F400000000000187708000000200000000D740009247265717569726564737200116A6176612E6C616E672E426F6F6C65616ECD207280D59CFAEE0200015A000576616C756578700074000C5F66635F647261675F746167740005696E7075747400056669656C647400046E616D6574000668696464656E71007E0007740007646973706C61797371007E00060174000474797065740005696E7075747400057469746C65740006E5908DE7A7B0740004696E666F74000074000570726F70737371007E00023F400000000000007708000000100000000078007400026F6E7371007E00023F400000000000007708000000100000000078007400076F7074696F6E737371007E000000000000770400000000787400086368696C6472656E7371007E0000000000007704000000007874000576616C756574000433333333780078, NULL);
INSERT INTO `act_ge_bytearray` (`ID_`, `REV_`, `NAME_`, `DEPLOYMENT_ID_`, `BYTES_`, `GENERATED_`) VALUES ('b7a60498-5851-11ee-9923-f22f4b0aefad', 1, 'hist.var-variables', NULL, 0xACED0005737200136A6176612E7574696C2E41727261794C6973747881D21D99C7619D03000149000473697A65787000000001770400000001737200176A6176612E7574696C2E4C696E6B6564486173684D617034C04E5C106CC0FB0200015A000B6163636573734F72646572787200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F400000000000187708000000200000000D740009247265717569726564737200116A6176612E6C616E672E426F6F6C65616ECD207280D59CFAEE0200015A000576616C756578700074000C5F66635F647261675F746167740005696E7075747400056669656C647400046E616D6574000668696464656E71007E0007740007646973706C61797371007E00060174000474797065740005696E7075747400057469746C65740006E5908DE7A7B0740004696E666F74000074000570726F70737371007E00023F400000000000007708000000100000000078007400026F6E7371007E00023F400000000000007708000000100000000078007400076F7074696F6E737371007E000000000000770400000000787400086368696C6472656E7371007E0000000000007704000000007874000576616C756574000433333333780078, NULL);
INSERT INTO `act_ge_bytearray` (`ID_`, `REV_`, `NAME_`, `DEPLOYMENT_ID_`, `BYTES_`, `GENERATED_`) VALUES ('b8069e08-b345-11ed-8617-ce4fe10f37b8', 1, 'var-leavetime', NULL, 0xACED0005737200136A6176612E7574696C2E41727261794C6973747881D21D99C7619D03000149000473697A6578700000000277040000000274000A323032332D30322D323474000A323032332D30322D323578, NULL);
INSERT INTO `act_ge_bytearray` (`ID_`, `REV_`, `NAME_`, `DEPLOYMENT_ID_`, `BYTES_`, `GENERATED_`) VALUES ('b806ec2a-b345-11ed-8617-ce4fe10f37b8', 1, 'hist.var-leavetime', NULL, 0xACED0005737200136A6176612E7574696C2E41727261794C6973747881D21D99C7619D03000149000473697A6578700000000277040000000274000A323032332D30322D323474000A323032332D30322D323578, NULL);
INSERT INTO `act_ge_bytearray` (`ID_`, `REV_`, `NAME_`, `DEPLOYMENT_ID_`, `BYTES_`, `GENERATED_`) VALUES ('b807133d-b345-11ed-8617-ce4fe10f37b8', 1, 'var-variables', NULL, 0xACED0005737200176A6176612E7574696C2E4C696E6B6564486173684D617034C04E5C106CC0FB0200015A000B6163636573734F72646572787200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000B740007666F726D5265667400056C65617665740006677574746572737200116A6176612E6C616E672E496E746567657212E2A0A4F781873802000149000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B02000078700000000F74000473697A657400066D656469756D740009666F726D52756C657374000572756C657374000D6C6162656C506F736974696F6E7400057269676874740008666F726D42746E73737200116A6176612E6C616E672E426F6F6C65616ECD207280D59CFAEE0200015A000576616C756578700074000A6C6162656C57696474687371007E00060000006474000864697361626C65647371007E001001740009666F726D4D6F64656C7400096C65617665466F726D7400066669656C6473737200136A6176612E7574696C2E41727261794C6973747881D21D99C7619D03000149000473697A657870000000037704000000037371007E00003F4000000000000C7708000000100000000C740009636C65617261626C6571007E001574000A5F5F636F6E6669675F5F7371007E00003F400000000000187708000000200000000E740006666F726D49647371007E00060000006574000C64656661756C7456616C75657371007E00190000000277040000000274000A323032332D30322D323474000A323032332D30322D323578740008646F63756D656E7474003668747470733A2F2F656C656D656E742E656C656D652E636E2F232F7A682D434E2F636F6D706F6E656E742F646174652D7069636B657271007E0012707400056C6162656C74000CE8AFB7E58187E697B6E997B474000973686F774C6162656C71007E0015740008726571756972656471007E001574000972656E6465724B6579740010313031313634323133383830383939347400066C61796F757474000B636F6C466F726D4974656D74000774616749636F6E74000A646174652D72616E67657400096368616E676554616771007E001574000374616774000E656C2D646174652D7069636B65727400077265674C6973747371007E0019000000017704000000017371007E00003F4000000000000C7708000000100000000371007E002A71007E00157400076D657373616765740018E8AFB7E58187E697B6E997B4E4B88DE883BDE4B8BAE7A9BA740007747269676765727400066368616E67657800787400047370616E7371007E000600000018780074000F72616E67652D736570617261746F72740003E887B3740008726561646F6E6C7971007E001174001173746172742D706C616365686F6C64657274000CE5BC80E5A78BE697A5E69C9F740006666F726D617474000A797979792D4D4D2D646474000C76616C75652D666F726D617474000A797979792D4D4D2D646474000A5F5F764D6F64656C5F5F7400096C6561766574696D657400057374796C657371007E00003F4000000000000177080000000200000001740005776964746874000431303025780071007E001471007E0011740004747970657400096461746572616E676574000F656E642D706C616365686F6C64657274000CE7BB93E69D9FE697A5E69C9F78007371007E00003F4000000000000C7708000000100000000974000A66696C74657261626C6571007E001171007E001C71007E001571007E001D7371007E00003F400000000000187708000000200000000E71007E001F7371007E00060000006671007E002574003168747470733A2F2F656C656D656E742E656C656D652E636E2F232F7A682D434E2F636F6D706F6E656E742F73656C65637471007E00127071007E002774000CE8AFB7E58187E7B1BBE59E8B71007E002971007E001571007E002A71007E001571007E002B7400103130323136343231333837383439313071007E002D74000B636F6C466F726D4974656D71007E002F74000673656C65637471007E003171007E001571007E0032740009656C2D73656C65637471007E00347371007E0019000000017704000000017371007E00003F4000000000000C7708000000100000000371007E002A71007E001571007E0037740012E98089E68BA9E8AFB7E58187E7B1BBE59E8B71007E00397400066368616E676578007871007E003B71007E003C71007E00217371007E00060000000178007400086D756C7469706C6571007E001171007E00467400096C656176657479706571007E00487371007E00003F400000000000017708000000020000000171007E004A74000431303025780071007E001471007E001174000B706C616365686F6C646572740012E98089E68BA9E8AFB7E58187E7B1BBE59E8B7400085F5F736C6F745F5F7371007E00003F40000000000001770800000002000000017400076F7074696F6E737371007E0019000000027704000000027371007E00003F400000000000037708000000040000000271007E0027740006E5B9B4E5818774000576616C756571007E005E78007371007E00003F400000000000037708000000040000000271007E0027740006E8B083E4BC9171007E006B7371007E000600000002780078780078007371007E00003F4000000000000C7708000000100000000A71007E001D7371007E00003F400000000000187708000000200000000E71007E001F71007E002071007E002574003068747470733A2F2F656C656D656E742E656C656D652E636E2F232F7A682D434E2F636F6D706F6E656E742F696E70757471007E00127071007E002774000CE8AFB7E58187E4BA8BE794B171007E002971007E001571007E002A71007E001571007E002B7400103130313136343231333837323630383771007E002D74000B636F6C466F726D4974656D71007E002F740008746578746172656171007E003171007E001571007E0032740008656C2D696E70757471007E00347371007E0019000000017704000000017371007E00003F4000000000000C7708000000100000000371007E002A71007E001571007E0037740015E8AFB7E8BE93E585A5E8AFB7E58187E4BA8BE794B171007E0039740004626C757278007871007E003B71007E003C71007E00217400023434780071007E003F71007E00117400096D61786C656E6774687071007E004674000B6C65617665726561736F6E71007E00487371007E00003F400000000000017708000000020000000171007E004A74000431303025780071007E001471007E001171007E0063740015E8AFB7E8BE93E585A5E8AFB7E58187E4BA8BE794B174000F73686F772D776F72642D6C696D697471007E001171007E004C74000874657874617265617400086175746F73697A657371007E00003F40000000000003770800000004000000027400076D696E526F77737371007E0006000000047400076D6178526F777371007E0086780078007871007E003B71007E003C7800, NULL);
INSERT INTO `act_ge_bytearray` (`ID_`, `REV_`, `NAME_`, `DEPLOYMENT_ID_`, `BYTES_`, `GENERATED_`) VALUES ('b807133f-b345-11ed-8617-ce4fe10f37b8', 1, 'hist.var-variables', NULL, 0xACED0005737200176A6176612E7574696C2E4C696E6B6564486173684D617034C04E5C106CC0FB0200015A000B6163636573734F72646572787200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000B740007666F726D5265667400056C65617665740006677574746572737200116A6176612E6C616E672E496E746567657212E2A0A4F781873802000149000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B02000078700000000F74000473697A657400066D656469756D740009666F726D52756C657374000572756C657374000D6C6162656C506F736974696F6E7400057269676874740008666F726D42746E73737200116A6176612E6C616E672E426F6F6C65616ECD207280D59CFAEE0200015A000576616C756578700074000A6C6162656C57696474687371007E00060000006474000864697361626C65647371007E001001740009666F726D4D6F64656C7400096C65617665466F726D7400066669656C6473737200136A6176612E7574696C2E41727261794C6973747881D21D99C7619D03000149000473697A657870000000037704000000037371007E00003F4000000000000C7708000000100000000C740009636C65617261626C6571007E001574000A5F5F636F6E6669675F5F7371007E00003F400000000000187708000000200000000E740006666F726D49647371007E00060000006574000C64656661756C7456616C75657371007E00190000000277040000000274000A323032332D30322D323474000A323032332D30322D323578740008646F63756D656E7474003668747470733A2F2F656C656D656E742E656C656D652E636E2F232F7A682D434E2F636F6D706F6E656E742F646174652D7069636B657271007E0012707400056C6162656C74000CE8AFB7E58187E697B6E997B474000973686F774C6162656C71007E0015740008726571756972656471007E001574000972656E6465724B6579740010313031313634323133383830383939347400066C61796F757474000B636F6C466F726D4974656D74000774616749636F6E74000A646174652D72616E67657400096368616E676554616771007E001574000374616774000E656C2D646174652D7069636B65727400077265674C6973747371007E0019000000017704000000017371007E00003F4000000000000C7708000000100000000371007E002A71007E00157400076D657373616765740018E8AFB7E58187E697B6E997B4E4B88DE883BDE4B8BAE7A9BA740007747269676765727400066368616E67657800787400047370616E7371007E000600000018780074000F72616E67652D736570617261746F72740003E887B3740008726561646F6E6C7971007E001174001173746172742D706C616365686F6C64657274000CE5BC80E5A78BE697A5E69C9F740006666F726D617474000A797979792D4D4D2D646474000C76616C75652D666F726D617474000A797979792D4D4D2D646474000A5F5F764D6F64656C5F5F7400096C6561766574696D657400057374796C657371007E00003F4000000000000177080000000200000001740005776964746874000431303025780071007E001471007E0011740004747970657400096461746572616E676574000F656E642D706C616365686F6C64657274000CE7BB93E69D9FE697A5E69C9F78007371007E00003F4000000000000C7708000000100000000974000A66696C74657261626C6571007E001171007E001C71007E001571007E001D7371007E00003F400000000000187708000000200000000E71007E001F7371007E00060000006671007E002574003168747470733A2F2F656C656D656E742E656C656D652E636E2F232F7A682D434E2F636F6D706F6E656E742F73656C65637471007E00127071007E002774000CE8AFB7E58187E7B1BBE59E8B71007E002971007E001571007E002A71007E001571007E002B7400103130323136343231333837383439313071007E002D74000B636F6C466F726D4974656D71007E002F74000673656C65637471007E003171007E001571007E0032740009656C2D73656C65637471007E00347371007E0019000000017704000000017371007E00003F4000000000000C7708000000100000000371007E002A71007E001571007E0037740012E98089E68BA9E8AFB7E58187E7B1BBE59E8B71007E00397400066368616E676578007871007E003B71007E003C71007E00217371007E00060000000178007400086D756C7469706C6571007E001171007E00467400096C656176657479706571007E00487371007E00003F400000000000017708000000020000000171007E004A74000431303025780071007E001471007E001174000B706C616365686F6C646572740012E98089E68BA9E8AFB7E58187E7B1BBE59E8B7400085F5F736C6F745F5F7371007E00003F40000000000001770800000002000000017400076F7074696F6E737371007E0019000000027704000000027371007E00003F400000000000037708000000040000000271007E0027740006E5B9B4E5818774000576616C756571007E005E78007371007E00003F400000000000037708000000040000000271007E0027740006E8B083E4BC9171007E006B7371007E000600000002780078780078007371007E00003F4000000000000C7708000000100000000A71007E001D7371007E00003F400000000000187708000000200000000E71007E001F71007E002071007E002574003068747470733A2F2F656C656D656E742E656C656D652E636E2F232F7A682D434E2F636F6D706F6E656E742F696E70757471007E00127071007E002774000CE8AFB7E58187E4BA8BE794B171007E002971007E001571007E002A71007E001571007E002B7400103130313136343231333837323630383771007E002D74000B636F6C466F726D4974656D71007E002F740008746578746172656171007E003171007E001571007E0032740008656C2D696E70757471007E00347371007E0019000000017704000000017371007E00003F4000000000000C7708000000100000000371007E002A71007E001571007E0037740015E8AFB7E8BE93E585A5E8AFB7E58187E4BA8BE794B171007E0039740004626C757278007871007E003B71007E003C71007E00217400023434780071007E003F71007E00117400096D61786C656E6774687071007E004674000B6C65617665726561736F6E71007E00487371007E00003F400000000000017708000000020000000171007E004A74000431303025780071007E001471007E001171007E0063740015E8AFB7E8BE93E585A5E8AFB7E58187E4BA8BE794B174000F73686F772D776F72642D6C696D697471007E001171007E004C74000874657874617265617400086175746F73697A657371007E00003F40000000000003770800000004000000027400076D696E526F77737371007E0006000000047400076D6178526F777371007E0086780078007871007E003B71007E003C7800, NULL);
INSERT INTO `act_ge_bytearray` (`ID_`, `REV_`, `NAME_`, `DEPLOYMENT_ID_`, `BYTES_`, `GENERATED_`) VALUES ('bb8f69b5-246c-11ee-8f95-36d2b240f315', 1, 'hist.var-leavetime', NULL, 0xACED0005737200136A6176612E7574696C2E41727261794C6973747881D21D99C7619D03000149000473697A6578700000000277040000000274000A323032332D30372D303474000A323032332D30372D313778, NULL);
INSERT INTO `act_ge_bytearray` (`ID_`, `REV_`, `NAME_`, `DEPLOYMENT_ID_`, `BYTES_`, `GENERATED_`) VALUES ('bb902d0a-246c-11ee-8f95-36d2b240f315', 1, 'hist.var-variables', NULL, 0xACED0005737200176A6176612E7574696C2E4C696E6B6564486173684D617034C04E5C106CC0FB0200015A000B6163636573734F72646572787200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000B740007666F726D5265667400056C65617665740006677574746572737200116A6176612E6C616E672E496E746567657212E2A0A4F781873802000149000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B02000078700000000F74000473697A657400066D656469756D740009666F726D52756C657374000572756C657374000D6C6162656C506F736974696F6E7400057269676874740008666F726D42746E73737200116A6176612E6C616E672E426F6F6C65616ECD207280D59CFAEE0200015A000576616C756578700074000A6C6162656C57696474687371007E00060000006474000864697361626C65647371007E001001740009666F726D4D6F64656C7400096C65617665466F726D7400066669656C6473737200136A6176612E7574696C2E41727261794C6973747881D21D99C7619D03000149000473697A657870000000037704000000037371007E00003F4000000000000C7708000000100000000C740009636C65617261626C6571007E001574000A5F5F636F6E6669675F5F7371007E00003F400000000000187708000000200000000E740006666F726D49647371007E00060000006574000C64656661756C7456616C75657371007E00190000000277040000000274000A323032332D30372D303474000A323032332D30372D313778740008646F63756D656E7474003668747470733A2F2F656C656D656E742E656C656D652E636E2F232F7A682D434E2F636F6D706F6E656E742F646174652D7069636B657271007E0012707400056C6162656C74000CE8AFB7E58187E697B6E997B474000973686F774C6162656C71007E0015740008726571756972656471007E001574000972656E6465724B6579740010313031313634323133383830383939347400066C61796F757474000B636F6C466F726D4974656D74000774616749636F6E74000A646174652D72616E67657400096368616E676554616771007E001574000374616774000E656C2D646174652D7069636B65727400077265674C6973747371007E0019000000017704000000017371007E00003F4000000000000C7708000000100000000371007E002A71007E00157400076D657373616765740018E8AFB7E58187E697B6E997B4E4B88DE883BDE4B8BAE7A9BA740007747269676765727400066368616E67657800787400047370616E7371007E000600000018780074000F72616E67652D736570617261746F72740003E887B3740008726561646F6E6C7971007E001174001173746172742D706C616365686F6C64657274000CE5BC80E5A78BE697A5E69C9F740006666F726D617474000A797979792D4D4D2D646474000C76616C75652D666F726D617474000A797979792D4D4D2D646474000A5F5F764D6F64656C5F5F7400096C6561766574696D657400057374796C657371007E00003F4000000000000177080000000200000001740005776964746874000431303025780071007E001471007E0011740004747970657400096461746572616E676574000F656E642D706C616365686F6C64657274000CE7BB93E69D9FE697A5E69C9F78007371007E00003F4000000000000C7708000000100000000974000A66696C74657261626C6571007E001171007E001C71007E001571007E001D7371007E00003F400000000000187708000000200000000E71007E001F7371007E00060000006671007E002574003168747470733A2F2F656C656D656E742E656C656D652E636E2F232F7A682D434E2F636F6D706F6E656E742F73656C65637471007E00127071007E002774000CE8AFB7E58187E7B1BBE59E8B71007E002971007E001571007E002A71007E001571007E002B7400103130323136343231333837383439313071007E002D74000B636F6C466F726D4974656D71007E002F74000673656C65637471007E003171007E001571007E0032740009656C2D73656C65637471007E00347371007E0019000000017704000000017371007E00003F4000000000000C7708000000100000000371007E002A71007E001571007E0037740012E98089E68BA9E8AFB7E58187E7B1BBE59E8B71007E00397400066368616E676578007871007E003B71007E003C71007E00217371007E00060000000278007400086D756C7469706C6571007E001171007E00467400096C656176657479706571007E00487371007E00003F400000000000017708000000020000000171007E004A74000431303025780071007E001471007E001174000B706C616365686F6C646572740012E98089E68BA9E8AFB7E58187E7B1BBE59E8B7400085F5F736C6F745F5F7371007E00003F40000000000001770800000002000000017400076F7074696F6E737371007E0019000000027704000000027371007E00003F400000000000037708000000040000000271007E0027740006E5B9B4E5818774000576616C75657371007E00060000000178007371007E00003F400000000000037708000000040000000271007E0027740006E8B083E4BC9171007E006B71007E005E780078780078007371007E00003F4000000000000C7708000000100000000A71007E001D7371007E00003F400000000000187708000000200000000E71007E001F71007E002071007E002574003068747470733A2F2F656C656D656E742E656C656D652E636E2F232F7A682D434E2F636F6D706F6E656E742F696E70757471007E00127071007E002774000CE8AFB7E58187E4BA8BE794B171007E002971007E001571007E002A71007E001571007E002B7400103130313136343231333837323630383771007E002D74000B636F6C466F726D4974656D71007E002F740008746578746172656171007E003171007E001571007E0032740008656C2D696E70757471007E00347371007E0019000000017704000000017371007E00003F4000000000000C7708000000100000000371007E002A71007E001571007E0037740015E8AFB7E8BE93E585A5E8AFB7E58187E4BA8BE794B171007E0039740004626C757278007871007E003B71007E003C71007E002174000431313131780071007E003F71007E00117400096D61786C656E6774687071007E004674000B6C65617665726561736F6E71007E00487371007E00003F400000000000017708000000020000000171007E004A74000431303025780071007E001471007E001171007E0063740015E8AFB7E8BE93E585A5E8AFB7E58187E4BA8BE794B174000F73686F772D776F72642D6C696D697471007E001171007E004C74000874657874617265617400086175746F73697A657371007E00003F40000000000003770800000004000000027400076D696E526F77737371007E0006000000047400076D6178526F777371007E0086780078007871007E003B71007E003C7800, NULL);
INSERT INTO `act_ge_bytearray` (`ID_`, `REV_`, `NAME_`, `DEPLOYMENT_ID_`, `BYTES_`, `GENERATED_`) VALUES ('d48dfd1f-b33f-11ed-9d23-869ef1607803', 1, 'var-leavetime', NULL, 0xACED0005737200136A6176612E7574696C2E41727261794C6973747881D21D99C7619D03000149000473697A6578700000000277040000000274000A323032332D30322D323374000A323032332D30332D303278, NULL);
INSERT INTO `act_ge_bytearray` (`ID_`, `REV_`, `NAME_`, `DEPLOYMENT_ID_`, `BYTES_`, `GENERATED_`) VALUES ('d48e4b41-b33f-11ed-9d23-869ef1607803', 1, 'hist.var-leavetime', NULL, 0xACED0005737200136A6176612E7574696C2E41727261794C6973747881D21D99C7619D03000149000473697A6578700000000277040000000274000A323032332D30322D323374000A323032332D30332D303278, NULL);
INSERT INTO `act_ge_bytearray` (`ID_`, `REV_`, `NAME_`, `DEPLOYMENT_ID_`, `BYTES_`, `GENERATED_`) VALUES ('d48e4b44-b33f-11ed-9d23-869ef1607803', 1, 'var-variables', NULL, 0xACED0005737200176A6176612E7574696C2E4C696E6B6564486173684D617034C04E5C106CC0FB0200015A000B6163636573734F72646572787200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000B740007666F726D5265667400056C65617665740006677574746572737200116A6176612E6C616E672E496E746567657212E2A0A4F781873802000149000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B02000078700000000F74000473697A657400066D656469756D740009666F726D52756C657374000572756C657374000D6C6162656C506F736974696F6E7400057269676874740008666F726D42746E73737200116A6176612E6C616E672E426F6F6C65616ECD207280D59CFAEE0200015A000576616C756578700074000A6C6162656C57696474687371007E00060000006474000864697361626C65647371007E001001740009666F726D4D6F64656C7400096C65617665466F726D7400066669656C6473737200136A6176612E7574696C2E41727261794C6973747881D21D99C7619D03000149000473697A657870000000037704000000037371007E00003F4000000000000C7708000000100000000C740009636C65617261626C6571007E001574000A5F5F636F6E6669675F5F7371007E00003F400000000000187708000000200000000E740006666F726D49647371007E00060000006574000C64656661756C7456616C75657371007E00190000000277040000000274000A323032332D30322D323374000A323032332D30332D303278740008646F63756D656E7474003668747470733A2F2F656C656D656E742E656C656D652E636E2F232F7A682D434E2F636F6D706F6E656E742F646174652D7069636B657271007E0012707400056C6162656C74000CE8AFB7E58187E697B6E997B474000973686F774C6162656C71007E0015740008726571756972656471007E001574000972656E6465724B6579740010313031313634323133383830383939347400066C61796F757474000B636F6C466F726D4974656D74000774616749636F6E74000A646174652D72616E67657400096368616E676554616771007E001574000374616774000E656C2D646174652D7069636B65727400077265674C6973747371007E0019000000017704000000017371007E00003F4000000000000C7708000000100000000371007E002A71007E00157400076D657373616765740018E8AFB7E58187E697B6E997B4E4B88DE883BDE4B8BAE7A9BA740007747269676765727400066368616E67657800787400047370616E7371007E000600000018780074000F72616E67652D736570617261746F72740003E887B3740008726561646F6E6C7971007E001174001173746172742D706C616365686F6C64657274000CE5BC80E5A78BE697A5E69C9F740006666F726D617474000A797979792D4D4D2D646474000C76616C75652D666F726D617474000A797979792D4D4D2D646474000A5F5F764D6F64656C5F5F7400096C6561766574696D657400057374796C657371007E00003F4000000000000177080000000200000001740005776964746874000431303025780071007E001471007E0011740004747970657400096461746572616E676574000F656E642D706C616365686F6C64657274000CE7BB93E69D9FE697A5E69C9F78007371007E00003F4000000000000C7708000000100000000974000A66696C74657261626C6571007E001171007E001C71007E001571007E001D7371007E00003F400000000000187708000000200000000E71007E001F7371007E00060000006671007E002574003168747470733A2F2F656C656D656E742E656C656D652E636E2F232F7A682D434E2F636F6D706F6E656E742F73656C65637471007E00127071007E002774000CE8AFB7E58187E7B1BBE59E8B71007E002971007E001571007E002A71007E001571007E002B7400103130323136343231333837383439313071007E002D74000B636F6C466F726D4974656D71007E002F74000673656C65637471007E003171007E001571007E0032740009656C2D73656C65637471007E00347371007E0019000000017704000000017371007E00003F4000000000000C7708000000100000000371007E002A71007E001571007E0037740012E98089E68BA9E8AFB7E58187E7B1BBE59E8B71007E00397400066368616E676578007871007E003B71007E003C71007E00217371007E00060000000178007400086D756C7469706C6571007E001171007E00467400096C656176657479706571007E00487371007E00003F400000000000017708000000020000000171007E004A74000431303025780071007E001471007E001174000B706C616365686F6C646572740012E98089E68BA9E8AFB7E58187E7B1BBE59E8B7400085F5F736C6F745F5F7371007E00003F40000000000001770800000002000000017400076F7074696F6E737371007E0019000000027704000000027371007E00003F400000000000037708000000040000000271007E0027740006E5B9B4E5818774000576616C756571007E005E78007371007E00003F400000000000037708000000040000000271007E0027740006E8B083E4BC9171007E006B7371007E000600000002780078780078007371007E00003F4000000000000C7708000000100000000A71007E001D7371007E00003F400000000000187708000000200000000E71007E001F71007E002071007E002574003068747470733A2F2F656C656D656E742E656C656D652E636E2F232F7A682D434E2F636F6D706F6E656E742F696E70757471007E00127071007E002774000CE8AFB7E58187E4BA8BE794B171007E002971007E001571007E002A71007E001571007E002B7400103130313136343231333837323630383771007E002D74000B636F6C466F726D4974656D71007E002F740008746578746172656171007E003171007E001571007E0032740008656C2D696E70757471007E00347371007E0019000000017704000000017371007E00003F4000000000000C7708000000100000000371007E002A71007E001571007E0037740015E8AFB7E8BE93E585A5E8AFB7E58187E4BA8BE794B171007E0039740004626C757278007871007E003B71007E003C71007E00217400023131780071007E003F71007E00117400096D61786C656E6774687071007E004674000B6C65617665726561736F6E71007E00487371007E00003F400000000000017708000000020000000171007E004A74000431303025780071007E001471007E001171007E0063740015E8AFB7E8BE93E585A5E8AFB7E58187E4BA8BE794B174000F73686F772D776F72642D6C696D697471007E001171007E004C74000874657874617265617400086175746F73697A657371007E00003F40000000000003770800000004000000027400076D696E526F77737371007E0006000000047400076D6178526F777371007E0086780078007871007E003B71007E003C7800, NULL);
INSERT INTO `act_ge_bytearray` (`ID_`, `REV_`, `NAME_`, `DEPLOYMENT_ID_`, `BYTES_`, `GENERATED_`) VALUES ('d48e4b46-b33f-11ed-9d23-869ef1607803', 1, 'hist.var-variables', NULL, 0xACED0005737200176A6176612E7574696C2E4C696E6B6564486173684D617034C04E5C106CC0FB0200015A000B6163636573734F72646572787200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000B740007666F726D5265667400056C65617665740006677574746572737200116A6176612E6C616E672E496E746567657212E2A0A4F781873802000149000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B02000078700000000F74000473697A657400066D656469756D740009666F726D52756C657374000572756C657374000D6C6162656C506F736974696F6E7400057269676874740008666F726D42746E73737200116A6176612E6C616E672E426F6F6C65616ECD207280D59CFAEE0200015A000576616C756578700074000A6C6162656C57696474687371007E00060000006474000864697361626C65647371007E001001740009666F726D4D6F64656C7400096C65617665466F726D7400066669656C6473737200136A6176612E7574696C2E41727261794C6973747881D21D99C7619D03000149000473697A657870000000037704000000037371007E00003F4000000000000C7708000000100000000C740009636C65617261626C6571007E001574000A5F5F636F6E6669675F5F7371007E00003F400000000000187708000000200000000E740006666F726D49647371007E00060000006574000C64656661756C7456616C75657371007E00190000000277040000000274000A323032332D30322D323374000A323032332D30332D303278740008646F63756D656E7474003668747470733A2F2F656C656D656E742E656C656D652E636E2F232F7A682D434E2F636F6D706F6E656E742F646174652D7069636B657271007E0012707400056C6162656C74000CE8AFB7E58187E697B6E997B474000973686F774C6162656C71007E0015740008726571756972656471007E001574000972656E6465724B6579740010313031313634323133383830383939347400066C61796F757474000B636F6C466F726D4974656D74000774616749636F6E74000A646174652D72616E67657400096368616E676554616771007E001574000374616774000E656C2D646174652D7069636B65727400077265674C6973747371007E0019000000017704000000017371007E00003F4000000000000C7708000000100000000371007E002A71007E00157400076D657373616765740018E8AFB7E58187E697B6E997B4E4B88DE883BDE4B8BAE7A9BA740007747269676765727400066368616E67657800787400047370616E7371007E000600000018780074000F72616E67652D736570617261746F72740003E887B3740008726561646F6E6C7971007E001174001173746172742D706C616365686F6C64657274000CE5BC80E5A78BE697A5E69C9F740006666F726D617474000A797979792D4D4D2D646474000C76616C75652D666F726D617474000A797979792D4D4D2D646474000A5F5F764D6F64656C5F5F7400096C6561766574696D657400057374796C657371007E00003F4000000000000177080000000200000001740005776964746874000431303025780071007E001471007E0011740004747970657400096461746572616E676574000F656E642D706C616365686F6C64657274000CE7BB93E69D9FE697A5E69C9F78007371007E00003F4000000000000C7708000000100000000974000A66696C74657261626C6571007E001171007E001C71007E001571007E001D7371007E00003F400000000000187708000000200000000E71007E001F7371007E00060000006671007E002574003168747470733A2F2F656C656D656E742E656C656D652E636E2F232F7A682D434E2F636F6D706F6E656E742F73656C65637471007E00127071007E002774000CE8AFB7E58187E7B1BBE59E8B71007E002971007E001571007E002A71007E001571007E002B7400103130323136343231333837383439313071007E002D74000B636F6C466F726D4974656D71007E002F74000673656C65637471007E003171007E001571007E0032740009656C2D73656C65637471007E00347371007E0019000000017704000000017371007E00003F4000000000000C7708000000100000000371007E002A71007E001571007E0037740012E98089E68BA9E8AFB7E58187E7B1BBE59E8B71007E00397400066368616E676578007871007E003B71007E003C71007E00217371007E00060000000178007400086D756C7469706C6571007E001171007E00467400096C656176657479706571007E00487371007E00003F400000000000017708000000020000000171007E004A74000431303025780071007E001471007E001174000B706C616365686F6C646572740012E98089E68BA9E8AFB7E58187E7B1BBE59E8B7400085F5F736C6F745F5F7371007E00003F40000000000001770800000002000000017400076F7074696F6E737371007E0019000000027704000000027371007E00003F400000000000037708000000040000000271007E0027740006E5B9B4E5818774000576616C756571007E005E78007371007E00003F400000000000037708000000040000000271007E0027740006E8B083E4BC9171007E006B7371007E000600000002780078780078007371007E00003F4000000000000C7708000000100000000A71007E001D7371007E00003F400000000000187708000000200000000E71007E001F71007E002071007E002574003068747470733A2F2F656C656D656E742E656C656D652E636E2F232F7A682D434E2F636F6D706F6E656E742F696E70757471007E00127071007E002774000CE8AFB7E58187E4BA8BE794B171007E002971007E001571007E002A71007E001571007E002B7400103130313136343231333837323630383771007E002D74000B636F6C466F726D4974656D71007E002F740008746578746172656171007E003171007E001571007E0032740008656C2D696E70757471007E00347371007E0019000000017704000000017371007E00003F4000000000000C7708000000100000000371007E002A71007E001571007E0037740015E8AFB7E8BE93E585A5E8AFB7E58187E4BA8BE794B171007E0039740004626C757278007871007E003B71007E003C71007E00217400023131780071007E003F71007E00117400096D61786C656E6774687071007E004674000B6C65617665726561736F6E71007E00487371007E00003F400000000000017708000000020000000171007E004A74000431303025780071007E001471007E001171007E0063740015E8AFB7E8BE93E585A5E8AFB7E58187E4BA8BE794B174000F73686F772D776F72642D6C696D697471007E001171007E004C74000874657874617265617400086175746F73697A657371007E00003F40000000000003770800000004000000027400076D696E526F77737371007E0006000000047400076D6178526F777371007E0086780078007871007E003B71007E003C7800, NULL);
INSERT INTO `act_ge_bytearray` (`ID_`, `REV_`, `NAME_`, `DEPLOYMENT_ID_`, `BYTES_`, `GENERATED_`) VALUES ('ede2b72a-5850-11ee-9923-f22f4b0aefad', 1, 'var-variables', NULL, 0xACED0005737200136A6176612E7574696C2E41727261794C6973747881D21D99C7619D03000149000473697A65787000000001770400000001737200176A6176612E7574696C2E4C696E6B6564486173684D617034C04E5C106CC0FB0200015A000B6163636573734F72646572787200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F400000000000187708000000200000000D740009247265717569726564737200116A6176612E6C616E672E426F6F6C65616ECD207280D59CFAEE0200015A000576616C756578700074000C5F66635F647261675F746167740005696E7075747400056669656C647400046E616D6574000668696464656E71007E0007740007646973706C61797371007E00060174000474797065740005696E7075747400057469746C65740006E5908DE7A7B0740004696E666F74000074000570726F70737371007E00023F400000000000007708000000100000000078007400026F6E7371007E00023F400000000000007708000000100000000078007400076F7074696F6E737371007E000000000000770400000000787400086368696C6472656E7371007E0000000000007704000000007874000576616C756574000433333333780078, NULL);
INSERT INTO `act_ge_bytearray` (`ID_`, `REV_`, `NAME_`, `DEPLOYMENT_ID_`, `BYTES_`, `GENERATED_`) VALUES ('ede2b72c-5850-11ee-9923-f22f4b0aefad', 1, 'hist.var-variables', NULL, 0xACED0005737200136A6176612E7574696C2E41727261794C6973747881D21D99C7619D03000149000473697A65787000000001770400000001737200176A6176612E7574696C2E4C696E6B6564486173684D617034C04E5C106CC0FB0200015A000B6163636573734F72646572787200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F400000000000187708000000200000000D740009247265717569726564737200116A6176612E6C616E672E426F6F6C65616ECD207280D59CFAEE0200015A000576616C756578700074000C5F66635F647261675F746167740005696E7075747400056669656C647400046E616D6574000668696464656E71007E0007740007646973706C61797371007E00060174000474797065740005696E7075747400057469746C65740006E5908DE7A7B0740004696E666F74000074000570726F70737371007E00023F400000000000007708000000100000000078007400026F6E7371007E00023F400000000000007708000000100000000078007400076F7074696F6E737371007E000000000000770400000000787400086368696C6472656E7371007E0000000000007704000000007874000576616C756574000433333333780078, NULL);
INSERT INTO `act_ge_bytearray` (`ID_`, `REV_`, `NAME_`, `DEPLOYMENT_ID_`, `BYTES_`, `GENERATED_`) VALUES ('ff6e5216-584d-11ee-9923-f22f4b0aefad', 1, 'var-variables', NULL, 0xACED0005737200136A6176612E7574696C2E41727261794C6973747881D21D99C7619D03000149000473697A65787000000001770400000001737200176A6176612E7574696C2E4C696E6B6564486173684D617034C04E5C106CC0FB0200015A000B6163636573734F72646572787200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F400000000000187708000000200000000D740009247265717569726564737200116A6176612E6C616E672E426F6F6C65616ECD207280D59CFAEE0200015A000576616C756578700074000C5F66635F647261675F746167740005696E7075747400056669656C647400046E616D6574000668696464656E71007E0007740007646973706C61797371007E00060174000474797065740005696E7075747400057469746C65740006E5908DE7A7B0740004696E666F74000074000570726F70737371007E00023F400000000000007708000000100000000078007400026F6E7371007E00023F400000000000007708000000100000000078007400076F7074696F6E737371007E000000000000770400000000787400086368696C6472656E7371007E0000000000007704000000007874000576616C7565740003313131780078, NULL);
INSERT INTO `act_ge_bytearray` (`ID_`, `REV_`, `NAME_`, `DEPLOYMENT_ID_`, `BYTES_`, `GENERATED_`) VALUES ('ff6e5218-584d-11ee-9923-f22f4b0aefad', 1, 'hist.var-variables', NULL, 0xACED0005737200136A6176612E7574696C2E41727261794C6973747881D21D99C7619D03000149000473697A65787000000001770400000001737200176A6176612E7574696C2E4C696E6B6564486173684D617034C04E5C106CC0FB0200015A000B6163636573734F72646572787200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F400000000000187708000000200000000D740009247265717569726564737200116A6176612E6C616E672E426F6F6C65616ECD207280D59CFAEE0200015A000576616C756578700074000C5F66635F647261675F746167740005696E7075747400056669656C647400046E616D6574000668696464656E71007E0007740007646973706C61797371007E00060174000474797065740005696E7075747400057469746C65740006E5908DE7A7B0740004696E666F74000074000570726F70737371007E00023F400000000000007708000000100000000078007400026F6E7371007E00023F400000000000007708000000100000000078007400076F7074696F6E737371007E000000000000770400000000787400086368696C6472656E7371007E0000000000007704000000007874000576616C7565740003313131780078, NULL);
COMMIT;

-- ----------------------------
-- Table structure for act_ge_property
-- ----------------------------
DROP TABLE IF EXISTS `act_ge_property`;
CREATE TABLE `act_ge_property` (
                                   `NAME_` varchar(64) COLLATE utf8_bin NOT NULL,
                                   `VALUE_` varchar(300) COLLATE utf8_bin DEFAULT NULL,
                                   `REV_` int DEFAULT NULL,
                                   PRIMARY KEY (`NAME_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_ge_property
-- ----------------------------
BEGIN;
INSERT INTO `act_ge_property` (`NAME_`, `VALUE_`, `REV_`) VALUES ('batch.schema.version', '6.8.1.0', 1);
INSERT INTO `act_ge_property` (`NAME_`, `VALUE_`, `REV_`) VALUES ('cfg.execution-related-entities-count', 'true', 1);
INSERT INTO `act_ge_property` (`NAME_`, `VALUE_`, `REV_`) VALUES ('cfg.task-related-entities-count', 'true', 1);
INSERT INTO `act_ge_property` (`NAME_`, `VALUE_`, `REV_`) VALUES ('common.schema.version', '6.8.1.0', 1);
INSERT INTO `act_ge_property` (`NAME_`, `VALUE_`, `REV_`) VALUES ('entitylink.schema.version', '6.8.1.0', 1);
INSERT INTO `act_ge_property` (`NAME_`, `VALUE_`, `REV_`) VALUES ('eventsubscription.schema.version', '6.8.1.0', 1);
INSERT INTO `act_ge_property` (`NAME_`, `VALUE_`, `REV_`) VALUES ('identitylink.schema.version', '6.8.1.0', 1);
INSERT INTO `act_ge_property` (`NAME_`, `VALUE_`, `REV_`) VALUES ('job.schema.version', '6.8.1.0', 1);
INSERT INTO `act_ge_property` (`NAME_`, `VALUE_`, `REV_`) VALUES ('next.dbid', '1', 1);
INSERT INTO `act_ge_property` (`NAME_`, `VALUE_`, `REV_`) VALUES ('schema.history', 'upgrade(6.7.2.0->6.8.1.0)', 2);
INSERT INTO `act_ge_property` (`NAME_`, `VALUE_`, `REV_`) VALUES ('schema.version', '6.8.1.0', 2);
INSERT INTO `act_ge_property` (`NAME_`, `VALUE_`, `REV_`) VALUES ('task.schema.version', '6.8.1.0', 1);
INSERT INTO `act_ge_property` (`NAME_`, `VALUE_`, `REV_`) VALUES ('variable.schema.version', '6.8.1.0', 1);
COMMIT;

-- ----------------------------
-- Table structure for act_hi_actinst
-- ----------------------------
DROP TABLE IF EXISTS `act_hi_actinst`;
CREATE TABLE `act_hi_actinst` (
                                  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                  `REV_` int DEFAULT '1',
                                  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                  `ACT_ID_` varchar(255) COLLATE utf8_bin NOT NULL,
                                  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                  `CALL_PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                  `ACT_NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                  `ACT_TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
                                  `ASSIGNEE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                  `START_TIME_` datetime(3) NOT NULL,
                                  `END_TIME_` datetime(3) DEFAULT NULL,
                                  `TRANSACTION_ORDER_` int DEFAULT NULL,
                                  `DURATION_` bigint DEFAULT NULL,
                                  `DELETE_REASON_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
                                  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
                                  PRIMARY KEY (`ID_`),
                                  KEY `ACT_IDX_HI_ACT_INST_START` (`START_TIME_`),
                                  KEY `ACT_IDX_HI_ACT_INST_END` (`END_TIME_`),
                                  KEY `ACT_IDX_HI_ACT_INST_PROCINST` (`PROC_INST_ID_`,`ACT_ID_`),
                                  KEY `ACT_IDX_HI_ACT_INST_EXEC` (`EXECUTION_ID_`,`ACT_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_hi_actinst
-- ----------------------------
BEGIN;
INSERT INTO `act_hi_actinst` (`ID_`, `REV_`, `PROC_DEF_ID_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `ACT_ID_`, `TASK_ID_`, `CALL_PROC_INST_ID_`, `ACT_NAME_`, `ACT_TYPE_`, `ASSIGNEE_`, `START_TIME_`, `END_TIME_`, `TRANSACTION_ORDER_`, `DURATION_`, `DELETE_REASON_`, `TENANT_ID_`) VALUES ('02422b1d-246d-11ee-8f95-36d2b240f315', 1, 'testoa:16:98955103-b33e-11ed-b511-ce4fe10f37b8', 'bb8dbc01-246c-11ee-8f95-36d2b240f315', 'bb90541c-246c-11ee-8f95-36d2b240f315', 'Flow_1nm8bdm', NULL, NULL, NULL, 'sequenceFlow', NULL, '2023-07-17 06:41:50.299', '2023-07-17 06:41:50.299', 1, 0, NULL, '');
INSERT INTO `act_hi_actinst` (`ID_`, `REV_`, `PROC_DEF_ID_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `ACT_ID_`, `TASK_ID_`, `CALL_PROC_INST_ID_`, `ACT_NAME_`, `ACT_TYPE_`, `ASSIGNEE_`, `START_TIME_`, `END_TIME_`, `TRANSACTION_ORDER_`, `DURATION_`, `DELETE_REASON_`, `TENANT_ID_`) VALUES ('0242522e-246d-11ee-8f95-36d2b240f315', 1, 'testoa:16:98955103-b33e-11ed-b511-ce4fe10f37b8', 'bb8dbc01-246c-11ee-8f95-36d2b240f315', 'bb90541c-246c-11ee-8f95-36d2b240f315', 'Event_0p01b7d', NULL, NULL, NULL, 'endEvent', NULL, '2023-07-17 06:41:50.300', '2023-07-17 06:41:50.303', 2, 3, NULL, '');
INSERT INTO `act_hi_actinst` (`ID_`, `REV_`, `PROC_DEF_ID_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `ACT_ID_`, `TASK_ID_`, `CALL_PROC_INST_ID_`, `ACT_NAME_`, `ACT_TYPE_`, `ASSIGNEE_`, `START_TIME_`, `END_TIME_`, `TRANSACTION_ORDER_`, `DURATION_`, `DELETE_REASON_`, `TENANT_ID_`) VALUES ('0619d72b-b347-11ed-bdbd-ce4fe10f37b8', 1, 'testoa:16:98955103-b33e-11ed-b511-ce4fe10f37b8', '3477e76a-b342-11ed-abc3-869ef1607803', '34791ff5-b342-11ed-abc3-869ef1607803', 'Flow_14pge79', NULL, NULL, NULL, 'sequenceFlow', NULL, '2023-02-23 06:55:14.476', '2023-02-23 06:55:14.476', 1, 0, NULL, '');
INSERT INTO `act_hi_actinst` (`ID_`, `REV_`, `PROC_DEF_ID_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `ACT_ID_`, `TASK_ID_`, `CALL_PROC_INST_ID_`, `ACT_NAME_`, `ACT_TYPE_`, `ASSIGNEE_`, `START_TIME_`, `END_TIME_`, `TRANSACTION_ORDER_`, `DURATION_`, `DELETE_REASON_`, `TENANT_ID_`) VALUES ('061a736c-b347-11ed-bdbd-ce4fe10f37b8', 1, 'testoa:16:98955103-b33e-11ed-b511-ce4fe10f37b8', '3477e76a-b342-11ed-abc3-869ef1607803', '34791ff5-b342-11ed-abc3-869ef1607803', 'Gateway_1nuou39', NULL, NULL, NULL, 'exclusiveGateway', NULL, '2023-02-23 06:55:14.480', '2023-02-23 06:55:14.498', 2, 18, NULL, '');
INSERT INTO `act_hi_actinst` (`ID_`, `REV_`, `PROC_DEF_ID_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `ACT_ID_`, `TASK_ID_`, `CALL_PROC_INST_ID_`, `ACT_NAME_`, `ACT_TYPE_`, `ASSIGNEE_`, `START_TIME_`, `END_TIME_`, `TRANSACTION_ORDER_`, `DURATION_`, `DELETE_REASON_`, `TENANT_ID_`) VALUES ('061d599d-b347-11ed-bdbd-ce4fe10f37b8', 1, 'testoa:16:98955103-b33e-11ed-b511-ce4fe10f37b8', '3477e76a-b342-11ed-abc3-869ef1607803', '34791ff5-b342-11ed-abc3-869ef1607803', 'Flow_04w3hjd', NULL, NULL, '同意', 'sequenceFlow', NULL, '2023-02-23 06:55:14.499', '2023-02-23 06:55:14.499', 3, 0, NULL, '');
INSERT INTO `act_hi_actinst` (`ID_`, `REV_`, `PROC_DEF_ID_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `ACT_ID_`, `TASK_ID_`, `CALL_PROC_INST_ID_`, `ACT_NAME_`, `ACT_TYPE_`, `ASSIGNEE_`, `START_TIME_`, `END_TIME_`, `TRANSACTION_ORDER_`, `DURATION_`, `DELETE_REASON_`, `TENANT_ID_`) VALUES ('061da7be-b347-11ed-bdbd-ce4fe10f37b8', 2, 'testoa:16:98955103-b33e-11ed-b511-ce4fe10f37b8', '3477e76a-b342-11ed-abc3-869ef1607803', '34791ff5-b342-11ed-abc3-869ef1607803', 'Activity_0exhfyz', '061dcecf-b347-11ed-bdbd-ce4fe10f37b8', NULL, '验收', 'userTask', '1', '2023-02-23 06:55:14.501', '2023-02-23 06:55:22.457', 4, 7956, NULL, '');
INSERT INTO `act_hi_actinst` (`ID_`, `REV_`, `PROC_DEF_ID_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `ACT_ID_`, `TASK_ID_`, `CALL_PROC_INST_ID_`, `ACT_NAME_`, `ACT_TYPE_`, `ASSIGNEE_`, `START_TIME_`, `END_TIME_`, `TRANSACTION_ORDER_`, `DURATION_`, `DELETE_REASON_`, `TENANT_ID_`) VALUES ('09331ece-b33f-11ed-b511-ce4fe10f37b8', 1, 'testoa:16:98955103-b33e-11ed-b511-ce4fe10f37b8', 'a573b064-b33e-11ed-b511-ce4fe10f37b8', '0932f7bd-b33f-11ed-b511-ce4fe10f37b8', 'Event_0p01b7d', NULL, NULL, NULL, 'endEvent', NULL, '2023-02-23 05:58:03.701', '2023-02-23 05:58:03.709', 1, 8, NULL, '');
INSERT INTO `act_hi_actinst` (`ID_`, `REV_`, `PROC_DEF_ID_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `ACT_ID_`, `TASK_ID_`, `CALL_PROC_INST_ID_`, `ACT_NAME_`, `ACT_TYPE_`, `ASSIGNEE_`, `START_TIME_`, `END_TIME_`, `TRANSACTION_ORDER_`, `DURATION_`, `DELETE_REASON_`, `TENANT_ID_`) VALUES ('0adbcc12-b347-11ed-bdbd-ce4fe10f37b8', 1, 'testoa:16:98955103-b33e-11ed-b511-ce4fe10f37b8', '3477e76a-b342-11ed-abc3-869ef1607803', '34791ff5-b342-11ed-abc3-869ef1607803', 'Flow_1nm8bdm', NULL, NULL, NULL, 'sequenceFlow', NULL, '2023-02-23 06:55:22.458', '2023-02-23 06:55:22.458', 1, 0, NULL, '');
INSERT INTO `act_hi_actinst` (`ID_`, `REV_`, `PROC_DEF_ID_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `ACT_ID_`, `TASK_ID_`, `CALL_PROC_INST_ID_`, `ACT_NAME_`, `ACT_TYPE_`, `ASSIGNEE_`, `START_TIME_`, `END_TIME_`, `TRANSACTION_ORDER_`, `DURATION_`, `DELETE_REASON_`, `TENANT_ID_`) VALUES ('0adc1a33-b347-11ed-bdbd-ce4fe10f37b8', 1, 'testoa:16:98955103-b33e-11ed-b511-ce4fe10f37b8', '3477e76a-b342-11ed-abc3-869ef1607803', '34791ff5-b342-11ed-abc3-869ef1607803', 'Event_0p01b7d', NULL, NULL, NULL, 'endEvent', NULL, '2023-02-23 06:55:22.460', '2023-02-23 06:55:22.461', 2, 1, NULL, '');
INSERT INTO `act_hi_actinst` (`ID_`, `REV_`, `PROC_DEF_ID_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `ACT_ID_`, `TASK_ID_`, `CALL_PROC_INST_ID_`, `ACT_NAME_`, `ACT_TYPE_`, `ASSIGNEE_`, `START_TIME_`, `END_TIME_`, `TRANSACTION_ORDER_`, `DURATION_`, `DELETE_REASON_`, `TENANT_ID_`) VALUES ('1188c1cb-b33f-11ed-b511-ce4fe10f37b8', 1, 'testoa:16:98955103-b33e-11ed-b511-ce4fe10f37b8', '11884c8f-b33f-11ed-b511-ce4fe10f37b8', '1188c1ca-b33f-11ed-b511-ce4fe10f37b8', 'startNode1', NULL, NULL, '开始', 'startEvent', NULL, '2023-02-23 05:58:17.684', '2023-02-23 05:58:17.684', 1, 0, NULL, '');
INSERT INTO `act_hi_actinst` (`ID_`, `REV_`, `PROC_DEF_ID_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `ACT_ID_`, `TASK_ID_`, `CALL_PROC_INST_ID_`, `ACT_NAME_`, `ACT_TYPE_`, `ASSIGNEE_`, `START_TIME_`, `END_TIME_`, `TRANSACTION_ORDER_`, `DURATION_`, `DELETE_REASON_`, `TENANT_ID_`) VALUES ('1188c1cc-b33f-11ed-b511-ce4fe10f37b8', 1, 'testoa:16:98955103-b33e-11ed-b511-ce4fe10f37b8', '11884c8f-b33f-11ed-b511-ce4fe10f37b8', '1188c1ca-b33f-11ed-b511-ce4fe10f37b8', 'Flow_19ligpu', NULL, NULL, NULL, 'sequenceFlow', NULL, '2023-02-23 05:58:17.684', '2023-02-23 05:58:17.684', 2, 0, NULL, '');
INSERT INTO `act_hi_actinst` (`ID_`, `REV_`, `PROC_DEF_ID_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `ACT_ID_`, `TASK_ID_`, `CALL_PROC_INST_ID_`, `ACT_NAME_`, `ACT_TYPE_`, `ASSIGNEE_`, `START_TIME_`, `END_TIME_`, `TRANSACTION_ORDER_`, `DURATION_`, `DELETE_REASON_`, `TENANT_ID_`) VALUES ('1188c1cd-b33f-11ed-b511-ce4fe10f37b8', 3, 'testoa:16:98955103-b33e-11ed-b511-ce4fe10f37b8', '11884c8f-b33f-11ed-b511-ce4fe10f37b8', '1188c1ca-b33f-11ed-b511-ce4fe10f37b8', 'Activity_1qo8esf', '1188c1ce-b33f-11ed-b511-ce4fe10f37b8', NULL, '经理审批', 'userTask', '1', '2023-02-23 05:58:17.684', '2023-02-23 06:05:53.104', 3, 455420, NULL, '');
INSERT INTO `act_hi_actinst` (`ID_`, `REV_`, `PROC_DEF_ID_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `ACT_ID_`, `TASK_ID_`, `CALL_PROC_INST_ID_`, `ACT_NAME_`, `ACT_TYPE_`, `ASSIGNEE_`, `START_TIME_`, `END_TIME_`, `TRANSACTION_ORDER_`, `DURATION_`, `DELETE_REASON_`, `TENANT_ID_`) VALUES ('20fca3d3-b340-11ed-9d23-869ef1607803', 1, 'testoa:16:98955103-b33e-11ed-b511-ce4fe10f37b8', '11884c8f-b33f-11ed-b511-ce4fe10f37b8', '1188c1ca-b33f-11ed-b511-ce4fe10f37b8', 'Flow_14pge79', NULL, NULL, NULL, 'sequenceFlow', NULL, '2023-02-23 06:05:53.106', '2023-02-23 06:05:53.106', 1, 0, NULL, '');
INSERT INTO `act_hi_actinst` (`ID_`, `REV_`, `PROC_DEF_ID_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `ACT_ID_`, `TASK_ID_`, `CALL_PROC_INST_ID_`, `ACT_NAME_`, `ACT_TYPE_`, `ASSIGNEE_`, `START_TIME_`, `END_TIME_`, `TRANSACTION_ORDER_`, `DURATION_`, `DELETE_REASON_`, `TENANT_ID_`) VALUES ('20fccae4-b340-11ed-9d23-869ef1607803', 1, 'testoa:16:98955103-b33e-11ed-b511-ce4fe10f37b8', '11884c8f-b33f-11ed-b511-ce4fe10f37b8', '1188c1ca-b33f-11ed-b511-ce4fe10f37b8', 'Gateway_1nuou39', NULL, NULL, NULL, 'exclusiveGateway', NULL, '2023-02-23 06:05:53.107', '2023-02-23 06:05:53.108', 2, 1, NULL, '');
INSERT INTO `act_hi_actinst` (`ID_`, `REV_`, `PROC_DEF_ID_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `ACT_ID_`, `TASK_ID_`, `CALL_PROC_INST_ID_`, `ACT_NAME_`, `ACT_TYPE_`, `ASSIGNEE_`, `START_TIME_`, `END_TIME_`, `TRANSACTION_ORDER_`, `DURATION_`, `DELETE_REASON_`, `TENANT_ID_`) VALUES ('20fcf1f5-b340-11ed-9d23-869ef1607803', 1, 'testoa:16:98955103-b33e-11ed-b511-ce4fe10f37b8', '11884c8f-b33f-11ed-b511-ce4fe10f37b8', '1188c1ca-b33f-11ed-b511-ce4fe10f37b8', 'Flow_04w3hjd', NULL, NULL, '同意', 'sequenceFlow', NULL, '2023-02-23 06:05:53.108', '2023-02-23 06:05:53.108', 3, 0, NULL, '');
INSERT INTO `act_hi_actinst` (`ID_`, `REV_`, `PROC_DEF_ID_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `ACT_ID_`, `TASK_ID_`, `CALL_PROC_INST_ID_`, `ACT_NAME_`, `ACT_TYPE_`, `ASSIGNEE_`, `START_TIME_`, `END_TIME_`, `TRANSACTION_ORDER_`, `DURATION_`, `DELETE_REASON_`, `TENANT_ID_`) VALUES ('20fd4016-b340-11ed-9d23-869ef1607803', 1, 'testoa:16:98955103-b33e-11ed-b511-ce4fe10f37b8', '11884c8f-b33f-11ed-b511-ce4fe10f37b8', '1188c1ca-b33f-11ed-b511-ce4fe10f37b8', 'Activity_0exhfyz', '20fd4017-b340-11ed-9d23-869ef1607803', NULL, '验收', 'userTask', NULL, '2023-02-23 06:05:53.110', NULL, 4, NULL, NULL, '');
INSERT INTO `act_hi_actinst` (`ID_`, `REV_`, `PROC_DEF_ID_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `ACT_ID_`, `TASK_ID_`, `CALL_PROC_INST_ID_`, `ACT_NAME_`, `ACT_TYPE_`, `ASSIGNEE_`, `START_TIME_`, `END_TIME_`, `TRANSACTION_ORDER_`, `DURATION_`, `DELETE_REASON_`, `TENANT_ID_`) VALUES ('23cbdc5a-584e-11ee-9923-f22f4b0aefad', 1, 'testvue3:1:2aea33f1-56c2-11ee-ae41-f22f4b0aefad', '23cbb542-584e-11ee-9923-f22f4b0aefad', '23cbdc59-584e-11ee-9923-f22f4b0aefad', 'startNode1', NULL, NULL, '开始', 'startEvent', NULL, '2023-09-21 07:11:52.632', '2023-09-21 07:11:52.632', 1, 0, NULL, '');
INSERT INTO `act_hi_actinst` (`ID_`, `REV_`, `PROC_DEF_ID_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `ACT_ID_`, `TASK_ID_`, `CALL_PROC_INST_ID_`, `ACT_NAME_`, `ACT_TYPE_`, `ASSIGNEE_`, `START_TIME_`, `END_TIME_`, `TRANSACTION_ORDER_`, `DURATION_`, `DELETE_REASON_`, `TENANT_ID_`) VALUES ('23cbdc5b-584e-11ee-9923-f22f4b0aefad', 1, 'testvue3:1:2aea33f1-56c2-11ee-ae41-f22f4b0aefad', '23cbb542-584e-11ee-9923-f22f4b0aefad', '23cbdc59-584e-11ee-9923-f22f4b0aefad', 'Flow_0k6k615', NULL, NULL, NULL, 'sequenceFlow', NULL, '2023-09-21 07:11:52.632', '2023-09-21 07:11:52.632', 2, 0, NULL, '');
INSERT INTO `act_hi_actinst` (`ID_`, `REV_`, `PROC_DEF_ID_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `ACT_ID_`, `TASK_ID_`, `CALL_PROC_INST_ID_`, `ACT_NAME_`, `ACT_TYPE_`, `ASSIGNEE_`, `START_TIME_`, `END_TIME_`, `TRANSACTION_ORDER_`, `DURATION_`, `DELETE_REASON_`, `TENANT_ID_`) VALUES ('28c75a39-5852-11ee-9923-f22f4b0aefad', 1, 'testvue3:2:1e8d1651-584e-11ee-9923-f22f4b0aefad', '28c75a2e-5852-11ee-9923-f22f4b0aefad', '28c75a38-5852-11ee-9923-f22f4b0aefad', 'startNode1', NULL, NULL, '开始', 'startEvent', NULL, '2023-09-21 07:40:38.978', '2023-09-21 07:40:38.978', 1, 0, NULL, '');
INSERT INTO `act_hi_actinst` (`ID_`, `REV_`, `PROC_DEF_ID_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `ACT_ID_`, `TASK_ID_`, `CALL_PROC_INST_ID_`, `ACT_NAME_`, `ACT_TYPE_`, `ASSIGNEE_`, `START_TIME_`, `END_TIME_`, `TRANSACTION_ORDER_`, `DURATION_`, `DELETE_REASON_`, `TENANT_ID_`) VALUES ('28c75a3a-5852-11ee-9923-f22f4b0aefad', 1, 'testvue3:2:1e8d1651-584e-11ee-9923-f22f4b0aefad', '28c75a2e-5852-11ee-9923-f22f4b0aefad', '28c75a38-5852-11ee-9923-f22f4b0aefad', 'Flow_0k6k615', NULL, NULL, NULL, 'sequenceFlow', NULL, '2023-09-21 07:40:38.978', '2023-09-21 07:40:38.978', 2, 0, NULL, '');
INSERT INTO `act_hi_actinst` (`ID_`, `REV_`, `PROC_DEF_ID_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `ACT_ID_`, `TASK_ID_`, `CALL_PROC_INST_ID_`, `ACT_NAME_`, `ACT_TYPE_`, `ASSIGNEE_`, `START_TIME_`, `END_TIME_`, `TRANSACTION_ORDER_`, `DURATION_`, `DELETE_REASON_`, `TENANT_ID_`) VALUES ('34791ff6-b342-11ed-abc3-869ef1607803', 1, 'testoa:16:98955103-b33e-11ed-b511-ce4fe10f37b8', '3477e76a-b342-11ed-abc3-869ef1607803', '34791ff5-b342-11ed-abc3-869ef1607803', 'startNode1', NULL, NULL, '开始', 'startEvent', NULL, '2023-02-23 06:20:44.792', '2023-02-23 06:20:44.795', 1, 3, NULL, '');
INSERT INTO `act_hi_actinst` (`ID_`, `REV_`, `PROC_DEF_ID_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `ACT_ID_`, `TASK_ID_`, `CALL_PROC_INST_ID_`, `ACT_NAME_`, `ACT_TYPE_`, `ASSIGNEE_`, `START_TIME_`, `END_TIME_`, `TRANSACTION_ORDER_`, `DURATION_`, `DELETE_REASON_`, `TENANT_ID_`) VALUES ('3479bc37-b342-11ed-abc3-869ef1607803', 1, 'testoa:16:98955103-b33e-11ed-b511-ce4fe10f37b8', '3477e76a-b342-11ed-abc3-869ef1607803', '34791ff5-b342-11ed-abc3-869ef1607803', 'Flow_19ligpu', NULL, NULL, NULL, 'sequenceFlow', NULL, '2023-02-23 06:20:44.796', '2023-02-23 06:20:44.796', 2, 0, NULL, '');
INSERT INTO `act_hi_actinst` (`ID_`, `REV_`, `PROC_DEF_ID_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `ACT_ID_`, `TASK_ID_`, `CALL_PROC_INST_ID_`, `ACT_NAME_`, `ACT_TYPE_`, `ASSIGNEE_`, `START_TIME_`, `END_TIME_`, `TRANSACTION_ORDER_`, `DURATION_`, `DELETE_REASON_`, `TENANT_ID_`) VALUES ('3479bc38-b342-11ed-abc3-869ef1607803', 2, 'testoa:16:98955103-b33e-11ed-b511-ce4fe10f37b8', '3477e76a-b342-11ed-abc3-869ef1607803', '34791ff5-b342-11ed-abc3-869ef1607803', 'Activity_1qo8esf', '347b90f9-b342-11ed-abc3-869ef1607803', NULL, '经理审批', 'userTask', NULL, '2023-02-23 06:20:44.796', '2023-02-23 06:20:58.455', 3, 13659, NULL, '');
INSERT INTO `act_hi_actinst` (`ID_`, `REV_`, `PROC_DEF_ID_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `ACT_ID_`, `TASK_ID_`, `CALL_PROC_INST_ID_`, `ACT_NAME_`, `ACT_TYPE_`, `ASSIGNEE_`, `START_TIME_`, `END_TIME_`, `TRANSACTION_ORDER_`, `DURATION_`, `DELETE_REASON_`, `TENANT_ID_`) VALUES ('3c9e8b2e-b342-11ed-abc3-869ef1607803', 1, 'testoa:16:98955103-b33e-11ed-b511-ce4fe10f37b8', '3477e76a-b342-11ed-abc3-869ef1607803', '34791ff5-b342-11ed-abc3-869ef1607803', 'Flow_14pge79', NULL, NULL, NULL, 'sequenceFlow', NULL, '2023-02-23 06:20:58.459', '2023-02-23 06:20:58.459', 1, 0, NULL, '');
INSERT INTO `act_hi_actinst` (`ID_`, `REV_`, `PROC_DEF_ID_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `ACT_ID_`, `TASK_ID_`, `CALL_PROC_INST_ID_`, `ACT_NAME_`, `ACT_TYPE_`, `ASSIGNEE_`, `START_TIME_`, `END_TIME_`, `TRANSACTION_ORDER_`, `DURATION_`, `DELETE_REASON_`, `TENANT_ID_`) VALUES ('3c9f758f-b342-11ed-abc3-869ef1607803', 1, 'testoa:16:98955103-b33e-11ed-b511-ce4fe10f37b8', '3477e76a-b342-11ed-abc3-869ef1607803', '34791ff5-b342-11ed-abc3-869ef1607803', 'Gateway_1nuou39', NULL, NULL, NULL, 'exclusiveGateway', NULL, '2023-02-23 06:20:58.465', '2023-02-23 06:20:58.476', 2, 11, NULL, '');
INSERT INTO `act_hi_actinst` (`ID_`, `REV_`, `PROC_DEF_ID_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `ACT_ID_`, `TASK_ID_`, `CALL_PROC_INST_ID_`, `ACT_NAME_`, `ACT_TYPE_`, `ASSIGNEE_`, `START_TIME_`, `END_TIME_`, `TRANSACTION_ORDER_`, `DURATION_`, `DELETE_REASON_`, `TENANT_ID_`) VALUES ('3ca12340-b342-11ed-abc3-869ef1607803', 1, 'testoa:16:98955103-b33e-11ed-b511-ce4fe10f37b8', '3477e76a-b342-11ed-abc3-869ef1607803', '34791ff5-b342-11ed-abc3-869ef1607803', 'Flow_1vusrns', NULL, NULL, '驳回', 'sequenceFlow', NULL, '2023-02-23 06:20:58.476', '2023-02-23 06:20:58.476', 3, 0, NULL, '');
INSERT INTO `act_hi_actinst` (`ID_`, `REV_`, `PROC_DEF_ID_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `ACT_ID_`, `TASK_ID_`, `CALL_PROC_INST_ID_`, `ACT_NAME_`, `ACT_TYPE_`, `ASSIGNEE_`, `START_TIME_`, `END_TIME_`, `TRANSACTION_ORDER_`, `DURATION_`, `DELETE_REASON_`, `TENANT_ID_`) VALUES ('3ca1bf81-b342-11ed-abc3-869ef1607803', 2, 'testoa:16:98955103-b33e-11ed-b511-ce4fe10f37b8', '3477e76a-b342-11ed-abc3-869ef1607803', '34791ff5-b342-11ed-abc3-869ef1607803', 'Activity_1qfkof6', '3ca1e692-b342-11ed-abc3-869ef1607803', NULL, '重新发起', 'userTask', '1', '2023-02-23 06:20:58.480', '2023-02-23 06:46:11.680', 4, 1513200, NULL, '');
INSERT INTO `act_hi_actinst` (`ID_`, `REV_`, `PROC_DEF_ID_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `ACT_ID_`, `TASK_ID_`, `CALL_PROC_INST_ID_`, `ACT_NAME_`, `ACT_TYPE_`, `ASSIGNEE_`, `START_TIME_`, `END_TIME_`, `TRANSACTION_ORDER_`, `DURATION_`, `DELETE_REASON_`, `TENANT_ID_`) VALUES ('3ef44d34-b340-11ed-9d23-869ef1607803', 1, 'testoa:16:98955103-b33e-11ed-b511-ce4fe10f37b8', '3ef44d28-b340-11ed-9d23-869ef1607803', '3ef44d33-b340-11ed-9d23-869ef1607803', 'startNode1', NULL, NULL, '开始', 'startEvent', NULL, '2023-02-23 06:06:43.383', '2023-02-23 06:06:43.383', 1, 0, NULL, '');
INSERT INTO `act_hi_actinst` (`ID_`, `REV_`, `PROC_DEF_ID_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `ACT_ID_`, `TASK_ID_`, `CALL_PROC_INST_ID_`, `ACT_NAME_`, `ACT_TYPE_`, `ASSIGNEE_`, `START_TIME_`, `END_TIME_`, `TRANSACTION_ORDER_`, `DURATION_`, `DELETE_REASON_`, `TENANT_ID_`) VALUES ('3ef47445-b340-11ed-9d23-869ef1607803', 1, 'testoa:16:98955103-b33e-11ed-b511-ce4fe10f37b8', '3ef44d28-b340-11ed-9d23-869ef1607803', '3ef44d33-b340-11ed-9d23-869ef1607803', 'Flow_19ligpu', NULL, NULL, NULL, 'sequenceFlow', NULL, '2023-02-23 06:06:43.384', '2023-02-23 06:06:43.384', 2, 0, NULL, '');
INSERT INTO `act_hi_actinst` (`ID_`, `REV_`, `PROC_DEF_ID_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `ACT_ID_`, `TASK_ID_`, `CALL_PROC_INST_ID_`, `ACT_NAME_`, `ACT_TYPE_`, `ASSIGNEE_`, `START_TIME_`, `END_TIME_`, `TRANSACTION_ORDER_`, `DURATION_`, `DELETE_REASON_`, `TENANT_ID_`) VALUES ('3ef47446-b340-11ed-9d23-869ef1607803', 2, 'testoa:16:98955103-b33e-11ed-b511-ce4fe10f37b8', '3ef44d28-b340-11ed-9d23-869ef1607803', '3ef44d33-b340-11ed-9d23-869ef1607803', 'Activity_1qo8esf', '3ef47447-b340-11ed-9d23-869ef1607803', NULL, '经理审批', 'userTask', NULL, '2023-02-23 06:06:43.384', '2023-02-23 06:10:28.221', 3, 224837, NULL, '');
INSERT INTO `act_hi_actinst` (`ID_`, `REV_`, `PROC_DEF_ID_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `ACT_ID_`, `TASK_ID_`, `CALL_PROC_INST_ID_`, `ACT_NAME_`, `ACT_TYPE_`, `ASSIGNEE_`, `START_TIME_`, `END_TIME_`, `TRANSACTION_ORDER_`, `DURATION_`, `DELETE_REASON_`, `TENANT_ID_`) VALUES ('4125bf16-584e-11ee-9923-f22f4b0aefad', 1, 'testvue3:2:1e8d1651-584e-11ee-9923-f22f4b0aefad', '4125bf0e-584e-11ee-9923-f22f4b0aefad', '4125bf15-584e-11ee-9923-f22f4b0aefad', 'startNode1', NULL, NULL, '开始', 'startEvent', NULL, '2023-09-21 07:12:41.875', '2023-09-21 07:12:41.875', 1, 0, NULL, '');
INSERT INTO `act_hi_actinst` (`ID_`, `REV_`, `PROC_DEF_ID_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `ACT_ID_`, `TASK_ID_`, `CALL_PROC_INST_ID_`, `ACT_NAME_`, `ACT_TYPE_`, `ASSIGNEE_`, `START_TIME_`, `END_TIME_`, `TRANSACTION_ORDER_`, `DURATION_`, `DELETE_REASON_`, `TENANT_ID_`) VALUES ('4125bf17-584e-11ee-9923-f22f4b0aefad', 1, 'testvue3:2:1e8d1651-584e-11ee-9923-f22f4b0aefad', '4125bf0e-584e-11ee-9923-f22f4b0aefad', '4125bf15-584e-11ee-9923-f22f4b0aefad', 'Flow_0k6k615', NULL, NULL, NULL, 'sequenceFlow', NULL, '2023-09-21 07:12:41.875', '2023-09-21 07:12:41.875', 2, 0, NULL, '');
INSERT INTO `act_hi_actinst` (`ID_`, `REV_`, `PROC_DEF_ID_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `ACT_ID_`, `TASK_ID_`, `CALL_PROC_INST_ID_`, `ACT_NAME_`, `ACT_TYPE_`, `ASSIGNEE_`, `START_TIME_`, `END_TIME_`, `TRANSACTION_ORDER_`, `DURATION_`, `DELETE_REASON_`, `TENANT_ID_`) VALUES ('65359e82-584e-11ee-9923-f22f4b0aefad', 1, 'testvue3:2:1e8d1651-584e-11ee-9923-f22f4b0aefad', '65359e7a-584e-11ee-9923-f22f4b0aefad', '65359e81-584e-11ee-9923-f22f4b0aefad', 'startNode1', NULL, NULL, '开始', 'startEvent', NULL, '2023-09-21 07:13:42.377', '2023-09-21 07:13:42.378', 1, 1, NULL, '');
INSERT INTO `act_hi_actinst` (`ID_`, `REV_`, `PROC_DEF_ID_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `ACT_ID_`, `TASK_ID_`, `CALL_PROC_INST_ID_`, `ACT_NAME_`, `ACT_TYPE_`, `ASSIGNEE_`, `START_TIME_`, `END_TIME_`, `TRANSACTION_ORDER_`, `DURATION_`, `DELETE_REASON_`, `TENANT_ID_`) VALUES ('6535c593-584e-11ee-9923-f22f4b0aefad', 1, 'testvue3:2:1e8d1651-584e-11ee-9923-f22f4b0aefad', '65359e7a-584e-11ee-9923-f22f4b0aefad', '65359e81-584e-11ee-9923-f22f4b0aefad', 'Flow_0k6k615', NULL, NULL, NULL, 'sequenceFlow', NULL, '2023-09-21 07:13:42.378', '2023-09-21 07:13:42.378', 2, 0, NULL, '');
INSERT INTO `act_hi_actinst` (`ID_`, `REV_`, `PROC_DEF_ID_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `ACT_ID_`, `TASK_ID_`, `CALL_PROC_INST_ID_`, `ACT_NAME_`, `ACT_TYPE_`, `ASSIGNEE_`, `START_TIME_`, `END_TIME_`, `TRANSACTION_ORDER_`, `DURATION_`, `DELETE_REASON_`, `TENANT_ID_`) VALUES ('a5744cb0-b33e-11ed-b511-ce4fe10f37b8', 1, 'testoa:16:98955103-b33e-11ed-b511-ce4fe10f37b8', 'a573b064-b33e-11ed-b511-ce4fe10f37b8', 'a574259f-b33e-11ed-b511-ce4fe10f37b8', 'startNode1', NULL, NULL, '开始', 'startEvent', NULL, '2023-02-23 05:55:16.356', '2023-02-23 05:55:16.356', 1, 0, NULL, '');
INSERT INTO `act_hi_actinst` (`ID_`, `REV_`, `PROC_DEF_ID_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `ACT_ID_`, `TASK_ID_`, `CALL_PROC_INST_ID_`, `ACT_NAME_`, `ACT_TYPE_`, `ASSIGNEE_`, `START_TIME_`, `END_TIME_`, `TRANSACTION_ORDER_`, `DURATION_`, `DELETE_REASON_`, `TENANT_ID_`) VALUES ('a5744cb1-b33e-11ed-b511-ce4fe10f37b8', 1, 'testoa:16:98955103-b33e-11ed-b511-ce4fe10f37b8', 'a573b064-b33e-11ed-b511-ce4fe10f37b8', 'a574259f-b33e-11ed-b511-ce4fe10f37b8', 'Flow_19ligpu', NULL, NULL, NULL, 'sequenceFlow', NULL, '2023-02-23 05:55:16.356', '2023-02-23 05:55:16.356', 2, 0, NULL, '');
INSERT INTO `act_hi_actinst` (`ID_`, `REV_`, `PROC_DEF_ID_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `ACT_ID_`, `TASK_ID_`, `CALL_PROC_INST_ID_`, `ACT_NAME_`, `ACT_TYPE_`, `ASSIGNEE_`, `START_TIME_`, `END_TIME_`, `TRANSACTION_ORDER_`, `DURATION_`, `DELETE_REASON_`, `TENANT_ID_`) VALUES ('a5744cb2-b33e-11ed-b511-ce4fe10f37b8', 2, 'testoa:16:98955103-b33e-11ed-b511-ce4fe10f37b8', 'a573b064-b33e-11ed-b511-ce4fe10f37b8', 'a574259f-b33e-11ed-b511-ce4fe10f37b8', 'Activity_1qo8esf', 'a5744cb3-b33e-11ed-b511-ce4fe10f37b8', NULL, '经理审批', 'userTask', NULL, '2023-02-23 05:55:16.356', '2023-02-23 05:55:27.051', 3, 10695, NULL, '');
INSERT INTO `act_hi_actinst` (`ID_`, `REV_`, `PROC_DEF_ID_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `ACT_ID_`, `TASK_ID_`, `CALL_PROC_INST_ID_`, `ACT_NAME_`, `ACT_TYPE_`, `ASSIGNEE_`, `START_TIME_`, `END_TIME_`, `TRANSACTION_ORDER_`, `DURATION_`, `DELETE_REASON_`, `TENANT_ID_`) VALUES ('abd48848-b33e-11ed-b511-ce4fe10f37b8', 1, 'testoa:16:98955103-b33e-11ed-b511-ce4fe10f37b8', 'a573b064-b33e-11ed-b511-ce4fe10f37b8', 'a574259f-b33e-11ed-b511-ce4fe10f37b8', 'Flow_14pge79', NULL, NULL, NULL, 'sequenceFlow', NULL, '2023-02-23 05:55:27.053', '2023-02-23 05:55:27.053', 1, 0, NULL, '');
INSERT INTO `act_hi_actinst` (`ID_`, `REV_`, `PROC_DEF_ID_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `ACT_ID_`, `TASK_ID_`, `CALL_PROC_INST_ID_`, `ACT_NAME_`, `ACT_TYPE_`, `ASSIGNEE_`, `START_TIME_`, `END_TIME_`, `TRANSACTION_ORDER_`, `DURATION_`, `DELETE_REASON_`, `TENANT_ID_`) VALUES ('abd572a9-b33e-11ed-b511-ce4fe10f37b8', 1, 'testoa:16:98955103-b33e-11ed-b511-ce4fe10f37b8', 'a573b064-b33e-11ed-b511-ce4fe10f37b8', 'a574259f-b33e-11ed-b511-ce4fe10f37b8', 'Gateway_1nuou39', NULL, NULL, NULL, 'exclusiveGateway', NULL, '2023-02-23 05:55:27.059', '2023-02-23 05:55:27.060', 2, 1, NULL, '');
INSERT INTO `act_hi_actinst` (`ID_`, `REV_`, `PROC_DEF_ID_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `ACT_ID_`, `TASK_ID_`, `CALL_PROC_INST_ID_`, `ACT_NAME_`, `ACT_TYPE_`, `ASSIGNEE_`, `START_TIME_`, `END_TIME_`, `TRANSACTION_ORDER_`, `DURATION_`, `DELETE_REASON_`, `TENANT_ID_`) VALUES ('abd599ba-b33e-11ed-b511-ce4fe10f37b8', 1, 'testoa:16:98955103-b33e-11ed-b511-ce4fe10f37b8', 'a573b064-b33e-11ed-b511-ce4fe10f37b8', 'a574259f-b33e-11ed-b511-ce4fe10f37b8', 'Flow_1vusrns', NULL, NULL, '驳回', 'sequenceFlow', NULL, '2023-02-23 05:55:27.060', '2023-02-23 05:55:27.060', 3, 0, NULL, '');
INSERT INTO `act_hi_actinst` (`ID_`, `REV_`, `PROC_DEF_ID_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `ACT_ID_`, `TASK_ID_`, `CALL_PROC_INST_ID_`, `ACT_NAME_`, `ACT_TYPE_`, `ASSIGNEE_`, `START_TIME_`, `END_TIME_`, `TRANSACTION_ORDER_`, `DURATION_`, `DELETE_REASON_`, `TENANT_ID_`) VALUES ('abd5c0cb-b33e-11ed-b511-ce4fe10f37b8', 2, 'testoa:16:98955103-b33e-11ed-b511-ce4fe10f37b8', 'a573b064-b33e-11ed-b511-ce4fe10f37b8', 'a574259f-b33e-11ed-b511-ce4fe10f37b8', 'Activity_1qfkof6', 'abd5e7dc-b33e-11ed-b511-ce4fe10f37b8', NULL, '重新发起', 'userTask', NULL, '2023-02-23 05:55:27.061', '2023-02-23 05:58:03.492', 4, 156431, 'Change activity to Event_0p01b7d', '');
INSERT INTO `act_hi_actinst` (`ID_`, `REV_`, `PROC_DEF_ID_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `ACT_ID_`, `TASK_ID_`, `CALL_PROC_INST_ID_`, `ACT_NAME_`, `ACT_TYPE_`, `ASSIGNEE_`, `START_TIME_`, `END_TIME_`, `TRANSACTION_ORDER_`, `DURATION_`, `DELETE_REASON_`, `TENANT_ID_`) VALUES ('b7a6049a-5851-11ee-9923-f22f4b0aefad', 1, 'testvue3:2:1e8d1651-584e-11ee-9923-f22f4b0aefad', 'b7a5dd82-5851-11ee-9923-f22f4b0aefad', 'b7a60499-5851-11ee-9923-f22f4b0aefad', 'startNode1', NULL, NULL, '开始', 'startEvent', NULL, '2023-09-21 07:37:29.177', '2023-09-21 07:37:29.177', 1, 0, NULL, '');
INSERT INTO `act_hi_actinst` (`ID_`, `REV_`, `PROC_DEF_ID_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `ACT_ID_`, `TASK_ID_`, `CALL_PROC_INST_ID_`, `ACT_NAME_`, `ACT_TYPE_`, `ASSIGNEE_`, `START_TIME_`, `END_TIME_`, `TRANSACTION_ORDER_`, `DURATION_`, `DELETE_REASON_`, `TENANT_ID_`) VALUES ('b7a6049b-5851-11ee-9923-f22f4b0aefad', 1, 'testvue3:2:1e8d1651-584e-11ee-9923-f22f4b0aefad', 'b7a5dd82-5851-11ee-9923-f22f4b0aefad', 'b7a60499-5851-11ee-9923-f22f4b0aefad', 'Flow_0k6k615', NULL, NULL, NULL, 'sequenceFlow', NULL, '2023-09-21 07:37:29.177', '2023-09-21 07:37:29.177', 2, 0, NULL, '');
INSERT INTO `act_hi_actinst` (`ID_`, `REV_`, `PROC_DEF_ID_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `ACT_ID_`, `TASK_ID_`, `CALL_PROC_INST_ID_`, `ACT_NAME_`, `ACT_TYPE_`, `ASSIGNEE_`, `START_TIME_`, `END_TIME_`, `TRANSACTION_ORDER_`, `DURATION_`, `DELETE_REASON_`, `TENANT_ID_`) VALUES ('b8076162-b345-11ed-8617-ce4fe10f37b8', 1, 'testoa:16:98955103-b33e-11ed-b511-ce4fe10f37b8', 'b8058c96-b345-11ed-8617-ce4fe10f37b8', 'b8073a51-b345-11ed-8617-ce4fe10f37b8', 'startNode1', NULL, NULL, '开始', 'startEvent', NULL, '2023-02-23 06:45:53.996', '2023-02-23 06:45:54.000', 1, 4, NULL, '');
INSERT INTO `act_hi_actinst` (`ID_`, `REV_`, `PROC_DEF_ID_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `ACT_ID_`, `TASK_ID_`, `CALL_PROC_INST_ID_`, `ACT_NAME_`, `ACT_TYPE_`, `ASSIGNEE_`, `START_TIME_`, `END_TIME_`, `TRANSACTION_ORDER_`, `DURATION_`, `DELETE_REASON_`, `TENANT_ID_`) VALUES ('b8084bc3-b345-11ed-8617-ce4fe10f37b8', 1, 'testoa:16:98955103-b33e-11ed-b511-ce4fe10f37b8', 'b8058c96-b345-11ed-8617-ce4fe10f37b8', 'b8073a51-b345-11ed-8617-ce4fe10f37b8', 'Flow_19ligpu', NULL, NULL, NULL, 'sequenceFlow', NULL, '2023-02-23 06:45:54.002', '2023-02-23 06:45:54.002', 2, 0, NULL, '');
INSERT INTO `act_hi_actinst` (`ID_`, `REV_`, `PROC_DEF_ID_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `ACT_ID_`, `TASK_ID_`, `CALL_PROC_INST_ID_`, `ACT_NAME_`, `ACT_TYPE_`, `ASSIGNEE_`, `START_TIME_`, `END_TIME_`, `TRANSACTION_ORDER_`, `DURATION_`, `DELETE_REASON_`, `TENANT_ID_`) VALUES ('b8084bc4-b345-11ed-8617-ce4fe10f37b8', 1, 'testoa:16:98955103-b33e-11ed-b511-ce4fe10f37b8', 'b8058c96-b345-11ed-8617-ce4fe10f37b8', 'b8073a51-b345-11ed-8617-ce4fe10f37b8', 'Activity_1qo8esf', 'b80abcc5-b345-11ed-8617-ce4fe10f37b8', NULL, '经理审批', 'userTask', NULL, '2023-02-23 06:45:54.002', NULL, 3, NULL, NULL, '');
INSERT INTO `act_hi_actinst` (`ID_`, `REV_`, `PROC_DEF_ID_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `ACT_ID_`, `TASK_ID_`, `CALL_PROC_INST_ID_`, `ACT_NAME_`, `ACT_TYPE_`, `ASSIGNEE_`, `START_TIME_`, `END_TIME_`, `TRANSACTION_ORDER_`, `DURATION_`, `DELETE_REASON_`, `TENANT_ID_`) VALUES ('bb90541d-246c-11ee-8f95-36d2b240f315', 1, 'testoa:16:98955103-b33e-11ed-b511-ce4fe10f37b8', 'bb8dbc01-246c-11ee-8f95-36d2b240f315', 'bb90541c-246c-11ee-8f95-36d2b240f315', 'startNode1', NULL, NULL, '开始', 'startEvent', NULL, '2023-07-17 06:39:51.693', '2023-07-17 06:39:51.698', 1, 5, NULL, '');
INSERT INTO `act_hi_actinst` (`ID_`, `REV_`, `PROC_DEF_ID_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `ACT_ID_`, `TASK_ID_`, `CALL_PROC_INST_ID_`, `ACT_NAME_`, `ACT_TYPE_`, `ASSIGNEE_`, `START_TIME_`, `END_TIME_`, `TRANSACTION_ORDER_`, `DURATION_`, `DELETE_REASON_`, `TENANT_ID_`) VALUES ('bb913e7e-246c-11ee-8f95-36d2b240f315', 1, 'testoa:16:98955103-b33e-11ed-b511-ce4fe10f37b8', 'bb8dbc01-246c-11ee-8f95-36d2b240f315', 'bb90541c-246c-11ee-8f95-36d2b240f315', 'Flow_19ligpu', NULL, NULL, NULL, 'sequenceFlow', NULL, '2023-07-17 06:39:51.699', '2023-07-17 06:39:51.699', 2, 0, NULL, '');
INSERT INTO `act_hi_actinst` (`ID_`, `REV_`, `PROC_DEF_ID_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `ACT_ID_`, `TASK_ID_`, `CALL_PROC_INST_ID_`, `ACT_NAME_`, `ACT_TYPE_`, `ASSIGNEE_`, `START_TIME_`, `END_TIME_`, `TRANSACTION_ORDER_`, `DURATION_`, `DELETE_REASON_`, `TENANT_ID_`) VALUES ('bb913e7f-246c-11ee-8f95-36d2b240f315', 2, 'testoa:16:98955103-b33e-11ed-b511-ce4fe10f37b8', 'bb8dbc01-246c-11ee-8f95-36d2b240f315', 'bb90541c-246c-11ee-8f95-36d2b240f315', 'Activity_1qo8esf', 'bb93af80-246c-11ee-8f95-36d2b240f315', NULL, '经理审批', 'userTask', NULL, '2023-07-17 06:39:51.699', '2023-07-17 06:40:29.085', 3, 37386, NULL, '');
INSERT INTO `act_hi_actinst` (`ID_`, `REV_`, `PROC_DEF_ID_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `ACT_ID_`, `TASK_ID_`, `CALL_PROC_INST_ID_`, `ACT_NAME_`, `ACT_TYPE_`, `ASSIGNEE_`, `START_TIME_`, `END_TIME_`, `TRANSACTION_ORDER_`, `DURATION_`, `DELETE_REASON_`, `TENANT_ID_`) VALUES ('c2920cc9-b345-11ed-8617-ce4fe10f37b8', 1, 'testoa:16:98955103-b33e-11ed-b511-ce4fe10f37b8', '3477e76a-b342-11ed-abc3-869ef1607803', '34791ff5-b342-11ed-abc3-869ef1607803', 'Flow_11x5wzj', NULL, NULL, NULL, 'sequenceFlow', NULL, '2023-02-23 06:46:11.683', '2023-02-23 06:46:11.683', 1, 0, NULL, '');
INSERT INTO `act_hi_actinst` (`ID_`, `REV_`, `PROC_DEF_ID_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `ACT_ID_`, `TASK_ID_`, `CALL_PROC_INST_ID_`, `ACT_NAME_`, `ACT_TYPE_`, `ASSIGNEE_`, `START_TIME_`, `END_TIME_`, `TRANSACTION_ORDER_`, `DURATION_`, `DELETE_REASON_`, `TENANT_ID_`) VALUES ('c2925aea-b345-11ed-8617-ce4fe10f37b8', 3, 'testoa:16:98955103-b33e-11ed-b511-ce4fe10f37b8', '3477e76a-b342-11ed-abc3-869ef1607803', '34791ff5-b342-11ed-abc3-869ef1607803', 'Activity_1qo8esf', 'c29281fb-b345-11ed-8617-ce4fe10f37b8', NULL, '经理审批', 'userTask', '1', '2023-02-23 06:46:11.684', '2023-02-23 06:55:14.471', 2, 542787, NULL, '');
INSERT INTO `act_hi_actinst` (`ID_`, `REV_`, `PROC_DEF_ID_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `ACT_ID_`, `TASK_ID_`, `CALL_PROC_INST_ID_`, `ACT_NAME_`, `ACT_TYPE_`, `ASSIGNEE_`, `START_TIME_`, `END_TIME_`, `TRANSACTION_ORDER_`, `DURATION_`, `DELETE_REASON_`, `TENANT_ID_`) VALUES ('c4f9137d-b340-11ed-88a8-869ef1607803', 1, 'testoa:16:98955103-b33e-11ed-b511-ce4fe10f37b8', '3ef44d28-b340-11ed-9d23-869ef1607803', '3ef44d33-b340-11ed-9d23-869ef1607803', 'Flow_14pge79', NULL, NULL, NULL, 'sequenceFlow', NULL, '2023-02-23 06:10:28.229', '2023-02-23 06:10:28.229', 1, 0, NULL, '');
INSERT INTO `act_hi_actinst` (`ID_`, `REV_`, `PROC_DEF_ID_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `ACT_ID_`, `TASK_ID_`, `CALL_PROC_INST_ID_`, `ACT_NAME_`, `ACT_TYPE_`, `ASSIGNEE_`, `START_TIME_`, `END_TIME_`, `TRANSACTION_ORDER_`, `DURATION_`, `DELETE_REASON_`, `TENANT_ID_`) VALUES ('c4f988ae-b340-11ed-88a8-869ef1607803', 1, 'testoa:16:98955103-b33e-11ed-b511-ce4fe10f37b8', '3ef44d28-b340-11ed-9d23-869ef1607803', '3ef44d33-b340-11ed-9d23-869ef1607803', 'Gateway_1nuou39', NULL, NULL, NULL, 'exclusiveGateway', NULL, '2023-02-23 06:10:28.232', '2023-02-23 06:10:28.250', 2, 18, NULL, '');
INSERT INTO `act_hi_actinst` (`ID_`, `REV_`, `PROC_DEF_ID_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `ACT_ID_`, `TASK_ID_`, `CALL_PROC_INST_ID_`, `ACT_NAME_`, `ACT_TYPE_`, `ASSIGNEE_`, `START_TIME_`, `END_TIME_`, `TRANSACTION_ORDER_`, `DURATION_`, `DELETE_REASON_`, `TENANT_ID_`) VALUES ('c4fc47cf-b340-11ed-88a8-869ef1607803', 1, 'testoa:16:98955103-b33e-11ed-b511-ce4fe10f37b8', '3ef44d28-b340-11ed-9d23-869ef1607803', '3ef44d33-b340-11ed-9d23-869ef1607803', 'Flow_1vusrns', NULL, NULL, '驳回', 'sequenceFlow', NULL, '2023-02-23 06:10:28.250', '2023-02-23 06:10:28.250', 3, 0, NULL, '');
INSERT INTO `act_hi_actinst` (`ID_`, `REV_`, `PROC_DEF_ID_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `ACT_ID_`, `TASK_ID_`, `CALL_PROC_INST_ID_`, `ACT_NAME_`, `ACT_TYPE_`, `ASSIGNEE_`, `START_TIME_`, `END_TIME_`, `TRANSACTION_ORDER_`, `DURATION_`, `DELETE_REASON_`, `TENANT_ID_`) VALUES ('c4fcbd00-b340-11ed-88a8-869ef1607803', 1, 'testoa:16:98955103-b33e-11ed-b511-ce4fe10f37b8', '3ef44d28-b340-11ed-9d23-869ef1607803', '3ef44d33-b340-11ed-9d23-869ef1607803', 'Activity_1qfkof6', 'c4fce411-b340-11ed-88a8-869ef1607803', NULL, '重新发起', 'userTask', NULL, '2023-02-23 06:10:28.253', NULL, 4, NULL, NULL, '');
INSERT INTO `act_hi_actinst` (`ID_`, `REV_`, `PROC_DEF_ID_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `ACT_ID_`, `TASK_ID_`, `CALL_PROC_INST_ID_`, `ACT_NAME_`, `ACT_TYPE_`, `ASSIGNEE_`, `START_TIME_`, `END_TIME_`, `TRANSACTION_ORDER_`, `DURATION_`, `DELETE_REASON_`, `TENANT_ID_`) VALUES ('d1da0c35-246c-11ee-8f95-36d2b240f315', 1, 'testoa:16:98955103-b33e-11ed-b511-ce4fe10f37b8', 'bb8dbc01-246c-11ee-8f95-36d2b240f315', 'bb90541c-246c-11ee-8f95-36d2b240f315', 'Flow_14pge79', NULL, NULL, NULL, 'sequenceFlow', NULL, '2023-07-17 06:40:29.086', '2023-07-17 06:40:29.086', 1, 0, NULL, '');
INSERT INTO `act_hi_actinst` (`ID_`, `REV_`, `PROC_DEF_ID_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `ACT_ID_`, `TASK_ID_`, `CALL_PROC_INST_ID_`, `ACT_NAME_`, `ACT_TYPE_`, `ASSIGNEE_`, `START_TIME_`, `END_TIME_`, `TRANSACTION_ORDER_`, `DURATION_`, `DELETE_REASON_`, `TENANT_ID_`) VALUES ('d1da3346-246c-11ee-8f95-36d2b240f315', 1, 'testoa:16:98955103-b33e-11ed-b511-ce4fe10f37b8', 'bb8dbc01-246c-11ee-8f95-36d2b240f315', 'bb90541c-246c-11ee-8f95-36d2b240f315', 'Gateway_1nuou39', NULL, NULL, NULL, 'exclusiveGateway', NULL, '2023-07-17 06:40:29.087', '2023-07-17 06:40:29.095', 2, 8, NULL, '');
INSERT INTO `act_hi_actinst` (`ID_`, `REV_`, `PROC_DEF_ID_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `ACT_ID_`, `TASK_ID_`, `CALL_PROC_INST_ID_`, `ACT_NAME_`, `ACT_TYPE_`, `ASSIGNEE_`, `START_TIME_`, `END_TIME_`, `TRANSACTION_ORDER_`, `DURATION_`, `DELETE_REASON_`, `TENANT_ID_`) VALUES ('d1db6bc7-246c-11ee-8f95-36d2b240f315', 1, 'testoa:16:98955103-b33e-11ed-b511-ce4fe10f37b8', 'bb8dbc01-246c-11ee-8f95-36d2b240f315', 'bb90541c-246c-11ee-8f95-36d2b240f315', 'Flow_1vusrns', NULL, NULL, '驳回', 'sequenceFlow', NULL, '2023-07-17 06:40:29.095', '2023-07-17 06:40:29.095', 3, 0, NULL, '');
INSERT INTO `act_hi_actinst` (`ID_`, `REV_`, `PROC_DEF_ID_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `ACT_ID_`, `TASK_ID_`, `CALL_PROC_INST_ID_`, `ACT_NAME_`, `ACT_TYPE_`, `ASSIGNEE_`, `START_TIME_`, `END_TIME_`, `TRANSACTION_ORDER_`, `DURATION_`, `DELETE_REASON_`, `TENANT_ID_`) VALUES ('d1db92d8-246c-11ee-8f95-36d2b240f315', 2, 'testoa:16:98955103-b33e-11ed-b511-ce4fe10f37b8', 'bb8dbc01-246c-11ee-8f95-36d2b240f315', 'bb90541c-246c-11ee-8f95-36d2b240f315', 'Activity_1qfkof6', 'd1db92d9-246c-11ee-8f95-36d2b240f315', NULL, '重新发起', 'userTask', '1', '2023-07-17 06:40:29.096', '2023-07-17 06:41:15.599', 4, 46503, NULL, '');
INSERT INTO `act_hi_actinst` (`ID_`, `REV_`, `PROC_DEF_ID_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `ACT_ID_`, `TASK_ID_`, `CALL_PROC_INST_ID_`, `ACT_NAME_`, `ACT_TYPE_`, `ASSIGNEE_`, `START_TIME_`, `END_TIME_`, `TRANSACTION_ORDER_`, `DURATION_`, `DELETE_REASON_`, `TENANT_ID_`) VALUES ('d48e7259-b33f-11ed-9d23-869ef1607803', 1, 'testoa:16:98955103-b33e-11ed-b511-ce4fe10f37b8', 'd48d87ed-b33f-11ed-9d23-869ef1607803', 'd48e7258-b33f-11ed-9d23-869ef1607803', 'startNode1', NULL, NULL, '开始', 'startEvent', NULL, '2023-02-23 06:03:44.878', '2023-02-23 06:03:44.880', 1, 2, NULL, '');
INSERT INTO `act_hi_actinst` (`ID_`, `REV_`, `PROC_DEF_ID_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `ACT_ID_`, `TASK_ID_`, `CALL_PROC_INST_ID_`, `ACT_NAME_`, `ACT_TYPE_`, `ASSIGNEE_`, `START_TIME_`, `END_TIME_`, `TRANSACTION_ORDER_`, `DURATION_`, `DELETE_REASON_`, `TENANT_ID_`) VALUES ('d48f0e9a-b33f-11ed-9d23-869ef1607803', 1, 'testoa:16:98955103-b33e-11ed-b511-ce4fe10f37b8', 'd48d87ed-b33f-11ed-9d23-869ef1607803', 'd48e7258-b33f-11ed-9d23-869ef1607803', 'Flow_19ligpu', NULL, NULL, NULL, 'sequenceFlow', NULL, '2023-02-23 06:03:44.882', '2023-02-23 06:03:44.882', 2, 0, NULL, '');
INSERT INTO `act_hi_actinst` (`ID_`, `REV_`, `PROC_DEF_ID_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `ACT_ID_`, `TASK_ID_`, `CALL_PROC_INST_ID_`, `ACT_NAME_`, `ACT_TYPE_`, `ASSIGNEE_`, `START_TIME_`, `END_TIME_`, `TRANSACTION_ORDER_`, `DURATION_`, `DELETE_REASON_`, `TENANT_ID_`) VALUES ('d48f35ab-b33f-11ed-9d23-869ef1607803', 3, 'testoa:16:98955103-b33e-11ed-b511-ce4fe10f37b8', 'd48d87ed-b33f-11ed-9d23-869ef1607803', 'd48e7258-b33f-11ed-9d23-869ef1607803', 'Activity_1qo8esf', 'd4910a6c-b33f-11ed-9d23-869ef1607803', NULL, '经理审批', 'userTask', '1', '2023-02-23 06:03:44.882', '2023-02-23 06:03:55.028', 3, 10146, NULL, '');
INSERT INTO `act_hi_actinst` (`ID_`, `REV_`, `PROC_DEF_ID_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `ACT_ID_`, `TASK_ID_`, `CALL_PROC_INST_ID_`, `ACT_NAME_`, `ACT_TYPE_`, `ASSIGNEE_`, `START_TIME_`, `END_TIME_`, `TRANSACTION_ORDER_`, `DURATION_`, `DELETE_REASON_`, `TENANT_ID_`) VALUES ('da9babf6-b33f-11ed-9d23-869ef1607803', 1, 'testoa:16:98955103-b33e-11ed-b511-ce4fe10f37b8', 'd48d87ed-b33f-11ed-9d23-869ef1607803', 'd48e7258-b33f-11ed-9d23-869ef1607803', 'Flow_14pge79', NULL, NULL, NULL, 'sequenceFlow', NULL, '2023-02-23 06:03:55.030', '2023-02-23 06:03:55.030', 1, 0, NULL, '');
INSERT INTO `act_hi_actinst` (`ID_`, `REV_`, `PROC_DEF_ID_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `ACT_ID_`, `TASK_ID_`, `CALL_PROC_INST_ID_`, `ACT_NAME_`, `ACT_TYPE_`, `ASSIGNEE_`, `START_TIME_`, `END_TIME_`, `TRANSACTION_ORDER_`, `DURATION_`, `DELETE_REASON_`, `TENANT_ID_`) VALUES ('da9bfa17-b33f-11ed-9d23-869ef1607803', 1, 'testoa:16:98955103-b33e-11ed-b511-ce4fe10f37b8', 'd48d87ed-b33f-11ed-9d23-869ef1607803', 'd48e7258-b33f-11ed-9d23-869ef1607803', 'Gateway_1nuou39', NULL, NULL, NULL, 'exclusiveGateway', NULL, '2023-02-23 06:03:55.032', '2023-02-23 06:03:55.040', 2, 8, NULL, '');
INSERT INTO `act_hi_actinst` (`ID_`, `REV_`, `PROC_DEF_ID_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `ACT_ID_`, `TASK_ID_`, `CALL_PROC_INST_ID_`, `ACT_NAME_`, `ACT_TYPE_`, `ASSIGNEE_`, `START_TIME_`, `END_TIME_`, `TRANSACTION_ORDER_`, `DURATION_`, `DELETE_REASON_`, `TENANT_ID_`) VALUES ('da9d3298-b33f-11ed-9d23-869ef1607803', 1, 'testoa:16:98955103-b33e-11ed-b511-ce4fe10f37b8', 'd48d87ed-b33f-11ed-9d23-869ef1607803', 'd48e7258-b33f-11ed-9d23-869ef1607803', 'Flow_1vusrns', NULL, NULL, '驳回', 'sequenceFlow', NULL, '2023-02-23 06:03:55.040', '2023-02-23 06:03:55.040', 3, 0, NULL, '');
INSERT INTO `act_hi_actinst` (`ID_`, `REV_`, `PROC_DEF_ID_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `ACT_ID_`, `TASK_ID_`, `CALL_PROC_INST_ID_`, `ACT_NAME_`, `ACT_TYPE_`, `ASSIGNEE_`, `START_TIME_`, `END_TIME_`, `TRANSACTION_ORDER_`, `DURATION_`, `DELETE_REASON_`, `TENANT_ID_`) VALUES ('da9dced9-b33f-11ed-9d23-869ef1607803', 1, 'testoa:16:98955103-b33e-11ed-b511-ce4fe10f37b8', 'd48d87ed-b33f-11ed-9d23-869ef1607803', 'd48e7258-b33f-11ed-9d23-869ef1607803', 'Activity_1qfkof6', 'da9dceda-b33f-11ed-9d23-869ef1607803', NULL, '重新发起', 'userTask', NULL, '2023-02-23 06:03:55.044', NULL, 4, NULL, NULL, '');
INSERT INTO `act_hi_actinst` (`ID_`, `REV_`, `PROC_DEF_ID_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `ACT_ID_`, `TASK_ID_`, `CALL_PROC_INST_ID_`, `ACT_NAME_`, `ACT_TYPE_`, `ASSIGNEE_`, `START_TIME_`, `END_TIME_`, `TRANSACTION_ORDER_`, `DURATION_`, `DELETE_REASON_`, `TENANT_ID_`) VALUES ('ed935e4d-246c-11ee-8f95-36d2b240f315', 1, 'testoa:16:98955103-b33e-11ed-b511-ce4fe10f37b8', 'bb8dbc01-246c-11ee-8f95-36d2b240f315', 'bb90541c-246c-11ee-8f95-36d2b240f315', 'Flow_11x5wzj', NULL, NULL, NULL, 'sequenceFlow', NULL, '2023-07-17 06:41:15.600', '2023-07-17 06:41:15.600', 1, 0, NULL, '');
INSERT INTO `act_hi_actinst` (`ID_`, `REV_`, `PROC_DEF_ID_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `ACT_ID_`, `TASK_ID_`, `CALL_PROC_INST_ID_`, `ACT_NAME_`, `ACT_TYPE_`, `ASSIGNEE_`, `START_TIME_`, `END_TIME_`, `TRANSACTION_ORDER_`, `DURATION_`, `DELETE_REASON_`, `TENANT_ID_`) VALUES ('ed93ac6e-246c-11ee-8f95-36d2b240f315', 3, 'testoa:16:98955103-b33e-11ed-b511-ce4fe10f37b8', 'bb8dbc01-246c-11ee-8f95-36d2b240f315', 'bb90541c-246c-11ee-8f95-36d2b240f315', 'Activity_1qo8esf', 'ed93ac6f-246c-11ee-8f95-36d2b240f315', NULL, '经理审批', 'userTask', '1', '2023-07-17 06:41:15.601', '2023-07-17 06:41:30.431', 2, 14830, NULL, '');
INSERT INTO `act_hi_actinst` (`ID_`, `REV_`, `PROC_DEF_ID_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `ACT_ID_`, `TASK_ID_`, `CALL_PROC_INST_ID_`, `ACT_NAME_`, `ACT_TYPE_`, `ASSIGNEE_`, `START_TIME_`, `END_TIME_`, `TRANSACTION_ORDER_`, `DURATION_`, `DELETE_REASON_`, `TENANT_ID_`) VALUES ('ede2b72e-5850-11ee-9923-f22f4b0aefad', 1, 'testvue3:2:1e8d1651-584e-11ee-9923-f22f4b0aefad', 'ede26906-5850-11ee-9923-f22f4b0aefad', 'ede2b72d-5850-11ee-9923-f22f4b0aefad', 'startNode1', NULL, NULL, '开始', 'startEvent', NULL, '2023-09-21 07:31:50.675', '2023-09-21 07:31:50.675', 1, 0, NULL, '');
INSERT INTO `act_hi_actinst` (`ID_`, `REV_`, `PROC_DEF_ID_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `ACT_ID_`, `TASK_ID_`, `CALL_PROC_INST_ID_`, `ACT_NAME_`, `ACT_TYPE_`, `ASSIGNEE_`, `START_TIME_`, `END_TIME_`, `TRANSACTION_ORDER_`, `DURATION_`, `DELETE_REASON_`, `TENANT_ID_`) VALUES ('ede2b72f-5850-11ee-9923-f22f4b0aefad', 1, 'testvue3:2:1e8d1651-584e-11ee-9923-f22f4b0aefad', 'ede26906-5850-11ee-9923-f22f4b0aefad', 'ede2b72d-5850-11ee-9923-f22f4b0aefad', 'Flow_0k6k615', NULL, NULL, NULL, 'sequenceFlow', NULL, '2023-09-21 07:31:50.675', '2023-09-21 07:31:50.675', 2, 0, NULL, '');
INSERT INTO `act_hi_actinst` (`ID_`, `REV_`, `PROC_DEF_ID_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `ACT_ID_`, `TASK_ID_`, `CALL_PROC_INST_ID_`, `ACT_NAME_`, `ACT_TYPE_`, `ASSIGNEE_`, `START_TIME_`, `END_TIME_`, `TRANSACTION_ORDER_`, `DURATION_`, `DELETE_REASON_`, `TENANT_ID_`) VALUES ('f66ab466-246c-11ee-8f95-36d2b240f315', 1, 'testoa:16:98955103-b33e-11ed-b511-ce4fe10f37b8', 'bb8dbc01-246c-11ee-8f95-36d2b240f315', 'bb90541c-246c-11ee-8f95-36d2b240f315', 'Flow_14pge79', NULL, NULL, NULL, 'sequenceFlow', NULL, '2023-07-17 06:41:30.432', '2023-07-17 06:41:30.432', 1, 0, NULL, '');
INSERT INTO `act_hi_actinst` (`ID_`, `REV_`, `PROC_DEF_ID_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `ACT_ID_`, `TASK_ID_`, `CALL_PROC_INST_ID_`, `ACT_NAME_`, `ACT_TYPE_`, `ASSIGNEE_`, `START_TIME_`, `END_TIME_`, `TRANSACTION_ORDER_`, `DURATION_`, `DELETE_REASON_`, `TENANT_ID_`) VALUES ('f66adb77-246c-11ee-8f95-36d2b240f315', 1, 'testoa:16:98955103-b33e-11ed-b511-ce4fe10f37b8', 'bb8dbc01-246c-11ee-8f95-36d2b240f315', 'bb90541c-246c-11ee-8f95-36d2b240f315', 'Gateway_1nuou39', NULL, NULL, NULL, 'exclusiveGateway', NULL, '2023-07-17 06:41:30.433', '2023-07-17 06:41:30.433', 2, 0, NULL, '');
INSERT INTO `act_hi_actinst` (`ID_`, `REV_`, `PROC_DEF_ID_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `ACT_ID_`, `TASK_ID_`, `CALL_PROC_INST_ID_`, `ACT_NAME_`, `ACT_TYPE_`, `ASSIGNEE_`, `START_TIME_`, `END_TIME_`, `TRANSACTION_ORDER_`, `DURATION_`, `DELETE_REASON_`, `TENANT_ID_`) VALUES ('f66adb78-246c-11ee-8f95-36d2b240f315', 1, 'testoa:16:98955103-b33e-11ed-b511-ce4fe10f37b8', 'bb8dbc01-246c-11ee-8f95-36d2b240f315', 'bb90541c-246c-11ee-8f95-36d2b240f315', 'Flow_04w3hjd', NULL, NULL, '同意', 'sequenceFlow', NULL, '2023-07-17 06:41:30.433', '2023-07-17 06:41:30.433', 3, 0, NULL, '');
INSERT INTO `act_hi_actinst` (`ID_`, `REV_`, `PROC_DEF_ID_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `ACT_ID_`, `TASK_ID_`, `CALL_PROC_INST_ID_`, `ACT_NAME_`, `ACT_TYPE_`, `ASSIGNEE_`, `START_TIME_`, `END_TIME_`, `TRANSACTION_ORDER_`, `DURATION_`, `DELETE_REASON_`, `TENANT_ID_`) VALUES ('f66b0289-246c-11ee-8f95-36d2b240f315', 2, 'testoa:16:98955103-b33e-11ed-b511-ce4fe10f37b8', 'bb8dbc01-246c-11ee-8f95-36d2b240f315', 'bb90541c-246c-11ee-8f95-36d2b240f315', 'Activity_0exhfyz', 'f66b028a-246c-11ee-8f95-36d2b240f315', NULL, '验收', 'userTask', '1', '2023-07-17 06:41:30.434', '2023-07-17 06:41:50.292', 4, 19858, NULL, '');
INSERT INTO `act_hi_actinst` (`ID_`, `REV_`, `PROC_DEF_ID_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `ACT_ID_`, `TASK_ID_`, `CALL_PROC_INST_ID_`, `ACT_NAME_`, `ACT_TYPE_`, `ASSIGNEE_`, `START_TIME_`, `END_TIME_`, `TRANSACTION_ORDER_`, `DURATION_`, `DELETE_REASON_`, `TENANT_ID_`) VALUES ('ff6e521a-584d-11ee-9923-f22f4b0aefad', 1, 'testvue3:1:2aea33f1-56c2-11ee-ae41-f22f4b0aefad', 'ff6d67b2-584d-11ee-9923-f22f4b0aefad', 'ff6e5219-584d-11ee-9923-f22f4b0aefad', 'startNode1', NULL, NULL, '开始', 'startEvent', NULL, '2023-09-21 07:10:51.621', '2023-09-21 07:10:51.623', 1, 2, NULL, '');
INSERT INTO `act_hi_actinst` (`ID_`, `REV_`, `PROC_DEF_ID_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `ACT_ID_`, `TASK_ID_`, `CALL_PROC_INST_ID_`, `ACT_NAME_`, `ACT_TYPE_`, `ASSIGNEE_`, `START_TIME_`, `END_TIME_`, `TRANSACTION_ORDER_`, `DURATION_`, `DELETE_REASON_`, `TENANT_ID_`) VALUES ('ff6ec74b-584d-11ee-9923-f22f4b0aefad', 1, 'testvue3:1:2aea33f1-56c2-11ee-ae41-f22f4b0aefad', 'ff6d67b2-584d-11ee-9923-f22f4b0aefad', 'ff6e5219-584d-11ee-9923-f22f4b0aefad', 'Flow_0k6k615', NULL, NULL, NULL, 'sequenceFlow', NULL, '2023-09-21 07:10:51.624', '2023-09-21 07:10:51.624', 2, 0, NULL, '');
COMMIT;

-- ----------------------------
-- Table structure for act_hi_attachment
-- ----------------------------
DROP TABLE IF EXISTS `act_hi_attachment`;
CREATE TABLE `act_hi_attachment` (
                                     `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                     `REV_` int DEFAULT NULL,
                                     `USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                     `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                     `DESCRIPTION_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
                                     `TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                     `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                     `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                     `URL_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
                                     `CONTENT_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                     `TIME_` datetime(3) DEFAULT NULL,
                                     PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_hi_attachment
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for act_hi_comment
-- ----------------------------
DROP TABLE IF EXISTS `act_hi_comment`;
CREATE TABLE `act_hi_comment` (
                                  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                  `TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                  `TIME_` datetime(3) NOT NULL,
                                  `USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                  `ACTION_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                  `MESSAGE_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
                                  `FULL_MSG_` longblob,
                                  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_hi_comment
-- ----------------------------
BEGIN;
INSERT INTO `act_hi_comment` (`ID_`, `TYPE_`, `TIME_`, `USER_ID_`, `TASK_ID_`, `PROC_INST_ID_`, `ACTION_`, `MESSAGE_`, `FULL_MSG_`) VALUES ('023dbe4c-246d-11ee-8f95-36d2b240f315', '1', '2023-07-17 06:41:50.270', NULL, 'f66b028a-246c-11ee-8f95-36d2b240f315', 'bb8dbc01-246c-11ee-8f95-36d2b240f315', 'AddComment', '11', 0x3131);
INSERT INTO `act_hi_comment` (`ID_`, `TYPE_`, `TIME_`, `USER_ID_`, `TASK_ID_`, `PROC_INST_ID_`, `ACTION_`, `MESSAGE_`, `FULL_MSG_`) VALUES ('06053db8-b347-11ed-bdbd-ce4fe10f37b8', '1', '2023-02-23 06:55:14.341', NULL, 'c29281fb-b345-11ed-8617-ce4fe10f37b8', '3477e76a-b342-11ed-abc3-869ef1607803', 'AddComment', '', '');
INSERT INTO `act_hi_comment` (`ID_`, `TYPE_`, `TIME_`, `USER_ID_`, `TASK_ID_`, `PROC_INST_ID_`, `ACTION_`, `MESSAGE_`, `FULL_MSG_`) VALUES ('060c69aa-b347-11ed-bdbd-ce4fe10f37b8', 'event', '2023-02-23 06:55:14.388', NULL, 'c29281fb-b345-11ed-8617-ce4fe10f37b8', NULL, 'AddUserLink', '1_|_assignee', NULL);
INSERT INTO `act_hi_comment` (`ID_`, `TYPE_`, `TIME_`, `USER_ID_`, `TASK_ID_`, `PROC_INST_ID_`, `ACTION_`, `MESSAGE_`, `FULL_MSG_`) VALUES ('0ad4ee41-b347-11ed-bdbd-ce4fe10f37b8', '1', '2023-02-23 06:55:22.412', NULL, '061dcecf-b347-11ed-bdbd-ce4fe10f37b8', '3477e76a-b342-11ed-abc3-869ef1607803', 'AddComment', '', '');
INSERT INTO `act_hi_comment` (`ID_`, `TYPE_`, `TIME_`, `USER_ID_`, `TASK_ID_`, `PROC_INST_ID_`, `ACTION_`, `MESSAGE_`, `FULL_MSG_`) VALUES ('20f0e3fe-b340-11ed-9d23-869ef1607803', '1', '2023-02-23 06:05:53.029', NULL, '1188c1ce-b33f-11ed-b511-ce4fe10f37b8', '11884c8f-b33f-11ed-b511-ce4fe10f37b8', 'AddComment', '', '');
INSERT INTO `act_hi_comment` (`ID_`, `TYPE_`, `TIME_`, `USER_ID_`, `TASK_ID_`, `PROC_INST_ID_`, `ACTION_`, `MESSAGE_`, `FULL_MSG_`) VALUES ('20f5ed11-b340-11ed-9d23-869ef1607803', 'event', '2023-02-23 06:05:53.062', NULL, '1188c1ce-b33f-11ed-b511-ce4fe10f37b8', NULL, 'AddUserLink', '1_|_assignee', NULL);
INSERT INTO `act_hi_comment` (`ID_`, `TYPE_`, `TIME_`, `USER_ID_`, `TASK_ID_`, `PROC_INST_ID_`, `ACTION_`, `MESSAGE_`, `FULL_MSG_`) VALUES ('3c90816c-b342-11ed-abc3-869ef1607803', '1', '2023-02-23 06:20:58.365', NULL, '347b90f9-b342-11ed-abc3-869ef1607803', '3477e76a-b342-11ed-abc3-869ef1607803', 'AddComment', '22', 0x3232);
INSERT INTO `act_hi_comment` (`ID_`, `TYPE_`, `TIME_`, `USER_ID_`, `TASK_ID_`, `PROC_INST_ID_`, `ACTION_`, `MESSAGE_`, `FULL_MSG_`) VALUES ('3f011e7c-b340-11ed-9d23-869ef1607803', 'event', '2023-02-23 06:06:43.467', '1', '3ef47447-b340-11ed-9d23-869ef1607803', NULL, 'AddUserLink', '1_|_owner', NULL);
INSERT INTO `act_hi_comment` (`ID_`, `TYPE_`, `TIME_`, `USER_ID_`, `TASK_ID_`, `PROC_INST_ID_`, `ACTION_`, `MESSAGE_`, `FULL_MSG_`) VALUES ('abce1fa6-b33e-11ed-b511-ce4fe10f37b8', '1', '2023-02-23 05:55:27.011', NULL, 'a5744cb3-b33e-11ed-b511-ce4fe10f37b8', 'a573b064-b33e-11ed-b511-ce4fe10f37b8', 'AddComment', '222', 0x323232);
INSERT INTO `act_hi_comment` (`ID_`, `TYPE_`, `TIME_`, `USER_ID_`, `TASK_ID_`, `PROC_INST_ID_`, `ACTION_`, `MESSAGE_`, `FULL_MSG_`) VALUES ('c2890c18-b345-11ed-8617-ce4fe10f37b8', '1', '2023-02-23 06:46:11.622', NULL, '3ca1e692-b342-11ed-abc3-869ef1607803', '3477e76a-b342-11ed-abc3-869ef1607803', 'AddComment', '', '');
INSERT INTO `act_hi_comment` (`ID_`, `TYPE_`, `TIME_`, `USER_ID_`, `TASK_ID_`, `PROC_INST_ID_`, `ACTION_`, `MESSAGE_`, `FULL_MSG_`) VALUES ('c4e9f84b-b340-11ed-88a8-869ef1607803', '1', '2023-02-23 06:10:28.129', NULL, '3ef47447-b340-11ed-9d23-869ef1607803', '3ef44d28-b340-11ed-9d23-869ef1607803', 'AddComment', 'ee', 0x6565);
INSERT INTO `act_hi_comment` (`ID_`, `TYPE_`, `TIME_`, `USER_ID_`, `TASK_ID_`, `PROC_INST_ID_`, `ACTION_`, `MESSAGE_`, `FULL_MSG_`) VALUES ('d1d6b0d3-246c-11ee-8f95-36d2b240f315', '1', '2023-07-17 06:40:29.063', NULL, 'bb93af80-246c-11ee-8f95-36d2b240f315', 'bb8dbc01-246c-11ee-8f95-36d2b240f315', 'AddComment', '111', 0x313131);
INSERT INTO `act_hi_comment` (`ID_`, `TYPE_`, `TIME_`, `USER_ID_`, `TASK_ID_`, `PROC_INST_ID_`, `ACTION_`, `MESSAGE_`, `FULL_MSG_`) VALUES ('d4af19c1-b33f-11ed-9d23-869ef1607803', 'event', '2023-02-23 06:03:45.091', '1', 'd4910a6c-b33f-11ed-9d23-869ef1607803', NULL, 'AddUserLink', '1_|_owner', NULL);
INSERT INTO `act_hi_comment` (`ID_`, `TYPE_`, `TIME_`, `USER_ID_`, `TASK_ID_`, `PROC_INST_ID_`, `ACTION_`, `MESSAGE_`, `FULL_MSG_`) VALUES ('da925d23-b33f-11ed-9d23-869ef1607803', 'event', '2023-02-23 06:03:54.969', NULL, 'd4910a6c-b33f-11ed-9d23-869ef1607803', NULL, 'AddUserLink', '1_|_assignee', NULL);
INSERT INTO `act_hi_comment` (`ID_`, `TYPE_`, `TIME_`, `USER_ID_`, `TASK_ID_`, `PROC_INST_ID_`, `ACTION_`, `MESSAGE_`, `FULL_MSG_`) VALUES ('da962db4-b33f-11ed-9d23-869ef1607803', '1', '2023-02-23 06:03:54.994', NULL, 'd4910a6c-b33f-11ed-9d23-869ef1607803', 'd48d87ed-b33f-11ed-9d23-869ef1607803', 'AddComment', 'eee', 0x656565);
INSERT INTO `act_hi_comment` (`ID_`, `TYPE_`, `TIME_`, `USER_ID_`, `TASK_ID_`, `PROC_INST_ID_`, `ACTION_`, `MESSAGE_`, `FULL_MSG_`) VALUES ('ed8d43cc-246c-11ee-8f95-36d2b240f315', '1', '2023-07-17 06:41:15.559', NULL, 'd1db92d9-246c-11ee-8f95-36d2b240f315', 'bb8dbc01-246c-11ee-8f95-36d2b240f315', 'AddComment', '11', 0x3131);
INSERT INTO `act_hi_comment` (`ID_`, `TYPE_`, `TIME_`, `USER_ID_`, `TASK_ID_`, `PROC_INST_ID_`, `ACTION_`, `MESSAGE_`, `FULL_MSG_`) VALUES ('f6638872-246c-11ee-8f95-36d2b240f315', '1', '2023-07-17 06:41:30.385', '1', 'ed93ac6f-246c-11ee-8f95-36d2b240f315', 'bb8dbc01-246c-11ee-8f95-36d2b240f315', 'AddComment', '111', 0x313131);
INSERT INTO `act_hi_comment` (`ID_`, `TYPE_`, `TIME_`, `USER_ID_`, `TASK_ID_`, `PROC_INST_ID_`, `ACTION_`, `MESSAGE_`, `FULL_MSG_`) VALUES ('f66731f4-246c-11ee-8f95-36d2b240f315', 'event', '2023-07-17 06:41:30.409', '1', 'ed93ac6f-246c-11ee-8f95-36d2b240f315', NULL, 'AddUserLink', '1_|_assignee', NULL);
INSERT INTO `act_hi_comment` (`ID_`, `TYPE_`, `TIME_`, `USER_ID_`, `TASK_ID_`, `PROC_INST_ID_`, `ACTION_`, `MESSAGE_`, `FULL_MSG_`) VALUES ('f7a265a7-b33f-11ed-9d23-869ef1607803', '3', '2023-02-23 06:04:43.728', NULL, '1188c1ce-b33f-11ed-b511-ce4fe10f37b8', '11884c8f-b33f-11ed-b511-ce4fe10f37b8', 'AddComment', '333', 0x333333);
COMMIT;

-- ----------------------------
-- Table structure for act_hi_detail
-- ----------------------------
DROP TABLE IF EXISTS `act_hi_detail`;
CREATE TABLE `act_hi_detail` (
                                 `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                 `TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
                                 `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                 `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                 `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                 `ACT_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                 `NAME_` varchar(255) COLLATE utf8_bin NOT NULL,
                                 `VAR_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                 `REV_` int DEFAULT NULL,
                                 `TIME_` datetime(3) NOT NULL,
                                 `BYTEARRAY_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                 `DOUBLE_` double DEFAULT NULL,
                                 `LONG_` bigint DEFAULT NULL,
                                 `TEXT_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
                                 `TEXT2_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
                                 PRIMARY KEY (`ID_`),
                                 KEY `ACT_IDX_HI_DETAIL_PROC_INST` (`PROC_INST_ID_`),
                                 KEY `ACT_IDX_HI_DETAIL_ACT_INST` (`ACT_INST_ID_`),
                                 KEY `ACT_IDX_HI_DETAIL_TIME` (`TIME_`),
                                 KEY `ACT_IDX_HI_DETAIL_NAME` (`NAME_`),
                                 KEY `ACT_IDX_HI_DETAIL_TASK_ID` (`TASK_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_hi_detail
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for act_hi_entitylink
-- ----------------------------
DROP TABLE IF EXISTS `act_hi_entitylink`;
CREATE TABLE `act_hi_entitylink` (
                                     `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                     `LINK_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                     `CREATE_TIME_` datetime(3) DEFAULT NULL,
                                     `SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                     `SUB_SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                     `SCOPE_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                     `SCOPE_DEFINITION_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                     `PARENT_ELEMENT_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                     `REF_SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                     `REF_SCOPE_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                     `REF_SCOPE_DEFINITION_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                     `ROOT_SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                     `ROOT_SCOPE_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                     `HIERARCHY_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                     PRIMARY KEY (`ID_`),
                                     KEY `ACT_IDX_HI_ENT_LNK_SCOPE` (`SCOPE_ID_`,`SCOPE_TYPE_`,`LINK_TYPE_`),
                                     KEY `ACT_IDX_HI_ENT_LNK_REF_SCOPE` (`REF_SCOPE_ID_`,`REF_SCOPE_TYPE_`,`LINK_TYPE_`),
                                     KEY `ACT_IDX_HI_ENT_LNK_ROOT_SCOPE` (`ROOT_SCOPE_ID_`,`ROOT_SCOPE_TYPE_`,`LINK_TYPE_`),
                                     KEY `ACT_IDX_HI_ENT_LNK_SCOPE_DEF` (`SCOPE_DEFINITION_ID_`,`SCOPE_TYPE_`,`LINK_TYPE_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_hi_entitylink
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for act_hi_identitylink
-- ----------------------------
DROP TABLE IF EXISTS `act_hi_identitylink`;
CREATE TABLE `act_hi_identitylink` (
                                       `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                       `GROUP_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                       `TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                       `USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                       `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                       `CREATE_TIME_` datetime(3) DEFAULT NULL,
                                       `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                       `SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                       `SUB_SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                       `SCOPE_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                       `SCOPE_DEFINITION_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                       PRIMARY KEY (`ID_`),
                                       KEY `ACT_IDX_HI_IDENT_LNK_USER` (`USER_ID_`),
                                       KEY `ACT_IDX_HI_IDENT_LNK_SCOPE` (`SCOPE_ID_`,`SCOPE_TYPE_`),
                                       KEY `ACT_IDX_HI_IDENT_LNK_SUB_SCOPE` (`SUB_SCOPE_ID_`,`SCOPE_TYPE_`),
                                       KEY `ACT_IDX_HI_IDENT_LNK_SCOPE_DEF` (`SCOPE_DEFINITION_ID_`,`SCOPE_TYPE_`),
                                       KEY `ACT_IDX_HI_IDENT_LNK_TASK` (`TASK_ID_`),
                                       KEY `ACT_IDX_HI_IDENT_LNK_PROCINST` (`PROC_INST_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_hi_identitylink
-- ----------------------------
BEGIN;
INSERT INTO `act_hi_identitylink` (`ID_`, `GROUP_ID_`, `TYPE_`, `USER_ID_`, `TASK_ID_`, `CREATE_TIME_`, `PROC_INST_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `SCOPE_DEFINITION_ID_`) VALUES ('060b7f49-b347-11ed-bdbd-ce4fe10f37b8', NULL, 'assignee', '1', 'c29281fb-b345-11ed-8617-ce4fe10f37b8', '2023-02-23 06:55:14.382', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `act_hi_identitylink` (`ID_`, `GROUP_ID_`, `TYPE_`, `USER_ID_`, `TASK_ID_`, `CREATE_TIME_`, `PROC_INST_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `SCOPE_DEFINITION_ID_`) VALUES ('061dced0-b347-11ed-bdbd-ce4fe10f37b8', NULL, 'assignee', '1', '061dcecf-b347-11ed-bdbd-ce4fe10f37b8', '2023-02-23 06:55:14.502', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `act_hi_identitylink` (`ID_`, `GROUP_ID_`, `TYPE_`, `USER_ID_`, `TASK_ID_`, `CREATE_TIME_`, `PROC_INST_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `SCOPE_DEFINITION_ID_`) VALUES ('11884c90-b33f-11ed-b511-ce4fe10f37b8', NULL, 'starter', '1', NULL, '2023-02-23 05:58:17.681', '11884c8f-b33f-11ed-b511-ce4fe10f37b8', NULL, NULL, NULL, NULL);
INSERT INTO `act_hi_identitylink` (`ID_`, `GROUP_ID_`, `TYPE_`, `USER_ID_`, `TASK_ID_`, `CREATE_TIME_`, `PROC_INST_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `SCOPE_DEFINITION_ID_`) VALUES ('1188e8df-b33f-11ed-b511-ce4fe10f37b8', '641845124569108480', 'candidate', NULL, '1188c1ce-b33f-11ed-b511-ce4fe10f37b8', '2023-02-23 05:58:17.685', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `act_hi_identitylink` (`ID_`, `GROUP_ID_`, `TYPE_`, `USER_ID_`, `TASK_ID_`, `CREATE_TIME_`, `PROC_INST_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `SCOPE_DEFINITION_ID_`) VALUES ('1188e8e0-b33f-11ed-b511-ce4fe10f37b8', '1', 'candidate', NULL, '1188c1ce-b33f-11ed-b511-ce4fe10f37b8', '2023-02-23 05:58:17.685', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `act_hi_identitylink` (`ID_`, `GROUP_ID_`, `TYPE_`, `USER_ID_`, `TASK_ID_`, `CREATE_TIME_`, `PROC_INST_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `SCOPE_DEFINITION_ID_`) VALUES ('20f550cf-b340-11ed-9d23-869ef1607803', NULL, 'assignee', '1', '1188c1ce-b33f-11ed-b511-ce4fe10f37b8', '2023-02-23 06:05:53.058', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `act_hi_identitylink` (`ID_`, `GROUP_ID_`, `TYPE_`, `USER_ID_`, `TASK_ID_`, `CREATE_TIME_`, `PROC_INST_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `SCOPE_DEFINITION_ID_`) VALUES ('20f5ed10-b340-11ed-9d23-869ef1607803', NULL, 'participant', '1', NULL, '2023-02-23 06:05:53.062', '11884c8f-b33f-11ed-b511-ce4fe10f37b8', NULL, NULL, NULL, NULL);
INSERT INTO `act_hi_identitylink` (`ID_`, `GROUP_ID_`, `TYPE_`, `USER_ID_`, `TASK_ID_`, `CREATE_TIME_`, `PROC_INST_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `SCOPE_DEFINITION_ID_`) VALUES ('23cbb544-584e-11ee-9923-f22f4b0aefad', NULL, 'starter', '1', NULL, '2023-09-21 07:11:52.631', '23cbb542-584e-11ee-9923-f22f4b0aefad', NULL, NULL, NULL, NULL);
INSERT INTO `act_hi_identitylink` (`ID_`, `GROUP_ID_`, `TYPE_`, `USER_ID_`, `TASK_ID_`, `CREATE_TIME_`, `PROC_INST_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `SCOPE_DEFINITION_ID_`) VALUES ('28c75a30-5852-11ee-9923-f22f4b0aefad', NULL, 'starter', '1', NULL, '2023-09-21 07:40:38.978', '28c75a2e-5852-11ee-9923-f22f4b0aefad', NULL, NULL, NULL, NULL);
INSERT INTO `act_hi_identitylink` (`ID_`, `GROUP_ID_`, `TYPE_`, `USER_ID_`, `TASK_ID_`, `CREATE_TIME_`, `PROC_INST_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `SCOPE_DEFINITION_ID_`) VALUES ('34780e7b-b342-11ed-abc3-869ef1607803', NULL, 'starter', '1', NULL, '2023-02-23 06:20:44.785', '3477e76a-b342-11ed-abc3-869ef1607803', NULL, NULL, NULL, NULL);
INSERT INTO `act_hi_identitylink` (`ID_`, `GROUP_ID_`, `TYPE_`, `USER_ID_`, `TASK_ID_`, `CREATE_TIME_`, `PROC_INST_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `SCOPE_DEFINITION_ID_`) VALUES ('347bb80a-b342-11ed-abc3-869ef1607803', '641845124569108480', 'candidate', NULL, '347b90f9-b342-11ed-abc3-869ef1607803', '2023-02-23 06:20:44.809', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `act_hi_identitylink` (`ID_`, `GROUP_ID_`, `TYPE_`, `USER_ID_`, `TASK_ID_`, `CREATE_TIME_`, `PROC_INST_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `SCOPE_DEFINITION_ID_`) VALUES ('347bb80b-b342-11ed-abc3-869ef1607803', '1', 'candidate', NULL, '347b90f9-b342-11ed-abc3-869ef1607803', '2023-02-23 06:20:44.809', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `act_hi_identitylink` (`ID_`, `GROUP_ID_`, `TYPE_`, `USER_ID_`, `TASK_ID_`, `CREATE_TIME_`, `PROC_INST_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `SCOPE_DEFINITION_ID_`) VALUES ('3ca1e693-b342-11ed-abc3-869ef1607803', NULL, 'assignee', '1', '3ca1e692-b342-11ed-abc3-869ef1607803', '2023-02-23 06:20:58.481', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `act_hi_identitylink` (`ID_`, `GROUP_ID_`, `TYPE_`, `USER_ID_`, `TASK_ID_`, `CREATE_TIME_`, `PROC_INST_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `SCOPE_DEFINITION_ID_`) VALUES ('3ca282d4-b342-11ed-abc3-869ef1607803', NULL, 'participant', '1', NULL, '2023-02-23 06:20:58.485', '3477e76a-b342-11ed-abc3-869ef1607803', NULL, NULL, NULL, NULL);
INSERT INTO `act_hi_identitylink` (`ID_`, `GROUP_ID_`, `TYPE_`, `USER_ID_`, `TASK_ID_`, `CREATE_TIME_`, `PROC_INST_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `SCOPE_DEFINITION_ID_`) VALUES ('3ef44d29-b340-11ed-9d23-869ef1607803', NULL, 'starter', '1', NULL, '2023-02-23 06:06:43.383', '3ef44d28-b340-11ed-9d23-869ef1607803', NULL, NULL, NULL, NULL);
INSERT INTO `act_hi_identitylink` (`ID_`, `GROUP_ID_`, `TYPE_`, `USER_ID_`, `TASK_ID_`, `CREATE_TIME_`, `PROC_INST_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `SCOPE_DEFINITION_ID_`) VALUES ('3ef47448-b340-11ed-9d23-869ef1607803', '641845124569108480', 'candidate', NULL, '3ef47447-b340-11ed-9d23-869ef1607803', '2023-02-23 06:06:43.384', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `act_hi_identitylink` (`ID_`, `GROUP_ID_`, `TYPE_`, `USER_ID_`, `TASK_ID_`, `CREATE_TIME_`, `PROC_INST_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `SCOPE_DEFINITION_ID_`) VALUES ('3ef47449-b340-11ed-9d23-869ef1607803', '1', 'candidate', NULL, '3ef47447-b340-11ed-9d23-869ef1607803', '2023-02-23 06:06:43.386', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `act_hi_identitylink` (`ID_`, `GROUP_ID_`, `TYPE_`, `USER_ID_`, `TASK_ID_`, `CREATE_TIME_`, `PROC_INST_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `SCOPE_DEFINITION_ID_`) VALUES ('3f00823a-b340-11ed-9d23-869ef1607803', NULL, 'owner', '1', '3ef47447-b340-11ed-9d23-869ef1607803', '2023-02-23 06:06:43.463', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `act_hi_identitylink` (`ID_`, `GROUP_ID_`, `TYPE_`, `USER_ID_`, `TASK_ID_`, `CREATE_TIME_`, `PROC_INST_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `SCOPE_DEFINITION_ID_`) VALUES ('3f011e7b-b340-11ed-9d23-869ef1607803', NULL, 'participant', '1', NULL, '2023-02-23 06:06:43.467', '3ef44d28-b340-11ed-9d23-869ef1607803', NULL, NULL, NULL, NULL);
INSERT INTO `act_hi_identitylink` (`ID_`, `GROUP_ID_`, `TYPE_`, `USER_ID_`, `TASK_ID_`, `CREATE_TIME_`, `PROC_INST_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `SCOPE_DEFINITION_ID_`) VALUES ('4125bf10-584e-11ee-9923-f22f4b0aefad', NULL, 'starter', '1', NULL, '2023-09-21 07:12:41.875', '4125bf0e-584e-11ee-9923-f22f4b0aefad', NULL, NULL, NULL, NULL);
INSERT INTO `act_hi_identitylink` (`ID_`, `GROUP_ID_`, `TYPE_`, `USER_ID_`, `TASK_ID_`, `CREATE_TIME_`, `PROC_INST_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `SCOPE_DEFINITION_ID_`) VALUES ('65359e7c-584e-11ee-9923-f22f4b0aefad', NULL, 'starter', '1', NULL, '2023-09-21 07:13:42.377', '65359e7a-584e-11ee-9923-f22f4b0aefad', NULL, NULL, NULL, NULL);
INSERT INTO `act_hi_identitylink` (`ID_`, `GROUP_ID_`, `TYPE_`, `USER_ID_`, `TASK_ID_`, `CREATE_TIME_`, `PROC_INST_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `SCOPE_DEFINITION_ID_`) VALUES ('a573b065-b33e-11ed-b511-ce4fe10f37b8', NULL, 'starter', '1', NULL, '2023-02-23 05:55:16.352', 'a573b064-b33e-11ed-b511-ce4fe10f37b8', NULL, NULL, NULL, NULL);
INSERT INTO `act_hi_identitylink` (`ID_`, `GROUP_ID_`, `TYPE_`, `USER_ID_`, `TASK_ID_`, `CREATE_TIME_`, `PROC_INST_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `SCOPE_DEFINITION_ID_`) VALUES ('a5744cb4-b33e-11ed-b511-ce4fe10f37b8', '641845124569108480', 'candidate', NULL, 'a5744cb3-b33e-11ed-b511-ce4fe10f37b8', '2023-02-23 05:55:16.356', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `act_hi_identitylink` (`ID_`, `GROUP_ID_`, `TYPE_`, `USER_ID_`, `TASK_ID_`, `CREATE_TIME_`, `PROC_INST_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `SCOPE_DEFINITION_ID_`) VALUES ('a5744cb5-b33e-11ed-b511-ce4fe10f37b8', '1', 'candidate', NULL, 'a5744cb3-b33e-11ed-b511-ce4fe10f37b8', '2023-02-23 05:55:16.357', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `act_hi_identitylink` (`ID_`, `GROUP_ID_`, `TYPE_`, `USER_ID_`, `TASK_ID_`, `CREATE_TIME_`, `PROC_INST_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `SCOPE_DEFINITION_ID_`) VALUES ('b7a5dd84-5851-11ee-9923-f22f4b0aefad', NULL, 'starter', '1', NULL, '2023-09-21 07:37:29.176', 'b7a5dd82-5851-11ee-9923-f22f4b0aefad', NULL, NULL, NULL, NULL);
INSERT INTO `act_hi_identitylink` (`ID_`, `GROUP_ID_`, `TYPE_`, `USER_ID_`, `TASK_ID_`, `CREATE_TIME_`, `PROC_INST_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `SCOPE_DEFINITION_ID_`) VALUES ('b805b3a7-b345-11ed-8617-ce4fe10f37b8', NULL, 'starter', '1', NULL, '2023-02-23 06:45:53.986', 'b8058c96-b345-11ed-8617-ce4fe10f37b8', NULL, NULL, NULL, NULL);
INSERT INTO `act_hi_identitylink` (`ID_`, `GROUP_ID_`, `TYPE_`, `USER_ID_`, `TASK_ID_`, `CREATE_TIME_`, `PROC_INST_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `SCOPE_DEFINITION_ID_`) VALUES ('b80b31f6-b345-11ed-8617-ce4fe10f37b8', '641845124569108480', 'candidate', NULL, 'b80abcc5-b345-11ed-8617-ce4fe10f37b8', '2023-02-23 06:45:54.021', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `act_hi_identitylink` (`ID_`, `GROUP_ID_`, `TYPE_`, `USER_ID_`, `TASK_ID_`, `CREATE_TIME_`, `PROC_INST_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `SCOPE_DEFINITION_ID_`) VALUES ('b80b5907-b345-11ed-8617-ce4fe10f37b8', '1', 'candidate', NULL, 'b80abcc5-b345-11ed-8617-ce4fe10f37b8', '2023-02-23 06:45:54.022', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `act_hi_identitylink` (`ID_`, `GROUP_ID_`, `TYPE_`, `USER_ID_`, `TASK_ID_`, `CREATE_TIME_`, `PROC_INST_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `SCOPE_DEFINITION_ID_`) VALUES ('bb8de312-246c-11ee-8f95-36d2b240f315', NULL, 'starter', '1', NULL, '2023-07-17 06:39:51.678', 'bb8dbc01-246c-11ee-8f95-36d2b240f315', NULL, NULL, NULL, NULL);
INSERT INTO `act_hi_identitylink` (`ID_`, `GROUP_ID_`, `TYPE_`, `USER_ID_`, `TASK_ID_`, `CREATE_TIME_`, `PROC_INST_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `SCOPE_DEFINITION_ID_`) VALUES ('bb944bc1-246c-11ee-8f95-36d2b240f315', '641845124569108480', 'candidate', NULL, 'bb93af80-246c-11ee-8f95-36d2b240f315', '2023-07-17 06:39:51.719', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `act_hi_identitylink` (`ID_`, `GROUP_ID_`, `TYPE_`, `USER_ID_`, `TASK_ID_`, `CREATE_TIME_`, `PROC_INST_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `SCOPE_DEFINITION_ID_`) VALUES ('bb9472d2-246c-11ee-8f95-36d2b240f315', '1', 'candidate', NULL, 'bb93af80-246c-11ee-8f95-36d2b240f315', '2023-07-17 06:39:51.720', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `act_hi_identitylink` (`ID_`, `GROUP_ID_`, `TYPE_`, `USER_ID_`, `TASK_ID_`, `CREATE_TIME_`, `PROC_INST_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `SCOPE_DEFINITION_ID_`) VALUES ('c29281fc-b345-11ed-8617-ce4fe10f37b8', '641845124569108480', 'candidate', NULL, 'c29281fb-b345-11ed-8617-ce4fe10f37b8', '2023-02-23 06:46:11.685', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `act_hi_identitylink` (`ID_`, `GROUP_ID_`, `TYPE_`, `USER_ID_`, `TASK_ID_`, `CREATE_TIME_`, `PROC_INST_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `SCOPE_DEFINITION_ID_`) VALUES ('c29281fd-b345-11ed-8617-ce4fe10f37b8', '1', 'candidate', NULL, 'c29281fb-b345-11ed-8617-ce4fe10f37b8', '2023-02-23 06:46:11.685', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `act_hi_identitylink` (`ID_`, `GROUP_ID_`, `TYPE_`, `USER_ID_`, `TASK_ID_`, `CREATE_TIME_`, `PROC_INST_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `SCOPE_DEFINITION_ID_`) VALUES ('d1db92da-246c-11ee-8f95-36d2b240f315', NULL, 'assignee', '1', 'd1db92d9-246c-11ee-8f95-36d2b240f315', '2023-07-17 06:40:29.096', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `act_hi_identitylink` (`ID_`, `GROUP_ID_`, `TYPE_`, `USER_ID_`, `TASK_ID_`, `CREATE_TIME_`, `PROC_INST_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `SCOPE_DEFINITION_ID_`) VALUES ('d1dbe0fb-246c-11ee-8f95-36d2b240f315', NULL, 'participant', '1', NULL, '2023-07-17 06:40:29.098', 'bb8dbc01-246c-11ee-8f95-36d2b240f315', NULL, NULL, NULL, NULL);
INSERT INTO `act_hi_identitylink` (`ID_`, `GROUP_ID_`, `TYPE_`, `USER_ID_`, `TASK_ID_`, `CREATE_TIME_`, `PROC_INST_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `SCOPE_DEFINITION_ID_`) VALUES ('d48daefe-b33f-11ed-9d23-869ef1607803', NULL, 'starter', '1', NULL, '2023-02-23 06:03:44.872', 'd48d87ed-b33f-11ed-9d23-869ef1607803', NULL, NULL, NULL, NULL);
INSERT INTO `act_hi_identitylink` (`ID_`, `GROUP_ID_`, `TYPE_`, `USER_ID_`, `TASK_ID_`, `CREATE_TIME_`, `PROC_INST_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `SCOPE_DEFINITION_ID_`) VALUES ('d491317d-b33f-11ed-9d23-869ef1607803', '641845124569108480', 'candidate', NULL, 'd4910a6c-b33f-11ed-9d23-869ef1607803', '2023-02-23 06:03:44.895', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `act_hi_identitylink` (`ID_`, `GROUP_ID_`, `TYPE_`, `USER_ID_`, `TASK_ID_`, `CREATE_TIME_`, `PROC_INST_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `SCOPE_DEFINITION_ID_`) VALUES ('d491317e-b33f-11ed-9d23-869ef1607803', '1', 'candidate', NULL, 'd4910a6c-b33f-11ed-9d23-869ef1607803', '2023-02-23 06:03:44.895', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `act_hi_identitylink` (`ID_`, `GROUP_ID_`, `TYPE_`, `USER_ID_`, `TASK_ID_`, `CREATE_TIME_`, `PROC_INST_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `SCOPE_DEFINITION_ID_`) VALUES ('d4ae566f-b33f-11ed-9d23-869ef1607803', NULL, 'owner', '1', 'd4910a6c-b33f-11ed-9d23-869ef1607803', '2023-02-23 06:03:45.086', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `act_hi_identitylink` (`ID_`, `GROUP_ID_`, `TYPE_`, `USER_ID_`, `TASK_ID_`, `CREATE_TIME_`, `PROC_INST_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `SCOPE_DEFINITION_ID_`) VALUES ('d4aef2b0-b33f-11ed-9d23-869ef1607803', NULL, 'participant', '1', NULL, '2023-02-23 06:03:45.091', 'd48d87ed-b33f-11ed-9d23-869ef1607803', NULL, NULL, NULL, NULL);
INSERT INTO `act_hi_identitylink` (`ID_`, `GROUP_ID_`, `TYPE_`, `USER_ID_`, `TASK_ID_`, `CREATE_TIME_`, `PROC_INST_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `SCOPE_DEFINITION_ID_`) VALUES ('da9199d2-b33f-11ed-9d23-869ef1607803', NULL, 'assignee', '1', 'd4910a6c-b33f-11ed-9d23-869ef1607803', '2023-02-23 06:03:54.963', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `act_hi_identitylink` (`ID_`, `GROUP_ID_`, `TYPE_`, `USER_ID_`, `TASK_ID_`, `CREATE_TIME_`, `PROC_INST_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `SCOPE_DEFINITION_ID_`) VALUES ('ed93ac70-246c-11ee-8f95-36d2b240f315', '641845124569108480', 'candidate', NULL, 'ed93ac6f-246c-11ee-8f95-36d2b240f315', '2023-07-17 06:41:15.601', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `act_hi_identitylink` (`ID_`, `GROUP_ID_`, `TYPE_`, `USER_ID_`, `TASK_ID_`, `CREATE_TIME_`, `PROC_INST_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `SCOPE_DEFINITION_ID_`) VALUES ('ed93ac71-246c-11ee-8f95-36d2b240f315', '1', 'candidate', NULL, 'ed93ac6f-246c-11ee-8f95-36d2b240f315', '2023-07-17 06:41:15.601', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `act_hi_identitylink` (`ID_`, `GROUP_ID_`, `TYPE_`, `USER_ID_`, `TASK_ID_`, `CREATE_TIME_`, `PROC_INST_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `SCOPE_DEFINITION_ID_`) VALUES ('ede26908-5850-11ee-9923-f22f4b0aefad', NULL, 'starter', '1', NULL, '2023-09-21 07:31:50.673', 'ede26906-5850-11ee-9923-f22f4b0aefad', NULL, NULL, NULL, NULL);
INSERT INTO `act_hi_identitylink` (`ID_`, `GROUP_ID_`, `TYPE_`, `USER_ID_`, `TASK_ID_`, `CREATE_TIME_`, `PROC_INST_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `SCOPE_DEFINITION_ID_`) VALUES ('f666bcc3-246c-11ee-8f95-36d2b240f315', NULL, 'assignee', '1', 'ed93ac6f-246c-11ee-8f95-36d2b240f315', '2023-07-17 06:41:30.406', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `act_hi_identitylink` (`ID_`, `GROUP_ID_`, `TYPE_`, `USER_ID_`, `TASK_ID_`, `CREATE_TIME_`, `PROC_INST_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `SCOPE_DEFINITION_ID_`) VALUES ('f669ca05-246c-11ee-8f95-36d2b240f315', NULL, 'participant', '1', NULL, '2023-07-17 06:41:30.427', 'bb8dbc01-246c-11ee-8f95-36d2b240f315', NULL, NULL, NULL, NULL);
INSERT INTO `act_hi_identitylink` (`ID_`, `GROUP_ID_`, `TYPE_`, `USER_ID_`, `TASK_ID_`, `CREATE_TIME_`, `PROC_INST_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `SCOPE_DEFINITION_ID_`) VALUES ('f66b028b-246c-11ee-8f95-36d2b240f315', NULL, 'assignee', '1', 'f66b028a-246c-11ee-8f95-36d2b240f315', '2023-07-17 06:41:30.434', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `act_hi_identitylink` (`ID_`, `GROUP_ID_`, `TYPE_`, `USER_ID_`, `TASK_ID_`, `CREATE_TIME_`, `PROC_INST_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `SCOPE_DEFINITION_ID_`) VALUES ('ff6db5d4-584d-11ee-9923-f22f4b0aefad', NULL, 'starter', '1', NULL, '2023-09-21 07:10:51.617', 'ff6d67b2-584d-11ee-9923-f22f4b0aefad', NULL, NULL, NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for act_hi_procinst
-- ----------------------------
DROP TABLE IF EXISTS `act_hi_procinst`;
CREATE TABLE `act_hi_procinst` (
                                   `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                   `REV_` int DEFAULT '1',
                                   `PROC_INST_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                   `BUSINESS_KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                   `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                   `START_TIME_` datetime(3) NOT NULL,
                                   `END_TIME_` datetime(3) DEFAULT NULL,
                                   `DURATION_` bigint DEFAULT NULL,
                                   `START_USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                   `START_ACT_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                   `END_ACT_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                   `SUPER_PROCESS_INSTANCE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                   `DELETE_REASON_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
                                   `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
                                   `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                   `CALLBACK_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                   `CALLBACK_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                   `REFERENCE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                   `REFERENCE_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                   `PROPAGATED_STAGE_INST_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                   `BUSINESS_STATUS_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                   PRIMARY KEY (`ID_`),
                                   UNIQUE KEY `PROC_INST_ID_` (`PROC_INST_ID_`),
                                   KEY `ACT_IDX_HI_PRO_INST_END` (`END_TIME_`),
                                   KEY `ACT_IDX_HI_PRO_I_BUSKEY` (`BUSINESS_KEY_`),
                                   KEY `ACT_IDX_HI_PRO_SUPER_PROCINST` (`SUPER_PROCESS_INSTANCE_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_hi_procinst
-- ----------------------------
BEGIN;
INSERT INTO `act_hi_procinst` (`ID_`, `REV_`, `PROC_INST_ID_`, `BUSINESS_KEY_`, `PROC_DEF_ID_`, `START_TIME_`, `END_TIME_`, `DURATION_`, `START_USER_ID_`, `START_ACT_ID_`, `END_ACT_ID_`, `SUPER_PROCESS_INSTANCE_ID_`, `DELETE_REASON_`, `TENANT_ID_`, `NAME_`, `CALLBACK_ID_`, `CALLBACK_TYPE_`, `REFERENCE_ID_`, `REFERENCE_TYPE_`, `PROPAGATED_STAGE_INST_ID_`, `BUSINESS_STATUS_`) VALUES ('11884c8f-b33f-11ed-b511-ce4fe10f37b8', 1, '11884c8f-b33f-11ed-b511-ce4fe10f37b8', NULL, 'testoa:16:98955103-b33e-11ed-b511-ce4fe10f37b8', '2023-02-23 05:58:17.681', NULL, NULL, '1', 'startNode1', NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `act_hi_procinst` (`ID_`, `REV_`, `PROC_INST_ID_`, `BUSINESS_KEY_`, `PROC_DEF_ID_`, `START_TIME_`, `END_TIME_`, `DURATION_`, `START_USER_ID_`, `START_ACT_ID_`, `END_ACT_ID_`, `SUPER_PROCESS_INSTANCE_ID_`, `DELETE_REASON_`, `TENANT_ID_`, `NAME_`, `CALLBACK_ID_`, `CALLBACK_TYPE_`, `REFERENCE_ID_`, `REFERENCE_TYPE_`, `PROPAGATED_STAGE_INST_ID_`, `BUSINESS_STATUS_`) VALUES ('23cbb542-584e-11ee-9923-f22f4b0aefad', 1, '23cbb542-584e-11ee-9923-f22f4b0aefad', NULL, 'testvue3:1:2aea33f1-56c2-11ee-ae41-f22f4b0aefad', '2023-09-21 07:11:52.631', NULL, NULL, '1', 'startNode1', NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `act_hi_procinst` (`ID_`, `REV_`, `PROC_INST_ID_`, `BUSINESS_KEY_`, `PROC_DEF_ID_`, `START_TIME_`, `END_TIME_`, `DURATION_`, `START_USER_ID_`, `START_ACT_ID_`, `END_ACT_ID_`, `SUPER_PROCESS_INSTANCE_ID_`, `DELETE_REASON_`, `TENANT_ID_`, `NAME_`, `CALLBACK_ID_`, `CALLBACK_TYPE_`, `REFERENCE_ID_`, `REFERENCE_TYPE_`, `PROPAGATED_STAGE_INST_ID_`, `BUSINESS_STATUS_`) VALUES ('28c75a2e-5852-11ee-9923-f22f4b0aefad', 1, '28c75a2e-5852-11ee-9923-f22f4b0aefad', NULL, 'testvue3:2:1e8d1651-584e-11ee-9923-f22f4b0aefad', '2023-09-21 07:40:38.978', NULL, NULL, '1', 'startNode1', NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `act_hi_procinst` (`ID_`, `REV_`, `PROC_INST_ID_`, `BUSINESS_KEY_`, `PROC_DEF_ID_`, `START_TIME_`, `END_TIME_`, `DURATION_`, `START_USER_ID_`, `START_ACT_ID_`, `END_ACT_ID_`, `SUPER_PROCESS_INSTANCE_ID_`, `DELETE_REASON_`, `TENANT_ID_`, `NAME_`, `CALLBACK_ID_`, `CALLBACK_TYPE_`, `REFERENCE_ID_`, `REFERENCE_TYPE_`, `PROPAGATED_STAGE_INST_ID_`, `BUSINESS_STATUS_`) VALUES ('3477e76a-b342-11ed-abc3-869ef1607803', 2, '3477e76a-b342-11ed-abc3-869ef1607803', NULL, 'testoa:16:98955103-b33e-11ed-b511-ce4fe10f37b8', '2023-02-23 06:20:44.784', '2023-02-23 06:55:22.497', 2077713, '1', 'startNode1', 'Event_0p01b7d', NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `act_hi_procinst` (`ID_`, `REV_`, `PROC_INST_ID_`, `BUSINESS_KEY_`, `PROC_DEF_ID_`, `START_TIME_`, `END_TIME_`, `DURATION_`, `START_USER_ID_`, `START_ACT_ID_`, `END_ACT_ID_`, `SUPER_PROCESS_INSTANCE_ID_`, `DELETE_REASON_`, `TENANT_ID_`, `NAME_`, `CALLBACK_ID_`, `CALLBACK_TYPE_`, `REFERENCE_ID_`, `REFERENCE_TYPE_`, `PROPAGATED_STAGE_INST_ID_`, `BUSINESS_STATUS_`) VALUES ('3ef44d28-b340-11ed-9d23-869ef1607803', 1, '3ef44d28-b340-11ed-9d23-869ef1607803', NULL, 'testoa:16:98955103-b33e-11ed-b511-ce4fe10f37b8', '2023-02-23 06:06:43.383', NULL, NULL, '1', 'startNode1', NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `act_hi_procinst` (`ID_`, `REV_`, `PROC_INST_ID_`, `BUSINESS_KEY_`, `PROC_DEF_ID_`, `START_TIME_`, `END_TIME_`, `DURATION_`, `START_USER_ID_`, `START_ACT_ID_`, `END_ACT_ID_`, `SUPER_PROCESS_INSTANCE_ID_`, `DELETE_REASON_`, `TENANT_ID_`, `NAME_`, `CALLBACK_ID_`, `CALLBACK_TYPE_`, `REFERENCE_ID_`, `REFERENCE_TYPE_`, `PROPAGATED_STAGE_INST_ID_`, `BUSINESS_STATUS_`) VALUES ('4125bf0e-584e-11ee-9923-f22f4b0aefad', 1, '4125bf0e-584e-11ee-9923-f22f4b0aefad', NULL, 'testvue3:2:1e8d1651-584e-11ee-9923-f22f4b0aefad', '2023-09-21 07:12:41.875', NULL, NULL, '1', 'startNode1', NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `act_hi_procinst` (`ID_`, `REV_`, `PROC_INST_ID_`, `BUSINESS_KEY_`, `PROC_DEF_ID_`, `START_TIME_`, `END_TIME_`, `DURATION_`, `START_USER_ID_`, `START_ACT_ID_`, `END_ACT_ID_`, `SUPER_PROCESS_INSTANCE_ID_`, `DELETE_REASON_`, `TENANT_ID_`, `NAME_`, `CALLBACK_ID_`, `CALLBACK_TYPE_`, `REFERENCE_ID_`, `REFERENCE_TYPE_`, `PROPAGATED_STAGE_INST_ID_`, `BUSINESS_STATUS_`) VALUES ('65359e7a-584e-11ee-9923-f22f4b0aefad', 1, '65359e7a-584e-11ee-9923-f22f4b0aefad', NULL, 'testvue3:2:1e8d1651-584e-11ee-9923-f22f4b0aefad', '2023-09-21 07:13:42.377', NULL, NULL, '1', 'startNode1', NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `act_hi_procinst` (`ID_`, `REV_`, `PROC_INST_ID_`, `BUSINESS_KEY_`, `PROC_DEF_ID_`, `START_TIME_`, `END_TIME_`, `DURATION_`, `START_USER_ID_`, `START_ACT_ID_`, `END_ACT_ID_`, `SUPER_PROCESS_INSTANCE_ID_`, `DELETE_REASON_`, `TENANT_ID_`, `NAME_`, `CALLBACK_ID_`, `CALLBACK_TYPE_`, `REFERENCE_ID_`, `REFERENCE_TYPE_`, `PROPAGATED_STAGE_INST_ID_`, `BUSINESS_STATUS_`) VALUES ('a573b064-b33e-11ed-b511-ce4fe10f37b8', 2, 'a573b064-b33e-11ed-b511-ce4fe10f37b8', NULL, 'testoa:16:98955103-b33e-11ed-b511-ce4fe10f37b8', '2023-02-23 05:55:16.352', '2023-02-23 05:58:03.866', 167514, '1', 'startNode1', 'Event_0p01b7d', NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `act_hi_procinst` (`ID_`, `REV_`, `PROC_INST_ID_`, `BUSINESS_KEY_`, `PROC_DEF_ID_`, `START_TIME_`, `END_TIME_`, `DURATION_`, `START_USER_ID_`, `START_ACT_ID_`, `END_ACT_ID_`, `SUPER_PROCESS_INSTANCE_ID_`, `DELETE_REASON_`, `TENANT_ID_`, `NAME_`, `CALLBACK_ID_`, `CALLBACK_TYPE_`, `REFERENCE_ID_`, `REFERENCE_TYPE_`, `PROPAGATED_STAGE_INST_ID_`, `BUSINESS_STATUS_`) VALUES ('b7a5dd82-5851-11ee-9923-f22f4b0aefad', 1, 'b7a5dd82-5851-11ee-9923-f22f4b0aefad', NULL, 'testvue3:2:1e8d1651-584e-11ee-9923-f22f4b0aefad', '2023-09-21 07:37:29.176', NULL, NULL, '1', 'startNode1', NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `act_hi_procinst` (`ID_`, `REV_`, `PROC_INST_ID_`, `BUSINESS_KEY_`, `PROC_DEF_ID_`, `START_TIME_`, `END_TIME_`, `DURATION_`, `START_USER_ID_`, `START_ACT_ID_`, `END_ACT_ID_`, `SUPER_PROCESS_INSTANCE_ID_`, `DELETE_REASON_`, `TENANT_ID_`, `NAME_`, `CALLBACK_ID_`, `CALLBACK_TYPE_`, `REFERENCE_ID_`, `REFERENCE_TYPE_`, `PROPAGATED_STAGE_INST_ID_`, `BUSINESS_STATUS_`) VALUES ('b8058c96-b345-11ed-8617-ce4fe10f37b8', 1, 'b8058c96-b345-11ed-8617-ce4fe10f37b8', NULL, 'testoa:16:98955103-b33e-11ed-b511-ce4fe10f37b8', '2023-02-23 06:45:53.984', NULL, NULL, '1', 'startNode1', NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `act_hi_procinst` (`ID_`, `REV_`, `PROC_INST_ID_`, `BUSINESS_KEY_`, `PROC_DEF_ID_`, `START_TIME_`, `END_TIME_`, `DURATION_`, `START_USER_ID_`, `START_ACT_ID_`, `END_ACT_ID_`, `SUPER_PROCESS_INSTANCE_ID_`, `DELETE_REASON_`, `TENANT_ID_`, `NAME_`, `CALLBACK_ID_`, `CALLBACK_TYPE_`, `REFERENCE_ID_`, `REFERENCE_TYPE_`, `PROPAGATED_STAGE_INST_ID_`, `BUSINESS_STATUS_`) VALUES ('bb8dbc01-246c-11ee-8f95-36d2b240f315', 2, 'bb8dbc01-246c-11ee-8f95-36d2b240f315', NULL, 'testoa:16:98955103-b33e-11ed-b511-ce4fe10f37b8', '2023-07-17 06:39:51.676', '2023-07-17 06:41:50.364', 118688, '1', 'startNode1', 'Event_0p01b7d', NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `act_hi_procinst` (`ID_`, `REV_`, `PROC_INST_ID_`, `BUSINESS_KEY_`, `PROC_DEF_ID_`, `START_TIME_`, `END_TIME_`, `DURATION_`, `START_USER_ID_`, `START_ACT_ID_`, `END_ACT_ID_`, `SUPER_PROCESS_INSTANCE_ID_`, `DELETE_REASON_`, `TENANT_ID_`, `NAME_`, `CALLBACK_ID_`, `CALLBACK_TYPE_`, `REFERENCE_ID_`, `REFERENCE_TYPE_`, `PROPAGATED_STAGE_INST_ID_`, `BUSINESS_STATUS_`) VALUES ('d48d87ed-b33f-11ed-9d23-869ef1607803', 1, 'd48d87ed-b33f-11ed-9d23-869ef1607803', NULL, 'testoa:16:98955103-b33e-11ed-b511-ce4fe10f37b8', '2023-02-23 06:03:44.871', NULL, NULL, '1', 'startNode1', NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `act_hi_procinst` (`ID_`, `REV_`, `PROC_INST_ID_`, `BUSINESS_KEY_`, `PROC_DEF_ID_`, `START_TIME_`, `END_TIME_`, `DURATION_`, `START_USER_ID_`, `START_ACT_ID_`, `END_ACT_ID_`, `SUPER_PROCESS_INSTANCE_ID_`, `DELETE_REASON_`, `TENANT_ID_`, `NAME_`, `CALLBACK_ID_`, `CALLBACK_TYPE_`, `REFERENCE_ID_`, `REFERENCE_TYPE_`, `PROPAGATED_STAGE_INST_ID_`, `BUSINESS_STATUS_`) VALUES ('ede26906-5850-11ee-9923-f22f4b0aefad', 1, 'ede26906-5850-11ee-9923-f22f4b0aefad', NULL, 'testvue3:2:1e8d1651-584e-11ee-9923-f22f4b0aefad', '2023-09-21 07:31:50.673', NULL, NULL, '1', 'startNode1', NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `act_hi_procinst` (`ID_`, `REV_`, `PROC_INST_ID_`, `BUSINESS_KEY_`, `PROC_DEF_ID_`, `START_TIME_`, `END_TIME_`, `DURATION_`, `START_USER_ID_`, `START_ACT_ID_`, `END_ACT_ID_`, `SUPER_PROCESS_INSTANCE_ID_`, `DELETE_REASON_`, `TENANT_ID_`, `NAME_`, `CALLBACK_ID_`, `CALLBACK_TYPE_`, `REFERENCE_ID_`, `REFERENCE_TYPE_`, `PROPAGATED_STAGE_INST_ID_`, `BUSINESS_STATUS_`) VALUES ('ff6d67b2-584d-11ee-9923-f22f4b0aefad', 1, 'ff6d67b2-584d-11ee-9923-f22f4b0aefad', NULL, 'testvue3:1:2aea33f1-56c2-11ee-ae41-f22f4b0aefad', '2023-09-21 07:10:51.615', NULL, NULL, '1', 'startNode1', NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for act_hi_taskinst
-- ----------------------------
DROP TABLE IF EXISTS `act_hi_taskinst`;
CREATE TABLE `act_hi_taskinst` (
                                   `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                   `REV_` int DEFAULT '1',
                                   `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                   `TASK_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                   `TASK_DEF_KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                   `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                   `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                   `SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                   `SUB_SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                   `SCOPE_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                   `SCOPE_DEFINITION_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                   `PROPAGATED_STAGE_INST_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                   `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                   `PARENT_TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                   `DESCRIPTION_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
                                   `OWNER_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                   `ASSIGNEE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                   `START_TIME_` datetime(3) NOT NULL,
                                   `CLAIM_TIME_` datetime(3) DEFAULT NULL,
                                   `END_TIME_` datetime(3) DEFAULT NULL,
                                   `DURATION_` bigint DEFAULT NULL,
                                   `DELETE_REASON_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
                                   `PRIORITY_` int DEFAULT NULL,
                                   `DUE_DATE_` datetime(3) DEFAULT NULL,
                                   `FORM_KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                   `CATEGORY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                   `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
                                   `LAST_UPDATED_TIME_` datetime(3) DEFAULT NULL,
                                   PRIMARY KEY (`ID_`),
                                   KEY `ACT_IDX_HI_TASK_SCOPE` (`SCOPE_ID_`,`SCOPE_TYPE_`),
                                   KEY `ACT_IDX_HI_TASK_SUB_SCOPE` (`SUB_SCOPE_ID_`,`SCOPE_TYPE_`),
                                   KEY `ACT_IDX_HI_TASK_SCOPE_DEF` (`SCOPE_DEFINITION_ID_`,`SCOPE_TYPE_`),
                                   KEY `ACT_IDX_HI_TASK_INST_PROCINST` (`PROC_INST_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_hi_taskinst
-- ----------------------------
BEGIN;
INSERT INTO `act_hi_taskinst` (`ID_`, `REV_`, `PROC_DEF_ID_`, `TASK_DEF_ID_`, `TASK_DEF_KEY_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `SCOPE_DEFINITION_ID_`, `PROPAGATED_STAGE_INST_ID_`, `NAME_`, `PARENT_TASK_ID_`, `DESCRIPTION_`, `OWNER_`, `ASSIGNEE_`, `START_TIME_`, `CLAIM_TIME_`, `END_TIME_`, `DURATION_`, `DELETE_REASON_`, `PRIORITY_`, `DUE_DATE_`, `FORM_KEY_`, `CATEGORY_`, `TENANT_ID_`, `LAST_UPDATED_TIME_`) VALUES ('061dcecf-b347-11ed-bdbd-ce4fe10f37b8', 2, 'testoa:16:98955103-b33e-11ed-b511-ce4fe10f37b8', NULL, 'Activity_0exhfyz', '3477e76a-b342-11ed-abc3-869ef1607803', '34791ff5-b342-11ed-abc3-869ef1607803', NULL, NULL, NULL, NULL, NULL, '验收', NULL, NULL, NULL, '1', '2023-02-23 06:55:14.501', NULL, '2023-02-23 06:55:22.452', 7951, NULL, 50, NULL, NULL, NULL, '', '2023-02-23 06:55:22.452');
INSERT INTO `act_hi_taskinst` (`ID_`, `REV_`, `PROC_DEF_ID_`, `TASK_DEF_ID_`, `TASK_DEF_KEY_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `SCOPE_DEFINITION_ID_`, `PROPAGATED_STAGE_INST_ID_`, `NAME_`, `PARENT_TASK_ID_`, `DESCRIPTION_`, `OWNER_`, `ASSIGNEE_`, `START_TIME_`, `CLAIM_TIME_`, `END_TIME_`, `DURATION_`, `DELETE_REASON_`, `PRIORITY_`, `DUE_DATE_`, `FORM_KEY_`, `CATEGORY_`, `TENANT_ID_`, `LAST_UPDATED_TIME_`) VALUES ('1188c1ce-b33f-11ed-b511-ce4fe10f37b8', 3, 'testoa:16:98955103-b33e-11ed-b511-ce4fe10f37b8', NULL, 'Activity_1qo8esf', '11884c8f-b33f-11ed-b511-ce4fe10f37b8', '1188c1ca-b33f-11ed-b511-ce4fe10f37b8', NULL, NULL, NULL, NULL, NULL, '经理审批', NULL, NULL, NULL, '1', '2023-02-23 05:58:17.684', NULL, '2023-02-23 06:05:53.098', 455414, NULL, 50, NULL, NULL, NULL, '', '2023-02-23 06:05:53.098');
INSERT INTO `act_hi_taskinst` (`ID_`, `REV_`, `PROC_DEF_ID_`, `TASK_DEF_ID_`, `TASK_DEF_KEY_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `SCOPE_DEFINITION_ID_`, `PROPAGATED_STAGE_INST_ID_`, `NAME_`, `PARENT_TASK_ID_`, `DESCRIPTION_`, `OWNER_`, `ASSIGNEE_`, `START_TIME_`, `CLAIM_TIME_`, `END_TIME_`, `DURATION_`, `DELETE_REASON_`, `PRIORITY_`, `DUE_DATE_`, `FORM_KEY_`, `CATEGORY_`, `TENANT_ID_`, `LAST_UPDATED_TIME_`) VALUES ('20fd4017-b340-11ed-9d23-869ef1607803', 1, 'testoa:16:98955103-b33e-11ed-b511-ce4fe10f37b8', NULL, 'Activity_0exhfyz', '11884c8f-b33f-11ed-b511-ce4fe10f37b8', '1188c1ca-b33f-11ed-b511-ce4fe10f37b8', NULL, NULL, NULL, NULL, NULL, '验收', NULL, NULL, NULL, NULL, '2023-02-23 06:05:53.110', NULL, NULL, NULL, NULL, 50, NULL, NULL, NULL, '', '2023-02-23 06:05:53.110');
INSERT INTO `act_hi_taskinst` (`ID_`, `REV_`, `PROC_DEF_ID_`, `TASK_DEF_ID_`, `TASK_DEF_KEY_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `SCOPE_DEFINITION_ID_`, `PROPAGATED_STAGE_INST_ID_`, `NAME_`, `PARENT_TASK_ID_`, `DESCRIPTION_`, `OWNER_`, `ASSIGNEE_`, `START_TIME_`, `CLAIM_TIME_`, `END_TIME_`, `DURATION_`, `DELETE_REASON_`, `PRIORITY_`, `DUE_DATE_`, `FORM_KEY_`, `CATEGORY_`, `TENANT_ID_`, `LAST_UPDATED_TIME_`) VALUES ('347b90f9-b342-11ed-abc3-869ef1607803', 2, 'testoa:16:98955103-b33e-11ed-b511-ce4fe10f37b8', NULL, 'Activity_1qo8esf', '3477e76a-b342-11ed-abc3-869ef1607803', '34791ff5-b342-11ed-abc3-869ef1607803', NULL, NULL, NULL, NULL, NULL, '经理审批', NULL, NULL, NULL, NULL, '2023-02-23 06:20:44.796', NULL, '2023-02-23 06:20:58.444', 13648, NULL, 50, NULL, NULL, NULL, '', '2023-02-23 06:20:58.444');
INSERT INTO `act_hi_taskinst` (`ID_`, `REV_`, `PROC_DEF_ID_`, `TASK_DEF_ID_`, `TASK_DEF_KEY_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `SCOPE_DEFINITION_ID_`, `PROPAGATED_STAGE_INST_ID_`, `NAME_`, `PARENT_TASK_ID_`, `DESCRIPTION_`, `OWNER_`, `ASSIGNEE_`, `START_TIME_`, `CLAIM_TIME_`, `END_TIME_`, `DURATION_`, `DELETE_REASON_`, `PRIORITY_`, `DUE_DATE_`, `FORM_KEY_`, `CATEGORY_`, `TENANT_ID_`, `LAST_UPDATED_TIME_`) VALUES ('3ca1e692-b342-11ed-abc3-869ef1607803', 2, 'testoa:16:98955103-b33e-11ed-b511-ce4fe10f37b8', NULL, 'Activity_1qfkof6', '3477e76a-b342-11ed-abc3-869ef1607803', '34791ff5-b342-11ed-abc3-869ef1607803', NULL, NULL, NULL, NULL, NULL, '重新发起', NULL, NULL, NULL, '1', '2023-02-23 06:20:58.480', NULL, '2023-02-23 06:46:11.671', 1513191, NULL, 50, NULL, NULL, NULL, '', '2023-02-23 06:46:11.671');
INSERT INTO `act_hi_taskinst` (`ID_`, `REV_`, `PROC_DEF_ID_`, `TASK_DEF_ID_`, `TASK_DEF_KEY_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `SCOPE_DEFINITION_ID_`, `PROPAGATED_STAGE_INST_ID_`, `NAME_`, `PARENT_TASK_ID_`, `DESCRIPTION_`, `OWNER_`, `ASSIGNEE_`, `START_TIME_`, `CLAIM_TIME_`, `END_TIME_`, `DURATION_`, `DELETE_REASON_`, `PRIORITY_`, `DUE_DATE_`, `FORM_KEY_`, `CATEGORY_`, `TENANT_ID_`, `LAST_UPDATED_TIME_`) VALUES ('3ef47447-b340-11ed-9d23-869ef1607803', 3, 'testoa:16:98955103-b33e-11ed-b511-ce4fe10f37b8', NULL, 'Activity_1qo8esf', '3ef44d28-b340-11ed-9d23-869ef1607803', '3ef44d33-b340-11ed-9d23-869ef1607803', NULL, NULL, NULL, NULL, NULL, '经理审批', NULL, NULL, '1', NULL, '2023-02-23 06:06:43.384', NULL, '2023-02-23 06:10:28.187', 224803, NULL, 50, NULL, NULL, NULL, '', '2023-02-23 06:10:28.187');
INSERT INTO `act_hi_taskinst` (`ID_`, `REV_`, `PROC_DEF_ID_`, `TASK_DEF_ID_`, `TASK_DEF_KEY_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `SCOPE_DEFINITION_ID_`, `PROPAGATED_STAGE_INST_ID_`, `NAME_`, `PARENT_TASK_ID_`, `DESCRIPTION_`, `OWNER_`, `ASSIGNEE_`, `START_TIME_`, `CLAIM_TIME_`, `END_TIME_`, `DURATION_`, `DELETE_REASON_`, `PRIORITY_`, `DUE_DATE_`, `FORM_KEY_`, `CATEGORY_`, `TENANT_ID_`, `LAST_UPDATED_TIME_`) VALUES ('a5744cb3-b33e-11ed-b511-ce4fe10f37b8', 2, 'testoa:16:98955103-b33e-11ed-b511-ce4fe10f37b8', NULL, 'Activity_1qo8esf', 'a573b064-b33e-11ed-b511-ce4fe10f37b8', 'a574259f-b33e-11ed-b511-ce4fe10f37b8', NULL, NULL, NULL, NULL, NULL, '经理审批', NULL, NULL, NULL, NULL, '2023-02-23 05:55:16.356', NULL, '2023-02-23 05:55:27.035', 10679, NULL, 50, NULL, NULL, NULL, '', '2023-02-23 05:55:27.035');
INSERT INTO `act_hi_taskinst` (`ID_`, `REV_`, `PROC_DEF_ID_`, `TASK_DEF_ID_`, `TASK_DEF_KEY_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `SCOPE_DEFINITION_ID_`, `PROPAGATED_STAGE_INST_ID_`, `NAME_`, `PARENT_TASK_ID_`, `DESCRIPTION_`, `OWNER_`, `ASSIGNEE_`, `START_TIME_`, `CLAIM_TIME_`, `END_TIME_`, `DURATION_`, `DELETE_REASON_`, `PRIORITY_`, `DUE_DATE_`, `FORM_KEY_`, `CATEGORY_`, `TENANT_ID_`, `LAST_UPDATED_TIME_`) VALUES ('abd5e7dc-b33e-11ed-b511-ce4fe10f37b8', 2, 'testoa:16:98955103-b33e-11ed-b511-ce4fe10f37b8', NULL, 'Activity_1qfkof6', 'a573b064-b33e-11ed-b511-ce4fe10f37b8', 'a574259f-b33e-11ed-b511-ce4fe10f37b8', NULL, NULL, NULL, NULL, NULL, '重新发起', NULL, NULL, NULL, NULL, '2023-02-23 05:55:27.062', NULL, '2023-02-23 05:58:03.500', 156438, 'Change activity to Event_0p01b7d', 50, NULL, NULL, NULL, '', '2023-02-23 05:58:03.500');
INSERT INTO `act_hi_taskinst` (`ID_`, `REV_`, `PROC_DEF_ID_`, `TASK_DEF_ID_`, `TASK_DEF_KEY_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `SCOPE_DEFINITION_ID_`, `PROPAGATED_STAGE_INST_ID_`, `NAME_`, `PARENT_TASK_ID_`, `DESCRIPTION_`, `OWNER_`, `ASSIGNEE_`, `START_TIME_`, `CLAIM_TIME_`, `END_TIME_`, `DURATION_`, `DELETE_REASON_`, `PRIORITY_`, `DUE_DATE_`, `FORM_KEY_`, `CATEGORY_`, `TENANT_ID_`, `LAST_UPDATED_TIME_`) VALUES ('b80abcc5-b345-11ed-8617-ce4fe10f37b8', 1, 'testoa:16:98955103-b33e-11ed-b511-ce4fe10f37b8', NULL, 'Activity_1qo8esf', 'b8058c96-b345-11ed-8617-ce4fe10f37b8', 'b8073a51-b345-11ed-8617-ce4fe10f37b8', NULL, NULL, NULL, NULL, NULL, '经理审批', NULL, NULL, NULL, NULL, '2023-02-23 06:45:54.002', NULL, NULL, NULL, NULL, 50, NULL, NULL, NULL, '', '2023-02-23 06:45:54.019');
INSERT INTO `act_hi_taskinst` (`ID_`, `REV_`, `PROC_DEF_ID_`, `TASK_DEF_ID_`, `TASK_DEF_KEY_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `SCOPE_DEFINITION_ID_`, `PROPAGATED_STAGE_INST_ID_`, `NAME_`, `PARENT_TASK_ID_`, `DESCRIPTION_`, `OWNER_`, `ASSIGNEE_`, `START_TIME_`, `CLAIM_TIME_`, `END_TIME_`, `DURATION_`, `DELETE_REASON_`, `PRIORITY_`, `DUE_DATE_`, `FORM_KEY_`, `CATEGORY_`, `TENANT_ID_`, `LAST_UPDATED_TIME_`) VALUES ('bb93af80-246c-11ee-8f95-36d2b240f315', 2, 'testoa:16:98955103-b33e-11ed-b511-ce4fe10f37b8', NULL, 'Activity_1qo8esf', 'bb8dbc01-246c-11ee-8f95-36d2b240f315', 'bb90541c-246c-11ee-8f95-36d2b240f315', NULL, NULL, NULL, NULL, NULL, '经理审批', NULL, NULL, NULL, NULL, '2023-07-17 06:39:51.700', NULL, '2023-07-17 06:40:29.081', 37381, NULL, 50, NULL, NULL, NULL, '', '2023-07-17 06:40:29.081');
INSERT INTO `act_hi_taskinst` (`ID_`, `REV_`, `PROC_DEF_ID_`, `TASK_DEF_ID_`, `TASK_DEF_KEY_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `SCOPE_DEFINITION_ID_`, `PROPAGATED_STAGE_INST_ID_`, `NAME_`, `PARENT_TASK_ID_`, `DESCRIPTION_`, `OWNER_`, `ASSIGNEE_`, `START_TIME_`, `CLAIM_TIME_`, `END_TIME_`, `DURATION_`, `DELETE_REASON_`, `PRIORITY_`, `DUE_DATE_`, `FORM_KEY_`, `CATEGORY_`, `TENANT_ID_`, `LAST_UPDATED_TIME_`) VALUES ('c29281fb-b345-11ed-8617-ce4fe10f37b8', 3, 'testoa:16:98955103-b33e-11ed-b511-ce4fe10f37b8', NULL, 'Activity_1qo8esf', '3477e76a-b342-11ed-abc3-869ef1607803', '34791ff5-b342-11ed-abc3-869ef1607803', NULL, NULL, NULL, NULL, NULL, '经理审批', NULL, NULL, NULL, '1', '2023-02-23 06:46:11.684', NULL, '2023-02-23 06:55:14.463', 542779, NULL, 50, NULL, NULL, NULL, '', '2023-02-23 06:55:14.463');
INSERT INTO `act_hi_taskinst` (`ID_`, `REV_`, `PROC_DEF_ID_`, `TASK_DEF_ID_`, `TASK_DEF_KEY_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `SCOPE_DEFINITION_ID_`, `PROPAGATED_STAGE_INST_ID_`, `NAME_`, `PARENT_TASK_ID_`, `DESCRIPTION_`, `OWNER_`, `ASSIGNEE_`, `START_TIME_`, `CLAIM_TIME_`, `END_TIME_`, `DURATION_`, `DELETE_REASON_`, `PRIORITY_`, `DUE_DATE_`, `FORM_KEY_`, `CATEGORY_`, `TENANT_ID_`, `LAST_UPDATED_TIME_`) VALUES ('c4fce411-b340-11ed-88a8-869ef1607803', 1, 'testoa:16:98955103-b33e-11ed-b511-ce4fe10f37b8', NULL, 'Activity_1qfkof6', '3ef44d28-b340-11ed-9d23-869ef1607803', '3ef44d33-b340-11ed-9d23-869ef1607803', NULL, NULL, NULL, NULL, NULL, '重新发起', NULL, NULL, NULL, NULL, '2023-02-23 06:10:28.253', NULL, NULL, NULL, NULL, 50, NULL, NULL, NULL, '', '2023-02-23 06:10:28.254');
INSERT INTO `act_hi_taskinst` (`ID_`, `REV_`, `PROC_DEF_ID_`, `TASK_DEF_ID_`, `TASK_DEF_KEY_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `SCOPE_DEFINITION_ID_`, `PROPAGATED_STAGE_INST_ID_`, `NAME_`, `PARENT_TASK_ID_`, `DESCRIPTION_`, `OWNER_`, `ASSIGNEE_`, `START_TIME_`, `CLAIM_TIME_`, `END_TIME_`, `DURATION_`, `DELETE_REASON_`, `PRIORITY_`, `DUE_DATE_`, `FORM_KEY_`, `CATEGORY_`, `TENANT_ID_`, `LAST_UPDATED_TIME_`) VALUES ('d1db92d9-246c-11ee-8f95-36d2b240f315', 2, 'testoa:16:98955103-b33e-11ed-b511-ce4fe10f37b8', NULL, 'Activity_1qfkof6', 'bb8dbc01-246c-11ee-8f95-36d2b240f315', 'bb90541c-246c-11ee-8f95-36d2b240f315', NULL, NULL, NULL, NULL, NULL, '重新发起', NULL, NULL, NULL, '1', '2023-07-17 06:40:29.096', NULL, '2023-07-17 06:41:15.594', 46498, NULL, 50, NULL, NULL, NULL, '', '2023-07-17 06:41:15.594');
INSERT INTO `act_hi_taskinst` (`ID_`, `REV_`, `PROC_DEF_ID_`, `TASK_DEF_ID_`, `TASK_DEF_KEY_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `SCOPE_DEFINITION_ID_`, `PROPAGATED_STAGE_INST_ID_`, `NAME_`, `PARENT_TASK_ID_`, `DESCRIPTION_`, `OWNER_`, `ASSIGNEE_`, `START_TIME_`, `CLAIM_TIME_`, `END_TIME_`, `DURATION_`, `DELETE_REASON_`, `PRIORITY_`, `DUE_DATE_`, `FORM_KEY_`, `CATEGORY_`, `TENANT_ID_`, `LAST_UPDATED_TIME_`) VALUES ('d4910a6c-b33f-11ed-9d23-869ef1607803', 4, 'testoa:16:98955103-b33e-11ed-b511-ce4fe10f37b8', NULL, 'Activity_1qo8esf', 'd48d87ed-b33f-11ed-9d23-869ef1607803', 'd48e7258-b33f-11ed-9d23-869ef1607803', NULL, NULL, NULL, NULL, NULL, '经理审批', NULL, NULL, '1', '1', '2023-02-23 06:03:44.882', NULL, '2023-02-23 06:03:55.019', 10137, NULL, 50, NULL, NULL, NULL, '', '2023-02-23 06:03:55.019');
INSERT INTO `act_hi_taskinst` (`ID_`, `REV_`, `PROC_DEF_ID_`, `TASK_DEF_ID_`, `TASK_DEF_KEY_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `SCOPE_DEFINITION_ID_`, `PROPAGATED_STAGE_INST_ID_`, `NAME_`, `PARENT_TASK_ID_`, `DESCRIPTION_`, `OWNER_`, `ASSIGNEE_`, `START_TIME_`, `CLAIM_TIME_`, `END_TIME_`, `DURATION_`, `DELETE_REASON_`, `PRIORITY_`, `DUE_DATE_`, `FORM_KEY_`, `CATEGORY_`, `TENANT_ID_`, `LAST_UPDATED_TIME_`) VALUES ('da9dceda-b33f-11ed-9d23-869ef1607803', 1, 'testoa:16:98955103-b33e-11ed-b511-ce4fe10f37b8', NULL, 'Activity_1qfkof6', 'd48d87ed-b33f-11ed-9d23-869ef1607803', 'd48e7258-b33f-11ed-9d23-869ef1607803', NULL, NULL, NULL, NULL, NULL, '重新发起', NULL, NULL, NULL, NULL, '2023-02-23 06:03:55.044', NULL, NULL, NULL, NULL, 50, NULL, NULL, NULL, '', '2023-02-23 06:03:55.044');
INSERT INTO `act_hi_taskinst` (`ID_`, `REV_`, `PROC_DEF_ID_`, `TASK_DEF_ID_`, `TASK_DEF_KEY_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `SCOPE_DEFINITION_ID_`, `PROPAGATED_STAGE_INST_ID_`, `NAME_`, `PARENT_TASK_ID_`, `DESCRIPTION_`, `OWNER_`, `ASSIGNEE_`, `START_TIME_`, `CLAIM_TIME_`, `END_TIME_`, `DURATION_`, `DELETE_REASON_`, `PRIORITY_`, `DUE_DATE_`, `FORM_KEY_`, `CATEGORY_`, `TENANT_ID_`, `LAST_UPDATED_TIME_`) VALUES ('ed93ac6f-246c-11ee-8f95-36d2b240f315', 3, 'testoa:16:98955103-b33e-11ed-b511-ce4fe10f37b8', NULL, 'Activity_1qo8esf', 'bb8dbc01-246c-11ee-8f95-36d2b240f315', 'bb90541c-246c-11ee-8f95-36d2b240f315', NULL, NULL, NULL, NULL, NULL, '经理审批', NULL, NULL, NULL, '1', '2023-07-17 06:41:15.601', NULL, '2023-07-17 06:41:30.428', 14827, NULL, 50, NULL, NULL, NULL, '', '2023-07-17 06:41:30.428');
INSERT INTO `act_hi_taskinst` (`ID_`, `REV_`, `PROC_DEF_ID_`, `TASK_DEF_ID_`, `TASK_DEF_KEY_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `SCOPE_DEFINITION_ID_`, `PROPAGATED_STAGE_INST_ID_`, `NAME_`, `PARENT_TASK_ID_`, `DESCRIPTION_`, `OWNER_`, `ASSIGNEE_`, `START_TIME_`, `CLAIM_TIME_`, `END_TIME_`, `DURATION_`, `DELETE_REASON_`, `PRIORITY_`, `DUE_DATE_`, `FORM_KEY_`, `CATEGORY_`, `TENANT_ID_`, `LAST_UPDATED_TIME_`) VALUES ('f66b028a-246c-11ee-8f95-36d2b240f315', 2, 'testoa:16:98955103-b33e-11ed-b511-ce4fe10f37b8', NULL, 'Activity_0exhfyz', 'bb8dbc01-246c-11ee-8f95-36d2b240f315', 'bb90541c-246c-11ee-8f95-36d2b240f315', NULL, NULL, NULL, NULL, NULL, '验收', NULL, NULL, NULL, '1', '2023-07-17 06:41:30.434', NULL, '2023-07-17 06:41:50.289', 19855, NULL, 50, NULL, NULL, NULL, '', '2023-07-17 06:41:50.289');
COMMIT;

-- ----------------------------
-- Table structure for act_hi_tsk_log
-- ----------------------------
DROP TABLE IF EXISTS `act_hi_tsk_log`;
CREATE TABLE `act_hi_tsk_log` (
                                  `ID_` bigint NOT NULL AUTO_INCREMENT,
                                  `TYPE_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                  `TASK_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                  `TIME_STAMP_` timestamp(3) NOT NULL,
                                  `USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                  `DATA_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
                                  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                  `SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                  `SCOPE_DEFINITION_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                  `SUB_SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                  `SCOPE_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
                                  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_hi_tsk_log
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for act_hi_varinst
-- ----------------------------
DROP TABLE IF EXISTS `act_hi_varinst`;
CREATE TABLE `act_hi_varinst` (
                                  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                  `REV_` int DEFAULT '1',
                                  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                  `NAME_` varchar(255) COLLATE utf8_bin NOT NULL,
                                  `VAR_TYPE_` varchar(100) COLLATE utf8_bin DEFAULT NULL,
                                  `SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                  `SUB_SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                  `SCOPE_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                  `BYTEARRAY_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                  `DOUBLE_` double DEFAULT NULL,
                                  `LONG_` bigint DEFAULT NULL,
                                  `TEXT_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
                                  `TEXT2_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
                                  `CREATE_TIME_` datetime(3) DEFAULT NULL,
                                  `LAST_UPDATED_TIME_` datetime(3) DEFAULT NULL,
                                  `META_INFO_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
                                  PRIMARY KEY (`ID_`),
                                  KEY `ACT_IDX_HI_PROCVAR_NAME_TYPE` (`NAME_`,`VAR_TYPE_`),
                                  KEY `ACT_IDX_HI_VAR_SCOPE_ID_TYPE` (`SCOPE_ID_`,`SCOPE_TYPE_`),
                                  KEY `ACT_IDX_HI_VAR_SUB_ID_TYPE` (`SUB_SCOPE_ID_`,`SCOPE_TYPE_`),
                                  KEY `ACT_IDX_HI_PROCVAR_PROC_INST` (`PROC_INST_ID_`),
                                  KEY `ACT_IDX_HI_PROCVAR_TASK_ID` (`TASK_ID_`),
                                  KEY `ACT_IDX_HI_PROCVAR_EXE` (`EXECUTION_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_hi_varinst
-- ----------------------------
BEGIN;
INSERT INTO `act_hi_varinst` (`ID_`, `REV_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `TASK_ID_`, `NAME_`, `VAR_TYPE_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `CREATE_TIME_`, `LAST_UPDATED_TIME_`, `META_INFO_`) VALUES ('11889ab2-b33f-11ed-b511-ce4fe10f37b8', 0, '11884c8f-b33f-11ed-b511-ce4fe10f37b8', '11884c8f-b33f-11ed-b511-ce4fe10f37b8', NULL, 'leavetime', 'serializable', NULL, NULL, NULL, '11889ab3-b33f-11ed-b511-ce4fe10f37b8', NULL, NULL, NULL, NULL, '2023-02-23 05:58:17.683', '2023-02-23 05:58:17.683', NULL);
INSERT INTO `act_hi_varinst` (`ID_`, `REV_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `TASK_ID_`, `NAME_`, `VAR_TYPE_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `CREATE_TIME_`, `LAST_UPDATED_TIME_`, `META_INFO_`) VALUES ('11889ab4-b33f-11ed-b511-ce4fe10f37b8', 0, '11884c8f-b33f-11ed-b511-ce4fe10f37b8', '11884c8f-b33f-11ed-b511-ce4fe10f37b8', NULL, 'leavetype', 'integer', NULL, NULL, NULL, NULL, NULL, 1, '1', NULL, '2023-02-23 05:58:17.683', '2023-02-23 05:58:17.683', NULL);
INSERT INTO `act_hi_varinst` (`ID_`, `REV_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `TASK_ID_`, `NAME_`, `VAR_TYPE_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `CREATE_TIME_`, `LAST_UPDATED_TIME_`, `META_INFO_`) VALUES ('11889ab5-b33f-11ed-b511-ce4fe10f37b8', 0, '11884c8f-b33f-11ed-b511-ce4fe10f37b8', '11884c8f-b33f-11ed-b511-ce4fe10f37b8', NULL, 'leavereason', 'string', NULL, NULL, NULL, NULL, NULL, NULL, '111', NULL, '2023-02-23 05:58:17.683', '2023-02-23 05:58:17.683', NULL);
INSERT INTO `act_hi_varinst` (`ID_`, `REV_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `TASK_ID_`, `NAME_`, `VAR_TYPE_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `CREATE_TIME_`, `LAST_UPDATED_TIME_`, `META_INFO_`) VALUES ('1188c1c7-b33f-11ed-b511-ce4fe10f37b8', 0, '11884c8f-b33f-11ed-b511-ce4fe10f37b8', '11884c8f-b33f-11ed-b511-ce4fe10f37b8', NULL, 'variables', 'serializable', NULL, NULL, NULL, '1188c1c8-b33f-11ed-b511-ce4fe10f37b8', NULL, NULL, NULL, NULL, '2023-02-23 05:58:17.684', '2023-02-23 05:58:17.684', NULL);
INSERT INTO `act_hi_varinst` (`ID_`, `REV_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `TASK_ID_`, `NAME_`, `VAR_TYPE_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `CREATE_TIME_`, `LAST_UPDATED_TIME_`, `META_INFO_`) VALUES ('1188c1c9-b33f-11ed-b511-ce4fe10f37b8', 0, '11884c8f-b33f-11ed-b511-ce4fe10f37b8', '11884c8f-b33f-11ed-b511-ce4fe10f37b8', NULL, 'INITIATOR', 'string', NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2023-02-23 05:58:17.684', '2023-02-23 05:58:17.684', NULL);
INSERT INTO `act_hi_varinst` (`ID_`, `REV_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `TASK_ID_`, `NAME_`, `VAR_TYPE_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `CREATE_TIME_`, `LAST_UPDATED_TIME_`, `META_INFO_`) VALUES ('20faf622-b340-11ed-9d23-869ef1607803', 0, '11884c8f-b33f-11ed-b511-ce4fe10f37b8', '11884c8f-b33f-11ed-b511-ce4fe10f37b8', NULL, 'approve', 'string', NULL, NULL, NULL, NULL, NULL, NULL, '同意', NULL, '2023-02-23 06:05:53.095', '2023-02-23 06:05:53.095', NULL);
INSERT INTO `act_hi_varinst` (`ID_`, `REV_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `TASK_ID_`, `NAME_`, `VAR_TYPE_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `CREATE_TIME_`, `LAST_UPDATED_TIME_`, `META_INFO_`) VALUES ('23cbb543-584e-11ee-9923-f22f4b0aefad', 0, '23cbb542-584e-11ee-9923-f22f4b0aefad', '23cbb542-584e-11ee-9923-f22f4b0aefad', NULL, 'INITIATOR', 'long', NULL, NULL, NULL, NULL, NULL, 1, '1', NULL, '2023-09-21 07:11:52.631', '2023-09-21 07:11:52.632', NULL);
INSERT INTO `act_hi_varinst` (`ID_`, `REV_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `TASK_ID_`, `NAME_`, `VAR_TYPE_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `CREATE_TIME_`, `LAST_UPDATED_TIME_`, `META_INFO_`) VALUES ('23cbb545-584e-11ee-9923-f22f4b0aefad', 0, '23cbb542-584e-11ee-9923-f22f4b0aefad', '23cbb542-584e-11ee-9923-f22f4b0aefad', NULL, 'name', 'string', NULL, NULL, NULL, NULL, NULL, NULL, '3333', NULL, '2023-09-21 07:11:52.631', '2023-09-21 07:11:52.631', NULL);
INSERT INTO `act_hi_varinst` (`ID_`, `REV_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `TASK_ID_`, `NAME_`, `VAR_TYPE_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `CREATE_TIME_`, `LAST_UPDATED_TIME_`, `META_INFO_`) VALUES ('23cbb547-584e-11ee-9923-f22f4b0aefad', 0, '23cbb542-584e-11ee-9923-f22f4b0aefad', '23cbb542-584e-11ee-9923-f22f4b0aefad', NULL, 'variables', 'serializable', NULL, NULL, NULL, '23cbb548-584e-11ee-9923-f22f4b0aefad', NULL, NULL, NULL, NULL, '2023-09-21 07:11:52.631', '2023-09-21 07:11:52.631', NULL);
INSERT INTO `act_hi_varinst` (`ID_`, `REV_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `TASK_ID_`, `NAME_`, `VAR_TYPE_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `CREATE_TIME_`, `LAST_UPDATED_TIME_`, `META_INFO_`) VALUES ('28c75a2f-5852-11ee-9923-f22f4b0aefad', 0, '28c75a2e-5852-11ee-9923-f22f4b0aefad', '28c75a2e-5852-11ee-9923-f22f4b0aefad', NULL, 'INITIATOR', 'long', NULL, NULL, NULL, NULL, NULL, 1, '1', NULL, '2023-09-21 07:40:38.978', '2023-09-21 07:40:38.978', NULL);
INSERT INTO `act_hi_varinst` (`ID_`, `REV_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `TASK_ID_`, `NAME_`, `VAR_TYPE_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `CREATE_TIME_`, `LAST_UPDATED_TIME_`, `META_INFO_`) VALUES ('28c75a32-5852-11ee-9923-f22f4b0aefad', 0, '28c75a2e-5852-11ee-9923-f22f4b0aefad', '28c75a2e-5852-11ee-9923-f22f4b0aefad', NULL, 'fields', 'serializable', NULL, NULL, NULL, '28c75a33-5852-11ee-9923-f22f4b0aefad', NULL, NULL, NULL, NULL, '2023-09-21 07:40:38.978', '2023-09-21 07:40:38.978', NULL);
INSERT INTO `act_hi_varinst` (`ID_`, `REV_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `TASK_ID_`, `NAME_`, `VAR_TYPE_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `CREATE_TIME_`, `LAST_UPDATED_TIME_`, `META_INFO_`) VALUES ('28c75a34-5852-11ee-9923-f22f4b0aefad', 0, '28c75a2e-5852-11ee-9923-f22f4b0aefad', '28c75a2e-5852-11ee-9923-f22f4b0aefad', NULL, 'name', 'string', NULL, NULL, NULL, NULL, NULL, NULL, '444', NULL, '2023-09-21 07:40:38.978', '2023-09-21 07:40:38.978', NULL);
INSERT INTO `act_hi_varinst` (`ID_`, `REV_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `TASK_ID_`, `NAME_`, `VAR_TYPE_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `CREATE_TIME_`, `LAST_UPDATED_TIME_`, `META_INFO_`) VALUES ('28c75a36-5852-11ee-9923-f22f4b0aefad', 0, '28c75a2e-5852-11ee-9923-f22f4b0aefad', '28c75a2e-5852-11ee-9923-f22f4b0aefad', NULL, 'variables', 'serializable', NULL, NULL, NULL, '28c75a37-5852-11ee-9923-f22f4b0aefad', NULL, NULL, NULL, NULL, '2023-09-21 07:40:38.978', '2023-09-21 07:40:38.978', NULL);
INSERT INTO `act_hi_varinst` (`ID_`, `REV_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `TASK_ID_`, `NAME_`, `VAR_TYPE_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `CREATE_TIME_`, `LAST_UPDATED_TIME_`, `META_INFO_`) VALUES ('3478aabd-b342-11ed-abc3-869ef1607803', 0, '3477e76a-b342-11ed-abc3-869ef1607803', '3477e76a-b342-11ed-abc3-869ef1607803', NULL, 'leavetime', 'serializable', NULL, NULL, NULL, '3478d1ce-b342-11ed-abc3-869ef1607803', NULL, NULL, NULL, NULL, '2023-02-23 06:20:44.790', '2023-02-23 06:20:44.790', NULL);
INSERT INTO `act_hi_varinst` (`ID_`, `REV_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `TASK_ID_`, `NAME_`, `VAR_TYPE_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `CREATE_TIME_`, `LAST_UPDATED_TIME_`, `META_INFO_`) VALUES ('3478d1cf-b342-11ed-abc3-869ef1607803', 0, '3477e76a-b342-11ed-abc3-869ef1607803', '3477e76a-b342-11ed-abc3-869ef1607803', NULL, 'leavetype', 'integer', NULL, NULL, NULL, NULL, NULL, 1, '1', NULL, '2023-02-23 06:20:44.790', '2023-02-23 06:20:44.790', NULL);
INSERT INTO `act_hi_varinst` (`ID_`, `REV_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `TASK_ID_`, `NAME_`, `VAR_TYPE_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `CREATE_TIME_`, `LAST_UPDATED_TIME_`, `META_INFO_`) VALUES ('3478d1d0-b342-11ed-abc3-869ef1607803', 0, '3477e76a-b342-11ed-abc3-869ef1607803', '3477e76a-b342-11ed-abc3-869ef1607803', NULL, 'leavereason', 'string', NULL, NULL, NULL, NULL, NULL, NULL, '222', NULL, '2023-02-23 06:20:44.790', '2023-02-23 06:20:44.790', NULL);
INSERT INTO `act_hi_varinst` (`ID_`, `REV_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `TASK_ID_`, `NAME_`, `VAR_TYPE_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `CREATE_TIME_`, `LAST_UPDATED_TIME_`, `META_INFO_`) VALUES ('3478f8e2-b342-11ed-abc3-869ef1607803', 0, '3477e76a-b342-11ed-abc3-869ef1607803', '3477e76a-b342-11ed-abc3-869ef1607803', NULL, 'variables', 'serializable', NULL, NULL, NULL, '3478f8e3-b342-11ed-abc3-869ef1607803', NULL, NULL, NULL, NULL, '2023-02-23 06:20:44.791', '2023-02-23 06:20:44.791', NULL);
INSERT INTO `act_hi_varinst` (`ID_`, `REV_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `TASK_ID_`, `NAME_`, `VAR_TYPE_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `CREATE_TIME_`, `LAST_UPDATED_TIME_`, `META_INFO_`) VALUES ('3478f8e4-b342-11ed-abc3-869ef1607803', 0, '3477e76a-b342-11ed-abc3-869ef1607803', '3477e76a-b342-11ed-abc3-869ef1607803', NULL, 'INITIATOR', 'string', NULL, NULL, NULL, NULL, NULL, NULL, '1', NULL, '2023-02-23 06:20:44.791', '2023-02-23 06:20:44.791', NULL);
INSERT INTO `act_hi_varinst` (`ID_`, `REV_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `TASK_ID_`, `NAME_`, `VAR_TYPE_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `CREATE_TIME_`, `LAST_UPDATED_TIME_`, `META_INFO_`) VALUES ('3c9b56dd-b342-11ed-abc3-869ef1607803', 3, '3477e76a-b342-11ed-abc3-869ef1607803', '3477e76a-b342-11ed-abc3-869ef1607803', NULL, 'approve', 'string', NULL, NULL, NULL, NULL, NULL, NULL, '同意', NULL, '2023-02-23 06:20:58.438', '2023-02-23 06:55:22.450', NULL);
INSERT INTO `act_hi_varinst` (`ID_`, `REV_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `TASK_ID_`, `NAME_`, `VAR_TYPE_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `CREATE_TIME_`, `LAST_UPDATED_TIME_`, `META_INFO_`) VALUES ('3ef44d2b-b340-11ed-9d23-869ef1607803', 0, '3ef44d28-b340-11ed-9d23-869ef1607803', '3ef44d28-b340-11ed-9d23-869ef1607803', NULL, 'leavetime', 'serializable', NULL, NULL, NULL, '3ef44d2c-b340-11ed-9d23-869ef1607803', NULL, NULL, NULL, NULL, '2023-02-23 06:06:43.383', '2023-02-23 06:06:43.383', NULL);
INSERT INTO `act_hi_varinst` (`ID_`, `REV_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `TASK_ID_`, `NAME_`, `VAR_TYPE_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `CREATE_TIME_`, `LAST_UPDATED_TIME_`, `META_INFO_`) VALUES ('3ef44d2d-b340-11ed-9d23-869ef1607803', 0, '3ef44d28-b340-11ed-9d23-869ef1607803', '3ef44d28-b340-11ed-9d23-869ef1607803', NULL, 'leavetype', 'integer', NULL, NULL, NULL, NULL, NULL, 1, '1', NULL, '2023-02-23 06:06:43.383', '2023-02-23 06:06:43.383', NULL);
INSERT INTO `act_hi_varinst` (`ID_`, `REV_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `TASK_ID_`, `NAME_`, `VAR_TYPE_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `CREATE_TIME_`, `LAST_UPDATED_TIME_`, `META_INFO_`) VALUES ('3ef44d2e-b340-11ed-9d23-869ef1607803', 0, '3ef44d28-b340-11ed-9d23-869ef1607803', '3ef44d28-b340-11ed-9d23-869ef1607803', NULL, 'leavereason', 'string', NULL, NULL, NULL, NULL, NULL, NULL, '111', NULL, '2023-02-23 06:06:43.383', '2023-02-23 06:06:43.383', NULL);
INSERT INTO `act_hi_varinst` (`ID_`, `REV_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `TASK_ID_`, `NAME_`, `VAR_TYPE_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `CREATE_TIME_`, `LAST_UPDATED_TIME_`, `META_INFO_`) VALUES ('3ef44d30-b340-11ed-9d23-869ef1607803', 0, '3ef44d28-b340-11ed-9d23-869ef1607803', '3ef44d28-b340-11ed-9d23-869ef1607803', NULL, 'variables', 'serializable', NULL, NULL, NULL, '3ef44d31-b340-11ed-9d23-869ef1607803', NULL, NULL, NULL, NULL, '2023-02-23 06:06:43.383', '2023-02-23 06:06:43.383', NULL);
INSERT INTO `act_hi_varinst` (`ID_`, `REV_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `TASK_ID_`, `NAME_`, `VAR_TYPE_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `CREATE_TIME_`, `LAST_UPDATED_TIME_`, `META_INFO_`) VALUES ('3ef44d32-b340-11ed-9d23-869ef1607803', 0, '3ef44d28-b340-11ed-9d23-869ef1607803', '3ef44d28-b340-11ed-9d23-869ef1607803', NULL, 'INITIATOR', 'string', NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2023-02-23 06:06:43.383', '2023-02-23 06:06:43.383', NULL);
INSERT INTO `act_hi_varinst` (`ID_`, `REV_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `TASK_ID_`, `NAME_`, `VAR_TYPE_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `CREATE_TIME_`, `LAST_UPDATED_TIME_`, `META_INFO_`) VALUES ('4125bf0f-584e-11ee-9923-f22f4b0aefad', 0, '4125bf0e-584e-11ee-9923-f22f4b0aefad', '4125bf0e-584e-11ee-9923-f22f4b0aefad', NULL, 'INITIATOR', 'long', NULL, NULL, NULL, NULL, NULL, 1, '1', NULL, '2023-09-21 07:12:41.875', '2023-09-21 07:12:41.875', NULL);
INSERT INTO `act_hi_varinst` (`ID_`, `REV_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `TASK_ID_`, `NAME_`, `VAR_TYPE_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `CREATE_TIME_`, `LAST_UPDATED_TIME_`, `META_INFO_`) VALUES ('4125bf11-584e-11ee-9923-f22f4b0aefad', 0, '4125bf0e-584e-11ee-9923-f22f4b0aefad', '4125bf0e-584e-11ee-9923-f22f4b0aefad', NULL, 'name', 'string', NULL, NULL, NULL, NULL, NULL, NULL, '111', NULL, '2023-09-21 07:12:41.875', '2023-09-21 07:12:41.875', NULL);
INSERT INTO `act_hi_varinst` (`ID_`, `REV_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `TASK_ID_`, `NAME_`, `VAR_TYPE_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `CREATE_TIME_`, `LAST_UPDATED_TIME_`, `META_INFO_`) VALUES ('4125bf13-584e-11ee-9923-f22f4b0aefad', 0, '4125bf0e-584e-11ee-9923-f22f4b0aefad', '4125bf0e-584e-11ee-9923-f22f4b0aefad', NULL, 'variables', 'serializable', NULL, NULL, NULL, '4125bf14-584e-11ee-9923-f22f4b0aefad', NULL, NULL, NULL, NULL, '2023-09-21 07:12:41.875', '2023-09-21 07:12:41.875', NULL);
INSERT INTO `act_hi_varinst` (`ID_`, `REV_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `TASK_ID_`, `NAME_`, `VAR_TYPE_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `CREATE_TIME_`, `LAST_UPDATED_TIME_`, `META_INFO_`) VALUES ('65359e7b-584e-11ee-9923-f22f4b0aefad', 0, '65359e7a-584e-11ee-9923-f22f4b0aefad', '65359e7a-584e-11ee-9923-f22f4b0aefad', NULL, 'INITIATOR', 'long', NULL, NULL, NULL, NULL, NULL, 1, '1', NULL, '2023-09-21 07:13:42.377', '2023-09-21 07:13:42.377', NULL);
INSERT INTO `act_hi_varinst` (`ID_`, `REV_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `TASK_ID_`, `NAME_`, `VAR_TYPE_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `CREATE_TIME_`, `LAST_UPDATED_TIME_`, `META_INFO_`) VALUES ('65359e7d-584e-11ee-9923-f22f4b0aefad', 0, '65359e7a-584e-11ee-9923-f22f4b0aefad', '65359e7a-584e-11ee-9923-f22f4b0aefad', NULL, 'name', 'string', NULL, NULL, NULL, NULL, NULL, NULL, '222', NULL, '2023-09-21 07:13:42.377', '2023-09-21 07:13:42.377', NULL);
INSERT INTO `act_hi_varinst` (`ID_`, `REV_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `TASK_ID_`, `NAME_`, `VAR_TYPE_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `CREATE_TIME_`, `LAST_UPDATED_TIME_`, `META_INFO_`) VALUES ('65359e7f-584e-11ee-9923-f22f4b0aefad', 0, '65359e7a-584e-11ee-9923-f22f4b0aefad', '65359e7a-584e-11ee-9923-f22f4b0aefad', NULL, 'variables', 'serializable', NULL, NULL, NULL, '65359e80-584e-11ee-9923-f22f4b0aefad', NULL, NULL, NULL, NULL, '2023-09-21 07:13:42.377', '2023-09-21 07:13:42.377', NULL);
INSERT INTO `act_hi_varinst` (`ID_`, `REV_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `TASK_ID_`, `NAME_`, `VAR_TYPE_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `CREATE_TIME_`, `LAST_UPDATED_TIME_`, `META_INFO_`) VALUES ('a573fe87-b33e-11ed-b511-ce4fe10f37b8', 0, 'a573b064-b33e-11ed-b511-ce4fe10f37b8', 'a573b064-b33e-11ed-b511-ce4fe10f37b8', NULL, 'leavetime', 'serializable', NULL, NULL, NULL, 'a5742598-b33e-11ed-b511-ce4fe10f37b8', NULL, NULL, NULL, NULL, '2023-02-23 05:55:16.354', '2023-02-23 05:55:16.354', NULL);
INSERT INTO `act_hi_varinst` (`ID_`, `REV_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `TASK_ID_`, `NAME_`, `VAR_TYPE_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `CREATE_TIME_`, `LAST_UPDATED_TIME_`, `META_INFO_`) VALUES ('a5742599-b33e-11ed-b511-ce4fe10f37b8', 0, 'a573b064-b33e-11ed-b511-ce4fe10f37b8', 'a573b064-b33e-11ed-b511-ce4fe10f37b8', NULL, 'leavetype', 'integer', NULL, NULL, NULL, NULL, NULL, 1, '1', NULL, '2023-02-23 05:55:16.355', '2023-02-23 05:55:16.355', NULL);
INSERT INTO `act_hi_varinst` (`ID_`, `REV_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `TASK_ID_`, `NAME_`, `VAR_TYPE_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `CREATE_TIME_`, `LAST_UPDATED_TIME_`, `META_INFO_`) VALUES ('a574259a-b33e-11ed-b511-ce4fe10f37b8', 0, 'a573b064-b33e-11ed-b511-ce4fe10f37b8', 'a573b064-b33e-11ed-b511-ce4fe10f37b8', NULL, 'leavereason', 'string', NULL, NULL, NULL, NULL, NULL, NULL, '111', NULL, '2023-02-23 05:55:16.355', '2023-02-23 05:55:16.355', NULL);
INSERT INTO `act_hi_varinst` (`ID_`, `REV_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `TASK_ID_`, `NAME_`, `VAR_TYPE_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `CREATE_TIME_`, `LAST_UPDATED_TIME_`, `META_INFO_`) VALUES ('a574259c-b33e-11ed-b511-ce4fe10f37b8', 0, 'a573b064-b33e-11ed-b511-ce4fe10f37b8', 'a573b064-b33e-11ed-b511-ce4fe10f37b8', NULL, 'variables', 'serializable', NULL, NULL, NULL, 'a574259d-b33e-11ed-b511-ce4fe10f37b8', NULL, NULL, NULL, NULL, '2023-02-23 05:55:16.355', '2023-02-23 05:55:16.355', NULL);
INSERT INTO `act_hi_varinst` (`ID_`, `REV_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `TASK_ID_`, `NAME_`, `VAR_TYPE_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `CREATE_TIME_`, `LAST_UPDATED_TIME_`, `META_INFO_`) VALUES ('a574259e-b33e-11ed-b511-ce4fe10f37b8', 0, 'a573b064-b33e-11ed-b511-ce4fe10f37b8', 'a573b064-b33e-11ed-b511-ce4fe10f37b8', NULL, 'INITIATOR', 'string', NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2023-02-23 05:55:16.355', '2023-02-23 05:55:16.355', NULL);
INSERT INTO `act_hi_varinst` (`ID_`, `REV_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `TASK_ID_`, `NAME_`, `VAR_TYPE_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `CREATE_TIME_`, `LAST_UPDATED_TIME_`, `META_INFO_`) VALUES ('abd090a7-b33e-11ed-b511-ce4fe10f37b8', 0, 'a573b064-b33e-11ed-b511-ce4fe10f37b8', 'a573b064-b33e-11ed-b511-ce4fe10f37b8', NULL, 'approve', 'string', NULL, NULL, NULL, NULL, NULL, NULL, '拒绝', NULL, '2023-02-23 05:55:27.027', '2023-02-23 05:55:27.027', NULL);
INSERT INTO `act_hi_varinst` (`ID_`, `REV_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `TASK_ID_`, `NAME_`, `VAR_TYPE_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `CREATE_TIME_`, `LAST_UPDATED_TIME_`, `META_INFO_`) VALUES ('b7a5dd83-5851-11ee-9923-f22f4b0aefad', 0, 'b7a5dd82-5851-11ee-9923-f22f4b0aefad', 'b7a5dd82-5851-11ee-9923-f22f4b0aefad', NULL, 'INITIATOR', 'long', NULL, NULL, NULL, NULL, NULL, 1, '1', NULL, '2023-09-21 07:37:29.176', '2023-09-21 07:37:29.177', NULL);
INSERT INTO `act_hi_varinst` (`ID_`, `REV_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `TASK_ID_`, `NAME_`, `VAR_TYPE_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `CREATE_TIME_`, `LAST_UPDATED_TIME_`, `META_INFO_`) VALUES ('b7a60495-5851-11ee-9923-f22f4b0aefad', 0, 'b7a5dd82-5851-11ee-9923-f22f4b0aefad', 'b7a5dd82-5851-11ee-9923-f22f4b0aefad', NULL, 'name', 'string', NULL, NULL, NULL, NULL, NULL, NULL, '3333', NULL, '2023-09-21 07:37:29.177', '2023-09-21 07:37:29.177', NULL);
INSERT INTO `act_hi_varinst` (`ID_`, `REV_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `TASK_ID_`, `NAME_`, `VAR_TYPE_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `CREATE_TIME_`, `LAST_UPDATED_TIME_`, `META_INFO_`) VALUES ('b7a60497-5851-11ee-9923-f22f4b0aefad', 0, 'b7a5dd82-5851-11ee-9923-f22f4b0aefad', 'b7a5dd82-5851-11ee-9923-f22f4b0aefad', NULL, 'variables', 'serializable', NULL, NULL, NULL, 'b7a60498-5851-11ee-9923-f22f4b0aefad', NULL, NULL, NULL, NULL, '2023-09-21 07:37:29.177', '2023-09-21 07:37:29.177', NULL);
INSERT INTO `act_hi_varinst` (`ID_`, `REV_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `TASK_ID_`, `NAME_`, `VAR_TYPE_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `CREATE_TIME_`, `LAST_UPDATED_TIME_`, `META_INFO_`) VALUES ('b8069e09-b345-11ed-8617-ce4fe10f37b8', 0, 'b8058c96-b345-11ed-8617-ce4fe10f37b8', 'b8058c96-b345-11ed-8617-ce4fe10f37b8', NULL, 'leavetime', 'serializable', NULL, NULL, NULL, 'b806ec2a-b345-11ed-8617-ce4fe10f37b8', NULL, NULL, NULL, NULL, '2023-02-23 06:45:53.993', '2023-02-23 06:45:53.993', NULL);
INSERT INTO `act_hi_varinst` (`ID_`, `REV_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `TASK_ID_`, `NAME_`, `VAR_TYPE_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `CREATE_TIME_`, `LAST_UPDATED_TIME_`, `META_INFO_`) VALUES ('b806ec2b-b345-11ed-8617-ce4fe10f37b8', 0, 'b8058c96-b345-11ed-8617-ce4fe10f37b8', 'b8058c96-b345-11ed-8617-ce4fe10f37b8', NULL, 'leavetype', 'integer', NULL, NULL, NULL, NULL, NULL, 1, '1', NULL, '2023-02-23 06:45:53.993', '2023-02-23 06:45:53.993', NULL);
INSERT INTO `act_hi_varinst` (`ID_`, `REV_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `TASK_ID_`, `NAME_`, `VAR_TYPE_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `CREATE_TIME_`, `LAST_UPDATED_TIME_`, `META_INFO_`) VALUES ('b807133c-b345-11ed-8617-ce4fe10f37b8', 0, 'b8058c96-b345-11ed-8617-ce4fe10f37b8', 'b8058c96-b345-11ed-8617-ce4fe10f37b8', NULL, 'leavereason', 'string', NULL, NULL, NULL, NULL, NULL, NULL, '44', NULL, '2023-02-23 06:45:53.994', '2023-02-23 06:45:53.994', NULL);
INSERT INTO `act_hi_varinst` (`ID_`, `REV_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `TASK_ID_`, `NAME_`, `VAR_TYPE_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `CREATE_TIME_`, `LAST_UPDATED_TIME_`, `META_INFO_`) VALUES ('b807133e-b345-11ed-8617-ce4fe10f37b8', 0, 'b8058c96-b345-11ed-8617-ce4fe10f37b8', 'b8058c96-b345-11ed-8617-ce4fe10f37b8', NULL, 'variables', 'serializable', NULL, NULL, NULL, 'b807133f-b345-11ed-8617-ce4fe10f37b8', NULL, NULL, NULL, NULL, '2023-02-23 06:45:53.994', '2023-02-23 06:45:53.994', NULL);
INSERT INTO `act_hi_varinst` (`ID_`, `REV_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `TASK_ID_`, `NAME_`, `VAR_TYPE_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `CREATE_TIME_`, `LAST_UPDATED_TIME_`, `META_INFO_`) VALUES ('b8071340-b345-11ed-8617-ce4fe10f37b8', 0, 'b8058c96-b345-11ed-8617-ce4fe10f37b8', 'b8058c96-b345-11ed-8617-ce4fe10f37b8', NULL, 'INITIATOR', 'string', NULL, NULL, NULL, NULL, NULL, NULL, '1', NULL, '2023-02-23 06:45:53.994', '2023-02-23 06:45:53.994', NULL);
INSERT INTO `act_hi_varinst` (`ID_`, `REV_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `TASK_ID_`, `NAME_`, `VAR_TYPE_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `CREATE_TIME_`, `LAST_UPDATED_TIME_`, `META_INFO_`) VALUES ('bb8f1b94-246c-11ee-8f95-36d2b240f315', 0, 'bb8dbc01-246c-11ee-8f95-36d2b240f315', 'bb8dbc01-246c-11ee-8f95-36d2b240f315', NULL, 'leavetime', 'serializable', NULL, NULL, NULL, 'bb8f69b5-246c-11ee-8f95-36d2b240f315', NULL, NULL, NULL, NULL, '2023-07-17 06:39:51.686', '2023-07-17 06:39:51.686', NULL);
INSERT INTO `act_hi_varinst` (`ID_`, `REV_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `TASK_ID_`, `NAME_`, `VAR_TYPE_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `CREATE_TIME_`, `LAST_UPDATED_TIME_`, `META_INFO_`) VALUES ('bb8f69b6-246c-11ee-8f95-36d2b240f315', 0, 'bb8dbc01-246c-11ee-8f95-36d2b240f315', 'bb8dbc01-246c-11ee-8f95-36d2b240f315', NULL, 'leavetype', 'integer', NULL, NULL, NULL, NULL, NULL, 2, '2', NULL, '2023-07-17 06:39:51.687', '2023-07-17 06:39:51.687', NULL);
INSERT INTO `act_hi_varinst` (`ID_`, `REV_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `TASK_ID_`, `NAME_`, `VAR_TYPE_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `CREATE_TIME_`, `LAST_UPDATED_TIME_`, `META_INFO_`) VALUES ('bb8f69b7-246c-11ee-8f95-36d2b240f315', 0, 'bb8dbc01-246c-11ee-8f95-36d2b240f315', 'bb8dbc01-246c-11ee-8f95-36d2b240f315', NULL, 'leavereason', 'string', NULL, NULL, NULL, NULL, NULL, NULL, '1111', NULL, '2023-07-17 06:39:51.687', '2023-07-17 06:39:51.687', NULL);
INSERT INTO `act_hi_varinst` (`ID_`, `REV_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `TASK_ID_`, `NAME_`, `VAR_TYPE_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `CREATE_TIME_`, `LAST_UPDATED_TIME_`, `META_INFO_`) VALUES ('bb902d09-246c-11ee-8f95-36d2b240f315', 0, 'bb8dbc01-246c-11ee-8f95-36d2b240f315', 'bb8dbc01-246c-11ee-8f95-36d2b240f315', NULL, 'variables', 'serializable', NULL, NULL, NULL, 'bb902d0a-246c-11ee-8f95-36d2b240f315', NULL, NULL, NULL, NULL, '2023-07-17 06:39:51.692', '2023-07-17 06:39:51.692', NULL);
INSERT INTO `act_hi_varinst` (`ID_`, `REV_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `TASK_ID_`, `NAME_`, `VAR_TYPE_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `CREATE_TIME_`, `LAST_UPDATED_TIME_`, `META_INFO_`) VALUES ('bb902d0b-246c-11ee-8f95-36d2b240f315', 0, 'bb8dbc01-246c-11ee-8f95-36d2b240f315', 'bb8dbc01-246c-11ee-8f95-36d2b240f315', NULL, 'INITIATOR', 'string', NULL, NULL, NULL, NULL, NULL, NULL, '1', NULL, '2023-07-17 06:39:51.692', '2023-07-17 06:39:51.692', NULL);
INSERT INTO `act_hi_varinst` (`ID_`, `REV_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `TASK_ID_`, `NAME_`, `VAR_TYPE_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `CREATE_TIME_`, `LAST_UPDATED_TIME_`, `META_INFO_`) VALUES ('c4f14b4c-b340-11ed-88a8-869ef1607803', 0, '3ef44d28-b340-11ed-9d23-869ef1607803', '3ef44d28-b340-11ed-9d23-869ef1607803', NULL, 'approve', 'string', NULL, NULL, NULL, NULL, NULL, NULL, '拒绝', NULL, '2023-02-23 06:10:28.181', '2023-02-23 06:10:28.181', NULL);
INSERT INTO `act_hi_varinst` (`ID_`, `REV_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `TASK_ID_`, `NAME_`, `VAR_TYPE_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `CREATE_TIME_`, `LAST_UPDATED_TIME_`, `META_INFO_`) VALUES ('d1d8fac4-246c-11ee-8f95-36d2b240f315', 3, 'bb8dbc01-246c-11ee-8f95-36d2b240f315', 'bb8dbc01-246c-11ee-8f95-36d2b240f315', NULL, 'approve', 'string', NULL, NULL, NULL, NULL, NULL, NULL, '同意', NULL, '2023-07-17 06:40:29.079', '2023-07-17 06:41:50.287', NULL);
INSERT INTO `act_hi_varinst` (`ID_`, `REV_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `TASK_ID_`, `NAME_`, `VAR_TYPE_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `CREATE_TIME_`, `LAST_UPDATED_TIME_`, `META_INFO_`) VALUES ('d48dfd20-b33f-11ed-9d23-869ef1607803', 0, 'd48d87ed-b33f-11ed-9d23-869ef1607803', 'd48d87ed-b33f-11ed-9d23-869ef1607803', NULL, 'leavetime', 'serializable', NULL, NULL, NULL, 'd48e4b41-b33f-11ed-9d23-869ef1607803', NULL, NULL, NULL, NULL, '2023-02-23 06:03:44.876', '2023-02-23 06:03:44.876', NULL);
INSERT INTO `act_hi_varinst` (`ID_`, `REV_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `TASK_ID_`, `NAME_`, `VAR_TYPE_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `CREATE_TIME_`, `LAST_UPDATED_TIME_`, `META_INFO_`) VALUES ('d48e4b42-b33f-11ed-9d23-869ef1607803', 0, 'd48d87ed-b33f-11ed-9d23-869ef1607803', 'd48d87ed-b33f-11ed-9d23-869ef1607803', NULL, 'leavetype', 'integer', NULL, NULL, NULL, NULL, NULL, 1, '1', NULL, '2023-02-23 06:03:44.876', '2023-02-23 06:03:44.876', NULL);
INSERT INTO `act_hi_varinst` (`ID_`, `REV_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `TASK_ID_`, `NAME_`, `VAR_TYPE_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `CREATE_TIME_`, `LAST_UPDATED_TIME_`, `META_INFO_`) VALUES ('d48e4b43-b33f-11ed-9d23-869ef1607803', 0, 'd48d87ed-b33f-11ed-9d23-869ef1607803', 'd48d87ed-b33f-11ed-9d23-869ef1607803', NULL, 'leavereason', 'string', NULL, NULL, NULL, NULL, NULL, NULL, '11', NULL, '2023-02-23 06:03:44.876', '2023-02-23 06:03:44.876', NULL);
INSERT INTO `act_hi_varinst` (`ID_`, `REV_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `TASK_ID_`, `NAME_`, `VAR_TYPE_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `CREATE_TIME_`, `LAST_UPDATED_TIME_`, `META_INFO_`) VALUES ('d48e4b45-b33f-11ed-9d23-869ef1607803', 0, 'd48d87ed-b33f-11ed-9d23-869ef1607803', 'd48d87ed-b33f-11ed-9d23-869ef1607803', NULL, 'variables', 'serializable', NULL, NULL, NULL, 'd48e4b46-b33f-11ed-9d23-869ef1607803', NULL, NULL, NULL, NULL, '2023-02-23 06:03:44.876', '2023-02-23 06:03:44.876', NULL);
INSERT INTO `act_hi_varinst` (`ID_`, `REV_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `TASK_ID_`, `NAME_`, `VAR_TYPE_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `CREATE_TIME_`, `LAST_UPDATED_TIME_`, `META_INFO_`) VALUES ('d48e4b47-b33f-11ed-9d23-869ef1607803', 0, 'd48d87ed-b33f-11ed-9d23-869ef1607803', 'd48d87ed-b33f-11ed-9d23-869ef1607803', NULL, 'INITIATOR', 'string', NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2023-02-23 06:03:44.876', '2023-02-23 06:03:44.876', NULL);
INSERT INTO `act_hi_varinst` (`ID_`, `REV_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `TASK_ID_`, `NAME_`, `VAR_TYPE_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `CREATE_TIME_`, `LAST_UPDATED_TIME_`, `META_INFO_`) VALUES ('da996205-b33f-11ed-9d23-869ef1607803', 0, 'd48d87ed-b33f-11ed-9d23-869ef1607803', 'd48d87ed-b33f-11ed-9d23-869ef1607803', NULL, 'approve', 'string', NULL, NULL, NULL, NULL, NULL, NULL, '拒绝', NULL, '2023-02-23 06:03:55.016', '2023-02-23 06:03:55.016', NULL);
INSERT INTO `act_hi_varinst` (`ID_`, `REV_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `TASK_ID_`, `NAME_`, `VAR_TYPE_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `CREATE_TIME_`, `LAST_UPDATED_TIME_`, `META_INFO_`) VALUES ('ede26907-5850-11ee-9923-f22f4b0aefad', 0, 'ede26906-5850-11ee-9923-f22f4b0aefad', 'ede26906-5850-11ee-9923-f22f4b0aefad', NULL, 'INITIATOR', 'long', NULL, NULL, NULL, NULL, NULL, 1, '1', NULL, '2023-09-21 07:31:50.673', '2023-09-21 07:31:50.675', NULL);
INSERT INTO `act_hi_varinst` (`ID_`, `REV_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `TASK_ID_`, `NAME_`, `VAR_TYPE_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `CREATE_TIME_`, `LAST_UPDATED_TIME_`, `META_INFO_`) VALUES ('ede26909-5850-11ee-9923-f22f4b0aefad', 0, 'ede26906-5850-11ee-9923-f22f4b0aefad', 'ede26906-5850-11ee-9923-f22f4b0aefad', NULL, 'name', 'string', NULL, NULL, NULL, NULL, NULL, NULL, '3333', NULL, '2023-09-21 07:31:50.673', '2023-09-21 07:31:50.673', NULL);
INSERT INTO `act_hi_varinst` (`ID_`, `REV_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `TASK_ID_`, `NAME_`, `VAR_TYPE_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `CREATE_TIME_`, `LAST_UPDATED_TIME_`, `META_INFO_`) VALUES ('ede2b72b-5850-11ee-9923-f22f4b0aefad', 0, 'ede26906-5850-11ee-9923-f22f4b0aefad', 'ede26906-5850-11ee-9923-f22f4b0aefad', NULL, 'variables', 'serializable', NULL, NULL, NULL, 'ede2b72c-5850-11ee-9923-f22f4b0aefad', NULL, NULL, NULL, NULL, '2023-09-21 07:31:50.675', '2023-09-21 07:31:50.675', NULL);
INSERT INTO `act_hi_varinst` (`ID_`, `REV_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `TASK_ID_`, `NAME_`, `VAR_TYPE_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `CREATE_TIME_`, `LAST_UPDATED_TIME_`, `META_INFO_`) VALUES ('ff6d8ec3-584d-11ee-9923-f22f4b0aefad', 0, 'ff6d67b2-584d-11ee-9923-f22f4b0aefad', 'ff6d67b2-584d-11ee-9923-f22f4b0aefad', NULL, 'INITIATOR', 'long', NULL, NULL, NULL, NULL, NULL, 1, '1', NULL, '2023-09-21 07:10:51.616', '2023-09-21 07:10:51.621', NULL);
INSERT INTO `act_hi_varinst` (`ID_`, `REV_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `TASK_ID_`, `NAME_`, `VAR_TYPE_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `CREATE_TIME_`, `LAST_UPDATED_TIME_`, `META_INFO_`) VALUES ('ff6db5d5-584d-11ee-9923-f22f4b0aefad', 0, 'ff6d67b2-584d-11ee-9923-f22f4b0aefad', 'ff6d67b2-584d-11ee-9923-f22f4b0aefad', NULL, 'name', 'string', NULL, NULL, NULL, NULL, NULL, NULL, '111', NULL, '2023-09-21 07:10:51.617', '2023-09-21 07:10:51.617', NULL);
INSERT INTO `act_hi_varinst` (`ID_`, `REV_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `TASK_ID_`, `NAME_`, `VAR_TYPE_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `CREATE_TIME_`, `LAST_UPDATED_TIME_`, `META_INFO_`) VALUES ('ff6e5217-584d-11ee-9923-f22f4b0aefad', 0, 'ff6d67b2-584d-11ee-9923-f22f4b0aefad', 'ff6d67b2-584d-11ee-9923-f22f4b0aefad', NULL, 'variables', 'serializable', NULL, NULL, NULL, 'ff6e5218-584d-11ee-9923-f22f4b0aefad', NULL, NULL, NULL, NULL, '2023-09-21 07:10:51.621', '2023-09-21 07:10:51.621', NULL);
COMMIT;

-- ----------------------------
-- Table structure for act_id_bytearray
-- ----------------------------
DROP TABLE IF EXISTS `act_id_bytearray`;
CREATE TABLE `act_id_bytearray` (
                                    `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                    `REV_` int DEFAULT NULL,
                                    `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                    `BYTES_` longblob,
                                    PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_id_bytearray
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for act_id_group
-- ----------------------------
DROP TABLE IF EXISTS `act_id_group`;
CREATE TABLE `act_id_group` (
                                `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                `REV_` int DEFAULT NULL,
                                `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                `TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_id_group
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for act_id_info
-- ----------------------------
DROP TABLE IF EXISTS `act_id_info`;
CREATE TABLE `act_id_info` (
                               `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                               `REV_` int DEFAULT NULL,
                               `USER_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                               `TYPE_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                               `KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                               `VALUE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                               `PASSWORD_` longblob,
                               `PARENT_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                               PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_id_info
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for act_id_membership
-- ----------------------------
DROP TABLE IF EXISTS `act_id_membership`;
CREATE TABLE `act_id_membership` (
                                     `USER_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                     `GROUP_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                     PRIMARY KEY (`USER_ID_`,`GROUP_ID_`),
                                     KEY `ACT_FK_MEMB_GROUP` (`GROUP_ID_`),
                                     CONSTRAINT `ACT_FK_MEMB_GROUP` FOREIGN KEY (`GROUP_ID_`) REFERENCES `act_id_group` (`ID_`),
                                     CONSTRAINT `ACT_FK_MEMB_USER` FOREIGN KEY (`USER_ID_`) REFERENCES `act_id_user` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_id_membership
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for act_id_priv
-- ----------------------------
DROP TABLE IF EXISTS `act_id_priv`;
CREATE TABLE `act_id_priv` (
                               `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                               `NAME_` varchar(255) COLLATE utf8_bin NOT NULL,
                               PRIMARY KEY (`ID_`),
                               UNIQUE KEY `ACT_UNIQ_PRIV_NAME` (`NAME_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_id_priv
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for act_id_priv_mapping
-- ----------------------------
DROP TABLE IF EXISTS `act_id_priv_mapping`;
CREATE TABLE `act_id_priv_mapping` (
                                       `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                       `PRIV_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                       `USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                       `GROUP_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                       PRIMARY KEY (`ID_`),
                                       KEY `ACT_FK_PRIV_MAPPING` (`PRIV_ID_`),
                                       KEY `ACT_IDX_PRIV_USER` (`USER_ID_`),
                                       KEY `ACT_IDX_PRIV_GROUP` (`GROUP_ID_`),
                                       CONSTRAINT `ACT_FK_PRIV_MAPPING` FOREIGN KEY (`PRIV_ID_`) REFERENCES `act_id_priv` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_id_priv_mapping
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for act_id_property
-- ----------------------------
DROP TABLE IF EXISTS `act_id_property`;
CREATE TABLE `act_id_property` (
                                   `NAME_` varchar(64) COLLATE utf8_bin NOT NULL,
                                   `VALUE_` varchar(300) COLLATE utf8_bin DEFAULT NULL,
                                   `REV_` int DEFAULT NULL,
                                   PRIMARY KEY (`NAME_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_id_property
-- ----------------------------
BEGIN;
INSERT INTO `act_id_property` (`NAME_`, `VALUE_`, `REV_`) VALUES ('schema.version', '6.8.1.0', 1);
COMMIT;

-- ----------------------------
-- Table structure for act_id_token
-- ----------------------------
DROP TABLE IF EXISTS `act_id_token`;
CREATE TABLE `act_id_token` (
                                `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                `REV_` int DEFAULT NULL,
                                `TOKEN_VALUE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                `TOKEN_DATE_` timestamp(3) NULL DEFAULT NULL,
                                `IP_ADDRESS_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                `USER_AGENT_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                `USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                `TOKEN_DATA_` varchar(2000) COLLATE utf8_bin DEFAULT NULL,
                                PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_id_token
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for act_id_user
-- ----------------------------
DROP TABLE IF EXISTS `act_id_user`;
CREATE TABLE `act_id_user` (
                               `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                               `REV_` int DEFAULT NULL,
                               `FIRST_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                               `LAST_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                               `DISPLAY_NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                               `EMAIL_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                               `PWD_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                               `PICTURE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                               `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
                               PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_id_user
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for act_procdef_info
-- ----------------------------
DROP TABLE IF EXISTS `act_procdef_info`;
CREATE TABLE `act_procdef_info` (
                                    `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                    `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                    `REV_` int DEFAULT NULL,
                                    `INFO_JSON_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                    PRIMARY KEY (`ID_`),
                                    UNIQUE KEY `ACT_UNIQ_INFO_PROCDEF` (`PROC_DEF_ID_`),
                                    KEY `ACT_IDX_INFO_PROCDEF` (`PROC_DEF_ID_`),
                                    KEY `ACT_FK_INFO_JSON_BA` (`INFO_JSON_ID_`),
                                    CONSTRAINT `ACT_FK_INFO_JSON_BA` FOREIGN KEY (`INFO_JSON_ID_`) REFERENCES `act_ge_bytearray` (`ID_`),
                                    CONSTRAINT `ACT_FK_INFO_PROCDEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `act_re_procdef` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_procdef_info
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for act_re_deployment
-- ----------------------------
DROP TABLE IF EXISTS `act_re_deployment`;
CREATE TABLE `act_re_deployment` (
                                     `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                     `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                     `CATEGORY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                     `KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                     `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
                                     `DEPLOY_TIME_` timestamp(3) NULL DEFAULT NULL,
                                     `DERIVED_FROM_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                     `DERIVED_FROM_ROOT_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                     `PARENT_DEPLOYMENT_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                     `ENGINE_VERSION_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                     PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_re_deployment
-- ----------------------------
BEGIN;
INSERT INTO `act_re_deployment` (`ID_`, `NAME_`, `CATEGORY_`, `KEY_`, `TENANT_ID_`, `DEPLOY_TIME_`, `DERIVED_FROM_`, `DERIVED_FROM_ROOT_`, `PARENT_DEPLOYMENT_ID_`, `ENGINE_VERSION_`) VALUES ('1e4bc78e-584e-11ee-9923-f22f4b0aefad', 'test_vue3', '2', NULL, '', '2023-09-21 07:11:43.404', NULL, NULL, '1e4bc78e-584e-11ee-9923-f22f4b0aefad', NULL);
INSERT INTO `act_re_deployment` (`ID_`, `NAME_`, `CATEGORY_`, `KEY_`, `TENANT_ID_`, `DEPLOY_TIME_`, `DERIVED_FROM_`, `DERIVED_FROM_ROOT_`, `PARENT_DEPLOYMENT_ID_`, `ENGINE_VERSION_`) VALUES ('2a913e7e-56c2-11ee-ae41-f22f4b0aefad', 'test_vue3', '2', NULL, '', '2023-09-19 07:57:23.287', NULL, NULL, '2a913e7e-56c2-11ee-ae41-f22f4b0aefad', NULL);
INSERT INTO `act_re_deployment` (`ID_`, `NAME_`, `CATEGORY_`, `KEY_`, `TENANT_ID_`, `DEPLOY_TIME_`, `DERIVED_FROM_`, `DERIVED_FROM_ROOT_`, `PARENT_DEPLOYMENT_ID_`, `ENGINE_VERSION_`) VALUES ('987c4ac0-b33e-11ed-b511-ce4fe10f37b8', 'test', '1', NULL, '', '2023-02-23 05:54:54.597', NULL, NULL, '987c4ac0-b33e-11ed-b511-ce4fe10f37b8', NULL);
COMMIT;

-- ----------------------------
-- Table structure for act_re_model
-- ----------------------------
DROP TABLE IF EXISTS `act_re_model`;
CREATE TABLE `act_re_model` (
                                `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                `REV_` int DEFAULT NULL,
                                `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                `KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                `CATEGORY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                `CREATE_TIME_` timestamp(3) NULL DEFAULT NULL,
                                `LAST_UPDATE_TIME_` timestamp(3) NULL DEFAULT NULL,
                                `VERSION_` int DEFAULT NULL,
                                `META_INFO_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
                                `DEPLOYMENT_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                `EDITOR_SOURCE_VALUE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                `EDITOR_SOURCE_EXTRA_VALUE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
                                PRIMARY KEY (`ID_`),
                                KEY `ACT_FK_MODEL_SOURCE` (`EDITOR_SOURCE_VALUE_ID_`),
                                KEY `ACT_FK_MODEL_SOURCE_EXTRA` (`EDITOR_SOURCE_EXTRA_VALUE_ID_`),
                                KEY `ACT_FK_MODEL_DEPLOYMENT` (`DEPLOYMENT_ID_`),
                                CONSTRAINT `ACT_FK_MODEL_DEPLOYMENT` FOREIGN KEY (`DEPLOYMENT_ID_`) REFERENCES `act_re_deployment` (`ID_`),
                                CONSTRAINT `ACT_FK_MODEL_SOURCE` FOREIGN KEY (`EDITOR_SOURCE_VALUE_ID_`) REFERENCES `act_ge_bytearray` (`ID_`),
                                CONSTRAINT `ACT_FK_MODEL_SOURCE_EXTRA` FOREIGN KEY (`EDITOR_SOURCE_EXTRA_VALUE_ID_`) REFERENCES `act_ge_bytearray` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_re_model
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for act_re_procdef
-- ----------------------------
DROP TABLE IF EXISTS `act_re_procdef`;
CREATE TABLE `act_re_procdef` (
                                  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                  `REV_` int DEFAULT NULL,
                                  `CATEGORY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                  `KEY_` varchar(255) COLLATE utf8_bin NOT NULL,
                                  `VERSION_` int NOT NULL,
                                  `DEPLOYMENT_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                  `RESOURCE_NAME_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
                                  `DGRM_RESOURCE_NAME_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
                                  `DESCRIPTION_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
                                  `HAS_START_FORM_KEY_` tinyint DEFAULT NULL,
                                  `HAS_GRAPHICAL_NOTATION_` tinyint DEFAULT NULL,
                                  `SUSPENSION_STATE_` int DEFAULT NULL,
                                  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
                                  `ENGINE_VERSION_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                  `DERIVED_FROM_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                  `DERIVED_FROM_ROOT_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                  `DERIVED_VERSION_` int NOT NULL DEFAULT '0',
                                  PRIMARY KEY (`ID_`),
                                  UNIQUE KEY `ACT_UNIQ_PROCDEF` (`KEY_`,`VERSION_`,`DERIVED_VERSION_`,`TENANT_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_re_procdef
-- ----------------------------
BEGIN;
INSERT INTO `act_re_procdef` (`ID_`, `REV_`, `CATEGORY_`, `NAME_`, `KEY_`, `VERSION_`, `DEPLOYMENT_ID_`, `RESOURCE_NAME_`, `DGRM_RESOURCE_NAME_`, `DESCRIPTION_`, `HAS_START_FORM_KEY_`, `HAS_GRAPHICAL_NOTATION_`, `SUSPENSION_STATE_`, `TENANT_ID_`, `ENGINE_VERSION_`, `DERIVED_FROM_`, `DERIVED_FROM_ROOT_`, `DERIVED_VERSION_`) VALUES ('testoa:16:98955103-b33e-11ed-b511-ce4fe10f37b8', 2, '1', 'test', 'testoa', 16, '987c4ac0-b33e-11ed-b511-ce4fe10f37b8', 'test.bpmn', 'test.testoa.png', NULL, 0, 1, 1, '', NULL, NULL, NULL, 0);
INSERT INTO `act_re_procdef` (`ID_`, `REV_`, `CATEGORY_`, `NAME_`, `KEY_`, `VERSION_`, `DEPLOYMENT_ID_`, `RESOURCE_NAME_`, `DGRM_RESOURCE_NAME_`, `DESCRIPTION_`, `HAS_START_FORM_KEY_`, `HAS_GRAPHICAL_NOTATION_`, `SUSPENSION_STATE_`, `TENANT_ID_`, `ENGINE_VERSION_`, `DERIVED_FROM_`, `DERIVED_FROM_ROOT_`, `DERIVED_VERSION_`) VALUES ('testvue3:1:2aea33f1-56c2-11ee-ae41-f22f4b0aefad', 2, '2', 'test_vue3', 'testvue3', 1, '2a913e7e-56c2-11ee-ae41-f22f4b0aefad', 'test_vue3.bpmn', 'test_vue3.testvue3.png', NULL, 0, 1, 1, '', NULL, NULL, NULL, 0);
INSERT INTO `act_re_procdef` (`ID_`, `REV_`, `CATEGORY_`, `NAME_`, `KEY_`, `VERSION_`, `DEPLOYMENT_ID_`, `RESOURCE_NAME_`, `DGRM_RESOURCE_NAME_`, `DESCRIPTION_`, `HAS_START_FORM_KEY_`, `HAS_GRAPHICAL_NOTATION_`, `SUSPENSION_STATE_`, `TENANT_ID_`, `ENGINE_VERSION_`, `DERIVED_FROM_`, `DERIVED_FROM_ROOT_`, `DERIVED_VERSION_`) VALUES ('testvue3:2:1e8d1651-584e-11ee-9923-f22f4b0aefad', 2, '2', 'test_vue3', 'testvue3', 2, '1e4bc78e-584e-11ee-9923-f22f4b0aefad', 'test_vue3.bpmn', 'test_vue3.testvue3.png', NULL, 0, 1, 1, '', NULL, NULL, NULL, 0);
COMMIT;

-- ----------------------------
-- Table structure for act_ru_actinst
-- ----------------------------
DROP TABLE IF EXISTS `act_ru_actinst`;
CREATE TABLE `act_ru_actinst` (
                                  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                  `REV_` int DEFAULT '1',
                                  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                  `ACT_ID_` varchar(255) COLLATE utf8_bin NOT NULL,
                                  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                  `CALL_PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                  `ACT_NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                  `ACT_TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
                                  `ASSIGNEE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                  `START_TIME_` datetime(3) NOT NULL,
                                  `END_TIME_` datetime(3) DEFAULT NULL,
                                  `DURATION_` bigint DEFAULT NULL,
                                  `TRANSACTION_ORDER_` int DEFAULT NULL,
                                  `DELETE_REASON_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
                                  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
                                  PRIMARY KEY (`ID_`),
                                  KEY `ACT_IDX_RU_ACTI_START` (`START_TIME_`),
                                  KEY `ACT_IDX_RU_ACTI_END` (`END_TIME_`),
                                  KEY `ACT_IDX_RU_ACTI_PROC` (`PROC_INST_ID_`),
                                  KEY `ACT_IDX_RU_ACTI_PROC_ACT` (`PROC_INST_ID_`,`ACT_ID_`),
                                  KEY `ACT_IDX_RU_ACTI_EXEC` (`EXECUTION_ID_`),
                                  KEY `ACT_IDX_RU_ACTI_EXEC_ACT` (`EXECUTION_ID_`,`ACT_ID_`),
                                  KEY `ACT_IDX_RU_ACTI_TASK` (`TASK_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_ru_actinst
-- ----------------------------
BEGIN;
INSERT INTO `act_ru_actinst` (`ID_`, `REV_`, `PROC_DEF_ID_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `ACT_ID_`, `TASK_ID_`, `CALL_PROC_INST_ID_`, `ACT_NAME_`, `ACT_TYPE_`, `ASSIGNEE_`, `START_TIME_`, `END_TIME_`, `DURATION_`, `TRANSACTION_ORDER_`, `DELETE_REASON_`, `TENANT_ID_`) VALUES ('1188c1cb-b33f-11ed-b511-ce4fe10f37b8', 1, 'testoa:16:98955103-b33e-11ed-b511-ce4fe10f37b8', '11884c8f-b33f-11ed-b511-ce4fe10f37b8', '1188c1ca-b33f-11ed-b511-ce4fe10f37b8', 'startNode1', NULL, NULL, '开始', 'startEvent', NULL, '2023-02-23 05:58:17.684', '2023-02-23 05:58:17.684', 0, 1, NULL, '');
INSERT INTO `act_ru_actinst` (`ID_`, `REV_`, `PROC_DEF_ID_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `ACT_ID_`, `TASK_ID_`, `CALL_PROC_INST_ID_`, `ACT_NAME_`, `ACT_TYPE_`, `ASSIGNEE_`, `START_TIME_`, `END_TIME_`, `DURATION_`, `TRANSACTION_ORDER_`, `DELETE_REASON_`, `TENANT_ID_`) VALUES ('1188c1cc-b33f-11ed-b511-ce4fe10f37b8', 1, 'testoa:16:98955103-b33e-11ed-b511-ce4fe10f37b8', '11884c8f-b33f-11ed-b511-ce4fe10f37b8', '1188c1ca-b33f-11ed-b511-ce4fe10f37b8', 'Flow_19ligpu', NULL, NULL, NULL, 'sequenceFlow', NULL, '2023-02-23 05:58:17.684', '2023-02-23 05:58:17.684', 0, 2, NULL, '');
INSERT INTO `act_ru_actinst` (`ID_`, `REV_`, `PROC_DEF_ID_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `ACT_ID_`, `TASK_ID_`, `CALL_PROC_INST_ID_`, `ACT_NAME_`, `ACT_TYPE_`, `ASSIGNEE_`, `START_TIME_`, `END_TIME_`, `DURATION_`, `TRANSACTION_ORDER_`, `DELETE_REASON_`, `TENANT_ID_`) VALUES ('1188c1cd-b33f-11ed-b511-ce4fe10f37b8', 3, 'testoa:16:98955103-b33e-11ed-b511-ce4fe10f37b8', '11884c8f-b33f-11ed-b511-ce4fe10f37b8', '1188c1ca-b33f-11ed-b511-ce4fe10f37b8', 'Activity_1qo8esf', '1188c1ce-b33f-11ed-b511-ce4fe10f37b8', NULL, '经理审批', 'userTask', '1', '2023-02-23 05:58:17.684', '2023-02-23 06:05:53.104', 455420, 3, NULL, '');
INSERT INTO `act_ru_actinst` (`ID_`, `REV_`, `PROC_DEF_ID_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `ACT_ID_`, `TASK_ID_`, `CALL_PROC_INST_ID_`, `ACT_NAME_`, `ACT_TYPE_`, `ASSIGNEE_`, `START_TIME_`, `END_TIME_`, `DURATION_`, `TRANSACTION_ORDER_`, `DELETE_REASON_`, `TENANT_ID_`) VALUES ('20fca3d3-b340-11ed-9d23-869ef1607803', 1, 'testoa:16:98955103-b33e-11ed-b511-ce4fe10f37b8', '11884c8f-b33f-11ed-b511-ce4fe10f37b8', '1188c1ca-b33f-11ed-b511-ce4fe10f37b8', 'Flow_14pge79', NULL, NULL, NULL, 'sequenceFlow', NULL, '2023-02-23 06:05:53.106', '2023-02-23 06:05:53.106', 0, 1, NULL, '');
INSERT INTO `act_ru_actinst` (`ID_`, `REV_`, `PROC_DEF_ID_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `ACT_ID_`, `TASK_ID_`, `CALL_PROC_INST_ID_`, `ACT_NAME_`, `ACT_TYPE_`, `ASSIGNEE_`, `START_TIME_`, `END_TIME_`, `DURATION_`, `TRANSACTION_ORDER_`, `DELETE_REASON_`, `TENANT_ID_`) VALUES ('20fccae4-b340-11ed-9d23-869ef1607803', 1, 'testoa:16:98955103-b33e-11ed-b511-ce4fe10f37b8', '11884c8f-b33f-11ed-b511-ce4fe10f37b8', '1188c1ca-b33f-11ed-b511-ce4fe10f37b8', 'Gateway_1nuou39', NULL, NULL, NULL, 'exclusiveGateway', NULL, '2023-02-23 06:05:53.107', '2023-02-23 06:05:53.108', 1, 2, NULL, '');
INSERT INTO `act_ru_actinst` (`ID_`, `REV_`, `PROC_DEF_ID_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `ACT_ID_`, `TASK_ID_`, `CALL_PROC_INST_ID_`, `ACT_NAME_`, `ACT_TYPE_`, `ASSIGNEE_`, `START_TIME_`, `END_TIME_`, `DURATION_`, `TRANSACTION_ORDER_`, `DELETE_REASON_`, `TENANT_ID_`) VALUES ('20fcf1f5-b340-11ed-9d23-869ef1607803', 1, 'testoa:16:98955103-b33e-11ed-b511-ce4fe10f37b8', '11884c8f-b33f-11ed-b511-ce4fe10f37b8', '1188c1ca-b33f-11ed-b511-ce4fe10f37b8', 'Flow_04w3hjd', NULL, NULL, '同意', 'sequenceFlow', NULL, '2023-02-23 06:05:53.108', '2023-02-23 06:05:53.108', 0, 3, NULL, '');
INSERT INTO `act_ru_actinst` (`ID_`, `REV_`, `PROC_DEF_ID_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `ACT_ID_`, `TASK_ID_`, `CALL_PROC_INST_ID_`, `ACT_NAME_`, `ACT_TYPE_`, `ASSIGNEE_`, `START_TIME_`, `END_TIME_`, `DURATION_`, `TRANSACTION_ORDER_`, `DELETE_REASON_`, `TENANT_ID_`) VALUES ('20fd4016-b340-11ed-9d23-869ef1607803', 1, 'testoa:16:98955103-b33e-11ed-b511-ce4fe10f37b8', '11884c8f-b33f-11ed-b511-ce4fe10f37b8', '1188c1ca-b33f-11ed-b511-ce4fe10f37b8', 'Activity_0exhfyz', '20fd4017-b340-11ed-9d23-869ef1607803', NULL, '验收', 'userTask', NULL, '2023-02-23 06:05:53.110', NULL, NULL, 4, NULL, '');
INSERT INTO `act_ru_actinst` (`ID_`, `REV_`, `PROC_DEF_ID_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `ACT_ID_`, `TASK_ID_`, `CALL_PROC_INST_ID_`, `ACT_NAME_`, `ACT_TYPE_`, `ASSIGNEE_`, `START_TIME_`, `END_TIME_`, `DURATION_`, `TRANSACTION_ORDER_`, `DELETE_REASON_`, `TENANT_ID_`) VALUES ('23cbdc5a-584e-11ee-9923-f22f4b0aefad', 1, 'testvue3:1:2aea33f1-56c2-11ee-ae41-f22f4b0aefad', '23cbb542-584e-11ee-9923-f22f4b0aefad', '23cbdc59-584e-11ee-9923-f22f4b0aefad', 'startNode1', NULL, NULL, '开始', 'startEvent', NULL, '2023-09-21 07:11:52.632', '2023-09-21 07:11:52.632', 0, 1, NULL, '');
INSERT INTO `act_ru_actinst` (`ID_`, `REV_`, `PROC_DEF_ID_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `ACT_ID_`, `TASK_ID_`, `CALL_PROC_INST_ID_`, `ACT_NAME_`, `ACT_TYPE_`, `ASSIGNEE_`, `START_TIME_`, `END_TIME_`, `DURATION_`, `TRANSACTION_ORDER_`, `DELETE_REASON_`, `TENANT_ID_`) VALUES ('23cbdc5b-584e-11ee-9923-f22f4b0aefad', 1, 'testvue3:1:2aea33f1-56c2-11ee-ae41-f22f4b0aefad', '23cbb542-584e-11ee-9923-f22f4b0aefad', '23cbdc59-584e-11ee-9923-f22f4b0aefad', 'Flow_0k6k615', NULL, NULL, NULL, 'sequenceFlow', NULL, '2023-09-21 07:11:52.632', '2023-09-21 07:11:52.632', 0, 2, NULL, '');
INSERT INTO `act_ru_actinst` (`ID_`, `REV_`, `PROC_DEF_ID_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `ACT_ID_`, `TASK_ID_`, `CALL_PROC_INST_ID_`, `ACT_NAME_`, `ACT_TYPE_`, `ASSIGNEE_`, `START_TIME_`, `END_TIME_`, `DURATION_`, `TRANSACTION_ORDER_`, `DELETE_REASON_`, `TENANT_ID_`) VALUES ('28c75a39-5852-11ee-9923-f22f4b0aefad', 1, 'testvue3:2:1e8d1651-584e-11ee-9923-f22f4b0aefad', '28c75a2e-5852-11ee-9923-f22f4b0aefad', '28c75a38-5852-11ee-9923-f22f4b0aefad', 'startNode1', NULL, NULL, '开始', 'startEvent', NULL, '2023-09-21 07:40:38.978', '2023-09-21 07:40:38.978', 0, 1, NULL, '');
INSERT INTO `act_ru_actinst` (`ID_`, `REV_`, `PROC_DEF_ID_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `ACT_ID_`, `TASK_ID_`, `CALL_PROC_INST_ID_`, `ACT_NAME_`, `ACT_TYPE_`, `ASSIGNEE_`, `START_TIME_`, `END_TIME_`, `DURATION_`, `TRANSACTION_ORDER_`, `DELETE_REASON_`, `TENANT_ID_`) VALUES ('28c75a3a-5852-11ee-9923-f22f4b0aefad', 1, 'testvue3:2:1e8d1651-584e-11ee-9923-f22f4b0aefad', '28c75a2e-5852-11ee-9923-f22f4b0aefad', '28c75a38-5852-11ee-9923-f22f4b0aefad', 'Flow_0k6k615', NULL, NULL, NULL, 'sequenceFlow', NULL, '2023-09-21 07:40:38.978', '2023-09-21 07:40:38.978', 0, 2, NULL, '');
INSERT INTO `act_ru_actinst` (`ID_`, `REV_`, `PROC_DEF_ID_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `ACT_ID_`, `TASK_ID_`, `CALL_PROC_INST_ID_`, `ACT_NAME_`, `ACT_TYPE_`, `ASSIGNEE_`, `START_TIME_`, `END_TIME_`, `DURATION_`, `TRANSACTION_ORDER_`, `DELETE_REASON_`, `TENANT_ID_`) VALUES ('3ef44d34-b340-11ed-9d23-869ef1607803', 1, 'testoa:16:98955103-b33e-11ed-b511-ce4fe10f37b8', '3ef44d28-b340-11ed-9d23-869ef1607803', '3ef44d33-b340-11ed-9d23-869ef1607803', 'startNode1', NULL, NULL, '开始', 'startEvent', NULL, '2023-02-23 06:06:43.383', '2023-02-23 06:06:43.383', 0, 1, NULL, '');
INSERT INTO `act_ru_actinst` (`ID_`, `REV_`, `PROC_DEF_ID_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `ACT_ID_`, `TASK_ID_`, `CALL_PROC_INST_ID_`, `ACT_NAME_`, `ACT_TYPE_`, `ASSIGNEE_`, `START_TIME_`, `END_TIME_`, `DURATION_`, `TRANSACTION_ORDER_`, `DELETE_REASON_`, `TENANT_ID_`) VALUES ('3ef47445-b340-11ed-9d23-869ef1607803', 1, 'testoa:16:98955103-b33e-11ed-b511-ce4fe10f37b8', '3ef44d28-b340-11ed-9d23-869ef1607803', '3ef44d33-b340-11ed-9d23-869ef1607803', 'Flow_19ligpu', NULL, NULL, NULL, 'sequenceFlow', NULL, '2023-02-23 06:06:43.384', '2023-02-23 06:06:43.384', 0, 2, NULL, '');
INSERT INTO `act_ru_actinst` (`ID_`, `REV_`, `PROC_DEF_ID_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `ACT_ID_`, `TASK_ID_`, `CALL_PROC_INST_ID_`, `ACT_NAME_`, `ACT_TYPE_`, `ASSIGNEE_`, `START_TIME_`, `END_TIME_`, `DURATION_`, `TRANSACTION_ORDER_`, `DELETE_REASON_`, `TENANT_ID_`) VALUES ('3ef47446-b340-11ed-9d23-869ef1607803', 2, 'testoa:16:98955103-b33e-11ed-b511-ce4fe10f37b8', '3ef44d28-b340-11ed-9d23-869ef1607803', '3ef44d33-b340-11ed-9d23-869ef1607803', 'Activity_1qo8esf', '3ef47447-b340-11ed-9d23-869ef1607803', NULL, '经理审批', 'userTask', NULL, '2023-02-23 06:06:43.384', '2023-02-23 06:10:28.221', 224837, 3, NULL, '');
INSERT INTO `act_ru_actinst` (`ID_`, `REV_`, `PROC_DEF_ID_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `ACT_ID_`, `TASK_ID_`, `CALL_PROC_INST_ID_`, `ACT_NAME_`, `ACT_TYPE_`, `ASSIGNEE_`, `START_TIME_`, `END_TIME_`, `DURATION_`, `TRANSACTION_ORDER_`, `DELETE_REASON_`, `TENANT_ID_`) VALUES ('4125bf16-584e-11ee-9923-f22f4b0aefad', 1, 'testvue3:2:1e8d1651-584e-11ee-9923-f22f4b0aefad', '4125bf0e-584e-11ee-9923-f22f4b0aefad', '4125bf15-584e-11ee-9923-f22f4b0aefad', 'startNode1', NULL, NULL, '开始', 'startEvent', NULL, '2023-09-21 07:12:41.875', '2023-09-21 07:12:41.875', 0, 1, NULL, '');
INSERT INTO `act_ru_actinst` (`ID_`, `REV_`, `PROC_DEF_ID_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `ACT_ID_`, `TASK_ID_`, `CALL_PROC_INST_ID_`, `ACT_NAME_`, `ACT_TYPE_`, `ASSIGNEE_`, `START_TIME_`, `END_TIME_`, `DURATION_`, `TRANSACTION_ORDER_`, `DELETE_REASON_`, `TENANT_ID_`) VALUES ('4125bf17-584e-11ee-9923-f22f4b0aefad', 1, 'testvue3:2:1e8d1651-584e-11ee-9923-f22f4b0aefad', '4125bf0e-584e-11ee-9923-f22f4b0aefad', '4125bf15-584e-11ee-9923-f22f4b0aefad', 'Flow_0k6k615', NULL, NULL, NULL, 'sequenceFlow', NULL, '2023-09-21 07:12:41.875', '2023-09-21 07:12:41.875', 0, 2, NULL, '');
INSERT INTO `act_ru_actinst` (`ID_`, `REV_`, `PROC_DEF_ID_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `ACT_ID_`, `TASK_ID_`, `CALL_PROC_INST_ID_`, `ACT_NAME_`, `ACT_TYPE_`, `ASSIGNEE_`, `START_TIME_`, `END_TIME_`, `DURATION_`, `TRANSACTION_ORDER_`, `DELETE_REASON_`, `TENANT_ID_`) VALUES ('65359e82-584e-11ee-9923-f22f4b0aefad', 1, 'testvue3:2:1e8d1651-584e-11ee-9923-f22f4b0aefad', '65359e7a-584e-11ee-9923-f22f4b0aefad', '65359e81-584e-11ee-9923-f22f4b0aefad', 'startNode1', NULL, NULL, '开始', 'startEvent', NULL, '2023-09-21 07:13:42.377', '2023-09-21 07:13:42.378', 1, 1, NULL, '');
INSERT INTO `act_ru_actinst` (`ID_`, `REV_`, `PROC_DEF_ID_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `ACT_ID_`, `TASK_ID_`, `CALL_PROC_INST_ID_`, `ACT_NAME_`, `ACT_TYPE_`, `ASSIGNEE_`, `START_TIME_`, `END_TIME_`, `DURATION_`, `TRANSACTION_ORDER_`, `DELETE_REASON_`, `TENANT_ID_`) VALUES ('6535c593-584e-11ee-9923-f22f4b0aefad', 1, 'testvue3:2:1e8d1651-584e-11ee-9923-f22f4b0aefad', '65359e7a-584e-11ee-9923-f22f4b0aefad', '65359e81-584e-11ee-9923-f22f4b0aefad', 'Flow_0k6k615', NULL, NULL, NULL, 'sequenceFlow', NULL, '2023-09-21 07:13:42.378', '2023-09-21 07:13:42.378', 0, 2, NULL, '');
INSERT INTO `act_ru_actinst` (`ID_`, `REV_`, `PROC_DEF_ID_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `ACT_ID_`, `TASK_ID_`, `CALL_PROC_INST_ID_`, `ACT_NAME_`, `ACT_TYPE_`, `ASSIGNEE_`, `START_TIME_`, `END_TIME_`, `DURATION_`, `TRANSACTION_ORDER_`, `DELETE_REASON_`, `TENANT_ID_`) VALUES ('b7a6049a-5851-11ee-9923-f22f4b0aefad', 1, 'testvue3:2:1e8d1651-584e-11ee-9923-f22f4b0aefad', 'b7a5dd82-5851-11ee-9923-f22f4b0aefad', 'b7a60499-5851-11ee-9923-f22f4b0aefad', 'startNode1', NULL, NULL, '开始', 'startEvent', NULL, '2023-09-21 07:37:29.177', '2023-09-21 07:37:29.177', 0, 1, NULL, '');
INSERT INTO `act_ru_actinst` (`ID_`, `REV_`, `PROC_DEF_ID_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `ACT_ID_`, `TASK_ID_`, `CALL_PROC_INST_ID_`, `ACT_NAME_`, `ACT_TYPE_`, `ASSIGNEE_`, `START_TIME_`, `END_TIME_`, `DURATION_`, `TRANSACTION_ORDER_`, `DELETE_REASON_`, `TENANT_ID_`) VALUES ('b7a6049b-5851-11ee-9923-f22f4b0aefad', 1, 'testvue3:2:1e8d1651-584e-11ee-9923-f22f4b0aefad', 'b7a5dd82-5851-11ee-9923-f22f4b0aefad', 'b7a60499-5851-11ee-9923-f22f4b0aefad', 'Flow_0k6k615', NULL, NULL, NULL, 'sequenceFlow', NULL, '2023-09-21 07:37:29.177', '2023-09-21 07:37:29.177', 0, 2, NULL, '');
INSERT INTO `act_ru_actinst` (`ID_`, `REV_`, `PROC_DEF_ID_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `ACT_ID_`, `TASK_ID_`, `CALL_PROC_INST_ID_`, `ACT_NAME_`, `ACT_TYPE_`, `ASSIGNEE_`, `START_TIME_`, `END_TIME_`, `DURATION_`, `TRANSACTION_ORDER_`, `DELETE_REASON_`, `TENANT_ID_`) VALUES ('b8076162-b345-11ed-8617-ce4fe10f37b8', 1, 'testoa:16:98955103-b33e-11ed-b511-ce4fe10f37b8', 'b8058c96-b345-11ed-8617-ce4fe10f37b8', 'b8073a51-b345-11ed-8617-ce4fe10f37b8', 'startNode1', NULL, NULL, '开始', 'startEvent', NULL, '2023-02-23 06:45:53.996', '2023-02-23 06:45:54.000', 4, 1, NULL, '');
INSERT INTO `act_ru_actinst` (`ID_`, `REV_`, `PROC_DEF_ID_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `ACT_ID_`, `TASK_ID_`, `CALL_PROC_INST_ID_`, `ACT_NAME_`, `ACT_TYPE_`, `ASSIGNEE_`, `START_TIME_`, `END_TIME_`, `DURATION_`, `TRANSACTION_ORDER_`, `DELETE_REASON_`, `TENANT_ID_`) VALUES ('b8084bc3-b345-11ed-8617-ce4fe10f37b8', 1, 'testoa:16:98955103-b33e-11ed-b511-ce4fe10f37b8', 'b8058c96-b345-11ed-8617-ce4fe10f37b8', 'b8073a51-b345-11ed-8617-ce4fe10f37b8', 'Flow_19ligpu', NULL, NULL, NULL, 'sequenceFlow', NULL, '2023-02-23 06:45:54.002', '2023-02-23 06:45:54.002', 0, 2, NULL, '');
INSERT INTO `act_ru_actinst` (`ID_`, `REV_`, `PROC_DEF_ID_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `ACT_ID_`, `TASK_ID_`, `CALL_PROC_INST_ID_`, `ACT_NAME_`, `ACT_TYPE_`, `ASSIGNEE_`, `START_TIME_`, `END_TIME_`, `DURATION_`, `TRANSACTION_ORDER_`, `DELETE_REASON_`, `TENANT_ID_`) VALUES ('b8084bc4-b345-11ed-8617-ce4fe10f37b8', 1, 'testoa:16:98955103-b33e-11ed-b511-ce4fe10f37b8', 'b8058c96-b345-11ed-8617-ce4fe10f37b8', 'b8073a51-b345-11ed-8617-ce4fe10f37b8', 'Activity_1qo8esf', 'b80abcc5-b345-11ed-8617-ce4fe10f37b8', NULL, '经理审批', 'userTask', NULL, '2023-02-23 06:45:54.002', NULL, NULL, 3, NULL, '');
INSERT INTO `act_ru_actinst` (`ID_`, `REV_`, `PROC_DEF_ID_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `ACT_ID_`, `TASK_ID_`, `CALL_PROC_INST_ID_`, `ACT_NAME_`, `ACT_TYPE_`, `ASSIGNEE_`, `START_TIME_`, `END_TIME_`, `DURATION_`, `TRANSACTION_ORDER_`, `DELETE_REASON_`, `TENANT_ID_`) VALUES ('c4f9137d-b340-11ed-88a8-869ef1607803', 1, 'testoa:16:98955103-b33e-11ed-b511-ce4fe10f37b8', '3ef44d28-b340-11ed-9d23-869ef1607803', '3ef44d33-b340-11ed-9d23-869ef1607803', 'Flow_14pge79', NULL, NULL, NULL, 'sequenceFlow', NULL, '2023-02-23 06:10:28.229', '2023-02-23 06:10:28.229', 0, 1, NULL, '');
INSERT INTO `act_ru_actinst` (`ID_`, `REV_`, `PROC_DEF_ID_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `ACT_ID_`, `TASK_ID_`, `CALL_PROC_INST_ID_`, `ACT_NAME_`, `ACT_TYPE_`, `ASSIGNEE_`, `START_TIME_`, `END_TIME_`, `DURATION_`, `TRANSACTION_ORDER_`, `DELETE_REASON_`, `TENANT_ID_`) VALUES ('c4f988ae-b340-11ed-88a8-869ef1607803', 1, 'testoa:16:98955103-b33e-11ed-b511-ce4fe10f37b8', '3ef44d28-b340-11ed-9d23-869ef1607803', '3ef44d33-b340-11ed-9d23-869ef1607803', 'Gateway_1nuou39', NULL, NULL, NULL, 'exclusiveGateway', NULL, '2023-02-23 06:10:28.232', '2023-02-23 06:10:28.250', 18, 2, NULL, '');
INSERT INTO `act_ru_actinst` (`ID_`, `REV_`, `PROC_DEF_ID_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `ACT_ID_`, `TASK_ID_`, `CALL_PROC_INST_ID_`, `ACT_NAME_`, `ACT_TYPE_`, `ASSIGNEE_`, `START_TIME_`, `END_TIME_`, `DURATION_`, `TRANSACTION_ORDER_`, `DELETE_REASON_`, `TENANT_ID_`) VALUES ('c4fc47cf-b340-11ed-88a8-869ef1607803', 1, 'testoa:16:98955103-b33e-11ed-b511-ce4fe10f37b8', '3ef44d28-b340-11ed-9d23-869ef1607803', '3ef44d33-b340-11ed-9d23-869ef1607803', 'Flow_1vusrns', NULL, NULL, '驳回', 'sequenceFlow', NULL, '2023-02-23 06:10:28.250', '2023-02-23 06:10:28.250', 0, 3, NULL, '');
INSERT INTO `act_ru_actinst` (`ID_`, `REV_`, `PROC_DEF_ID_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `ACT_ID_`, `TASK_ID_`, `CALL_PROC_INST_ID_`, `ACT_NAME_`, `ACT_TYPE_`, `ASSIGNEE_`, `START_TIME_`, `END_TIME_`, `DURATION_`, `TRANSACTION_ORDER_`, `DELETE_REASON_`, `TENANT_ID_`) VALUES ('c4fcbd00-b340-11ed-88a8-869ef1607803', 1, 'testoa:16:98955103-b33e-11ed-b511-ce4fe10f37b8', '3ef44d28-b340-11ed-9d23-869ef1607803', '3ef44d33-b340-11ed-9d23-869ef1607803', 'Activity_1qfkof6', 'c4fce411-b340-11ed-88a8-869ef1607803', NULL, '重新发起', 'userTask', NULL, '2023-02-23 06:10:28.253', NULL, NULL, 4, NULL, '');
INSERT INTO `act_ru_actinst` (`ID_`, `REV_`, `PROC_DEF_ID_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `ACT_ID_`, `TASK_ID_`, `CALL_PROC_INST_ID_`, `ACT_NAME_`, `ACT_TYPE_`, `ASSIGNEE_`, `START_TIME_`, `END_TIME_`, `DURATION_`, `TRANSACTION_ORDER_`, `DELETE_REASON_`, `TENANT_ID_`) VALUES ('d48e7259-b33f-11ed-9d23-869ef1607803', 1, 'testoa:16:98955103-b33e-11ed-b511-ce4fe10f37b8', 'd48d87ed-b33f-11ed-9d23-869ef1607803', 'd48e7258-b33f-11ed-9d23-869ef1607803', 'startNode1', NULL, NULL, '开始', 'startEvent', NULL, '2023-02-23 06:03:44.878', '2023-02-23 06:03:44.880', 2, 1, NULL, '');
INSERT INTO `act_ru_actinst` (`ID_`, `REV_`, `PROC_DEF_ID_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `ACT_ID_`, `TASK_ID_`, `CALL_PROC_INST_ID_`, `ACT_NAME_`, `ACT_TYPE_`, `ASSIGNEE_`, `START_TIME_`, `END_TIME_`, `DURATION_`, `TRANSACTION_ORDER_`, `DELETE_REASON_`, `TENANT_ID_`) VALUES ('d48f0e9a-b33f-11ed-9d23-869ef1607803', 1, 'testoa:16:98955103-b33e-11ed-b511-ce4fe10f37b8', 'd48d87ed-b33f-11ed-9d23-869ef1607803', 'd48e7258-b33f-11ed-9d23-869ef1607803', 'Flow_19ligpu', NULL, NULL, NULL, 'sequenceFlow', NULL, '2023-02-23 06:03:44.882', '2023-02-23 06:03:44.882', 0, 2, NULL, '');
INSERT INTO `act_ru_actinst` (`ID_`, `REV_`, `PROC_DEF_ID_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `ACT_ID_`, `TASK_ID_`, `CALL_PROC_INST_ID_`, `ACT_NAME_`, `ACT_TYPE_`, `ASSIGNEE_`, `START_TIME_`, `END_TIME_`, `DURATION_`, `TRANSACTION_ORDER_`, `DELETE_REASON_`, `TENANT_ID_`) VALUES ('d48f35ab-b33f-11ed-9d23-869ef1607803', 3, 'testoa:16:98955103-b33e-11ed-b511-ce4fe10f37b8', 'd48d87ed-b33f-11ed-9d23-869ef1607803', 'd48e7258-b33f-11ed-9d23-869ef1607803', 'Activity_1qo8esf', 'd4910a6c-b33f-11ed-9d23-869ef1607803', NULL, '经理审批', 'userTask', '1', '2023-02-23 06:03:44.882', '2023-02-23 06:03:55.028', 10146, 3, NULL, '');
INSERT INTO `act_ru_actinst` (`ID_`, `REV_`, `PROC_DEF_ID_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `ACT_ID_`, `TASK_ID_`, `CALL_PROC_INST_ID_`, `ACT_NAME_`, `ACT_TYPE_`, `ASSIGNEE_`, `START_TIME_`, `END_TIME_`, `DURATION_`, `TRANSACTION_ORDER_`, `DELETE_REASON_`, `TENANT_ID_`) VALUES ('da9babf6-b33f-11ed-9d23-869ef1607803', 1, 'testoa:16:98955103-b33e-11ed-b511-ce4fe10f37b8', 'd48d87ed-b33f-11ed-9d23-869ef1607803', 'd48e7258-b33f-11ed-9d23-869ef1607803', 'Flow_14pge79', NULL, NULL, NULL, 'sequenceFlow', NULL, '2023-02-23 06:03:55.030', '2023-02-23 06:03:55.030', 0, 1, NULL, '');
INSERT INTO `act_ru_actinst` (`ID_`, `REV_`, `PROC_DEF_ID_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `ACT_ID_`, `TASK_ID_`, `CALL_PROC_INST_ID_`, `ACT_NAME_`, `ACT_TYPE_`, `ASSIGNEE_`, `START_TIME_`, `END_TIME_`, `DURATION_`, `TRANSACTION_ORDER_`, `DELETE_REASON_`, `TENANT_ID_`) VALUES ('da9bfa17-b33f-11ed-9d23-869ef1607803', 1, 'testoa:16:98955103-b33e-11ed-b511-ce4fe10f37b8', 'd48d87ed-b33f-11ed-9d23-869ef1607803', 'd48e7258-b33f-11ed-9d23-869ef1607803', 'Gateway_1nuou39', NULL, NULL, NULL, 'exclusiveGateway', NULL, '2023-02-23 06:03:55.032', '2023-02-23 06:03:55.040', 8, 2, NULL, '');
INSERT INTO `act_ru_actinst` (`ID_`, `REV_`, `PROC_DEF_ID_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `ACT_ID_`, `TASK_ID_`, `CALL_PROC_INST_ID_`, `ACT_NAME_`, `ACT_TYPE_`, `ASSIGNEE_`, `START_TIME_`, `END_TIME_`, `DURATION_`, `TRANSACTION_ORDER_`, `DELETE_REASON_`, `TENANT_ID_`) VALUES ('da9d3298-b33f-11ed-9d23-869ef1607803', 1, 'testoa:16:98955103-b33e-11ed-b511-ce4fe10f37b8', 'd48d87ed-b33f-11ed-9d23-869ef1607803', 'd48e7258-b33f-11ed-9d23-869ef1607803', 'Flow_1vusrns', NULL, NULL, '驳回', 'sequenceFlow', NULL, '2023-02-23 06:03:55.040', '2023-02-23 06:03:55.040', 0, 3, NULL, '');
INSERT INTO `act_ru_actinst` (`ID_`, `REV_`, `PROC_DEF_ID_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `ACT_ID_`, `TASK_ID_`, `CALL_PROC_INST_ID_`, `ACT_NAME_`, `ACT_TYPE_`, `ASSIGNEE_`, `START_TIME_`, `END_TIME_`, `DURATION_`, `TRANSACTION_ORDER_`, `DELETE_REASON_`, `TENANT_ID_`) VALUES ('da9dced9-b33f-11ed-9d23-869ef1607803', 1, 'testoa:16:98955103-b33e-11ed-b511-ce4fe10f37b8', 'd48d87ed-b33f-11ed-9d23-869ef1607803', 'd48e7258-b33f-11ed-9d23-869ef1607803', 'Activity_1qfkof6', 'da9dceda-b33f-11ed-9d23-869ef1607803', NULL, '重新发起', 'userTask', NULL, '2023-02-23 06:03:55.044', NULL, NULL, 4, NULL, '');
INSERT INTO `act_ru_actinst` (`ID_`, `REV_`, `PROC_DEF_ID_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `ACT_ID_`, `TASK_ID_`, `CALL_PROC_INST_ID_`, `ACT_NAME_`, `ACT_TYPE_`, `ASSIGNEE_`, `START_TIME_`, `END_TIME_`, `DURATION_`, `TRANSACTION_ORDER_`, `DELETE_REASON_`, `TENANT_ID_`) VALUES ('ede2b72e-5850-11ee-9923-f22f4b0aefad', 1, 'testvue3:2:1e8d1651-584e-11ee-9923-f22f4b0aefad', 'ede26906-5850-11ee-9923-f22f4b0aefad', 'ede2b72d-5850-11ee-9923-f22f4b0aefad', 'startNode1', NULL, NULL, '开始', 'startEvent', NULL, '2023-09-21 07:31:50.675', '2023-09-21 07:31:50.675', 0, 1, NULL, '');
INSERT INTO `act_ru_actinst` (`ID_`, `REV_`, `PROC_DEF_ID_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `ACT_ID_`, `TASK_ID_`, `CALL_PROC_INST_ID_`, `ACT_NAME_`, `ACT_TYPE_`, `ASSIGNEE_`, `START_TIME_`, `END_TIME_`, `DURATION_`, `TRANSACTION_ORDER_`, `DELETE_REASON_`, `TENANT_ID_`) VALUES ('ede2b72f-5850-11ee-9923-f22f4b0aefad', 1, 'testvue3:2:1e8d1651-584e-11ee-9923-f22f4b0aefad', 'ede26906-5850-11ee-9923-f22f4b0aefad', 'ede2b72d-5850-11ee-9923-f22f4b0aefad', 'Flow_0k6k615', NULL, NULL, NULL, 'sequenceFlow', NULL, '2023-09-21 07:31:50.675', '2023-09-21 07:31:50.675', 0, 2, NULL, '');
INSERT INTO `act_ru_actinst` (`ID_`, `REV_`, `PROC_DEF_ID_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `ACT_ID_`, `TASK_ID_`, `CALL_PROC_INST_ID_`, `ACT_NAME_`, `ACT_TYPE_`, `ASSIGNEE_`, `START_TIME_`, `END_TIME_`, `DURATION_`, `TRANSACTION_ORDER_`, `DELETE_REASON_`, `TENANT_ID_`) VALUES ('ff6e521a-584d-11ee-9923-f22f4b0aefad', 1, 'testvue3:1:2aea33f1-56c2-11ee-ae41-f22f4b0aefad', 'ff6d67b2-584d-11ee-9923-f22f4b0aefad', 'ff6e5219-584d-11ee-9923-f22f4b0aefad', 'startNode1', NULL, NULL, '开始', 'startEvent', NULL, '2023-09-21 07:10:51.621', '2023-09-21 07:10:51.623', 2, 1, NULL, '');
INSERT INTO `act_ru_actinst` (`ID_`, `REV_`, `PROC_DEF_ID_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `ACT_ID_`, `TASK_ID_`, `CALL_PROC_INST_ID_`, `ACT_NAME_`, `ACT_TYPE_`, `ASSIGNEE_`, `START_TIME_`, `END_TIME_`, `DURATION_`, `TRANSACTION_ORDER_`, `DELETE_REASON_`, `TENANT_ID_`) VALUES ('ff6ec74b-584d-11ee-9923-f22f4b0aefad', 1, 'testvue3:1:2aea33f1-56c2-11ee-ae41-f22f4b0aefad', 'ff6d67b2-584d-11ee-9923-f22f4b0aefad', 'ff6e5219-584d-11ee-9923-f22f4b0aefad', 'Flow_0k6k615', NULL, NULL, NULL, 'sequenceFlow', NULL, '2023-09-21 07:10:51.624', '2023-09-21 07:10:51.624', 0, 2, NULL, '');
COMMIT;

-- ----------------------------
-- Table structure for act_ru_deadletter_job
-- ----------------------------
DROP TABLE IF EXISTS `act_ru_deadletter_job`;
CREATE TABLE `act_ru_deadletter_job` (
                                         `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                         `REV_` int DEFAULT NULL,
                                         `CATEGORY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                         `TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
                                         `EXCLUSIVE_` tinyint(1) DEFAULT NULL,
                                         `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                         `PROCESS_INSTANCE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                         `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                         `ELEMENT_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                         `ELEMENT_NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                         `SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                         `SUB_SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                         `SCOPE_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                         `SCOPE_DEFINITION_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                         `CORRELATION_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                         `EXCEPTION_STACK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                         `EXCEPTION_MSG_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
                                         `DUEDATE_` timestamp(3) NULL DEFAULT NULL,
                                         `REPEAT_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                         `HANDLER_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                         `HANDLER_CFG_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
                                         `CUSTOM_VALUES_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                         `CREATE_TIME_` timestamp(3) NULL DEFAULT NULL,
                                         `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
                                         PRIMARY KEY (`ID_`),
                                         KEY `ACT_IDX_DEADLETTER_JOB_EXCEPTION_STACK_ID` (`EXCEPTION_STACK_ID_`),
                                         KEY `ACT_IDX_DEADLETTER_JOB_CUSTOM_VALUES_ID` (`CUSTOM_VALUES_ID_`),
                                         KEY `ACT_IDX_DEADLETTER_JOB_CORRELATION_ID` (`CORRELATION_ID_`),
                                         KEY `ACT_IDX_DJOB_SCOPE` (`SCOPE_ID_`,`SCOPE_TYPE_`),
                                         KEY `ACT_IDX_DJOB_SUB_SCOPE` (`SUB_SCOPE_ID_`,`SCOPE_TYPE_`),
                                         KEY `ACT_IDX_DJOB_SCOPE_DEF` (`SCOPE_DEFINITION_ID_`,`SCOPE_TYPE_`),
                                         KEY `ACT_FK_DEADLETTER_JOB_EXECUTION` (`EXECUTION_ID_`),
                                         KEY `ACT_FK_DEADLETTER_JOB_PROCESS_INSTANCE` (`PROCESS_INSTANCE_ID_`),
                                         KEY `ACT_FK_DEADLETTER_JOB_PROC_DEF` (`PROC_DEF_ID_`),
                                         CONSTRAINT `ACT_FK_DEADLETTER_JOB_CUSTOM_VALUES` FOREIGN KEY (`CUSTOM_VALUES_ID_`) REFERENCES `act_ge_bytearray` (`ID_`),
                                         CONSTRAINT `ACT_FK_DEADLETTER_JOB_EXCEPTION` FOREIGN KEY (`EXCEPTION_STACK_ID_`) REFERENCES `act_ge_bytearray` (`ID_`),
                                         CONSTRAINT `ACT_FK_DEADLETTER_JOB_EXECUTION` FOREIGN KEY (`EXECUTION_ID_`) REFERENCES `act_ru_execution` (`ID_`),
                                         CONSTRAINT `ACT_FK_DEADLETTER_JOB_PROC_DEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `act_re_procdef` (`ID_`),
                                         CONSTRAINT `ACT_FK_DEADLETTER_JOB_PROCESS_INSTANCE` FOREIGN KEY (`PROCESS_INSTANCE_ID_`) REFERENCES `act_ru_execution` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_ru_deadletter_job
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for act_ru_entitylink
-- ----------------------------
DROP TABLE IF EXISTS `act_ru_entitylink`;
CREATE TABLE `act_ru_entitylink` (
                                     `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                     `REV_` int DEFAULT NULL,
                                     `CREATE_TIME_` datetime(3) DEFAULT NULL,
                                     `LINK_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                     `SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                     `SUB_SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                     `SCOPE_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                     `SCOPE_DEFINITION_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                     `PARENT_ELEMENT_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                     `REF_SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                     `REF_SCOPE_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                     `REF_SCOPE_DEFINITION_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                     `ROOT_SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                     `ROOT_SCOPE_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                     `HIERARCHY_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                     PRIMARY KEY (`ID_`),
                                     KEY `ACT_IDX_ENT_LNK_SCOPE` (`SCOPE_ID_`,`SCOPE_TYPE_`,`LINK_TYPE_`),
                                     KEY `ACT_IDX_ENT_LNK_REF_SCOPE` (`REF_SCOPE_ID_`,`REF_SCOPE_TYPE_`,`LINK_TYPE_`),
                                     KEY `ACT_IDX_ENT_LNK_ROOT_SCOPE` (`ROOT_SCOPE_ID_`,`ROOT_SCOPE_TYPE_`,`LINK_TYPE_`),
                                     KEY `ACT_IDX_ENT_LNK_SCOPE_DEF` (`SCOPE_DEFINITION_ID_`,`SCOPE_TYPE_`,`LINK_TYPE_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_ru_entitylink
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for act_ru_event_subscr
-- ----------------------------
DROP TABLE IF EXISTS `act_ru_event_subscr`;
CREATE TABLE `act_ru_event_subscr` (
                                       `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                       `REV_` int DEFAULT NULL,
                                       `EVENT_TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
                                       `EVENT_NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                       `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                       `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                       `ACTIVITY_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                       `CONFIGURATION_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                       `CREATED_` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
                                       `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                       `SUB_SCOPE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                       `SCOPE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                       `SCOPE_DEFINITION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                       `SCOPE_TYPE_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                       `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
                                       `LOCK_TIME_` timestamp(3) NULL DEFAULT NULL,
                                       `LOCK_OWNER_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                       PRIMARY KEY (`ID_`),
                                       KEY `ACT_IDX_EVENT_SUBSCR_CONFIG_` (`CONFIGURATION_`),
                                       KEY `ACT_FK_EVENT_EXEC` (`EXECUTION_ID_`),
                                       KEY `ACT_IDX_EVENT_SUBSCR_SCOPEREF_` (`SCOPE_ID_`,`SCOPE_TYPE_`),
                                       CONSTRAINT `ACT_FK_EVENT_EXEC` FOREIGN KEY (`EXECUTION_ID_`) REFERENCES `act_ru_execution` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_ru_event_subscr
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for act_ru_execution
-- ----------------------------
DROP TABLE IF EXISTS `act_ru_execution`;
CREATE TABLE `act_ru_execution` (
                                    `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                    `REV_` int DEFAULT NULL,
                                    `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                    `BUSINESS_KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                    `PARENT_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                    `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                    `SUPER_EXEC_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                    `ROOT_PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                    `ACT_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                    `IS_ACTIVE_` tinyint DEFAULT NULL,
                                    `IS_CONCURRENT_` tinyint DEFAULT NULL,
                                    `IS_SCOPE_` tinyint DEFAULT NULL,
                                    `IS_EVENT_SCOPE_` tinyint DEFAULT NULL,
                                    `IS_MI_ROOT_` tinyint DEFAULT NULL,
                                    `SUSPENSION_STATE_` int DEFAULT NULL,
                                    `CACHED_ENT_STATE_` int DEFAULT NULL,
                                    `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
                                    `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                    `START_ACT_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                    `START_TIME_` datetime(3) DEFAULT NULL,
                                    `START_USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                    `LOCK_TIME_` timestamp(3) NULL DEFAULT NULL,
                                    `LOCK_OWNER_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                    `IS_COUNT_ENABLED_` tinyint DEFAULT NULL,
                                    `EVT_SUBSCR_COUNT_` int DEFAULT NULL,
                                    `TASK_COUNT_` int DEFAULT NULL,
                                    `JOB_COUNT_` int DEFAULT NULL,
                                    `TIMER_JOB_COUNT_` int DEFAULT NULL,
                                    `SUSP_JOB_COUNT_` int DEFAULT NULL,
                                    `DEADLETTER_JOB_COUNT_` int DEFAULT NULL,
                                    `EXTERNAL_WORKER_JOB_COUNT_` int DEFAULT NULL,
                                    `VAR_COUNT_` int DEFAULT NULL,
                                    `ID_LINK_COUNT_` int DEFAULT NULL,
                                    `CALLBACK_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                    `CALLBACK_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                    `REFERENCE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                    `REFERENCE_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                    `PROPAGATED_STAGE_INST_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                    `BUSINESS_STATUS_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                    PRIMARY KEY (`ID_`),
                                    KEY `ACT_IDX_EXEC_BUSKEY` (`BUSINESS_KEY_`),
                                    KEY `ACT_IDC_EXEC_ROOT` (`ROOT_PROC_INST_ID_`),
                                    KEY `ACT_IDX_EXEC_REF_ID_` (`REFERENCE_ID_`),
                                    KEY `ACT_FK_EXE_PROCINST` (`PROC_INST_ID_`),
                                    KEY `ACT_FK_EXE_PARENT` (`PARENT_ID_`),
                                    KEY `ACT_FK_EXE_SUPER` (`SUPER_EXEC_`),
                                    KEY `ACT_FK_EXE_PROCDEF` (`PROC_DEF_ID_`),
                                    CONSTRAINT `ACT_FK_EXE_PARENT` FOREIGN KEY (`PARENT_ID_`) REFERENCES `act_ru_execution` (`ID_`) ON DELETE CASCADE,
                                    CONSTRAINT `ACT_FK_EXE_PROCDEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `act_re_procdef` (`ID_`),
                                    CONSTRAINT `ACT_FK_EXE_PROCINST` FOREIGN KEY (`PROC_INST_ID_`) REFERENCES `act_ru_execution` (`ID_`) ON DELETE CASCADE ON UPDATE CASCADE,
                                    CONSTRAINT `ACT_FK_EXE_SUPER` FOREIGN KEY (`SUPER_EXEC_`) REFERENCES `act_ru_execution` (`ID_`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_ru_execution
-- ----------------------------
BEGIN;
INSERT INTO `act_ru_execution` (`ID_`, `REV_`, `PROC_INST_ID_`, `BUSINESS_KEY_`, `PARENT_ID_`, `PROC_DEF_ID_`, `SUPER_EXEC_`, `ROOT_PROC_INST_ID_`, `ACT_ID_`, `IS_ACTIVE_`, `IS_CONCURRENT_`, `IS_SCOPE_`, `IS_EVENT_SCOPE_`, `IS_MI_ROOT_`, `SUSPENSION_STATE_`, `CACHED_ENT_STATE_`, `TENANT_ID_`, `NAME_`, `START_ACT_ID_`, `START_TIME_`, `START_USER_ID_`, `LOCK_TIME_`, `LOCK_OWNER_`, `IS_COUNT_ENABLED_`, `EVT_SUBSCR_COUNT_`, `TASK_COUNT_`, `JOB_COUNT_`, `TIMER_JOB_COUNT_`, `SUSP_JOB_COUNT_`, `DEADLETTER_JOB_COUNT_`, `EXTERNAL_WORKER_JOB_COUNT_`, `VAR_COUNT_`, `ID_LINK_COUNT_`, `CALLBACK_ID_`, `CALLBACK_TYPE_`, `REFERENCE_ID_`, `REFERENCE_TYPE_`, `PROPAGATED_STAGE_INST_ID_`, `BUSINESS_STATUS_`) VALUES ('11884c8f-b33f-11ed-b511-ce4fe10f37b8', 1, '11884c8f-b33f-11ed-b511-ce4fe10f37b8', NULL, NULL, 'testoa:16:98955103-b33e-11ed-b511-ce4fe10f37b8', NULL, '11884c8f-b33f-11ed-b511-ce4fe10f37b8', NULL, 1, 0, 1, 0, 0, 1, NULL, '', NULL, 'startNode1', '2023-02-23 05:58:17.681', '1', NULL, NULL, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `act_ru_execution` (`ID_`, `REV_`, `PROC_INST_ID_`, `BUSINESS_KEY_`, `PARENT_ID_`, `PROC_DEF_ID_`, `SUPER_EXEC_`, `ROOT_PROC_INST_ID_`, `ACT_ID_`, `IS_ACTIVE_`, `IS_CONCURRENT_`, `IS_SCOPE_`, `IS_EVENT_SCOPE_`, `IS_MI_ROOT_`, `SUSPENSION_STATE_`, `CACHED_ENT_STATE_`, `TENANT_ID_`, `NAME_`, `START_ACT_ID_`, `START_TIME_`, `START_USER_ID_`, `LOCK_TIME_`, `LOCK_OWNER_`, `IS_COUNT_ENABLED_`, `EVT_SUBSCR_COUNT_`, `TASK_COUNT_`, `JOB_COUNT_`, `TIMER_JOB_COUNT_`, `SUSP_JOB_COUNT_`, `DEADLETTER_JOB_COUNT_`, `EXTERNAL_WORKER_JOB_COUNT_`, `VAR_COUNT_`, `ID_LINK_COUNT_`, `CALLBACK_ID_`, `CALLBACK_TYPE_`, `REFERENCE_ID_`, `REFERENCE_TYPE_`, `PROPAGATED_STAGE_INST_ID_`, `BUSINESS_STATUS_`) VALUES ('1188c1ca-b33f-11ed-b511-ce4fe10f37b8', 2, '11884c8f-b33f-11ed-b511-ce4fe10f37b8', NULL, '11884c8f-b33f-11ed-b511-ce4fe10f37b8', 'testoa:16:98955103-b33e-11ed-b511-ce4fe10f37b8', NULL, '11884c8f-b33f-11ed-b511-ce4fe10f37b8', 'Activity_0exhfyz', 1, 0, 0, 0, 0, 1, NULL, '', NULL, NULL, '2023-02-23 05:58:17.684', NULL, NULL, NULL, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `act_ru_execution` (`ID_`, `REV_`, `PROC_INST_ID_`, `BUSINESS_KEY_`, `PARENT_ID_`, `PROC_DEF_ID_`, `SUPER_EXEC_`, `ROOT_PROC_INST_ID_`, `ACT_ID_`, `IS_ACTIVE_`, `IS_CONCURRENT_`, `IS_SCOPE_`, `IS_EVENT_SCOPE_`, `IS_MI_ROOT_`, `SUSPENSION_STATE_`, `CACHED_ENT_STATE_`, `TENANT_ID_`, `NAME_`, `START_ACT_ID_`, `START_TIME_`, `START_USER_ID_`, `LOCK_TIME_`, `LOCK_OWNER_`, `IS_COUNT_ENABLED_`, `EVT_SUBSCR_COUNT_`, `TASK_COUNT_`, `JOB_COUNT_`, `TIMER_JOB_COUNT_`, `SUSP_JOB_COUNT_`, `DEADLETTER_JOB_COUNT_`, `EXTERNAL_WORKER_JOB_COUNT_`, `VAR_COUNT_`, `ID_LINK_COUNT_`, `CALLBACK_ID_`, `CALLBACK_TYPE_`, `REFERENCE_ID_`, `REFERENCE_TYPE_`, `PROPAGATED_STAGE_INST_ID_`, `BUSINESS_STATUS_`) VALUES ('23cbb542-584e-11ee-9923-f22f4b0aefad', 1, '23cbb542-584e-11ee-9923-f22f4b0aefad', NULL, NULL, 'testvue3:1:2aea33f1-56c2-11ee-ae41-f22f4b0aefad', NULL, '23cbb542-584e-11ee-9923-f22f4b0aefad', NULL, 1, 0, 1, 0, 0, 1, NULL, '', NULL, 'startNode1', '2023-09-21 07:11:52.631', '1', NULL, NULL, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `act_ru_execution` (`ID_`, `REV_`, `PROC_INST_ID_`, `BUSINESS_KEY_`, `PARENT_ID_`, `PROC_DEF_ID_`, `SUPER_EXEC_`, `ROOT_PROC_INST_ID_`, `ACT_ID_`, `IS_ACTIVE_`, `IS_CONCURRENT_`, `IS_SCOPE_`, `IS_EVENT_SCOPE_`, `IS_MI_ROOT_`, `SUSPENSION_STATE_`, `CACHED_ENT_STATE_`, `TENANT_ID_`, `NAME_`, `START_ACT_ID_`, `START_TIME_`, `START_USER_ID_`, `LOCK_TIME_`, `LOCK_OWNER_`, `IS_COUNT_ENABLED_`, `EVT_SUBSCR_COUNT_`, `TASK_COUNT_`, `JOB_COUNT_`, `TIMER_JOB_COUNT_`, `SUSP_JOB_COUNT_`, `DEADLETTER_JOB_COUNT_`, `EXTERNAL_WORKER_JOB_COUNT_`, `VAR_COUNT_`, `ID_LINK_COUNT_`, `CALLBACK_ID_`, `CALLBACK_TYPE_`, `REFERENCE_ID_`, `REFERENCE_TYPE_`, `PROPAGATED_STAGE_INST_ID_`, `BUSINESS_STATUS_`) VALUES ('23cbdc59-584e-11ee-9923-f22f4b0aefad', 1, '23cbb542-584e-11ee-9923-f22f4b0aefad', NULL, '23cbb542-584e-11ee-9923-f22f4b0aefad', 'testvue3:1:2aea33f1-56c2-11ee-ae41-f22f4b0aefad', NULL, '23cbb542-584e-11ee-9923-f22f4b0aefad', 'Activity_17esl0a', 1, 0, 0, 0, 0, 1, NULL, '', NULL, NULL, '2023-09-21 07:11:52.632', NULL, NULL, NULL, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `act_ru_execution` (`ID_`, `REV_`, `PROC_INST_ID_`, `BUSINESS_KEY_`, `PARENT_ID_`, `PROC_DEF_ID_`, `SUPER_EXEC_`, `ROOT_PROC_INST_ID_`, `ACT_ID_`, `IS_ACTIVE_`, `IS_CONCURRENT_`, `IS_SCOPE_`, `IS_EVENT_SCOPE_`, `IS_MI_ROOT_`, `SUSPENSION_STATE_`, `CACHED_ENT_STATE_`, `TENANT_ID_`, `NAME_`, `START_ACT_ID_`, `START_TIME_`, `START_USER_ID_`, `LOCK_TIME_`, `LOCK_OWNER_`, `IS_COUNT_ENABLED_`, `EVT_SUBSCR_COUNT_`, `TASK_COUNT_`, `JOB_COUNT_`, `TIMER_JOB_COUNT_`, `SUSP_JOB_COUNT_`, `DEADLETTER_JOB_COUNT_`, `EXTERNAL_WORKER_JOB_COUNT_`, `VAR_COUNT_`, `ID_LINK_COUNT_`, `CALLBACK_ID_`, `CALLBACK_TYPE_`, `REFERENCE_ID_`, `REFERENCE_TYPE_`, `PROPAGATED_STAGE_INST_ID_`, `BUSINESS_STATUS_`) VALUES ('28c75a2e-5852-11ee-9923-f22f4b0aefad', 1, '28c75a2e-5852-11ee-9923-f22f4b0aefad', NULL, NULL, 'testvue3:2:1e8d1651-584e-11ee-9923-f22f4b0aefad', NULL, '28c75a2e-5852-11ee-9923-f22f4b0aefad', NULL, 1, 0, 1, 0, 0, 1, NULL, '', NULL, 'startNode1', '2023-09-21 07:40:38.978', '1', NULL, NULL, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `act_ru_execution` (`ID_`, `REV_`, `PROC_INST_ID_`, `BUSINESS_KEY_`, `PARENT_ID_`, `PROC_DEF_ID_`, `SUPER_EXEC_`, `ROOT_PROC_INST_ID_`, `ACT_ID_`, `IS_ACTIVE_`, `IS_CONCURRENT_`, `IS_SCOPE_`, `IS_EVENT_SCOPE_`, `IS_MI_ROOT_`, `SUSPENSION_STATE_`, `CACHED_ENT_STATE_`, `TENANT_ID_`, `NAME_`, `START_ACT_ID_`, `START_TIME_`, `START_USER_ID_`, `LOCK_TIME_`, `LOCK_OWNER_`, `IS_COUNT_ENABLED_`, `EVT_SUBSCR_COUNT_`, `TASK_COUNT_`, `JOB_COUNT_`, `TIMER_JOB_COUNT_`, `SUSP_JOB_COUNT_`, `DEADLETTER_JOB_COUNT_`, `EXTERNAL_WORKER_JOB_COUNT_`, `VAR_COUNT_`, `ID_LINK_COUNT_`, `CALLBACK_ID_`, `CALLBACK_TYPE_`, `REFERENCE_ID_`, `REFERENCE_TYPE_`, `PROPAGATED_STAGE_INST_ID_`, `BUSINESS_STATUS_`) VALUES ('28c75a38-5852-11ee-9923-f22f4b0aefad', 1, '28c75a2e-5852-11ee-9923-f22f4b0aefad', NULL, '28c75a2e-5852-11ee-9923-f22f4b0aefad', 'testvue3:2:1e8d1651-584e-11ee-9923-f22f4b0aefad', NULL, '28c75a2e-5852-11ee-9923-f22f4b0aefad', 'Activity_17esl0a', 1, 0, 0, 0, 0, 1, NULL, '', NULL, NULL, '2023-09-21 07:40:38.978', NULL, NULL, NULL, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `act_ru_execution` (`ID_`, `REV_`, `PROC_INST_ID_`, `BUSINESS_KEY_`, `PARENT_ID_`, `PROC_DEF_ID_`, `SUPER_EXEC_`, `ROOT_PROC_INST_ID_`, `ACT_ID_`, `IS_ACTIVE_`, `IS_CONCURRENT_`, `IS_SCOPE_`, `IS_EVENT_SCOPE_`, `IS_MI_ROOT_`, `SUSPENSION_STATE_`, `CACHED_ENT_STATE_`, `TENANT_ID_`, `NAME_`, `START_ACT_ID_`, `START_TIME_`, `START_USER_ID_`, `LOCK_TIME_`, `LOCK_OWNER_`, `IS_COUNT_ENABLED_`, `EVT_SUBSCR_COUNT_`, `TASK_COUNT_`, `JOB_COUNT_`, `TIMER_JOB_COUNT_`, `SUSP_JOB_COUNT_`, `DEADLETTER_JOB_COUNT_`, `EXTERNAL_WORKER_JOB_COUNT_`, `VAR_COUNT_`, `ID_LINK_COUNT_`, `CALLBACK_ID_`, `CALLBACK_TYPE_`, `REFERENCE_ID_`, `REFERENCE_TYPE_`, `PROPAGATED_STAGE_INST_ID_`, `BUSINESS_STATUS_`) VALUES ('3ef44d28-b340-11ed-9d23-869ef1607803', 1, '3ef44d28-b340-11ed-9d23-869ef1607803', NULL, NULL, 'testoa:16:98955103-b33e-11ed-b511-ce4fe10f37b8', NULL, '3ef44d28-b340-11ed-9d23-869ef1607803', NULL, 1, 0, 1, 0, 0, 1, NULL, '', NULL, 'startNode1', '2023-02-23 06:06:43.383', '1', NULL, NULL, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `act_ru_execution` (`ID_`, `REV_`, `PROC_INST_ID_`, `BUSINESS_KEY_`, `PARENT_ID_`, `PROC_DEF_ID_`, `SUPER_EXEC_`, `ROOT_PROC_INST_ID_`, `ACT_ID_`, `IS_ACTIVE_`, `IS_CONCURRENT_`, `IS_SCOPE_`, `IS_EVENT_SCOPE_`, `IS_MI_ROOT_`, `SUSPENSION_STATE_`, `CACHED_ENT_STATE_`, `TENANT_ID_`, `NAME_`, `START_ACT_ID_`, `START_TIME_`, `START_USER_ID_`, `LOCK_TIME_`, `LOCK_OWNER_`, `IS_COUNT_ENABLED_`, `EVT_SUBSCR_COUNT_`, `TASK_COUNT_`, `JOB_COUNT_`, `TIMER_JOB_COUNT_`, `SUSP_JOB_COUNT_`, `DEADLETTER_JOB_COUNT_`, `EXTERNAL_WORKER_JOB_COUNT_`, `VAR_COUNT_`, `ID_LINK_COUNT_`, `CALLBACK_ID_`, `CALLBACK_TYPE_`, `REFERENCE_ID_`, `REFERENCE_TYPE_`, `PROPAGATED_STAGE_INST_ID_`, `BUSINESS_STATUS_`) VALUES ('3ef44d33-b340-11ed-9d23-869ef1607803', 2, '3ef44d28-b340-11ed-9d23-869ef1607803', NULL, '3ef44d28-b340-11ed-9d23-869ef1607803', 'testoa:16:98955103-b33e-11ed-b511-ce4fe10f37b8', NULL, '3ef44d28-b340-11ed-9d23-869ef1607803', 'Activity_1qfkof6', 1, 0, 0, 0, 0, 1, NULL, '', NULL, NULL, '2023-02-23 06:06:43.383', NULL, NULL, NULL, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `act_ru_execution` (`ID_`, `REV_`, `PROC_INST_ID_`, `BUSINESS_KEY_`, `PARENT_ID_`, `PROC_DEF_ID_`, `SUPER_EXEC_`, `ROOT_PROC_INST_ID_`, `ACT_ID_`, `IS_ACTIVE_`, `IS_CONCURRENT_`, `IS_SCOPE_`, `IS_EVENT_SCOPE_`, `IS_MI_ROOT_`, `SUSPENSION_STATE_`, `CACHED_ENT_STATE_`, `TENANT_ID_`, `NAME_`, `START_ACT_ID_`, `START_TIME_`, `START_USER_ID_`, `LOCK_TIME_`, `LOCK_OWNER_`, `IS_COUNT_ENABLED_`, `EVT_SUBSCR_COUNT_`, `TASK_COUNT_`, `JOB_COUNT_`, `TIMER_JOB_COUNT_`, `SUSP_JOB_COUNT_`, `DEADLETTER_JOB_COUNT_`, `EXTERNAL_WORKER_JOB_COUNT_`, `VAR_COUNT_`, `ID_LINK_COUNT_`, `CALLBACK_ID_`, `CALLBACK_TYPE_`, `REFERENCE_ID_`, `REFERENCE_TYPE_`, `PROPAGATED_STAGE_INST_ID_`, `BUSINESS_STATUS_`) VALUES ('4125bf0e-584e-11ee-9923-f22f4b0aefad', 1, '4125bf0e-584e-11ee-9923-f22f4b0aefad', NULL, NULL, 'testvue3:2:1e8d1651-584e-11ee-9923-f22f4b0aefad', NULL, '4125bf0e-584e-11ee-9923-f22f4b0aefad', NULL, 1, 0, 1, 0, 0, 1, NULL, '', NULL, 'startNode1', '2023-09-21 07:12:41.875', '1', NULL, NULL, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `act_ru_execution` (`ID_`, `REV_`, `PROC_INST_ID_`, `BUSINESS_KEY_`, `PARENT_ID_`, `PROC_DEF_ID_`, `SUPER_EXEC_`, `ROOT_PROC_INST_ID_`, `ACT_ID_`, `IS_ACTIVE_`, `IS_CONCURRENT_`, `IS_SCOPE_`, `IS_EVENT_SCOPE_`, `IS_MI_ROOT_`, `SUSPENSION_STATE_`, `CACHED_ENT_STATE_`, `TENANT_ID_`, `NAME_`, `START_ACT_ID_`, `START_TIME_`, `START_USER_ID_`, `LOCK_TIME_`, `LOCK_OWNER_`, `IS_COUNT_ENABLED_`, `EVT_SUBSCR_COUNT_`, `TASK_COUNT_`, `JOB_COUNT_`, `TIMER_JOB_COUNT_`, `SUSP_JOB_COUNT_`, `DEADLETTER_JOB_COUNT_`, `EXTERNAL_WORKER_JOB_COUNT_`, `VAR_COUNT_`, `ID_LINK_COUNT_`, `CALLBACK_ID_`, `CALLBACK_TYPE_`, `REFERENCE_ID_`, `REFERENCE_TYPE_`, `PROPAGATED_STAGE_INST_ID_`, `BUSINESS_STATUS_`) VALUES ('4125bf15-584e-11ee-9923-f22f4b0aefad', 1, '4125bf0e-584e-11ee-9923-f22f4b0aefad', NULL, '4125bf0e-584e-11ee-9923-f22f4b0aefad', 'testvue3:2:1e8d1651-584e-11ee-9923-f22f4b0aefad', NULL, '4125bf0e-584e-11ee-9923-f22f4b0aefad', 'Activity_17esl0a', 1, 0, 0, 0, 0, 1, NULL, '', NULL, NULL, '2023-09-21 07:12:41.875', NULL, NULL, NULL, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `act_ru_execution` (`ID_`, `REV_`, `PROC_INST_ID_`, `BUSINESS_KEY_`, `PARENT_ID_`, `PROC_DEF_ID_`, `SUPER_EXEC_`, `ROOT_PROC_INST_ID_`, `ACT_ID_`, `IS_ACTIVE_`, `IS_CONCURRENT_`, `IS_SCOPE_`, `IS_EVENT_SCOPE_`, `IS_MI_ROOT_`, `SUSPENSION_STATE_`, `CACHED_ENT_STATE_`, `TENANT_ID_`, `NAME_`, `START_ACT_ID_`, `START_TIME_`, `START_USER_ID_`, `LOCK_TIME_`, `LOCK_OWNER_`, `IS_COUNT_ENABLED_`, `EVT_SUBSCR_COUNT_`, `TASK_COUNT_`, `JOB_COUNT_`, `TIMER_JOB_COUNT_`, `SUSP_JOB_COUNT_`, `DEADLETTER_JOB_COUNT_`, `EXTERNAL_WORKER_JOB_COUNT_`, `VAR_COUNT_`, `ID_LINK_COUNT_`, `CALLBACK_ID_`, `CALLBACK_TYPE_`, `REFERENCE_ID_`, `REFERENCE_TYPE_`, `PROPAGATED_STAGE_INST_ID_`, `BUSINESS_STATUS_`) VALUES ('65359e7a-584e-11ee-9923-f22f4b0aefad', 1, '65359e7a-584e-11ee-9923-f22f4b0aefad', NULL, NULL, 'testvue3:2:1e8d1651-584e-11ee-9923-f22f4b0aefad', NULL, '65359e7a-584e-11ee-9923-f22f4b0aefad', NULL, 1, 0, 1, 0, 0, 1, NULL, '', NULL, 'startNode1', '2023-09-21 07:13:42.377', '1', NULL, NULL, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `act_ru_execution` (`ID_`, `REV_`, `PROC_INST_ID_`, `BUSINESS_KEY_`, `PARENT_ID_`, `PROC_DEF_ID_`, `SUPER_EXEC_`, `ROOT_PROC_INST_ID_`, `ACT_ID_`, `IS_ACTIVE_`, `IS_CONCURRENT_`, `IS_SCOPE_`, `IS_EVENT_SCOPE_`, `IS_MI_ROOT_`, `SUSPENSION_STATE_`, `CACHED_ENT_STATE_`, `TENANT_ID_`, `NAME_`, `START_ACT_ID_`, `START_TIME_`, `START_USER_ID_`, `LOCK_TIME_`, `LOCK_OWNER_`, `IS_COUNT_ENABLED_`, `EVT_SUBSCR_COUNT_`, `TASK_COUNT_`, `JOB_COUNT_`, `TIMER_JOB_COUNT_`, `SUSP_JOB_COUNT_`, `DEADLETTER_JOB_COUNT_`, `EXTERNAL_WORKER_JOB_COUNT_`, `VAR_COUNT_`, `ID_LINK_COUNT_`, `CALLBACK_ID_`, `CALLBACK_TYPE_`, `REFERENCE_ID_`, `REFERENCE_TYPE_`, `PROPAGATED_STAGE_INST_ID_`, `BUSINESS_STATUS_`) VALUES ('65359e81-584e-11ee-9923-f22f4b0aefad', 1, '65359e7a-584e-11ee-9923-f22f4b0aefad', NULL, '65359e7a-584e-11ee-9923-f22f4b0aefad', 'testvue3:2:1e8d1651-584e-11ee-9923-f22f4b0aefad', NULL, '65359e7a-584e-11ee-9923-f22f4b0aefad', 'Activity_17esl0a', 1, 0, 0, 0, 0, 1, NULL, '', NULL, NULL, '2023-09-21 07:13:42.377', NULL, NULL, NULL, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `act_ru_execution` (`ID_`, `REV_`, `PROC_INST_ID_`, `BUSINESS_KEY_`, `PARENT_ID_`, `PROC_DEF_ID_`, `SUPER_EXEC_`, `ROOT_PROC_INST_ID_`, `ACT_ID_`, `IS_ACTIVE_`, `IS_CONCURRENT_`, `IS_SCOPE_`, `IS_EVENT_SCOPE_`, `IS_MI_ROOT_`, `SUSPENSION_STATE_`, `CACHED_ENT_STATE_`, `TENANT_ID_`, `NAME_`, `START_ACT_ID_`, `START_TIME_`, `START_USER_ID_`, `LOCK_TIME_`, `LOCK_OWNER_`, `IS_COUNT_ENABLED_`, `EVT_SUBSCR_COUNT_`, `TASK_COUNT_`, `JOB_COUNT_`, `TIMER_JOB_COUNT_`, `SUSP_JOB_COUNT_`, `DEADLETTER_JOB_COUNT_`, `EXTERNAL_WORKER_JOB_COUNT_`, `VAR_COUNT_`, `ID_LINK_COUNT_`, `CALLBACK_ID_`, `CALLBACK_TYPE_`, `REFERENCE_ID_`, `REFERENCE_TYPE_`, `PROPAGATED_STAGE_INST_ID_`, `BUSINESS_STATUS_`) VALUES ('b7a5dd82-5851-11ee-9923-f22f4b0aefad', 1, 'b7a5dd82-5851-11ee-9923-f22f4b0aefad', NULL, NULL, 'testvue3:2:1e8d1651-584e-11ee-9923-f22f4b0aefad', NULL, 'b7a5dd82-5851-11ee-9923-f22f4b0aefad', NULL, 1, 0, 1, 0, 0, 1, NULL, '', NULL, 'startNode1', '2023-09-21 07:37:29.176', '1', NULL, NULL, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `act_ru_execution` (`ID_`, `REV_`, `PROC_INST_ID_`, `BUSINESS_KEY_`, `PARENT_ID_`, `PROC_DEF_ID_`, `SUPER_EXEC_`, `ROOT_PROC_INST_ID_`, `ACT_ID_`, `IS_ACTIVE_`, `IS_CONCURRENT_`, `IS_SCOPE_`, `IS_EVENT_SCOPE_`, `IS_MI_ROOT_`, `SUSPENSION_STATE_`, `CACHED_ENT_STATE_`, `TENANT_ID_`, `NAME_`, `START_ACT_ID_`, `START_TIME_`, `START_USER_ID_`, `LOCK_TIME_`, `LOCK_OWNER_`, `IS_COUNT_ENABLED_`, `EVT_SUBSCR_COUNT_`, `TASK_COUNT_`, `JOB_COUNT_`, `TIMER_JOB_COUNT_`, `SUSP_JOB_COUNT_`, `DEADLETTER_JOB_COUNT_`, `EXTERNAL_WORKER_JOB_COUNT_`, `VAR_COUNT_`, `ID_LINK_COUNT_`, `CALLBACK_ID_`, `CALLBACK_TYPE_`, `REFERENCE_ID_`, `REFERENCE_TYPE_`, `PROPAGATED_STAGE_INST_ID_`, `BUSINESS_STATUS_`) VALUES ('b7a60499-5851-11ee-9923-f22f4b0aefad', 1, 'b7a5dd82-5851-11ee-9923-f22f4b0aefad', NULL, 'b7a5dd82-5851-11ee-9923-f22f4b0aefad', 'testvue3:2:1e8d1651-584e-11ee-9923-f22f4b0aefad', NULL, 'b7a5dd82-5851-11ee-9923-f22f4b0aefad', 'Activity_17esl0a', 1, 0, 0, 0, 0, 1, NULL, '', NULL, NULL, '2023-09-21 07:37:29.177', NULL, NULL, NULL, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `act_ru_execution` (`ID_`, `REV_`, `PROC_INST_ID_`, `BUSINESS_KEY_`, `PARENT_ID_`, `PROC_DEF_ID_`, `SUPER_EXEC_`, `ROOT_PROC_INST_ID_`, `ACT_ID_`, `IS_ACTIVE_`, `IS_CONCURRENT_`, `IS_SCOPE_`, `IS_EVENT_SCOPE_`, `IS_MI_ROOT_`, `SUSPENSION_STATE_`, `CACHED_ENT_STATE_`, `TENANT_ID_`, `NAME_`, `START_ACT_ID_`, `START_TIME_`, `START_USER_ID_`, `LOCK_TIME_`, `LOCK_OWNER_`, `IS_COUNT_ENABLED_`, `EVT_SUBSCR_COUNT_`, `TASK_COUNT_`, `JOB_COUNT_`, `TIMER_JOB_COUNT_`, `SUSP_JOB_COUNT_`, `DEADLETTER_JOB_COUNT_`, `EXTERNAL_WORKER_JOB_COUNT_`, `VAR_COUNT_`, `ID_LINK_COUNT_`, `CALLBACK_ID_`, `CALLBACK_TYPE_`, `REFERENCE_ID_`, `REFERENCE_TYPE_`, `PROPAGATED_STAGE_INST_ID_`, `BUSINESS_STATUS_`) VALUES ('b8058c96-b345-11ed-8617-ce4fe10f37b8', 1, 'b8058c96-b345-11ed-8617-ce4fe10f37b8', NULL, NULL, 'testoa:16:98955103-b33e-11ed-b511-ce4fe10f37b8', NULL, 'b8058c96-b345-11ed-8617-ce4fe10f37b8', NULL, 1, 0, 1, 0, 0, 1, NULL, '', NULL, 'startNode1', '2023-02-23 06:45:53.984', '1', NULL, NULL, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `act_ru_execution` (`ID_`, `REV_`, `PROC_INST_ID_`, `BUSINESS_KEY_`, `PARENT_ID_`, `PROC_DEF_ID_`, `SUPER_EXEC_`, `ROOT_PROC_INST_ID_`, `ACT_ID_`, `IS_ACTIVE_`, `IS_CONCURRENT_`, `IS_SCOPE_`, `IS_EVENT_SCOPE_`, `IS_MI_ROOT_`, `SUSPENSION_STATE_`, `CACHED_ENT_STATE_`, `TENANT_ID_`, `NAME_`, `START_ACT_ID_`, `START_TIME_`, `START_USER_ID_`, `LOCK_TIME_`, `LOCK_OWNER_`, `IS_COUNT_ENABLED_`, `EVT_SUBSCR_COUNT_`, `TASK_COUNT_`, `JOB_COUNT_`, `TIMER_JOB_COUNT_`, `SUSP_JOB_COUNT_`, `DEADLETTER_JOB_COUNT_`, `EXTERNAL_WORKER_JOB_COUNT_`, `VAR_COUNT_`, `ID_LINK_COUNT_`, `CALLBACK_ID_`, `CALLBACK_TYPE_`, `REFERENCE_ID_`, `REFERENCE_TYPE_`, `PROPAGATED_STAGE_INST_ID_`, `BUSINESS_STATUS_`) VALUES ('b8073a51-b345-11ed-8617-ce4fe10f37b8', 1, 'b8058c96-b345-11ed-8617-ce4fe10f37b8', NULL, 'b8058c96-b345-11ed-8617-ce4fe10f37b8', 'testoa:16:98955103-b33e-11ed-b511-ce4fe10f37b8', NULL, 'b8058c96-b345-11ed-8617-ce4fe10f37b8', 'Activity_1qo8esf', 1, 0, 0, 0, 0, 1, NULL, '', NULL, NULL, '2023-02-23 06:45:53.995', NULL, NULL, NULL, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `act_ru_execution` (`ID_`, `REV_`, `PROC_INST_ID_`, `BUSINESS_KEY_`, `PARENT_ID_`, `PROC_DEF_ID_`, `SUPER_EXEC_`, `ROOT_PROC_INST_ID_`, `ACT_ID_`, `IS_ACTIVE_`, `IS_CONCURRENT_`, `IS_SCOPE_`, `IS_EVENT_SCOPE_`, `IS_MI_ROOT_`, `SUSPENSION_STATE_`, `CACHED_ENT_STATE_`, `TENANT_ID_`, `NAME_`, `START_ACT_ID_`, `START_TIME_`, `START_USER_ID_`, `LOCK_TIME_`, `LOCK_OWNER_`, `IS_COUNT_ENABLED_`, `EVT_SUBSCR_COUNT_`, `TASK_COUNT_`, `JOB_COUNT_`, `TIMER_JOB_COUNT_`, `SUSP_JOB_COUNT_`, `DEADLETTER_JOB_COUNT_`, `EXTERNAL_WORKER_JOB_COUNT_`, `VAR_COUNT_`, `ID_LINK_COUNT_`, `CALLBACK_ID_`, `CALLBACK_TYPE_`, `REFERENCE_ID_`, `REFERENCE_TYPE_`, `PROPAGATED_STAGE_INST_ID_`, `BUSINESS_STATUS_`) VALUES ('d48d87ed-b33f-11ed-9d23-869ef1607803', 1, 'd48d87ed-b33f-11ed-9d23-869ef1607803', NULL, NULL, 'testoa:16:98955103-b33e-11ed-b511-ce4fe10f37b8', NULL, 'd48d87ed-b33f-11ed-9d23-869ef1607803', NULL, 1, 0, 1, 0, 0, 1, NULL, '', NULL, 'startNode1', '2023-02-23 06:03:44.871', '1', NULL, NULL, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `act_ru_execution` (`ID_`, `REV_`, `PROC_INST_ID_`, `BUSINESS_KEY_`, `PARENT_ID_`, `PROC_DEF_ID_`, `SUPER_EXEC_`, `ROOT_PROC_INST_ID_`, `ACT_ID_`, `IS_ACTIVE_`, `IS_CONCURRENT_`, `IS_SCOPE_`, `IS_EVENT_SCOPE_`, `IS_MI_ROOT_`, `SUSPENSION_STATE_`, `CACHED_ENT_STATE_`, `TENANT_ID_`, `NAME_`, `START_ACT_ID_`, `START_TIME_`, `START_USER_ID_`, `LOCK_TIME_`, `LOCK_OWNER_`, `IS_COUNT_ENABLED_`, `EVT_SUBSCR_COUNT_`, `TASK_COUNT_`, `JOB_COUNT_`, `TIMER_JOB_COUNT_`, `SUSP_JOB_COUNT_`, `DEADLETTER_JOB_COUNT_`, `EXTERNAL_WORKER_JOB_COUNT_`, `VAR_COUNT_`, `ID_LINK_COUNT_`, `CALLBACK_ID_`, `CALLBACK_TYPE_`, `REFERENCE_ID_`, `REFERENCE_TYPE_`, `PROPAGATED_STAGE_INST_ID_`, `BUSINESS_STATUS_`) VALUES ('d48e7258-b33f-11ed-9d23-869ef1607803', 2, 'd48d87ed-b33f-11ed-9d23-869ef1607803', NULL, 'd48d87ed-b33f-11ed-9d23-869ef1607803', 'testoa:16:98955103-b33e-11ed-b511-ce4fe10f37b8', NULL, 'd48d87ed-b33f-11ed-9d23-869ef1607803', 'Activity_1qfkof6', 1, 0, 0, 0, 0, 1, NULL, '', NULL, NULL, '2023-02-23 06:03:44.877', NULL, NULL, NULL, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `act_ru_execution` (`ID_`, `REV_`, `PROC_INST_ID_`, `BUSINESS_KEY_`, `PARENT_ID_`, `PROC_DEF_ID_`, `SUPER_EXEC_`, `ROOT_PROC_INST_ID_`, `ACT_ID_`, `IS_ACTIVE_`, `IS_CONCURRENT_`, `IS_SCOPE_`, `IS_EVENT_SCOPE_`, `IS_MI_ROOT_`, `SUSPENSION_STATE_`, `CACHED_ENT_STATE_`, `TENANT_ID_`, `NAME_`, `START_ACT_ID_`, `START_TIME_`, `START_USER_ID_`, `LOCK_TIME_`, `LOCK_OWNER_`, `IS_COUNT_ENABLED_`, `EVT_SUBSCR_COUNT_`, `TASK_COUNT_`, `JOB_COUNT_`, `TIMER_JOB_COUNT_`, `SUSP_JOB_COUNT_`, `DEADLETTER_JOB_COUNT_`, `EXTERNAL_WORKER_JOB_COUNT_`, `VAR_COUNT_`, `ID_LINK_COUNT_`, `CALLBACK_ID_`, `CALLBACK_TYPE_`, `REFERENCE_ID_`, `REFERENCE_TYPE_`, `PROPAGATED_STAGE_INST_ID_`, `BUSINESS_STATUS_`) VALUES ('ede26906-5850-11ee-9923-f22f4b0aefad', 1, 'ede26906-5850-11ee-9923-f22f4b0aefad', NULL, NULL, 'testvue3:2:1e8d1651-584e-11ee-9923-f22f4b0aefad', NULL, 'ede26906-5850-11ee-9923-f22f4b0aefad', NULL, 1, 0, 1, 0, 0, 1, NULL, '', NULL, 'startNode1', '2023-09-21 07:31:50.673', '1', NULL, NULL, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `act_ru_execution` (`ID_`, `REV_`, `PROC_INST_ID_`, `BUSINESS_KEY_`, `PARENT_ID_`, `PROC_DEF_ID_`, `SUPER_EXEC_`, `ROOT_PROC_INST_ID_`, `ACT_ID_`, `IS_ACTIVE_`, `IS_CONCURRENT_`, `IS_SCOPE_`, `IS_EVENT_SCOPE_`, `IS_MI_ROOT_`, `SUSPENSION_STATE_`, `CACHED_ENT_STATE_`, `TENANT_ID_`, `NAME_`, `START_ACT_ID_`, `START_TIME_`, `START_USER_ID_`, `LOCK_TIME_`, `LOCK_OWNER_`, `IS_COUNT_ENABLED_`, `EVT_SUBSCR_COUNT_`, `TASK_COUNT_`, `JOB_COUNT_`, `TIMER_JOB_COUNT_`, `SUSP_JOB_COUNT_`, `DEADLETTER_JOB_COUNT_`, `EXTERNAL_WORKER_JOB_COUNT_`, `VAR_COUNT_`, `ID_LINK_COUNT_`, `CALLBACK_ID_`, `CALLBACK_TYPE_`, `REFERENCE_ID_`, `REFERENCE_TYPE_`, `PROPAGATED_STAGE_INST_ID_`, `BUSINESS_STATUS_`) VALUES ('ede2b72d-5850-11ee-9923-f22f4b0aefad', 1, 'ede26906-5850-11ee-9923-f22f4b0aefad', NULL, 'ede26906-5850-11ee-9923-f22f4b0aefad', 'testvue3:2:1e8d1651-584e-11ee-9923-f22f4b0aefad', NULL, 'ede26906-5850-11ee-9923-f22f4b0aefad', 'Activity_17esl0a', 1, 0, 0, 0, 0, 1, NULL, '', NULL, NULL, '2023-09-21 07:31:50.675', NULL, NULL, NULL, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `act_ru_execution` (`ID_`, `REV_`, `PROC_INST_ID_`, `BUSINESS_KEY_`, `PARENT_ID_`, `PROC_DEF_ID_`, `SUPER_EXEC_`, `ROOT_PROC_INST_ID_`, `ACT_ID_`, `IS_ACTIVE_`, `IS_CONCURRENT_`, `IS_SCOPE_`, `IS_EVENT_SCOPE_`, `IS_MI_ROOT_`, `SUSPENSION_STATE_`, `CACHED_ENT_STATE_`, `TENANT_ID_`, `NAME_`, `START_ACT_ID_`, `START_TIME_`, `START_USER_ID_`, `LOCK_TIME_`, `LOCK_OWNER_`, `IS_COUNT_ENABLED_`, `EVT_SUBSCR_COUNT_`, `TASK_COUNT_`, `JOB_COUNT_`, `TIMER_JOB_COUNT_`, `SUSP_JOB_COUNT_`, `DEADLETTER_JOB_COUNT_`, `EXTERNAL_WORKER_JOB_COUNT_`, `VAR_COUNT_`, `ID_LINK_COUNT_`, `CALLBACK_ID_`, `CALLBACK_TYPE_`, `REFERENCE_ID_`, `REFERENCE_TYPE_`, `PROPAGATED_STAGE_INST_ID_`, `BUSINESS_STATUS_`) VALUES ('ff6d67b2-584d-11ee-9923-f22f4b0aefad', 1, 'ff6d67b2-584d-11ee-9923-f22f4b0aefad', NULL, NULL, 'testvue3:1:2aea33f1-56c2-11ee-ae41-f22f4b0aefad', NULL, 'ff6d67b2-584d-11ee-9923-f22f4b0aefad', NULL, 1, 0, 1, 0, 0, 1, NULL, '', NULL, 'startNode1', '2023-09-21 07:10:51.615', '1', NULL, NULL, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `act_ru_execution` (`ID_`, `REV_`, `PROC_INST_ID_`, `BUSINESS_KEY_`, `PARENT_ID_`, `PROC_DEF_ID_`, `SUPER_EXEC_`, `ROOT_PROC_INST_ID_`, `ACT_ID_`, `IS_ACTIVE_`, `IS_CONCURRENT_`, `IS_SCOPE_`, `IS_EVENT_SCOPE_`, `IS_MI_ROOT_`, `SUSPENSION_STATE_`, `CACHED_ENT_STATE_`, `TENANT_ID_`, `NAME_`, `START_ACT_ID_`, `START_TIME_`, `START_USER_ID_`, `LOCK_TIME_`, `LOCK_OWNER_`, `IS_COUNT_ENABLED_`, `EVT_SUBSCR_COUNT_`, `TASK_COUNT_`, `JOB_COUNT_`, `TIMER_JOB_COUNT_`, `SUSP_JOB_COUNT_`, `DEADLETTER_JOB_COUNT_`, `EXTERNAL_WORKER_JOB_COUNT_`, `VAR_COUNT_`, `ID_LINK_COUNT_`, `CALLBACK_ID_`, `CALLBACK_TYPE_`, `REFERENCE_ID_`, `REFERENCE_TYPE_`, `PROPAGATED_STAGE_INST_ID_`, `BUSINESS_STATUS_`) VALUES ('ff6e5219-584d-11ee-9923-f22f4b0aefad', 1, 'ff6d67b2-584d-11ee-9923-f22f4b0aefad', NULL, 'ff6d67b2-584d-11ee-9923-f22f4b0aefad', 'testvue3:1:2aea33f1-56c2-11ee-ae41-f22f4b0aefad', NULL, 'ff6d67b2-584d-11ee-9923-f22f4b0aefad', 'Activity_17esl0a', 1, 0, 0, 0, 0, 1, NULL, '', NULL, NULL, '2023-09-21 07:10:51.621', NULL, NULL, NULL, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for act_ru_external_job
-- ----------------------------
DROP TABLE IF EXISTS `act_ru_external_job`;
CREATE TABLE `act_ru_external_job` (
                                       `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                       `REV_` int DEFAULT NULL,
                                       `CATEGORY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                       `TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
                                       `LOCK_EXP_TIME_` timestamp(3) NULL DEFAULT NULL,
                                       `LOCK_OWNER_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                       `EXCLUSIVE_` tinyint(1) DEFAULT NULL,
                                       `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                       `PROCESS_INSTANCE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                       `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                       `ELEMENT_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                       `ELEMENT_NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                       `SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                       `SUB_SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                       `SCOPE_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                       `SCOPE_DEFINITION_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                       `CORRELATION_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                       `RETRIES_` int DEFAULT NULL,
                                       `EXCEPTION_STACK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                       `EXCEPTION_MSG_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
                                       `DUEDATE_` timestamp(3) NULL DEFAULT NULL,
                                       `REPEAT_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                       `HANDLER_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                       `HANDLER_CFG_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
                                       `CUSTOM_VALUES_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                       `CREATE_TIME_` timestamp(3) NULL DEFAULT NULL,
                                       `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
                                       PRIMARY KEY (`ID_`),
                                       KEY `ACT_IDX_EXTERNAL_JOB_EXCEPTION_STACK_ID` (`EXCEPTION_STACK_ID_`),
                                       KEY `ACT_IDX_EXTERNAL_JOB_CUSTOM_VALUES_ID` (`CUSTOM_VALUES_ID_`),
                                       KEY `ACT_IDX_EXTERNAL_JOB_CORRELATION_ID` (`CORRELATION_ID_`),
                                       KEY `ACT_IDX_EJOB_SCOPE` (`SCOPE_ID_`,`SCOPE_TYPE_`),
                                       KEY `ACT_IDX_EJOB_SUB_SCOPE` (`SUB_SCOPE_ID_`,`SCOPE_TYPE_`),
                                       KEY `ACT_IDX_EJOB_SCOPE_DEF` (`SCOPE_DEFINITION_ID_`,`SCOPE_TYPE_`),
                                       CONSTRAINT `ACT_FK_EXTERNAL_JOB_CUSTOM_VALUES` FOREIGN KEY (`CUSTOM_VALUES_ID_`) REFERENCES `act_ge_bytearray` (`ID_`),
                                       CONSTRAINT `ACT_FK_EXTERNAL_JOB_EXCEPTION` FOREIGN KEY (`EXCEPTION_STACK_ID_`) REFERENCES `act_ge_bytearray` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_ru_external_job
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for act_ru_history_job
-- ----------------------------
DROP TABLE IF EXISTS `act_ru_history_job`;
CREATE TABLE `act_ru_history_job` (
                                      `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                      `REV_` int DEFAULT NULL,
                                      `LOCK_EXP_TIME_` timestamp(3) NULL DEFAULT NULL,
                                      `LOCK_OWNER_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                      `RETRIES_` int DEFAULT NULL,
                                      `EXCEPTION_STACK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                      `EXCEPTION_MSG_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
                                      `HANDLER_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                      `HANDLER_CFG_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
                                      `CUSTOM_VALUES_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                      `ADV_HANDLER_CFG_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                      `CREATE_TIME_` timestamp(3) NULL DEFAULT NULL,
                                      `SCOPE_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                      `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
                                      PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_ru_history_job
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for act_ru_identitylink
-- ----------------------------
DROP TABLE IF EXISTS `act_ru_identitylink`;
CREATE TABLE `act_ru_identitylink` (
                                       `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                       `REV_` int DEFAULT NULL,
                                       `GROUP_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                       `TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                       `USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                       `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                       `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                       `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                       `SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                       `SUB_SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                       `SCOPE_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                       `SCOPE_DEFINITION_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                       PRIMARY KEY (`ID_`),
                                       KEY `ACT_IDX_IDENT_LNK_USER` (`USER_ID_`),
                                       KEY `ACT_IDX_IDENT_LNK_GROUP` (`GROUP_ID_`),
                                       KEY `ACT_IDX_IDENT_LNK_SCOPE` (`SCOPE_ID_`,`SCOPE_TYPE_`),
                                       KEY `ACT_IDX_IDENT_LNK_SUB_SCOPE` (`SUB_SCOPE_ID_`,`SCOPE_TYPE_`),
                                       KEY `ACT_IDX_IDENT_LNK_SCOPE_DEF` (`SCOPE_DEFINITION_ID_`,`SCOPE_TYPE_`),
                                       KEY `ACT_IDX_ATHRZ_PROCEDEF` (`PROC_DEF_ID_`),
                                       KEY `ACT_FK_TSKASS_TASK` (`TASK_ID_`),
                                       KEY `ACT_FK_IDL_PROCINST` (`PROC_INST_ID_`),
                                       CONSTRAINT `ACT_FK_ATHRZ_PROCEDEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `act_re_procdef` (`ID_`),
                                       CONSTRAINT `ACT_FK_IDL_PROCINST` FOREIGN KEY (`PROC_INST_ID_`) REFERENCES `act_ru_execution` (`ID_`),
                                       CONSTRAINT `ACT_FK_TSKASS_TASK` FOREIGN KEY (`TASK_ID_`) REFERENCES `act_ru_task` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_ru_identitylink
-- ----------------------------
BEGIN;
INSERT INTO `act_ru_identitylink` (`ID_`, `REV_`, `GROUP_ID_`, `TYPE_`, `USER_ID_`, `TASK_ID_`, `PROC_INST_ID_`, `PROC_DEF_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `SCOPE_DEFINITION_ID_`) VALUES ('11884c90-b33f-11ed-b511-ce4fe10f37b8', 1, NULL, 'starter', '1', NULL, '11884c8f-b33f-11ed-b511-ce4fe10f37b8', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `act_ru_identitylink` (`ID_`, `REV_`, `GROUP_ID_`, `TYPE_`, `USER_ID_`, `TASK_ID_`, `PROC_INST_ID_`, `PROC_DEF_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `SCOPE_DEFINITION_ID_`) VALUES ('20f5ed10-b340-11ed-9d23-869ef1607803', 1, NULL, 'participant', '1', NULL, '11884c8f-b33f-11ed-b511-ce4fe10f37b8', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `act_ru_identitylink` (`ID_`, `REV_`, `GROUP_ID_`, `TYPE_`, `USER_ID_`, `TASK_ID_`, `PROC_INST_ID_`, `PROC_DEF_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `SCOPE_DEFINITION_ID_`) VALUES ('23cbb544-584e-11ee-9923-f22f4b0aefad', 1, NULL, 'starter', '1', NULL, '23cbb542-584e-11ee-9923-f22f4b0aefad', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `act_ru_identitylink` (`ID_`, `REV_`, `GROUP_ID_`, `TYPE_`, `USER_ID_`, `TASK_ID_`, `PROC_INST_ID_`, `PROC_DEF_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `SCOPE_DEFINITION_ID_`) VALUES ('28c75a30-5852-11ee-9923-f22f4b0aefad', 1, NULL, 'starter', '1', NULL, '28c75a2e-5852-11ee-9923-f22f4b0aefad', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `act_ru_identitylink` (`ID_`, `REV_`, `GROUP_ID_`, `TYPE_`, `USER_ID_`, `TASK_ID_`, `PROC_INST_ID_`, `PROC_DEF_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `SCOPE_DEFINITION_ID_`) VALUES ('3ef44d29-b340-11ed-9d23-869ef1607803', 1, NULL, 'starter', '1', NULL, '3ef44d28-b340-11ed-9d23-869ef1607803', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `act_ru_identitylink` (`ID_`, `REV_`, `GROUP_ID_`, `TYPE_`, `USER_ID_`, `TASK_ID_`, `PROC_INST_ID_`, `PROC_DEF_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `SCOPE_DEFINITION_ID_`) VALUES ('3f011e7b-b340-11ed-9d23-869ef1607803', 1, NULL, 'participant', '1', NULL, '3ef44d28-b340-11ed-9d23-869ef1607803', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `act_ru_identitylink` (`ID_`, `REV_`, `GROUP_ID_`, `TYPE_`, `USER_ID_`, `TASK_ID_`, `PROC_INST_ID_`, `PROC_DEF_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `SCOPE_DEFINITION_ID_`) VALUES ('4125bf10-584e-11ee-9923-f22f4b0aefad', 1, NULL, 'starter', '1', NULL, '4125bf0e-584e-11ee-9923-f22f4b0aefad', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `act_ru_identitylink` (`ID_`, `REV_`, `GROUP_ID_`, `TYPE_`, `USER_ID_`, `TASK_ID_`, `PROC_INST_ID_`, `PROC_DEF_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `SCOPE_DEFINITION_ID_`) VALUES ('65359e7c-584e-11ee-9923-f22f4b0aefad', 1, NULL, 'starter', '1', NULL, '65359e7a-584e-11ee-9923-f22f4b0aefad', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `act_ru_identitylink` (`ID_`, `REV_`, `GROUP_ID_`, `TYPE_`, `USER_ID_`, `TASK_ID_`, `PROC_INST_ID_`, `PROC_DEF_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `SCOPE_DEFINITION_ID_`) VALUES ('b7a5dd84-5851-11ee-9923-f22f4b0aefad', 1, NULL, 'starter', '1', NULL, 'b7a5dd82-5851-11ee-9923-f22f4b0aefad', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `act_ru_identitylink` (`ID_`, `REV_`, `GROUP_ID_`, `TYPE_`, `USER_ID_`, `TASK_ID_`, `PROC_INST_ID_`, `PROC_DEF_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `SCOPE_DEFINITION_ID_`) VALUES ('b805b3a7-b345-11ed-8617-ce4fe10f37b8', 1, NULL, 'starter', '1', NULL, 'b8058c96-b345-11ed-8617-ce4fe10f37b8', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `act_ru_identitylink` (`ID_`, `REV_`, `GROUP_ID_`, `TYPE_`, `USER_ID_`, `TASK_ID_`, `PROC_INST_ID_`, `PROC_DEF_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `SCOPE_DEFINITION_ID_`) VALUES ('b80b31f6-b345-11ed-8617-ce4fe10f37b8', 1, '641845124569108480', 'candidate', NULL, 'b80abcc5-b345-11ed-8617-ce4fe10f37b8', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `act_ru_identitylink` (`ID_`, `REV_`, `GROUP_ID_`, `TYPE_`, `USER_ID_`, `TASK_ID_`, `PROC_INST_ID_`, `PROC_DEF_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `SCOPE_DEFINITION_ID_`) VALUES ('b80b5907-b345-11ed-8617-ce4fe10f37b8', 1, '1', 'candidate', NULL, 'b80abcc5-b345-11ed-8617-ce4fe10f37b8', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `act_ru_identitylink` (`ID_`, `REV_`, `GROUP_ID_`, `TYPE_`, `USER_ID_`, `TASK_ID_`, `PROC_INST_ID_`, `PROC_DEF_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `SCOPE_DEFINITION_ID_`) VALUES ('d48daefe-b33f-11ed-9d23-869ef1607803', 1, NULL, 'starter', '1', NULL, 'd48d87ed-b33f-11ed-9d23-869ef1607803', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `act_ru_identitylink` (`ID_`, `REV_`, `GROUP_ID_`, `TYPE_`, `USER_ID_`, `TASK_ID_`, `PROC_INST_ID_`, `PROC_DEF_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `SCOPE_DEFINITION_ID_`) VALUES ('d4aef2b0-b33f-11ed-9d23-869ef1607803', 1, NULL, 'participant', '1', NULL, 'd48d87ed-b33f-11ed-9d23-869ef1607803', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `act_ru_identitylink` (`ID_`, `REV_`, `GROUP_ID_`, `TYPE_`, `USER_ID_`, `TASK_ID_`, `PROC_INST_ID_`, `PROC_DEF_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `SCOPE_DEFINITION_ID_`) VALUES ('ede26908-5850-11ee-9923-f22f4b0aefad', 1, NULL, 'starter', '1', NULL, 'ede26906-5850-11ee-9923-f22f4b0aefad', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `act_ru_identitylink` (`ID_`, `REV_`, `GROUP_ID_`, `TYPE_`, `USER_ID_`, `TASK_ID_`, `PROC_INST_ID_`, `PROC_DEF_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `SCOPE_DEFINITION_ID_`) VALUES ('ff6db5d4-584d-11ee-9923-f22f4b0aefad', 1, NULL, 'starter', '1', NULL, 'ff6d67b2-584d-11ee-9923-f22f4b0aefad', NULL, NULL, NULL, NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for act_ru_job
-- ----------------------------
DROP TABLE IF EXISTS `act_ru_job`;
CREATE TABLE `act_ru_job` (
                              `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                              `REV_` int DEFAULT NULL,
                              `CATEGORY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                              `TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
                              `LOCK_EXP_TIME_` timestamp(3) NULL DEFAULT NULL,
                              `LOCK_OWNER_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                              `EXCLUSIVE_` tinyint(1) DEFAULT NULL,
                              `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                              `PROCESS_INSTANCE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                              `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                              `ELEMENT_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                              `ELEMENT_NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                              `SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                              `SUB_SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                              `SCOPE_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                              `SCOPE_DEFINITION_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                              `CORRELATION_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                              `RETRIES_` int DEFAULT NULL,
                              `EXCEPTION_STACK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                              `EXCEPTION_MSG_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
                              `DUEDATE_` timestamp(3) NULL DEFAULT NULL,
                              `REPEAT_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                              `HANDLER_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                              `HANDLER_CFG_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
                              `CUSTOM_VALUES_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                              `CREATE_TIME_` timestamp(3) NULL DEFAULT NULL,
                              `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
                              PRIMARY KEY (`ID_`),
                              KEY `ACT_IDX_JOB_EXCEPTION_STACK_ID` (`EXCEPTION_STACK_ID_`),
                              KEY `ACT_IDX_JOB_CUSTOM_VALUES_ID` (`CUSTOM_VALUES_ID_`),
                              KEY `ACT_IDX_JOB_CORRELATION_ID` (`CORRELATION_ID_`),
                              KEY `ACT_IDX_JOB_SCOPE` (`SCOPE_ID_`,`SCOPE_TYPE_`),
                              KEY `ACT_IDX_JOB_SUB_SCOPE` (`SUB_SCOPE_ID_`,`SCOPE_TYPE_`),
                              KEY `ACT_IDX_JOB_SCOPE_DEF` (`SCOPE_DEFINITION_ID_`,`SCOPE_TYPE_`),
                              KEY `ACT_FK_JOB_EXECUTION` (`EXECUTION_ID_`),
                              KEY `ACT_FK_JOB_PROCESS_INSTANCE` (`PROCESS_INSTANCE_ID_`),
                              KEY `ACT_FK_JOB_PROC_DEF` (`PROC_DEF_ID_`),
                              CONSTRAINT `ACT_FK_JOB_CUSTOM_VALUES` FOREIGN KEY (`CUSTOM_VALUES_ID_`) REFERENCES `act_ge_bytearray` (`ID_`),
                              CONSTRAINT `ACT_FK_JOB_EXCEPTION` FOREIGN KEY (`EXCEPTION_STACK_ID_`) REFERENCES `act_ge_bytearray` (`ID_`),
                              CONSTRAINT `ACT_FK_JOB_EXECUTION` FOREIGN KEY (`EXECUTION_ID_`) REFERENCES `act_ru_execution` (`ID_`),
                              CONSTRAINT `ACT_FK_JOB_PROC_DEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `act_re_procdef` (`ID_`),
                              CONSTRAINT `ACT_FK_JOB_PROCESS_INSTANCE` FOREIGN KEY (`PROCESS_INSTANCE_ID_`) REFERENCES `act_ru_execution` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_ru_job
-- ----------------------------
BEGIN;
INSERT INTO `act_ru_job` (`ID_`, `REV_`, `CATEGORY_`, `TYPE_`, `LOCK_EXP_TIME_`, `LOCK_OWNER_`, `EXCLUSIVE_`, `EXECUTION_ID_`, `PROCESS_INSTANCE_ID_`, `PROC_DEF_ID_`, `ELEMENT_ID_`, `ELEMENT_NAME_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `SCOPE_DEFINITION_ID_`, `CORRELATION_ID_`, `RETRIES_`, `EXCEPTION_STACK_ID_`, `EXCEPTION_MSG_`, `DUEDATE_`, `REPEAT_`, `HANDLER_TYPE_`, `HANDLER_CFG_`, `CUSTOM_VALUES_ID_`, `CREATE_TIME_`, `TENANT_ID_`) VALUES ('23cbdc5d-584e-11ee-9923-f22f4b0aefad', 1, NULL, 'message', NULL, NULL, 1, '23cbdc59-584e-11ee-9923-f22f4b0aefad', '23cbb542-584e-11ee-9923-f22f4b0aefad', 'testvue3:1:2aea33f1-56c2-11ee-ae41-f22f4b0aefad', 'Activity_17esl0a', 'aaa', NULL, NULL, NULL, NULL, '23cbdc5c-584e-11ee-9923-f22f4b0aefad', 3, NULL, NULL, NULL, NULL, 'async-continuation', NULL, NULL, '2023-09-21 07:11:52.632', '');
INSERT INTO `act_ru_job` (`ID_`, `REV_`, `CATEGORY_`, `TYPE_`, `LOCK_EXP_TIME_`, `LOCK_OWNER_`, `EXCLUSIVE_`, `EXECUTION_ID_`, `PROCESS_INSTANCE_ID_`, `PROC_DEF_ID_`, `ELEMENT_ID_`, `ELEMENT_NAME_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `SCOPE_DEFINITION_ID_`, `CORRELATION_ID_`, `RETRIES_`, `EXCEPTION_STACK_ID_`, `EXCEPTION_MSG_`, `DUEDATE_`, `REPEAT_`, `HANDLER_TYPE_`, `HANDLER_CFG_`, `CUSTOM_VALUES_ID_`, `CREATE_TIME_`, `TENANT_ID_`) VALUES ('28c75a3c-5852-11ee-9923-f22f4b0aefad', 1, NULL, 'message', NULL, NULL, 1, '28c75a38-5852-11ee-9923-f22f4b0aefad', '28c75a2e-5852-11ee-9923-f22f4b0aefad', 'testvue3:2:1e8d1651-584e-11ee-9923-f22f4b0aefad', 'Activity_17esl0a', 'aaa', NULL, NULL, NULL, NULL, '28c75a3b-5852-11ee-9923-f22f4b0aefad', 3, NULL, NULL, NULL, NULL, 'async-continuation', NULL, NULL, '2023-09-21 07:40:38.978', '');
INSERT INTO `act_ru_job` (`ID_`, `REV_`, `CATEGORY_`, `TYPE_`, `LOCK_EXP_TIME_`, `LOCK_OWNER_`, `EXCLUSIVE_`, `EXECUTION_ID_`, `PROCESS_INSTANCE_ID_`, `PROC_DEF_ID_`, `ELEMENT_ID_`, `ELEMENT_NAME_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `SCOPE_DEFINITION_ID_`, `CORRELATION_ID_`, `RETRIES_`, `EXCEPTION_STACK_ID_`, `EXCEPTION_MSG_`, `DUEDATE_`, `REPEAT_`, `HANDLER_TYPE_`, `HANDLER_CFG_`, `CUSTOM_VALUES_ID_`, `CREATE_TIME_`, `TENANT_ID_`) VALUES ('4125bf19-584e-11ee-9923-f22f4b0aefad', 1, NULL, 'message', NULL, NULL, 1, '4125bf15-584e-11ee-9923-f22f4b0aefad', '4125bf0e-584e-11ee-9923-f22f4b0aefad', 'testvue3:2:1e8d1651-584e-11ee-9923-f22f4b0aefad', 'Activity_17esl0a', 'aaa', NULL, NULL, NULL, NULL, '4125bf18-584e-11ee-9923-f22f4b0aefad', 3, NULL, NULL, NULL, NULL, 'async-continuation', NULL, NULL, '2023-09-21 07:12:41.875', '');
INSERT INTO `act_ru_job` (`ID_`, `REV_`, `CATEGORY_`, `TYPE_`, `LOCK_EXP_TIME_`, `LOCK_OWNER_`, `EXCLUSIVE_`, `EXECUTION_ID_`, `PROCESS_INSTANCE_ID_`, `PROC_DEF_ID_`, `ELEMENT_ID_`, `ELEMENT_NAME_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `SCOPE_DEFINITION_ID_`, `CORRELATION_ID_`, `RETRIES_`, `EXCEPTION_STACK_ID_`, `EXCEPTION_MSG_`, `DUEDATE_`, `REPEAT_`, `HANDLER_TYPE_`, `HANDLER_CFG_`, `CUSTOM_VALUES_ID_`, `CREATE_TIME_`, `TENANT_ID_`) VALUES ('6535c595-584e-11ee-9923-f22f4b0aefad', 1, NULL, 'message', NULL, NULL, 1, '65359e81-584e-11ee-9923-f22f4b0aefad', '65359e7a-584e-11ee-9923-f22f4b0aefad', 'testvue3:2:1e8d1651-584e-11ee-9923-f22f4b0aefad', 'Activity_17esl0a', 'aaa', NULL, NULL, NULL, NULL, '6535c594-584e-11ee-9923-f22f4b0aefad', 3, NULL, NULL, NULL, NULL, 'async-continuation', NULL, NULL, '2023-09-21 07:13:42.378', '');
INSERT INTO `act_ru_job` (`ID_`, `REV_`, `CATEGORY_`, `TYPE_`, `LOCK_EXP_TIME_`, `LOCK_OWNER_`, `EXCLUSIVE_`, `EXECUTION_ID_`, `PROCESS_INSTANCE_ID_`, `PROC_DEF_ID_`, `ELEMENT_ID_`, `ELEMENT_NAME_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `SCOPE_DEFINITION_ID_`, `CORRELATION_ID_`, `RETRIES_`, `EXCEPTION_STACK_ID_`, `EXCEPTION_MSG_`, `DUEDATE_`, `REPEAT_`, `HANDLER_TYPE_`, `HANDLER_CFG_`, `CUSTOM_VALUES_ID_`, `CREATE_TIME_`, `TENANT_ID_`) VALUES ('b7a6049d-5851-11ee-9923-f22f4b0aefad', 1, NULL, 'message', NULL, NULL, 1, 'b7a60499-5851-11ee-9923-f22f4b0aefad', 'b7a5dd82-5851-11ee-9923-f22f4b0aefad', 'testvue3:2:1e8d1651-584e-11ee-9923-f22f4b0aefad', 'Activity_17esl0a', 'aaa', NULL, NULL, NULL, NULL, 'b7a6049c-5851-11ee-9923-f22f4b0aefad', 3, NULL, NULL, NULL, NULL, 'async-continuation', NULL, NULL, '2023-09-21 07:37:29.177', '');
INSERT INTO `act_ru_job` (`ID_`, `REV_`, `CATEGORY_`, `TYPE_`, `LOCK_EXP_TIME_`, `LOCK_OWNER_`, `EXCLUSIVE_`, `EXECUTION_ID_`, `PROCESS_INSTANCE_ID_`, `PROC_DEF_ID_`, `ELEMENT_ID_`, `ELEMENT_NAME_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `SCOPE_DEFINITION_ID_`, `CORRELATION_ID_`, `RETRIES_`, `EXCEPTION_STACK_ID_`, `EXCEPTION_MSG_`, `DUEDATE_`, `REPEAT_`, `HANDLER_TYPE_`, `HANDLER_CFG_`, `CUSTOM_VALUES_ID_`, `CREATE_TIME_`, `TENANT_ID_`) VALUES ('ede2b731-5850-11ee-9923-f22f4b0aefad', 1, NULL, 'message', NULL, NULL, 1, 'ede2b72d-5850-11ee-9923-f22f4b0aefad', 'ede26906-5850-11ee-9923-f22f4b0aefad', 'testvue3:2:1e8d1651-584e-11ee-9923-f22f4b0aefad', 'Activity_17esl0a', 'aaa', NULL, NULL, NULL, NULL, 'ede2b730-5850-11ee-9923-f22f4b0aefad', 3, NULL, NULL, NULL, NULL, 'async-continuation', NULL, NULL, '2023-09-21 07:31:50.675', '');
INSERT INTO `act_ru_job` (`ID_`, `REV_`, `CATEGORY_`, `TYPE_`, `LOCK_EXP_TIME_`, `LOCK_OWNER_`, `EXCLUSIVE_`, `EXECUTION_ID_`, `PROCESS_INSTANCE_ID_`, `PROC_DEF_ID_`, `ELEMENT_ID_`, `ELEMENT_NAME_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `SCOPE_DEFINITION_ID_`, `CORRELATION_ID_`, `RETRIES_`, `EXCEPTION_STACK_ID_`, `EXCEPTION_MSG_`, `DUEDATE_`, `REPEAT_`, `HANDLER_TYPE_`, `HANDLER_CFG_`, `CUSTOM_VALUES_ID_`, `CREATE_TIME_`, `TENANT_ID_`) VALUES ('ff6eee5d-584d-11ee-9923-f22f4b0aefad', 1, NULL, 'message', NULL, NULL, 1, 'ff6e5219-584d-11ee-9923-f22f4b0aefad', 'ff6d67b2-584d-11ee-9923-f22f4b0aefad', 'testvue3:1:2aea33f1-56c2-11ee-ae41-f22f4b0aefad', 'Activity_17esl0a', 'aaa', NULL, NULL, NULL, NULL, 'ff6eee5c-584d-11ee-9923-f22f4b0aefad', 3, NULL, NULL, NULL, NULL, 'async-continuation', NULL, NULL, '2023-09-21 07:10:51.625', '');
COMMIT;

-- ----------------------------
-- Table structure for act_ru_suspended_job
-- ----------------------------
DROP TABLE IF EXISTS `act_ru_suspended_job`;
CREATE TABLE `act_ru_suspended_job` (
                                        `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                        `REV_` int DEFAULT NULL,
                                        `CATEGORY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                        `TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
                                        `EXCLUSIVE_` tinyint(1) DEFAULT NULL,
                                        `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                        `PROCESS_INSTANCE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                        `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                        `ELEMENT_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                        `ELEMENT_NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                        `SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                        `SUB_SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                        `SCOPE_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                        `SCOPE_DEFINITION_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                        `CORRELATION_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                        `RETRIES_` int DEFAULT NULL,
                                        `EXCEPTION_STACK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                        `EXCEPTION_MSG_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
                                        `DUEDATE_` timestamp(3) NULL DEFAULT NULL,
                                        `REPEAT_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                        `HANDLER_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                        `HANDLER_CFG_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
                                        `CUSTOM_VALUES_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                        `CREATE_TIME_` timestamp(3) NULL DEFAULT NULL,
                                        `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
                                        PRIMARY KEY (`ID_`),
                                        KEY `ACT_IDX_SUSPENDED_JOB_EXCEPTION_STACK_ID` (`EXCEPTION_STACK_ID_`),
                                        KEY `ACT_IDX_SUSPENDED_JOB_CUSTOM_VALUES_ID` (`CUSTOM_VALUES_ID_`),
                                        KEY `ACT_IDX_SUSPENDED_JOB_CORRELATION_ID` (`CORRELATION_ID_`),
                                        KEY `ACT_IDX_SJOB_SCOPE` (`SCOPE_ID_`,`SCOPE_TYPE_`),
                                        KEY `ACT_IDX_SJOB_SUB_SCOPE` (`SUB_SCOPE_ID_`,`SCOPE_TYPE_`),
                                        KEY `ACT_IDX_SJOB_SCOPE_DEF` (`SCOPE_DEFINITION_ID_`,`SCOPE_TYPE_`),
                                        KEY `ACT_FK_SUSPENDED_JOB_EXECUTION` (`EXECUTION_ID_`),
                                        KEY `ACT_FK_SUSPENDED_JOB_PROCESS_INSTANCE` (`PROCESS_INSTANCE_ID_`),
                                        KEY `ACT_FK_SUSPENDED_JOB_PROC_DEF` (`PROC_DEF_ID_`),
                                        CONSTRAINT `ACT_FK_SUSPENDED_JOB_CUSTOM_VALUES` FOREIGN KEY (`CUSTOM_VALUES_ID_`) REFERENCES `act_ge_bytearray` (`ID_`),
                                        CONSTRAINT `ACT_FK_SUSPENDED_JOB_EXCEPTION` FOREIGN KEY (`EXCEPTION_STACK_ID_`) REFERENCES `act_ge_bytearray` (`ID_`),
                                        CONSTRAINT `ACT_FK_SUSPENDED_JOB_EXECUTION` FOREIGN KEY (`EXECUTION_ID_`) REFERENCES `act_ru_execution` (`ID_`),
                                        CONSTRAINT `ACT_FK_SUSPENDED_JOB_PROC_DEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `act_re_procdef` (`ID_`),
                                        CONSTRAINT `ACT_FK_SUSPENDED_JOB_PROCESS_INSTANCE` FOREIGN KEY (`PROCESS_INSTANCE_ID_`) REFERENCES `act_ru_execution` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_ru_suspended_job
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for act_ru_task
-- ----------------------------
DROP TABLE IF EXISTS `act_ru_task`;
CREATE TABLE `act_ru_task` (
                               `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                               `REV_` int DEFAULT NULL,
                               `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                               `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                               `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                               `TASK_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                               `SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                               `SUB_SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                               `SCOPE_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                               `SCOPE_DEFINITION_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                               `PROPAGATED_STAGE_INST_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                               `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                               `PARENT_TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                               `DESCRIPTION_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
                               `TASK_DEF_KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                               `OWNER_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                               `ASSIGNEE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                               `DELEGATION_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                               `PRIORITY_` int DEFAULT NULL,
                               `CREATE_TIME_` timestamp(3) NULL DEFAULT NULL,
                               `DUE_DATE_` datetime(3) DEFAULT NULL,
                               `CATEGORY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                               `SUSPENSION_STATE_` int DEFAULT NULL,
                               `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
                               `FORM_KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                               `CLAIM_TIME_` datetime(3) DEFAULT NULL,
                               `IS_COUNT_ENABLED_` tinyint DEFAULT NULL,
                               `VAR_COUNT_` int DEFAULT NULL,
                               `ID_LINK_COUNT_` int DEFAULT NULL,
                               `SUB_TASK_COUNT_` int DEFAULT NULL,
                               PRIMARY KEY (`ID_`),
                               KEY `ACT_IDX_TASK_CREATE` (`CREATE_TIME_`),
                               KEY `ACT_IDX_TASK_SCOPE` (`SCOPE_ID_`,`SCOPE_TYPE_`),
                               KEY `ACT_IDX_TASK_SUB_SCOPE` (`SUB_SCOPE_ID_`,`SCOPE_TYPE_`),
                               KEY `ACT_IDX_TASK_SCOPE_DEF` (`SCOPE_DEFINITION_ID_`,`SCOPE_TYPE_`),
                               KEY `ACT_FK_TASK_EXE` (`EXECUTION_ID_`),
                               KEY `ACT_FK_TASK_PROCINST` (`PROC_INST_ID_`),
                               KEY `ACT_FK_TASK_PROCDEF` (`PROC_DEF_ID_`),
                               CONSTRAINT `ACT_FK_TASK_EXE` FOREIGN KEY (`EXECUTION_ID_`) REFERENCES `act_ru_execution` (`ID_`),
                               CONSTRAINT `ACT_FK_TASK_PROCDEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `act_re_procdef` (`ID_`),
                               CONSTRAINT `ACT_FK_TASK_PROCINST` FOREIGN KEY (`PROC_INST_ID_`) REFERENCES `act_ru_execution` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_ru_task
-- ----------------------------
BEGIN;
INSERT INTO `act_ru_task` (`ID_`, `REV_`, `EXECUTION_ID_`, `PROC_INST_ID_`, `PROC_DEF_ID_`, `TASK_DEF_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `SCOPE_DEFINITION_ID_`, `PROPAGATED_STAGE_INST_ID_`, `NAME_`, `PARENT_TASK_ID_`, `DESCRIPTION_`, `TASK_DEF_KEY_`, `OWNER_`, `ASSIGNEE_`, `DELEGATION_`, `PRIORITY_`, `CREATE_TIME_`, `DUE_DATE_`, `CATEGORY_`, `SUSPENSION_STATE_`, `TENANT_ID_`, `FORM_KEY_`, `CLAIM_TIME_`, `IS_COUNT_ENABLED_`, `VAR_COUNT_`, `ID_LINK_COUNT_`, `SUB_TASK_COUNT_`) VALUES ('20fd4017-b340-11ed-9d23-869ef1607803', 1, '1188c1ca-b33f-11ed-b511-ce4fe10f37b8', '11884c8f-b33f-11ed-b511-ce4fe10f37b8', 'testoa:16:98955103-b33e-11ed-b511-ce4fe10f37b8', NULL, NULL, NULL, NULL, NULL, NULL, '验收', NULL, NULL, 'Activity_0exhfyz', NULL, NULL, NULL, 50, '2023-02-23 06:05:53.110', NULL, NULL, 1, '', NULL, NULL, 1, 0, 0, 0);
INSERT INTO `act_ru_task` (`ID_`, `REV_`, `EXECUTION_ID_`, `PROC_INST_ID_`, `PROC_DEF_ID_`, `TASK_DEF_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `SCOPE_DEFINITION_ID_`, `PROPAGATED_STAGE_INST_ID_`, `NAME_`, `PARENT_TASK_ID_`, `DESCRIPTION_`, `TASK_DEF_KEY_`, `OWNER_`, `ASSIGNEE_`, `DELEGATION_`, `PRIORITY_`, `CREATE_TIME_`, `DUE_DATE_`, `CATEGORY_`, `SUSPENSION_STATE_`, `TENANT_ID_`, `FORM_KEY_`, `CLAIM_TIME_`, `IS_COUNT_ENABLED_`, `VAR_COUNT_`, `ID_LINK_COUNT_`, `SUB_TASK_COUNT_`) VALUES ('b80abcc5-b345-11ed-8617-ce4fe10f37b8', 1, 'b8073a51-b345-11ed-8617-ce4fe10f37b8', 'b8058c96-b345-11ed-8617-ce4fe10f37b8', 'testoa:16:98955103-b33e-11ed-b511-ce4fe10f37b8', NULL, NULL, NULL, NULL, NULL, NULL, '经理审批', NULL, NULL, 'Activity_1qo8esf', NULL, NULL, NULL, 50, '2023-02-23 06:45:54.002', NULL, NULL, 1, '', NULL, NULL, 1, 0, 2, 0);
INSERT INTO `act_ru_task` (`ID_`, `REV_`, `EXECUTION_ID_`, `PROC_INST_ID_`, `PROC_DEF_ID_`, `TASK_DEF_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `SCOPE_DEFINITION_ID_`, `PROPAGATED_STAGE_INST_ID_`, `NAME_`, `PARENT_TASK_ID_`, `DESCRIPTION_`, `TASK_DEF_KEY_`, `OWNER_`, `ASSIGNEE_`, `DELEGATION_`, `PRIORITY_`, `CREATE_TIME_`, `DUE_DATE_`, `CATEGORY_`, `SUSPENSION_STATE_`, `TENANT_ID_`, `FORM_KEY_`, `CLAIM_TIME_`, `IS_COUNT_ENABLED_`, `VAR_COUNT_`, `ID_LINK_COUNT_`, `SUB_TASK_COUNT_`) VALUES ('c4fce411-b340-11ed-88a8-869ef1607803', 1, '3ef44d33-b340-11ed-9d23-869ef1607803', '3ef44d28-b340-11ed-9d23-869ef1607803', 'testoa:16:98955103-b33e-11ed-b511-ce4fe10f37b8', NULL, NULL, NULL, NULL, NULL, NULL, '重新发起', NULL, NULL, 'Activity_1qfkof6', NULL, NULL, NULL, 50, '2023-02-23 06:10:28.253', NULL, NULL, 1, '', NULL, NULL, 1, 0, 0, 0);
INSERT INTO `act_ru_task` (`ID_`, `REV_`, `EXECUTION_ID_`, `PROC_INST_ID_`, `PROC_DEF_ID_`, `TASK_DEF_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `SCOPE_DEFINITION_ID_`, `PROPAGATED_STAGE_INST_ID_`, `NAME_`, `PARENT_TASK_ID_`, `DESCRIPTION_`, `TASK_DEF_KEY_`, `OWNER_`, `ASSIGNEE_`, `DELEGATION_`, `PRIORITY_`, `CREATE_TIME_`, `DUE_DATE_`, `CATEGORY_`, `SUSPENSION_STATE_`, `TENANT_ID_`, `FORM_KEY_`, `CLAIM_TIME_`, `IS_COUNT_ENABLED_`, `VAR_COUNT_`, `ID_LINK_COUNT_`, `SUB_TASK_COUNT_`) VALUES ('da9dceda-b33f-11ed-9d23-869ef1607803', 1, 'd48e7258-b33f-11ed-9d23-869ef1607803', 'd48d87ed-b33f-11ed-9d23-869ef1607803', 'testoa:16:98955103-b33e-11ed-b511-ce4fe10f37b8', NULL, NULL, NULL, NULL, NULL, NULL, '重新发起', NULL, NULL, 'Activity_1qfkof6', NULL, NULL, NULL, 50, '2023-02-23 06:03:55.044', NULL, NULL, 1, '', NULL, NULL, 1, 0, 0, 0);
COMMIT;

-- ----------------------------
-- Table structure for act_ru_timer_job
-- ----------------------------
DROP TABLE IF EXISTS `act_ru_timer_job`;
CREATE TABLE `act_ru_timer_job` (
                                    `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                    `REV_` int DEFAULT NULL,
                                    `CATEGORY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                    `TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
                                    `LOCK_EXP_TIME_` timestamp(3) NULL DEFAULT NULL,
                                    `LOCK_OWNER_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                    `EXCLUSIVE_` tinyint(1) DEFAULT NULL,
                                    `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                    `PROCESS_INSTANCE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                    `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                    `ELEMENT_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                    `ELEMENT_NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                    `SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                    `SUB_SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                    `SCOPE_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                    `SCOPE_DEFINITION_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                    `CORRELATION_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                    `RETRIES_` int DEFAULT NULL,
                                    `EXCEPTION_STACK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                    `EXCEPTION_MSG_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
                                    `DUEDATE_` timestamp(3) NULL DEFAULT NULL,
                                    `REPEAT_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                    `HANDLER_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                    `HANDLER_CFG_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
                                    `CUSTOM_VALUES_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                    `CREATE_TIME_` timestamp(3) NULL DEFAULT NULL,
                                    `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
                                    PRIMARY KEY (`ID_`),
                                    KEY `ACT_IDX_TIMER_JOB_EXCEPTION_STACK_ID` (`EXCEPTION_STACK_ID_`),
                                    KEY `ACT_IDX_TIMER_JOB_CUSTOM_VALUES_ID` (`CUSTOM_VALUES_ID_`),
                                    KEY `ACT_IDX_TIMER_JOB_CORRELATION_ID` (`CORRELATION_ID_`),
                                    KEY `ACT_IDX_TIMER_JOB_DUEDATE` (`DUEDATE_`),
                                    KEY `ACT_IDX_TJOB_SCOPE` (`SCOPE_ID_`,`SCOPE_TYPE_`),
                                    KEY `ACT_IDX_TJOB_SUB_SCOPE` (`SUB_SCOPE_ID_`,`SCOPE_TYPE_`),
                                    KEY `ACT_IDX_TJOB_SCOPE_DEF` (`SCOPE_DEFINITION_ID_`,`SCOPE_TYPE_`),
                                    KEY `ACT_FK_TIMER_JOB_EXECUTION` (`EXECUTION_ID_`),
                                    KEY `ACT_FK_TIMER_JOB_PROCESS_INSTANCE` (`PROCESS_INSTANCE_ID_`),
                                    KEY `ACT_FK_TIMER_JOB_PROC_DEF` (`PROC_DEF_ID_`),
                                    CONSTRAINT `ACT_FK_TIMER_JOB_CUSTOM_VALUES` FOREIGN KEY (`CUSTOM_VALUES_ID_`) REFERENCES `act_ge_bytearray` (`ID_`),
                                    CONSTRAINT `ACT_FK_TIMER_JOB_EXCEPTION` FOREIGN KEY (`EXCEPTION_STACK_ID_`) REFERENCES `act_ge_bytearray` (`ID_`),
                                    CONSTRAINT `ACT_FK_TIMER_JOB_EXECUTION` FOREIGN KEY (`EXECUTION_ID_`) REFERENCES `act_ru_execution` (`ID_`),
                                    CONSTRAINT `ACT_FK_TIMER_JOB_PROC_DEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `act_re_procdef` (`ID_`),
                                    CONSTRAINT `ACT_FK_TIMER_JOB_PROCESS_INSTANCE` FOREIGN KEY (`PROCESS_INSTANCE_ID_`) REFERENCES `act_ru_execution` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_ru_timer_job
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for act_ru_variable
-- ----------------------------
DROP TABLE IF EXISTS `act_ru_variable`;
CREATE TABLE `act_ru_variable` (
                                   `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                   `REV_` int DEFAULT NULL,
                                   `TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
                                   `NAME_` varchar(255) COLLATE utf8_bin NOT NULL,
                                   `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                   `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                   `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                   `SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                   `SUB_SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                   `SCOPE_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                   `BYTEARRAY_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                   `DOUBLE_` double DEFAULT NULL,
                                   `LONG_` bigint DEFAULT NULL,
                                   `TEXT_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
                                   `TEXT2_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
                                   `META_INFO_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
                                   PRIMARY KEY (`ID_`),
                                   KEY `ACT_IDX_RU_VAR_SCOPE_ID_TYPE` (`SCOPE_ID_`,`SCOPE_TYPE_`),
                                   KEY `ACT_IDX_RU_VAR_SUB_ID_TYPE` (`SUB_SCOPE_ID_`,`SCOPE_TYPE_`),
                                   KEY `ACT_FK_VAR_BYTEARRAY` (`BYTEARRAY_ID_`),
                                   KEY `ACT_IDX_VARIABLE_TASK_ID` (`TASK_ID_`),
                                   KEY `ACT_FK_VAR_EXE` (`EXECUTION_ID_`),
                                   KEY `ACT_FK_VAR_PROCINST` (`PROC_INST_ID_`),
                                   CONSTRAINT `ACT_FK_VAR_BYTEARRAY` FOREIGN KEY (`BYTEARRAY_ID_`) REFERENCES `act_ge_bytearray` (`ID_`),
                                   CONSTRAINT `ACT_FK_VAR_EXE` FOREIGN KEY (`EXECUTION_ID_`) REFERENCES `act_ru_execution` (`ID_`),
                                   CONSTRAINT `ACT_FK_VAR_PROCINST` FOREIGN KEY (`PROC_INST_ID_`) REFERENCES `act_ru_execution` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_ru_variable
-- ----------------------------
BEGIN;
INSERT INTO `act_ru_variable` (`ID_`, `REV_`, `TYPE_`, `NAME_`, `EXECUTION_ID_`, `PROC_INST_ID_`, `TASK_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `META_INFO_`) VALUES ('11889ab2-b33f-11ed-b511-ce4fe10f37b8', 1, 'serializable', 'leavetime', '11884c8f-b33f-11ed-b511-ce4fe10f37b8', '11884c8f-b33f-11ed-b511-ce4fe10f37b8', NULL, NULL, NULL, NULL, '11889ab1-b33f-11ed-b511-ce4fe10f37b8', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `act_ru_variable` (`ID_`, `REV_`, `TYPE_`, `NAME_`, `EXECUTION_ID_`, `PROC_INST_ID_`, `TASK_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `META_INFO_`) VALUES ('11889ab4-b33f-11ed-b511-ce4fe10f37b8', 1, 'integer', 'leavetype', '11884c8f-b33f-11ed-b511-ce4fe10f37b8', '11884c8f-b33f-11ed-b511-ce4fe10f37b8', NULL, NULL, NULL, NULL, NULL, NULL, 1, '1', NULL, NULL);
INSERT INTO `act_ru_variable` (`ID_`, `REV_`, `TYPE_`, `NAME_`, `EXECUTION_ID_`, `PROC_INST_ID_`, `TASK_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `META_INFO_`) VALUES ('11889ab5-b33f-11ed-b511-ce4fe10f37b8', 1, 'string', 'leavereason', '11884c8f-b33f-11ed-b511-ce4fe10f37b8', '11884c8f-b33f-11ed-b511-ce4fe10f37b8', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '111', NULL, NULL);
INSERT INTO `act_ru_variable` (`ID_`, `REV_`, `TYPE_`, `NAME_`, `EXECUTION_ID_`, `PROC_INST_ID_`, `TASK_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `META_INFO_`) VALUES ('1188c1c7-b33f-11ed-b511-ce4fe10f37b8', 1, 'serializable', 'variables', '11884c8f-b33f-11ed-b511-ce4fe10f37b8', '11884c8f-b33f-11ed-b511-ce4fe10f37b8', NULL, NULL, NULL, NULL, '1188c1c6-b33f-11ed-b511-ce4fe10f37b8', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `act_ru_variable` (`ID_`, `REV_`, `TYPE_`, `NAME_`, `EXECUTION_ID_`, `PROC_INST_ID_`, `TASK_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `META_INFO_`) VALUES ('1188c1c9-b33f-11ed-b511-ce4fe10f37b8', 1, 'string', 'INITIATOR', '11884c8f-b33f-11ed-b511-ce4fe10f37b8', '11884c8f-b33f-11ed-b511-ce4fe10f37b8', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, NULL);
INSERT INTO `act_ru_variable` (`ID_`, `REV_`, `TYPE_`, `NAME_`, `EXECUTION_ID_`, `PROC_INST_ID_`, `TASK_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `META_INFO_`) VALUES ('20faf622-b340-11ed-9d23-869ef1607803', 1, 'string', 'approve', '11884c8f-b33f-11ed-b511-ce4fe10f37b8', '11884c8f-b33f-11ed-b511-ce4fe10f37b8', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '同意', NULL, NULL);
INSERT INTO `act_ru_variable` (`ID_`, `REV_`, `TYPE_`, `NAME_`, `EXECUTION_ID_`, `PROC_INST_ID_`, `TASK_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `META_INFO_`) VALUES ('23cbb543-584e-11ee-9923-f22f4b0aefad', 1, 'long', 'INITIATOR', '23cbb542-584e-11ee-9923-f22f4b0aefad', '23cbb542-584e-11ee-9923-f22f4b0aefad', NULL, NULL, NULL, NULL, NULL, NULL, 1, '1', NULL, NULL);
INSERT INTO `act_ru_variable` (`ID_`, `REV_`, `TYPE_`, `NAME_`, `EXECUTION_ID_`, `PROC_INST_ID_`, `TASK_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `META_INFO_`) VALUES ('23cbb545-584e-11ee-9923-f22f4b0aefad', 1, 'string', 'name', '23cbb542-584e-11ee-9923-f22f4b0aefad', '23cbb542-584e-11ee-9923-f22f4b0aefad', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '3333', NULL, NULL);
INSERT INTO `act_ru_variable` (`ID_`, `REV_`, `TYPE_`, `NAME_`, `EXECUTION_ID_`, `PROC_INST_ID_`, `TASK_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `META_INFO_`) VALUES ('23cbb547-584e-11ee-9923-f22f4b0aefad', 1, 'serializable', 'variables', '23cbb542-584e-11ee-9923-f22f4b0aefad', '23cbb542-584e-11ee-9923-f22f4b0aefad', NULL, NULL, NULL, NULL, '23cbb546-584e-11ee-9923-f22f4b0aefad', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `act_ru_variable` (`ID_`, `REV_`, `TYPE_`, `NAME_`, `EXECUTION_ID_`, `PROC_INST_ID_`, `TASK_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `META_INFO_`) VALUES ('28c75a2f-5852-11ee-9923-f22f4b0aefad', 1, 'long', 'INITIATOR', '28c75a2e-5852-11ee-9923-f22f4b0aefad', '28c75a2e-5852-11ee-9923-f22f4b0aefad', NULL, NULL, NULL, NULL, NULL, NULL, 1, '1', NULL, NULL);
INSERT INTO `act_ru_variable` (`ID_`, `REV_`, `TYPE_`, `NAME_`, `EXECUTION_ID_`, `PROC_INST_ID_`, `TASK_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `META_INFO_`) VALUES ('28c75a32-5852-11ee-9923-f22f4b0aefad', 1, 'serializable', 'fields', '28c75a2e-5852-11ee-9923-f22f4b0aefad', '28c75a2e-5852-11ee-9923-f22f4b0aefad', NULL, NULL, NULL, NULL, '28c75a31-5852-11ee-9923-f22f4b0aefad', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `act_ru_variable` (`ID_`, `REV_`, `TYPE_`, `NAME_`, `EXECUTION_ID_`, `PROC_INST_ID_`, `TASK_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `META_INFO_`) VALUES ('28c75a34-5852-11ee-9923-f22f4b0aefad', 1, 'string', 'name', '28c75a2e-5852-11ee-9923-f22f4b0aefad', '28c75a2e-5852-11ee-9923-f22f4b0aefad', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '444', NULL, NULL);
INSERT INTO `act_ru_variable` (`ID_`, `REV_`, `TYPE_`, `NAME_`, `EXECUTION_ID_`, `PROC_INST_ID_`, `TASK_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `META_INFO_`) VALUES ('28c75a36-5852-11ee-9923-f22f4b0aefad', 1, 'serializable', 'variables', '28c75a2e-5852-11ee-9923-f22f4b0aefad', '28c75a2e-5852-11ee-9923-f22f4b0aefad', NULL, NULL, NULL, NULL, '28c75a35-5852-11ee-9923-f22f4b0aefad', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `act_ru_variable` (`ID_`, `REV_`, `TYPE_`, `NAME_`, `EXECUTION_ID_`, `PROC_INST_ID_`, `TASK_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `META_INFO_`) VALUES ('3ef44d2b-b340-11ed-9d23-869ef1607803', 1, 'serializable', 'leavetime', '3ef44d28-b340-11ed-9d23-869ef1607803', '3ef44d28-b340-11ed-9d23-869ef1607803', NULL, NULL, NULL, NULL, '3ef44d2a-b340-11ed-9d23-869ef1607803', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `act_ru_variable` (`ID_`, `REV_`, `TYPE_`, `NAME_`, `EXECUTION_ID_`, `PROC_INST_ID_`, `TASK_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `META_INFO_`) VALUES ('3ef44d2d-b340-11ed-9d23-869ef1607803', 1, 'integer', 'leavetype', '3ef44d28-b340-11ed-9d23-869ef1607803', '3ef44d28-b340-11ed-9d23-869ef1607803', NULL, NULL, NULL, NULL, NULL, NULL, 1, '1', NULL, NULL);
INSERT INTO `act_ru_variable` (`ID_`, `REV_`, `TYPE_`, `NAME_`, `EXECUTION_ID_`, `PROC_INST_ID_`, `TASK_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `META_INFO_`) VALUES ('3ef44d2e-b340-11ed-9d23-869ef1607803', 1, 'string', 'leavereason', '3ef44d28-b340-11ed-9d23-869ef1607803', '3ef44d28-b340-11ed-9d23-869ef1607803', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '111', NULL, NULL);
INSERT INTO `act_ru_variable` (`ID_`, `REV_`, `TYPE_`, `NAME_`, `EXECUTION_ID_`, `PROC_INST_ID_`, `TASK_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `META_INFO_`) VALUES ('3ef44d30-b340-11ed-9d23-869ef1607803', 1, 'serializable', 'variables', '3ef44d28-b340-11ed-9d23-869ef1607803', '3ef44d28-b340-11ed-9d23-869ef1607803', NULL, NULL, NULL, NULL, '3ef44d2f-b340-11ed-9d23-869ef1607803', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `act_ru_variable` (`ID_`, `REV_`, `TYPE_`, `NAME_`, `EXECUTION_ID_`, `PROC_INST_ID_`, `TASK_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `META_INFO_`) VALUES ('3ef44d32-b340-11ed-9d23-869ef1607803', 1, 'string', 'INITIATOR', '3ef44d28-b340-11ed-9d23-869ef1607803', '3ef44d28-b340-11ed-9d23-869ef1607803', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, NULL);
INSERT INTO `act_ru_variable` (`ID_`, `REV_`, `TYPE_`, `NAME_`, `EXECUTION_ID_`, `PROC_INST_ID_`, `TASK_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `META_INFO_`) VALUES ('4125bf0f-584e-11ee-9923-f22f4b0aefad', 1, 'long', 'INITIATOR', '4125bf0e-584e-11ee-9923-f22f4b0aefad', '4125bf0e-584e-11ee-9923-f22f4b0aefad', NULL, NULL, NULL, NULL, NULL, NULL, 1, '1', NULL, NULL);
INSERT INTO `act_ru_variable` (`ID_`, `REV_`, `TYPE_`, `NAME_`, `EXECUTION_ID_`, `PROC_INST_ID_`, `TASK_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `META_INFO_`) VALUES ('4125bf11-584e-11ee-9923-f22f4b0aefad', 1, 'string', 'name', '4125bf0e-584e-11ee-9923-f22f4b0aefad', '4125bf0e-584e-11ee-9923-f22f4b0aefad', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '111', NULL, NULL);
INSERT INTO `act_ru_variable` (`ID_`, `REV_`, `TYPE_`, `NAME_`, `EXECUTION_ID_`, `PROC_INST_ID_`, `TASK_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `META_INFO_`) VALUES ('4125bf13-584e-11ee-9923-f22f4b0aefad', 1, 'serializable', 'variables', '4125bf0e-584e-11ee-9923-f22f4b0aefad', '4125bf0e-584e-11ee-9923-f22f4b0aefad', NULL, NULL, NULL, NULL, '4125bf12-584e-11ee-9923-f22f4b0aefad', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `act_ru_variable` (`ID_`, `REV_`, `TYPE_`, `NAME_`, `EXECUTION_ID_`, `PROC_INST_ID_`, `TASK_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `META_INFO_`) VALUES ('65359e7b-584e-11ee-9923-f22f4b0aefad', 1, 'long', 'INITIATOR', '65359e7a-584e-11ee-9923-f22f4b0aefad', '65359e7a-584e-11ee-9923-f22f4b0aefad', NULL, NULL, NULL, NULL, NULL, NULL, 1, '1', NULL, NULL);
INSERT INTO `act_ru_variable` (`ID_`, `REV_`, `TYPE_`, `NAME_`, `EXECUTION_ID_`, `PROC_INST_ID_`, `TASK_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `META_INFO_`) VALUES ('65359e7d-584e-11ee-9923-f22f4b0aefad', 1, 'string', 'name', '65359e7a-584e-11ee-9923-f22f4b0aefad', '65359e7a-584e-11ee-9923-f22f4b0aefad', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '222', NULL, NULL);
INSERT INTO `act_ru_variable` (`ID_`, `REV_`, `TYPE_`, `NAME_`, `EXECUTION_ID_`, `PROC_INST_ID_`, `TASK_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `META_INFO_`) VALUES ('65359e7f-584e-11ee-9923-f22f4b0aefad', 1, 'serializable', 'variables', '65359e7a-584e-11ee-9923-f22f4b0aefad', '65359e7a-584e-11ee-9923-f22f4b0aefad', NULL, NULL, NULL, NULL, '65359e7e-584e-11ee-9923-f22f4b0aefad', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `act_ru_variable` (`ID_`, `REV_`, `TYPE_`, `NAME_`, `EXECUTION_ID_`, `PROC_INST_ID_`, `TASK_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `META_INFO_`) VALUES ('b7a5dd83-5851-11ee-9923-f22f4b0aefad', 1, 'long', 'INITIATOR', 'b7a5dd82-5851-11ee-9923-f22f4b0aefad', 'b7a5dd82-5851-11ee-9923-f22f4b0aefad', NULL, NULL, NULL, NULL, NULL, NULL, 1, '1', NULL, NULL);
INSERT INTO `act_ru_variable` (`ID_`, `REV_`, `TYPE_`, `NAME_`, `EXECUTION_ID_`, `PROC_INST_ID_`, `TASK_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `META_INFO_`) VALUES ('b7a60495-5851-11ee-9923-f22f4b0aefad', 1, 'string', 'name', 'b7a5dd82-5851-11ee-9923-f22f4b0aefad', 'b7a5dd82-5851-11ee-9923-f22f4b0aefad', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '3333', NULL, NULL);
INSERT INTO `act_ru_variable` (`ID_`, `REV_`, `TYPE_`, `NAME_`, `EXECUTION_ID_`, `PROC_INST_ID_`, `TASK_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `META_INFO_`) VALUES ('b7a60497-5851-11ee-9923-f22f4b0aefad', 1, 'serializable', 'variables', 'b7a5dd82-5851-11ee-9923-f22f4b0aefad', 'b7a5dd82-5851-11ee-9923-f22f4b0aefad', NULL, NULL, NULL, NULL, 'b7a60496-5851-11ee-9923-f22f4b0aefad', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `act_ru_variable` (`ID_`, `REV_`, `TYPE_`, `NAME_`, `EXECUTION_ID_`, `PROC_INST_ID_`, `TASK_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `META_INFO_`) VALUES ('b8069e09-b345-11ed-8617-ce4fe10f37b8', 1, 'serializable', 'leavetime', 'b8058c96-b345-11ed-8617-ce4fe10f37b8', 'b8058c96-b345-11ed-8617-ce4fe10f37b8', NULL, NULL, NULL, NULL, 'b8069e08-b345-11ed-8617-ce4fe10f37b8', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `act_ru_variable` (`ID_`, `REV_`, `TYPE_`, `NAME_`, `EXECUTION_ID_`, `PROC_INST_ID_`, `TASK_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `META_INFO_`) VALUES ('b806ec2b-b345-11ed-8617-ce4fe10f37b8', 1, 'integer', 'leavetype', 'b8058c96-b345-11ed-8617-ce4fe10f37b8', 'b8058c96-b345-11ed-8617-ce4fe10f37b8', NULL, NULL, NULL, NULL, NULL, NULL, 1, '1', NULL, NULL);
INSERT INTO `act_ru_variable` (`ID_`, `REV_`, `TYPE_`, `NAME_`, `EXECUTION_ID_`, `PROC_INST_ID_`, `TASK_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `META_INFO_`) VALUES ('b807133c-b345-11ed-8617-ce4fe10f37b8', 1, 'string', 'leavereason', 'b8058c96-b345-11ed-8617-ce4fe10f37b8', 'b8058c96-b345-11ed-8617-ce4fe10f37b8', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '44', NULL, NULL);
INSERT INTO `act_ru_variable` (`ID_`, `REV_`, `TYPE_`, `NAME_`, `EXECUTION_ID_`, `PROC_INST_ID_`, `TASK_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `META_INFO_`) VALUES ('b807133e-b345-11ed-8617-ce4fe10f37b8', 1, 'serializable', 'variables', 'b8058c96-b345-11ed-8617-ce4fe10f37b8', 'b8058c96-b345-11ed-8617-ce4fe10f37b8', NULL, NULL, NULL, NULL, 'b807133d-b345-11ed-8617-ce4fe10f37b8', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `act_ru_variable` (`ID_`, `REV_`, `TYPE_`, `NAME_`, `EXECUTION_ID_`, `PROC_INST_ID_`, `TASK_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `META_INFO_`) VALUES ('b8071340-b345-11ed-8617-ce4fe10f37b8', 1, 'string', 'INITIATOR', 'b8058c96-b345-11ed-8617-ce4fe10f37b8', 'b8058c96-b345-11ed-8617-ce4fe10f37b8', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1', NULL, NULL);
INSERT INTO `act_ru_variable` (`ID_`, `REV_`, `TYPE_`, `NAME_`, `EXECUTION_ID_`, `PROC_INST_ID_`, `TASK_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `META_INFO_`) VALUES ('c4f14b4c-b340-11ed-88a8-869ef1607803', 1, 'string', 'approve', '3ef44d28-b340-11ed-9d23-869ef1607803', '3ef44d28-b340-11ed-9d23-869ef1607803', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '拒绝', NULL, NULL);
INSERT INTO `act_ru_variable` (`ID_`, `REV_`, `TYPE_`, `NAME_`, `EXECUTION_ID_`, `PROC_INST_ID_`, `TASK_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `META_INFO_`) VALUES ('d48dfd20-b33f-11ed-9d23-869ef1607803', 1, 'serializable', 'leavetime', 'd48d87ed-b33f-11ed-9d23-869ef1607803', 'd48d87ed-b33f-11ed-9d23-869ef1607803', NULL, NULL, NULL, NULL, 'd48dfd1f-b33f-11ed-9d23-869ef1607803', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `act_ru_variable` (`ID_`, `REV_`, `TYPE_`, `NAME_`, `EXECUTION_ID_`, `PROC_INST_ID_`, `TASK_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `META_INFO_`) VALUES ('d48e4b42-b33f-11ed-9d23-869ef1607803', 1, 'integer', 'leavetype', 'd48d87ed-b33f-11ed-9d23-869ef1607803', 'd48d87ed-b33f-11ed-9d23-869ef1607803', NULL, NULL, NULL, NULL, NULL, NULL, 1, '1', NULL, NULL);
INSERT INTO `act_ru_variable` (`ID_`, `REV_`, `TYPE_`, `NAME_`, `EXECUTION_ID_`, `PROC_INST_ID_`, `TASK_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `META_INFO_`) VALUES ('d48e4b43-b33f-11ed-9d23-869ef1607803', 1, 'string', 'leavereason', 'd48d87ed-b33f-11ed-9d23-869ef1607803', 'd48d87ed-b33f-11ed-9d23-869ef1607803', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '11', NULL, NULL);
INSERT INTO `act_ru_variable` (`ID_`, `REV_`, `TYPE_`, `NAME_`, `EXECUTION_ID_`, `PROC_INST_ID_`, `TASK_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `META_INFO_`) VALUES ('d48e4b45-b33f-11ed-9d23-869ef1607803', 1, 'serializable', 'variables', 'd48d87ed-b33f-11ed-9d23-869ef1607803', 'd48d87ed-b33f-11ed-9d23-869ef1607803', NULL, NULL, NULL, NULL, 'd48e4b44-b33f-11ed-9d23-869ef1607803', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `act_ru_variable` (`ID_`, `REV_`, `TYPE_`, `NAME_`, `EXECUTION_ID_`, `PROC_INST_ID_`, `TASK_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `META_INFO_`) VALUES ('d48e4b47-b33f-11ed-9d23-869ef1607803', 1, 'string', 'INITIATOR', 'd48d87ed-b33f-11ed-9d23-869ef1607803', 'd48d87ed-b33f-11ed-9d23-869ef1607803', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, NULL);
INSERT INTO `act_ru_variable` (`ID_`, `REV_`, `TYPE_`, `NAME_`, `EXECUTION_ID_`, `PROC_INST_ID_`, `TASK_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `META_INFO_`) VALUES ('da996205-b33f-11ed-9d23-869ef1607803', 1, 'string', 'approve', 'd48d87ed-b33f-11ed-9d23-869ef1607803', 'd48d87ed-b33f-11ed-9d23-869ef1607803', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '拒绝', NULL, NULL);
INSERT INTO `act_ru_variable` (`ID_`, `REV_`, `TYPE_`, `NAME_`, `EXECUTION_ID_`, `PROC_INST_ID_`, `TASK_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `META_INFO_`) VALUES ('ede26907-5850-11ee-9923-f22f4b0aefad', 1, 'long', 'INITIATOR', 'ede26906-5850-11ee-9923-f22f4b0aefad', 'ede26906-5850-11ee-9923-f22f4b0aefad', NULL, NULL, NULL, NULL, NULL, NULL, 1, '1', NULL, NULL);
INSERT INTO `act_ru_variable` (`ID_`, `REV_`, `TYPE_`, `NAME_`, `EXECUTION_ID_`, `PROC_INST_ID_`, `TASK_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `META_INFO_`) VALUES ('ede26909-5850-11ee-9923-f22f4b0aefad', 1, 'string', 'name', 'ede26906-5850-11ee-9923-f22f4b0aefad', 'ede26906-5850-11ee-9923-f22f4b0aefad', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '3333', NULL, NULL);
INSERT INTO `act_ru_variable` (`ID_`, `REV_`, `TYPE_`, `NAME_`, `EXECUTION_ID_`, `PROC_INST_ID_`, `TASK_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `META_INFO_`) VALUES ('ede2b72b-5850-11ee-9923-f22f4b0aefad', 1, 'serializable', 'variables', 'ede26906-5850-11ee-9923-f22f4b0aefad', 'ede26906-5850-11ee-9923-f22f4b0aefad', NULL, NULL, NULL, NULL, 'ede2b72a-5850-11ee-9923-f22f4b0aefad', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `act_ru_variable` (`ID_`, `REV_`, `TYPE_`, `NAME_`, `EXECUTION_ID_`, `PROC_INST_ID_`, `TASK_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `META_INFO_`) VALUES ('ff6d8ec3-584d-11ee-9923-f22f4b0aefad', 1, 'long', 'INITIATOR', 'ff6d67b2-584d-11ee-9923-f22f4b0aefad', 'ff6d67b2-584d-11ee-9923-f22f4b0aefad', NULL, NULL, NULL, NULL, NULL, NULL, 1, '1', NULL, NULL);
INSERT INTO `act_ru_variable` (`ID_`, `REV_`, `TYPE_`, `NAME_`, `EXECUTION_ID_`, `PROC_INST_ID_`, `TASK_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `META_INFO_`) VALUES ('ff6db5d5-584d-11ee-9923-f22f4b0aefad', 1, 'string', 'name', 'ff6d67b2-584d-11ee-9923-f22f4b0aefad', 'ff6d67b2-584d-11ee-9923-f22f4b0aefad', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '111', NULL, NULL);
INSERT INTO `act_ru_variable` (`ID_`, `REV_`, `TYPE_`, `NAME_`, `EXECUTION_ID_`, `PROC_INST_ID_`, `TASK_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `META_INFO_`) VALUES ('ff6e5217-584d-11ee-9923-f22f4b0aefad', 1, 'serializable', 'variables', 'ff6d67b2-584d-11ee-9923-f22f4b0aefad', 'ff6d67b2-584d-11ee-9923-f22f4b0aefad', NULL, NULL, NULL, NULL, 'ff6e5216-584d-11ee-9923-f22f4b0aefad', NULL, NULL, NULL, NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for flw_channel_definition
-- ----------------------------
DROP TABLE IF EXISTS `flw_channel_definition`;
CREATE TABLE `flw_channel_definition` (
                                          `ID_` varchar(255) NOT NULL,
                                          `NAME_` varchar(255) DEFAULT NULL,
                                          `VERSION_` int DEFAULT NULL,
                                          `KEY_` varchar(255) DEFAULT NULL,
                                          `CATEGORY_` varchar(255) DEFAULT NULL,
                                          `DEPLOYMENT_ID_` varchar(255) DEFAULT NULL,
                                          `CREATE_TIME_` datetime(3) DEFAULT NULL,
                                          `TENANT_ID_` varchar(255) DEFAULT NULL,
                                          `RESOURCE_NAME_` varchar(255) DEFAULT NULL,
                                          `DESCRIPTION_` varchar(255) DEFAULT NULL,
                                          `TYPE_` varchar(255) DEFAULT NULL,
                                          `IMPLEMENTATION_` varchar(255) DEFAULT NULL,
                                          PRIMARY KEY (`ID_`),
                                          UNIQUE KEY `ACT_IDX_CHANNEL_DEF_UNIQ` (`KEY_`,`VERSION_`,`TENANT_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of flw_channel_definition
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for flw_ev_databasechangelog
-- ----------------------------
DROP TABLE IF EXISTS `flw_ev_databasechangelog`;
CREATE TABLE `flw_ev_databasechangelog` (
                                            `ID` varchar(255) NOT NULL,
                                            `AUTHOR` varchar(255) NOT NULL,
                                            `FILENAME` varchar(255) NOT NULL,
                                            `DATEEXECUTED` datetime NOT NULL,
                                            `ORDEREXECUTED` int NOT NULL,
                                            `EXECTYPE` varchar(10) NOT NULL,
                                            `MD5SUM` varchar(35) DEFAULT NULL,
                                            `DESCRIPTION` varchar(255) DEFAULT NULL,
                                            `COMMENTS` varchar(255) DEFAULT NULL,
                                            `TAG` varchar(255) DEFAULT NULL,
                                            `LIQUIBASE` varchar(20) DEFAULT NULL,
                                            `CONTEXTS` varchar(255) DEFAULT NULL,
                                            `LABELS` varchar(255) DEFAULT NULL,
                                            `DEPLOYMENT_ID` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of flw_ev_databasechangelog
-- ----------------------------
BEGIN;
INSERT INTO `flw_ev_databasechangelog` (`ID`, `AUTHOR`, `FILENAME`, `DATEEXECUTED`, `ORDEREXECUTED`, `EXECTYPE`, `MD5SUM`, `DESCRIPTION`, `COMMENTS`, `TAG`, `LIQUIBASE`, `CONTEXTS`, `LABELS`, `DEPLOYMENT_ID`) VALUES ('1', 'flowable', 'org/flowable/eventregistry/db/liquibase/flowable-eventregistry-db-changelog.xml', '2022-01-12 07:20:38', 1, 'EXECUTED', '8:1b0c48c9cf7945be799d868a2626d687', 'createTable tableName=FLW_EVENT_DEPLOYMENT; createTable tableName=FLW_EVENT_RESOURCE; createTable tableName=FLW_EVENT_DEFINITION; createIndex indexName=ACT_IDX_EVENT_DEF_UNIQ, tableName=FLW_EVENT_DEFINITION; createTable tableName=FLW_CHANNEL_DEFIN...', '', NULL, '3.8.9', NULL, NULL, '1972038104');
INSERT INTO `flw_ev_databasechangelog` (`ID`, `AUTHOR`, `FILENAME`, `DATEEXECUTED`, `ORDEREXECUTED`, `EXECTYPE`, `MD5SUM`, `DESCRIPTION`, `COMMENTS`, `TAG`, `LIQUIBASE`, `CONTEXTS`, `LABELS`, `DEPLOYMENT_ID`) VALUES ('2', 'flowable', 'org/flowable/eventregistry/db/liquibase/flowable-eventregistry-db-changelog.xml', '2022-01-12 07:20:38', 2, 'EXECUTED', '8:0ea825feb8e470558f0b5754352b9cda', 'addColumn tableName=FLW_CHANNEL_DEFINITION; addColumn tableName=FLW_CHANNEL_DEFINITION', '', NULL, '3.8.9', NULL, NULL, '1972038104');
INSERT INTO `flw_ev_databasechangelog` (`ID`, `AUTHOR`, `FILENAME`, `DATEEXECUTED`, `ORDEREXECUTED`, `EXECTYPE`, `MD5SUM`, `DESCRIPTION`, `COMMENTS`, `TAG`, `LIQUIBASE`, `CONTEXTS`, `LABELS`, `DEPLOYMENT_ID`) VALUES ('3', 'flowable', 'org/flowable/eventregistry/db/liquibase/flowable-eventregistry-db-changelog.xml', '2022-01-12 07:20:38', 3, 'EXECUTED', '8:3c2bb293350b5cbe6504331980c9dcee', 'customChange', '', NULL, '3.8.9', NULL, NULL, '1972038104');
COMMIT;

-- ----------------------------
-- Table structure for flw_ev_databasechangeloglock
-- ----------------------------
DROP TABLE IF EXISTS `flw_ev_databasechangeloglock`;
CREATE TABLE `flw_ev_databasechangeloglock` (
                                                `ID` int NOT NULL,
                                                `LOCKED` bit(1) NOT NULL,
                                                `LOCKGRANTED` datetime DEFAULT NULL,
                                                `LOCKEDBY` varchar(255) DEFAULT NULL,
                                                PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of flw_ev_databasechangeloglock
-- ----------------------------
BEGIN;
INSERT INTO `flw_ev_databasechangeloglock` (`ID`, `LOCKED`, `LOCKGRANTED`, `LOCKEDBY`) VALUES (1, b'0', NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for flw_event_definition
-- ----------------------------
DROP TABLE IF EXISTS `flw_event_definition`;
CREATE TABLE `flw_event_definition` (
                                        `ID_` varchar(255) NOT NULL,
                                        `NAME_` varchar(255) DEFAULT NULL,
                                        `VERSION_` int DEFAULT NULL,
                                        `KEY_` varchar(255) DEFAULT NULL,
                                        `CATEGORY_` varchar(255) DEFAULT NULL,
                                        `DEPLOYMENT_ID_` varchar(255) DEFAULT NULL,
                                        `TENANT_ID_` varchar(255) DEFAULT NULL,
                                        `RESOURCE_NAME_` varchar(255) DEFAULT NULL,
                                        `DESCRIPTION_` varchar(255) DEFAULT NULL,
                                        PRIMARY KEY (`ID_`),
                                        UNIQUE KEY `ACT_IDX_EVENT_DEF_UNIQ` (`KEY_`,`VERSION_`,`TENANT_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of flw_event_definition
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for flw_event_deployment
-- ----------------------------
DROP TABLE IF EXISTS `flw_event_deployment`;
CREATE TABLE `flw_event_deployment` (
                                        `ID_` varchar(255) NOT NULL,
                                        `NAME_` varchar(255) DEFAULT NULL,
                                        `CATEGORY_` varchar(255) DEFAULT NULL,
                                        `DEPLOY_TIME_` datetime(3) DEFAULT NULL,
                                        `TENANT_ID_` varchar(255) DEFAULT NULL,
                                        `PARENT_DEPLOYMENT_ID_` varchar(255) DEFAULT NULL,
                                        PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of flw_event_deployment
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for flw_event_resource
-- ----------------------------
DROP TABLE IF EXISTS `flw_event_resource`;
CREATE TABLE `flw_event_resource` (
                                      `ID_` varchar(255) NOT NULL,
                                      `NAME_` varchar(255) DEFAULT NULL,
                                      `DEPLOYMENT_ID_` varchar(255) DEFAULT NULL,
                                      `RESOURCE_BYTES_` longblob,
                                      PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of flw_event_resource
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for flw_ru_batch
-- ----------------------------
DROP TABLE IF EXISTS `flw_ru_batch`;
CREATE TABLE `flw_ru_batch` (
                                `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                `REV_` int DEFAULT NULL,
                                `TYPE_` varchar(64) COLLATE utf8_bin NOT NULL,
                                `SEARCH_KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                `SEARCH_KEY2_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                `CREATE_TIME_` datetime(3) NOT NULL,
                                `COMPLETE_TIME_` datetime(3) DEFAULT NULL,
                                `STATUS_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                `BATCH_DOC_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
                                PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;

-- ----------------------------
-- Records of flw_ru_batch
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for flw_ru_batch_part
-- ----------------------------
DROP TABLE IF EXISTS `flw_ru_batch_part`;
CREATE TABLE `flw_ru_batch_part` (
                                     `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                     `REV_` int DEFAULT NULL,
                                     `BATCH_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                     `TYPE_` varchar(64) COLLATE utf8_bin NOT NULL,
                                     `SCOPE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                     `SUB_SCOPE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                     `SCOPE_TYPE_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                     `SEARCH_KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                     `SEARCH_KEY2_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                     `CREATE_TIME_` datetime(3) NOT NULL,
                                     `COMPLETE_TIME_` datetime(3) DEFAULT NULL,
                                     `STATUS_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                     `RESULT_DOC_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                     `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
                                     PRIMARY KEY (`ID_`),
                                     KEY `FLW_IDX_BATCH_PART` (`BATCH_ID_`),
                                     CONSTRAINT `FLW_FK_BATCH_PART_PARENT` FOREIGN KEY (`BATCH_ID_`) REFERENCES `flw_ru_batch` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;

-- ----------------------------
-- Records of flw_ru_batch_part
-- ----------------------------
BEGIN;
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
