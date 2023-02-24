package com.ares.core.persistence.dao;


import com.ares.core.persistence.model.SysTemplate;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface ISysTemplateDao extends IBaseDao<SysTemplate> {
    SysTemplate getByName(@Param("name") String name);
}
