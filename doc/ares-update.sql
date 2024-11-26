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


ALTER TABLE `jimu_report_share`
    ADD UNIQUE INDEX `uniq_report_id`(`report_id`);

ALTER TABLE jimu_report_share
    ADD COLUMN share_token varchar(50) NULL COMMENT '分享token' AFTER preview_lock_status,
ADD UNIQUE INDEX uniq_jrs_share_token(share_token);

ALTER TABLE `jimu_report`
    ADD COLUMN `py_str` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL COMMENT 'py增强' AFTER `js_str`;

-- 积木报表加乐观锁---
ALTER TABLE jimu_report
    ADD COLUMN update_count int NULL DEFAULT 0 COMMENT '乐观锁版本' AFTER tenant_id;
-- 版本默认为0
update jimu_report set update_count = 0 where update_count is null;

-- 在线填报功能 ---
ALTER TABLE jimu_report
    ADD COLUMN `submit_form` tinyint(1) NULL COMMENT '是否填报报表 0不是,1是' ;

-- 支持自定义目录树---
ALTER TABLE jimu_report
    MODIFY COLUMN type varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '类型' AFTER status;

-- 支持自定义目录树---
DROP TABLE IF EXISTS `jimu_report_category`;
CREATE TABLE `jimu_report_category`  (
                                         `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '主键',
                                         `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '分类名称',
                                         `parent_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '父级id',
                                         `iz_leaf` int(1) NULL DEFAULT NULL COMMENT '是否为叶子节点(0 否 1是)',
                                         `source_type` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '来源类型( report 积木报表 screen 大屏  drag 仪表盘)',
                                         `del_flag` int(1) NULL DEFAULT NULL COMMENT '删除标识(0 正常 1 已删除)',
                                         `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
                                         `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间',
                                         `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新人',
                                         `update_time` timestamp NULL DEFAULT NULL COMMENT '更新时间',
                                         `tenant_id` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '租户id',
                                         PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '分类' ROW_FORMAT = Dynamic;

INSERT INTO jimu_report_category (id, name, parent_id, iz_leaf, source_type, del_flag, create_by, create_time, update_by, update_time, tenant_id) VALUES ('984272091947253760', '数据报表', '0', 1, 'report', 0, 'admin', '2024-08-16 11:52:44', NULL, NULL, '1000');
INSERT INTO jimu_report_category (id, name, parent_id, iz_leaf, source_type, del_flag, create_by, create_time, update_by, update_time, tenant_id) VALUES ('984302961118724096', '图形报表', '0', 1, 'report', 0, 'admin', '2024-08-16 13:55:24', NULL, NULL, '1000');
INSERT INTO jimu_report_category (id, name, parent_id, iz_leaf, source_type, del_flag, create_by, create_time, update_by, update_time, tenant_id) VALUES ('984302991393210368', '打印设计', '0', 1, 'report', 0, 'admin', '2024-08-16 13:55:31', NULL, NULL, '1000');
update jimu_report set type = '984302991393210368' where type = 'printinfo';
update jimu_report set type = '984272091947253760' where type = 'datainfo';
update jimu_report set type = '984302961118724096' where type = 'chartinfo';


-- 自动导出日志表---
CREATE TABLE IF NOT EXISTS `jimu_report_export_log`  (
    `id` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
    `batch_no` varchar(50) NULL COMMENT '批次编号',
    `export_channel` varchar(20) NULL COMMENT '导出渠道',
    `export_type` varchar(10) NULL COMMENT '导出类型',
    `report_id` text NULL COMMENT '报表id',
    `download_path` varchar(255) NULL COMMENT '下载路径',
    `status` varchar(15) NULL COMMENT '状态',
    `create_by` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '创建人',
    `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
    `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
    `tenant_id` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '多租户标识',
    PRIMARY KEY (`id`)
    ) COMMENT = '积木报表自动导出记录表';
-- 在线填报--示例:员工信息登记表 ---
-- 字典数据： 民族
INSERT INTO `jimu_dict` (`id`, `dict_name`, `dict_code`, `description`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `type`, `tenant_id`) VALUES ('986779503584169984', '民族', 'minzu', '', 0, 'admin', '2024-08-23 09:56:17', NULL, NULL, NULL, NULL);
INSERT INTO `jimu_dict_item` (`id`, `dict_id`, `item_text`, `item_value`, `description`, `sort_order`, `status`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES ('986779561591394304', '986779503584169984', '汉族', 'hanzu', NULL, 1, 1, 'admin', '2024-08-23 09:56:31', 'admin', '2024-08-23 09:56:45');
INSERT INTO `jimu_dict_item` (`id`, `dict_id`, `item_text`, `item_value`, `description`, `sort_order`, `status`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES ('986779602800431104', '986779503584169984', '回族', 'huizu', NULL, 1, 1, 'admin', '2024-08-23 09:56:41', NULL, NULL);
INSERT INTO `jimu_dict_item` (`id`, `dict_id`, `item_text`, `item_value`, `description`, `sort_order`, `status`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES ('986779663689142272', '986779503584169984', '维吾尔族', 'weiwuer', NULL, 1, 1, 'admin', '2024-08-23 09:56:56', NULL, NULL);
INSERT INTO `jimu_dict_item` (`id`, `dict_id`, `item_text`, `item_value`, `description`, `sort_order`, `status`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES ('986779697352626176', '986779503584169984', '藏族', 'zangzu', NULL, 1, 1, 'admin', '2024-08-23 09:57:04', NULL, NULL);


-- 字典数据： 学历
INSERT INTO `jimu_dict` (`id`, `dict_name`, `dict_code`, `description`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `type`, `tenant_id`) VALUES ('986783181955223552', '学历', 'xueli_sf', '', 0, 'admin', '2024-08-23 10:10:54', NULL, NULL, NULL, NULL);
INSERT INTO `jimu_dict_item` (`id`, `dict_id`, `item_text`, `item_value`, `description`, `sort_order`, `status`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES ('986783239996002304', '986783181955223552', '文盲', '0', NULL, 1, 1, 'admin', '2024-08-23 10:11:08', NULL, NULL);
INSERT INTO `jimu_dict_item` (`id`, `dict_id`, `item_text`, `item_value`, `description`, `sort_order`, `status`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES ('986783271616860160', '986783181955223552', '小学', '1', NULL, 1, 1, 'admin', '2024-08-23 10:11:16', NULL, NULL);
INSERT INTO `jimu_dict_item` (`id`, `dict_id`, `item_text`, `item_value`, `description`, `sort_order`, `status`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES ('986783303967526912', '986783181955223552', '初中', '2', NULL, 1, 1, 'admin', '2024-08-23 10:11:23', NULL, NULL);
INSERT INTO `jimu_dict_item` (`id`, `dict_id`, `item_text`, `item_value`, `description`, `sort_order`, `status`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES ('986783326532882432', '986783181955223552', '高中', '3', NULL, 1, 1, 'admin', '2024-08-23 10:11:29', NULL, NULL);
INSERT INTO `jimu_dict_item` (`id`, `dict_id`, `item_text`, `item_value`, `description`, `sort_order`, `status`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES ('986783354462752768', '986783181955223552', '专科', '4', NULL, 1, 1, 'admin', '2024-08-23 10:11:35', NULL, NULL);
INSERT INTO `jimu_dict_item` (`id`, `dict_id`, `item_text`, `item_value`, `description`, `sort_order`, `status`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES ('986783373504892928', '986783181955223552', '本科', '5', NULL, 1, 1, 'admin', '2024-08-23 10:11:40', NULL, NULL);
INSERT INTO `jimu_dict_item` (`id`, `dict_id`, `item_text`, `item_value`, `description`, `sort_order`, `status`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES ('986783415494070272', '986783181955223552', '研究生', '6', NULL, 1, 1, 'admin', '2024-08-23 10:11:50', NULL, NULL);
INSERT INTO `jimu_dict_item` (`id`, `dict_id`, `item_text`, `item_value`, `description`, `sort_order`, `status`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES ('986783438734708736', '986783181955223552', '博士', '7', NULL, 1, 1, 'admin', '2024-08-23 10:11:56', NULL, NULL);

-- 字典数据： 爱好
INSERT INTO `jimu_dict` (`id`, `dict_name`, `dict_code`, `description`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `type`, `tenant_id`) VALUES ('986784113082322944', '爱好', 'aihao', '', 0, 'admin', '2024-08-23 10:14:36', NULL, NULL, NULL, NULL);
INSERT INTO `jimu_dict_item` (`id`, `dict_id`, `item_text`, `item_value`, `description`, `sort_order`, `status`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES ('986784154379440128', '986784113082322944', '音乐', '0', NULL, 1, 1, 'admin', '2024-08-23 10:14:46', NULL, NULL);
INSERT INTO `jimu_dict_item` (`id`, `dict_id`, `item_text`, `item_value`, `description`, `sort_order`, `status`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES ('986784179134222336', '986784113082322944', '运动', '1', NULL, 1, 1, 'admin', '2024-08-23 10:14:52', NULL, NULL);
INSERT INTO `jimu_dict_item` (`id`, `dict_id`, `item_text`, `item_value`, `description`, `sort_order`, `status`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES ('986784205717721088', '986784113082322944', '舞蹈', '2', NULL, 1, 1, 'admin', '2024-08-23 10:14:58', NULL, NULL);
INSERT INTO `jimu_dict_item` (`id`, `dict_id`, `item_text`, `item_value`, `description`, `sort_order`, `status`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES ('986784229390372864', '986784113082322944', '棋牌', '3', NULL, 1, 1, 'admin', '2024-08-23 10:15:04', NULL, NULL);
INSERT INTO `jimu_dict_item` (`id`, `dict_id`, `item_text`, `item_value`, `description`, `sort_order`, `status`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES ('986784260960899072', '986784113082322944', '电竞', '4', NULL, 1, 1, 'admin', '2024-08-23 10:15:12', NULL, NULL);

-- 报表数据
INSERT INTO `jimu_report` (`id`, `code`, `name`, `note`, `status`, `type`, `json_str`, `api_url`, `thumb`, `create_by`, `create_time`, `update_by`, `update_time`, `del_flag`, `api_method`, `api_code`, `template`, `view_count`, `css_str`, `js_str`, `py_str`, `tenant_id`, `update_count`, `submit_form`) VALUES ('989065112487022592', '20240823093133__1750', '在线填报-员工信息登记', NULL, NULL, 'datainfo', '{\"loopBlockList\":[],\"querySetting\":{\"izOpenQueryBar\":false,\"izDefaultQuery\":true},\"printConfig\":{\"paper\":\"A4\",\"width\":210,\"height\":297,\"definition\":1,\"isBackend\":false,\"marginX\":10,\"marginY\":10,\"layout\":\"portrait\",\"printCallBackUrl\":\"\"},\"hidden\":{\"rows\":[],\"cols\":[]},\"dbexps\":[],\"dicts\":[],\"freeze\":\"A1\",\"dataRectWidth\":698,\"autofilter\":{},\"validations\":[],\"cols\":{\"0\":{\"width\":76},\"1\":{\"width\":114},\"2\":{\"width\":87},\"3\":{\"width\":99},\"4\":{\"width\":65},\"5\":{\"width\":126},\"6\":{\"width\":131},\"len\":100},\"area\":{\"sri\":10,\"sci\":9,\"eri\":10,\"eci\":9,\"width\":100,\"height\":121},\"pyGroupEngine\":false,\"submitHandlers\":[{\"type\":\"api\",\"code\":\"api\",\"name\":\"api\",\"isMain\":true,\"isEdit\":true,\"apiUrl\":\"https://bootapi.jeecg.com/jmreport/test/submit/handle\"}],\"excel_config_id\":\"989065112487022592\",\"hiddenCells\":[],\"zonedEditionList\":[],\"rows\":{\"0\":{\"cells\":{\"0\":{\"merge\":[1,6],\"height\":90,\"text\":\"员工信息登记表\",\"style\":6}},\"height\":45},\"1\":{\"cells\":{},\"height\":45},\"2\":{\"cells\":{\"0\":{\"text\":\"编号\",\"style\":7,\"fillFormLabel\":\"*\"},\"1\":{\"fillForm\":{\"componentFlag\":\"input-text\",\"component\":\"Input\",\"field\":\"no\",\"value\":\"\",\"defaultValue\":\"\",\"placeholder\":\"\",\"required\":false,\"requiredTip\":\"不能为空~\",\"pattern\":\"\",\"patternErrorTip\":\"\"},\"style\":7,\"text\":\" \"},\"2\":{\"text\":\"年龄\",\"style\":7},\"3\":{\"fillForm\":{\"componentFlag\":\"InputNumber\",\"component\":\"InputNumber\",\"field\":\"age\",\"placeholder\":\"\",\"required\":false,\"requiredTip\":\"不能为空~\",\"label\":\"\",\"labelText\":\"\",\"precision\":0,\"isLimitMinNum\":false,\"minNum\":0,\"isLimitMaxNum\":false,\"maxNum\":100,\"dbFieldBind\":[{\"dbTable\":\"test_form_submit\",\"dbField\":\"age\"}]},\"style\":7,\"text\":\" \"},\"4\":{\"text\":\"填写时间\",\"style\":7},\"5\":{\"fillForm\":{\"componentFlag\":\"DatePicker-time\",\"component\":\"DatePicker\",\"field\":\"create_time\",\"placeholder\":\"\",\"required\":false,\"requiredTip\":\"不能为空~\",\"label\":\"\",\"labelText\":\"\",\"dateFormat\":\"yyyy-MM-dd HH:mm:ss\",\"defaultValue\":\"\"},\"style\":7,\"text\":\" \"},\"6\":{\"merge\":[3,0],\"height\":180,\"fillForm\":{\"componentFlag\":\"JUploadImage\",\"component\":\"JUploadImage\",\"field\":\"photo\",\"value\":\"\",\"defaultValue\":\"\",\"placeholder\":\"\",\"required\":false,\"requiredTip\":\"不能为空~\",\"multiple\":false,\"maxUploadNum\":1,\"h_align\":\"center\"},\"style\":7,\"text\":\" \"}},\"height\":45},\"3\":{\"cells\":{\"0\":{\"text\":\"姓名\",\"style\":7,\"fillFormLabel\":\"*\"},\"1\":{\"text\":\" \",\"fillForm\":{\"componentFlag\":\"input-text\",\"component\":\"Input\",\"field\":\"name\",\"placeholder\":\"\",\"required\":true,\"requiredTip\":\"不能为空~\",\"dbFieldBind\":[{\"dbTable\":\"test_form_submit\",\"dbField\":\"name\"},{\"dbTable\":\"test_form_submit1\",\"dbField\":\"name\"}],\"label\":\"A5\",\"labelText\":\"姓名\",\"pattern\":\"\",\"patternErrorTip\":\"\"}},\"2\":{\"text\":\"性别\",\"style\":7},\"3\":{\"fillForm\":{\"componentFlag\":\"JRadio\",\"component\":\"JRadio\",\"field\":\"sex\",\"value\":\"\",\"defaultValue\":\"\",\"placeholder\":\"\",\"required\":false,\"requiredTip\":\"不能为空~\",\"dataSource\":\"dict\",\"options\":[{\"label\":\"男\",\"value\":\"1\"},{\"label\":\"女\",\"value\":\"2\"}],\"apiUrl\":\"\",\"dictCode\":\"sex1\",\"dictName\":\"性别\"},\"style\":8,\"text\":\" \"},\"4\":{\"text\":\"出生日期\",\"style\":7},\"5\":{\"fillForm\":{\"componentFlag\":\"DatePicker-date\",\"component\":\"DatePicker\",\"field\":\"brithday\",\"value\":\"\",\"defaultValue\":\"\",\"placeholder\":\"\",\"required\":false,\"requiredTip\":\"不能为空~\",\"dateFormat\":\"yyyy-MM-dd\",\"dateShowType\":\"date\"},\"style\":7,\"text\":\" \"},\"8\":{}},\"height\":45},\"4\":{\"cells\":{\"0\":{\"text\":\"民族\",\"style\":7,\"fillFormLabel\":\"*\"},\"1\":{\"fillForm\":{\"componentFlag\":\"JSelect\",\"component\":\"JSelect\",\"field\":\"nation\",\"value\":\"\",\"defaultValue\":\"\",\"placeholder\":\"\",\"required\":false,\"requiredTip\":\"不能为空~\",\"dataSource\":\"dict\",\"options\":[{\"label\":\"选项1\",\"value\":\"1\"},{\"label\":\"选项2\",\"value\":\"2\"},{\"label\":\"选项3\",\"value\":\"3\"}],\"apiUrl\":\"\",\"dictCode\":\"minzu\",\"dictName\":\"民族\",\"multiple\":\"\"},\"style\":7,\"text\":\" \"},\"2\":{\"text\":\"政治面貌\",\"style\":7},\"3\":{\"fillForm\":{\"componentFlag\":\"JSelect\",\"component\":\"JSelect\",\"field\":\"politics\",\"value\":\"\",\"defaultValue\":\"\",\"placeholder\":\"\",\"required\":false,\"requiredTip\":\"不能为空~\",\"dbFieldBind\":[{\"dbTable\":\"test_form_submit\",\"dbField\":\"politics\"}],\"dataSource\":\"api\",\"options\":[{\"label\":\"选项1\",\"value\":\"1\"},{\"label\":\"选项2\",\"value\":\"2\"},{\"label\":\"选项3\",\"value\":\"3\"}],\"apiUrl\":\"https://bootapi.jeecg.com/jmreport/test/submit/dict/political\",\"dictCode\":\"\",\"dictName\":\"\",\"multiple\":\"\"},\"style\":7,\"text\":\" \"},\"4\":{\"text\":\"籍贯\",\"style\":7},\"5\":{\"fillForm\":{\"componentFlag\":\"JAreaLinkage\",\"component\":\"JAreaLinkage\",\"field\":\"native_place\",\"value\":\"\",\"defaultValue\":\"\",\"placeholder\":\"\",\"required\":false,\"requiredTip\":\"不能为空~\",\"dbFieldBind\":[{\"dbTable\":\"test_form_submit\",\"dbField\":\"native_place\"}],\"areaType\":\"region\"},\"style\":7,\"text\":\" \"}},\"height\":45},\"5\":{\"cells\":{\"0\":{\"text\":\"身高（cm)\",\"style\":7},\"1\":{\"fillForm\":{\"componentFlag\":\"InputNumber\",\"component\":\"InputNumber\",\"field\":\"height\",\"value\":\"\",\"defaultValue\":\"\",\"placeholder\":\"\",\"required\":false,\"requiredTip\":\"不能为空~\",\"dbFieldBind\":[{\"dbTable\":\"test_form_submit\",\"dbField\":\"height\"}],\"precision\":2,\"isLimitMinNum\":false,\"minNum\":50,\"isLimitMaxNum\":false,\"maxNum\":200},\"style\":7,\"text\":\" \"},\"2\":{\"text\":\"体重\",\"style\":7},\"3\":{\"fillForm\":{\"componentFlag\":\"InputNumber\",\"component\":\"InputNumber\",\"field\":\"weight\",\"value\":\"\",\"defaultValue\":\"\",\"placeholder\":\"\",\"required\":false,\"requiredTip\":\"不能为空~\",\"dbFieldBind\":[{\"dbTable\":\"test_form_submit\",\"dbField\":\"weight\"}],\"precision\":2,\"isLimitMinNum\":false,\"minNum\":30,\"isLimitMaxNum\":false,\"maxNum\":300},\"style\":7,\"text\":\" \"},\"4\":{\"text\":\"健康状况\",\"style\":7},\"5\":{\"fillForm\":{\"componentFlag\":\"JSelect\",\"component\":\"JSelect\",\"field\":\"health\",\"value\":\"\",\"defaultValue\":\"\",\"placeholder\":\"\",\"required\":false,\"requiredTip\":\"不能为空~\",\"dataSource\":\"static\",\"options\":[{\"label\":\"健康\",\"value\":\"1\"},{\"label\":\"不健康\",\"value\":\"2\"}],\"apiUrl\":\"\",\"dictCode\":\"\",\"dictName\":\"\",\"multiple\":\"\"},\"style\":7,\"text\":\" \"}},\"height\":45},\"6\":{\"cells\":{\"0\":{\"text\":\"身份证号\",\"style\":7},\"1\":{\"merge\":[0,2],\"height\":45,\"fillForm\":{\"componentFlag\":\"input-text\",\"component\":\"Input\",\"field\":\"idcard\",\"value\":\"\",\"defaultValue\":\"\",\"placeholder\":\"\",\"required\":false,\"requiredTip\":\"不能为空~\",\"pattern\":\"^\\\\d{17}[\\\\dX]$\",\"patternErrorTip\":\"请输入身份证号\",\"dbFieldBind\":[{\"dbTable\":\"test_form_submit\",\"dbField\":\"id_card\"}]},\"style\":7,\"text\":\" \"},\"4\":{\"text\":\"学历\",\"style\":7},\"5\":{\"fillForm\":{\"componentFlag\":\"JSelect\",\"component\":\"JSelect\",\"field\":\"people\",\"value\":\"\",\"defaultValue\":\"\",\"placeholder\":\"\",\"required\":false,\"requiredTip\":\"不能为空~\",\"dataSource\":\"dict\",\"options\":[{\"label\":\"选项1\",\"value\":\"1\"},{\"label\":\"选项2\",\"value\":\"2\"},{\"label\":\"选项3\",\"value\":\"3\"}],\"apiUrl\":\"\",\"dictCode\":\"xueli_sf\",\"dictName\":\"学历\",\"multiple\":true},\"style\":7,\"text\":\" \",\"merge\":[0,1],\"height\":45}},\"height\":45},\"7\":{\"cells\":{\"0\":{\"text\":\"联系地址\",\"style\":7},\"1\":{\"fillForm\":{\"componentFlag\":\"input-text\",\"component\":\"Input\",\"field\":\"addr\",\"value\":\"\",\"defaultValue\":\"\",\"placeholder\":\"\",\"required\":false,\"requiredTip\":\"不能为空~\",\"dbFieldBind\":[{\"dbTable\":\"test_form_submit\",\"dbField\":\"address\"}],\"pattern\":\"\",\"patternErrorTip\":\"\"},\"merge\":[0,2],\"height\":45,\"style\":7,\"text\":\" \"},\"4\":{\"text\":\"手机号\",\"style\":7},\"5\":{\"fillForm\":{\"componentFlag\":\"input-text\",\"component\":\"Input\",\"field\":\"phone\",\"value\":\"\",\"defaultValue\":\"\",\"placeholder\":\"\",\"required\":false,\"requiredTip\":\"不能为空~\",\"dbFieldBind\":[{\"dbTable\":\"test_form_submit\",\"dbField\":\"phone\"}],\"pattern\":\"\",\"patternErrorTip\":\"\"},\"style\":7,\"text\":\" \",\"merge\":[0,1],\"height\":45}},\"height\":45},\"8\":{\"cells\":{\"0\":{\"text\":\"毕业证书\",\"style\":7},\"1\":{\"merge\":[0,2],\"height\":45,\"fillForm\":{\"componentFlag\":\"JUploadFile\",\"component\":\"JUploadFile\",\"field\":\"ca\",\"value\":\"\",\"defaultValue\":\"\",\"placeholder\":\"\",\"required\":false,\"requiredTip\":\"不能为空~\",\"multiple\":false,\"maxUploadNum\":1,\"dbFieldBind\":[{\"dbTable\":\"test_form_submit\",\"dbField\":\"ca\"}]},\"style\":9,\"text\":\" \"},\"4\":{\"text\":\"幸运色\",\"style\":7},\"5\":{\"fillForm\":{\"componentFlag\":\"ColorPicker\",\"component\":\"ColorPicker\",\"field\":\"lucky_color\",\"value\":\"\",\"defaultValue\":\"\",\"placeholder\":\"\",\"required\":false,\"requiredTip\":\"不能为空~\",\"alpha\":false},\"style\":7,\"text\":\" \",\"merge\":[0,1],\"height\":45}},\"height\":45},\"9\":{\"cells\":{\"0\":{\"text\":\"教育经历\",\"merge\":[0,6],\"height\":45,\"style\":8}},\"height\":45},\"10\":{\"cells\":{\"0\":{\"merge\":[0,6],\"height\":121,\"fillForm\":{\"componentFlag\":\"input-textarea\",\"component\":\"Input\",\"field\":\"education\",\"value\":\"\",\"defaultValue\":\"\",\"placeholder\":\"\",\"required\":false,\"requiredTip\":\"不能为空~\",\"dbFieldBind\":[{\"dbTable\":\"test_form_submit\",\"dbField\":\"education\"}],\"pattern\":\"\",\"patternErrorTip\":\"\"},\"style\":7,\"text\":\" \"}},\"height\":121},\"11\":{\"cells\":{\"0\":{\"text\":\"工作经历\",\"merge\":[0,6],\"height\":45,\"style\":8}},\"height\":45},\"12\":{\"cells\":{\"0\":{\"merge\":[0,6],\"height\":150,\"fillForm\":{\"componentFlag\":\"input-textarea\",\"component\":\"Input\",\"field\":\"work_exp\",\"value\":\"\",\"defaultValue\":\"\",\"placeholder\":\"\",\"required\":false,\"requiredTip\":\"不能为空~\",\"dbFieldBind\":[{\"dbTable\":\"test_form_submit\",\"dbField\":\"work_exp\"}],\"pattern\":\"\",\"patternErrorTip\":\"\"},\"style\":7,\"text\":\" \"}},\"height\":150},\"13\":{\"cells\":{\"0\":{\"text\":\"爱好\",\"style\":7},\"1\":{\"merge\":[0,5],\"height\":45,\"fillForm\":{\"componentFlag\":\"JCheckbox\",\"component\":\"JCheckbox\",\"field\":\"fruity\",\"value\":\"\",\"defaultValue\":\"\",\"placeholder\":\"\",\"required\":false,\"requiredTip\":\"不能为空~\",\"dbFieldBind\":[{\"dbTable\":\"test_form_submit\",\"dbField\":\"fruity\"}],\"dataSource\":\"dict\",\"options\":[{\"label\":\"选项1\",\"value\":\"1\"},{\"label\":\"选项2\",\"value\":\"2\"},{\"label\":\"选项3\",\"value\":\"3\"}],\"apiUrl\":\"\",\"dictCode\":\"aihao\",\"dictName\":\"爱好\"},\"style\":7,\"text\":\" \"}},\"height\":45},\"14\":{\"cells\":{\"0\":{\"text\":\"所属部门\",\"style\":7},\"1\":{\"fillForm\":{\"componentFlag\":\"JDepartment\",\"component\":\"JDepartment\",\"field\":\"dept\",\"value\":\"\",\"defaultValue\":\"\",\"placeholder\":\"\",\"required\":false,\"requiredTip\":\"不能为空~\",\"dbFieldBind\":[{\"dbTable\":\"test_form_submit\",\"dbField\":\"dept\"}],\"multiple\":true,\"apiUrl\":\"http://192.168.1.69:8086/jmreport/test/getDepartmentList\"},\"merge\":[0,2],\"height\":45,\"style\":7,\"text\":\" \"},\"4\":{\"text\":\"薪资\",\"style\":7},\"5\":{\"fillForm\":{\"componentFlag\":\"JMoney\",\"component\":\"JMoney\",\"field\":\"pay\",\"placeholder\":\"\",\"required\":false,\"requiredTip\":\"不能为空~\",\"label\":\"\",\"labelText\":\"\",\"precision\":0,\"addon\":\"prepend\",\"moenyUnit\":\"￥\"},\"style\":7,\"text\":\" \",\"merge\":[0,1],\"height\":45}},\"height\":45},\"15\":{\"cells\":{\"0\":{\"text\":\"角色\",\"style\":7},\"1\":{\"merge\":[0,2],\"height\":45,\"fillForm\":{\"componentFlag\":\"JRole\",\"component\":\"JRole\",\"field\":\"role\",\"value\":\"\",\"defaultValue\":\"\",\"placeholder\":\"\",\"required\":false,\"requiredTip\":\"不能为空~\",\"multiple\":false,\"apiUrl\":\"https://bootapi.jeecg.com/jmreport/test/getRoleList\",\"dbFieldBind\":[{\"dbTable\":\"test_form_submit\",\"dbField\":\"role\"}]},\"style\":7,\"text\":\" \"},\"4\":{\"style\":7,\"text\":\"工位\"},\"5\":{\"style\":7,\"text\":\" \",\"merge\":[0,1],\"height\":45,\"fillForm\":{\"componentFlag\":\"JSelect\",\"component\":\"JSelect\",\"field\":\"station\",\"placeholder\":\"\",\"required\":false,\"requiredTip\":\"不能为空~\",\"label\":\"\",\"labelText\":\"\",\"dataSource\":\"static\",\"options\":[{\"label\":\"101\",\"value\":\"1\"},{\"label\":\"102\",\"value\":\"2\"},{\"label\":\"103\",\"value\":\"3\"},{\"label\":\"104\",\"value\":\"4\"}],\"apiUrl\":\"\",\"dictCode\":\"\",\"dictName\":\"\",\"multiple\":true}}},\"height\":45},\"16\":{\"cells\":{\"0\":{\"text\":\"直属领导\",\"style\":7},\"1\":{\"fillForm\":{\"componentFlag\":\"JUser\",\"component\":\"JUser\",\"field\":\"leader\",\"value\":\"\",\"defaultValue\":\"\",\"placeholder\":\"\",\"required\":false,\"requiredTip\":\"不能为空~\",\"multiple\":false,\"apiUrl\":\"https://bootapi.jeecg.com/jmreport/test/getUserList\",\"dbFieldBind\":[{\"dbTable\":\"test_form_submit\",\"dbField\":\"leader\"}]},\"merge\":[0,2],\"height\":45,\"style\":7,\"text\":\" \"},\"4\":{\"style\":7,\"text\":\"是否启用\"},\"5\":{\"style\":10,\"text\":\" \",\"merge\":[0,1],\"height\":45,\"fillForm\":{\"componentFlag\":\"JSwitch\",\"component\":\"JSwitch\",\"field\":\"status\",\"placeholder\":\"\",\"required\":false,\"requiredTip\":\"不能为空~\",\"dbFieldBind\":[{\"dbTable\":\"test_form_submit\",\"dbField\":\"status\"}],\"label\":\"\",\"labelText\":\"\",\"switchOpen\":\"Y\",\"switchClose\":\"N\",\"h_align\":\"center\"}},\"6\":{}},\"height\":45},\"17\":{\"cells\":{\"0\":{\"style\":7,\"text\":\"负责部门\"},\"1\":{\"fillForm\":{\"componentFlag\":\"JSelectTree\",\"component\":\"JSelectTree\",\"field\":\"responsible\",\"value\":\"\",\"defaultValue\":\"\",\"placeholder\":\"\",\"required\":false,\"requiredTip\":\"不能为空~\",\"multiple\":true,\"apiUrl\":\"https://bootapi.jeecg.com/jmreport/test/getDepartmentList\"},\"style\":7,\"text\":\" \",\"merge\":[0,2],\"height\":45},\"4\":{\"style\":7,\"text\":\"上班时间\"},\"5\":{\"style\":7,\"text\":\" \",\"merge\":[0,1],\"height\":45,\"fillForm\":{\"componentFlag\":\"TimePicker\",\"component\":\"TimePicker\",\"field\":\"key_1724408224853_326455\",\"placeholder\":\"\",\"required\":false,\"requiredTip\":\"不能为空~\",\"label\":\"\",\"labelText\":\"\",\"isRangTime\":false,\"timeType\":\"time\"}}},\"height\":45},\"20\":{\"cells\":{\"6\":{}}},\"len\":201},\"rpbar\":{\"show\":true,\"pageSize\":\"\",\"btnList\":[]},\"fixedPrintHeadRows\":[],\"fixedPrintTailRows\":[],\"displayConfig\":{},\"background\":false,\"name\":\"sheet1\",\"styles\":[{\"align\":\"center\"},{\"align\":\"center\",\"valign\":\"middle\"},{\"align\":\"center\",\"valign\":\"middle\",\"font\":{\"size\":16}},{\"font\":{\"size\":16}},{\"align\":\"center\",\"valign\":\"middle\",\"font\":{\"size\":16,\"bold\":true}},{\"font\":{\"size\":16,\"bold\":true}},{\"align\":\"center\",\"valign\":\"middle\",\"font\":{\"size\":16,\"bold\":true},\"border\":{\"bottom\":[\"thin\",\"#000\"],\"top\":[\"thin\",\"#000\"],\"left\":[\"thin\",\"#000\"],\"right\":[\"thin\",\"#000\"]}},{\"border\":{\"bottom\":[\"thin\",\"#000\"],\"top\":[\"thin\",\"#000\"],\"left\":[\"thin\",\"#000\"],\"right\":[\"thin\",\"#000\"]}},{\"align\":\"center\",\"border\":{\"bottom\":[\"thin\",\"#000\"],\"top\":[\"thin\",\"#000\"],\"left\":[\"thin\",\"#000\"],\"right\":[\"thin\",\"#000\"]}},{\"align\":\"center\",\"border\":{\"bottom\":[\"thin\",\"#000\"],\"top\":[\"thin\",\"#000\"],\"left\":[\"thin\",\"#000\"],\"right\":[\"thin\",\"#000\"]},\"valign\":\"middle\"},{\"align\":\"right\",\"border\":{\"bottom\":[\"thin\",\"#000\"],\"top\":[\"thin\",\"#000\"],\"left\":[\"thin\",\"#000\"],\"right\":[\"thin\",\"#000\"]}}],\"freezeLineColor\":\"rgb(185, 185, 185)\",\"merges\":[\"A1:G2\",\"G3:G6\",\"B7:D7\",\"F7:G7\",\"B8:D8\",\"F8:G8\",\"B9:D9\",\"F9:G9\",\"A10:G10\",\"A11:G11\",\"A12:G12\",\"A13:G13\",\"B14:G14\",\"B15:D15\",\"F15:G15\",\"B16:D16\",\"F16:G16\",\"B17:D17\",\"F17:G17\",\"B18:D18\",\"F18:G18\"]}', NULL, NULL, 'admin', '2024-08-29 17:18:29', 'admin', '2024-08-30 10:24:03', 0, NULL, NULL, 1, 2, NULL, NULL, NULL, '1', 9, 1);

-- 报表分享数据
INSERT INTO `jimu_report_share` (`id`, `report_id`, `preview_url`, `preview_lock`, `last_update_time`, `term_of_validity`, `status`, `preview_lock_status`, `SHARE_TOKEN`) VALUES ('989322818603012096', '989065112487022592', '/jmreport/shareView/989065112487022592', '', '2024-08-30 10:22:31', '1', '0', '0', '71e3778ba7ebeae4652d2e53c46a7b1b');
