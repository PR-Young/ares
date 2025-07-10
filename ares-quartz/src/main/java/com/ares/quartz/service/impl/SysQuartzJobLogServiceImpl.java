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

package com.ares.quartz.service.impl;

import com.ares.quartz.model.query.SysQuartzJobLogQuery;
import com.ares.quartz.model.vo.SysQuartzJobLog;
import com.ares.quartz.persistence.entity.SysQuartzJobLogDto;
import com.ares.quartz.persistence.manager.SysQuartzJobLogManager;
import com.ares.quartz.service.ISysQuartzJobLogService;
import com.github.pagehelper.PageInfo;
import io.github.linpeilie.Converter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 * @description:
 * @author: Young 2020/01/29
 **/
@Service
public class SysQuartzJobLogServiceImpl implements ISysQuartzJobLogService {

    private SysQuartzJobLogManager quartzJobLogManager;
    private Converter converter;

    @Autowired
    public SysQuartzJobLogServiceImpl(SysQuartzJobLogManager quartzJobLogManager, Converter converter) {
        this.quartzJobLogManager = quartzJobLogManager;
        this.converter = converter;
    }

    @Override
    public void insert(SysQuartzJobLog obj) {
        SysQuartzJobLogDto sysQuartzJobLogDto = converter.convert(obj, SysQuartzJobLogDto.class);
        quartzJobLogManager.insert(sysQuartzJobLogDto);
    }

    @Override
    public void update(SysQuartzJobLog obj) {

    }

    @Override
    public void deleteByIds(List<Long> ids) {
        quartzJobLogManager.deleteByIds(ids);
    }

    @Override
    public SysQuartzJobLog getById(Long id) {
        return converter.convert(quartzJobLogManager.getById(id), SysQuartzJobLog.class);
    }

    @Override
    public PageInfo<SysQuartzJobLog> list(int pageNo, int pageSize, Map<String, Object> map) {
        PageInfo<SysQuartzJobLogDto> list = quartzJobLogManager.list(pageNo, pageSize, map);
        PageInfo<SysQuartzJobLog> jobPageInfo = list.convert(dto -> {
            SysQuartzJobLog v = converter.convert(dto, SysQuartzJobLog.class);
            return v;
        });
        return jobPageInfo;
    }

    @Override
    public PageInfo<SysQuartzJobLog> list(SysQuartzJobLogQuery obj) {
        List<SysQuartzJobLogDto> sysQuartzJobLogList = quartzJobLogManager.selectList(obj);
        PageInfo<SysQuartzJobLogDto> pageInfo = new PageInfo<>(sysQuartzJobLogList);
        PageInfo<SysQuartzJobLog> page = pageInfo.convert(dto -> {
            SysQuartzJobLog v = converter.convert(dto, SysQuartzJobLog.class);
            return v;
        });
        return page;
    }

    @Override
    public List<SysQuartzJobLog> selectJobLogList(SysQuartzJobLogQuery jobLog) {
        return converter.convert(quartzJobLogManager.selectList(jobLog), SysQuartzJobLog.class);
    }

    @Override
    public void cleanJobLog() {
        quartzJobLogManager.cleanJobLog();
    }

}
