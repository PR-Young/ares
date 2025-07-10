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

package com.ares.generator.service.impl;

import com.ares.generator.model.query.GenPropertiesQuery;
import com.ares.generator.model.vo.GenProperties;
import com.ares.generator.persistence.entity.GenPropertiesDto;
import com.ares.generator.persistence.manager.GenPropertiesManager;
import com.ares.generator.service.IGenPropertiesService;
import com.github.pagehelper.PageInfo;
import io.github.linpeilie.Converter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class GenPropertiesServiceImpl implements IGenPropertiesService {

    private GenPropertiesManager genPropertiesManager;
    private Converter converter;

    @Autowired
    public GenPropertiesServiceImpl(GenPropertiesManager genPropertiesManager, Converter converter) {
        this.genPropertiesManager = genPropertiesManager;
        this.converter = converter;
    }

    @Override
    public PageInfo<GenProperties> list(int pageNo, int pageSize, Map<String, Object> map) {
        PageInfo<GenPropertiesDto> list = genPropertiesManager.list(pageNo, pageSize, map);
        PageInfo<GenProperties> pageInfo = list.convert(dto -> {
            GenProperties v = converter.convert(dto, GenProperties.class);
            return v;
        });
        return pageInfo;
    }

    @Override
    public void insert(GenProperties obj) {
        GenPropertiesDto genPropertiesDto = converter.convert(obj, GenPropertiesDto.class);
        genPropertiesManager.insert(genPropertiesDto);
    }

    @Override
    public void update(GenProperties obj) {
        GenPropertiesDto genPropertiesDto = converter.convert(obj, GenPropertiesDto.class);
        genPropertiesManager.update(genPropertiesDto);
    }

    @Override
    public void deleteByIds(List<Long> ids) {
        genPropertiesManager.deleteByIds(ids);
    }

    @Override
    public GenProperties getById(Long id) {
        return converter.convert(genPropertiesManager.getById(id), GenProperties.class);
    }

    @Override
    public PageInfo<GenProperties> list(GenPropertiesQuery obj) {
        List<GenPropertiesDto> lists = genPropertiesManager.selectList(obj);
        PageInfo<GenPropertiesDto> pageInfo = new PageInfo<>(lists);
        PageInfo<GenProperties> page = pageInfo.convert(dto -> {
            GenProperties v = converter.convert(dto, GenProperties.class);
            return v;
        });
        return page;
    }

    @Override
    public GenProperties getByUser() {
        GenPropertiesDto genPropertiesDto = genPropertiesManager.getByUser();
        return converter.convert(genPropertiesDto, GenProperties.class);
    }
}
