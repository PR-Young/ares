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

import com.ares.core.model.query.SysDeptQuery;
import com.ares.core.persistence.dao.ISysDeptDao;
import com.ares.core.persistence.entity.SysDeptDto;
import com.ares.core.persistence.manager.SysDeptManager;
import com.ares.core.utils.SnowflakeIdWorker;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * @author young
 */
@Service
public class SysDeptManagerImpl implements SysDeptManager {

    private ISysDeptDao sysDeptDao;

    @Autowired
    public SysDeptManagerImpl(ISysDeptDao sysDeptDao) {
        this.sysDeptDao = sysDeptDao;
    }


    @Override
    public void insert(SysDeptDto obj) {
        obj.setId(SnowflakeIdWorker.getUUID());
        obj.setCreateTime(new Date());
        sysDeptDao.insert(obj);
    }

    @Override
    public void update(SysDeptDto obj) {
        obj.setModifyTime(new Date());
        sysDeptDao.update(obj);
    }

    @Override
    public void deleteByIds(List<Long> ids) {
        sysDeptDao.deleteByIds(ids);
    }

    @Override
    public SysDeptDto getById(Long id) {
        return sysDeptDao.getById(id);
    }

    @Override
    public PageInfo<SysDeptDto> list(int pageNo, int pageSize, Map<String, Object> map) {
        PageHelper.startPage(pageNo, pageSize);
        List<SysDeptDto> lists = sysDeptDao.list(map);
        PageInfo<SysDeptDto> pageInfo = new PageInfo<>(lists);
        return pageInfo;
    }

    @Override
    public PageInfo<SysDeptDto> list(SysDeptQuery obj) {
        List<SysDeptDto> lists = sysDeptDao.selectList(obj);
        PageInfo<SysDeptDto> pageInfo = new PageInfo<>(lists);
        return pageInfo;
    }

    @Override
    public List<SysDeptDto> list(Map<String, Object> params) {
        return sysDeptDao.list(params);
    }

    @Override
    public List<SysDeptDto> selectList(SysDeptQuery obj) {
        return sysDeptDao.selectList(obj);
    }

    @Override
    public SysDeptDto getByDeptId(Long id) {
        return sysDeptDao.getByDeptId(id);
    }

    @Override
    public List<SysDeptDto> getAllDept() {
        return sysDeptDao.getAllDept();
    }

}
