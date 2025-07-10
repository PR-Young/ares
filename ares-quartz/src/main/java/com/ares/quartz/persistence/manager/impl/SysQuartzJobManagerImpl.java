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
import com.ares.quartz.common.quartz.ScheduleConstants;
import com.ares.quartz.model.query.SysQuartzJobQuery;
import com.ares.quartz.persistence.dao.ISysQuartzJobDao;
import com.ares.quartz.persistence.entity.SysQuartzJobDto;
import com.ares.quartz.persistence.manager.SysQuartzJobManager;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * @description:
 * @author: Young 2020/01/29
 **/
@Slf4j
@Service
public class SysQuartzJobManagerImpl implements SysQuartzJobManager {

    private ISysQuartzJobDao sysQuartzJobDao;

    @Autowired
    public SysQuartzJobManagerImpl(ISysQuartzJobDao sysQuartzJobDao) {
        this.sysQuartzJobDao = sysQuartzJobDao;
    }
    

    @Override
    public PageInfo<SysQuartzJobDto> list(int pageNo, int pageSize, Map<String, Object> map) {
        PageHelper.startPage(pageNo, pageSize);
        List<SysQuartzJobDto> sysQuartzJobList = sysQuartzJobDao.list(map);
        PageInfo<SysQuartzJobDto> jobPageInfo = new PageInfo<>(sysQuartzJobList);
        return jobPageInfo;
    }

    @Override
    public PageInfo<SysQuartzJobDto> list(SysQuartzJobQuery obj) {
        List<SysQuartzJobDto> sysQuartzJobList = sysQuartzJobDao.selectList(obj);
        PageInfo<SysQuartzJobDto> pageInfo = new PageInfo<>(sysQuartzJobList);
        return pageInfo;
    }

    @Override
    public List<SysQuartzJobDto> list(Map<String, Object> params) {
        return sysQuartzJobDao.list(params);
    }

    @Override
    public List<SysQuartzJobDto> selectList(SysQuartzJobQuery obj) {
        return sysQuartzJobDao.selectList(obj);
    }


    @Override
    public void insert(SysQuartzJobDto obj) {
        obj.setId(SnowflakeIdWorker.getUUID());
        obj.setCreateTime(new Date());
        sysQuartzJobDao.insert(obj);
    }

    @Override
    public void update(SysQuartzJobDto obj) {
        obj.setModifyTime(new Date());
        sysQuartzJobDao.update(obj);
    }

    @Override
    public void deleteByIds(List<Long> ids) {
        sysQuartzJobDao.deleteByIds(ids);
    }

    @Override
    public SysQuartzJobDto getById(Long id) {
        return sysQuartzJobDao.getById(id);
    }

    @Override
    public int checkUnique(String jobName) {
        Integer num = sysQuartzJobDao.checkUnique(jobName);
        if (null != num && num > 0) {
            return num;
        }
        return 0;
    }

    @Override
    public int resumeJob(SysQuartzJobDto job) {
        job.setStatus(ScheduleConstants.Status.NORMAL.getValue());
        int rows = sysQuartzJobDao.update(job);
        return rows;
    }

    @Override
    public int pauseJob(SysQuartzJobDto job) {
        job.setStatus(ScheduleConstants.Status.PAUSE.getValue());
        int rows = sysQuartzJobDao.update(job);
        return rows;
    }



    @Override
    public List<SysQuartzJobDto> selectJobList(SysQuartzJobQuery job) {
        List<SysQuartzJobDto> sysQuartzJobList = sysQuartzJobDao.selectList(job);
        return sysQuartzJobList;
    }

}
