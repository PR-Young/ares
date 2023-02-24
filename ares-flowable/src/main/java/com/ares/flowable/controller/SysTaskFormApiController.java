package com.ares.flowable.controller;

import cn.dev33.satoken.annotation.SaCheckPermission;
import com.ares.core.common.security.SecurityUtils;
import com.ares.core.controller.BaseController;
import com.ares.core.model.base.AjaxResult;
import com.ares.core.model.page.TableDataInfo;
import com.ares.core.utils.StringUtils;
import com.ares.flowable.persistence.model.SysTaskForm;
import com.ares.flowable.persistence.service.ISysTaskFormService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.Arrays;
import java.util.List;


@RestController
@RequestMapping("/sysTaskForm/*")
@Api(value = "API", tags = {"管理"})
public class SysTaskFormApiController extends BaseController {

    private ISysTaskFormService sysTaskFormService;

    @Autowired
    public SysTaskFormApiController(ISysTaskFormService sysTaskFormService) {
        this.sysTaskFormService = sysTaskFormService;
    }

    @SaCheckPermission("sysTaskForm:list")
    @RequestMapping("list")
    @ApiOperation(value = "列表", response = TableDataInfo.class)
    public TableDataInfo list(SysTaskForm sysTaskForm) {
        startPage();
        List<SysTaskForm> sysTaskFormList = sysTaskFormService.list(sysTaskForm);
        return getDataTable(sysTaskFormList);
    }

    @GetMapping("{sysTaskFormId}")
    @ApiOperation(value = "根据Id获取信息", response = Object.class)
    public Object getInfo(@PathVariable String sysTaskFormId) {
        return AjaxResult.successData(sysTaskFormService.getById(sysTaskFormId));
    }

    @SaCheckPermission("sysTaskForm:edit")
    @PostMapping("edit")
    @ApiOperation(value = "编辑信息", response = Object.class)
    public Object edit(@Validated @RequestBody SysTaskForm sysTaskForm) throws Exception {
        if (StringUtils.isEmpty(sysTaskForm.getId())) {
            sysTaskForm.setCreator(SecurityUtils.getUser().getId());
            sysTaskFormService.insert(sysTaskForm);
        } else {
            sysTaskForm.setModifier(SecurityUtils.getUser().getId());
            sysTaskFormService.update(sysTaskForm);
        }
        return AjaxResult.success();
    }

    @SaCheckPermission("sysTaskForm:delete")
    @DeleteMapping("{sysTaskFormIds}")
    @ApiOperation(value = "删除信息", response = Object.class)
    public Object remove(@PathVariable String[] sysTaskFormIds) {
        sysTaskFormService.deleteByIds(Arrays.asList(sysTaskFormIds));
        return AjaxResult.success();
    }
}
