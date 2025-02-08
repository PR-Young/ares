/*
 * !******************************************************************************
 *  * Copyright (c) 2021 - 9999, ARES
 *  *
 *  * Licensed under the Apache License, Version 2.0 (the "License");
 *  * you may not use this file except in compliance with the License.
 *  * You may obtain a copy of the License at
 *  *
 *  *        http://www.apache.org/licenses/LICENSE-2.0
 *  *
 *  * Unless required by applicable law or agreed to in writing, software
 *  * distributed under the License is distributed on an "AS IS" BASIS,
 *  * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  * See the License for the specific language governing permissions and
 *  * limitations under the License.
 *  *****************************************************************************
 */

package com.ares.flowable.persistence.service.impl;

import com.ares.core.utils.SnowflakeIdWorker;
import com.ares.flowable.model.vo.SysTaskForm;
import com.ares.flowable.model.query.SysTaskFormQuery;
import com.ares.flowable.persistence.dao.ISysTaskFormDao;
import com.ares.flowable.persistence.entity.SysTaskFormDto;
import com.ares.flowable.persistence.service.ISysTaskFormService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import io.github.linpeilie.Converter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;
import java.util.Map;

@Service
public class SysTaskFormServiceImpl implements ISysTaskFormService {

    private ISysTaskFormDao sysTaskFormDao;
    private Converter converter;

    @Autowired
    public SysTaskFormServiceImpl(ISysTaskFormDao sysTaskFormDao, Converter converter) {
        this.sysTaskFormDao = sysTaskFormDao;
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
        return converter.convert(sysTaskFormDao.getById(id), SysTaskForm.class);
    }

    /**
     * 查询流程任务关联单列表
     *
     * @param sysTaskForm 流程任务关联单
     * @return 流程任务关联单
     */

    @Override
    public List<SysTaskForm> selectSysTaskFormList(SysTaskFormQuery sysTaskForm) {
        return converter.convert(sysTaskFormDao.selectList(sysTaskForm), SysTaskForm.class);
    }

    @Override
    public PageInfo<SysTaskForm> list(int pageNo, int pageSize, Map<String, Object> map) {
        PageHelper.startPage(pageNo, pageSize);
        List<SysTaskForm> lists = converter.convert(sysTaskFormDao.list(map), SysTaskForm.class);
        PageInfo<SysTaskForm> pageInfo = new PageInfo<>(lists);
        return pageInfo;
    }

    @Override
    public void insert(SysTaskForm obj) {
        obj.setId(SnowflakeIdWorker.getUUID());
        obj.setCreateTime(new Date());
        SysTaskFormDto sysTaskFormDto = converter.convert(obj, SysTaskFormDto.class);
        sysTaskFormDao.insert(sysTaskFormDto);
    }

    @Override
    public void update(SysTaskForm obj) {
        obj.setModifyTime(new Date());
        SysTaskFormDto sysTaskFormDto = converter.convert(obj, SysTaskFormDto.class);
        sysTaskFormDao.update(sysTaskFormDto);
    }

    @Override
    public void deleteByIds(List<Long> ids) {
        sysTaskFormDao.deleteByIds(ids);
    }

    @Override
    public SysTaskForm getById(Long id) {
        return converter.convert(sysTaskFormDao.getById(id), SysTaskForm.class);
    }

    @Override
    public List<SysTaskForm> list(SysTaskFormQuery obj) {
        List<SysTaskForm> lists = converter.convert(sysTaskFormDao.selectList(obj), SysTaskForm.class);
        return lists;
    }

}
