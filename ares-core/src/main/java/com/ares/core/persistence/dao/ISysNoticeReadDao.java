package com.ares.core.persistence.dao;

import com.ares.core.persistence.model.system.SysNoticeRead;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ISysNoticeReadDao extends IBaseDao<SysNoticeRead> {

    int batchInsert(List<SysNoticeRead> noticeReadList);

    List<String> getByUser(String userId);
}
