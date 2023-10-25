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

package com.ares.core.persistence.service.impl;

import com.ares.core.model.query.SysDictTypeQuery;
import com.ares.core.persistence.dao.ISysDictTypeDao;
import com.ares.core.persistence.entity.SysDictType;
import com.ares.core.persistence.service.ISysDictTypeService;
import com.ares.core.utils.SnowflakeIdWorker;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;
import java.util.Map;

@Service
public class SysDictTypeServiceImpl implements ISysDictTypeService {

    private ISysDictTypeDao sysDictTypeDao;

    @Autowired
    public SysDictTypeServiceImpl(ISysDictTypeDao sysDictTypeDao) {
        this.sysDictTypeDao = sysDictTypeDao;
    }

    @Override
    public PageInfo<SysDictType> list(int pageNo, int pageSize, Map<String, Object> map) {
        PageHelper.startPage(pageNo, pageSize);
        List<SysDictType> lists = sysDictTypeDao.list(map);
        PageInfo<SysDictType> pageInfo = new PageInfo<>(lists);
        return pageInfo;
    }

    @Override
    public void insert(SysDictType obj) {
        obj.setId(SnowflakeIdWorker.getUUID());
        obj.setCreateTime(new Date());
        sysDictTypeDao.insert(obj);
    }

    @Override
    public void update(SysDictType obj) {
        obj.setModifyTime(new Date());
        sysDictTypeDao.update(obj);
    }

    @Override
    public void deleteByIds(List<Long> ids) {
        sysDictTypeDao.deleteByIds(ids);
    }

    @Override
    public SysDictType getById(Long id) {
        return sysDictTypeDao.getById(id);
    }

    @Override
    public List<SysDictType> list(SysDictTypeQuery obj) {
        List<SysDictType> lists = sysDictTypeDao.selectList(obj);
        return lists;
    }
}
