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


import cn.dev33.satoken.stp.StpUtil;
import com.ares.config.base.BaseConfig;
import com.ares.core.common.security.SecurityUtils;
import com.ares.core.model.base.AjaxResult;
import com.ares.core.model.base.Constants;
import com.ares.core.model.base.ResultCode;
import com.ares.core.persistence.model.SysLoginInfo;
import com.ares.core.persistence.model.SysMenu;
import com.ares.core.persistence.model.SysRole;
import com.ares.core.persistence.model.SysUser;
import com.ares.core.persistence.service.ISysLoginInfoService;
import com.ares.core.persistence.service.ISysMenuService;
import com.ares.core.persistence.service.ISysRoleService;
import com.ares.core.persistence.service.ISysUserService;
import com.ares.core.utils.AresCommonUtils;
import com.ares.core.utils.IpUtils;
import com.ares.core.utils.MD5Util;
import com.ares.core.utils.ServletUtils;
import com.ares.redis.utils.RedisUtil;
import com.wf.captcha.ArithmeticCaptcha;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.*;

/**
 * @description: 登录
 * @author: Young 2020/05/04
 **/
@RestController
@Tag(name = "LoginApiController", description = "系统登录API")
public class LoginApiController {
    private Logger logger = LoggerFactory.getLogger(LoginApiController.class);

    private String prefix = "";
    // token 过期时间一个月
    private static final long EXPIRE = 7 * 24 * 60 * 60;

    private ISysUserService userService;
    private ISysRoleService roleService;
    private ISysMenuService menuService;
    private BaseConfig config;
    private ISysLoginInfoService loginInfoService;

    @Autowired
    public LoginApiController(ISysUserService userService,
                              ISysRoleService roleService,
                              ISysMenuService menuService,
                              BaseConfig config,
                              ISysLoginInfoService loginInfoService
    ) {
        this.userService = userService;
        this.roleService = roleService;
        this.menuService = menuService;
        this.config = config;
        this.loginInfoService = loginInfoService;
    }

    @Operation(summary = "登录", responses = {@ApiResponse(content = @Content(schema = @Schema(implementation = Object.class)))})
    @PostMapping("/login")
    public Object login(HttpServletRequest request, HttpServletResponse response) throws Exception {
        Map<String, Object> map = ServletUtils.getParameter();
        String userName = String.valueOf(map.get("username"));
        String password = String.valueOf(map.get("password"));
        String code = String.valueOf(map.get("code"));
        String uuid = String.valueOf(map.get("uuid"));
        Boolean rememberMe = Boolean.parseBoolean(String.valueOf(map.get("rememberMe")));

        if (!AresCommonUtils.checkVerifyCode(code, uuid)) {
            return AjaxResult.error(ResultCode.CODEERROR.getCode(), ResultCode.CODEERROR.getMsg());
        }

        // 系统登录认证
        SysUser user = userService.getUserByName(userName);
        if (null == user) {
            return AjaxResult.error(ResultCode.NOUSER.getCode(), ResultCode.NOUSER.getMsg());
        }
        if (!user.getPassword().equals(MD5Util.encode(password))) {
            return AjaxResult.error(ResultCode.PWDERROR.getCode(), ResultCode.PWDERROR.getMsg());
        }
        StpUtil.login(user.getId());
        String token = StpUtil.getTokenValue();
        if (rememberMe) {
            RedisUtil.set(Constants.LOGIN_INFO + userName, token, EXPIRE);
        } else {
            RedisUtil.set(Constants.LOGIN_INFO + userName, token, config.getTimeout());
        }

        SysLoginInfo sysLoginInfo = new SysLoginInfo();
        sysLoginInfo.setUserName(user.getUserName());
        sysLoginInfo.setLoginTime(new Date());
        sysLoginInfo.setIpAddr(IpUtils.getIpAddr(request));
        sysLoginInfo.setStatus(Constants.ONLINE);
        sysLoginInfo.setBrowser(AresCommonUtils.getUserAgent(request, "browser"));
        sysLoginInfo.setOs(AresCommonUtils.getUserAgent(request, "os"));
        Long id = loginInfoService.saveInfo(sysLoginInfo);
        RedisUtil.set(token, id, 0);

        return AjaxResult.success().put("token", token);
    }


