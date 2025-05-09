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

package com.ares.quartz.persistence.service.impl;

import com.ares.core.utils.SnowflakeIdWorker;
import com.ares.quartz.model.query.SysQuartzJobLogQuery;
import com.ares.quartz.model.vo.SysQuartzJobLog;
import com.ares.quartz.persistence.dao.ISysQuartzJobLogDao;
import com.ares.quartz.persistence.entity.SysQuartzJobLogDto;
import com.ares.quartz.persistence.service.ISysQuartzJobLogService;
import com.github.pagehelper.PageHelper;
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

    private ISysQuartzJobLogDao sysQuartzJobLogDao;
    private Converter converter;

    @Autowired
    public SysQuartzJobLogServiceImpl(ISysQuartzJobLogDao sysQuartzJobLogDao, Converter converter) {
        this.sysQuartzJobLogDao = sysQuartzJobLogDao;
        this.converter = converter;
    }

    @Override
    public void insert(SysQuartzJobLog obj) {
        obj.setId(SnowflakeIdWorker.getUUID());
        SysQuartzJobLogDto sysQuartzJobLogDto = converter.convert(obj, SysQuartzJobLogDto.class);
        sysQuartzJobLogDao.insert(sysQuartzJobLogDto);
    }

    @Override
    public void update(SysQuartzJobLog obj) {

    }

    @Override
    public void deleteByIds(List<Long> ids) {
        sysQuartzJobLogDao.deleteByIds(ids);
    }

    @Override
    public SysQuartzJobLog getById(Long id) {
        return converter.convert(sysQuartzJobLogDao.getById(id), SysQuartzJobLog.class);
    }

    @Override
    public PageInfo<SysQuartzJobLog> list(int pageNo, int pageSize, Map<String, Object> map) {
        PageHelper.startPage(pageNo, pageSize);
        List<SysQuartzJobLog> sysQuartzJobLogList = converter.convert(sysQuartzJobLogDao.list(map), SysQuartzJobLog.class);
        PageInfo<SysQuartzJobLog> jobPageInfo = new PageInfo<>(sysQuartzJobLogList);
        return jobPageInfo;
    }

    @Override
    public PageInfo<SysQuartzJobLog> list(SysQuartzJobLogQuery obj) {
        List<SysQuartzJobLogDto> sysQuartzJobLogList = sysQuartzJobLogDao.selectList(obj);
        PageInfo<SysQuartzJobLogDto> pageInfo = new PageInfo<>(sysQuartzJobLogList);
        PageInfo<SysQuartzJobLog> page = pageInfo.convert(dto -> {
            SysQuartzJobLog v = converter.convert(dto, SysQuartzJobLog.class);
            return v;
        });
        return page;
    }

    @Override
    public List<SysQuartzJobLog> selectJobLogList(SysQuartzJobLogQuery jobLog) {
        return converter.convert(sysQuartzJobLogDao.selectList(jobLog), SysQuartzJobLog.class);
    }

    @Override
    public void cleanJobLog() {
        sysQuartzJobLogDao.cleanJobLog();
    }

}
