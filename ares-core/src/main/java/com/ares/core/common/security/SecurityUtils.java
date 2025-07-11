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

package com.ares.core.common.security;

import cn.dev33.satoken.stp.StpUtil;
import com.ares.core.common.exception.UserException;
import com.ares.core.model.exception.ErrorCode;
import com.ares.core.model.vo.SysRole;
import com.ares.core.model.vo.SysUser;
import com.ares.core.service.ISysRoleService;
import com.ares.core.service.ISysTenantUsersService;
import com.ares.core.service.ISysUserService;
import com.ares.core.utils.SpringUtils;

import java.util.List;

/**
 * @description:
 * @author: Young
 * @date: 2020/10/19
 * @see: com.ares.core.common.security SecurityUtils.java
 **/
public final class SecurityUtils {

    private SecurityUtils() {
    }

    public static SysUser getUser() throws UserException {
        Long loginId = Long.valueOf(String.valueOf(StpUtil.getLoginId()));
        if (loginId == 0) {
            throw new UserException(ErrorCode.NOLOGIN.getCode(), "用户未登录！");
        }
        ISysUserService userService = SpringUtils.getBean(ISysUserService.class);
        SysUser user = userService.getById(loginId);
        ISysTenantUsersService tenantUsersService = SpringUtils.getBean(ISysTenantUsersService.class);
        Long tenantId = tenantUsersService.getTenantIdByUserId(user.getId());
        user.setTenantId(tenantId);
        ISysRoleService sysRoleService = SpringUtils.getBean(ISysRoleService.class);
        List<SysRole> roles = sysRoleService.getRoleByUserId(user.getId());
        Long[] roleIds = roles.stream().map(SysRole::getId).toArray(Long[]::new);
        user.setRoleIds(roleIds);
        return user;
    }

}
