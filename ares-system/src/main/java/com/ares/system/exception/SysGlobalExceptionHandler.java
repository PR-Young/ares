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

package com.ares.system.exception;


import cn.dev33.satoken.exception.NotLoginException;
import cn.dev33.satoken.stp.StpUtil;
import com.ares.core.common.exception.UserException;
import com.ares.core.model.base.AjaxResult;
import com.ares.core.model.base.Constants;
import com.ares.core.model.base.ResultCode;
import com.ares.core.model.exception.ErrorCode;
import com.ares.core.persistence.model.SysLoginInfo;
import com.ares.core.persistence.service.ISysLoginInfoService;
import com.ares.core.utils.SpringUtils;
import com.ares.redis.utils.RedisUtil;
import org.apache.ibatis.exceptions.PersistenceException;
import org.springframework.core.Ordered;
import org.springframework.core.annotation.Order;
import org.springframework.validation.BindException;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * @description:
 * @author: Young 2020/05/09
 **/
@RestControllerAdvice
@Order(value = Ordered.HIGHEST_PRECEDENCE)
public class SysGlobalExceptionHandler {

    @ExceptionHandler(value = BindException.class)
    public Object handleNotValidException(HttpServletRequest request, HttpServletResponse response, BindException e) {
        ObjectError error = e.getBindingResult().getAllErrors().get(0);
        return AjaxResult.result(ResultCode.VALIDATE_FAILED.getCode(), ResultCode.VALIDATE_FAILED.getMsg(), error.getDefaultMessage());
    }

    @ExceptionHandler(value = UserException.class)
    public Object handleUserException(HttpServletRequest request, HttpServletResponse response, UserException e) {
        Integer code = e.getCode();
        if (code.equals(ErrorCode.NOUSER.getCode())) {
            return AjaxResult.error(ResultCode.NOUSER.getCode(), ResultCode.NOUSER.getMsg());
        } else if (code.equals(ErrorCode.NOAUTH.getCode())) {
            return AjaxResult.unAuth();
        }
        return AjaxResult.unLogin();
    }

    @ExceptionHandler(value = NumberFormatException.class)
    public Object handleNumberFormatException(HttpServletRequest request, HttpServletResponse response, NumberFormatException e) {
        return AjaxResult.error(ResultCode.FAILED.getCode(), e.getMessage());
    }

    @ExceptionHandler(value = PersistenceException.class)
    public Object handlePersistenceException(HttpServletRequest request, HttpServletResponse response, PersistenceException e) {
        return AjaxResult.error(ResultCode.FAILED.getCode(), e.getMessage());
    }

    @ExceptionHandler(value = NotLoginException.class)
    public Object handleException(HttpServletRequest request, HttpServletResponse response, NotLoginException e) {
        if (e.getType().equals(NotLoginException.INVALID_TOKEN_MESSAGE)
                || e.getType().equals(NotLoginException.BE_REPLACED_MESSAGE)
                || e.getType().equals(NotLoginException.DEFAULT_MESSAGE)
                || e.getType().equals(NotLoginException.KICK_OUT_MESSAGE)
                || e.getType().equals(NotLoginException.TOKEN_TIMEOUT_MESSAGE)
                || e.getType().equals(NotLoginException.NOT_TOKEN_MESSAGE)) {
            String token = StpUtil.getTokenValue();
            Long id = Long.valueOf(String.valueOf(RedisUtil.get(token)));
            SysLoginInfo sysLoginInfo = new SysLoginInfo();
            sysLoginInfo.setId(id);
            sysLoginInfo.setStatus(Constants.OFFLINE);
            ISysLoginInfoService loginInfoService = SpringUtils.getBean(ISysLoginInfoService.class);
            loginInfoService.update(sysLoginInfo);
            RedisUtil.del(token);
            return AjaxResult.error(ResultCode.NOLOGIN.getCode(), ResultCode.NOLOGIN.getMsg());
        }
        return AjaxResult.error(ResultCode.FAILED.getCode(), e.getMessage());
    }

}
