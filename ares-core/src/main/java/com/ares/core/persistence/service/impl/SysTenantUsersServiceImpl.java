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

import com.ares.core.model.query.SysTenantUsersQuery;
import com.ares.core.model.vo.SysTenantUsers;
import com.ares.core.persistence.dao.ISysTenantUsersDao;
import com.ares.core.persistence.entity.SysTenantUsersDto;
import com.ares.core.persistence.service.ISysTenantUsersService;
import com.ares.core.utils.SnowflakeIdWorker;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import io.github.linpeilie.Converter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;
import java.util.Map;

@Service
public class SysTenantUsersServiceImpl implements ISysTenantUsersService {

    private ISysTenantUsersDao sysTenantRolesDao;
    private Converter converter;

    @Autowired
    public SysTenantUsersServiceImpl(ISysTenantUsersDao sysTenantRolesDao, Converter converter) {
        this.sysTenantRolesDao = sysTenantRolesDao;
        this.converter = converter;
    }

    @Override
    public PageInfo<SysTenantUsers> list(int pageNo, int pageSize, Map<String, Object> map) {
        PageHelper.startPage(pageNo, pageSize);
        List<SysTenantUsers> lists = converter.convert(sysTenantRolesDao.list(map), SysTenantUsers.class);
        PageInfo<SysTenantUsers> pageInfo = new PageInfo<>(lists);
        return pageInfo;
    }

    @Override
    public void insert(SysTenantUsers obj) {
        obj.setId(SnowflakeIdWorker.getUUID());
        obj.setCreateTime(new Date());
        SysTenantUsersDto sysTenantUsersDto = converter.convert(obj, SysTenantUsersDto.class);
        sysTenantRolesDao.insert(sysTenantUsersDto);
    }

    @Override
    public void update(SysTenantUsers obj) {
        obj.setModifyTime(new Date());
        SysTenantUsersDto sysTenantUsersDto = converter.convert(obj, SysTenantUsersDto.class);
        sysTenantRolesDao.update(sysTenantUsersDto);
    }

    @Override
    public void deleteByIds(List<Long> ids) {
        sysTenantRolesDao.deleteByIds(ids);
    }

    @Override
    public SysTenantUsers getById(Long id) {
        return converter.convert(sysTenantRolesDao.getById(id), SysTenantUsers.class);
    }

    @Override
    public PageInfo<SysTenantUsers> list(SysTenantUsersQuery obj) {
        List<SysTenantUsersDto> lists = sysTenantRolesDao.selectList(obj);
        PageInfo<SysTenantUsersDto> pageInfo = new PageInfo<>(lists);
        PageInfo<SysTenantUsers> page = pageInfo.convert(dto -> {
            SysTenantUsers v = converter.convert(dto, SysTenantUsers.class);
            return v;
        });
        return page;
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
