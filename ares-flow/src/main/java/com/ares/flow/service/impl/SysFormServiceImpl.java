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

package com.ares.flow.service.impl;

import com.ares.flow.model.SysForm;
import com.ares.flow.model.query.SysFormQuery;
import com.ares.flow.persistence.entity.SysFormDto;
import com.ares.flow.persistence.manager.SysFormManager;
import com.ares.flow.service.ISysFormService;
import com.github.pagehelper.PageInfo;
import io.github.linpeilie.Converter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class SysFormServiceImpl implements ISysFormService {

    private SysFormManager formManager;
    private Converter converter;

    @Autowired
    public SysFormServiceImpl(SysFormManager formManager, Converter converter) {
        this.formManager = formManager;
        this.converter = converter;
    }

    @Override
    public PageInfo<SysForm> list(int pageNo, int pageSize, Map<String, Object> map) {
        PageInfo<SysFormDto> list = formManager.list(pageNo, pageSize, map);
        PageInfo<SysForm> pageInfo = list.convert(dto -> converter.convert(dto, SysForm.class));
        return pageInfo;
    }

    @Override
    public void insert(SysForm obj) {
        SysFormDto sysFormDto = converter.convert(obj, SysFormDto.class);
        formManager.insert(sysFormDto);
    }

    @Override
    public void update(SysForm obj) {
        SysFormDto sysFormDto = converter.convert(obj, SysFormDto.class);
        formManager.update(sysFormDto);
    }

    @Override
    public void deleteByIds(List<Long> ids) {
        formManager.deleteByIds(ids);
    }

    @Override
    public SysForm getById(Long id) {
        return converter.convert(formManager.getById(id), SysForm.class);
    }

    @Override
    public PageInfo<SysForm> list(SysFormQuery obj) {
        List<SysFormDto> lists = formManager.selectList(obj);
        PageInfo<SysFormDto> pageInfo = new PageInfo<>(lists);
        PageInfo<SysForm> page = pageInfo.convert(dto -> {
            SysForm v = converter.convert(dto, SysForm.class);
            return v;
        });
        return page;
    }
}
