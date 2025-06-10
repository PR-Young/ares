/*
 *
 *  * ****************************************************************************
 *  * * Copyright (c) 2021 - 9999, ARES
 *  * *
 *  * * Licensed under the Apache License, Version 2.0 (the "License");
 *  * * you may not use this file except in compliance with the License.
 *  * * You may obtain a copy of the License at
 *  * *
 *  * *        http://www.apache.org/licenses/LICENSE-2.0
 *  * *
 *  * * Unless required by applicable law or agreed to in writing, software
 *  * * distributed under the License is distributed on an "AS IS" BASIS,
 *  * * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  * * See the License for the specific language governing permissions and
 *  * * limitations under the License.
 *  * ***************************************************************************
 *
 */

package com.ares.flow.handler;


import com.ares.core.common.security.SecurityUtils;
import com.ares.core.model.vo.SysRole;
import com.ares.core.model.vo.SysUser;
import com.ares.core.persistence.service.ISysRoleService;
import org.dromara.warm.flow.core.handler.PermissionHandler;
import org.dromara.warm.flow.core.utils.StreamUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.List;

/**
 * @description: 办理人权限处理器
 * @author: Young
 * @date: 2025/6/9
 * @see: com.ares.flow.handler.CustomPermissionHandler.java
 **/
@Component
public class CustomPermissionHandler implements PermissionHandler {

    private ISysRoleService sysRoleService;

    @Autowired
    public CustomPermissionHandler(ISysRoleService sysRoleService) {
        this.sysRoleService = sysRoleService;
    }

    /**
     * 获取当前操作用户所有权限
     */
    @Override
    public List<String> permissions() {
        // 办理人权限标识，比如用户，角色，部门等, 流程设计时未设置办理人或者ignore为true可不传 [按需传输]
        SysUser sysUser = SecurityUtils.getUser();
        List<SysRole> roles = sysRoleService.getRoleByUserId(sysUser.getId());
        List<String> permissionList = StreamUtils.toList(roles, role -> "role:" + role.getId());
        if (sysUser.getId() != null) {
            permissionList.add(String.valueOf(sysUser.getId()));
        }
        if (sysUser.getDeptId() != null) {
            permissionList.add("dept:" + sysUser.getDeptId());
        }
        return permissionList;
    }

    /**
     * 获取当前办理人
     * @return 当前办理人
     */
    @Override
    public String getHandler() {
        SysUser sysUser = SecurityUtils.getUser();
        if (sysUser.getId() != null) {
            return String.valueOf(sysUser.getId());
        }
        return null;
    }

    /**
     * 转换办理人，比如设计器中预设了能办理的人，如果其中包含角色或者部门id等，可以通过此接口进行转换成用户id
     */
    @Override
    public List<String> convertPermissions(List<String> permissions) {
        // 把角色部门转换成用户
        
        return permissions;
    }
}
