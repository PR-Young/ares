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

package com.ares.core.service.impl;

import com.ares.core.model.query.SysPostQuery;
import com.ares.core.model.vo.SysPost;
import com.ares.core.persistence.entity.SysPostDto;
import com.ares.core.persistence.manager.SysPostManager;
import com.ares.core.service.ISysPostService;
import com.github.pagehelper.PageInfo;
import io.github.linpeilie.Converter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class SysPostServiceImpl implements ISysPostService {

    private SysPostManager postManager;
    private Converter converter;

    @Autowired
    public SysPostServiceImpl(SysPostManager postManager, Converter converter) {
        this.postManager = postManager;
        this.converter = converter;
    }

    @Override
    public PageInfo<SysPost> list(int pageNo, int pageSize, Map<String, Object> map) {
        PageInfo<SysPostDto> list = postManager.list(pageNo, pageSize, map);
        PageInfo<SysPost> pageInfo = list.convert(dto -> {
            SysPost v = converter.convert(dto, SysPost.class);
            return v;
        });
        return pageInfo;
    }

    @Override
    public void insert(SysPost obj) {
        SysPostDto sysPostDto = converter.convert(obj, SysPostDto.class);
        postManager.insert(sysPostDto);
    }

    @Override
    public void update(SysPost obj) {
        SysPostDto sysPostDto = converter.convert(obj, SysPostDto.class);
        postManager.update(sysPostDto);
    }

    @Override
    public void deleteByIds(List<Long> ids) {
        postManager.deleteByIds(ids);
    }

    @Override
    public SysPost getById(Long id) {
        return converter.convert(postManager.getById(id), SysPost.class);
    }

    @Override
    public PageInfo<SysPost> list(SysPostQuery obj) {
        List<SysPostDto> lists = postManager.selectList(obj);
        PageInfo<SysPostDto> pageInfo = new PageInfo<>(lists);
        PageInfo<SysPost> page = pageInfo.convert(dto -> {
            SysPost v = converter.convert(dto, SysPost.class);
            return v;
        });
        return page;
    }

    @Override
    public List<SysPost> getAll() {
        return converter.convert(postManager.list(new HashMap<>()), SysPost.class);
    }

    @Override
    public SysPost getByName(String name) {
        return converter.convert(postManager.getByName(name), SysPost.class);
    }

}
