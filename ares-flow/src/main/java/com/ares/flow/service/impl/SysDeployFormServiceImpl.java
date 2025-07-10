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

import com.ares.flow.model.SysDeployForm;
import com.ares.flow.model.SysForm;
import com.ares.flow.model.query.SysDeployFormQuery;
import com.ares.flow.persistence.entity.SysDeployFormDto;
import com.ares.flow.persistence.manager.SysDeployFormManager;
import com.ares.flow.service.ISysDeployFormService;
import com.ares.flow.service.ISysFormService;
import com.github.pagehelper.PageInfo;
import io.github.linpeilie.Converter;
import org.dromara.warm.flow.core.service.FormService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class SysDeployFormServiceImpl implements ISysDeployFormService {

    private SysDeployFormManager deployFormManager;
    private Converter converter;
    private FormService formService;
    private ISysFormService sysFormService;

    @Autowired
    public SysDeployFormServiceImpl(SysDeployFormManager deployFormManager,
                                    Converter converter,
                                    FormService formService,
                                    ISysFormService sysFormService) {
        this.deployFormManager = deployFormManager;
        this.converter = converter;
        this.formService = formService;
        this.sysFormService = sysFormService;
    }

    @Override
    public PageInfo<SysDeployForm> list(int pageNo, int pageSize, Map<String, Object> map) {
        PageInfo<SysDeployFormDto> list = deployFormManager.list(pageNo, pageSize, map);
        PageInfo<SysDeployForm> pageInfo = list.convert(dto -> {
            SysDeployForm v = converter.convert(dto, SysDeployForm.class);
            return v;
        });
        return pageInfo;
    }

    @Override
    public void insert(SysDeployForm obj) {
        SysDeployFormDto sysDeployFormDto = converter.convert(obj, SysDeployFormDto.class);
        deployFormManager.insert(sysDeployFormDto);
    }

    @Override
    public void update(SysDeployForm obj) {
        SysDeployFormDto sysDeployFormDto = converter.convert(obj, SysDeployFormDto.class);
        deployFormManager.update(sysDeployFormDto);
    }

    @Override
    public void deleteByIds(List<Long> ids) {
        deployFormManager.deleteByIds(ids);
    }

    @Override
    public SysDeployForm getById(Long id) {
        return converter.convert(deployFormManager.getById(id), SysDeployForm.class);
    }

    @Override
    public PageInfo<SysDeployForm> list(SysDeployFormQuery obj) {
        List<SysDeployFormDto> lists = deployFormManager.selectList(obj);
        PageInfo<SysDeployFormDto> pageInfo = new PageInfo<>(lists);
        PageInfo<SysDeployForm> page = pageInfo.convert(dto -> {
            SysDeployForm v = converter.convert(dto, SysDeployForm.class);
            return v;
        });
        return page;
    }

    @Override
    public SysDeployForm selectSysDeployFormById(Long id) {
        return converter.convert(deployFormManager.selectSysDeployFormById(id), SysDeployForm.class);
    }

    @Override
    public SysForm selectSysDeployFormByDeployId(String id) {
        return converter.convert(deployFormManager.selectSysDeployFormByDeployId(id), SysForm.class);
    }

    @Override
    public String isBindForm(String deployId) {
        return deployFormManager.isBindForm(deployId);
    }

}
