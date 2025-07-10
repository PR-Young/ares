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

package com.ares.flowable.service;


import com.ares.core.model.base.AjaxResult;
import com.ares.flowable.model.vo.FlowProcDef;
import com.github.pagehelper.Page;

import java.io.IOException;
import java.io.InputStream;
import java.util.List;
import java.util.Map;

public interface IFlowDefinitionService {

    boolean exist(String processDefinitionKey);

    /**
     * 流程定义列表
     *
     * @param pageNum  当前页码
     * @param pageSize 每页条数
     * @return 流程定义分页列表数据
     */
    Page<FlowProcDef> list(Integer pageNum, Integer pageSize);


    /**
     * 导入流程文件
     *
     * @param name
     * @param category
     * @param in
     */
    void importFile(String name, String category, InputStream in);

    /**
     * 读取xml
     *
     * @param deployId
     * @return
     */
    AjaxResult readXml(String deployId) throws IOException;

    /**
     * 读取xml
     *
     * @param deployId
     * @return
     */
    InputStream readImage(String deployId);

    /**
     * 根据流程定义ID启动流程实例
     *
     * @param procDefId 流程定义Id
     * @param variables 流程变量
     * @return
     */
    AjaxResult startProcessInstanceById(String procDefId, Map<String, Object> variables);


    /**
     * 激活或挂起流程定义
     *
     * @param state    状态
     * @param deployId 流程部署ID
     */
    void updateState(Integer state, String deployId);


    /**
     * 删除流程定义
     *
     * @param deployId 流程部署ID act_ge_bytearray 表中 deployment_id值
     */
    void delete(String deployId);

    /**
     * 发起流程列表
     *
     * @param pageNum
     * @param pageSize
     * @return
     */
    Page<FlowProcDef> applyFlowList(Integer pageNum, Integer pageSize);

    /**
     * 发起流程列表
     *
     * @return
     */
    List<FlowProcDef> applyFlowList();

}
