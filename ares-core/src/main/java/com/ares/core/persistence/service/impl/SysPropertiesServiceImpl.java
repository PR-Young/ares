package com.ares.core.persistence.service.impl;

import com.ares.core.persistence.dao.ISysPropertiesDao;
import com.ares.core.persistence.model.system.SysProperties;
import com.ares.core.persistence.service.ISysPropertiesService;
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
import java.util.stream.Collectors;

@Service
public class SysPropertiesServiceImpl implements ISysPropertiesService {

    private ISysPropertiesDao sysPropertiesDao;

    @Autowired
    public SysPropertiesServiceImpl(ISysPropertiesDao sysPropertiesDao) {
        this.sysPropertiesDao = sysPropertiesDao;
    }

    @Override
    public PageInfo<SysProperties> list(int pageNo, int pageSize, Map<String, Object> map) {
        PageHelper.startPage(pageNo, pageSize);
        List<SysProperties> lists = sysPropertiesDao.list(map);
        PageInfo<SysProperties> pageInfo = new PageInfo<>(lists);
        return pageInfo;
    }

    @Override
    public void insert(SysProperties obj) {
        obj.setId(SnowflakeIdWorker.getUUID());
        obj.setCreateTime(new Date());
        sysPropertiesDao.insert(obj);
    }

    @Override
    public void update(SysProperties obj) {
        obj.setModifyTime(new Date());
        sysPropertiesDao.update(obj);
    }

    @Override
    public void deleteByIds(List<String> ids) {
        sysPropertiesDao.deleteByIds(ids);
    }

    @Override
    public SysProperties getById(String id) {
        return sysPropertiesDao.getById(id);
    }

    @Override
    public List<SysProperties> list(SysProperties obj) {
        List<SysProperties> lists = sysPropertiesDao.selectList(obj);
        return lists;
    }

    @Override
    public Map<String, Object> getByGroup(String group) {
        List<SysProperties> properties = sysPropertiesDao.getByGroup(group);
        Map<String, Object> map = properties.stream().collect(Collectors.toMap(SysProperties::getAlias, SysProperties::getValue));
        return map;
    }

    @Override
    public String getValueByAlias(String alias) {
        return sysPropertiesDao.getValueByAlias(alias);
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
