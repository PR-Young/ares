/*
 *
 *  * ****************************************************************************
 *  * * Copyright (c) 2021 - 9999, ARES
 *  * *
 *  * * Licensed under the Apache License, Version 2.0 (the "License");
 *  * * you may not use this file except in compliance with the License.
 *  * * You may obtain a copy of the License at
 *  * *
 *  * *        http://www.apache.org/licenses/LICENSE-2.0
 *  * *
 *  * * Unless required by applicable law or agreed to in writing, software
 *  * * distributed under the License is distributed on an "AS IS" BASIS,
 *  * * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  * * See the License for the specific language governing permissions and
 *  * * limitations under the License.
 *  * ***************************************************************************
 *
 */

package com.ares.flow.listener;


import com.ares.core.model.vo.SysUser;
import com.ares.core.persistence.service.ISysUserService;
import jakarta.annotation.Resource;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.dromara.warm.flow.core.FlowEngine;
import org.dromara.warm.flow.core.dto.DefJson;
import org.dromara.warm.flow.core.dto.NodeJson;
import org.dromara.warm.flow.core.listener.GlobalListener;
import org.dromara.warm.flow.core.listener.ListenerVariable;
import org.springframework.stereotype.Component;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

/**
 * @description:
 * @author: Young
 * @date: 2025/6/20
 * @see: com.ares.flow.listener.CustomGlobalListener.java
 **/
@Slf4j
@Component
public class CustomGlobalListener implements GlobalListener {

    @Resource
    private ISysUserService userService;

    /**
     * 分派监听器，动态修改代办任务信息
     * @param listenerVariable  监听器变量
     */
    @Override
    public void assignment(ListenerVariable listenerVariable) {
        log.info("全局分派监听器开始执行......");

        String defJsonStr = listenerVariable.getInstance().getDefJson();
        if (StringUtils.isNotBlank(defJsonStr)) {
            DefJson defJson = FlowEngine.jsonConvert.strToBean(defJsonStr, DefJson.class);
            for (NodeJson nodeJson : defJson.getNodeList()) {
                if (nodeJson.getNodeCode().equals(listenerVariable.getNode().getNodeCode())) {
                    Long userId = Long.valueOf(listenerVariable.getFlowParams().getHandler());
                    SysUser sysUser = userService.getById(userId);
                    if (sysUser != null && StringUtils.isNotEmpty(sysUser.getUserName())) {
                        nodeJson.getExtMap().put("办理人", sysUser.getUserName());
                    }
                    // 年月日时分秒
                    nodeJson.getExtMap().put("办理时间", LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));
                }
            }
            listenerVariable.getInstance().setDefJson(FlowEngine.jsonConvert.objToStr(defJson));
        }

        log.info("全局分派监听器执行结束......");
    }
}
