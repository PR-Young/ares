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

package com.ares.flow.persistence.manager;

import com.ares.core.persistence.manager.BaseManager;
import com.ares.flow.model.query.SysTaskFormQuery;
import com.ares.flow.persistence.entity.SysTaskFormDto;

import java.util.List;

/**
 * @author young
 */
public interface SysTaskFormManager extends BaseManager<SysTaskFormDto, SysTaskFormQuery> {

    /**
     * 查询流程任务关联单
     *
     * @param id 流程任务关联单ID
     * @return 流程任务关联单
     */
    SysTaskFormDto selectSysTaskFormById(Long id);

    /**
     * 查询流程任务关联单列表
     *
     * @param sysTaskForm 流程任务关联单
     * @return 流程任务关联单
     */

    List<SysTaskFormDto> selectSysTaskFormList(SysTaskFormQuery sysTaskForm);

}
