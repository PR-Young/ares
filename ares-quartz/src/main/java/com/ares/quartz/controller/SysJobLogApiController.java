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

package com.ares.quartz.controller;


import cn.dev33.satoken.annotation.SaCheckPermission;
import com.ares.core.controller.BaseController;
import com.ares.core.model.base.AjaxResult;
import com.ares.core.model.page.TableDataInfo;
import com.ares.quartz.model.query.SysQuartzJobLogQuery;
import com.ares.quartz.model.vo.SysQuartzJobLog;
import com.ares.quartz.service.ISysQuartzJobLogService;
import com.github.pagehelper.PageInfo;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.Arrays;

/**
 * @description: 任务日志
 * @author: Young 2020/05/07
 **/
@RestController
@RequestMapping("/monitor/jobLog/*")
@Tag(name = "SysJobLogApiController", description = "系统任务日志API")
public class SysJobLogApiController extends BaseController {

    private ISysQuartzJobLogService jobLogService;

    @Autowired
    public SysJobLogApiController(ISysQuartzJobLogService jobLogService) {
        this.jobLogService = jobLogService;
    }

    @SaCheckPermission("quartz:logList")
    @GetMapping("list")
    @Operation(summary = "任务日志列表", responses = {@ApiResponse(content = @Content(schema = @Schema(implementation = TableDataInfo.class)))})
    public TableDataInfo list(SysQuartzJobLogQuery jobLog) {
        startPage();
        PageInfo<SysQuartzJobLog> list = jobLogService.list(jobLog);
        return getDataTable(list);
    }

    /**
     * 根据调度编号获取详细信息
     */
    @GetMapping(value = "{jobLogId}")
    @Operation(summary = "根据调度编号获取详细信息", responses = {@ApiResponse(content = @Content(schema = @Schema(implementation = Object.class)))})
    public Object getInfo(@PathVariable Long jobLogId) {
        return AjaxResult.successData(jobLogService.getById(jobLogId));
    }


    /**
     * 删除定时任务调度日志
     */
    @SaCheckPermission("quartz:logDelete")
    @DeleteMapping("{jobLogIds}")
    @Operation(summary = "删除定时任务调度日志", responses = {@ApiResponse(content = @Content(schema = @Schema(implementation = Object.class)))})
    public Object remove(@PathVariable Long[] jobLogIds) {
        jobLogService.deleteByIds(Arrays.asList(jobLogIds));
        return AjaxResult.success();
    }

    @SaCheckPermission("quartz:logDelete")
    @DeleteMapping("clean")
    @Operation(summary = "清空定时任务调度日志", responses = {@ApiResponse(content = @Content(schema = @Schema(implementation = Object.class)))})
    public Object clean() {
        jobLogService.cleanJobLog();
        return AjaxResult.success();
    }
}
