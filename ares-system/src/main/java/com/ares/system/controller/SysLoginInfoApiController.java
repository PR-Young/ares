/*
 *
 *  * !******************************************************************************
 *  *  * Copyright (c) 2021 - 9999, ARES
 *  *  *
 *  *  * Licensed under the Apache License, Version 2.0 (the "License");
 *  *  * you may not use this file except in compliance with the License.
 *  *  * You may obtain a copy of the License at
 *  *  *
 *  *  *        http://www.apache.org/licenses/LICENSE-2.0
 *  *  *
 *  *  * Unless required by applicable law or agreed to in writing, software
 *  *  * distributed under the License is distributed on an "AS IS" BASIS,
 *  *  * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  *  * See the License for the specific language governing permissions and
 *  *  * limitations under the License.
 *  *  *****************************************************************************
 *
 */

package com.ares.system.controller;

import cn.dev33.satoken.annotation.SaCheckPermission;
import com.ares.core.common.security.SecurityUtils;
import com.ares.core.controller.BaseController;
import com.ares.core.model.base.AjaxResult;
import com.ares.core.model.page.TableDataInfo;
import com.ares.core.model.query.SysLoginInfoQuery;
import com.ares.core.model.vo.SysLoginInfo;
import com.ares.core.service.ISysLoginInfoService;
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


@RestController
@RequestMapping("/sysLoginInfo/*")
@Tag(name = "SysLoginInfoApiController", description = "API")
public class SysLoginInfoApiController extends BaseController {

    private ISysLoginInfoService sysLoginInfoService;

    @Autowired
    public SysLoginInfoApiController(ISysLoginInfoService sysLoginInfoService) {
        this.sysLoginInfoService = sysLoginInfoService;
    }

    @SaCheckPermission("sysLoginInfo:list")
    @GetMapping("list")
    @Operation(summary = "列表", responses = {@ApiResponse(content = @Content(schema = @Schema(implementation = TableDataInfo.class)))})
    public TableDataInfo list(SysLoginInfoQuery sysLoginInfo) {
        startPage();
        PageInfo<SysLoginInfo> sysLoginInfoList = sysLoginInfoService.list(sysLoginInfo);
        return getDataTable(sysLoginInfoList);
    }

    @GetMapping("{sysLoginInfoId}")
    @Operation(summary = "根据Id获取信息", responses = {@ApiResponse(content = @Content(schema = @Schema(implementation = Object.class)))})
    public Object getInfo(@PathVariable Long sysLoginInfoId) {
        return AjaxResult.successData(sysLoginInfoService.getById(sysLoginInfoId));
    }

    @SaCheckPermission("sysLoginInfo:edit")
    @PostMapping("edit")
    @Operation(summary = "编辑信息", responses = {@ApiResponse(content = @Content(schema = @Schema(implementation = Object.class)))})
    public Object edit(@Validated @RequestBody SysLoginInfo sysLoginInfo) throws Exception {
        if (StringUtils.isEmpty(sysLoginInfo.getId())) {
            sysLoginInfo.setCreator(SecurityUtils.getUser().getId());
            sysLoginInfoService.insert(sysLoginInfo);
        } else {
            sysLoginInfo.setModifier(SecurityUtils.getUser().getId());
            sysLoginInfoService.update(sysLoginInfo);
        }
        return AjaxResult.success();
    }

    @SaCheckPermission("sysLoginInfo:delete")
    @DeleteMapping("{sysLoginInfoIds}")
    @Operation(summary = "删除信息", responses = {@ApiResponse(content = @Content(schema = @Schema(implementation = Object.class)))})
    public Object remove(@PathVariable Long[] sysLoginInfoIds) {
        sysLoginInfoService.deleteByIds(Arrays.asList(sysLoginInfoIds));
        return AjaxResult.success();
    }

    @SaCheckPermission("sysLoginInfo:clean")
    @DeleteMapping("clean")
    @Operation(summary = "删除信息", responses = {@ApiResponse(content = @Content(schema = @Schema(implementation = Object.class)))})
    public Object clean() {
        sysLoginInfoService.remove();
        return AjaxResult.success();
    }
}
