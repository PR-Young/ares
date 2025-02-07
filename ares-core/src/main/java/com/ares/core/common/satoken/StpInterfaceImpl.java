/*
 * !******************************************************************************
 *  * Copyright (c) 2021 - 9999, ARES
 *  *
 *  * Licensed under the Apache License, Version 2.0 (the "License");
 *  * you may not use this file except in compliance with the License.
 *  * You may obtain a copy of the License at
 *  *
 *  *        http://www.apache.org/licenses/LICENSE-2.0
 *  *
 *  * Unless required by applicable law or agreed to in writing, software
 *  * distributed under the License is distributed on an "AS IS" BASIS,
 *  * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  * See the License for the specific language governing permissions and
 *  * limitations under the License.
 *  *****************************************************************************
 */

package com.ares.core.common.satoken;

import cn.dev33.satoken.stp.StpInterface;
import com.ares.core.common.exception.UserException;
import com.ares.core.model.vo.SysRole;
import com.ares.core.model.vo.SysUser;
import com.ares.core.persistence.service.ISysRoleService;
import com.ares.core.persistence.service.ISysUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;

/**
 * @description:
 * @author: Young
 * @date: 2022/12/9
 * @see: com.ares.core.common.satoken.StpInterfaceImpl.java
 **/
@Component
public class StpInterfaceImpl implements StpInterface {

    private ISysUserService userService;
    private ISysRoleService roleService;

    @Autowired
    public StpInterfaceImpl(ISysUserService userService,
                            ISysRoleService roleService) {
        this.userService = userService;
        this.roleService = roleService;
    }

    @Override
    public List<String> getPermissionList(Object loginId, String loginType) {
        List<String> perms = new ArrayList<>();
        SysUser user = userService.getById(Long.valueOf(String.valueOf(loginId)));
        if (null == user) {
            throw new UserException("该用户不存在");
        }
        List<SysRole> roleList = roleService.getRoleByUserId(Long.valueOf(String.valueOf(loginId)));
        for (SysRole role : roleList) {
            if ("gly".equalsIgnoreCase(role.getRoleName())) {
                perms = roleService.getPermsByRoleId(null);
            } else {
                perms = roleService.getPermsByRoleId(role.getId());
            }
        }
        return perms;
    }

    @Override
    public List<String> getRoleList(Object loginId, String loginType) {
        List<String> roles = new ArrayList<>();
        SysUser user = userService.getById(Long.valueOf(String.valueOf(loginId)));
        if (null == user) {
            throw new UserException("该用户不存在");
        }
        List<SysRole> roleList = roleService.getRoleByUserId(Long.valueOf(String.valueOf(loginId)));
        for (SysRole role : roleList) {
            roles.add(role.getRoleName());
        }
        return roles;
    }
}
