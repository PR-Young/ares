package com.ares.core.persistence.service.impl;

import com.ares.core.persistence.dao.ISysLogDao;
import com.ares.core.persistence.model.SysLog;
import com.ares.core.persistence.service.ISysLogService;
import com.ares.core.utils.SnowflakeIdWorker;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

/**
 * @description:
 * @author: Young 2020/01/27
 **/
@Service
public class SysLogServiceImpl implements ISysLogService {

    private ISysLogDao sysLogDao;

    @Autowired
    public SysLogServiceImpl(ISysLogDao sysLogDao) {
        this.sysLogDao = sysLogDao;
    }

    @Override
    public void insert(SysLog sysLog) {
        sysLog.setId(SnowflakeIdWorker.getUUID());
        sysLog.setCreateTime(new Date());
        sysLogDao.insert(sysLog);
    }

    @Override
    public List<SysLog> list(SysLog sysLog) {
        List<SysLog> logList = sysLogDao.list(sysLog);
        return logList;
    }
}
