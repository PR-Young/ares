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

package com.ares.generator.persistence.dao;

import com.ares.core.persistence.dao.IBaseDao;
import com.ares.generator.persistence.entity.GenPropertiesDto;
import com.ares.generator.model.query.GenPropertiesQuery;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface IGenPropertiesDao extends IBaseDao<GenPropertiesDto, GenPropertiesQuery> {
    GenPropertiesDto getByUser(Long userId);
}
