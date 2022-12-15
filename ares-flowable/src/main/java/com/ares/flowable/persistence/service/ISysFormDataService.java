package com.ares.flowable.persistence.service;


import com.ares.core.persistence.service.IBaseService;
import com.ares.flowable.persistence.model.SysFormData;

public interface ISysFormDataService extends IBaseService<SysFormData> {

    public SysFormData getFormDataByProInstId(String proInstId) ;

}
