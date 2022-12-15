package com.ares.system.persistence.service.impl;

import com.ares.core.utils.SnowflakeIdWorker;
import com.ares.system.persistence.dao.IArticlesDao;
import com.ares.system.persistence.model.Articles;
import com.ares.system.persistence.service.IArticlesService;
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
public class ArticlesServiceImpl implements IArticlesService {

    private IArticlesDao articlesDao;

    @Autowired
    public ArticlesServiceImpl(IArticlesDao articlesDao) {
        this.articlesDao = articlesDao;
    }

    @Override
    public PageInfo<Articles> list(int pageNo, int pageSize, Map<String, Object> map) {
        PageHelper.startPage(pageNo, pageSize);
        List<Articles> lists = articlesDao.list(map);
        PageInfo<Articles> pageInfo = new PageInfo<>(lists);
        return pageInfo;
    }

    @Override
    public void insert(Articles obj) {
        obj.setId(SnowflakeIdWorker.getUUID());
        obj.setCreateTime(new Date());
        articlesDao.insert(obj);
    }

    @Override
    public void update(Articles obj) {
        obj.setModifyTime(new Date());
        articlesDao.update(obj);
    }

    @Override
    public void deleteByIds(List<String> ids) {
        articlesDao.deleteByIds(ids);
    }

    @Override
    public Articles getById(String id) {
        return articlesDao.getById(id);
    }

    @Override
    public List<Articles> list(Articles obj) {
        List<Articles> lists = articlesDao.selectList(obj);
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
