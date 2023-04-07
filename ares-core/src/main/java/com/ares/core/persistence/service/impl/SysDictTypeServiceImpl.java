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

import com.ares.core.persistence.dao.ISysDictTypeDao;
import com.ares.core.persistence.model.SysDictType;
import com.ares.core.persistence.service.ISysDictTypeService;
import com.ares.core.utils.SnowflakeIdWorker;
import com.baomidou.mybatisplus.core.conditions.Wrapper;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Collection;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.function.Function;

@Service
public class SysDictTypeServiceImpl implements ISysDictTypeService {

    private ISysDictTypeDao sysDictTypeDao;

    @Autowired
    public SysDictTypeServiceImpl(ISysDictTypeDao sysDictTypeDao) {
        this.sysDictTypeDao = sysDictTypeDao;
    }

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
    public void deleteByIds(List<String> ids) {
        sysDictTypeDao.deleteByIds(ids);
    }

    @Override
    public SysDictType getById(String id) {
        return sysDictTypeDao.getById(id);
    }

    @Override
    public List<SysDictType> list(SysDictType obj) {
        List<SysDictType> lists = sysDictTypeDao.selectList(obj);
        return lists;
    }


    @Override
    public boolean saveBatch(Collection<SysDictType> entityList, int batchSize) {
        return false;
    }

    @Override
    public boolean saveOrUpdateBatch(Collection<SysDictType> entityList, int batchSize) {
        return false;
    }

    @Override
    public boolean updateBatchById(Collection<SysDictType> entityList, int batchSize) {
        return false;
    }

    @Override
    public boolean saveOrUpdate(SysDictType entity) {
        return false;
    }

    @Override
    public SysDictType getOne(Wrapper<SysDictType> queryWrapper, boolean throwEx) {
        return null;
    }

    @Override
    public Map<String, Object> getMap(Wrapper<SysDictType> queryWrapper) {
        return null;
    }

    @Override
    public <V> V getObj(Wrapper<SysDictType> queryWrapper, Function<? super Object, V> mapper) {
        return null;
    }

    @Override
    public BaseMapper<SysDictType> getBaseMapper() {
        return null;
    }

    @Override
    public Class<SysDictType> getEntityClass() {
        return null;
    }
}
