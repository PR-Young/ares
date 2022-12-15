package com.ares.flowable.persistence.service.impl;

import com.ares.core.utils.SnowflakeIdWorker;
import com.ares.flowable.persistence.dao.ISysFormDao;
import com.ares.flowable.persistence.model.SysForm;
import com.ares.flowable.persistence.service.ISysFormService;
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
public class SysFormServiceImpl implements ISysFormService {

    private ISysFormDao sysFormDao;

    @Autowired
    public SysFormServiceImpl(ISysFormDao sysFormDao) {
        this.sysFormDao = sysFormDao;
    }

    @Override
    public PageInfo<SysForm> list(int pageNo, int pageSize, Map<String, Object> map) {
        PageHelper.startPage(pageNo, pageSize);
        List<SysForm> lists = sysFormDao.list(map);
        PageInfo<SysForm> pageInfo = new PageInfo<>(lists);
        return pageInfo;
    }

    @Override
    public void insert(SysForm obj) {
        obj.setId(SnowflakeIdWorker.getUUID());
        obj.setCreateTime(new Date());
        sysFormDao.insert(obj);
    }

    @Override
    public void update(SysForm obj) {
        obj.setModifyTime(new Date());
        sysFormDao.update(obj);
    }

    @Override
    public void deleteByIds(List<String> ids) {
        sysFormDao.deleteByIds(ids);
    }

    @Override
    public SysForm getById(String id) {
        return sysFormDao.getById(id);
    }

    @Override
    public List<SysForm> list(SysForm obj) {
        List<SysForm> lists = sysFormDao.selectList(obj);
        return lists;
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
