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

package com.ares.flowable.persistence.service.impl;


import com.ares.core.utils.SnowflakeIdWorker;
import com.ares.flowable.model.query.SysFormDataQuery;
import com.ares.flowable.persistence.dao.ISysFormDataDao;
import com.ares.flowable.persistence.entity.SysFormData;
import com.ares.flowable.persistence.service.ISysFormDataService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;
import java.util.Map;

@Service
public class SysFormDataServiceImpl implements ISysFormDataService {

    private ISysFormDataDao sysFormDataDao;

    @Autowired
    public SysFormDataServiceImpl(ISysFormDataDao sysFormDataDao) {
        this.sysFormDataDao = sysFormDataDao;
    }

    @Override
    public PageInfo<SysFormData> list(int pageNo, int pageSize, Map<String, Object> map) {
        PageHelper.startPage(pageNo, pageSize);
        List<SysFormData> lists = sysFormDataDao.list(map);
        PageInfo<SysFormData> pageInfo = new PageInfo<>(lists);
        return pageInfo;
    }

    @Override
    public void insert(SysFormData obj) {
        obj.setId(SnowflakeIdWorker.getUUID());
        obj.setCreateTime(new Date());
        sysFormDataDao.insert(obj);
    }

    @Override
    public void update(SysFormData obj) {
        obj.setModifyTime(new Date());
        sysFormDataDao.update(obj);
    }

    @Override
    public void deleteByIds(List<Long> ids) {
        sysFormDataDao.deleteByIds(ids);
    }

    @Override
    public SysFormData getById(Long id) {
        return sysFormDataDao.getById(id);
    }

    @Override
    public List<SysFormData> list(SysFormDataQuery obj) {
        List<SysFormData> lists = sysFormDataDao.selectList(obj);
        return lists;
    }

    @Override
    public SysFormData getFormDataByProInstId(String proInstId) {
        return sysFormDataDao.getFormDataByProInstId(proInstId);
    }

}
