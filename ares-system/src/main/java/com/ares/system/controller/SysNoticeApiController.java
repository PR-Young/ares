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
import com.ares.core.common.exception.UserException;
import com.ares.core.common.security.SecurityUtils;
import com.ares.core.controller.BaseController;
import com.ares.core.model.base.AjaxResult;
import com.ares.core.model.page.TableDataInfo;
import com.ares.core.model.query.SysNoticeQuery;
import com.ares.core.model.vo.SysNotice;
import com.ares.core.service.ISysNoticeService;
import com.ares.core.utils.StringUtils;
import com.ares.system.websocket.WebSocketServer;
import com.github.pagehelper.PageInfo;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.Arrays;

/**
 * @description: 通知
 * @author: Young
 */
@RestController
@RequestMapping("/system/notice/*")
@Tag(name = "SysNoticeApiController", description = "通知公告API")
public class SysNoticeApiController extends BaseController {

    private ISysNoticeService sysNoticeService;

    @Autowired
    public SysNoticeApiController(ISysNoticeService sysNoticeService) {
        this.sysNoticeService = sysNoticeService;
    }

    @SaCheckPermission("notice:list")
    @GetMapping("list")
    @Operation(summary = "通知公告列表", responses = {@ApiResponse(content = @Content(schema = @Schema(implementation = TableDataInfo.class)))})
    public TableDataInfo list(SysNoticeQuery sysNotice) {
        startPage();
        PageInfo<SysNotice> sysNoticeList = sysNoticeService.list(sysNotice);
        return getDataTable(sysNoticeList);
    }

    @GetMapping("{noticeId}")
    @Operation(summary = "根据Id获取通知公告", responses = {@ApiResponse(content = @Content(schema = @Schema(implementation = Object.class)))})
    public Object getInfo(@PathVariable Long noticeId) {
        return AjaxResult.successData(sysNoticeService.getById(noticeId));
    }

    @SaCheckPermission("notice:edit")
    @PostMapping("edit")
    @Operation(summary = "新增/修改通知公告", responses = {@ApiResponse(content = @Content(schema = @Schema(implementation = Object.class)))})
    public Object edit(@Validated @RequestBody SysNotice sysNotice) throws Exception {
        if (StringUtils.isEmpty(sysNotice.getId())) {
            sysNotice.setCreator(SecurityUtils.getUser().getId());
            sysNoticeService.insert(sysNotice);
        } else {
            sysNotice.setModifier(SecurityUtils.getUser().getId());
            sysNoticeService.update(sysNotice);
        }
        WebSocketServer.sendNotice(true, SecurityUtils.getUser().getAccount());
        return AjaxResult.success();
    }

    @SaCheckPermission("notice:delete")
    @DeleteMapping("{noticeIds}")
    @Operation(summary = "删除通知公告", responses = {@ApiResponse(content = @Content(schema = @Schema(implementation = Object.class)))})
    public Object remove(@PathVariable Long[] noticeIds) {
        sysNoticeService.deleteByIds(Arrays.asList(noticeIds));
        return AjaxResult.success();
    }

    @GetMapping("noticeNum")
    @Operation(summary = "获取通知公告数量", responses = {@ApiResponse(content = @Content(schema = @Schema(implementation = Object.class)))})
    public Object noticeNum() throws UserException {
        return AjaxResult.successData(sysNoticeService.noticeNum(SecurityUtils.getUser().getId()));
    }

    @GetMapping("getNotices")
    @Operation(summary = "通知公告时间线", responses = {@ApiResponse(content = @Content(schema = @Schema(implementation = Object.class)))})
    public Object getNotices() throws Exception {
        WebSocketServer.sendInfo(String.valueOf(0), SecurityUtils.getUser().getAccount());
        return AjaxResult.successData(sysNoticeService.getNotices(SecurityUtils.getUser().getId()));
    }
}
