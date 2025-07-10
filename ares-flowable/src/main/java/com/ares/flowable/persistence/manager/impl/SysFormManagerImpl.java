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
import com.ares.flowable.model.query.SysFormQuery;
import com.ares.flowable.persistence.dao.ISysFormDao;
import com.ares.flowable.persistence.entity.SysFormDto;
import com.ares.flowable.persistence.manager.SysFormManager;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;
import java.util.Map;

@Service
public class SysFormManagerImpl implements SysFormManager {

    private ISysFormDao sysFormDao;

    @Autowired
    public SysFormManagerImpl(ISysFormDao sysFormDao) {
        this.sysFormDao = sysFormDao;
    }

    @Override
    public PageInfo<SysFormDto> list(int pageNo, int pageSize, Map<String, Object> map) {
        PageHelper.startPage(pageNo, pageSize);
        List<SysFormDto> lists = sysFormDao.list(map);
        PageInfo<SysFormDto> pageInfo = new PageInfo<>(lists);
        return pageInfo;
    }

    @Override
    public void insert(SysFormDto obj) {
        obj.setId(SnowflakeIdWorker.getUUID());
        obj.setCreateTime(new Date());
        sysFormDao.insert(obj);
    }

    @Override
    public void update(SysFormDto obj) {
        obj.setModifyTime(new Date());
        sysFormDao.update(obj);
    }

    @Override
    public void deleteByIds(List<Long> ids) {
        sysFormDao.deleteByIds(ids);
    }

    @Override
    public SysFormDto getById(Long id) {
        return sysFormDao.getById(id);
    }

    @Override
    public PageInfo<SysFormDto> list(SysFormQuery obj) {
        List<SysFormDto> lists = sysFormDao.selectList(obj);
        PageInfo<SysFormDto> pageInfo = new PageInfo<>(lists);
        return pageInfo;
    }

    @Override
    public List<SysFormDto> list(Map<String, Object> params) {
        return sysFormDao.list(params);
    }

    @Override
    public List<SysFormDto> selectList(SysFormQuery obj) {
        return sysFormDao.selectList(obj);
    }
}
