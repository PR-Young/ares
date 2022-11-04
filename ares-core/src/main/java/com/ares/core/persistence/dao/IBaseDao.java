package com.ares.core.persistence.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * @description:
 * @author: Young 2020/01/22
 **/
public interface IBaseDao<T> extends BaseMapper<T> {
    int update(T obj);

    int deleteByIds(List<String> ids);

    List<T> list(Map<String, Object> params);

    T getById(@Param("id") String id);

    List<T> selectList(T obj);

}
