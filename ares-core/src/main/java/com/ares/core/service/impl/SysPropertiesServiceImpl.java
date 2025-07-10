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

import com.ares.core.model.query.SysPropertiesQuery;
import com.ares.core.model.vo.SysProperties;
import com.ares.core.persistence.entity.SysPropertiesDto;
import com.ares.core.persistence.manager.SysPropertiesManager;
import com.ares.core.service.ISysPropertiesService;
import com.github.pagehelper.PageInfo;
import io.github.linpeilie.Converter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Service
public class SysPropertiesServiceImpl implements ISysPropertiesService {

    private SysPropertiesManager propertiesManager;
    private Converter converter;

    @Autowired
    public SysPropertiesServiceImpl(SysPropertiesManager propertiesManager, Converter converter) {
        this.propertiesManager = propertiesManager;
        this.converter = converter;
    }

    @Override
    public PageInfo<SysProperties> list(int pageNo, int pageSize, Map<String, Object> map) {
        PageInfo<SysPropertiesDto> list = propertiesManager.list(pageNo, pageSize, map);
        PageInfo<SysProperties> pageInfo = list.convert(dto -> {
            SysProperties v = converter.convert(dto, SysProperties.class);
            return v;
        });
        return pageInfo;
    }

    @Override
    public void insert(SysProperties obj) {
        SysPropertiesDto sysPropertiesDto = converter.convert(obj, SysPropertiesDto.class);
        propertiesManager.insert(sysPropertiesDto);
    }

    @Override
    public void update(SysProperties obj) {
        SysPropertiesDto sysPropertiesDto = converter.convert(obj, SysPropertiesDto.class);
        propertiesManager.update(sysPropertiesDto);
    }

    @Override
    public void deleteByIds(List<Long> ids) {
        propertiesManager.deleteByIds(ids);
    }

    @Override
    public SysProperties getById(Long id) {
        return converter.convert(propertiesManager.getById(id), SysProperties.class);
    }

    @Override
    public PageInfo<SysProperties> list(SysPropertiesQuery obj) {
        List<SysPropertiesDto> lists = propertiesManager.selectList(obj);
        PageInfo<SysPropertiesDto> pageInfo = new PageInfo<>(lists);
        PageInfo<SysProperties> page = pageInfo.convert(dto -> {
            SysProperties v = converter.convert(dto, SysProperties.class);
            return v;
        });
        return page;
    }

    @Override
    public Map<String, Object> getByGroup(String group) {
        List<SysProperties> properties = converter.convert(propertiesManager.getByGroup(group), SysProperties.class);
        Map<String, Object> map = properties.stream().collect(Collectors.toMap(SysProperties::getAlias, SysProperties::getValue));
        return map;
    }

    @Override
    public String getValueByAlias(String alias) {
        return propertiesManager.getValueByAlias(alias);
    }
}
