package com.ares.core.common.log;


import com.ares.core.persistence.model.system.SysLog;
import com.ares.core.persistence.service.SysLogService;

/**
 * @description:
 * @author: Young 2020/05/08
 **/
public class SaveLogThread implements Runnable {
    private SysLog sysLog;
    private SysLogService sysLogService;

    public SaveLogThread(SysLog sysLog, SysLogService sysLogService) {
        this.sysLog = sysLog;
        this.sysLogService = sysLogService;
    }

    @Override
    public void run() {
        sysLogService.insert(sysLog);
    }
}
