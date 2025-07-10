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

package com.ares.core.persistence.manager.impl;

import com.ares.core.model.query.SysPropertiesQuery;
import com.ares.core.persistence.dao.ISysPropertiesDao;
import com.ares.core.persistence.entity.SysPropertiesDto;
import com.ares.core.persistence.manager.SysPropertiesManager;
import com.ares.core.utils.SnowflakeIdWorker;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;
import java.util.Map;

@Service
public class SysPropertiesManagerImpl implements SysPropertiesManager {

    private ISysPropertiesDao sysPropertiesDao;

    @Autowired
    public SysPropertiesManagerImpl(ISysPropertiesDao sysPropertiesDao) {
        this.sysPropertiesDao = sysPropertiesDao;
    }

    @Override
    public PageInfo<SysPropertiesDto> list(int pageNo, int pageSize, Map<String, Object> map) {
        PageHelper.startPage(pageNo, pageSize);
        List<SysPropertiesDto> lists = sysPropertiesDao.list(map);
        PageInfo<SysPropertiesDto> pageInfo = new PageInfo<>(lists);
        return pageInfo;
    }

    @Override
    public void insert(SysPropertiesDto obj) {
        obj.setId(SnowflakeIdWorker.getUUID());
        obj.setCreateTime(new Date());
        sysPropertiesDao.insert(obj);
    }

    @Override
    public void update(SysPropertiesDto obj) {
        obj.setModifyTime(new Date());
        sysPropertiesDao.update(obj);
    }

    @Override
    public void deleteByIds(List<Long> ids) {
        sysPropertiesDao.deleteByIds(ids);
    }

    @Override
    public SysPropertiesDto getById(Long id) {
        return sysPropertiesDao.getById(id);
    }

    @Override
    public PageInfo<SysPropertiesDto> list(SysPropertiesQuery obj) {
        List<SysPropertiesDto> lists = sysPropertiesDao.selectList(obj);
        PageInfo<SysPropertiesDto> pageInfo = new PageInfo<>(lists);
        return pageInfo;
    }

    @Override
    public List<SysPropertiesDto> list(Map<String, Object> params) {
        return sysPropertiesDao.list(params);
    }

    @Override
    public List<SysPropertiesDto> selectList(SysPropertiesQuery obj) {
        return sysPropertiesDao.selectList(obj);
    }


    @Override
    public String getValueByAlias(String alias) {
        return sysPropertiesDao.getValueByAlias(alias);
    }

    @Override
    public List<SysPropertiesDto> getByGroup(String group) {
        return sysPropertiesDao.getByGroup(group);
    }
}
