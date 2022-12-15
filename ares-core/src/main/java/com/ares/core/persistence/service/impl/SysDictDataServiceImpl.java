package com.ares.core.persistence.service.impl;

import com.ares.core.persistence.dao.ISysDictDataDao;
import com.ares.core.persistence.model.system.SysDictData;
import com.ares.core.persistence.service.ISysDictDataService;
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
public class SysDictDataServiceImpl implements ISysDictDataService {

    private ISysDictDataDao sysDictDataDao;

    @Autowired
    public SysDictDataServiceImpl(ISysDictDataDao sysDictDataDao) {
        this.sysDictDataDao = sysDictDataDao;
    }

    @Override
    public PageInfo<SysDictData> list(int pageNo, int pageSize, Map<String, Object> map) {
        PageHelper.startPage(pageNo, pageSize);
        List<SysDictData> lists = sysDictDataDao.list(map);
        PageInfo<SysDictData> pageInfo = new PageInfo<>(lists);
        return pageInfo;
    }

    @Override
    public void insert(SysDictData obj) {
        obj.setId(SnowflakeIdWorker.getUUID());
        obj.setCreateTime(new Date());
        sysDictDataDao.insert(obj);
    }

    @Override
    public void update(SysDictData obj) {
        obj.setModifyTime(new Date());
        sysDictDataDao.update(obj);
    }

    @Override
    public void deleteByIds(List<String> ids) {
        sysDictDataDao.deleteByIds(ids);
    }

    @Override
    public SysDictData getById(String id) {
        return sysDictDataDao.getById(id);
    }

    @Override
    public List<SysDictData> list(SysDictData obj) {
        List<SysDictData> lists = sysDictDataDao.selectList(obj);
        return lists;
    }

    @Override
    public List<SysDictData> getDicts(String dictType) {
        return sysDictDataDao.getDicts(dictType);
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
