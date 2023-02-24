package com.ares.core.persistence.service;

import com.ares.core.persistence.model.SysLog;

import java.util.List;

/**
 * @description:
 * @author: Young 2020/01/27
 **/
public interface ISysLogService{

    public void insert(SysLog sysLog);

    public List<SysLog> list(SysLog sysLog);

}
