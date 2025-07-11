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

package com.ares.flow.persistence.manager.impl;

import com.ares.core.utils.SnowflakeIdWorker;
import com.ares.flow.model.query.SysTaskFormQuery;
import com.ares.flow.persistence.dao.ISysTaskFormDao;
import com.ares.flow.persistence.entity.SysTaskFormDto;
import com.ares.flow.persistence.manager.SysTaskFormManager;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;
import java.util.Map;

@Service
public class SysTaskFormManagerImpl implements SysTaskFormManager {

    private ISysTaskFormDao sysTaskFormDao;

    @Autowired
    public SysTaskFormManagerImpl(ISysTaskFormDao sysTaskFormDao) {
        this.sysTaskFormDao = sysTaskFormDao;
    }

    /**
     * 查询流程任务关联单
     *
     * @param id 流程任务关联单ID
     * @return 流程任务关联单
     */
    @Override
    public SysTaskFormDto selectSysTaskFormById(Long id) {
        return sysTaskFormDao.getById(id);
    }

    /**
     * 查询流程任务关联单列表
     *
     * @param sysTaskForm 流程任务关联单
     * @return 流程任务关联单
     */

    @Override
    public List<SysTaskFormDto> selectSysTaskFormList(SysTaskFormQuery sysTaskForm) {
        return sysTaskFormDao.selectList(sysTaskForm);
    }

    @Override
    public PageInfo<SysTaskFormDto> list(int pageNo, int pageSize, Map<String, Object> map) {
        PageHelper.startPage(pageNo, pageSize);
        List<SysTaskFormDto> lists = sysTaskFormDao.list(map);
        PageInfo<SysTaskFormDto> pageInfo = new PageInfo<>(lists);
        return pageInfo;
    }

    @Override
    public void insert(SysTaskFormDto obj) {
        obj.setId(SnowflakeIdWorker.getUUID());
        obj.setCreateTime(new Date());
        sysTaskFormDao.insert(obj);
    }

    @Override
    public void update(SysTaskFormDto obj) {
        obj.setModifyTime(new Date());
        sysTaskFormDao.update(obj);
    }

    @Override
    public void deleteByIds(List<Long> ids) {
        sysTaskFormDao.deleteByIds(ids);
    }

    @Override
    public SysTaskFormDto getById(Long id) {
        return sysTaskFormDao.getById(id);
    }

    @Override
    public PageInfo<SysTaskFormDto> list(SysTaskFormQuery obj) {
        List<SysTaskFormDto> lists = sysTaskFormDao.selectList(obj);
        PageInfo<SysTaskFormDto> pageInfo = new PageInfo<>(lists);
        return pageInfo;
    }

    @Override
    public List<SysTaskFormDto> list(Map<String, Object> params) {
        return sysTaskFormDao.list(params);
    }

    @Override
    public List<SysTaskFormDto> selectList(SysTaskFormQuery obj) {
        return sysTaskFormDao.selectList(obj);
    }

}
