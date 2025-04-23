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

import com.ares.core.model.query.SysTemplateQuery;
import com.ares.core.model.vo.SysTemplate;
import com.ares.core.persistence.dao.ISysTemplateDao;
import com.ares.core.persistence.entity.SysTemplateDto;
import com.ares.core.persistence.service.ISysTemplateService;
import com.ares.core.utils.SnowflakeIdWorker;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import io.github.linpeilie.Converter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;
import java.util.Map;

@Service
public class SysTemplateServiceImpl implements ISysTemplateService {

    private ISysTemplateDao sysTemplateDao;
    private Converter converter;

    @Autowired
    public SysTemplateServiceImpl(ISysTemplateDao sysTemplateDao, Converter converter) {
        this.sysTemplateDao = sysTemplateDao;
        this.converter = converter;
    }

    @Override
    public PageInfo<SysTemplate> list(int pageNo, int pageSize, Map<String, Object> map) {
        PageHelper.startPage(pageNo, pageSize);
        List<SysTemplate> lists = converter.convert(sysTemplateDao.list(map), SysTemplate.class);
        PageInfo<SysTemplate> pageInfo = new PageInfo<>(lists);
        return pageInfo;
    }

    @Override
    public void insert(SysTemplate obj) {
        obj.setId(SnowflakeIdWorker.getUUID());
        obj.setCreateTime(new Date());
        SysTemplateDto sysTemplateDto = converter.convert(obj, SysTemplateDto.class);
        sysTemplateDao.insert(sysTemplateDto);
    }

    @Override
    public void update(SysTemplate obj) {
        obj.setModifyTime(new Date());
        SysTemplateDto sysTemplateDto = converter.convert(obj, SysTemplateDto.class);
        sysTemplateDao.update(sysTemplateDto);
    }

    @Override
    public void deleteByIds(List<Long> ids) {
        sysTemplateDao.deleteByIds(ids);
    }

    @Override
    public SysTemplate getById(Long id) {
        return converter.convert(sysTemplateDao.getById(id), SysTemplate.class);
    }

    @Override
    public PageInfo<SysTemplate> list(SysTemplateQuery obj) {
        List<SysTemplateDto> lists = sysTemplateDao.selectList(obj);
        PageInfo<SysTemplateDto> pageInfo = new PageInfo<>(lists);
        PageInfo<SysTemplate> page = pageInfo.convert(dto -> {
            SysTemplate v = converter.convert(dto, SysTemplate.class);
            return v;
        });
        return page;
    }
}
