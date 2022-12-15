package com.ares.core.persistence.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.github.pagehelper.PageInfo;

import java.util.List;
import java.util.Map;

/**
 * @description:
 * @author: Young 2020/01/22
 **/
public abstract interface IBaseService<T> extends IService {

    public void insert(T obj);

    public void update(T obj);

    public void deleteByIds(List<String> ids);

    public T getById(String id);

    public PageInfo<T> list(int pageNo, int pageSize, Map<String, Object> map);

    public List<T> list(T obj) ;

}
