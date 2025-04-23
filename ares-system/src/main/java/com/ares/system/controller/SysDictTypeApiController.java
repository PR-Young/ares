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
import com.ares.core.model.query.SysDictTypeQuery;
import com.ares.core.model.vo.SysDictType;
import com.ares.core.persistence.service.ISysDictTypeService;
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
 * @description: 字典
 * @author: Young
 */
@RestController
@RequestMapping("/system/dict/type/*")
@Tag(name = "SysDictTypeApiController", description = "字典类别API")
public class SysDictTypeApiController extends BaseController {

    private ISysDictTypeService sysDictTypeService;

    @Autowired
    public SysDictTypeApiController(ISysDictTypeService sysDictTypeService) {
        this.sysDictTypeService = sysDictTypeService;
    }

    @SaCheckPermission("sysDictType:list")
    @GetMapping("list")
    @Operation(summary = "字典类别列表", responses = {@ApiResponse(content = @Content(schema = @Schema(implementation = TableDataInfo.class)))})
    public TableDataInfo list(SysDictTypeQuery sysDictType) {
        startPage();
        PageInfo<SysDictType> sysDictTypeList = sysDictTypeService.list(sysDictType);
        return getDataTable(sysDictTypeList);
    }

    @GetMapping("{sysDictTypeId}")
    @Operation(summary = "根据Id获取字典类别", responses = {@ApiResponse(content = @Content(schema = @Schema(implementation = Object.class)))})
    public Object getInfo(@PathVariable Long sysDictTypeId) {
        return AjaxResult.successData(sysDictTypeService.getById(sysDictTypeId));
    }

    @SaCheckPermission("sysDictType:edit")
    @PostMapping("edit")
    @Operation(summary = "编辑字典类别", responses = {@ApiResponse(content = @Content(schema = @Schema(implementation = Object.class)))})
    public Object edit(@Validated @RequestBody SysDictType sysDictType) throws Exception {
        if (StringUtils.isEmpty(sysDictType.getId())) {
            sysDictType.setCreator(SecurityUtils.getUser().getId());
            sysDictTypeService.insert(sysDictType);
        } else {
            sysDictType.setModifier(SecurityUtils.getUser().getId());
            sysDictTypeService.update(sysDictType);
        }
        return AjaxResult.success();
    }

    @SaCheckPermission("sysDictType:delete")
    @DeleteMapping("{sysDictTypeIds}")
    @Operation(summary = "删除字典类别", responses = {@ApiResponse(content = @Content(schema = @Schema(implementation = Object.class)))})
    public Object remove(@PathVariable Long[] sysDictTypeIds) {
        sysDictTypeService.deleteByIds(Arrays.asList(sysDictTypeIds));
        return AjaxResult.success();
    }

}
