package com.ares.flowable.persistence.service;

import com.ares.core.persistence.service.IBaseService;
import com.ares.flowable.persistence.model.SysDeployForm;
import com.ares.flowable.persistence.model.SysForm;


public interface ISysDeployFormService extends IBaseService<SysDeployForm> {

    public SysDeployForm selectSysDeployFormById(String id);

    public SysForm selectSysDeployFormByDeployId(String id) ;
}
