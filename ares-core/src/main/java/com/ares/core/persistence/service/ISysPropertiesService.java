package com.ares.core.persistence.service;

import com.ares.core.persistence.model.system.SysProperties;

import java.util.Map;

public interface ISysPropertiesService extends IBaseService<SysProperties> {

    public Map<String, Object> getByGroup(String group);
    public String getValueByAlias(String alias);

}
