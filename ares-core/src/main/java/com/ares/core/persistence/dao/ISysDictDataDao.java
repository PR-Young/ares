package com.ares.core.persistence.dao;


import com.ares.core.persistence.model.system.SysDictData;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface ISysDictDataDao extends IBaseDao<SysDictData> {
    List<SysDictData> getDicts(@Param("dictType") String dictType);
}
