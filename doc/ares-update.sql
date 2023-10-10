-- ----------------------------
-- Table structure for sys_tenants
-- ----------------------------
DROP TABLE IF EXISTS `sys_tenants`;
CREATE TABLE `sys_tenants` (
                               `Id` bigint NOT NULL,
                               `TenantName` varchar(255) DEFAULT NULL COMMENT '租户名',
                               `TenantAlias` varchar(255) DEFAULT NULL COMMENT '租户别称',
                               `TenantStatus` char(1) DEFAULT NULL COMMENT '租户状态',
                               `Creator` bigint DEFAULT NULL,
                               `CreateTime` datetime DEFAULT NULL,
                               `Modifier` bigint DEFAULT NULL,
                               `ModifyTime` datetime DEFAULT NULL,
                               PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Table structure for sys_tenant_roles
-- ----------------------------
DROP TABLE IF EXISTS `sys_tenant_roles`;
CREATE TABLE `sys_tenant_roles` (
                                    `Id` bigint NOT NULL,
                                    `TenantId` bigint DEFAULT NULL,
                                    `RoleId` bigint DEFAULT NULL,
                                    `Creator` bigint DEFAULT NULL,
                                    `CreateTime` datetime DEFAULT NULL,
                                    `Modifier` bigint DEFAULT NULL,
                                    `ModifyTime` datetime DEFAULT NULL,
                                    PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


INSERT INTO `sys_menu` (`Id`, `Name`, `Description`, `Path`, `Url`, `IsBlank`, `PId`, `Icon`, `Order`, `Visible`, `Perms`, `Type`, `Creator`, `CreateTime`, `Modifier`, `ModifyTime`) VALUES (871629764891381760, '删除', NULL, NULL, '#', NULL, '871629501501673472', NULL, 2, 0, 'sysTenants:delete', 2, 1, '2023-10-10 07:52:20', NULL, NULL);
INSERT INTO `sys_menu` (`Id`, `Name`, `Description`, `Path`, `Url`, `IsBlank`, `PId`, `Icon`, `Order`, `Visible`, `Perms`, `Type`, `Creator`, `CreateTime`, `Modifier`, `ModifyTime`) VALUES (871629674382495744, '新增/修改', NULL, NULL, '#', NULL, '871629501501673472', NULL, 1, 0, 'sysTenants:edit', 2, 1, '2023-10-10 07:51:59', NULL, NULL);
INSERT INTO `sys_menu` (`Id`, `Name`, `Description`, `Path`, `Url`, `IsBlank`, `PId`, `Icon`, `Order`, `Visible`, `Perms`, `Type`, `Creator`, `CreateTime`, `Modifier`, `ModifyTime`) VALUES (871629501501673472, '租户', NULL, '/tenant', '/system/tenant/index', NULL, '1', 'nested', 6, 0, 'sysTenants:list', 1, 1, '2023-10-10 07:51:17', NULL, NULL);
