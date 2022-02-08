package com.ares.core.persistence.dao;


import com.ares.core.persistence.model.system.SysPost;
import org.springframework.stereotype.Repository;

@Repository
public interface ISysPostDao extends IBaseDao<SysPost> {
    SysPost getByName(String postName);
}
