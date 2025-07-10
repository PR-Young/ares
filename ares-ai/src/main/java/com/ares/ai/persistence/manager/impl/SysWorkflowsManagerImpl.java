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

package com.ares.ai.persistence.manager.impl;

import com.ares.ai.model.query.SysWorkflowsQuery;
import com.ares.ai.persistence.dao.ISysWorkflowsDao;
import com.ares.ai.persistence.entity.SysWorkflowsDto;
import com.ares.ai.persistence.manager.SysWorkflowsManager;
import com.ares.core.utils.SnowflakeIdWorker;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * @description:
 * @author: young
 * @date: 2025-05-15 13:15:01
 **/
@Service
public class SysWorkflowsManagerImpl implements SysWorkflowsManager {

    private ISysWorkflowsDao sysWorkflowsDao;

    @Autowired
    public SysWorkflowsManagerImpl(ISysWorkflowsDao sysWorkflowsDao) {
        this.sysWorkflowsDao = sysWorkflowsDao;
    }

    @Override
    public PageInfo<SysWorkflowsDto> list(int pageNo, int pageSize, Map<String, Object> map) {
        PageHelper.startPage(pageNo, pageSize);
        List<SysWorkflowsDto> lists = sysWorkflowsDao.list(map);
        PageInfo<SysWorkflowsDto> pageInfo = new PageInfo<>(lists);
        return pageInfo;
    }

    @Override
    public void insert(SysWorkflowsDto obj) {
        obj.setId(SnowflakeIdWorker.getUUID());
        obj.setCreateTime(new Date());
        sysWorkflowsDao.insert(obj);
    }

    @Override
    public void update(SysWorkflowsDto obj) {
        obj.setModifyTime(new Date());
        sysWorkflowsDao.update(obj);
    }

    @Override
    public void deleteByIds(List<Long> ids) {
        sysWorkflowsDao.deleteByIds(ids);
    }

    @Override
    public SysWorkflowsDto getById(Long id) {
        return sysWorkflowsDao.getById(id);
    }

    @Override
    public PageInfo<SysWorkflowsDto> list(SysWorkflowsQuery obj) {
        List<SysWorkflowsDto> lists = sysWorkflowsDao.selectList(obj);
        PageInfo<SysWorkflowsDto> pageInfo = new PageInfo<>(lists);
        return pageInfo;
    }

    @Override
    public List<SysWorkflowsDto> list(Map<String, Object> params) {
        return sysWorkflowsDao.list(params);
    }

    @Override
    public List<SysWorkflowsDto> selectList(SysWorkflowsQuery obj) {
        return sysWorkflowsDao.selectList(obj);
    }

}
