package com.ares.quartz.persistence.service;

import com.ares.core.persistence.service.IBaseService;
import com.ares.quartz.persistence.model.SysQuartzJobLog;

import java.util.List;

/**
 * @description:
 * @author: Young 2020/01/29
 **/
public interface ISysQuartzJobLogService extends IBaseService<SysQuartzJobLog> {

    public List<SysQuartzJobLog> selectJobLogList(SysQuartzJobLog jobLog) ;

    public void cleanJobLog();
}
