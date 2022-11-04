package com.ares.core.persistence.dao;

import com.ares.core.persistence.model.system.SysNoticeRead;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface ISysNoticeReadDao extends IBaseDao<SysNoticeRead> {

    int batchInsert(List<SysNoticeRead> noticeReadList);

    List<String> getByUser(String userId);
}
