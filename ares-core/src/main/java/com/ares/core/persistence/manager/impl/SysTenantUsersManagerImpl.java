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

import com.ares.core.model.query.SysTenantUsersQuery;
import com.ares.core.persistence.dao.ISysTenantUsersDao;
import com.ares.core.persistence.entity.SysTenantUsersDto;
import com.ares.core.persistence.manager.SysTenantUsersManager;
import com.ares.core.utils.SnowflakeIdWorker;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;
import java.util.Map;

@Service
public class SysTenantUsersManagerImpl implements SysTenantUsersManager {

    private ISysTenantUsersDao sysTenantRolesDao;

    @Autowired
    public SysTenantUsersManagerImpl(ISysTenantUsersDao sysTenantRolesDao) {
        this.sysTenantRolesDao = sysTenantRolesDao;
    }

    @Override
    public PageInfo<SysTenantUsersDto> list(int pageNo, int pageSize, Map<String, Object> map) {
        PageHelper.startPage(pageNo, pageSize);
        List<SysTenantUsersDto> lists = sysTenantRolesDao.list(map);
        PageInfo<SysTenantUsersDto> pageInfo = new PageInfo<>(lists);
        return pageInfo;
    }

    @Override
    public void insert(SysTenantUsersDto obj) {
        obj.setId(SnowflakeIdWorker.getUUID());
        obj.setCreateTime(new Date());
        sysTenantRolesDao.insert(obj);
    }

    @Override
    public void update(SysTenantUsersDto obj) {
        obj.setModifyTime(new Date());
        sysTenantRolesDao.update(obj);
    }

    @Override
    public void deleteByIds(List<Long> ids) {
        sysTenantRolesDao.deleteByIds(ids);
    }

    @Override
    public SysTenantUsersDto getById(Long id) {
        return sysTenantRolesDao.getById(id);
    }

    @Override
    public PageInfo<SysTenantUsersDto> list(SysTenantUsersQuery obj) {
        List<SysTenantUsersDto> lists = sysTenantRolesDao.selectList(obj);
        PageInfo<SysTenantUsersDto> pageInfo = new PageInfo<>(lists);
        return pageInfo;
    }

    @Override
    public List<SysTenantUsersDto> list(Map<String, Object> params) {
        return sysTenantRolesDao.list(params);
    }

    @Override
    public List<SysTenantUsersDto> selectList(SysTenantUsersQuery obj) {
        return sysTenantRolesDao.selectList(obj);
    }

    @Override
    public List<String> getUserIdsByTenant(Long tenantId) {
        return sysTenantRolesDao.getUserIdsByTenant(tenantId);
    }

    @Override
    public void delByTenantId(Long tenantId) {
        sysTenantRolesDao.deleteByTenantId(tenantId);
    }

    @Override
    public Long getTenantIdByUserId(Long userId) {
        return sysTenantRolesDao.getTenantIdByUserId(userId);
    }
}
