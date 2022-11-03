package com.ares.core.common.jwt;

import com.ares.core.common.security.SecurityUtils;
import com.ares.core.persistence.model.base.AjaxResult;
import com.ares.core.utils.AresCommonUtils;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.web.authentication.www.BasicAuthenticationFilter;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * @description:
 * @author: Young
 * @date: 2020/10/19
 * @see: com.ares.core.common.jwt JwtAuthenticationFilter.java
 **/
public class JwtAuthenticationFilter extends BasicAuthenticationFilter {

    public JwtAuthenticationFilter(AuthenticationManager authenticationManager) {
        super(authenticationManager);
    }

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain chain) throws IOException, ServletException {
        // 获取token, 并检查登录状态
        try {
            SecurityUtils.checkAuthentication(request);
            chain.doFilter(request, response);
        } catch (Exception e) {
            AresCommonUtils.writeResponse(response, AjaxResult.unLogin());
        }
    }
}
