package com.ares.flowable.persistence.service.impl;


import com.ares.core.utils.SnowflakeIdWorker;
import com.ares.flowable.persistence.dao.ISysFormDataDao;
import com.ares.flowable.persistence.model.SysFormData;
import com.ares.flowable.persistence.service.ISysFormDataService;
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
public class SysFormDataServiceImpl implements ISysFormDataService {

    private ISysFormDataDao sysFormDataDao;

    @Autowired
    public SysFormDataServiceImpl(ISysFormDataDao sysFormDataDao) {
        this.sysFormDataDao = sysFormDataDao;
    }

    @Override
    public PageInfo<SysFormData> list(int pageNo, int pageSize, Map<String, Object> map) {
        PageHelper.startPage(pageNo, pageSize);
        List<SysFormData> lists = sysFormDataDao.list(map);
        PageInfo<SysFormData> pageInfo = new PageInfo<>(lists);
        return pageInfo;
    }

    @Override
    public void insert(SysFormData obj) {
        obj.setId(SnowflakeIdWorker.getUUID());
        obj.setCreateTime(new Date());
        sysFormDataDao.insert(obj);
    }

    @Override
    public void update(SysFormData obj) {
        obj.setModifyTime(new Date());
        sysFormDataDao.update(obj);
    }

    @Override
    public void deleteByIds(List<String> ids) {
        sysFormDataDao.deleteByIds(ids);
    }

    @Override
    public SysFormData getById(String id) {
        return sysFormDataDao.getById(id);
    }

    @Override
    public List<SysFormData> list(SysFormData obj) {
        List<SysFormData> lists = sysFormDataDao.selectList(obj);
        return lists;
    }

    @Override
    public SysFormData getFormDataByProInstId(String proInstId) {
        return sysFormDataDao.getFormDataByProInstId(proInstId);
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
