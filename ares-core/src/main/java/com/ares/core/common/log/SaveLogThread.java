package com.ares.core.common.log;


import com.ares.core.persistence.model.SysLog;
import com.ares.core.persistence.service.ISysLogService;

/**
 * @description:
 * @author: Young 2020/05/08
 **/
public class SaveLogThread implements Runnable {
    private SysLog sysLog;
    private ISysLogService sysLogService;

    public SaveLogThread(SysLog sysLog, ISysLogService sysLogService) {
        this.sysLog = sysLog;
        this.sysLogService = sysLogService;
    }

    @Override
    public void run() {
        sysLogService.insert(sysLog);
    }
}
