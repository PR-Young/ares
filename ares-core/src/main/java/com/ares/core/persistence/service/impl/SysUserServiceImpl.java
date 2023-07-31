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

package com.ares.core.persistence.service.impl;

import com.ares.core.persistence.dao.ISysRoleDao;
import com.ares.core.persistence.dao.ISysUserDao;
import com.ares.core.persistence.model.SysRole;
import com.ares.core.persistence.model.SysUser;
import com.ares.core.persistence.service.ISysUserService;
import com.ares.core.utils.MD5Util;
import com.ares.core.utils.SnowflakeIdWorker;
import com.ares.core.utils.StringUtils;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * @description:
 * @author: Young 2020/01/22
 **/
@Service
public class SysUserServiceImpl implements ISysUserService {

    private ISysUserDao sysUserDao;
    private ISysRoleDao roleDao;

    @Autowired
    public SysUserServiceImpl(ISysUserDao sysUserDao, ISysRoleDao roleDao) {
        this.sysUserDao = sysUserDao;
        this.roleDao = roleDao;
    }

    @Override
    public void insert(SysUser sysUser) {
        sysUser.setId(SnowflakeIdWorker.getUUID());
        sysUser.setPassword(MD5Util.encode("123456"));
        sysUser.setCreateTime(new Date());
        sysUserDao.insert(sysUser);
    }

    @Override
    public PageInfo<SysUser> list(int pageNo, int pageSize, Map<String, Object> map) {
        PageHelper.startPage(pageNo, pageSize);
        List<SysUser> userList = sysUserDao.list(map);
        PageInfo<SysUser> userPageInfo = new PageInfo<>(userList);
        return userPageInfo;
    }

    @Override
    public List<SysUser> list(SysUser obj) {
        return null;
    }

    @Override
    public List<SysUser> assignAllUser(String roleId) {
        List<SysUser> userList = sysUserDao.allUser(roleId);
        return userList;
    }

    @Override
    public List<SysUser> getUserByRole(String roleId) {
        List<SysUser> userList = sysUserDao.getUserByRole(roleId);
        return userList;
    }

    @Override
    public void update(SysUser obj) {
        obj.setModifyTime(new Date());
        sysUserDao.update(obj);
    }

    @Override
    public void deleteByIds(List<String> ids) {
        sysUserDao.deleteByIds(ids);
    }

    @Override
    public SysUser getById(String id) {
        return sysUserDao.getById(id);
    }

    @Override
    public int checkAccount(String account) {
        Integer num = sysUserDao.checkAccount(account);
        return num == null ? 0 : num;
    }

    @Override
    public int resetPassword(String id) {
        return sysUserDao.resetPassword(MD5Util.encode("123456"), id);
    }

    @Override
    public List<SysUser> selectUserList(SysUser user) {
        return sysUserDao.selectList(user);
    }

    @Override
    public String insertUser(SysUser sysUser) {
        String id = SnowflakeIdWorker.getUUID();
        sysUser.setId(id);
        sysUser.setPassword(MD5Util.encode("123456"));
        sysUser.setCreateTime(new Date());
        sysUserDao.insert(sysUser);
        return id;
    }

    @Override
    public String selectUserRoleGroup(String userId) {
        List<SysRole> roleList = roleDao.getRoleByUserId(userId);
        StringBuffer idsStr = new StringBuffer();
        for (SysRole role : roleList) {
            idsStr.append(role.getDescription()).append(",");
        }
        if (StringUtils.isNotEmpty(idsStr.toString())) {
            return idsStr.substring(0, idsStr.length() - 1);
        }
        return idsStr.toString();
    }

    @Override
    public int updatePassword(SysUser user, String passWord) {
        user.setPassword(MD5Util.encode(passWord));
        return sysUserDao.update(user);
    }

    @Override
    public SysUser getUserByName(String userName) {
        return sysUserDao.getUserByName(userName);
    }

    @Override
    public int updateUserByAccount(SysUser sysUser) {
        return 0;
    }
}
