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

package com.ares.core.listener;


import com.alibaba.excel.context.AnalysisContext;
import com.alibaba.excel.event.AnalysisEventListener;
import com.alibaba.fastjson.JSON;
import com.ares.core.persistence.dao.ISysPostDao;
import com.ares.core.persistence.dao.ISysRoleDao;
import com.ares.core.persistence.model.SysPost;
import com.ares.core.persistence.model.SysRole;
import com.ares.core.persistence.model.SysUser;
import com.ares.core.persistence.service.ISysUserService;
import com.ares.core.utils.SnowflakeIdWorker;
import com.ares.core.utils.SpringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @description:
 * @author: Young
 * @date: 2022/12/15
 * @see: com.ares.core.persistence.service.impl.UserDataListener.java
 **/
public class UserDataListener extends AnalysisEventListener<SysUser> {
    private Logger logger = LoggerFactory.getLogger(UserDataListener.class);
    private static final int BATCH_COUNT = 100;
    private static final String POST_NAME = "员工";
    private static final String ROLE_NAME = "user";
    List<SysUser> userList = new ArrayList<>();
    private boolean needUpdate = true;
    private String deptId;

    public UserDataListener(boolean needUpdate, String deptId) {
        this.needUpdate = needUpdate;
        this.deptId = deptId;
    }

    @Override
    public void invoke(SysUser sysUser, AnalysisContext analysisContext) {
        logger.info("解析到一条数据:{}", JSON.toJSONString(sysUser));
        userList.add(sysUser);
        if (userList.size() >= BATCH_COUNT) {
            saveData();
            userList.clear();
        }
    }

    @Override
    public void doAfterAllAnalysed(AnalysisContext analysisContext) {
        saveData();
        logger.info("所有数据解析完成！");
    }

    private void saveData() {
        ISysUserService userService = SpringUtils.getBean(ISysUserService.class);
        logger.info("{}条数据，开始存储数据库！", userList.size());
        ISysPostDao postDao = SpringUtils.getBean(ISysPostDao.class);
        SysPost post = postDao.getByName(POST_NAME);
        ISysRoleDao roleDao = SpringUtils.getBean(ISysRoleDao.class);
        SysRole role = roleDao.getRoleByName(ROLE_NAME);
        for (SysUser user : userList) {
            if (userService.checkAccount(user.getAccount()) > 0) {
                if (needUpdate) {
                    SysUser oldUser = userService.getUserByName(user.getAccount());
                    oldUser.setUserName(user.getUserName());
                    oldUser.setPhoneNumber(user.getPhoneNumber());
                    oldUser.setEmail(user.getEmail());
                    userService.updateUserByAccount(oldUser);
                }
            } else {
                user.setDeptId(this.deptId);
                user.setPostId(post.getId());
                String userId = userService.insertUser(user);
                Map<String, Object> map = new HashMap<>();
                map.put("id", SnowflakeIdWorker.getUUID());
                map.put("userId", userId);
                map.put("roleId", role.getId());
                roleDao.insertRoleUser(map);
            }
        }
        logger.info("存储数据库成功！");
    }
}
