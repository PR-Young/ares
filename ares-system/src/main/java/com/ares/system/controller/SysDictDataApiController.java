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
import com.ares.core.model.query.SysDictDataQuery;
import com.ares.core.model.vo.SysDictData;
import com.ares.core.service.ISysDictDataService;
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
@RequestMapping("/system/dict/data/*")
@Tag(name = "SysDictDataApiController", description = "字典数据API")
public class SysDictDataApiController extends BaseController {

    private ISysDictDataService sysDictDataService;

    @Autowired
    public SysDictDataApiController(ISysDictDataService sysDictDataService) {
        this.sysDictDataService = sysDictDataService;
    }

    @SaCheckPermission("sysDictData:list")
    @GetMapping("list")
    @Operation(summary = "字典数据列表", responses = {@ApiResponse(content = @Content(schema = @Schema(implementation = TableDataInfo.class)))})
    public TableDataInfo list(SysDictDataQuery sysDictData) {
        startPage();
        PageInfo<SysDictData> sysDictDataList = sysDictDataService.list(sysDictData);
        return getDataTable(sysDictDataList);
    }

    @GetMapping("{sysDictDataId}")
    @Operation(summary = "根据Id获取字典数据", responses = {@ApiResponse(content = @Content(schema = @Schema(implementation = Object.class)))})
    public Object getInfo(@PathVariable Long sysDictDataId) {
        return AjaxResult.successData(sysDictDataService.getById(sysDictDataId));
    }

    @SaCheckPermission("sysDictData:edit")
    @PostMapping("edit")
    @Operation(summary = "编辑字典数据", responses = {@ApiResponse(content = @Content(schema = @Schema(implementation = Object.class)))})
    public Object edit(@Validated @RequestBody SysDictData sysDictData) throws Exception {
        if (StringUtils.isEmpty(sysDictData.getId())) {
            sysDictData.setCreator(SecurityUtils.getUser().getId());
            sysDictDataService.insert(sysDictData);
        } else {
            sysDictData.setModifier(SecurityUtils.getUser().getId());
            sysDictDataService.update(sysDictData);
        }
        return AjaxResult.success();
    }

    @SaCheckPermission("sysDictData:delete")
    @DeleteMapping("{sysDictDataIds}")
    @Operation(summary = "删除字典数据", responses = {@ApiResponse(content = @Content(schema = @Schema(implementation = Object.class)))})
    public Object remove(@PathVariable Long[] sysDictDataIds) {
        sysDictDataService.deleteByIds(Arrays.asList(sysDictDataIds));
        return AjaxResult.success();
    }

    @GetMapping("dictType/{dictType}")
    @Operation(summary = "根据类别获取字典数据", responses = {@ApiResponse(content = @Content(schema = @Schema(implementation = Object.class)))})
    public Object getDicts(@PathVariable String dictType) {
        return AjaxResult.successData(sysDictDataService.getDicts(dictType));
    }
}
