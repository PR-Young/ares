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

import com.ares.core.model.query.SysTemplateQuery;
import com.ares.core.persistence.dao.ISysTemplateDao;
import com.ares.core.persistence.entity.SysTemplateDto;
import com.ares.core.persistence.manager.SysTemplateManager;
import com.ares.core.utils.SnowflakeIdWorker;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;
import java.util.Map;

@Service
public class SysTemplateManagerImpl implements SysTemplateManager {

    private ISysTemplateDao sysTemplateDao;

    @Autowired
    public SysTemplateManagerImpl(ISysTemplateDao sysTemplateDao) {
        this.sysTemplateDao = sysTemplateDao;
    }

    @Override
    public PageInfo<SysTemplateDto> list(int pageNo, int pageSize, Map<String, Object> map) {
        PageHelper.startPage(pageNo, pageSize);
        List<SysTemplateDto> lists = sysTemplateDao.list(map);
        PageInfo<SysTemplateDto> pageInfo = new PageInfo<>(lists);
        return pageInfo;
    }

    @Override
    public void insert(SysTemplateDto obj) {
        obj.setId(SnowflakeIdWorker.getUUID());
        obj.setCreateTime(new Date());
        sysTemplateDao.insert(obj);
    }

    @Override
    public void update(SysTemplateDto obj) {
        obj.setModifyTime(new Date());
        sysTemplateDao.update(obj);
    }

    @Override
    public void deleteByIds(List<Long> ids) {
        sysTemplateDao.deleteByIds(ids);
    }

    @Override
    public SysTemplateDto getById(Long id) {
        return sysTemplateDao.getById(id);
    }

    @Override
    public PageInfo<SysTemplateDto> list(SysTemplateQuery obj) {
        List<SysTemplateDto> lists = sysTemplateDao.selectList(obj);
        PageInfo<SysTemplateDto> pageInfo = new PageInfo<>(lists);
        return pageInfo;
    }

    @Override
    public List<SysTemplateDto> list(Map<String, Object> params) {
        return sysTemplateDao.list(params);
    }

    @Override
    public List<SysTemplateDto> selectList(SysTemplateQuery obj) {
        return sysTemplateDao.selectList(obj);
    }

    @Override
    public SysTemplateDto getByName(String name) {
        return sysTemplateDao.getByName(name);
    }
}
