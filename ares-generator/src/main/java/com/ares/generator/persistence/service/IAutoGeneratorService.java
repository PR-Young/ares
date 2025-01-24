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

package com.ares.generator.persistence.service;

import com.ares.generator.persistence.entity.Column;
import com.ares.generator.persistence.entity.EntityDataModel;

import java.sql.Connection;
import java.util.List;

/**
 * @description:
 * @author: Young
 * @date: 2020/11/11
 * @see: com.ares.generator.persistence.service AutoGeneratorService.java
 **/
public interface IAutoGeneratorService {

    byte[] generator(String flag, String tableName);

    EntityDataModel getEntityModel(String flag, Connection con, String tableName, String tablePrefix)
            throws Exception;

    Connection getConn(String flag);

    String handleSQL(List<Column> columns, String flag);

}
