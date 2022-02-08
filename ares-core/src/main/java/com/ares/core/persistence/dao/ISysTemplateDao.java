package com.ares.core.persistence.dao;


import com.ares.core.persistence.model.system.SysTemplate;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface ISysTemplateDao extends IBaseDao<SysTemplate> {
    SysTemplate getByName(@Param("name") String name);
}
