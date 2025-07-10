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

package com.ares.generator.persistence.manager.impl;

import com.ares.core.common.security.SecurityUtils;
import com.ares.core.utils.SnowflakeIdWorker;
import com.ares.generator.model.query.GenPropertiesQuery;
import com.ares.generator.persistence.dao.IGenPropertiesDao;
import com.ares.generator.persistence.entity.GenPropertiesDto;
import com.ares.generator.persistence.manager.GenPropertiesManager;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;
import java.util.Map;

@Service
public class GenPropertiesManagerImpl implements GenPropertiesManager {

    private IGenPropertiesDao genPropertiesDao;
    

    @Autowired
    public GenPropertiesManagerImpl(IGenPropertiesDao genPropertiesDao) {
        this.genPropertiesDao = genPropertiesDao;
    }

    @Override
    public PageInfo<GenPropertiesDto> list(int pageNo, int pageSize, Map<String, Object> map) {
        PageHelper.startPage(pageNo, pageSize);
        List<GenPropertiesDto> lists = genPropertiesDao.list(map);
        PageInfo<GenPropertiesDto> pageInfo = new PageInfo<>(lists);
        return pageInfo;
    }

    @Override
    public void insert(GenPropertiesDto obj) {
        obj.setId(SnowflakeIdWorker.getUUID());
        obj.setCreateTime(new Date());
        genPropertiesDao.insert(obj);
    }

    @Override
    public void update(GenPropertiesDto obj) {
        obj.setModifyTime(new Date());
        genPropertiesDao.update(obj);
    }

    @Override
    public void deleteByIds(List<Long> ids) {
        genPropertiesDao.deleteByIds(ids);
    }

    @Override
    public GenPropertiesDto getById(Long id) {
        return genPropertiesDao.getById(id);
    }

    @Override
    public PageInfo<GenPropertiesDto> list(GenPropertiesQuery obj) {
        List<GenPropertiesDto> lists = genPropertiesDao.selectList(obj);
        PageInfo<GenPropertiesDto> pageInfo = new PageInfo<>(lists);
        return pageInfo;
    }

    @Override
    public List<GenPropertiesDto> list(Map<String, Object> params) {
        return genPropertiesDao.list(params);
    }

    @Override
    public List<GenPropertiesDto> selectList(GenPropertiesQuery obj) {
        return genPropertiesDao.selectList(obj);
    }

    @Override
    public GenPropertiesDto getByUser() {
        GenPropertiesDto genPropertiesDto = genPropertiesDao.getByUser(SecurityUtils.getUser().getId());
        return genPropertiesDto;
    }
}
