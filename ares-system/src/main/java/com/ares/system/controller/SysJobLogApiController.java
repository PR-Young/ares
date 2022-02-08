package com.ares.system.controller;


import com.ares.core.controller.BaseController;
import com.ares.core.persistence.model.base.AjaxResult;
import com.ares.core.persistence.model.page.TableDataInfo;
import com.ares.quartz.persistence.model.SysQuartzJobLog;
import com.ares.quartz.persistence.service.SysQuartzJobLogService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.Arrays;
import java.util.List;

/**
 * @description:
 * @author: Young 2020/05/07
 **/
@RestController
@RequestMapping("/monitor/jobLog/*")
@Api(value = "系统任务日志API", tags = {"系统任务日志"})
public class SysJobLogApiController extends BaseController {

    @Resource
    SysQuartzJobLogService jobLogService;

    @RequiresPermissions("quartz:logList")
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
    @RequiresPermissions("quartz:logDelete")
    @DeleteMapping("{jobLogIds}")
    @ApiOperation(value = "删除定时任务调度日志", response = Object.class)
    public Object remove(@PathVariable String[] jobLogIds) {
        jobLogService.deleteByIds(Arrays.asList(jobLogIds));
        return AjaxResult.success();
    }

    @RequiresPermissions("quartz:logDelete")
    @DeleteMapping("clean")
    @ApiOperation(value = "清空定时任务调度日志", response = Object.class)
    public Object clean() {
        jobLogService.cleanJobLog();
        return AjaxResult.success();
    }
}
