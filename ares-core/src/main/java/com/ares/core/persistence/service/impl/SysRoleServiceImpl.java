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

package com.ares.core.persistence.service.impl;

import com.ares.core.model.query.SysRoleQuery;
import com.ares.core.model.vo.SysRole;
import com.ares.core.persistence.dao.ISysRoleDao;
import com.ares.core.persistence.entity.SysRoleDto;
import com.ares.core.persistence.service.ISysRoleService;
import com.ares.core.utils.SnowflakeIdWorker;
import com.ares.core.utils.StringUtils;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import io.github.linpeilie.Converter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
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

    private ISysRoleDao sysRoleDao;
    private Converter converter;

    @Autowired
    public SysRoleServiceImpl(ISysRoleDao sysRoleDao, Converter converter) {
        this.sysRoleDao = sysRoleDao;
        this.converter = converter;
    }

    @Override
    public PageInfo<SysRole> list(int pageNo, int pageSize, Map<String, Object> map) {
        PageHelper.startPage(pageNo, pageSize);
        List<SysRole> userList = converter.convert(sysRoleDao.list(map), SysRole.class);
        PageInfo<SysRole> userPageInfo = new PageInfo<>(userList);
        return userPageInfo;
    }

    @Override
    public PageInfo<SysRole> list(SysRoleQuery obj) {
        List<SysRoleDto> lists = sysRoleDao.selectList(obj);
        PageInfo<SysRoleDto> pageInfo = new PageInfo<>(lists);
        PageInfo<SysRole> page = pageInfo.convert(dto -> {
            SysRole v = converter.convert(dto, SysRole.class);
            return v;
        });
        return page;
    }

    @Override
    public void insert(SysRole obj) {
        obj.setId(SnowflakeIdWorker.getUUID());
        obj.setCreateTime(new Date());
        SysRoleDto sysRoleDto = converter.convert(obj, SysRoleDto.class);
        sysRoleDao.insert(sysRoleDto);
    }

    @Override
    public void update(SysRole obj) {
        obj.setModifyTime(new Date());
        SysRoleDto sysRoleDto = converter.convert(obj, SysRoleDto.class);
        sysRoleDao.update(sysRoleDto);
    }

    @Override
    public void deleteByIds(List<Long> ids) {
        sysRoleDao.deleteByIds(ids);
    }

    @Override
    public SysRole getById(Long id) {
        return converter.convert(sysRoleDao.getById(id), SysRole.class);
    }

    @Override
    public void saveAssign(String users, String menus, Long roleId) {
        if (StringUtils.isNotEmpty(users)) {
            sysRoleDao.deleteRoleUser(roleId);
            String[] userIds = users.split(",");
            for (String id : userIds) {
                Map<String, Object> map = new HashMap<>();
                map.put("id", SnowflakeIdWorker.getUUID());
                map.put("userId", id);
                map.put("roleId", roleId);
                sysRoleDao.insertRoleUser(map);
            }
        }
        if (StringUtils.isNotEmpty(menus)) {
            sysRoleDao.deletePermission(roleId);
            String[] menuIds = menus.split(",");
            for (String id : menuIds) {
                Map<String, Object> map = new HashMap<>();
                map.put("id", SnowflakeIdWorker.getUUID());
                map.put("menuId", id);
                map.put("roleId", roleId);
                sysRoleDao.insertPermission(map);
            }
        }
    }

    @Override
    public List<SysRole> getRoleByUserId(Long userId) {
        return converter.convert(sysRoleDao.getRoleByUserId(userId), SysRole.class);
    }

    @Override
    public List<String> getPermsByRoleId(Long roleId) {
        return sysRoleDao.getPermsByRoleId(roleId);
    }

    @Override
    public List<String> getRoleIdsByUser(Long userId) {
        List<SysRole> roleList = converter.convert(sysRoleDao.getRoleByUserId(userId), SysRole.class);
        List<String> roles = roleList.stream().map(role -> role.getId().toString()).collect(Collectors.toList());
        return roles;
    }

    @Override
    public List<SysRole> getAll() {
        return converter.convert(sysRoleDao.list(new HashMap<>()), SysRole.class);
    }

    @Override
    @Transactional
    public void saveRoleUser(Long[] roleIds, Long userId) {
        sysRoleDao.deleteRoleByUser(userId);
        for (Long id : roleIds) {
            Map<String, Object> map = new HashMap<>();
            map.put("id", SnowflakeIdWorker.getUUID());
            map.put("userId", userId);
            map.put("roleId", id);
            sysRoleDao.insertRoleUser(map);
        }
    }

    @Override
    public List<SysRole> selectRoleList(SysRoleQuery role) {
        return converter.convert(sysRoleDao.selectList(role), SysRole.class);
    }

    @Override
    public boolean checkRoleName(String roleName) {
        int count = sysRoleDao.checkRoleName(roleName);
        return count == 0;
    }

    @Override
    @Transactional
    public Long insertRole(SysRole obj) {
        Long roleId = SnowflakeIdWorker.getUUID();
        obj.setId(roleId);
        obj.setCreateTime(new Date());
        SysRoleDto sysRoleDto = converter.convert(obj, SysRoleDto.class);
        sysRoleDao.insert(sysRoleDto);
        if (StringUtils.isNotEmpty(obj.getMenuIds())) {
            sysRoleDao.deletePermission(roleId);
            for (String id : obj.getMenuIds()) {
                Map<String, Object> map = new HashMap<>();
                map.put("id", SnowflakeIdWorker.getUUID());
                map.put("menuId", id);
                map.put("roleId", roleId);
                sysRoleDao.insertPermission(map);
            }
        }
        return roleId;
    }

    @Override
    @Transactional
    public void updateRole(SysRole obj) {
        obj.setModifyTime(new Date());
        SysRoleDto sysRoleDto = converter.convert(obj, SysRoleDto.class);
        sysRoleDao.update(sysRoleDto);
        if (StringUtils.isNotEmpty(obj.getMenuIds())) {
            sysRoleDao.deletePermission(obj.getId());
            for (String id : obj.getMenuIds()) {
                Map<String, Object> map = new HashMap<>();
                map.put("id", SnowflakeIdWorker.getUUID());
                map.put("menuId", id);
                map.put("roleId", obj.getId());
                sysRoleDao.insertPermission(map);
            }
        }
    }

    @Override
    @Transactional
    public void authDataScope(SysRole role) {
        role.setModifyTime(new Date());
        // 修改角色信息
        SysRoleDto sysRoleDto = converter.convert(role, SysRoleDto.class);
        sysRoleDao.update(sysRoleDto);
        if (StringUtils.isNotEmpty(role.getUserIds())) {
            sysRoleDao.deleteRoleUser(role.getId());
            for (String id : role.getUserIds()) {
                Map<String, Object> map = new HashMap<>();
                map.put("id", SnowflakeIdWorker.getUUID());
                map.put("userId", id);
                map.put("roleId", role.getId());
                sysRoleDao.insertRoleUser(map);
            }
        }
    }
}
