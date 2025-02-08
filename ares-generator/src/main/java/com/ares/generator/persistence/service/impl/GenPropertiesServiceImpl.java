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

package com.ares.generator.persistence.service.impl;

import com.ares.core.common.security.SecurityUtils;
import com.ares.core.utils.SnowflakeIdWorker;
import com.ares.generator.model.vo.GenProperties;
import com.ares.generator.model.query.GenPropertiesQuery;
import com.ares.generator.persistence.dao.IGenPropertiesDao;
import com.ares.generator.persistence.entity.GenPropertiesDto;
import com.ares.generator.persistence.service.IGenPropertiesService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import io.github.linpeilie.Converter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;
import java.util.Map;

@Service
public class GenPropertiesServiceImpl implements IGenPropertiesService {

    private IGenPropertiesDao genPropertiesDao;
    private Converter converter;

    @Autowired
    public GenPropertiesServiceImpl(IGenPropertiesDao genPropertiesDao, Converter converter) {
        this.genPropertiesDao = genPropertiesDao;
        this.converter = converter;
    }

    @Override
    public PageInfo<GenProperties> list(int pageNo, int pageSize, Map<String, Object> map) {
        PageHelper.startPage(pageNo, pageSize);
        List<GenProperties> lists = converter.convert(genPropertiesDao.list(map), GenProperties.class);
        PageInfo<GenProperties> pageInfo = new PageInfo<>(lists);
        return pageInfo;
    }

    @Override
    public void insert(GenProperties obj) {
        obj.setId(SnowflakeIdWorker.getUUID());
        obj.setCreateTime(new Date());
        GenPropertiesDto genPropertiesDto = converter.convert(obj, GenPropertiesDto.class);
        genPropertiesDao.insert(genPropertiesDto);
    }

    @Override
    public void update(GenProperties obj) {
        obj.setModifyTime(new Date());
        GenPropertiesDto genPropertiesDto = converter.convert(obj, GenPropertiesDto.class);
        genPropertiesDao.update(genPropertiesDto);
    }

    @Override
    public void deleteByIds(List<Long> ids) {
        genPropertiesDao.deleteByIds(ids);
    }

    @Override
    public GenProperties getById(Long id) {
        return converter.convert(genPropertiesDao.getById(id), GenProperties.class);
    }

    @Override
    public List<GenProperties> list(GenPropertiesQuery obj) {
        List<GenProperties> lists = converter.convert(genPropertiesDao.selectList(obj), GenProperties.class);
        return lists;
    }

    @Override
    public GenProperties getByUser() {
        GenPropertiesDto genPropertiesDto = genPropertiesDao.getByUser(SecurityUtils.getUser().getId());
        return converter.convert(genPropertiesDto, GenProperties.class);
    }
}
