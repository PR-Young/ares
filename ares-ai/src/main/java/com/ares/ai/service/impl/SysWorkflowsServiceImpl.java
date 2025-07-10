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

package com.ares.ai.service.impl;

import com.agentsflex.llm.qwen.QwenLlm;
import com.agentsflex.llm.qwen.QwenLlmConfig;
import com.alibaba.fastjson2.JSON;
import com.alibaba.fastjson2.JSONArray;
import com.alibaba.fastjson2.JSONObject;
import com.alibaba.fastjson2.TypeReference;
import com.ares.ai.model.ExecuteParams;
import com.ares.ai.model.SysWorkflows;
import com.ares.ai.model.query.SysWorkflowsQuery;
import com.ares.ai.persistence.dao.ISysWorkflowsDao;
import com.ares.ai.persistence.entity.SysWorkflowsDto;
import com.ares.ai.service.ISysWorkflowsService;
import com.ares.core.utils.SnowflakeIdWorker;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import dev.tinyflow.core.Tinyflow;
import io.github.linpeilie.Converter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * @description:
 * @author: young
 * @date: 2025-05-15 13:15:01
 **/
@Service
public class SysWorkflowsServiceImpl implements ISysWorkflowsService {

    private ISysWorkflowsDao sysWorkflowsDao;
    private Converter converter;

    @Autowired
    public SysWorkflowsServiceImpl(ISysWorkflowsDao sysWorkflowsDao, Converter converter) {
        this.sysWorkflowsDao = sysWorkflowsDao;
        this.converter = converter;
    }

    @Override
    public PageInfo<SysWorkflows> list(int pageNo, int pageSize, Map<String, Object> map) {
        PageHelper.startPage(pageNo, pageSize);
        List<SysWorkflows> lists = converter.convert(sysWorkflowsDao.list(map), SysWorkflows.class);
        PageInfo<SysWorkflows> pageInfo = new PageInfo<>(lists);
        return pageInfo;
    }

    @Override
    public void insert(SysWorkflows obj) {
        obj.setId(SnowflakeIdWorker.getUUID());
        obj.setCreateTime(new Date());
        SysWorkflowsDto dto = converter.convert(obj, SysWorkflowsDto.class);
        sysWorkflowsDao.insert(dto);
    }

    @Override
    public void update(SysWorkflows obj) {
        obj.setModifyTime(new Date());
        SysWorkflowsDto dto = converter.convert(obj, SysWorkflowsDto.class);
        sysWorkflowsDao.update(dto);
    }

    @Override
    public void deleteByIds(List<Long> ids) {
        sysWorkflowsDao.deleteByIds(ids);
    }

    @Override
    public SysWorkflows getById(Long id) {
        return converter.convert(sysWorkflowsDao.getById(id), SysWorkflows.class);
    }

    @Override
    public PageInfo<SysWorkflows> list(SysWorkflowsQuery obj) {
        List<SysWorkflowsDto> lists = sysWorkflowsDao.selectList(obj);
        PageInfo<SysWorkflowsDto> pageInfo = new PageInfo<>(lists);
        PageInfo<SysWorkflows> page = pageInfo.convert(dto -> {
            SysWorkflows v = converter.convert(dto, SysWorkflows.class);
            return v;
        });
        return page;
    }

    @Override
    public Map<String, Object> exe(ExecuteParams params) {
        Tinyflow tinyflow = parseFlowParam(params.getData());
        Map<String, Object> variables = JSON.parseObject(params.getParam(), new TypeReference<Map<String, Object>>() {
        });
        Map<String, Object> result = tinyflow.toChain().executeForResult(variables);
        return result;
    }

    private Tinyflow parseFlowParam(String graph) {
        JSONObject json = JSONObject.parseObject(graph);
        JSONArray nodeArr = json.getJSONArray("nodes");
        Tinyflow tinyflow = new Tinyflow(json.toJSONString());
        for (int i = 0; i < nodeArr.size(); i++) {
            JSONObject node = nodeArr.getJSONObject(i);
            switch (node.getString("type")) {
                case "llmNode":
                    JSONObject data = node.getJSONObject("data");
                    QwenLlmConfig qwenLlmConfig = new QwenLlmConfig();
                    //  千问apikey
                    qwenLlmConfig.setApiKey("sk-0119dfa3487045ceb4bce6d055e4257c");
                    qwenLlmConfig.setModel("qwen-plus");
                    tinyflow.setLlmProvider(id -> new QwenLlm(qwenLlmConfig));
                    break;
                case "zsk":

                    break;
                default:
                    break;
            }
        }
        return tinyflow;
    }
}
