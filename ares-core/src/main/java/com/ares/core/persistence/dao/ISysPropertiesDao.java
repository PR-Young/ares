package com.ares.core.persistence.dao;


import com.ares.core.persistence.model.SysProperties;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface ISysPropertiesDao extends IBaseDao<SysProperties> {

    public List<SysProperties> getByGroup(@Param("group") String group);

    public String getValueByAlias(@Param("alias") String alias);
}
