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

package com.ares.quartz.persistence.manager.impl;

import com.ares.core.utils.SnowflakeIdWorker;
import com.ares.quartz.model.query.SysQuartzJobLogQuery;
import com.ares.quartz.persistence.dao.ISysQuartzJobLogDao;
import com.ares.quartz.persistence.entity.SysQuartzJobLogDto;
import com.ares.quartz.persistence.manager.SysQuartzJobLogManager;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 * @description:
 * @author: Young 2020/01/29
 **/
@Service
public class SysQuartzJobLogManagerImpl implements SysQuartzJobLogManager {

    private ISysQuartzJobLogDao sysQuartzJobLogDao;

    @Autowired
    public SysQuartzJobLogManagerImpl(ISysQuartzJobLogDao sysQuartzJobLogDao) {
        this.sysQuartzJobLogDao = sysQuartzJobLogDao;
    }

    @Override
    public void insert(SysQuartzJobLogDto obj) {
        obj.setId(SnowflakeIdWorker.getUUID());
        sysQuartzJobLogDao.insert(obj);
    }

    @Override
    public void update(SysQuartzJobLogDto obj) {

    }

    @Override
    public void deleteByIds(List<Long> ids) {
        sysQuartzJobLogDao.deleteByIds(ids);
    }

    @Override
    public SysQuartzJobLogDto getById(Long id) {
        return sysQuartzJobLogDao.getById(id);
    }

    @Override
    public PageInfo<SysQuartzJobLogDto> list(int pageNo, int pageSize, Map<String, Object> map) {
        PageHelper.startPage(pageNo, pageSize);
        List<SysQuartzJobLogDto> sysQuartzJobLogList = sysQuartzJobLogDao.list(map);
        PageInfo<SysQuartzJobLogDto> jobPageInfo = new PageInfo<>(sysQuartzJobLogList);
        return jobPageInfo;
    }

    @Override
    public PageInfo<SysQuartzJobLogDto> list(SysQuartzJobLogQuery obj) {
        List<SysQuartzJobLogDto> sysQuartzJobLogList = sysQuartzJobLogDao.selectList(obj);
        PageInfo<SysQuartzJobLogDto> pageInfo = new PageInfo<>(sysQuartzJobLogList);
        return pageInfo;
    }

    @Override
    public List<SysQuartzJobLogDto> list(Map<String, Object> params) {
        return sysQuartzJobLogDao.list(params);
    }

    @Override
    public List<SysQuartzJobLogDto> selectList(SysQuartzJobLogQuery obj) {
        return sysQuartzJobLogDao.selectList(obj);
    }

    @Override
    public List<SysQuartzJobLogDto> selectJobLogList(SysQuartzJobLogQuery jobLog) {
        return sysQuartzJobLogDao.selectList(jobLog);
    }

    @Override
    public void cleanJobLog() {
        sysQuartzJobLogDao.cleanJobLog();
    }

}
