package com.ares.flowable.controller;

import cn.dev33.satoken.annotation.SaCheckPermission;
import com.ares.core.common.security.SecurityUtils;
import com.ares.core.controller.BaseController;
import com.ares.core.model.base.AjaxResult;
import com.ares.core.model.page.TableDataInfo;
import com.ares.core.utils.StringUtils;
import com.ares.flowable.persistence.model.SysDeployForm;
import com.ares.flowable.persistence.service.ISysDeployFormService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.Arrays;
import java.util.List;


@RestController
@RequestMapping("/sysDeployForm/*")
@Api(value = "API", tags = {"管理"})
public class SysDeployFormApiController extends BaseController {

    private ISysDeployFormService sysDeployFormService;

    @Autowired
    public SysDeployFormApiController(ISysDeployFormService sysDeployFormService) {
        this.sysDeployFormService = sysDeployFormService;
    }

    @SaCheckPermission("sysDeployForm:list")
    @RequestMapping("list")
    @ApiOperation(value = "列表", response = TableDataInfo.class)
    public TableDataInfo list(SysDeployForm sysDeployForm) {
        startPage();
        List<SysDeployForm> sysDeployFormList = sysDeployFormService.list(sysDeployForm);
        return getDataTable(sysDeployFormList);
    }

    @GetMapping("{sysDeployFormId}")
    @ApiOperation(value = "根据Id获取信息", response = Object.class)
    public Object getInfo(@PathVariable String sysDeployFormId) {
        return AjaxResult.successData(sysDeployFormService.getById(sysDeployFormId));
    }

    @SaCheckPermission("sysDeployForm:edit")
    @PostMapping("edit")
    @ApiOperation(value = "编辑信息", response = Object.class)
    public Object edit(@Validated @RequestBody SysDeployForm sysDeployForm) throws Exception {
        if (StringUtils.isEmpty(sysDeployForm.getId())) {
            sysDeployForm.setCreator(SecurityUtils.getUser().getId());
            sysDeployFormService.insert(sysDeployForm);
        } else {
            sysDeployForm.setModifier(SecurityUtils.getUser().getId());
            sysDeployFormService.update(sysDeployForm);
        }
        return AjaxResult.success();
    }

    @SaCheckPermission("sysDeployForm:delete")
    @DeleteMapping("{sysDeployFormIds}")
    @ApiOperation(value = "删除信息", response = Object.class)
    public Object remove(@PathVariable String[] sysDeployFormIds) {
        sysDeployFormService.deleteByIds(Arrays.asList(sysDeployFormIds));
        return AjaxResult.success();
    }
}
