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

package com.ares.core.persistence.service.impl;

import com.ares.core.model.query.SysTenantsQuery;
import com.ares.core.persistence.dao.ISysTenantsDao;
import com.ares.core.persistence.model.SysTenants;
import com.ares.core.persistence.service.ISysTenantsService;
import com.ares.core.utils.SnowflakeIdWorker;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;
import java.util.Map;

@Service
public class SysTenantsServiceImpl implements ISysTenantsService {

    private ISysTenantsDao sysTenantsDao;

    @Autowired
    public SysTenantsServiceImpl(ISysTenantsDao sysTenantsDao) {
        this.sysTenantsDao = sysTenantsDao;
    }

    @Override
    public PageInfo<SysTenants> list(int pageNo, int pageSize, Map<String, Object> map) {
        PageHelper.startPage(pageNo, pageSize);
        List<SysTenants> lists = sysTenantsDao.list(map);
        PageInfo<SysTenants> pageInfo = new PageInfo<>(lists);
        return pageInfo;
    }

    @Override
    public void insert(SysTenants obj) {
        obj.setId(SnowflakeIdWorker.getUUID());
        obj.setCreateTime(new Date());
        sysTenantsDao.insert(obj);
    }

    @Override
    public void update(SysTenants obj) {
        obj.setModifyTime(new Date());
        sysTenantsDao.update(obj);
    }

    @Override
    public void deleteByIds(List<Long> ids) {
        sysTenantsDao.deleteByIds(ids);
    }

    @Override
    public SysTenants getById(Long id) {
        return sysTenantsDao.getById(id);
    }

    @Override
    public List<SysTenants> list(SysTenantsQuery obj) {
        List<SysTenants> lists = sysTenantsDao.selectList(obj);
        return lists;
    }

}