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

package com.ares.system.service.impl;

import com.ares.system.model.query.ArticlesQuery;
import com.ares.system.model.vo.Articles;
import com.ares.system.persistence.entity.ArticlesDto;
import com.ares.system.persistence.manager.ArticlesManager;
import com.ares.system.service.IArticlesService;
import com.github.pagehelper.PageInfo;
import io.github.linpeilie.Converter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;


@Service
public class ArticlesServiceImpl implements IArticlesService {

    private ArticlesManager articlesManager;
    private Converter converter;

    @Autowired
    public ArticlesServiceImpl(ArticlesManager articlesManager, Converter converter) {
        this.articlesManager = articlesManager;
        this.converter = converter;
    }

    @Override
    public PageInfo<Articles> list(int pageNo, int pageSize, Map<String, Object> map) {
        PageInfo<ArticlesDto> list = articlesManager.list(pageNo, pageSize, map);
        PageInfo<Articles> pageInfo = list.convert(dto -> {
            Articles v = converter.convert(dto, Articles.class);
            return v;
        });
        return pageInfo;
    }

    @Override
    public void insert(Articles obj) {
        ArticlesDto articlesDto = converter.convert(obj, ArticlesDto.class);
        articlesManager.insert(articlesDto);
    }

    @Override
    public void update(Articles obj) {
        ArticlesDto articlesDto = converter.convert(obj, ArticlesDto.class);
        articlesManager.update(articlesDto);
    }

    @Override
    public void deleteByIds(List<Long> ids) {
        articlesManager.deleteByIds(ids);
    }

    @Override
    public Articles getById(Long id) {
        return converter.convert(articlesManager.getById(id), Articles.class);
    }

    @Override
    public PageInfo<Articles> list(ArticlesQuery obj) {
        List<ArticlesDto> lists = articlesManager.selectList(obj);
        PageInfo<ArticlesDto> pageInfo = new PageInfo<>(lists);
        PageInfo<Articles> page = pageInfo.convert(dto -> {
            Articles v = converter.convert(dto, Articles.class);
            return v;
        });
        return page;
    }

}
