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

package com.ares.core.persistence.manager.impl;

import com.ares.core.model.query.SysRoleQuery;
import com.ares.core.persistence.dao.ISysRoleDao;
import com.ares.core.persistence.entity.SysRoleDto;
import com.ares.core.persistence.manager.SysRoleManager;
import com.ares.core.utils.SnowflakeIdWorker;
import com.ares.core.utils.StringUtils;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @description:
 * @author: Young 2020/01/26
 **/
@Service
public class SysRoleManagerImpl implements SysRoleManager {

    private ISysRoleDao sysRoleDao;

    @Autowired
    public SysRoleManagerImpl(ISysRoleDao sysRoleDao) {
        this.sysRoleDao = sysRoleDao;
    }

    @Override
    public PageInfo<SysRoleDto> list(int pageNo, int pageSize, Map<String, Object> map) {
        PageHelper.startPage(pageNo, pageSize);
        List<SysRoleDto> userList = sysRoleDao.list(map);
        PageInfo<SysRoleDto> userPageInfo = new PageInfo<>(userList);
        return userPageInfo;
    }

    @Override
    public PageInfo<SysRoleDto> list(SysRoleQuery obj) {
        List<SysRoleDto> lists = sysRoleDao.selectList(obj);
        PageInfo<SysRoleDto> pageInfo = new PageInfo<>(lists);
        return pageInfo;
    }

    @Override
    public void insert(SysRoleDto obj) {
        obj.setId(SnowflakeIdWorker.getUUID());
        obj.setCreateTime(new Date());
        sysRoleDao.insert(obj);
    }

    @Override
    public void update(SysRoleDto obj) {
        obj.setModifyTime(new Date());
        sysRoleDao.update(obj);
    }

    @Override
    public void deleteByIds(List<Long> ids) {
        sysRoleDao.deleteByIds(ids);
    }

    @Override
    public SysRoleDto getById(Long id) {
        return sysRoleDao.getById(id);
    }

    @Transactional
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
    public List<SysRoleDto> getRoleByUserId(Long userId) {
        return sysRoleDao.getRoleByUserId(userId);
    }

    @Override
    public List<String> getPermsByRoleId(Long roleId) {
        return sysRoleDao.getPermsByRoleId(roleId);
    }

    @Override
    public List<SysRoleDto> getRoleIdsByUser(Long userId) {
        List<SysRoleDto> roleList = sysRoleDao.getRoleByUserId(userId);
        return roleList;
    }

    @Override
    public List<SysRoleDto> list(Map<String, Object> params) {
        return sysRoleDao.list(params);
    }

    @Override
    public List<SysRoleDto> selectList(SysRoleQuery obj) {
        return sysRoleDao.selectList(obj);
    }

    @Override
    public String selectUserRoleGroup(Long userId) {
        List<SysRoleDto> roleList = sysRoleDao.getRoleByUserId(userId);
        StringBuffer idsStr = new StringBuffer();
        for (SysRoleDto role : roleList) {
            idsStr.append(role.getDescription()).append(",");
        }
        if (StringUtils.isNotEmpty(idsStr.toString())) {
            return idsStr.substring(0, idsStr.length() - 1);
        }
        return idsStr.toString();
    }

    @Override
    public SysRoleDto getRoleByName(String roleName) {
        return sysRoleDao.getRoleByName(roleName);
    }

    @Override
    public void insertRoleUser(Map<String, Object> map) {
        sysRoleDao.insertRoleUser(map);
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
    public List<SysRoleDto> selectRoleList(SysRoleQuery role) {
        return sysRoleDao.selectList(role);
    }

    @Override
    public boolean checkRoleName(String roleName) {
        int count = sysRoleDao.checkRoleName(roleName);
        return count == 0;
    }

    @Override
    @Transactional
    public Long insertRole(SysRoleDto obj) {
        Long roleId = SnowflakeIdWorker.getUUID();
        obj.setId(roleId);
        obj.setCreateTime(new Date());
        sysRoleDao.insert(obj);
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
    public void updateRole(SysRoleDto obj) {
        obj.setModifyTime(new Date());
        sysRoleDao.update(obj);
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
    public void authDataScope(SysRoleDto role) {
        role.setModifyTime(new Date());
        // 修改角色信息
        sysRoleDao.update(role);
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
