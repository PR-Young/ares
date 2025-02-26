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
import com.ares.quartz.common.quartz.ScheduleConstants;
import com.ares.quartz.common.quartz.ScheduleManager;
import com.ares.quartz.model.query.SysQuartzJobQuery;
import com.ares.quartz.model.vo.SysQuartzJob;
import com.ares.quartz.persistence.dao.ISysQuartzJobDao;
import com.ares.quartz.persistence.entity.SysQuartzJobDto;
import com.ares.quartz.persistence.service.ISysQuartzJobService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import io.github.linpeilie.Converter;
import jakarta.annotation.PostConstruct;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.collections4.CollectionUtils;
import org.quartz.SchedulerException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;

/**
 * @description:
 * @author: Young 2020/01/29
 **/
@Slf4j
@Service
public class SysQuartzJobServiceImpl implements ISysQuartzJobService {

    private ISysQuartzJobDao sysQuartzJobDao;
    private ScheduleManager scheduler;
    private Converter converter;

    @Autowired
    public SysQuartzJobServiceImpl(ISysQuartzJobDao sysQuartzJobDao, ScheduleManager scheduler, Converter converter) {
        this.sysQuartzJobDao = sysQuartzJobDao;
        this.scheduler = scheduler;
        this.converter = converter;
    }

    @PostConstruct
    public void init() {
        List<SysQuartzJob> jobList = list();
        if (CollectionUtils.isNotEmpty(jobList)) {
            for (SysQuartzJob job : jobList) {
                try {
                    Optional.ofNullable(job.getStatus())
                            .filter(status -> ScheduleConstants.Status.NORMAL.getValue().equals(status))
                            .ifPresent(status -> {
                                try {
                                    if (scheduler.checkJobExist(job)) {
                                        scheduler.delete(scheduler.createTaskName(job.getJobName()), job.getJobGroup());
                                    }
                                    scheduler.addJob(job);
                                } catch (SchedulerException e) {
                                    log.error("Failed to init job {}: ", job, e);
                                }

                            });
                } catch (Exception e) {
                    log.error("init error: ", e);
                }
            }
        }

    }

    public List<SysQuartzJob> list() {
        List<SysQuartzJob> sysQuartzJobList = converter.convert(sysQuartzJobDao.list(new HashMap<>()), SysQuartzJob.class);
        return sysQuartzJobList;
    }

    @Override
    public PageInfo<SysQuartzJob> list(int pageNo, int pageSize, Map<String, Object> map) {
        PageHelper.startPage(pageNo, pageSize);
        List<SysQuartzJob> sysQuartzJobList = converter.convert(sysQuartzJobDao.list(map), SysQuartzJob.class);
        PageInfo<SysQuartzJob> jobPageInfo = new PageInfo<>(sysQuartzJobList);
        return jobPageInfo;
    }

    @Override
    public List<SysQuartzJob> list(SysQuartzJobQuery obj) {
        return null;
    }


    @Override
    public void insert(SysQuartzJob obj) {
        obj.setId(SnowflakeIdWorker.getUUID());
        obj.setCreateTime(new Date());
        SysQuartzJobDto sysQuartzJobDto = converter.convert(obj, SysQuartzJobDto.class);
        sysQuartzJobDao.insert(sysQuartzJobDto);
        scheduler.addJob(obj);
    }

    @Override
    public void update(SysQuartzJob obj) {
        obj.setModifyTime(new Date());
        SysQuartzJobDto sysQuartzJobDto = converter.convert(obj, SysQuartzJobDto.class);
        sysQuartzJobDao.update(sysQuartzJobDto);
        scheduler.edit(obj);
    }

    @Override
    public void deleteByIds(List<Long> ids) {
        for (Long id : ids) {
            SysQuartzJob job = getById(id);
            scheduler.delete(scheduler.createTaskName(job.getJobName()), job.getJobGroup());
        }
        sysQuartzJobDao.deleteByIds(ids);
    }

    @Override
    public SysQuartzJob getById(Long id) {
        return converter.convert(sysQuartzJobDao.getById(id), SysQuartzJob.class);
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
    @Transactional
    public int resumeJob(SysQuartzJob job) {
        job.setStatus(ScheduleConstants.Status.NORMAL.getValue());
        SysQuartzJobDto sysQuartzJobDto = converter.convert(job, SysQuartzJobDto.class);
        int rows = sysQuartzJobDao.update(sysQuartzJobDto);
        if (rows > 0) {
            scheduler.start(scheduler.createTaskName(job.getJobName()), job.getJobGroup());
        }
        return rows;
    }

    @Override
    @Transactional
    public int pauseJob(SysQuartzJob job) {
        job.setStatus(ScheduleConstants.Status.PAUSE.getValue());
        SysQuartzJobDto sysQuartzJobDto = converter.convert(job, SysQuartzJobDto.class);
        int rows = sysQuartzJobDao.update(sysQuartzJobDto);
        if (rows > 0) {
            scheduler.pause(scheduler.createTaskName(job.getJobName()), job.getJobGroup());
        }
        return rows;
    }

    @Override
    @Transactional
    public int changeStatus(SysQuartzJob job) {
        int rows = 0;
        Integer status = job.getStatus();
        if (ScheduleConstants.Status.NORMAL.getValue().equals(status)) {
            rows = resumeJob(job);
        } else if (ScheduleConstants.Status.PAUSE.getValue().equals(status)) {
            rows = pauseJob(job);
        }
        return rows;
    }


    @Override
    @Transactional
    public void run(SysQuartzJob job) throws SchedulerException {
        scheduler.run(job);
    }

    @Override
    public List<SysQuartzJob> selectJobList(SysQuartzJobQuery job) {
        List<SysQuartzJob> sysQuartzJobList = converter.convert(sysQuartzJobDao.selectList(job), SysQuartzJob.class);
        return sysQuartzJobList;
    }

}
