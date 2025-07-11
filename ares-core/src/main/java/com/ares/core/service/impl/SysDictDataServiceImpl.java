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

import com.ares.core.model.query.SysDictDataQuery;
import com.ares.core.model.vo.SysDictData;
import com.ares.core.persistence.entity.SysDictDataDto;
import com.ares.core.persistence.manager.SysDictDataManager;
import com.ares.core.service.ISysDictDataService;
import com.github.pagehelper.PageInfo;
import io.github.linpeilie.Converter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class SysDictDataServiceImpl implements ISysDictDataService {

    private SysDictDataManager dictDataManager;
    private Converter converter;

    @Autowired
    public SysDictDataServiceImpl(SysDictDataManager dictDataManager, Converter converter) {
        this.dictDataManager = dictDataManager;
        this.converter = converter;
    }

    @Override
    public PageInfo<SysDictData> list(int pageNo, int pageSize, Map<String, Object> map) {
        PageInfo<SysDictDataDto> list = dictDataManager.list(pageNo, pageSize, map);
        PageInfo<SysDictData> pageInfo = list.convert(dto -> {
            SysDictData v = converter.convert(dto, SysDictData.class);
            return v;
        });
        return pageInfo;
    }

    @Override
    public void insert(SysDictData obj) {
        SysDictDataDto sysDictDataDto = converter.convert(obj, SysDictDataDto.class);
        dictDataManager.insert(sysDictDataDto);
    }

    @Override
    public void update(SysDictData obj) {
        SysDictDataDto sysDictDataDto = converter.convert(obj, SysDictDataDto.class);
        dictDataManager.update(sysDictDataDto);
    }

    @Override
    public void deleteByIds(List<Long> ids) {
        dictDataManager.deleteByIds(ids);
    }

    @Override
    public SysDictData getById(Long id) {
        return converter.convert(dictDataManager.getById(id), SysDictData.class);
    }

    @Override
    public PageInfo<SysDictData> list(SysDictDataQuery obj) {
        List<SysDictDataDto> lists = dictDataManager.selectList(obj);
        PageInfo<SysDictDataDto> pageInfo = new PageInfo<>(lists);
        PageInfo<SysDictData> page = pageInfo.convert(dto -> {
            SysDictData v = converter.convert(dto, SysDictData.class);
            return v;
        });
        return page;
    }

    @Override
    public List<SysDictData> getDicts(String dictType) {
        return converter.convert(dictDataManager.getDicts(dictType), SysDictData.class);
    }

}
