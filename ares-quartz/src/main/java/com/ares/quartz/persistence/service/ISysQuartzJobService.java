package com.ares.quartz.persistence.service;

import com.ares.core.persistence.service.IBaseService;
import com.ares.quartz.persistence.model.SysQuartzJob;
import org.quartz.SchedulerException;

import java.util.List;

/**
 * @description:
 * @author: Young 2020/01/29
 **/
public interface ISysQuartzJobService extends IBaseService<SysQuartzJob> {

    public int checkUnique(String jobName);

    public int resumeJob(SysQuartzJob job);

    public int pauseJob(SysQuartzJob job);

    public int changeStatus(SysQuartzJob job);

    public void run(SysQuartzJob job) throws SchedulerException ;

    public List<SysQuartzJob> selectJobList(SysQuartzJob job);

}
