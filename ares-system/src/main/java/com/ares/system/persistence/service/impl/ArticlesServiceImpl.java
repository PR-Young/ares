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

package com.ares.system.persistence.service.impl;

import com.ares.core.utils.SnowflakeIdWorker;
import com.ares.system.persistence.dao.IArticlesDao;
import com.ares.system.persistence.model.Articles;
import com.ares.system.persistence.service.IArticlesService;
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
public class ArticlesServiceImpl implements IArticlesService {

    private IArticlesDao articlesDao;

    @Autowired
    public ArticlesServiceImpl(IArticlesDao articlesDao) {
        this.articlesDao = articlesDao;
    }

    @Override
    public PageInfo<Articles> list(int pageNo, int pageSize, Map<String, Object> map) {
        PageHelper.startPage(pageNo, pageSize);
        List<Articles> lists = articlesDao.list(map);
        PageInfo<Articles> pageInfo = new PageInfo<>(lists);
        return pageInfo;
    }

    @Override
    public void insert(Articles obj) {
        obj.setId(SnowflakeIdWorker.getUUID());
        obj.setCreateTime(new Date());
        articlesDao.insert(obj);
    }

    @Override
    public void update(Articles obj) {
        obj.setModifyTime(new Date());
        articlesDao.update(obj);
    }

    @Override
    public void deleteByIds(List<String> ids) {
        articlesDao.deleteByIds(ids);
    }

    @Override
    public Articles getById(String id) {
        return articlesDao.getById(id);
    }

    @Override
    public List<Articles> list(Articles obj) {
        List<Articles> lists = articlesDao.selectList(obj);
        return lists;
    }


    @Override
    public boolean saveBatch(Collection<Articles> entityList, int batchSize) {
        return false;
    }

    @Override
    public boolean saveOrUpdateBatch(Collection<Articles> entityList, int batchSize) {
        return false;
    }

    @Override
    public boolean updateBatchById(Collection<Articles> entityList, int batchSize) {
        return false;
    }

    @Override
    public boolean saveOrUpdate(Articles entity) {
        return false;
    }

    @Override
    public Articles getOne(Wrapper<Articles> queryWrapper, boolean throwEx) {
        return null;
    }

    @Override
    public Map<String, Object> getMap(Wrapper<Articles> queryWrapper) {
        return null;
    }

    @Override
    public <V> V getObj(Wrapper<Articles> queryWrapper, Function<? super Object, V> mapper) {
        return null;
    }

    @Override
    public BaseMapper<Articles> getBaseMapper() {
        return null;
    }

    @Override
    public Class<Articles> getEntityClass() {
        return null;
    }
}
