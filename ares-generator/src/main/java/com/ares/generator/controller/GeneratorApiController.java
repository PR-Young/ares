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

package com.ares.generator.controller;


import com.ares.core.controller.BaseController;
import com.ares.core.model.base.AjaxResult;
import com.ares.core.model.page.TableDataInfo;
import com.ares.core.utils.DateUtils;
import com.ares.core.utils.ServletUtils;
import com.ares.generator.service.IAutoGeneratorService;
import com.ares.generator.service.IGeneratorService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @description:
 * @author: Young 2020/05/12
 **/
@RestController
@RequestMapping("/tool/gen/*")
@Tag(name = "GeneratorApiController", description = "代码生成API")
public class GeneratorApiController extends BaseController {

    private IGeneratorService generatorService;
    private IAutoGeneratorService autoGeneratorService;

    @Autowired
    public GeneratorApiController(IGeneratorService generatorService, IAutoGeneratorService autoGeneratorService) {
        this.generatorService = generatorService;
        this.autoGeneratorService = autoGeneratorService;
    }

    @GetMapping("db/list")
    @Operation(summary = "表信息", responses = {@ApiResponse(content = @Content(schema = @Schema(implementation = TableDataInfo.class)))})
    public TableDataInfo dataList(HttpServletRequest request, HttpServletResponse response) {
        Map<String, Object> map = new HashMap<>();
        map.put("tableName", ServletUtils.getParameter("tableName"));
        map.put("tableComment", ServletUtils.getParameter("tableComment"));
        map.put("beginTime", ServletUtils.getParameter("beginTime"));
        map.put("endTime", ServletUtils.getParameter("endTime"));
        String flag = ServletUtils.getParameter("flag");
        startPage();
        List<Map<String, Object>> list = generatorService.tables(flag, map);
        return getDataTable(list);
    }

    @GetMapping(value = "column/{flag}/{tableName}")
    @Operation(summary = "根据表获取字段", responses = {@ApiResponse(content = @Content(schema = @Schema(implementation = TableDataInfo.class)))})
    public TableDataInfo columnList(@PathVariable("flag") String flag,
                                    @PathVariable("tableName") String tableName) {
        TableDataInfo dataInfo = new TableDataInfo();
        List<Map<String, Object>> list = generatorService.selectTableColumnListByTableName(flag, tableName);
        dataInfo.setRows(list);
        dataInfo.setTotal(list.size());
        return dataInfo;
    }

    @GetMapping("genCode/{flag}/{tableName}")
    @Operation(summary = "生成代码", responses = {@ApiResponse(content = @Content(schema = @Schema(implementation = TableDataInfo.class)))})
    public void genCode(HttpServletResponse response, @PathVariable("flag") String flag, @PathVariable("tableName") String tableName) throws IOException {
        byte[] data = autoGeneratorService.generator(flag, tableName);
        genCode(response, data, tableName);
    }

    /**
     * 生成zip文件
     */
    private void genCode(HttpServletResponse response, byte[] data, String tableName) throws IOException {
        String date = DateUtils.dateTimeNow();
        response.reset();
        response.setHeader("Content-Disposition", "attachment; filename=" + tableName + "_" + date + ".zip\"");
        response.addHeader("Content-Length", "" + data.length);
        response.setContentType("application/octet-stream; charset=UTF-8");
        IOUtils.write(data, response.getOutputStream());
    }

    @GetMapping("preview/{flag}/{tableName}")
    @Operation(summary = "预览代码", responses = {@ApiResponse(content = @Content(schema = @Schema(implementation = TableDataInfo.class)))})
    public Object preview(HttpServletResponse response, @PathVariable("flag") String flag, @PathVariable("tableName") String tableName) throws IOException {
        return AjaxResult.successData(generatorService.preview(flag, tableName));
    }
}
