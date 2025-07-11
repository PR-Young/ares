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
import com.ares.flowable.model.query.SysFormDataQuery;
import com.ares.flowable.model.vo.SysFormData;
import com.ares.flowable.service.ISysFormDataService;
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
@RequestMapping("/sysFormData/*")
@Tag(name = "SysFormDataApiController", description = "API")
public class SysFormDataApiController extends BaseController {

    private ISysFormDataService sysFormDataService;

    @Autowired
    public SysFormDataApiController(ISysFormDataService sysFormDataService) {
        this.sysFormDataService = sysFormDataService;
    }

    @SaCheckPermission("sysFormData:list")
    @GetMapping("list")
    @Operation(summary = "列表", responses = {@ApiResponse(content = @Content(schema = @Schema(implementation = TableDataInfo.class)))})
    public TableDataInfo list(SysFormDataQuery sysFormData) {
        startPage();
        PageInfo<SysFormData> sysFormDataList = sysFormDataService.list(sysFormData);
        return getDataTable(sysFormDataList);
    }

    @GetMapping("{sysFormDataId}")
    @Operation(summary = "根据Id获取信息", responses = {@ApiResponse(content = @Content(schema = @Schema(implementation = Object.class)))})
    public Object getInfo(@PathVariable Long sysFormDataId) {
        return AjaxResult.successData(sysFormDataService.getById(sysFormDataId));
    }

    @SaCheckPermission("sysFormData:edit")
    @PostMapping("edit")
    @Operation(summary = "编辑信息", responses = {@ApiResponse(content = @Content(schema = @Schema(implementation = Object.class)))})
    public Object edit(@Validated @RequestBody SysFormData sysFormData) throws Exception {
        if (StringUtils.isEmpty(sysFormData.getId())) {
            sysFormData.setCreator(SecurityUtils.getUser().getId());
            sysFormDataService.insert(sysFormData);
        } else {
            sysFormData.setModifier(SecurityUtils.getUser().getId());
            sysFormDataService.update(sysFormData);
        }
        return AjaxResult.success();
    }

    @SaCheckPermission("sysFormData:delete")
    @DeleteMapping("{sysFormDataIds}")
    @Operation(summary = "删除信息", responses = {@ApiResponse(content = @Content(schema = @Schema(implementation = Object.class)))})
    public Object remove(@PathVariable Long[] sysFormDataIds) {
        sysFormDataService.deleteByIds(Arrays.asList(sysFormDataIds));
        return AjaxResult.success();
    }

    @GetMapping("getFormData/{proInstId}")
    @Operation(summary = "根据proInstId获取信息", responses = {@ApiResponse(content = @Content(schema = @Schema(implementation = Object.class)))})
    public Object getFormData(@PathVariable String proInstId) {
        return AjaxResult.successData(sysFormDataService.getFormDataByProInstId(proInstId));
    }
}
