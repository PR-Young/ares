package com.ares.core.persistence.dao;


import com.ares.core.persistence.model.SysNotice;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface ISysNoticeDao extends IBaseDao<SysNotice> {

    int noticeNum(@Param("userId") String userId);

    List<SysNotice> getNotices();

}
