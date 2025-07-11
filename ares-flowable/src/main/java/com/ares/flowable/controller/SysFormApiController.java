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

package com.ares.flowable.controller;

import cn.dev33.satoken.annotation.SaCheckPermission;
import com.ares.core.common.security.SecurityUtils;
import com.ares.core.controller.BaseController;
import com.ares.core.model.base.AjaxResult;
import com.ares.core.model.page.TableDataInfo;
import com.ares.core.utils.StringUtils;
import com.ares.flowable.model.query.SysFormQuery;
import com.ares.flowable.model.vo.SysDeployForm;
import com.ares.flowable.model.vo.SysForm;
import com.ares.flowable.service.ISysDeployFormService;
import com.ares.flowable.service.ISysFormService;
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


@RestController
@RequestMapping("/sysForm/*")
@Tag(name = "SysFormApiController", description = "API")
public class SysFormApiController extends BaseController {

    private ISysFormService sysFormService;
    private ISysDeployFormService deployFormService;

    @Autowired
    public SysFormApiController(ISysFormService sysFormService, ISysDeployFormService deployFormService) {
        this.sysFormService = sysFormService;
        this.deployFormService = deployFormService;
    }

    @SaCheckPermission("sysForm:list")
    @GetMapping("list")
    @Operation(summary = "列表", responses = {@ApiResponse(content = @Content(schema = @Schema(implementation = TableDataInfo.class)))})
    public TableDataInfo list(SysFormQuery sysForm) {
        startPage();
        PageInfo<SysForm> sysFormList = sysFormService.list(sysForm);
        return getDataTable(sysFormList);
    }

    @GetMapping("{sysFormId}")
    @Operation(summary = "根据Id获取信息", responses = {@ApiResponse(content = @Content(schema = @Schema(implementation = Object.class)))})
    public Object getInfo(@PathVariable Long sysFormId) {
        return AjaxResult.successData(sysFormService.getById(sysFormId));
    }

    @SaCheckPermission("sysForm:edit")
    @PostMapping("edit")
    @Operation(summary = "编辑信息", responses = {@ApiResponse(content = @Content(schema = @Schema(implementation = Object.class)))})
    public Object edit(@Validated @RequestBody SysForm sysForm) throws Exception {
        if (StringUtils.isEmpty(sysForm.getId())) {
            sysForm.setCreator(SecurityUtils.getUser().getId());
            sysFormService.insert(sysForm);
        } else {
            sysForm.setModifier(SecurityUtils.getUser().getId());
            sysFormService.update(sysForm);
        }
        return AjaxResult.success();
    }

    @SaCheckPermission("sysForm:delete")
    @DeleteMapping("{sysFormIds}")
    @Operation(summary = "删除信息", responses = {@ApiResponse(content = @Content(schema = @Schema(implementation = Object.class)))})
    public Object remove(@PathVariable Long[] sysFormIds) {
        sysFormService.deleteByIds(Arrays.asList(sysFormIds));
        return AjaxResult.success();
    }

    /**
     * 挂载流程表单
     */
    @Operation(summary = "流程表单", responses = {@ApiResponse(content = @Content(schema = @Schema(implementation = Object.class)))})
    @PostMapping("/addDeployForm")
    public Object addDeployForm(@RequestBody SysDeployForm sysDeployForm) {
        deployFormService.insert(sysDeployForm);
        return AjaxResult.success();
    }
}
