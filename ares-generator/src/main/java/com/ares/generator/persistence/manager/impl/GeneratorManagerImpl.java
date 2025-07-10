/*
 *
 *  * ****************************************************************************
 *  * * Copyright (c) 2021 - 9999, ARES
 *  * *
 *  * * Licensed under the Apache License, Version 2.0 (the "License");
 *  * * you may not use this file except in compliance with the License.
 *  * * You may obtain a copy of the License at
 *  * *
 *  * *        http://www.apache.org/licenses/LICENSE-2.0
 *  * *
 *  * * Unless required by applicable law or agreed to in writing, software
 *  * * distributed under the License is distributed on an "AS IS" BASIS,
 *  * * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  * * See the License for the specific language governing permissions and
 *  * * limitations under the License.
 *  * ***************************************************************************
 *
 */

package com.ares.generator.persistence.manager.impl;


import com.ares.generator.persistence.dao.IGeneratorDao;
import com.ares.generator.persistence.manager.GeneratorManager;
import jakarta.annotation.Resource;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 * @description:
 * @author: Young
 * @date: 2025/7/10
 * @see: com.ares.generator.persistence.manager.impl.GeneratorManagerImpl.java
 **/
@Service
public class GeneratorManagerImpl implements GeneratorManager {
    @Resource
    private IGeneratorDao generatorDao;

    @Override
    public List<Map<String, Object>> getTables(Map<String, Object> map) {
        return generatorDao.getTables(map);
    }

    @Override
    public List<Map<String, Object>> getColumnsByTable(Map<String, Object> map) {
        return generatorDao.getColumnsByTable(map);
    }

    @Override
    public List<Map<String, Object>> selectTableColumnListByTableName(String tableName) {
        return generatorDao.selectTableColumnListByTableName(tableName);
    }

    @Override
    public List<Map<String, Object>> getSlaveTables() {
        return generatorDao.getSlaveTables();
    }

    @Override
    public List<Map<String, Object>> getSlaveColumnsByTable(Map<String, Object> map) {
        return generatorDao.getSlaveColumnsByTable(map);
    }
}
