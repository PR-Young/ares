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

import com.ares.core.model.query.SysDictDataQuery;
import com.ares.core.persistence.dao.ISysDictDataDao;
import com.ares.core.persistence.entity.SysDictDataDto;
import com.ares.core.persistence.manager.SysDictDataManager;
import com.ares.core.utils.SnowflakeIdWorker;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;
import java.util.Map;

@Service
public class SysDictDataManagerImpl implements SysDictDataManager {

    private ISysDictDataDao sysDictDataDao;


    @Autowired
    public SysDictDataManagerImpl(ISysDictDataDao sysDictDataDao) {
        this.sysDictDataDao = sysDictDataDao;
    }

    @Override
    public PageInfo<SysDictDataDto> list(int pageNo, int pageSize, Map<String, Object> map) {
        PageHelper.startPage(pageNo, pageSize);
        List<SysDictDataDto> lists = sysDictDataDao.list(map);
        PageInfo<SysDictDataDto> pageInfo = new PageInfo<>(lists);
        return pageInfo;
    }

    @Override
    public void insert(SysDictDataDto obj) {
        obj.setId(SnowflakeIdWorker.getUUID());
        obj.setCreateTime(new Date());
        sysDictDataDao.insert(obj);
    }

    @Override
    public void update(SysDictDataDto obj) {
        obj.setModifyTime(new Date());
        sysDictDataDao.update(obj);
    }

    @Override
    public void deleteByIds(List<Long> ids) {
        sysDictDataDao.deleteByIds(ids);
    }

    @Override
    public SysDictDataDto getById(Long id) {
        return sysDictDataDao.getById(id);
    }

    @Override
    public PageInfo<SysDictDataDto> list(SysDictDataQuery obj) {
        List<SysDictDataDto> lists = sysDictDataDao.selectList(obj);
        PageInfo<SysDictDataDto> pageInfo = new PageInfo<>(lists);
        return pageInfo;
    }

    @Override
    public List<SysDictDataDto> list(Map<String, Object> params) {
        return sysDictDataDao.list(params);
    }

    @Override
    public List<SysDictDataDto> selectList(SysDictDataQuery obj) {
        return sysDictDataDao.selectList(obj);
    }

    @Override
    public List<SysDictDataDto> getDicts(String dictType) {
        return sysDictDataDao.getDicts(dictType);
    }
}
