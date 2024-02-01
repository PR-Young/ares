/*
 * !******************************************************************************
 *  * Copyright (c) 2021 - 9999, ARES
 *  *
 *  * Licensed under the Apache License, Version 2.0 (the "License");
 *  * you may not use this file except in compliance with the License.
 *  * You may obtain a copy of the License at
 *  *
 *  *        http://www.apache.org/licenses/LICENSE-2.0
 *  *
 *  * Unless required by applicable law or agreed to in writing, software
 *  * distributed under the License is distributed on an "AS IS" BASIS,
 *  * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  * See the License for the specific language governing permissions and
 *  * limitations under the License.
 *  *****************************************************************************
 */

package com.ares.generator.persistence.service.impl;


import com.ares.generator.persistence.dao.IGeneratorDao;
import com.ares.generator.persistence.service.IGeneratorService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
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
    public List<Map<String, Object>> tables(String flag, Map<String, Object> map) {
        List<Map<String, Object>> tables = new ArrayList<>();
        if ("master".equalsIgnoreCase(flag)) {
            tables = generatorDao.getTables(map);
        } else {
            tables = generatorDao.getSlaveTables();
        }

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
    public List<Map<String, Object>> selectTableColumnListByTableName(String flag, String tableName) {
        if ("master".equalsIgnoreCase(flag)) {
            return generatorDao.selectTableColumnListByTableName(tableName);
        } else {
            return generatorDao.selectTableColumnListByTableName(tableName);
        }
    }

}
