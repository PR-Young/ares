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
import com.ares.core.persistence.model.SysRole;
import com.ares.core.persistence.model.SysUser;
import com.ares.core.persistence.service.ISysRoleService;
import com.ares.core.persistence.service.ISysUserService;
import com.ares.core.utils.StringUtils;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.Arrays;
import java.util.List;

/**
 * @description: 角色
 * @author: Young 2020/05/06
 **/
@RestController
@RequestMapping("/system/role/*")
@Tag(name = "SysRoleApiController", description = "系统角色API")
public class SysRoleApiController extends BaseController {
    private ISysRoleService roleService;
    private ISysUserService userService;

    @Autowired
    public SysRoleApiController(ISysRoleService roleService, ISysUserService userService) {
        this.roleService = roleService;
        this.userService = userService;
    }

    @SaCheckPermission("role:list")
    @RequestMapping("list")
    @Operation(summary = "角色列表", responses = {@ApiResponse(content = @Content(schema = @Schema(implementation = TableDataInfo.class)))})
    public TableDataInfo list(SysRole role) {
        startPage();
        List<SysRole> roleList = roleService.selectRoleList(role);
        return getDataTable(roleList);
    }

    @GetMapping("{roleId}")
    @Operation(summary = "根据角色Id获取用户", responses = {@ApiResponse(content = @Content(schema = @Schema(implementation = Object.class)))})
    public Object getInfo(@PathVariable String roleId) {
        return AjaxResult.successData(roleService.getById(roleId));
    }

    @SaCheckPermission("role:edit")
    @PostMapping("edit")
    @Operation(summary = "新增/修改角色", responses = {@ApiResponse(content = @Content(schema = @Schema(implementation = Object.class)))})
    public Object edit(@Validated @RequestBody SysRole role) throws Exception {
        String roleId = "";
        if (StringUtils.isEmpty(role.getId())) {
            if (!roleService.checkRoleName(role.getRoleName())) {
                return AjaxResult.error("新增角色'" + role.getRoleName() + "'失败，角色名称已存在");
            }
            role.setCreator(SecurityUtils.getUser().getId());
            roleId = roleService.insertRole(role);
        } else {
            roleId = role.getId();
            role.setModifier(SecurityUtils.getUser().getId());
            roleService.updateRole(role);
        }

        return AjaxResult.success();
    }

    @SaCheckPermission("role:delete")
    @DeleteMapping("{roleIds}")
    @Operation(summary = "删除用户", responses = {@ApiResponse(content = @Content(schema = @Schema(implementation = Object.class)))})
    public Object remove(@PathVariable String[] roleIds) {
        roleService.deleteByIds(Arrays.asList(roleIds));
        return AjaxResult.success();
    }

    @PutMapping("dataScope")
    @Operation(summary = "角色权限分配", responses = {@ApiResponse(content = @Content(schema = @Schema(implementation = Object.class)))})
    public Object dataScope(@RequestBody SysRole role) {
        roleService.authDataScope(role);
        return AjaxResult.success();
    }

    @GetMapping("optionselect")
    @Operation(summary = "角色下拉选项", responses = {@ApiResponse(content = @Content(schema = @Schema(implementation = Object.class)))})
    public Object optionSelect() {
        return AjaxResult.successData(roleService.getAll());
    }

    @GetMapping("roleUserselect/{roleId}")
    @Operation(summary = "根据角色Id获取用户", responses = {@ApiResponse(content = @Content(schema = @Schema(implementation = Object.class)))})
    public Object roleUserselect(@PathVariable String roleId) {
        AjaxResult result = AjaxResult.success();
        result.put("allUser", userService.selectUserList(new SysUser()));
        result.put("checkedKeys", userService.getUserByRole(roleId));
        return result;
    }
}