    @RequestMapping("/unAuth")
    @Operation(summary = "未登录", hidden = true, responses = {@ApiResponse(content = @Content(schema = @Schema(implementation = Object.class)))})
    public Object unAuth(HttpServletRequest request, HttpServletResponse response) {
        return AjaxResult.unLogin();
    }

    @RequestMapping("/unauthorized")
    @Operation(summary = "无权限", hidden = true, responses = {@ApiResponse(content = @Content(schema = @Schema(implementation = Object.class)))})
    public Object unauthorized(HttpServletRequest request, HttpServletResponse response) {
        return AjaxResult.error(HttpStatus.UNAUTHORIZED.value(), "用户无权限！");
    }

    @GetMapping("/getInfo")
    @Operation(summary = "获取登录信息", method = "GET", responses = {@ApiResponse(content = @Content(schema = @Schema(implementation = Object.class)))})
    public Object getInfo(HttpServletRequest request, HttpServletResponse response) throws Exception {
        SysUser user = SecurityUtils.getUser();
        List<SysRole> roleList = roleService.getRoleByUserId(user.getId());
        Set<String> roles = new HashSet<>();
        Set<String> permissions = new HashSet<>();
        for (SysRole role : roleList) {
            List<String> perms = new ArrayList<>();
            if ("gly".equalsIgnoreCase(role.getRoleName())) {
                perms = roleService.getPermsByRoleId(null);
            } else {
                perms = roleService.getPermsByRoleId(role.getId());
            }
            for (String perm : perms) {
                permissions.add(perm);
            }
            roles.add(role.getRoleName());
        }
        return AjaxResult.success().put("user", user).put("roles", roles).put("permissions", permissions);
    }

    @GetMapping("/getRouters")
    @Operation(summary = "获取路由", method = "GET", responses = {@ApiResponse(content = @Content(schema = @Schema(implementation = Object.class)))})
    public Object getRouters() throws Exception {
        SysUser user = SecurityUtils.getUser();
        List<SysMenu> menus = menuService.getAll(user.getId());
        return AjaxResult.successData(HttpStatus.OK.value(), menuService.buildMenus(menus, 0L));
    }

    @GetMapping("/kaptcha")
    @Operation(summary = "获取验证码", method = "GET", responses = {@ApiResponse(content = @Content(schema = @Schema(implementation = Object.class)))})
    public Object getKaptchaImage(HttpServletRequest request, HttpServletResponse response) throws Exception {
        ArithmeticCaptcha arithmeticCaptcha = new ArithmeticCaptcha(120, 40);
        String code = arithmeticCaptcha.text();
        String uuid = UUID.randomUUID().toString();
        RedisUtil.set(Constants.KAPTCHA_SESSION_KEY + uuid, code, 120);
        return AjaxResult.success().put("uuid", uuid).put("img", arithmeticCaptcha.toBase64());
    }

    @PostMapping("/logout")
    @Operation(summary = "退出登录", method = "POST", responses = {@ApiResponse(content = @Content(schema = @Schema(implementation = Object.class)))})
    public Object logout() {
        String token = StpUtil.getTokenValue();
        Long id = Long.valueOf(String.valueOf(RedisUtil.get(token)));
        SysLoginInfo sysLoginInfo = new SysLoginInfo();
        sysLoginInfo.setId(id);
        sysLoginInfo.setStatus(Constants.OFFLINE);
        loginInfoService.update(sysLoginInfo);
        RedisUtil.del(token);
        StpUtil.logout();
        return AjaxResult.success();
    }

}
