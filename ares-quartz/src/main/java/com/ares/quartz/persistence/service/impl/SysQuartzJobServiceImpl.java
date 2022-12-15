package com.ares.quartz.persistence.service.impl;

import com.ares.core.utils.SnowflakeIdWorker;
import com.ares.quartz.common.quartz.ScheduleConstants;
import com.ares.quartz.common.quartz.ScheduleManager;
import com.ares.quartz.persistence.dao.ISysQuartzJobDao;
import com.ares.quartz.persistence.model.SysQuartzJob;
import com.ares.quartz.persistence.service.ISysQuartzJobService;
import com.baomidou.mybatisplus.core.conditions.Wrapper;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.quartz.SchedulerException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.PostConstruct;
import java.util.*;
import java.util.function.Function;

/**
 * @description:
 * @author: Young 2020/01/29
 **/
@Service
public class SysQuartzJobServiceImpl implements ISysQuartzJobService {

    private ISysQuartzJobDao sysQuartzJobDao;
    private ScheduleManager scheduler;

    @Autowired
    public SysQuartzJobServiceImpl(ISysQuartzJobDao sysQuartzJobDao, ScheduleManager scheduler) {
        this.sysQuartzJobDao = sysQuartzJobDao;
        this.scheduler = scheduler;
    }

    @PostConstruct
    public void init() {
        List<SysQuartzJob> jobList = list();
        if (null != jobList && jobList.size() > 0) {
            for (SysQuartzJob job : jobList) {
                try {
                    if (ScheduleConstants.Status.NORMAL.getValue().equals(job.getStatus())) {
                        if (scheduler.checkJobExist(job)) {
                            scheduler.delete(scheduler.createTaskName(job.getJobName()), job.getJobGroup());
                        }
                        scheduler.addJob(job);
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }

    }

    @Override
    public PageInfo<SysQuartzJob> list(int pageNo, int pageSize, Map<String, Object> map) {
        PageHelper.startPage(pageNo, pageSize);
        List<SysQuartzJob> sysQuartzJobList = sysQuartzJobDao.list(map);
        PageInfo<SysQuartzJob> jobPageInfo = new PageInfo<>(sysQuartzJobList);
        return jobPageInfo;
    }

    @Override
    public List<SysQuartzJob> list(SysQuartzJob obj) {
        return null;
    }

    @Override
    public boolean saveBatch(Collection entityList, int batchSize) {
        return false;
    }

    @Override
    public boolean saveOrUpdateBatch(Collection entityList, int batchSize) {
        return false;
    }

    @Override
    public boolean updateBatchById(Collection entityList, int batchSize) {
        return false;
    }

    @Override
    public boolean saveOrUpdate(Object entity) {
        return false;
    }

    @Override
    public Object getOne(Wrapper queryWrapper, boolean throwEx) {
        return null;
    }

    @Override
    public Map<String, Object> getMap(Wrapper queryWrapper) {
        return null;
    }

    @Override
    public Object getObj(Wrapper queryWrapper, Function mapper) {
        return null;
    }

    @Override
    public List<SysQuartzJob> list() {
        List<SysQuartzJob> sysQuartzJobList = sysQuartzJobDao.list(new HashMap<>());
        return sysQuartzJobList;
    }

    @Override
    public BaseMapper getBaseMapper() {
        return null;
    }

    @Override
    public Class getEntityClass() {
        return null;
    }

    @Override
    public void insert(SysQuartzJob obj) {
        obj.setId(SnowflakeIdWorker.getUUID());
        obj.setCreateTime(new Date());
        sysQuartzJobDao.insert(obj);
        scheduler.addJob(obj);
    }

    @Override
    public void update(SysQuartzJob obj) {
        obj.setModifyTime(new Date());
        sysQuartzJobDao.update(obj);
        scheduler.edit(obj);
    }

    @Override
    public void deleteByIds(List<String> ids) {
        for (String id : ids) {
            SysQuartzJob job = getById(id);
            scheduler.delete(scheduler.createTaskName(job.getJobName()), job.getJobGroup());
        }
        sysQuartzJobDao.deleteByIds(ids);
    }

    @Override
    public SysQuartzJob getById(String id) {
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
    @Transactional
    public int resumeJob(SysQuartzJob job) {
        job.setStatus(ScheduleConstants.Status.NORMAL.getValue());
        int rows = sysQuartzJobDao.update(job);
        if (rows > 0) {
            scheduler.start(scheduler.createTaskName(job.getJobName()), job.getJobGroup());
        }
        return rows;
    }

    @Override
    @Transactional
    public int pauseJob(SysQuartzJob job) {
        job.setStatus(ScheduleConstants.Status.PAUSE.getValue());
        int rows = sysQuartzJobDao.update(job);
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
    public List<SysQuartzJob> selectJobList(SysQuartzJob job) {
        List<SysQuartzJob> sysQuartzJobList = sysQuartzJobDao.selectList(job);
        return sysQuartzJobList;
    }

}
