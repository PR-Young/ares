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

package com.ares.core.utils;

import com.alibaba.fastjson2.JSON;
import com.ares.core.model.base.Constants;
import jakarta.servlet.ServletInputStream;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.HashMap;
import java.util.Map;

/**
 * 客户端工具类
 */
@Slf4j
public class ServletUtils {
    /**
     * 获取String参数
     */
    public static String getParameter(String name) {
        return getRequest().getParameter(name);
    }

    /**
     * 获取String参数
     */
    public static String getParameter(String name, String defaultValue) {
        return Convert.toStr(getRequest().getParameter(name), defaultValue);
    }

    /**
     * 获取Integer参数
     */
    public static Integer getParameterToInt(String name) {
        return Convert.toInt(getRequest().getParameter(name));
    }

    /**
     * 获取Integer参数
     */
    public static Integer getParameterToInt(String name, Integer defaultValue) {
        return Convert.toInt(getRequest().getParameter(name), defaultValue);
    }

    /**
     * 获取request
     */
    public static HttpServletRequest getRequest() {
        return getRequestAttributes().getRequest();
    }

    /**
     * 获取response
     */
    public static HttpServletResponse getResponse() {
        return getRequestAttributes().getResponse();
    }

    /**
     * 获取session
     */
    public static HttpSession getSession() {
        return getRequest().getSession();
    }

    public static ServletRequestAttributes getRequestAttributes() {
        RequestAttributes attributes = RequestContextHolder.getRequestAttributes();
        return (ServletRequestAttributes) attributes;
    }

    /**
     * 将字符串渲染到客户端
     *
     * @param response 渲染对象
     * @param string   待渲染的字符串
     * @return null
     */
    public static String renderString(HttpServletResponse response, String string) {
        try {
            response.setContentType("application/json");
            response.setCharacterEncoding("utf-8");
            response.getWriter().print(string);
        } catch (IOException e) {
            log.error("renderString error:", e);
        }
        return null;
    }

    /**
     * 是否是Ajax异步请求
     *
     * @param request
     */
    public static boolean isAjaxRequest(HttpServletRequest request) {
        boolean result = true;

        String accept = request.getHeader("accept");
        if (accept == null || accept.indexOf("application/json") == -1) {
            String xRequestedWith = request.getHeader("X-Requested-With");
            if (xRequestedWith == null || xRequestedWith.indexOf("XMLHttpRequest") == -1) {
                String uri = request.getRequestURI();
                if (!StringUtils.inStringIgnoreCase(uri, ".json", ".xml")) {
                    String ajax = request.getParameter("__ajax");
                    if (!StringUtils.inStringIgnoreCase(ajax, "json", "xml")) {
                        result = false;
                    }
                }
            }
        }

        return result;
    }

    public static Map<String, Object> getQueryParams() {
        Map<String, Object> map = new HashMap<>();
        String search = getParameter("searchText");
        String sort = getParameter("sort");
        String sortOrder = getParameter("sortOrder");
        map.put("search", search);
        if (StringUtils.isNotEmpty(sort)) {
            map.put("sort", "`" + sort + "` " + sortOrder);
        }
        return map;
    }

    public static Map<String, Object> getParameter() {
        Map<String, Object> map = new HashMap<>();
        try {
            ServletInputStream inputStream = getRequest().getInputStream();
            BufferedReader bufferedReader = null;
            String line = null;
            StringBuffer sb = new StringBuffer();
            if (null != inputStream) {
                bufferedReader = new BufferedReader(new InputStreamReader(inputStream));
                while ((line = bufferedReader.readLine()) != null) {
                    sb.append(line);
                }
            }
            map = JSON.parseObject(sb.toString(), Map.class);
        } catch (Exception e) {
            log.error("getParameter error: ", e);
        }
        return map;
    }

    public static String getToken() {
        String token = getRequest().getHeader(Constants.TOKEN);
        if (StringUtils.isNotEmpty(token) && token.startsWith(Constants.TOKEN_PREFIX)) {
            token = token.replace(Constants.TOKEN_PREFIX, "");
        }
        return token;
    }
}
