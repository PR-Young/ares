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

package com.ares.flow.persistence.dao;


import com.ares.core.persistence.dao.IBaseDao;
import com.ares.flow.model.query.SysDeployFormQuery;
import com.ares.flow.persistence.entity.SysDeployFormDto;
import com.ares.flow.persistence.entity.SysFormDto;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ISysDeployFormDao extends IBaseDao<SysDeployFormDto, SysDeployFormQuery> {
    /**
     * 查询流程实例关联表单
     *
     * @param id 流程实例关联表单ID
     * @return 流程实例关联表单
     */
    SysDeployFormDto selectSysDeployFormById(Long id);

    /**
     * 查询流程实例关联表单列表
     *
     * @param sysDeployForm 流程实例关联表单
     * @return 流程实例关联表单集合
     */
    List<SysDeployFormDto> selectSysDeployFormList(SysDeployFormQuery sysDeployForm);


    /**
     * 查询流程挂着的表单
     *
     * @param deployId
     * @return
     */
    SysFormDto selectSysDeployFormByDeployId(String deployId);

    String isBindForm(String deployId);
}
