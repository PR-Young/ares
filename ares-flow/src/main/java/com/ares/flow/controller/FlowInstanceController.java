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

package com.ares.flow.controller;


import com.ares.core.model.base.AjaxResult;
import com.ares.flow.model.StartFlowParam;
import com.ares.flow.persistence.service.IFlowInstanceService;
import io.swagger.v3.oas.annotations.Parameter;
import org.dromara.warm.flow.core.service.InsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.Arrays;

/**
 * @description:
 * @author: Young
 * @date: 2025/6/6
 * @see: com.ares.flow.controller.FlowInstanceController.java
 **/
@RestController
@RequestMapping("/flow/instance/*")
public class FlowInstanceController {
    private InsService insService;
    private IFlowInstanceService flowInstanceService;

    @Autowired
    public FlowInstanceController(InsService insService,
                                  IFlowInstanceService flowInstanceService) {
        this.insService = insService;
        this.flowInstanceService = flowInstanceService;
    }

    @PostMapping("start")
    public AjaxResult startFlow(@RequestBody StartFlowParam params) {
        return flowInstanceService.start(params);
    }


    @RequestMapping(value = "active/{id}")
    public AjaxResult active(@Parameter Long id) {
        insService.active(id);
        return AjaxResult.success();
    }

    @RequestMapping(value = "unactive/{id}")
    public AjaxResult unActive(@Parameter Long id) {
        insService.unActive(id);
        return AjaxResult.success();
    }

    @DeleteMapping("remove/{ids}")
    public AjaxResult stopProcessInstance(@PathVariable Long[] ids) {
        insService.remove(Arrays.asList(ids));
        return AjaxResult.success();
    }

}
