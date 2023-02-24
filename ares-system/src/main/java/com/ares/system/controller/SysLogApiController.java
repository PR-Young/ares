package com.ares.system.controller;

import cn.dev33.satoken.annotation.SaCheckPermission;
import com.ares.core.controller.BaseController;
import com.ares.core.model.page.TableDataInfo;
import com.ares.core.persistence.model.SysLog;
import com.ares.core.persistence.service.ISysLogService;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

/**
 * @description:
 * @author: Young
 * @date: 2022/1/10
 * @see: com.ares.system.controller.SysLogApiController.java
 **/
@RequestMapping("/system/log/*")
@RestController
public class SysLogApiController extends BaseController {

    private ISysLogService sysLogService;

    @Autowired
    public SysLogApiController(ISysLogService sysLogService) {
        this.sysLogService = sysLogService;
    }

    @SaCheckPermission("log:list")
    @RequestMapping("list")
    @ApiOperation(value = "操作日志列表", response = TableDataInfo.class)
    public TableDataInfo list(SysLog sysLog) {
        startPage();
        List<SysLog> sysLogList = sysLogService.list(sysLog);
        return getDataTable(sysLogList);
    }
}
