package com.ares.system.exception;


import cn.dev33.satoken.exception.NotLoginException;
import com.ares.core.common.exception.UserException;
import com.ares.core.persistence.model.base.AjaxResult;
import com.ares.core.persistence.model.base.ResultCode;
import com.ares.core.persistence.model.exception.ErrorCode;
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
        if(e.getType().equals(NotLoginException.INVALID_TOKEN_MESSAGE) ||
                e.getType().equals(NotLoginException.BE_REPLACED_MESSAGE)||
                e.getType().equals(NotLoginException.DEFAULT_MESSAGE)||
                e.getType().equals(NotLoginException.KICK_OUT_MESSAGE)||
                e.getType().equals(NotLoginException.TOKEN_TIMEOUT_MESSAGE) ||
                e.getType().equals(NotLoginException.NOT_TOKEN_MESSAGE)){
            return AjaxResult.error(ResultCode.NOLOGIN.getCode(), ResultCode.NOLOGIN.getMsg());
        }
        return AjaxResult.error(ResultCode.FAILED.getCode(), e.getMessage());
    }

    @ExceptionHandler(value = Exception.class)
    public Object handleException(HttpServletRequest request, HttpServletResponse response, Exception e) {
        return AjaxResult.error(ResultCode.FAILED.getCode(), e.getMessage());
    }



}
