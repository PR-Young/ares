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

package com.ares.message.persistence.service;

import com.ares.message.persistence.model.AresDocument;
import org.springframework.data.domain.Pageable;

import java.util.List;

/**
 * @description:
 * @author: Young
 * @date: 2022/1/5
 * @see: com.ares.message.persistence.service.ElasticsearchService.java
 */
public interface IElasticsearchService {

    void save(AresDocument document);

    void saveAll(List<AresDocument> documents);

    void delete(AresDocument document);

    void deleteById(String id);

    List<AresDocument> query(String value);

    Iterable<AresDocument> queryByFiled(String fieldName, Object value, Pageable pageable);

    Iterable<AresDocument> queryAll(Pageable pageable);

}
