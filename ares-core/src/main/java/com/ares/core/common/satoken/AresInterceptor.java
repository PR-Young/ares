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

package com.ares.core.common.satoken;

import cn.dev33.satoken.stp.StpUtil;
import cn.hutool.extra.spring.SpringUtil;
import com.ares.config.base.BaseConfig;
import com.ares.core.model.base.Constants;
import com.ares.core.persistence.model.SysUser;
import com.ares.core.persistence.service.ISysUserService;
import com.ares.redis.utils.RedisUtil;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.web.servlet.HandlerInterceptor;




/**
 * @description:
 * @author: Young
 * @date: 2023/8/3
 * @see: com.ares.core.common.satoken.AresInterceptor.java
 **/
public class AresInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        BaseConfig config = SpringUtil.getBean(BaseConfig.class);
        String tokenValue = StpUtil.getTokenValue();
        Long id = Long.valueOf(String.valueOf(StpUtil.getLoginIdByToken(tokenValue)));
        ISysUserService userService = SpringUtil.getBean(ISysUserService.class);
        SysUser user = userService.getById(id);
        try {
            StpUtil.checkActivityTimeout();
        } catch (Exception e) {
            StpUtil.renewTimeout(config.getTimeout());
            StpUtil.updateLastActivityToNow();
            RedisUtil.expire(Constants.LOGIN_INFO + user.getAccount(), config.getTimeout());
        }
        long tokenTimeout = StpUtil.getTokenTimeout(); // 获取过期时间
        //token没过期，过期时间不是-1的时候，每次请求都刷新过期时间
        if (tokenTimeout != -1) {
            StpUtil.renewTimeout(config.getTimeout()); // 用于token续期
            StpUtil.updateLastActivityToNow();
            RedisUtil.expire(Constants.LOGIN_INFO + user.getAccount(), config.getTimeout());
        }
        return true;
    }
}
