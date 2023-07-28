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

import com.ares.core.persistence.dao.ISysRoleDao;
import com.ares.core.persistence.model.SysRole;
import com.ares.core.persistence.service.ISysRoleService;
import com.ares.core.utils.SnowflakeIdWorker;
import com.ares.core.utils.StringUtils;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
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
public class SysRoleServiceImpl extends ServiceImpl<ISysRoleDao, SysRole> implements ISysRoleService {

    private ISysRoleDao sysRoleDao;

    @Autowired
    public SysRoleServiceImpl(ISysRoleDao sysRoleDao) {
        this.sysRoleDao = sysRoleDao;
    }

    @Override
    public PageInfo<SysRole> list(int pageNo, int pageSize, Map<String, Object> map) {
        PageHelper.startPage(pageNo, pageSize);
        List<SysRole> userList = sysRoleDao.list(map);
        PageInfo<SysRole> userPageInfo = new PageInfo<>(userList);
        return userPageInfo;
    }

    @Override
    public List<SysRole> list(SysRole obj) {
        return null;
    }

    @Override
    public void insert(SysRole obj) {
        obj.setId(SnowflakeIdWorker.getUUID());
        obj.setCreateTime(new Date());
        sysRoleDao.insert(obj);
    }

    @Override
    public void update(SysRole obj) {
        obj.setModifyTime(new Date());
        sysRoleDao.update(obj);
    }

    @Override
    public void deleteByIds(List<String> ids) {
        sysRoleDao.deleteByIds(ids);
    }

    @Override
    public SysRole getById(String id) {
        return sysRoleDao.getById(id);
    }

    @Override
    public void saveAssign(String users, String menus, String roleId) {
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
    public List<SysRole> getRoleByUserId(String userId) {
        return sysRoleDao.getRoleByUserId(userId);
    }

    @Override
    public List<String> getPermsByRoleId(String roleId) {
        return sysRoleDao.getPermsByRoleId(roleId);
    }

    @Override
    public List<String> getRoleIdsByUser(String userId) {
        List<SysRole> roleList = sysRoleDao.getRoleByUserId(userId);
        List<String> roles = roleList.stream().map(SysRole::getId).collect(Collectors.toList());
        return roles;
    }

    @Override
    public List<SysRole> getAll() {
        return sysRoleDao.list(new HashMap<>());
    }

    @Override
    @Transactional
    public void saveRoleUser(String[] roleIds, String userId) {
        sysRoleDao.deleteRoleByUser(userId);
        for (String id : roleIds) {
            Map<String, Object> map = new HashMap<>();
            map.put("id", SnowflakeIdWorker.getUUID());
            map.put("userId", userId);
            map.put("roleId", id);
            sysRoleDao.insertRoleUser(map);
        }
    }

    @Override
    public List<SysRole> selectRoleList(SysRole role) {
        return sysRoleDao.selectList(role);
    }

    @Override
    public boolean checkRoleName(String roleName) {
        int count = sysRoleDao.checkRoleName(roleName);
        return count == 0 ? true : false;
    }

    @Override
    @Transactional
    public String insertRole(SysRole obj) {
        String roleId = SnowflakeIdWorker.getUUID();
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
    public void updateRole(SysRole obj) {
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
    public void authDataScope(SysRole role) {
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
