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
import com.ares.core.model.query.SysDeptQuery;
import com.ares.core.model.vo.SysDept;
import com.ares.core.service.ISysDeptService;
import com.ares.core.utils.StringUtils;
import com.github.pagehelper.PageInfo;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.Arrays;

/**
 * @description: 部门
 * @author: Young
 */
@RestController
@RequestMapping("/sysDept/*")
@Tag(name = "SysDeptApiController", description = "部门管理API")
public class SysDeptApiController extends BaseController {

    private ISysDeptService sysDeptService;

    @Autowired
    public SysDeptApiController(ISysDeptService sysDeptService) {
        this.sysDeptService = sysDeptService;
    }

    @SaCheckPermission("sysDept:list")
    @GetMapping("list")
    @Operation(summary = "部门列表", responses = {@ApiResponse(content = @Content(schema = @Schema(implementation = TableDataInfo.class)))})
    public TableDataInfo list(SysDeptQuery sysDept) {
        startPage();
        PageInfo<SysDept> sysDeptList = sysDeptService.list(sysDept);
        return getDataTable(sysDeptList);
    }

    @GetMapping("{sysDeptId}")
    @Operation(summary = "根据Id获取部门信息", responses = {@ApiResponse(content = @Content(schema = @Schema(implementation = Object.class)))})
    public Object getInfo(@PathVariable Long sysDeptId) {
        return AjaxResult.successData(sysDeptService.getByDeptId(sysDeptId));
    }

    @SaCheckPermission("sysDept:edit")
    @PostMapping("edit")
    @Operation(summary = "编辑部门信息", responses = {@ApiResponse(content = @Content(schema = @Schema(implementation = Object.class)))})
    public Object edit(@Validated @RequestBody SysDept sysDept) throws Exception {
        if (StringUtils.isEmpty(sysDept.getId())) {
            sysDept.setCreator(SecurityUtils.getUser().getId());
            sysDeptService.insert(sysDept);
        } else {
            sysDept.setModifier(SecurityUtils.getUser().getId());
            sysDeptService.update(sysDept);
        }
        return AjaxResult.success();
    }

    @SaCheckPermission("sysDept:delete")
    @DeleteMapping("{sysDeptIds}")
    @Operation(summary = "删除部门", responses = {@ApiResponse(content = @Content(schema = @Schema(implementation = Object.class)))})
    public Object remove(@PathVariable Long[] sysDeptIds) {
        sysDeptService.deleteByIds(Arrays.asList(sysDeptIds));
        return AjaxResult.success();
    }

    @GetMapping("treeselect")
    @Operation(summary = "部门树列表", responses = {@ApiResponse(content = @Content(schema = @Schema(implementation = Object.class)))})
    public Object tree(HttpServletRequest request, HttpServletResponse response) {
        return AjaxResult.successData(sysDeptService.buildDeptTree());
    }
}
