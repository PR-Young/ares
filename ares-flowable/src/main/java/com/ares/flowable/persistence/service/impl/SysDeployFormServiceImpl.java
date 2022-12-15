package com.ares.flowable.persistence.service.impl;

import com.ares.core.utils.SnowflakeIdWorker;
import com.ares.flowable.persistence.dao.ISysDeployFormDao;
import com.ares.flowable.persistence.model.SysDeployForm;
import com.ares.flowable.persistence.model.SysForm;
import com.ares.flowable.persistence.service.ISysDeployFormService;
import com.baomidou.mybatisplus.core.conditions.Wrapper;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Collection;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.function.Function;

@Service
public class SysDeployFormServiceImpl implements ISysDeployFormService {

    private ISysDeployFormDao sysDeployFormDao;

    @Autowired
    public SysDeployFormServiceImpl(ISysDeployFormDao sysDeployFormDao) {
        this.sysDeployFormDao = sysDeployFormDao;
    }

    @Override
    public PageInfo<SysDeployForm> list(int pageNo, int pageSize, Map<String, Object> map) {
        PageHelper.startPage(pageNo, pageSize);
        List<SysDeployForm> lists = sysDeployFormDao.list(map);
        PageInfo<SysDeployForm> pageInfo = new PageInfo<>(lists);
        return pageInfo;
    }

    @Override
    public void insert(SysDeployForm obj) {
        obj.setId(SnowflakeIdWorker.getUUID());
        obj.setCreateTime(new Date());
        sysDeployFormDao.insert(obj);
    }

    @Override
    public void update(SysDeployForm obj) {
        obj.setModifyTime(new Date());
        sysDeployFormDao.update(obj);
    }

    @Override
    public void deleteByIds(List<String> ids) {
        sysDeployFormDao.deleteByIds(ids);
    }

    @Override
    public SysDeployForm getById(String id) {
        return sysDeployFormDao.getById(id);
    }

    @Override
    public List<SysDeployForm> list(SysDeployForm obj) {
        List<SysDeployForm> lists = sysDeployFormDao.selectList(obj);
        return lists;
    }

    @Override
    public SysDeployForm selectSysDeployFormById(String id) {
        return sysDeployFormDao.selectSysDeployFormById(id);
    }

    @Override
    public SysForm selectSysDeployFormByDeployId(String id) {
        return sysDeployFormDao.selectSysDeployFormByDeployId(id);
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
