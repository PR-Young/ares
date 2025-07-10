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

package com.ares.flowable.service.impl;


import com.ares.flowable.model.query.SysFormDataQuery;
import com.ares.flowable.model.vo.SysFormData;
import com.ares.flowable.persistence.entity.SysFormDataDto;
import com.ares.flowable.persistence.manager.SysFormDataManager;
import com.ares.flowable.service.ISysFormDataService;
import com.github.pagehelper.PageInfo;
import io.github.linpeilie.Converter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class SysFormDataServiceImpl implements ISysFormDataService {

    private SysFormDataManager formDataManager;
    private Converter converter;

    @Autowired
    public SysFormDataServiceImpl(SysFormDataManager formDataManager, Converter converter) {
        this.formDataManager = formDataManager;
        this.converter = converter;
    }

    @Override
    public PageInfo<SysFormData> list(int pageNo, int pageSize, Map<String, Object> map) {
        PageInfo<SysFormDataDto> list = formDataManager.list(pageNo, pageSize, map);
        PageInfo<SysFormData> pageInfo = list.convert(dto -> {
            SysFormData v = converter.convert(dto, SysFormData.class);
            return v;
        });
        return pageInfo;
    }

    @Override
    public void insert(SysFormData obj) {
        SysFormDataDto sysFormDataDto = converter.convert(obj, SysFormDataDto.class);
        formDataManager.insert(sysFormDataDto);
    }

    @Override
    public void update(SysFormData obj) {
        SysFormDataDto sysFormDataDto = converter.convert(obj, SysFormDataDto.class);
        formDataManager.update(sysFormDataDto);
    }

    @Override
    public void deleteByIds(List<Long> ids) {
        formDataManager.deleteByIds(ids);
    }

    @Override
    public SysFormData getById(Long id) {
        return converter.convert(formDataManager.getById(id), SysFormData.class);
    }

    @Override
    public PageInfo<SysFormData> list(SysFormDataQuery obj) {
        List<SysFormDataDto> lists = formDataManager.selectList(obj);
        PageInfo<SysFormDataDto> pageInfo = new PageInfo<>(lists);
        PageInfo<SysFormData> page = pageInfo.convert(dto -> {
            SysFormData v = converter.convert(dto, SysFormData.class);
            return v;
        });
        return page;
    }

    @Override
    public SysFormData getFormDataByProInstId(String proInstId) {
        return converter.convert(formDataManager.getFormDataByProInstId(proInstId), SysFormData.class);
    }

}
