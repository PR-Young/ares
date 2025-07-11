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
import cn.dev33.satoken.stp.StpUtil;
import com.alibaba.excel.EasyExcel;
import com.alibaba.excel.event.AnalysisEventListener;
import com.ares.core.common.security.SecurityUtils;
import com.ares.core.controller.BaseController;
import com.ares.core.listener.UserDataListener;
import com.ares.core.model.base.AjaxResult;
import com.ares.core.model.base.Constants;
import com.ares.core.model.page.TableDataInfo;
import com.ares.core.model.query.SysUserQuery;
import com.ares.core.model.vo.SysUser;
import com.ares.core.service.ISysPostService;
import com.ares.core.service.ISysRoleService;
import com.ares.core.service.ISysUserService;
import com.ares.core.utils.ExcelUtils;
import com.ares.core.utils.StringUtils;
import com.ares.redis.utils.RedisUtil;
import com.github.pagehelper.PageInfo;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.InputStream;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

/**
 * @description: 用户
 * @author: Young 2020/05/05
 **/
@Slf4j
@RestController
@RequestMapping("/system/user/*")
@Tag(name = "SysUserApiController", description = "系统用户API")
public class SysUserApiController extends BaseController {

    private ISysUserService userService;
    private ISysRoleService roleService;
    private ISysPostService postService;

    @Autowired
    public SysUserApiController(ISysUserService userService,
                                ISysRoleService roleService,
                                ISysPostService postService) {
        this.userService = userService;
        this.roleService = roleService;
        this.postService = postService;
    }

    @SaCheckPermission("user:list")
    @GetMapping("list")
    @Operation(summary = "用户列表", parameters = {@Parameter(schema = @Schema(name = "SysUserQuery"))}, responses = {@ApiResponse(content = @Content(schema = @Schema(implementation = TableDataInfo.class)))})
    public TableDataInfo list(SysUserQuery user) {
        startPage();
        PageInfo<SysUser> userList = userService.list(user);
        return getDataTable(userList);
    }

    @GetMapping(value = {"", "{userId}"})
    @Operation(summary = "根据用户Id获取用户", responses = {@ApiResponse(content = @Content(schema = @Schema(implementation = Object.class)))})
    public Object getInfo(@PathVariable(value = "userId", required = false) Long userId) {
        AjaxResult result = new AjaxResult();
        result.put("code", HttpStatus.OK.value());
        result.put("data", userService.getById(userId));
        result.put("roles", roleService.getAll());
        result.put("posts", postService.getAll());
        if (StringUtils.isNotEmpty(userId)) {
            result.put("roleIds", roleService.getRoleIdsByUser(userId));
        }
        return result;
    }

    @SaCheckPermission("user:edit")
    @PostMapping("edit")
    @Operation(summary = "新增/修改用户", responses = {@ApiResponse(content = @Content(schema = @Schema(implementation = Object.class)))})
    public Object edit(@Validated @RequestBody SysUser user) throws Exception {
        Long userId = null;
        if (StringUtils.isEmpty(user.getId())) {
            if (userService.checkAccount(user.getAccount()) != 0) {
                return AjaxResult.error("新增用户'" + user.getUserName() + "'失败，登录账号已存在");
            }
            user.setCreator(SecurityUtils.getUser().getId());
            userId = userService.insertUser(user);
        } else {
            userId = user.getId();
            user.setModifier(SecurityUtils.getUser().getId());
            userService.update(user);
        }
        if (StringUtils.isNotEmpty(user.getRoleIds())) {
            roleService.saveRoleUser(user.getRoleIds(), userId);
        }
        return AjaxResult.success();
    }

    @SaCheckPermission("user:delete")
    @DeleteMapping("{userIds}")
    @Operation(summary = "删除用户", responses = {@ApiResponse(content = @Content(schema = @Schema(implementation = Object.class)))})
    public Object remove(@PathVariable Long[] userIds) {
        userService.deleteByIds(Arrays.asList(userIds));
        return AjaxResult.success();
    }

    /**
     * 重置密码
     */
    @PutMapping("resetPwd")
    @Operation(summary = "重置密码", responses = {@ApiResponse(content = @Content(schema = @Schema(implementation = Object.class)))})
    public Object resetPwd(@RequestBody SysUser user) {
        userService.resetPassword(user.getId());
        return AjaxResult.success();
    }

    @GetMapping("export")
    @Operation(summary = "导出用户")
    public void export(SysUserQuery user, HttpServletResponse response) {
        List<SysUser> userList = userService.selectUserList(user);
        String fileName = "用户信息" + System.currentTimeMillis();
        String sheetName = "用户";
        try {
            ExcelUtils.writeExcel(response, userList, fileName, sheetName, SysUser.class);
        } catch (Exception e) {
            log.error("export error: ", e);
        }
    }

    @GetMapping("importTemplate")
    @Operation(summary = "导入模版")
    public void importTemplate(HttpServletResponse response) {
        List<SysUser> userList = new ArrayList<>();
        String fileName = "用户信息模版" + System.currentTimeMillis();
        String sheetName = "用户";
        try {
            ExcelUtils.writeExcel(response, userList, fileName, sheetName, SysUser.class);
        } catch (Exception e) {
            log.error("importTemplate error: ", e);
        }
    }

    @PostMapping("importData")
    @SaCheckPermission("user:import")
    @Operation(summary = "导入用户")
    public Object importData(MultipartFile file, HttpServletRequest request) throws Exception {
        InputStream inputStream = file.getInputStream();
        boolean needUpdate = "1".equals(request.getParameter("updateSupport"));
        Long deptId = Long.valueOf(request.getParameter("deptId"));
        AnalysisEventListener listener = new UserDataListener(needUpdate, deptId);
        EasyExcel.read(inputStream, SysUser.class, listener).sheet().doRead();
        return AjaxResult.success("导入成功");
    }

    @PostMapping("kick")
    @Operation(summary = "下线", responses = {@ApiResponse(content = @Content(schema = @Schema(implementation = Object.class)))})
    public Object kickUser(@RequestParam("username") String userName) {
        SysUser user = userService.getUserByName(userName);
        RedisUtil.del(Constants.LOGIN_INFO + userName);
        StpUtil.kickout(user.getId());
        return AjaxResult.success();
    }
}
