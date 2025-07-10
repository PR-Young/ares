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

package com.ares.core.service.impl;

import com.ares.core.model.query.SysRoleQuery;
import com.ares.core.model.vo.SysRole;
import com.ares.core.persistence.entity.SysRoleDto;
import com.ares.core.persistence.manager.SysRoleManager;
import com.ares.core.service.ISysRoleService;
import com.github.pagehelper.PageInfo;
import io.github.linpeilie.Converter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

/**
 * @description:
 * @author: Young 2020/01/26
 **/
@Service
public class SysRoleServiceImpl implements ISysRoleService {

    private SysRoleManager roleManager;
    private Converter converter;

    @Autowired
    public SysRoleServiceImpl(SysRoleManager roleManager, Converter converter) {
        this.roleManager = roleManager;
        this.converter = converter;
    }

    @Override
    public PageInfo<SysRole> list(int pageNo, int pageSize, Map<String, Object> map) {
        PageInfo<SysRoleDto> list = roleManager.list(pageNo, pageSize, map);
        PageInfo<SysRole> userPageInfo = list.convert(dto -> {
            SysRole v = converter.convert(dto, SysRole.class);
            return v;
        });
        return userPageInfo;
    }

    @Override
    public PageInfo<SysRole> list(SysRoleQuery obj) {
        List<SysRoleDto> lists = roleManager.selectList(obj);
        PageInfo<SysRoleDto> pageInfo = new PageInfo<>(lists);
        PageInfo<SysRole> page = pageInfo.convert(dto -> {
            SysRole v = converter.convert(dto, SysRole.class);
            return v;
        });
        return page;
    }

    @Override
    public void insert(SysRole obj) {
        SysRoleDto sysRoleDto = converter.convert(obj, SysRoleDto.class);
        roleManager.insert(sysRoleDto);
    }

    @Override
    public void update(SysRole obj) {
        SysRoleDto sysRoleDto = converter.convert(obj, SysRoleDto.class);
        roleManager.update(sysRoleDto);
    }

    @Override
    public void deleteByIds(List<Long> ids) {
        roleManager.deleteByIds(ids);
    }

    @Override
    public SysRole getById(Long id) {
        return converter.convert(roleManager.getById(id), SysRole.class);
    }

    @Override
    public void saveAssign(String users, String menus, Long roleId) {
        roleManager.saveAssign(users, menus, roleId);
    }


    @Override
    public List<SysRole> getRoleByUserId(Long userId) {
        return converter.convert(roleManager.getRoleByUserId(userId), SysRole.class);
    }

    @Override
    public List<String> getPermsByRoleId(Long roleId) {
        return roleManager.getPermsByRoleId(roleId);
    }

    @Override
    public List<String> getRoleIdsByUser(Long userId) {
        List<SysRole> roleList = converter.convert(roleManager.getRoleByUserId(userId), SysRole.class);
        List<String> roles = roleList.stream().map(role -> role.getId().toString()).collect(Collectors.toList());
        return roles;
    }

    @Override
    public List<SysRole> getAll() {
        return converter.convert(roleManager.list(new HashMap<>()), SysRole.class);
    }

    @Override
    public void saveRoleUser(Long[] roleIds, Long userId) {
        roleManager.saveRoleUser(roleIds, userId);
    }

    @Override
    public List<SysRole> selectRoleList(SysRoleQuery role) {
        return converter.convert(roleManager.selectList(role), SysRole.class);
    }

    @Override
    public boolean checkRoleName(String roleName) {
        return roleManager.checkRoleName(roleName);
    }

    @Override
    public Long insertRole(SysRole obj) {
        SysRoleDto roleDto = converter.convert(obj, SysRoleDto.class);
        Long roleId = roleManager.insertRole(roleDto);
        return roleId;
    }

    @Override
    public void updateRole(SysRole obj) {
        SysRoleDto sysRoleDto = converter.convert(obj, SysRoleDto.class);
        roleManager.updateRole(sysRoleDto);
    }

    @Override
    public void authDataScope(SysRole role) {
        SysRoleDto sysRoleDto = converter.convert(role, SysRoleDto.class);
        roleManager.authDataScope(sysRoleDto);
    }

    @Override
    public SysRole getRoleByName(String roleName) {
        return converter.convert(roleManager.getRoleByName(roleName), SysRole.class);
    }

    @Override
    public void insertRoleUser(Map<String, Object> map) {
        roleManager.insertRoleUser(map);
    }
}
