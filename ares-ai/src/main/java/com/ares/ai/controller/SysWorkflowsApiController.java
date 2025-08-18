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

package com.ares.ai.controller;

import cn.dev33.satoken.annotation.SaCheckPermission;
import com.ares.ai.model.ExecuteParams;
import com.ares.ai.model.SysWorkflows;
import com.ares.ai.model.query.SysWorkflowsQuery;
import com.ares.ai.service.ISysWorkflowsService;
import com.ares.core.common.security.SecurityUtils;
import com.ares.core.controller.BaseController;
import com.ares.core.model.base.AjaxResult;
import com.ares.core.model.page.TableDataInfo;
import com.ares.core.utils.StringUtils;
import com.github.pagehelper.PageInfo;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.Arrays;

/**
 * @description:
 * @author: young
 * @date: 2025-05-15 13:15:01
 **/
@RestController
@RequestMapping("/sysWorkflows/*")
@Tag(name = "SysWorkflowsApiController", description = "API")
public class SysWorkflowsApiController extends BaseController {

    private ISysWorkflowsService sysWorkflowsService;

    @Autowired
    public SysWorkflowsApiController(ISysWorkflowsService sysWorkflowsService) {
        this.sysWorkflowsService = sysWorkflowsService;
    }

    @SaCheckPermission("sysWorkflows:list")
    @GetMapping("list")
    @Operation(summary = "列表", responses = {@ApiResponse(content = @Content(schema = @Schema(implementation = TableDataInfo.class)))})
    public TableDataInfo list(SysWorkflowsQuery sysWorkflows) {
        startPage();
        PageInfo<SysWorkflows> sysWorkflowsList = sysWorkflowsService.list(sysWorkflows);
        return getDataTable(sysWorkflowsList);
    }

    @GetMapping("{sysWorkflowsId}")
    @Operation(summary = "根据Id获取信息", responses = {@ApiResponse(content = @Content(schema = @Schema(implementation = Object.class)))})
    public Object getInfo(@PathVariable Long sysWorkflowsId) {
        return AjaxResult.successData(sysWorkflowsService.getById(sysWorkflowsId));
    }

    @SaCheckPermission("sysWorkflows:edit")
    @PostMapping("edit")
    @Operation(summary = "编辑信息", responses = {@ApiResponse(content = @Content(schema = @Schema(implementation = Object.class)))})
    public Object edit(@Validated @RequestBody SysWorkflows sysWorkflows) throws Exception {
        if (StringUtils.isEmpty(sysWorkflows.getId())) {
            sysWorkflows.setCreator(SecurityUtils.getUser().getId());
            sysWorkflowsService.insert(sysWorkflows);
        } else {
            sysWorkflows.setModifier(SecurityUtils.getUser().getId());
            sysWorkflowsService.update(sysWorkflows);
        }
        return AjaxResult.success();
    }

    @SaCheckPermission("sysWorkflows:delete")
    @DeleteMapping("{sysWorkflowsIds}")
    @Operation(summary = "删除信息", responses = {@ApiResponse(content = @Content(schema = @Schema(implementation = Object.class)))})
    public Object remove(@PathVariable Long[] sysWorkflowsIds) {
        sysWorkflowsService.deleteByIds(Arrays.asList(sysWorkflowsIds));
        return AjaxResult.success();
    }

    @PostMapping("workflow/exe")
    public Object exe(@RequestBody ExecuteParams ep) {
        return AjaxResult.successData(sysWorkflowsService.exe(ep));
    }

}
