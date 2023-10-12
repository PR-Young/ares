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

package com.ares.system.controller;

import cn.dev33.satoken.annotation.SaCheckPermission;
import com.ares.core.common.security.SecurityUtils;
import com.ares.core.controller.BaseController;
import com.ares.core.model.base.AjaxResult;
import com.ares.core.model.page.TableDataInfo;
import com.ares.core.model.query.SysTenantsQuery;
import com.ares.core.persistence.model.SysTenants;
import com.ares.core.persistence.service.ISysTenantUsersService;
import com.ares.core.persistence.service.ISysTenantsService;
import com.ares.core.utils.StringUtils;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.Arrays;
import java.util.List;


@RestController
@RequestMapping("/sysTenants/*")
@Tag(name = "SysTenantsApiController", description = "API")
public class SysTenantsApiController extends BaseController {

    private ISysTenantsService sysTenantsService;
    private ISysTenantUsersService sysTenantRolesService;

    @Autowired
    public SysTenantsApiController(ISysTenantsService sysTenantsService, ISysTenantUsersService sysTenantRolesService) {
        this.sysTenantsService = sysTenantsService;
        this.sysTenantRolesService = sysTenantRolesService;
    }

    @SaCheckPermission("sysTenants:list")
    @GetMapping("list")
    @Operation(summary = "列表", responses = {@ApiResponse(content = @Content(schema = @Schema(implementation = TableDataInfo.class)))})
    public TableDataInfo list(SysTenantsQuery sysTenants) {
        startPage();
        List<SysTenants> sysTenantsList = sysTenantsService.list(sysTenants);
        return getDataTable(sysTenantsList);
    }

    @GetMapping(value = {"", "{sysTenantsId}"})
    @Operation(summary = "根据Id获取信息", responses = {@ApiResponse(content = @Content(schema = @Schema(implementation = Object.class)))})
    public Object getInfo(@PathVariable(required = false) Long sysTenantsId) {
        AjaxResult result = new AjaxResult();
        result.put("code", HttpStatus.OK.value());
        result.put("data", sysTenantsService.getById(sysTenantsId));
        result.put("allUser", sysTenantsService.getAllUsers());
        if (StringUtils.isNotEmpty(sysTenantsId)) {
            result.put("checkedKeys", sysTenantRolesService.getUserIdsByTenant(sysTenantsId));
        }
        return result;
    }

    @SaCheckPermission("sysTenants:edit")
    @PostMapping("edit")
    @Operation(summary = "编辑信息", responses = {@ApiResponse(content = @Content(schema = @Schema(implementation = Object.class)))})
    public Object edit(@Validated @RequestBody SysTenants sysTenants) throws Exception {
        if (StringUtils.isEmpty(sysTenants.getId())) {
            sysTenants.setCreator(SecurityUtils.getUser().getId());
            sysTenantsService.insert(sysTenants);
        } else {
            sysTenants.setModifier(SecurityUtils.getUser().getId());
            sysTenantsService.update(sysTenants);
        }
        return AjaxResult.success();
    }

    @SaCheckPermission("sysTenants:delete")
    @DeleteMapping("{sysTenantsIds}")
    @Operation(summary = "删除信息", responses = {@ApiResponse(content = @Content(schema = @Schema(implementation = Object.class)))})
    public Object remove(@PathVariable Long[] sysTenantsIds) {
        sysTenantsService.deleteByIds(Arrays.asList(sysTenantsIds));
        return AjaxResult.success();
    }

    @PutMapping("changeStatus")
    @Operation(summary = "", responses = {@ApiResponse(content = @Content(schema = @Schema(implementation = Object.class)))})
    public Object changeStatus(@RequestBody SysTenants tenants) throws Exception {
        SysTenants newTenant = sysTenantsService.getById(tenants.getId());
        newTenant.setTenantStatus(tenants.getTenantStatus());
        newTenant.setModifier(SecurityUtils.getUser().getId());
        sysTenantsService.update(newTenant);
        return AjaxResult.success();
    }
}
