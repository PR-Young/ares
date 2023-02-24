package com.ares.flowable.persistence.service;


import com.ares.core.model.base.AjaxResult;
import com.ares.flowable.persistence.model.vo.FlowTaskVo;
import org.flowable.engine.history.HistoricProcessInstance;
import org.flowable.task.api.Task;

import java.util.List;
import java.util.Map;

/**
 * <p>工作流流程实例管理<p>
 * @author young
 */
public interface IFlowInstanceService{

    public List<Task> queryListByInstanceId(String instanceId);

    /**
     * 结束流程实例
     *
     * @param vo
     */
    public void stopProcessInstance(FlowTaskVo vo);

    /**
     * 激活或挂起流程实例
     *
     * @param state      状态
     * @param instanceId 流程实例ID
     */
    public void updateState(Integer state, String instanceId);

    /**
     * 删除流程实例ID
     *
     * @param instanceId   流程实例ID
     * @param deleteReason 删除原因
     */
    public void delete(String instanceId, String deleteReason);

    /**
     * 根据实例ID查询历史实例数据
     *
     * @param processInstanceId
     * @return
     */
    public HistoricProcessInstance getHistoricProcessInstanceById(String processInstanceId);

    /**
     * 根据流程定义ID启动流程实例
     *
     * @param procDefId 流程定义Id
     * @param variables 流程变量
     * @return
     */
    public AjaxResult startProcessInstanceById(String procDefId, Map<String, Object> variables);
}
