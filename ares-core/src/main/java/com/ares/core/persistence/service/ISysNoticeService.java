package com.ares.core.persistence.service;

import com.ares.core.persistence.model.SysNotice;

import java.util.List;

public interface ISysNoticeService extends IBaseService<SysNotice> {

    public int noticeNum(String userId);

    public List<SysNotice> getNotices(String userId);

}
