package com.ares.core.persistence.dao;


import com.ares.core.persistence.model.system.SysNotice;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ISysNoticeDao extends IBaseDao<SysNotice> {

    int noticeNum(@Param("userId") String userId);

    List<SysNotice> getNotices();

}
