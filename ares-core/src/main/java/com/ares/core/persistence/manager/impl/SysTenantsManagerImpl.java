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

import com.ares.core.model.query.SysTenantsQuery;
import com.ares.core.persistence.dao.ISysTenantUsersDao;
import com.ares.core.persistence.dao.ISysTenantsDao;
import com.ares.core.persistence.entity.SysTenantUsersDto;
import com.ares.core.persistence.entity.SysTenantsDto;
import com.ares.core.persistence.manager.SysTenantsManager;
import com.ares.core.utils.SnowflakeIdWorker;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.List;
import java.util.Map;

@Service
public class SysTenantsManagerImpl implements SysTenantsManager {

    private ISysTenantsDao sysTenantsDao;
    private ISysTenantUsersDao sysTenantUsersDao;

    @Autowired
    public SysTenantsManagerImpl(ISysTenantsDao sysTenantsDao, ISysTenantUsersDao sysTenantUsersDao) {
        this.sysTenantsDao = sysTenantsDao;
        this.sysTenantUsersDao = sysTenantUsersDao;
    }

    @Override
    public PageInfo<SysTenantsDto> list(int pageNo, int pageSize, Map<String, Object> map) {
        PageHelper.startPage(pageNo, pageSize);
        List<SysTenantsDto> lists = sysTenantsDao.list(map);
        PageInfo<SysTenantsDto> pageInfo = new PageInfo<>(lists);
        return pageInfo;
    }

    @Transactional
    @Override
    public void insert(SysTenantsDto obj) {
        Long id = SnowflakeIdWorker.getUUID();
        obj.setId(id);
        obj.setCreateTime(new Date());
        sysTenantsDao.insert(obj);
        for (Long userId : obj.getUserIds()) {
            SysTenantUsersDto tenantRoles = new SysTenantUsersDto();
            tenantRoles.setTenantId(id);
            tenantRoles.setUserId(userId);
            sysTenantUsersDao.insert(tenantRoles);
        }
    }

    @Transactional
    @Override
    public void update(SysTenantsDto obj) {
        obj.setModifyTime(new Date());
        sysTenantsDao.update(obj);
        sysTenantUsersDao.deleteByTenantId(obj.getId());
        for (Long userId : obj.getUserIds()) {
            SysTenantUsersDto tenantRoles = new SysTenantUsersDto();
            tenantRoles.setTenantId(obj.getId());
            tenantRoles.setUserId(userId);
            sysTenantUsersDao.insert(tenantRoles);
        }
    }

    @Transactional
    @Override
    public void deleteByIds(List<Long> ids) {
        sysTenantsDao.deleteByIds(ids);
        for (Long id : ids) {
            sysTenantUsersDao.deleteByTenantId(id);
        }
    }

    @Override
    public SysTenantsDto getById(Long id) {
        return sysTenantsDao.getById(id);
    }

    @Override
    public PageInfo<SysTenantsDto> list(SysTenantsQuery obj) {
        List<SysTenantsDto> lists = sysTenantsDao.selectList(obj);
        PageInfo<SysTenantsDto> pageInfo = new PageInfo<>(lists);
        return pageInfo;
    }

    @Override
    public List<SysTenantsDto> list(Map<String, Object> params) {
        return sysTenantsDao.list(params);
    }

    @Override
    public List<SysTenantsDto> selectList(SysTenantsQuery obj) {
        return sysTenantsDao.selectList(obj);
    }

    @Override
    public List<Map<String, Object>> getAllUsers() {
        return sysTenantsDao.getAllUsers();
    }
}
