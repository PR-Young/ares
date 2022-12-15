package com.ares.generator.persistence.service;


import com.github.pagehelper.PageInfo;

import java.util.List;
import java.util.Map;

/**
 * @description:
 * @author: Young 2020/04/28
 **/
public interface IGeneratorService {


    public List<Map<String, Object>> tables(Map<String, Object> map) ;

    public PageInfo<Map<String, Object>> columns(int pageNo, int pageSize, Map<String, Object> map);

    public List<Map<String, Object>> selectTableColumnListByTableName(String tableName);

}
