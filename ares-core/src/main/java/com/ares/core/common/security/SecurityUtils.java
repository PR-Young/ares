package com.ares.core.common.security;

import cn.dev33.satoken.stp.StpUtil;
import com.ares.core.common.exception.UserException;
import com.ares.core.persistence.model.exception.ErrorCode;
import com.ares.core.persistence.model.system.SysUser;
import com.ares.core.persistence.service.ISysUserService;
import com.ares.core.utils.SpringUtils;

/**
 * @description:
 * @author: Young
 * @date: 2020/10/19
 * @see: com.ares.core.common.security SecurityUtils.java
 **/
public class SecurityUtils {

    private SecurityUtils() {
    }

    public static SysUser getUser() throws UserException {
        String loginId = String.valueOf(StpUtil.getLoginId());
        if (null == loginId || "null".equalsIgnoreCase(loginId)){
            throw new UserException(ErrorCode.NOLOGIN.getCode(), "用户未登录！");
        }
        ISysUserService userService = SpringUtils.getBean(ISysUserService.class);
        SysUser user = userService.getById(loginId);
        return user;
    }

}
