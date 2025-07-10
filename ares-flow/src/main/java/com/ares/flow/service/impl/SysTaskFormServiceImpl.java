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

import com.ares.flow.model.SysTaskForm;
import com.ares.flow.model.query.SysTaskFormQuery;
import com.ares.flow.persistence.entity.SysTaskFormDto;
import com.ares.flow.persistence.manager.SysTaskFormManager;
import com.ares.flow.service.ISysTaskFormService;
import com.github.pagehelper.PageInfo;
import io.github.linpeilie.Converter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class SysTaskFormServiceImpl implements ISysTaskFormService {

    private SysTaskFormManager taskFormManager;
    private Converter converter;

    @Autowired
    public SysTaskFormServiceImpl(SysTaskFormManager taskFormManager, Converter converter) {
        this.taskFormManager = taskFormManager;
        this.converter = converter;
    }

    /**
     * 查询流程任务关联单
     *
     * @param id 流程任务关联单ID
     * @return 流程任务关联单
     */
    @Override
    public SysTaskForm selectSysTaskFormById(Long id) {
        return converter.convert(taskFormManager.getById(id), SysTaskForm.class);
    }

    /**
     * 查询流程任务关联单列表
     *
     * @param sysTaskForm 流程任务关联单
     * @return 流程任务关联单
     */

    @Override
    public List<SysTaskForm> selectSysTaskFormList(SysTaskFormQuery sysTaskForm) {
        return converter.convert(taskFormManager.selectList(sysTaskForm), SysTaskForm.class);
    }

    @Override
    public PageInfo<SysTaskForm> list(int pageNo, int pageSize, Map<String, Object> map) {
        PageInfo<SysTaskFormDto> list = taskFormManager.list(pageNo, pageSize, map);
        PageInfo<SysTaskForm> pageInfo = list.convert(dto -> {
            SysTaskForm v = converter.convert(dto, SysTaskForm.class);
            return v;
        });
        return pageInfo;
    }

    @Override
    public void insert(SysTaskForm obj) {
        SysTaskFormDto sysTaskFormDto = converter.convert(obj, SysTaskFormDto.class);
        taskFormManager.insert(sysTaskFormDto);
    }

    @Override
    public void update(SysTaskForm obj) {
        SysTaskFormDto sysTaskFormDto = converter.convert(obj, SysTaskFormDto.class);
        taskFormManager.update(sysTaskFormDto);
    }

    @Override
    public void deleteByIds(List<Long> ids) {
        taskFormManager.deleteByIds(ids);
    }

    @Override
    public SysTaskForm getById(Long id) {
        return converter.convert(taskFormManager.getById(id), SysTaskForm.class);
    }

    @Override
    public PageInfo<SysTaskForm> list(SysTaskFormQuery obj) {
        List<SysTaskFormDto> lists = taskFormManager.selectList(obj);
        PageInfo<SysTaskFormDto> pageInfo = new PageInfo<>(lists);
        PageInfo<SysTaskForm> page = pageInfo.convert(dto -> {
            SysTaskForm v = converter.convert(dto, SysTaskForm.class);
            return v;
        });
        return page;
    }

}
