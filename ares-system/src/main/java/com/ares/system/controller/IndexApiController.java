package com.ares.system.controller;

import com.ares.core.persistence.model.base.AjaxResult;
import com.ares.system.persistence.service.IndexService;
import io.swagger.annotations.Api;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;

/**
 * @description:
 * @author: Young
 * @date: 2020/09/14
 * @see: com.ares.system.controller IndexApiController.java
 **/
@Slf4j
@RestController
@RequestMapping("/index/*")
@Api(value = "index", tags = {"index"})
public class IndexApiController {

    @Resource
    private IndexService indexService;

    @GetMapping("panelGroup")
    public Object getPanelGroup() {
        return AjaxResult.successData(indexService.getPanelGroup());
    }

    @GetMapping("lineChartData")
    public Object getLineChartData() {
        return AjaxResult.successData(indexService.getLineChartData());
    }
}
