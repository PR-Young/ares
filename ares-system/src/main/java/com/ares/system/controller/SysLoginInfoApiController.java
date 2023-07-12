/*
 *
 *  * !******************************************************************************
 *  *  * Copyright (c) 2021 - 9999, ARES
 *  *  *
 *  *  * Licensed under the Apache License, Version 2.0 (the "License");
 *  *  * you may not use this file except in compliance with the License.
 *  *  * You may obtain a copy of the License at
 *  *  *
 *  *  *        http://www.apache.org/licenses/LICENSE-2.0
 *  *  *
 *  *  * Unless required by applicable law or agreed to in writing, software
 *  *  * distributed under the License is distributed on an "AS IS" BASIS,
 *  *  * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  *  * See the License for the specific language governing permissions and
 *  *  * limitations under the License.
 *  *  *****************************************************************************
 *
 */

package com.ares.system.controller;

import cn.dev33.satoken.annotation.SaCheckPermission;
import com.ares.core.controller.BaseController;
import com.ares.core.model.base.AjaxResult;
import com.ares.core.model.page.TableDataInfo;
import com.ares.core.persistence.model.SysLoginInfo;
import com.ares.core.persistence.service.ISysLoginInfoService;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.Arrays;
import java.util.List;


@RestController
@RequestMapping("/sysLoginInfo/*")
@Api(value = "API", tags = {"管理"})
public class SysLoginInfoApiController extends BaseController {

    private ISysLoginInfoService sysLoginInfoService;

    @Autowired
    public SysLoginInfoApiController(ISysLoginInfoService sysLoginInfoService) {
        this.sysLoginInfoService = sysLoginInfoService;
    }

    @SaCheckPermission("sysLoginInfo:list")
    @RequestMapping("list")
    @ApiOperation(value = "列表", response = TableDataInfo.class)
    public TableDataInfo list(SysLoginInfo sysLoginInfo) {
        startPage();
        QueryWrapper<SysLoginInfo> wrapper = new QueryWrapper<>();
        if (!"".equals(sysLoginInfo.getBeginTime()) && !"".equals(sysLoginInfo.getEndTime())) {
            wrapper.gt("create_time", sysLoginInfo.getBeginTime());
            wrapper.lt("create_time", sysLoginInfo.getEndTime());
        }
        if (null != sysLoginInfo.getIpAddr()) {
            wrapper.like("ip_addr", sysLoginInfo.getIpAddr());
        }
        if (null != sysLoginInfo.getUserName()) {
            wrapper.like("user_name", sysLoginInfo.getUserName());
        }
        if (null != sysLoginInfo.getStatus()) {
            wrapper.eq("status", sysLoginInfo.getStatus());
        }
        List<SysLoginInfo> sysLoginInfoList = sysLoginInfoService.list(wrapper);
        return getDataTable(sysLoginInfoList);
    }

    @GetMapping("{sysLoginInfoId}")
    @ApiOperation(value = "根据Id获取信息", response = Object.class)
    public Object getInfo(@PathVariable String sysLoginInfoId) {
        return AjaxResult.successData(sysLoginInfoService.getById(sysLoginInfoId));
    }

    @SaCheckPermission("sysLoginInfo:edit")
    @PostMapping("edit")
    @ApiOperation(value = "编辑信息", response = Object.class)
    public Object edit(@Validated @RequestBody SysLoginInfo sysLoginInfo) throws Exception {
        sysLoginInfoService.saveOrUpdate(sysLoginInfo);
        return AjaxResult.success();
    }

    @SaCheckPermission("sysLoginInfo:delete")
    @DeleteMapping("{sysLoginInfoIds}")
    @ApiOperation(value = "删除信息", response = Object.class)
    public Object remove(@PathVariable String[] sysLoginInfoIds) {
        sysLoginInfoService.removeByIds(Arrays.asList(sysLoginInfoIds));
        return AjaxResult.success();
    }

    @SaCheckPermission("sysLoginInfo:clean")
    @DeleteMapping("clean")
    @ApiOperation(value = "删除信息", response = Object.class)
    public Object clean() {
        sysLoginInfoService.remove(null);
        return AjaxResult.success();
    }
}
