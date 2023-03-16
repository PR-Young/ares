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

package com.ares.flowable.persistence.service;

import com.ares.core.model.base.AjaxResult;
import com.ares.flowable.persistence.model.dto.FlowTaskDto;
import com.ares.flowable.persistence.model.vo.FlowTaskVo;
import com.github.pagehelper.Page;
import org.flowable.task.api.Task;

import java.io.InputStream;

/**
 * @description:
 * @author: Young
 * @date: 2022/1/13
 * @see: com.ares.flowable.persistence.service.FlowTaskService.java
 **/
public interface IFlowTaskService {
    /**
     * 完成任务
     *
     * @param taskVo 请求实体参数
     */
    public AjaxResult complete(FlowTaskVo taskVo) ;

    /**
     * 驳回任务
     *
     * @param taskVo
     */
    public void taskRejectNew(FlowTaskVo taskVo);

    /**
     * 驳回任务
     *
     * @param flowTaskVo
     */
    public void taskReject(FlowTaskVo flowTaskVo);

    /**
     * 退回任务
     *
     * @param flowTaskVo 请求实体参数
     */
    public void taskReturn(FlowTaskVo flowTaskVo);


    /**
     * 获取所有可回退的节点
     *
     * @param flowTaskVo
     * @return
     */
    public AjaxResult findReturnTaskList(FlowTaskVo flowTaskVo);

    /**
     * 删除任务
     *
     * @param flowTaskVo 请求实体参数
     */

    public void deleteTask(FlowTaskVo flowTaskVo);

    /**
     * 认领/签收任务
     *
     * @param flowTaskVo 请求实体参数
     */
    public void claim(FlowTaskVo flowTaskVo);

    /**
     * 取消认领/签收任务
     *
     * @param flowTaskVo 请求实体参数
     */
    public void unClaim(FlowTaskVo flowTaskVo);

    /**
     * 委派任务
     *
     * @param flowTaskVo 请求实体参数
     */
    public void delegateTask(FlowTaskVo flowTaskVo);


    /**
     * 转办任务
     *
     * @param flowTaskVo 请求实体参数
     */
    public void assignTask(FlowTaskVo flowTaskVo);

    /**
     * 我发起的流程
     *
     * @param pageNum
     * @param pageSize
     * @return
     */
    public Page<FlowTaskDto> myProcess(Integer pageNum, Integer pageSize);

    /**
     * 取消申请
     *
     * @param flowTaskVo
     * @return
     */
    public AjaxResult stopProcess(FlowTaskVo flowTaskVo);

    /**
     * 撤回流程  目前存在错误
     *
     * @param flowTaskVo
     * @return
     */
    public AjaxResult revokeProcess(FlowTaskVo flowTaskVo);

    /**
     * 代办任务列表
     *
     * @param pageNum  当前页码
     * @param pageSize 每页条数
     * @return
     */
    public Page<FlowTaskDto> todoList(Integer pageNum, Integer pageSize);


    /**
     * 已办任务列表
     *
     * @param pageNum  当前页码
     * @param pageSize 每页条数
     * @return
     */
    public Page<FlowTaskDto> finishedList(Integer pageNum, Integer pageSize) ;


    /**
     * 流程历史流转记录
     *
     * @param procInsId 流程实例Id
     * @return
     */
    public AjaxResult flowRecord(String procInsId, String deployId);

    /**
     * 根据任务ID查询挂载的表单信息
     *
     * @param taskId 任务Id
     * @return
     */

    public Task getTaskForm(String taskId);

    /**
     * 获取流程过程图
     *
     * @param processId
     * @return
     */
    public InputStream diagram(String processId);

    /**
     * 获取流程执行过程
     *
     * @param procInsId
     * @return
     */
    public AjaxResult getFlowViewer(String procInsId);

    /**
     * 获取流程变量
     *
     * @param taskId
     * @return
     */
    public AjaxResult processVariables(String taskId);

    /**
     * 获取下一节点
     *
     * @param flowTaskVo 任务
     * @return
     */
    public AjaxResult getNextFlowNode(FlowTaskVo flowTaskVo);


}
