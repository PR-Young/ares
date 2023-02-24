package com.ares.core.persistence.service.impl;

import com.ares.core.persistence.dao.ISysNoticeDao;
import com.ares.core.persistence.dao.ISysNoticeReadDao;
import com.ares.core.persistence.model.SysNotice;
import com.ares.core.persistence.model.SysNoticeRead;
import com.ares.core.persistence.service.ISysNoticeService;
import com.ares.core.utils.SnowflakeIdWorker;
import com.baomidou.mybatisplus.core.conditions.Wrapper;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;
import java.util.function.Function;

@Service
public class SysNoticeServiceImpl implements ISysNoticeService {

    private ISysNoticeDao sysNoticeDao;
    private ISysNoticeReadDao noticeReadDao;

    @Autowired
    public SysNoticeServiceImpl(ISysNoticeDao sysNoticeDao, ISysNoticeReadDao noticeReadDao) {
        this.sysNoticeDao = sysNoticeDao;
        this.noticeReadDao = noticeReadDao;
    }

    @Override
    public PageInfo<SysNotice> list(int pageNo, int pageSize, Map<String, Object> map) {
        PageHelper.startPage(pageNo, pageSize);
        List<SysNotice> lists = sysNoticeDao.list(map);
        PageInfo<SysNotice> pageInfo = new PageInfo<>(lists);
        return pageInfo;
    }

    @Override
    public void insert(SysNotice obj) {
        obj.setId(SnowflakeIdWorker.getUUID());
        obj.setCreateTime(new Date());
        sysNoticeDao.insert(obj);
    }

    @Override
    public void update(SysNotice obj) {
        obj.setModifyTime(new Date());
        sysNoticeDao.update(obj);
    }

    @Override
    public void deleteByIds(List<String> ids) {
        sysNoticeDao.deleteByIds(ids);
    }

    @Override
    public SysNotice getById(String id) {
        return sysNoticeDao.getById(id);
    }

    @Override
    public List<SysNotice> list(SysNotice obj) {
        List<SysNotice> lists = sysNoticeDao.selectList(obj);
        return lists;
    }

    @Override
    public int noticeNum(String userId) {
        return sysNoticeDao.noticeNum(userId);
    }

    @Override
    public List<SysNotice> getNotices(String userId) {
        List<SysNotice> noticeList = sysNoticeDao.getNotices();
        List<SysNoticeRead> noticeReads = new ArrayList<>();
        if (null != noticeList && noticeList.size() > 0) {
            List<String> noticeReadList = noticeReadDao.getByUser(userId);
            for (SysNotice sysNotice : noticeList) {
                if (noticeReadList.contains(sysNotice.getId())) {
                    continue;
                }
                SysNoticeRead sysNoticeRead = new SysNoticeRead();
                sysNoticeRead.setId(SnowflakeIdWorker.getUUID());
                sysNoticeRead.setNoticeId(sysNotice.getId());
                sysNoticeRead.setUserId(userId);
                sysNoticeRead.setCreator(userId);
                sysNoticeRead.setCreateTime(new Date());
                noticeReads.add(sysNoticeRead);
            }
        }
        if (null != noticeReads && noticeReads.size() > 0) {
            noticeReadDao.batchInsert(noticeReads);
        }
        return noticeList;
    }

    @Override
    public boolean saveBatch(Collection entityList, int batchSize) {
        return false;
    }

    @Override
    public boolean saveOrUpdateBatch(Collection entityList, int batchSize) {
        return false;
    }

    @Override
    public boolean updateBatchById(Collection entityList, int batchSize) {
        return false;
    }

    @Override
    public boolean saveOrUpdate(Object entity) {
        return false;
    }

    @Override
    public Object getOne(Wrapper queryWrapper, boolean throwEx) {
        return null;
    }

    @Override
    public Map<String, Object> getMap(Wrapper queryWrapper) {
        return null;
    }

    @Override
    public BaseMapper getBaseMapper() {
        return null;
    }

    @Override
    public Class getEntityClass() {
        return null;
    }

    @Override
    public Object getObj(Wrapper queryWrapper, Function mapper) {
        return null;
    }
}
