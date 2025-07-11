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

package com.ares.system.controller;


import cn.dev33.satoken.annotation.SaCheckPermission;
import com.ares.core.common.security.SecurityUtils;
import com.ares.core.controller.BaseController;
import com.ares.core.model.base.AjaxResult;
import com.ares.core.model.page.TableDataInfo;
import com.ares.core.model.query.SysPropertiesQuery;
import com.ares.core.model.vo.SysProperties;
import com.ares.core.service.ISysPropertiesService;
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
 * @description: 系统参数
 * @author: Young
 */
@RestController
@RequestMapping("/sysProperties/*")
@Tag(name = "SysPropertiesApiController", description = "系统参数API")
public class SysPropertiesApiController extends BaseController {

    private ISysPropertiesService sysPropertiesService;

    @Autowired
    public SysPropertiesApiController(ISysPropertiesService sysPropertiesService) {
        this.sysPropertiesService = sysPropertiesService;
    }

    @SaCheckPermission("sysProperties:list")
    @GetMapping("list")
    @Operation(summary = "系统参数列表", responses = {@ApiResponse(content = @Content(schema = @Schema(implementation = TableDataInfo.class)))})
    public TableDataInfo list(SysPropertiesQuery sysProperties) {
        startPage();
        PageInfo<SysProperties> sysPropertiesList = sysPropertiesService.list(sysProperties);
        return getDataTable(sysPropertiesList);
    }

    @GetMapping("{sysPropertiesId}")
    @Operation(summary = "根据参数Id获取系统参数", responses = {@ApiResponse(content = @Content(schema = @Schema(implementation = Object.class)))})
    public Object getInfo(@PathVariable Long sysPropertiesId) {
        return AjaxResult.successData(sysPropertiesService.getById(sysPropertiesId));
    }

    @SaCheckPermission("sysProperties:edit")
    @PostMapping("edit")
    @Operation(summary = "新增/修改系统参数", responses = {@ApiResponse(content = @Content(schema = @Schema(implementation = Object.class)))})
    public Object edit(@Validated @RequestBody SysProperties sysProperties) throws Exception {
        if (StringUtils.isEmpty(sysProperties.getId())) {
            sysProperties.setCreator(SecurityUtils.getUser().getId());
            sysPropertiesService.insert(sysProperties);
        } else {
            sysProperties.setModifier(SecurityUtils.getUser().getId());
            sysPropertiesService.update(sysProperties);
        }
        return AjaxResult.success();
    }

    @SaCheckPermission("sysProperties:delete")
    @DeleteMapping("{sysPropertiesIds}")
    @Operation(summary = "删除系统参数", responses = {@ApiResponse(content = @Content(schema = @Schema(implementation = Object.class)))})
    public Object remove(@PathVariable Long[] sysPropertiesIds) {
        sysPropertiesService.deleteByIds(Arrays.asList(sysPropertiesIds));
        return AjaxResult.success();
    }
}
