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

package com.ares.flow.persistence.manager.impl;


import com.ares.flow.persistence.dao.IFlowTaskDao;
import com.ares.flow.persistence.entity.FlowTaskDto;
import com.ares.flow.persistence.manager.FlowTaskManager;
import jakarta.annotation.Resource;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @description:
 * @author: Young
 * @date: 2025/7/10
 * @see: com.ares.flow.persistence.manager.impl.FlowTaskManagerImpl.java
 **/
@Service
public class FlowTaskManagerImpl implements FlowTaskManager {

    @Resource
    private IFlowTaskDao flowTaskDao;

    @Override
    public List<FlowTaskDto> getMyProcess(Long userId) {
        return flowTaskDao.getMyProcess(userId);
    }

    @Override
    public List<FlowTaskDto> getTodoList(List<String> list) {
        return flowTaskDao.getTodoList(list);
    }

    @Override
    public List<FlowTaskDto> finishedList(Long userId) {
        return flowTaskDao.finishedList(userId);
    }
}
