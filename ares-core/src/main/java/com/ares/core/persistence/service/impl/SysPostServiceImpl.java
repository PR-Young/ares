package com.ares.core.persistence.service.impl;

import com.ares.core.persistence.dao.ISysPostDao;
import com.ares.core.persistence.model.system.SysPost;
import com.ares.core.persistence.service.ISysPostService;
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
public class SysPostServiceImpl implements ISysPostService {

    private ISysPostDao sysPostDao;

    @Autowired
    public SysPostServiceImpl(ISysPostDao sysPostDao) {
        this.sysPostDao = sysPostDao;
    }

    @Override
    public PageInfo<SysPost> list(int pageNo, int pageSize, Map<String, Object> map) {
        PageHelper.startPage(pageNo, pageSize);
        List<SysPost> lists = sysPostDao.list(map);
        PageInfo<SysPost> pageInfo = new PageInfo<>(lists);
        return pageInfo;
    }

    @Override
    public void insert(SysPost obj) {
        obj.setId(SnowflakeIdWorker.getUUID());
        obj.setCreateTime(new Date());
        sysPostDao.insert(obj);
    }

    @Override
    public void update(SysPost obj) {
        obj.setModifyTime(new Date());
        sysPostDao.update(obj);
    }

    @Override
    public void deleteByIds(List<String> ids) {
        sysPostDao.deleteByIds(ids);
    }

    @Override
    public SysPost getById(String id) {
        return sysPostDao.getById(id);
    }

    @Override
    public List<SysPost> list(SysPost obj) {
        List<SysPost> lists = sysPostDao.selectList(obj);
        return lists;
    }

    @Override
    public List<SysPost> getAll() {
        return sysPostDao.list(new HashMap<>());
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
