package com.ares.core.persistence.service.impl;

import com.ares.core.persistence.dao.ISysDictTypeDao;
import com.ares.core.persistence.model.SysDictType;
import com.ares.core.persistence.service.ISysDictTypeService;
import com.ares.core.utils.SnowflakeIdWorker;
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
public class SysDictTypeServiceImpl implements ISysDictTypeService {

    private ISysDictTypeDao sysDictTypeDao;

    @Autowired
    public SysDictTypeServiceImpl(ISysDictTypeDao sysDictTypeDao) {
        this.sysDictTypeDao = sysDictTypeDao;
    }

    public PageInfo<SysDictType> list(int pageNo, int pageSize, Map<String, Object> map) {
        PageHelper.startPage(pageNo, pageSize);
        List<SysDictType> lists = sysDictTypeDao.list(map);
        PageInfo<SysDictType> pageInfo = new PageInfo<>(lists);
        return pageInfo;
    }

    @Override
    public void insert(SysDictType obj) {
        obj.setId(SnowflakeIdWorker.getUUID());
        obj.setCreateTime(new Date());
        sysDictTypeDao.insert(obj);
    }

    @Override
    public void update(SysDictType obj) {
        obj.setModifyTime(new Date());
        sysDictTypeDao.update(obj);
    }

    @Override
    public void deleteByIds(List<String> ids) {
        sysDictTypeDao.deleteByIds(ids);
    }

    @Override
    public SysDictType getById(String id) {
        return sysDictTypeDao.getById(id);
    }

    @Override
    public List<SysDictType> list(SysDictType obj) {
        List<SysDictType> lists = sysDictTypeDao.selectList(obj);
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
