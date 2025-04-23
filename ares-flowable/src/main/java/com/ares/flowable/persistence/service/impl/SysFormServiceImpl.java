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
import com.ares.flowable.model.query.SysFormQuery;
import com.ares.flowable.model.vo.SysForm;
import com.ares.flowable.persistence.dao.ISysFormDao;
import com.ares.flowable.persistence.entity.SysFormDto;
import com.ares.flowable.persistence.service.ISysFormService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import io.github.linpeilie.Converter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;
import java.util.Map;

@Service
public class SysFormServiceImpl implements ISysFormService {

    private ISysFormDao sysFormDao;
    private Converter converter;

    @Autowired
    public SysFormServiceImpl(ISysFormDao sysFormDao, Converter converter) {
        this.sysFormDao = sysFormDao;
        this.converter = converter;
    }

    @Override
    public PageInfo<SysForm> list(int pageNo, int pageSize, Map<String, Object> map) {
        PageHelper.startPage(pageNo, pageSize);
        List<SysForm> lists = converter.convert(sysFormDao.list(map), SysForm.class);
        PageInfo<SysForm> pageInfo = new PageInfo<>(lists);
        return pageInfo;
    }

    @Override
    public void insert(SysForm obj) {
        obj.setId(SnowflakeIdWorker.getUUID());
        obj.setCreateTime(new Date());
        SysFormDto sysFormDto = converter.convert(obj, SysFormDto.class);
        sysFormDao.insert(sysFormDto);
    }

    @Override
    public void update(SysForm obj) {
        obj.setModifyTime(new Date());
        SysFormDto sysFormDto = converter.convert(obj, SysFormDto.class);
        sysFormDao.update(sysFormDto);
    }

    @Override
    public void deleteByIds(List<Long> ids) {
        sysFormDao.deleteByIds(ids);
    }

    @Override
    public SysForm getById(Long id) {
        return converter.convert(sysFormDao.getById(id), SysForm.class);
    }

    @Override
    public PageInfo<SysForm> list(SysFormQuery obj) {
        List<SysFormDto> lists = sysFormDao.selectList(obj);
        PageInfo<SysFormDto> pageInfo = new PageInfo<>(lists);
        PageInfo<SysForm> page = pageInfo.convert(dto -> {
            SysForm v = converter.convert(dto, SysForm.class);
            return v;
        });
        return page;
    }
}
