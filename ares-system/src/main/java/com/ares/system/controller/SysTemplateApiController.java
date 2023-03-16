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

package com.ares.system.controller;


import cn.dev33.satoken.annotation.SaCheckPermission;
import com.ares.core.common.security.SecurityUtils;
import com.ares.core.controller.BaseController;
import com.ares.core.model.base.AjaxResult;
import com.ares.core.model.page.TableDataInfo;
import com.ares.core.persistence.model.SysTemplate;
import com.ares.core.persistence.service.ISysTemplateService;
import com.ares.core.utils.StringUtils;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.Arrays;
import java.util.List;

/**
 * @description: 模版
 * @author: Young
 */
@RestController
@RequestMapping("/sysTemplate/*")
@Api(value = "系统模版API", tags = {"系统模版"})
public class SysTemplateApiController extends BaseController {

    private ISysTemplateService sysTemplateService;

    @Autowired
    public SysTemplateApiController(ISysTemplateService sysTemplateService) {
        this.sysTemplateService = sysTemplateService;
    }

    @SaCheckPermission("sysTemplate:list")
    @RequestMapping("list")
    @ApiOperation(value = "模版列表", response = TableDataInfo.class)
    public TableDataInfo list(SysTemplate sysTemplate) {
        startPage();
        List<SysTemplate> sysTemplateList = sysTemplateService.list(sysTemplate);
        return getDataTable(sysTemplateList);
    }

    @GetMapping("{sysTemplateId}")
    @ApiOperation(value = "根据模版Id获取模版", response = Object.class)
    public Object getInfo(@PathVariable String sysTemplateId) {
        return AjaxResult.successData(sysTemplateService.getById(sysTemplateId));
    }

    @SaCheckPermission("sysTemplate:edit")
    @PostMapping("edit")
    @ApiOperation(value = "新增/修改模版", response = Object.class)
    public Object edit(@Validated @RequestBody SysTemplate sysTemplate) throws Exception {
        if (StringUtils.isEmpty(sysTemplate.getId())) {
            sysTemplate.setCreator(SecurityUtils.getUser().getId());
            sysTemplateService.insert(sysTemplate);
        } else {
            sysTemplate.setModifier(SecurityUtils.getUser().getId());
            sysTemplateService.update(sysTemplate);
        }
        return AjaxResult.success();
    }

    @SaCheckPermission("sysTemplate:delete")
    @DeleteMapping("{sysTemplateIds}")
    @ApiOperation(value = "删除模版", response = Object.class)
    public Object remove(@PathVariable String[] sysTemplateIds) {
        sysTemplateService.deleteByIds(Arrays.asList(sysTemplateIds));
        return AjaxResult.success();
    }
}
