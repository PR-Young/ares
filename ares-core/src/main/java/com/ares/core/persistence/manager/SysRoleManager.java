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

package com.ares.core.persistence.manager;

import com.ares.core.model.query.SysRoleQuery;
import com.ares.core.persistence.entity.SysRoleDto;

import java.util.List;
import java.util.Map;

/**
 * @description:
 * @author: Young 2020/01/26
 **/
public interface SysRoleManager extends BaseManager<SysRoleDto, SysRoleQuery> {
    void saveAssign(String users, String menus, Long roleId);

    List<SysRoleDto> getRoleByUserId(Long userId);

    List<String> getPermsByRoleId(Long roleId);

    List<SysRoleDto> getRoleIdsByUser(Long userId);

    void saveRoleUser(Long[] roleIds, Long userId);

    List<SysRoleDto> selectRoleList(SysRoleQuery role);

    boolean checkRoleName(String roleName);

    Long insertRole(SysRoleDto obj);

    void updateRole(SysRoleDto obj);

    void authDataScope(SysRoleDto role);

    List<SysRoleDto> list(Map<String, Object> params);

    String selectUserRoleGroup(Long userId);

    SysRoleDto getRoleByName(String roleName);

    void insertRoleUser(Map<String, Object> map);
}
