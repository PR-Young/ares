package com.ares.flowable.controller;

import cn.dev33.satoken.annotation.SaCheckPermission;
import com.ares.core.common.security.SecurityUtils;
import com.ares.core.controller.BaseController;
import com.ares.core.persistence.model.base.AjaxResult;
import com.ares.core.persistence.model.page.TableDataInfo;
import com.ares.core.utils.StringUtils;
import com.ares.flowable.persistence.model.SysFormData;
import com.ares.flowable.persistence.service.SysFormDataService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.Arrays;
import java.util.List;


@RestController
@RequestMapping("/sysFormData/*")
@Api(value = "API", tags = {"管理"})
public class SysFormDataApiController extends BaseController {

    private SysFormDataService sysFormDataService;

    @Autowired
    public SysFormDataApiController(SysFormDataService sysFormDataService) {
        this.sysFormDataService = sysFormDataService;
    }

    @SaCheckPermission("sysFormData:list")
    @RequestMapping("list")
    @ApiOperation(value = "列表", response = TableDataInfo.class)
    public TableDataInfo list(SysFormData sysFormData) {
        startPage();
        List<SysFormData> sysFormDataList = sysFormDataService.list(sysFormData);
        return getDataTable(sysFormDataList);
    }

    @GetMapping("{sysFormDataId}")
    @ApiOperation(value = "根据Id获取信息", response = Object.class)
    public Object getInfo(@PathVariable String sysFormDataId) {
        return AjaxResult.successData(sysFormDataService.getById(sysFormDataId));
    }

    @SaCheckPermission("sysFormData:edit")
    @PostMapping("edit")
    @ApiOperation(value = "编辑信息", response = Object.class)
    public Object edit(@Validated @RequestBody SysFormData sysFormData) throws Exception {
        if (StringUtils.isEmpty(sysFormData.getId())) {
            sysFormData.setCreator(SecurityUtils.getUser().getId());
            sysFormDataService.insert(sysFormData);
        } else {
            sysFormData.setModifier(SecurityUtils.getUser().getId());
            sysFormDataService.update(sysFormData);
        }
        return AjaxResult.success();
    }

    @SaCheckPermission("sysFormData:delete")
    @DeleteMapping("{sysFormDataIds}")
    @ApiOperation(value = "删除信息", response = Object.class)
    public Object remove(@PathVariable String[] sysFormDataIds) {
        sysFormDataService.deleteByIds(Arrays.asList(sysFormDataIds));
        return AjaxResult.success();
    }

    @GetMapping("getFormData/{proInstId}")
    @ApiOperation(value = "根据proInstId获取信息", response = Object.class)
    public Object getFormData(@PathVariable String proInstId) {
        return AjaxResult.successData(sysFormDataService.getFormDataByProInstId(proInstId));
    }
}
