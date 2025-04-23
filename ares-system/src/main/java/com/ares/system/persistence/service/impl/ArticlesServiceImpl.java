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
import com.ares.system.model.query.ArticlesQuery;
import com.ares.system.model.vo.Articles;
import com.ares.system.persistence.dao.IArticlesDao;
import com.ares.system.persistence.entity.ArticlesDto;
import com.ares.system.persistence.service.IArticlesService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import io.github.linpeilie.Converter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;
import java.util.Map;


@Service
public class ArticlesServiceImpl implements IArticlesService {

    private IArticlesDao articlesDao;
    private Converter converter;

    @Autowired
    public ArticlesServiceImpl(IArticlesDao articlesDao, Converter converter) {
        this.articlesDao = articlesDao;
        this.converter = converter;
    }

    @Override
    public PageInfo<Articles> list(int pageNo, int pageSize, Map<String, Object> map) {
        PageHelper.startPage(pageNo, pageSize);
        List<Articles> lists = converter.convert(articlesDao.list(map), Articles.class);
        PageInfo<Articles> pageInfo = new PageInfo<>(lists);
        return pageInfo;
    }

    @Override
    public void insert(Articles obj) {
        obj.setId(SnowflakeIdWorker.getUUID());
        obj.setCreateTime(new Date());
        ArticlesDto articlesDto = converter.convert(obj, ArticlesDto.class);
        articlesDao.insert(articlesDto);
    }

    @Override
    public void update(Articles obj) {
        obj.setModifyTime(new Date());
        ArticlesDto articlesDto = converter.convert(obj, ArticlesDto.class);
        articlesDao.update(articlesDto);
    }

    @Override
    public void deleteByIds(List<Long> ids) {
        articlesDao.deleteByIds(ids);
    }

    @Override
    public Articles getById(Long id) {
        return converter.convert(articlesDao.getById(id), Articles.class);
    }

    @Override
    public PageInfo<Articles> list(ArticlesQuery obj) {
        List<ArticlesDto> lists = articlesDao.selectList(obj);
        PageInfo<ArticlesDto> pageInfo = new PageInfo<>(lists);
        PageInfo<Articles> page = pageInfo.convert(dto -> {
            Articles v = converter.convert(dto, Articles.class);
            return v;
        });
        return page;
    }

}
