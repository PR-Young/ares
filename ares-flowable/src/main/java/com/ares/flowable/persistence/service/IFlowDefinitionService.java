package com.ares.flowable.persistence.service;


import com.ares.core.persistence.model.base.AjaxResult;
import com.ares.flowable.persistence.model.dto.FlowProcDefDto;
import com.github.pagehelper.Page;

import java.io.IOException;
import java.io.InputStream;
import java.util.List;
import java.util.Map;

public interface IFlowDefinitionService {

    public boolean exist(String processDefinitionKey) ;

    /**
     * 流程定义列表
     *
     * @param pageNum  当前页码
     * @param pageSize 每页条数
     * @return 流程定义分页列表数据
     */
    public Page<FlowProcDefDto> list(Integer pageNum, Integer pageSize);


    /**
     * 导入流程文件
     *
     * @param name
     * @param category
     * @param in
     */
    public void importFile(String name, String category, InputStream in);

    /**
     * 读取xml
     *
     * @param deployId
     * @return
     */
    public AjaxResult readXml(String deployId) throws IOException ;

    /**
     * 读取xml
     *
     * @param deployId
     * @return
     */
    public InputStream readImage(String deployId) ;

    /**
     * 根据流程定义ID启动流程实例
     *
     * @param procDefId 流程定义Id
     * @param variables 流程变量
     * @return
     */
    public AjaxResult startProcessInstanceById(String procDefId, Map<String, Object> variables);


    /**
     * 激活或挂起流程定义
     *
     * @param state    状态
     * @param deployId 流程部署ID
     */
    public void updateState(Integer state, String deployId);


    /**
     * 删除流程定义
     *
     * @param deployId 流程部署ID act_ge_bytearray 表中 deployment_id值
     */
    public void delete(String deployId);
    /**
     * 发起流程列表
     *
     * @param pageNum
     * @param pageSize
     * @return
     */
    public Page<FlowProcDefDto> applyFlowList(Integer pageNum, Integer pageSize) ;

    /**
     * 发起流程列表
     *
     * @return
     */
    public List<FlowProcDefDto> applyFlowList() ;

}
