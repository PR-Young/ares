-- ----------------------------
-- Table structure for gen_datasource
-- ----------------------------
DROP TABLE IF EXISTS `gen_datasource`;
CREATE TABLE `gen_datasource` (
                                  `ID_` bigint NOT NULL COMMENT '主键',
                                  `DATASOURCE_TYPE_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '数据源类型',
                                  `DATASOURCE_URL_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '数据源链接',
                                  `DATASOURCE_USERNAME_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '数据源用户名',
                                  `DATASOURCE_PASSWORD_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '数据源密码',
                                  `DATASOURCE_DRIVER_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '数据源驱动',
                                  `CREATOR_` bigint DEFAULT NULL COMMENT '创建人',
                                  `CREATE_TIME_` datetime DEFAULT NULL COMMENT '创建时间',
                                  `MODIFIER_` bigint DEFAULT NULL COMMENT '修改人',
                                  `MODIFY_TIME_` datetime DEFAULT NULL COMMENT '修改时间',
                                  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='数据源';

-- ----------------------------
-- Table structure for gen_history
-- ----------------------------
DROP TABLE IF EXISTS `gen_history`;
CREATE TABLE `gen_history` (
                               `ID_` bigint NOT NULL COMMENT '主键',
                               `GEN_NAME_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '生成名称',
                               `TEMPLATE_ID_` bigint NOT NULL COMMENT '模版ID',
                               `DATASOURCE_ID_` bigint NOT NULL COMMENT '数据源ID',
                               `PROPERTIES_ID_` bigint NOT NULL COMMENT '配置ID',
                               `CONTENT_` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci COMMENT '备注',
                               `CREATOR_` bigint DEFAULT NULL COMMENT '创建人',
                               `CREATE_TIME_` datetime DEFAULT NULL COMMENT '创建时间',
                               `MODIFIER_` bigint DEFAULT NULL COMMENT '修改人',
                               `MODIFY_TIME_` datetime DEFAULT NULL COMMENT '修改时间',
                               PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='生成历史';

-- ----------------------------
-- Table structure for gen_properties
-- ----------------------------
DROP TABLE IF EXISTS `gen_properties`;
CREATE TABLE `gen_properties` (
                                  `ID_` bigint NOT NULL COMMENT '主键',
                                  `BASE_PACKAGE_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '包名',
                                  `ENTITY_PACKAGE_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '实体包名',
                                  `DAO_PACKAGE_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT 'dao包名',
                                  `SERVICE_PACKAGE_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT 'service包名',
                                  `CONTROLLER_PACKAGE_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT 'controller包名',
                                  `TABLE_PREFIX_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '表前缀',
                                  `FILE_PREFIX_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '文件前缀',
                                  `FILE_SUFFIX_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '文件后缀',
                                  `AUTHOR_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '作者',
                                  `GEN_LEVEL_` int DEFAULT NULL COMMENT '生成层级',
                                  `CREATOR_` bigint DEFAULT NULL COMMENT '创建人',
                                  `CREATE_TIME_` datetime DEFAULT NULL COMMENT '创建时间',
                                  `MODIFIER_` bigint DEFAULT NULL COMMENT '修改人',
                                  `MODIFY_TIME_` datetime DEFAULT NULL COMMENT '修改时间',
                                  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='生成配置';

-- ----------------------------
-- Table structure for gen_template
-- ----------------------------
DROP TABLE IF EXISTS `gen_template`;
CREATE TABLE `gen_template` (
                                `ID_` bigint NOT NULL COMMENT '主键',
                                `TEMPLATE_TYPE_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '模版类型',
                                `TEMPLATE_NAME_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '模版名称',
                                `TEMPLATE_CONTENT_` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci COMMENT '模版内容',
                                `CREATOR_` bigint DEFAULT NULL COMMENT '创建人',
                                `CREATE_TIME_` datetime DEFAULT NULL COMMENT '创建时间',
                                `MODIFIER_` bigint DEFAULT NULL COMMENT '修改人',
                                `MODIFY_TIME_` datetime DEFAULT NULL COMMENT '修改时间',
                                PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='模版';
