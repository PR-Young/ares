package com.ares.core.common.security;

import com.ares.core.persistence.model.base.AjaxResult;
import com.ares.core.persistence.model.base.ResultCode;
import com.ares.core.utils.AresCommonUtils;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.AuthenticationEntryPoint;
import org.springframework.stereotype.Component;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.Serializable;

/**
 * @description:
 * @author: Young
 * @date: 2020/10/20
 * @see: com.ares.core.common.security AuthenticationEntryPointImpl.java
 **/
@Component
public class AuthenticationEntryPointImpl implements AuthenticationEntryPoint, Serializable {
    private static final String NO_AUTH = "Full authentication is required to access this resource";

    @Override
    public void commence(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, AuthenticationException e) throws IOException, ServletException {
        if (e.getMessage().contains(NO_AUTH)) {
            AresCommonUtils.writeResponse(httpServletResponse, AjaxResult.unAuth(), ResultCode.NOAUTH.getCode());
        } else {
            AresCommonUtils.writeResponse(httpServletResponse, AjaxResult.error(ResultCode.FAILED.getCode(), e.getMessage()));
        }
    }
}