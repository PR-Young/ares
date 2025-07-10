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

package com.ares.system.persistence.manager.impl;

import com.ares.core.utils.SnowflakeIdWorker;
import com.ares.system.model.query.ArticlesQuery;
import com.ares.system.persistence.dao.IArticlesDao;
import com.ares.system.persistence.entity.ArticlesDto;
import com.ares.system.persistence.manager.ArticlesManager;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;
import java.util.Map;


@Service
public class ArticlesManagerImpl implements ArticlesManager {

    private IArticlesDao articlesDao;

    @Autowired
    public ArticlesManagerImpl(IArticlesDao articlesDao) {
        this.articlesDao = articlesDao;
    }

    @Override
    public PageInfo<ArticlesDto> list(int pageNo, int pageSize, Map<String, Object> map) {
        PageHelper.startPage(pageNo, pageSize);
        List<ArticlesDto> lists = articlesDao.list(map);
        PageInfo<ArticlesDto> pageInfo = new PageInfo<>(lists);
        return pageInfo;
    }

    @Override
    public void insert(ArticlesDto obj) {
        obj.setId(SnowflakeIdWorker.getUUID());
        obj.setCreateTime(new Date());
        articlesDao.insert(obj);
    }

    @Override
    public void update(ArticlesDto obj) {
        obj.setModifyTime(new Date());
        articlesDao.update(obj);
    }

    @Override
    public void deleteByIds(List<Long> ids) {
        articlesDao.deleteByIds(ids);
    }

    @Override
    public ArticlesDto getById(Long id) {
        return articlesDao.getById(id);
    }

    @Override
    public PageInfo<ArticlesDto> list(ArticlesQuery obj) {
        List<ArticlesDto> lists = articlesDao.selectList(obj);
        PageInfo<ArticlesDto> pageInfo = new PageInfo<>(lists);
        return pageInfo;
    }

    @Override
    public List<ArticlesDto> list(Map<String, Object> params) {
        return articlesDao.list(params);
    }

    @Override
    public List<ArticlesDto> selectList(ArticlesQuery obj) {
        return articlesDao.selectList(obj);
    }

}
