package com.ares.quartz.controller;


import cn.dev33.satoken.annotation.SaCheckPermission;
import com.ares.core.controller.BaseController;
import com.ares.core.persistence.model.base.AjaxResult;
import com.ares.core.persistence.model.page.TableDataInfo;
import com.ares.quartz.persistence.model.SysQuartzJobLog;
import com.ares.quartz.persistence.service.SysQuartzJobLogService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.Arrays;
import java.util.List;

/**
 * @description: 任务日志
 * @author: Young 2020/05/07
 **/
@RestController
@RequestMapping("/monitor/jobLog/*")
@Api(value = "系统任务日志API", tags = {"系统任务日志"})
public class SysJobLogApiController extends BaseController {

    private SysQuartzJobLogService jobLogService;

    @Autowired
    public SysJobLogApiController(SysQuartzJobLogService jobLogService) {
        this.jobLogService = jobLogService;
    }

    @SaCheckPermission("quartz:logList")
    @GetMapping("list")
    @ApiOperation(value = "任务日志列表", response = TableDataInfo.class)
    public TableDataInfo list(SysQuartzJobLog jobLog) {
        startPage();
        List<SysQuartzJobLog> list = jobLogService.selectJobLogList(jobLog);
        return getDataTable(list);
    }

    /**
     * 根据调度编号获取详细信息
     */
    @GetMapping(value = "{jobLogId}")
    @ApiOperation(value = "根据调度编号获取详细信息", response = Object.class)
    public Object getInfo(@PathVariable String jobLogId) {
        return AjaxResult.successData(jobLogService.getById(jobLogId));
    }


    /**
     * 删除定时任务调度日志
     */
    @SaCheckPermission("quartz:logDelete")
    @DeleteMapping("{jobLogIds}")
    @ApiOperation(value = "删除定时任务调度日志", response = Object.class)
    public Object remove(@PathVariable String[] jobLogIds) {
        jobLogService.deleteByIds(Arrays.asList(jobLogIds));
        return AjaxResult.success();
    }

    @SaCheckPermission("quartz:logDelete")
    @DeleteMapping("clean")
    @ApiOperation(value = "清空定时任务调度日志", response = Object.class)
    public Object clean() {
        jobLogService.cleanJobLog();
        return AjaxResult.success();
    }
}
