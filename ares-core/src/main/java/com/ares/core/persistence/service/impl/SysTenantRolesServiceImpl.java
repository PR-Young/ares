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

package com.ares.core.persistence.service.impl;

import com.ares.core.model.query.SysTenantRolesQuery;
import com.ares.core.persistence.dao.ISysTenantRolesDao;
import com.ares.core.persistence.model.SysTenantRoles;
import com.ares.core.persistence.service.ISysTenantRolesService;
import com.ares.core.utils.SnowflakeIdWorker;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;
import java.util.Map;

@Service
public class SysTenantRolesServiceImpl implements ISysTenantRolesService {

    private ISysTenantRolesDao sysTenantRolesDao;

    @Autowired
    public SysTenantRolesServiceImpl(ISysTenantRolesDao sysTenantRolesDao) {
        this.sysTenantRolesDao = sysTenantRolesDao;
    }

    @Override
    public PageInfo<SysTenantRoles> list(int pageNo, int pageSize, Map<String, Object> map) {
        PageHelper.startPage(pageNo, pageSize);
        List<SysTenantRoles> lists = sysTenantRolesDao.list(map);
        PageInfo<SysTenantRoles> pageInfo = new PageInfo<>(lists);
        return pageInfo;
    }

    @Override
    public void insert(SysTenantRoles obj) {
        obj.setId(SnowflakeIdWorker.getUUID());
        obj.setCreateTime(new Date());
        sysTenantRolesDao.insert(obj);
    }

    @Override
    public void update(SysTenantRoles obj) {
        obj.setModifyTime(new Date());
        sysTenantRolesDao.update(obj);
    }

    @Override
    public void deleteByIds(List<Long> ids) {
        sysTenantRolesDao.deleteByIds(ids);
    }

    @Override
    public SysTenantRoles getById(Long id) {
        return sysTenantRolesDao.getById(id);
    }

    @Override
    public List<SysTenantRoles> list(SysTenantRolesQuery obj) {
        List<SysTenantRoles> lists = sysTenantRolesDao.selectList(obj);
        return lists;
    }

    @Override
    public List<String> getRoleIdsByTenant(Long tenantId) {
        return sysTenantRolesDao.getRoleIdsByTenant(tenantId);
    }

    @Override
    public void delByTenantId(Long tenantId) {
        sysTenantRolesDao.deleteByTenantId(tenantId);
    }
}
