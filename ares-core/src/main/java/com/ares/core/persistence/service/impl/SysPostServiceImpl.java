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

import com.ares.core.model.query.SysPostQuery;
import com.ares.core.model.vo.SysPost;
import com.ares.core.persistence.dao.ISysPostDao;
import com.ares.core.persistence.entity.SysPostDto;
import com.ares.core.persistence.service.ISysPostService;
import com.ares.core.utils.SnowflakeIdWorker;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import io.github.linpeilie.Converter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class SysPostServiceImpl implements ISysPostService {

    private ISysPostDao sysPostDao;
    private Converter converter;

    @Autowired
    public SysPostServiceImpl(ISysPostDao sysPostDao, Converter converter) {
        this.sysPostDao = sysPostDao;
        this.converter = converter;
    }

    @Override
    public PageInfo<SysPost> list(int pageNo, int pageSize, Map<String, Object> map) {
        PageHelper.startPage(pageNo, pageSize);
        List<SysPost> lists = converter.convert(sysPostDao.list(map), SysPost.class);
        PageInfo<SysPost> pageInfo = new PageInfo<>(lists);
        return pageInfo;
    }

    @Override
    public void insert(SysPost obj) {
        obj.setId(SnowflakeIdWorker.getUUID());
        obj.setCreateTime(new Date());
        SysPostDto sysPostDto = converter.convert(obj, SysPostDto.class);
        sysPostDao.insert(sysPostDto);
    }

    @Override
    public void update(SysPost obj) {
        obj.setModifyTime(new Date());
        SysPostDto sysPostDto = converter.convert(obj, SysPostDto.class);
        sysPostDao.update(sysPostDto);
    }

    @Override
    public void deleteByIds(List<Long> ids) {
        sysPostDao.deleteByIds(ids);
    }

    @Override
    public SysPost getById(Long id) {
        return converter.convert(sysPostDao.getById(id), SysPost.class);
    }

    @Override
    public List<SysPost> list(SysPostQuery obj) {
        List<SysPost> lists = converter.convert(sysPostDao.selectList(obj), SysPost.class);
        return lists;
    }

    @Override
    public List<SysPost> getAll() {
        return converter.convert(sysPostDao.list(new HashMap<>()), SysPost.class);
    }

}
