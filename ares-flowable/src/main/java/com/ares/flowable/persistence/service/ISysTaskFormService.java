package com.ares.flowable.persistence.service;

import com.ares.core.persistence.service.IBaseService;
import com.ares.flowable.persistence.model.SysTaskForm;

import java.util.List;

/**
 * @author young
 */
public interface ISysTaskFormService extends IBaseService<SysTaskForm> {

    /**
     * 查询流程任务关联单
     *
     * @param id 流程任务关联单ID
     * @return 流程任务关联单
     */
    public SysTaskForm selectSysTaskFormById(String id);

    /**
     * 查询流程任务关联单列表
     *
     * @param sysTaskForm 流程任务关联单
     * @return 流程任务关联单
     */

    public List<SysTaskForm> selectSysTaskFormList(SysTaskForm sysTaskForm) ;

}
