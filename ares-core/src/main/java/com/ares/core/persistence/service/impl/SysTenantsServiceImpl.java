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

import com.ares.core.model.query.SysTenantsQuery;
import com.ares.core.persistence.dao.ISysTenantsDao;
import com.ares.core.persistence.model.SysTenantRoles;
import com.ares.core.persistence.model.SysTenants;
import com.ares.core.persistence.service.ISysTenantRolesService;
import com.ares.core.persistence.service.ISysTenantsService;
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
public class SysTenantsServiceImpl implements ISysTenantsService {

    private ISysTenantsDao sysTenantsDao;
    private ISysTenantRolesService sysTenantRolesService;

    @Autowired
    public SysTenantsServiceImpl(ISysTenantsDao sysTenantsDao, ISysTenantRolesService sysTenantRolesService) {
        this.sysTenantsDao = sysTenantsDao;
        this.sysTenantRolesService = sysTenantRolesService;
    }

    @Override
    public PageInfo<SysTenants> list(int pageNo, int pageSize, Map<String, Object> map) {
        PageHelper.startPage(pageNo, pageSize);
        List<SysTenants> lists = sysTenantsDao.list(map);
        PageInfo<SysTenants> pageInfo = new PageInfo<>(lists);
        return pageInfo;
    }

    @Transactional
    @Override
    public void insert(SysTenants obj) {
        Long id = SnowflakeIdWorker.getUUID();
        obj.setId(id);
        obj.setCreateTime(new Date());
        sysTenantsDao.insert(obj);
        for (Long roleId : obj.getRoleIds()) {
            SysTenantRoles tenantRoles = new SysTenantRoles();
            tenantRoles.setTenantId(id);
            tenantRoles.setRoleId(roleId);
            sysTenantRolesService.insert(tenantRoles);
        }
    }

    @Transactional
    @Override
    public void update(SysTenants obj) {
        obj.setModifyTime(new Date());
        sysTenantsDao.update(obj);
        sysTenantRolesService.delByTenantId(obj.getId());
        for (Long roleId : obj.getRoleIds()) {
            SysTenantRoles tenantRoles = new SysTenantRoles();
            tenantRoles.setTenantId(obj.getId());
            tenantRoles.setRoleId(roleId);
            sysTenantRolesService.insert(tenantRoles);
        }
    }

    @Transactional
    @Override
    public void deleteByIds(List<Long> ids) {
        sysTenantsDao.deleteByIds(ids);
        for (Long id : ids) {
            sysTenantRolesService.delByTenantId(id);
        }
    }

    @Override
    public SysTenants getById(Long id) {
        return sysTenantsDao.getById(id);
    }

    @Override
    public List<SysTenants> list(SysTenantsQuery obj) {
        List<SysTenants> lists = sysTenantsDao.selectList(obj);
        return lists;
    }
}
