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

package com.ares.generator.controller;

import cn.dev33.satoken.annotation.SaCheckPermission;
import com.ares.core.common.security.SecurityUtils;
import com.ares.core.controller.BaseController;
import com.ares.core.model.base.AjaxResult;
import com.ares.core.model.page.TableDataInfo;
import com.ares.core.utils.StringUtils;
import com.ares.generator.model.query.GenPropertiesQuery;
import com.ares.generator.model.vo.GenProperties;
import com.ares.generator.service.IGenPropertiesService;
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
@RequestMapping("/genProperties/*")
@Tag(name = "GenPropertiesApiController", description = "API")
public class GenPropertiesApiController extends BaseController {

    private IGenPropertiesService genPropertiesService;

    @Autowired
    public GenPropertiesApiController(IGenPropertiesService genPropertiesService) {
        this.genPropertiesService = genPropertiesService;
    }

    @SaCheckPermission("genProperties:list")
    @GetMapping("list")
    @Operation(summary = "列表", responses = {@ApiResponse(content = @Content(schema = @Schema(implementation = TableDataInfo.class)))})
    public TableDataInfo list(GenPropertiesQuery genProperties) {
        startPage();
        PageInfo<GenProperties> genPropertiesList = genPropertiesService.list(genProperties);
        return getDataTable(genPropertiesList);
    }

    @GetMapping("{genPropertiesId}")
    @Operation(summary = "根据Id获取信息", responses = {@ApiResponse(content = @Content(schema = @Schema(implementation = Object.class)))})
    public Object getInfo(@PathVariable Long genPropertiesId) {
        return AjaxResult.successData(genPropertiesService.getById(genPropertiesId));
    }

    @PostMapping("edit")
    @Operation(summary = "编辑信息", responses = {@ApiResponse(content = @Content(schema = @Schema(implementation = Object.class)))})
    public Object edit(@Validated @RequestBody GenProperties genProperties) throws Exception {
        if (StringUtils.isEmpty(genProperties.getId())) {
            genProperties.setCreator(SecurityUtils.getUser().getId());
            genPropertiesService.insert(genProperties);
        } else {
            genProperties.setModifier(SecurityUtils.getUser().getId());
            genPropertiesService.update(genProperties);
        }
        return AjaxResult.success();
    }

    @SaCheckPermission("genProperties:delete")
    @DeleteMapping("{genPropertiesIds}")
    @Operation(summary = "删除信息", responses = {@ApiResponse(content = @Content(schema = @Schema(implementation = Object.class)))})
    public Object remove(@PathVariable Long[] genPropertiesIds) {
        genPropertiesService.deleteByIds(Arrays.asList(genPropertiesIds));
        return AjaxResult.success();
    }

    @GetMapping("basicInfo")
    @Operation(summary = "获取信息", responses = {@ApiResponse(content = @Content(schema = @Schema(implementation = Object.class)))})
    public Object getBasicInfo() {
        GenProperties properties = genPropertiesService.getByUser();
        if (null == properties) {
            properties = new GenProperties();
        }
        return AjaxResult.successData(properties);
    }
}
