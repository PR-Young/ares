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

import com.ares.core.model.query.SysTenantsQuery;
import com.ares.core.model.vo.SysTenants;
import com.ares.core.persistence.entity.SysTenantsDto;
import com.ares.core.persistence.manager.SysTenantsManager;
import com.ares.core.service.ISysTenantsService;
import com.github.pagehelper.PageInfo;
import io.github.linpeilie.Converter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class SysTenantsServiceImpl implements ISysTenantsService {

    private SysTenantsManager tenantsManager;
    private Converter converter;

    @Autowired
    public SysTenantsServiceImpl(SysTenantsManager tenantsManager, Converter converter) {
        this.tenantsManager = tenantsManager;
        this.converter = converter;
    }

    @Override
    public PageInfo<SysTenants> list(int pageNo, int pageSize, Map<String, Object> map) {
        PageInfo<SysTenantsDto> list = tenantsManager.list(pageNo, pageSize, map);
        PageInfo<SysTenants> pageInfo = list.convert(dto -> {
            SysTenants v = converter.convert(dto, SysTenants.class);
            return v;
        });
        return pageInfo;
    }

    @Override
    public void insert(SysTenants obj) {
        SysTenantsDto sysTenantsDto = converter.convert(obj, SysTenantsDto.class);
        tenantsManager.insert(sysTenantsDto);
    }

    @Override
    public void update(SysTenants obj) {
        SysTenantsDto sysTenantsDto = converter.convert(obj, SysTenantsDto.class);
        tenantsManager.update(sysTenantsDto);
    }

    @Override
    public void deleteByIds(List<Long> ids) {
        tenantsManager.deleteByIds(ids);
    }

    @Override
    public SysTenants getById(Long id) {
        return converter.convert(tenantsManager.getById(id), SysTenants.class);
    }

    @Override
    public PageInfo<SysTenants> list(SysTenantsQuery obj) {
        List<SysTenantsDto> lists = tenantsManager.selectList(obj);
        PageInfo<SysTenantsDto> pageInfo = new PageInfo<>(lists);
        PageInfo<SysTenants> page = pageInfo.convert(dto -> {
            SysTenants v = converter.convert(dto, SysTenants.class);
            return v;
        });
        return page;
    }

    @Override
    public List<Map<String, Object>> getAllUsers() {
        return tenantsManager.getAllUsers();
    }
}
