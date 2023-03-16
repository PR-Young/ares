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
import com.ares.flowable.persistence.dao.ISysTaskFormDao;
import com.ares.flowable.persistence.model.SysTaskForm;
import com.ares.flowable.persistence.service.ISysTaskFormService;
import com.baomidou.mybatisplus.core.conditions.Wrapper;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Collection;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.function.Function;

@Service
public class SysTaskFormServiceImpl implements ISysTaskFormService {

    private ISysTaskFormDao sysTaskFormDao;

    @Autowired
    public SysTaskFormServiceImpl(ISysTaskFormDao sysTaskFormDao) {
        this.sysTaskFormDao = sysTaskFormDao;
    }

    /**
     * 查询流程任务关联单
     *
     * @param id 流程任务关联单ID
     * @return 流程任务关联单
     */
    @Override
    public SysTaskForm selectSysTaskFormById(String id) {
        return sysTaskFormDao.getById(id);
    }

    /**
     * 查询流程任务关联单列表
     *
     * @param sysTaskForm 流程任务关联单
     * @return 流程任务关联单
     */

    @Override
    public List<SysTaskForm> selectSysTaskFormList(SysTaskForm sysTaskForm) {
        return sysTaskFormDao.selectList(sysTaskForm);
    }

    @Override
    public PageInfo<SysTaskForm> list(int pageNo, int pageSize, Map<String, Object> map) {
        PageHelper.startPage(pageNo, pageSize);
        List<SysTaskForm> lists = sysTaskFormDao.list(map);
        PageInfo<SysTaskForm> pageInfo = new PageInfo<>(lists);
        return pageInfo;
    }

    @Override
    public void insert(SysTaskForm obj) {
        obj.setId(SnowflakeIdWorker.getUUID());
        obj.setCreateTime(new Date());
        sysTaskFormDao.insert(obj);
    }

    @Override
    public void update(SysTaskForm obj) {
        obj.setModifyTime(new Date());
        sysTaskFormDao.update(obj);
    }

    @Override
    public void deleteByIds(List<String> ids) {
        sysTaskFormDao.deleteByIds(ids);
    }

    @Override
    public SysTaskForm getById(String id) {
        return sysTaskFormDao.getById(id);
    }

    @Override
    public List<SysTaskForm> list(SysTaskForm obj) {
        List<SysTaskForm> lists = sysTaskFormDao.selectList(obj);
        return lists;
    }

    @Override
    public boolean saveBatch(Collection entityList, int batchSize) {
        return false;
    }

    @Override
    public boolean saveOrUpdateBatch(Collection entityList, int batchSize) {
        return false;
    }

    @Override
    public boolean updateBatchById(Collection entityList, int batchSize) {
        return false;
    }

    @Override
    public boolean saveOrUpdate(Object entity) {
        return false;
    }

    @Override
    public Object getOne(Wrapper queryWrapper, boolean throwEx) {
        return null;
    }

    @Override
    public Map<String, Object> getMap(Wrapper queryWrapper) {
        return null;
    }

    @Override
    public BaseMapper getBaseMapper() {
        return null;
    }

    @Override
    public Class getEntityClass() {
        return null;
    }

    @Override
    public Object getObj(Wrapper queryWrapper, Function mapper) {
        return null;
    }
}
