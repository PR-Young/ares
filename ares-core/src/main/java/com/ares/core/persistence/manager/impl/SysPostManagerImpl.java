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

import com.ares.core.model.query.SysPostQuery;
import com.ares.core.persistence.dao.ISysPostDao;
import com.ares.core.persistence.entity.SysPostDto;
import com.ares.core.persistence.manager.SysPostManager;
import com.ares.core.utils.SnowflakeIdWorker;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;
import java.util.Map;

@Service
public class SysPostManagerImpl implements SysPostManager {

    private ISysPostDao sysPostDao;

    @Autowired
    public SysPostManagerImpl(ISysPostDao sysPostDao) {
        this.sysPostDao = sysPostDao;
    }

    @Override
    public PageInfo<SysPostDto> list(int pageNo, int pageSize, Map<String, Object> map) {
        PageHelper.startPage(pageNo, pageSize);
        List<SysPostDto> lists = sysPostDao.list(map);
        PageInfo<SysPostDto> pageInfo = new PageInfo<>(lists);
        return pageInfo;
    }

    @Override
    public void insert(SysPostDto obj) {
        obj.setId(SnowflakeIdWorker.getUUID());
        obj.setCreateTime(new Date());
        sysPostDao.insert(obj);
    }

    @Override
    public void update(SysPostDto obj) {
        obj.setModifyTime(new Date());
        sysPostDao.update(obj);
    }

    @Override
    public void deleteByIds(List<Long> ids) {
        sysPostDao.deleteByIds(ids);
    }

    @Override
    public SysPostDto getById(Long id) {
        return sysPostDao.getById(id);
    }

    @Override
    public PageInfo<SysPostDto> list(SysPostQuery obj) {
        List<SysPostDto> lists = sysPostDao.selectList(obj);
        PageInfo<SysPostDto> pageInfo = new PageInfo<>(lists);
        return pageInfo;
    }


    @Override
    public List<SysPostDto> list(Map<String, Object> params) {
        return sysPostDao.list(params);
    }

    @Override
    public List<SysPostDto> selectList(SysPostQuery obj) {
        return sysPostDao.selectList(obj);
    }

    @Override
    public SysPostDto getByName(String name) {
        return sysPostDao.getByName(name);
    }
}
