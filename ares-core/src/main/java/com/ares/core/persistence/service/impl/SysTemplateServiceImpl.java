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

import com.ares.core.persistence.dao.ISysTemplateDao;
import com.ares.core.persistence.model.SysTemplate;
import com.ares.core.persistence.service.ISysTemplateService;
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
public class SysTemplateServiceImpl implements ISysTemplateService {

    private ISysTemplateDao sysTemplateDao;

    @Autowired
    public SysTemplateServiceImpl(ISysTemplateDao sysTemplateDao) {
        this.sysTemplateDao = sysTemplateDao;
    }

    @Override
    public PageInfo<SysTemplate> list(int pageNo, int pageSize, Map<String, Object> map) {
        PageHelper.startPage(pageNo, pageSize);
        List<SysTemplate> lists = sysTemplateDao.list(map);
        PageInfo<SysTemplate> pageInfo = new PageInfo<>(lists);
        return pageInfo;
    }

    @Override
    public void insert(SysTemplate obj) {
        obj.setId(SnowflakeIdWorker.getUUID());
        obj.setCreateTime(new Date());
        sysTemplateDao.insert(obj);
    }

    @Override
    public void update(SysTemplate obj) {
        obj.setModifyTime(new Date());
        sysTemplateDao.update(obj);
    }

    @Override
    public void deleteByIds(List<String> ids) {
        sysTemplateDao.deleteByIds(ids);
    }

    @Override
    public SysTemplate getById(String id) {
        return sysTemplateDao.getById(id);
    }

    @Override
    public List<SysTemplate> list(SysTemplate obj) {
        List<SysTemplate> lists = sysTemplateDao.selectList(obj);
        return lists;
    }


    @Override
    public boolean saveBatch(Collection<SysTemplate> entityList, int batchSize) {
        return false;
    }

    @Override
    public boolean saveOrUpdateBatch(Collection<SysTemplate> entityList, int batchSize) {
        return false;
    }

    @Override
    public boolean updateBatchById(Collection<SysTemplate> entityList, int batchSize) {
        return false;
    }

    @Override
    public boolean saveOrUpdate(SysTemplate entity) {
        return false;
    }

    @Override
    public SysTemplate getOne(Wrapper<SysTemplate> queryWrapper, boolean throwEx) {
        return null;
    }

    @Override
    public Map<String, Object> getMap(Wrapper<SysTemplate> queryWrapper) {
        return null;
    }

    @Override
    public <V> V getObj(Wrapper<SysTemplate> queryWrapper, Function<? super Object, V> mapper) {
        return null;
    }

    @Override
    public BaseMapper<SysTemplate> getBaseMapper() {
        return null;
    }

    @Override
    public Class<SysTemplate> getEntityClass() {
        return null;
    }
}
