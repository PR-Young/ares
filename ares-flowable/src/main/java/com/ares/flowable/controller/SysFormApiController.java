package com.ares.flowable.controller;

import cn.dev33.satoken.annotation.SaCheckPermission;
import com.ares.core.common.security.SecurityUtils;
import com.ares.core.controller.BaseController;
import com.ares.core.model.base.AjaxResult;
import com.ares.core.model.page.TableDataInfo;
import com.ares.core.utils.StringUtils;
import com.ares.flowable.persistence.model.SysDeployForm;
import com.ares.flowable.persistence.model.SysForm;
import com.ares.flowable.persistence.service.ISysDeployFormService;
import com.ares.flowable.persistence.service.ISysFormService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.Arrays;
import java.util.List;


@RestController
@RequestMapping("/sysForm/*")
@Api(value = "API", tags = {"管理"})
public class SysFormApiController extends BaseController {

    private ISysFormService sysFormService;
    private ISysDeployFormService deployFormService;

    @Autowired
    public SysFormApiController(ISysFormService sysFormService, ISysDeployFormService deployFormService) {
        this.sysFormService = sysFormService;
        this.deployFormService = deployFormService;
    }

    @SaCheckPermission("sysForm:list")
    @RequestMapping("list")
    @ApiOperation(value = "列表", response = TableDataInfo.class)
    public TableDataInfo list(SysForm sysForm) {
        startPage();
        List<SysForm> sysFormList = sysFormService.list(sysForm);
        return getDataTable(sysFormList);
    }

    @GetMapping("{sysFormId}")
    @ApiOperation(value = "根据Id获取信息", response = Object.class)
    public Object getInfo(@PathVariable String sysFormId) {
        return AjaxResult.successData(sysFormService.getById(sysFormId));
    }

    @SaCheckPermission("sysForm:edit")
    @PostMapping("edit")
    @ApiOperation(value = "编辑信息", response = Object.class)
    public Object edit(@Validated @RequestBody SysForm sysForm) throws Exception {
        if (StringUtils.isEmpty(sysForm.getId())) {
            sysForm.setCreator(SecurityUtils.getUser().getId());
            sysFormService.insert(sysForm);
        } else {
            sysForm.setModifier(SecurityUtils.getUser().getId());
            sysFormService.update(sysForm);
        }
        return AjaxResult.success();
    }

    @SaCheckPermission("sysForm:delete")
    @DeleteMapping("{sysFormIds}")
    @ApiOperation(value = "删除信息", response = Object.class)
    public Object remove(@PathVariable String[] sysFormIds) {
        sysFormService.deleteByIds(Arrays.asList(sysFormIds));
        return AjaxResult.success();
    }

    /**
     * 挂载流程表单
     */
    @ApiOperation(value = "流程表单", response = Object.class)
    @PostMapping("/addDeployForm")
    public Object addDeployForm(@RequestBody SysDeployForm sysDeployForm) {
        deployFormService.insert(sysDeployForm);
        return AjaxResult.success();
    }
}
