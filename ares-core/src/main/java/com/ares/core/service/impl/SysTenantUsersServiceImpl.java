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

import com.ares.core.model.query.SysTenantUsersQuery;
import com.ares.core.model.vo.SysTenantUsers;
import com.ares.core.persistence.entity.SysTenantUsersDto;
import com.ares.core.persistence.manager.SysTenantUsersManager;
import com.ares.core.service.ISysTenantUsersService;
import com.github.pagehelper.PageInfo;
import io.github.linpeilie.Converter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class SysTenantUsersServiceImpl implements ISysTenantUsersService {

    private SysTenantUsersManager tenantUsersManager;
    private Converter converter;

    @Autowired
    public SysTenantUsersServiceImpl(SysTenantUsersManager tenantUsersManager, Converter converter) {
        this.tenantUsersManager = tenantUsersManager;
        this.converter = converter;
    }

    @Override
    public PageInfo<SysTenantUsers> list(int pageNo, int pageSize, Map<String, Object> map) {
        PageInfo<SysTenantUsersDto> list = tenantUsersManager.list(pageNo, pageSize, map);
        PageInfo<SysTenantUsers> pageInfo = list.convert(dto -> {
            SysTenantUsers v = converter.convert(dto, SysTenantUsers.class);
            return v;
        });
        return pageInfo;
    }

    @Override
    public void insert(SysTenantUsers obj) {
        SysTenantUsersDto sysTenantUsersDto = converter.convert(obj, SysTenantUsersDto.class);
        tenantUsersManager.insert(sysTenantUsersDto);
    }

    @Override
    public void update(SysTenantUsers obj) {
        SysTenantUsersDto sysTenantUsersDto = converter.convert(obj, SysTenantUsersDto.class);
        tenantUsersManager.update(sysTenantUsersDto);
    }

    @Override
    public void deleteByIds(List<Long> ids) {
        tenantUsersManager.deleteByIds(ids);
    }

    @Override
    public SysTenantUsers getById(Long id) {
        return converter.convert(tenantUsersManager.getById(id), SysTenantUsers.class);
    }

    @Override
    public PageInfo<SysTenantUsers> list(SysTenantUsersQuery obj) {
        List<SysTenantUsersDto> lists = tenantUsersManager.selectList(obj);
        PageInfo<SysTenantUsersDto> pageInfo = new PageInfo<>(lists);
        PageInfo<SysTenantUsers> page = pageInfo.convert(dto -> {
            SysTenantUsers v = converter.convert(dto, SysTenantUsers.class);
            return v;
        });
        return page;
    }

    @Override
    public List<String> getUserIdsByTenant(Long tenantId) {
        return tenantUsersManager.getUserIdsByTenant(tenantId);
    }

    @Override
    public void delByTenantId(Long tenantId) {
        tenantUsersManager.delByTenantId(tenantId);
    }

    @Override
    public Long getTenantIdByUserId(Long userId) {
        return tenantUsersManager.getTenantIdByUserId(userId);
    }
}
