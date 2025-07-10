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

package com.ares.flowable.persistence.manager.impl;

import com.ares.core.utils.SnowflakeIdWorker;
import com.ares.flowable.model.query.SysDeployFormQuery;
import com.ares.flowable.persistence.dao.ISysDeployFormDao;
import com.ares.flowable.persistence.entity.SysDeployFormDto;
import com.ares.flowable.persistence.entity.SysFormDto;
import com.ares.flowable.persistence.manager.SysDeployFormManager;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;
import java.util.Map;

@Service
public class SysDeployFormManagerImpl implements SysDeployFormManager {

    private ISysDeployFormDao sysDeployFormDao;

    @Autowired
    public SysDeployFormManagerImpl(ISysDeployFormDao sysDeployFormDao) {
        this.sysDeployFormDao = sysDeployFormDao;
    }

    @Override
    public PageInfo<SysDeployFormDto> list(int pageNo, int pageSize, Map<String, Object> map) {
        PageHelper.startPage(pageNo, pageSize);
        List<SysDeployFormDto> lists = sysDeployFormDao.list(map);
        PageInfo<SysDeployFormDto> pageInfo = new PageInfo<>(lists);
        return pageInfo;
    }

    @Override
    public void insert(SysDeployFormDto obj) {
        obj.setId(SnowflakeIdWorker.getUUID());
        obj.setCreateTime(new Date());
        sysDeployFormDao.insert(obj);
    }

    @Override
    public void update(SysDeployFormDto obj) {
        obj.setModifyTime(new Date());
        sysDeployFormDao.update(obj);
    }

    @Override
    public void deleteByIds(List<Long> ids) {
        sysDeployFormDao.deleteByIds(ids);
    }

    @Override
    public SysDeployFormDto getById(Long id) {
        return sysDeployFormDao.getById(id);
    }

    @Override
    public PageInfo<SysDeployFormDto> list(SysDeployFormQuery obj) {
        List<SysDeployFormDto> lists = sysDeployFormDao.selectList(obj);
        PageInfo<SysDeployFormDto> pageInfo = new PageInfo<>(lists);
        return pageInfo;
    }

    @Override
    public List<SysDeployFormDto> list(Map<String, Object> params) {
        return sysDeployFormDao.list(params);
    }

    @Override
    public List<SysDeployFormDto> selectList(SysDeployFormQuery obj) {
        return sysDeployFormDao.selectList(obj);
    }

    @Override
    public SysDeployFormDto selectSysDeployFormById(Long id) {
        return sysDeployFormDao.selectSysDeployFormById(id);
    }

    @Override
    public SysFormDto selectSysDeployFormByDeployId(String id) {
        return sysDeployFormDao.selectSysDeployFormByDeployId(id);
    }


}
