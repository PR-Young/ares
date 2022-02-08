package com.ares.core.persistence.dao;


import com.ares.core.persistence.model.system.SysProperties;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ISysPropertiesDao extends IBaseDao<SysProperties> {

    public List<SysProperties> getByGroup(@Param("group") String group);

    public String getValueByAlias(@Param("alias") String alias);
}
