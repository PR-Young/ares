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

package com.ares.core.persistence.service;

import com.ares.core.model.query.SysRoleQuery;
import com.ares.core.persistence.model.SysRole;

import java.util.List;

/**
 * @description:
 * @author: Young 2020/01/26
 **/
public interface ISysRoleService extends IBaseService<SysRole, SysRoleQuery> {

    public void saveAssign(String users, String menus, String roleId);

    public List<SysRole> getRoleByUserId(String userId);

    public List<String> getPermsByRoleId(String roleId);

    public List<String> getRoleIdsByUser(String userId);

    public List<SysRole> getAll();

    public void saveRoleUser(String[] roleIds, String userId);

    public List<SysRole> selectRoleList(SysRoleQuery role);

    public boolean checkRoleName(String roleName);

    public String insertRole(SysRole obj);

    public void updateRole(SysRole obj);

    public void authDataScope(SysRole role);
}
