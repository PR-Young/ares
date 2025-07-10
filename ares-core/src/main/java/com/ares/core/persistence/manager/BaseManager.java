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

package com.ares.core.persistence.manager;


import com.github.pagehelper.PageInfo;

import java.util.List;
import java.util.Map;

/**
 * @description:
 * @author: Young
 * @date: 2025/7/9
 * @see: com.ares.core.persistence.manager.impl.BaseManager.java
 * @param <T>
 * @param <Q>
 **/
public interface BaseManager<T, Q> {
    void insert(T obj);

    void update(T obj);

    void deleteByIds(List<Long> ids);

    T getById(Long id);

    PageInfo<T> list(int pageNo, int pageSize, Map<String, Object> map);

    PageInfo<T> list(Q obj);

    List<T> list(Map<String, Object> params);

    List<T> selectList(Q obj);
}
