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

import com.ares.core.model.query.SysDictTypeQuery;
import com.ares.core.persistence.dao.ISysDictTypeDao;
import com.ares.core.persistence.entity.SysDictTypeDto;
import com.ares.core.persistence.manager.SysDictTypeManager;
import com.ares.core.utils.SnowflakeIdWorker;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;
import java.util.Map;

@Service
public class SysDictTypeManagerImpl implements SysDictTypeManager {

    private ISysDictTypeDao sysDictTypeDao;

    @Autowired
    public SysDictTypeManagerImpl(ISysDictTypeDao sysDictTypeDao) {
        this.sysDictTypeDao = sysDictTypeDao;
    }

    @Override
    public PageInfo<SysDictTypeDto> list(int pageNo, int pageSize, Map<String, Object> map) {
        PageHelper.startPage(pageNo, pageSize);
        List<SysDictTypeDto> lists = sysDictTypeDao.list(map);
        PageInfo<SysDictTypeDto> pageInfo = new PageInfo<>(lists);
        return pageInfo;
    }

    @Override
    public void insert(SysDictTypeDto obj) {
        obj.setId(SnowflakeIdWorker.getUUID());
        obj.setCreateTime(new Date());
        sysDictTypeDao.insert(obj);
    }

    @Override
    public void update(SysDictTypeDto obj) {
        obj.setModifyTime(new Date());
        sysDictTypeDao.update(obj);
    }

    @Override
    public void deleteByIds(List<Long> ids) {
        sysDictTypeDao.deleteByIds(ids);
    }

    @Override
    public SysDictTypeDto getById(Long id) {
        return sysDictTypeDao.getById(id);
    }

    @Override
    public PageInfo<SysDictTypeDto> list(SysDictTypeQuery obj) {
        List<SysDictTypeDto> lists = sysDictTypeDao.selectList(obj);
        PageInfo<SysDictTypeDto> pageInfo = new PageInfo<>(lists);
        return pageInfo;
    }

    @Override
    public List<SysDictTypeDto> list(Map<String, Object> params) {
        return sysDictTypeDao.list(params);
    }

    @Override
    public List<SysDictTypeDto> selectList(SysDictTypeQuery obj) {
        return sysDictTypeDao.selectList(obj);
    }
}
