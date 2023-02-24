package com.ares.core.persistence.dao;


import com.ares.core.persistence.model.SysLog;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

/**
 * @description:
 * @author: Young 2020/01/27
 **/
@Mapper
public interface ISysLogDao {
    int insert(SysLog sysLog);

    List<SysLog> list(SysLog sysLog);
}
