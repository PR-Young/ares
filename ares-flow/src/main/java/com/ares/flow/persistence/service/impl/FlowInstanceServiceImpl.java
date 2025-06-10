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

package com.ares.flow.persistence.service.impl;


import cn.hutool.json.JSONUtil;
import com.ares.core.common.security.SecurityUtils;
import com.ares.core.model.base.AjaxResult;
import com.ares.core.utils.SnowflakeIdWorker;
import com.ares.flow.model.StartFlowParam;
import com.ares.flow.model.SysFormData;
import com.ares.flow.persistence.service.IFlowInstanceService;
import com.ares.flow.persistence.service.ISysFormDataService;
import org.dromara.warm.flow.core.dto.FlowParams;
import org.dromara.warm.flow.core.entity.Instance;
import org.dromara.warm.flow.core.service.InsService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * @description:
 * @author: Young
 * @date: 2025/6/9
 * @see: com.ares.flow.persistence.service.impl.FlowInstanceServiceImpl.java
 **/
@Service
public class FlowInstanceServiceImpl implements IFlowInstanceService {
    private InsService insService;
    private ISysFormDataService formDataService;

    public FlowInstanceServiceImpl(InsService insService,
                                   ISysFormDataService formDataService) {
        this.insService = insService;
        this.formDataService = formDataService;
    }

    @Transactional
    @Override
    public AjaxResult start(StartFlowParam params) {
        String businessId = SnowflakeIdWorker.getSUID();
        FlowParams flowParams = FlowParams.build().flowCode(params.getFlowCode());
        Instance instance = insService.start(businessId, flowParams);

        //保存表单数据
        SysFormData formData = new SysFormData();
        formData.setProInstId(String.valueOf(instance.getId()));
        formData.setFormData(JSONUtil.toJsonStr(params));
        formData.setCreator(SecurityUtils.getUser().getId());
        formDataService.insert(formData);
        return null;
    }
}
