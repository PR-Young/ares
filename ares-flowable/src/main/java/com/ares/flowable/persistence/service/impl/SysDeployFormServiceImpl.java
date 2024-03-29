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
import com.ares.flowable.model.query.SysDeployFormQuery;
import com.ares.flowable.persistence.dao.ISysDeployFormDao;
import com.ares.flowable.persistence.entity.SysDeployForm;
import com.ares.flowable.persistence.entity.SysForm;
import com.ares.flowable.persistence.service.ISysDeployFormService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;
import java.util.Map;

@Service
public class SysDeployFormServiceImpl implements ISysDeployFormService {

    private ISysDeployFormDao sysDeployFormDao;

    @Autowired
    public SysDeployFormServiceImpl(ISysDeployFormDao sysDeployFormDao) {
        this.sysDeployFormDao = sysDeployFormDao;
    }

    @Override
    public PageInfo<SysDeployForm> list(int pageNo, int pageSize, Map<String, Object> map) {
        PageHelper.startPage(pageNo, pageSize);
        List<SysDeployForm> lists = sysDeployFormDao.list(map);
        PageInfo<SysDeployForm> pageInfo = new PageInfo<>(lists);
        return pageInfo;
    }

    @Override
    public void insert(SysDeployForm obj) {
        obj.setId(SnowflakeIdWorker.getUUID());
        obj.setCreateTime(new Date());
        sysDeployFormDao.insert(obj);
    }

    @Override
    public void update(SysDeployForm obj) {
        obj.setModifyTime(new Date());
        sysDeployFormDao.update(obj);
    }

    @Override
    public void deleteByIds(List<Long> ids) {
        sysDeployFormDao.deleteByIds(ids);
    }

    @Override
    public SysDeployForm getById(Long id) {
        return sysDeployFormDao.getById(id);
    }

    @Override
    public List<SysDeployForm> list(SysDeployFormQuery obj) {
        List<SysDeployForm> lists = sysDeployFormDao.selectList(obj);
        return lists;
    }

    @Override
    public SysDeployForm selectSysDeployFormById(Long id) {
        return sysDeployFormDao.selectSysDeployFormById(id);
    }

    @Override
    public SysForm selectSysDeployFormByDeployId(String id) {
        return sysDeployFormDao.selectSysDeployFormByDeployId(id);
    }

}
