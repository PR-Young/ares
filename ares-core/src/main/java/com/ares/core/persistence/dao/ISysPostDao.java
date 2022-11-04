package com.ares.core.persistence.dao;


import com.ares.core.persistence.model.system.SysPost;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ISysPostDao extends IBaseDao<SysPost> {
    SysPost getByName(String postName);
}
