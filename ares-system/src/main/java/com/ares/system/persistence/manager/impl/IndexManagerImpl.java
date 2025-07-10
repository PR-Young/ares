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

package com.ares.system.persistence.manager.impl;


import com.ares.system.persistence.dao.IIndexDao;
import com.ares.system.persistence.manager.IndexManager;
import jakarta.annotation.Resource;
import org.springframework.stereotype.Service;

/**
 * @description:
 * @author: Young
 * @date: 2025/7/10
 * @see: com.ares.system.persistence.manager.impl.IndexManagerImpl.java
 **/
@Service
public class IndexManagerImpl implements IndexManager {
    @Resource
    private IIndexDao indexDao;

    @Override
    public int getJobNumber() {
        return indexDao.getJobNumber();
    }

    @Override
    public int getLogNumber() {
        return indexDao.getLogNumber();
    }
}
