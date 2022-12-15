package com.ares.generator.persistence.service.impl;


import com.ares.generator.persistence.dao.IGeneratorDao;
import com.ares.generator.persistence.service.IGeneratorService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 * @description:
 * @author: Young 2020/04/28
 **/
@Service
public class GeneratorServiceImpl implements IGeneratorService {

    private IGeneratorDao generatorDao;

    @Autowired
    public GeneratorServiceImpl(IGeneratorDao generatorDao) {
        this.generatorDao = generatorDao;
    }

    @Override
    public List<Map<String, Object>> tables(Map<String, Object> map) {
        List<Map<String, Object>> tables = generatorDao.getTables(map);
        return tables;
    }

    @Override
    public PageInfo<Map<String, Object>> columns(int pageNo, int pageSize, Map<String, Object> map) {
        PageHelper.startPage(pageNo, pageSize);
        List<Map<String, Object>> columnList = generatorDao.getColumnsByTable(map);
        PageInfo<Map<String, Object>> columnPageInfo = new PageInfo<>(columnList);
        return columnPageInfo;
    }

    @Override
    public List<Map<String, Object>> selectTableColumnListByTableName(String tableName) {
        return generatorDao.selectTableColumnListByTableName(tableName);
    }

}
