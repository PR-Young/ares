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

package com.ares.core.persistence.manager.impl;

import com.ares.core.model.query.SysUserQuery;
import com.ares.core.persistence.dao.ISysUserDao;
import com.ares.core.persistence.entity.SysUserDto;
import com.ares.core.persistence.manager.SysUserManager;
import com.ares.core.utils.MD5Util;
import com.ares.core.utils.SnowflakeIdWorker;
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
public class SysUserManagerImpl implements SysUserManager {

    private ISysUserDao sysUserDao;

    @Autowired
    public SysUserManagerImpl(ISysUserDao sysUserDao) {
        this.sysUserDao = sysUserDao;
    }

    @Override
    public void insert(SysUserDto sysUser) {
        sysUser.setId(SnowflakeIdWorker.getUUID());
        sysUser.setPassword(MD5Util.encode("123456"));
        sysUser.setCreateTime(new Date());
        sysUserDao.insert(sysUser);
    }

    @Override
    public PageInfo<SysUserDto> list(int pageNo, int pageSize, Map<String, Object> map) {
        PageHelper.startPage(pageNo, pageSize);
        List<SysUserDto> userList = sysUserDao.list(map);
        PageInfo<SysUserDto> userPageInfo = new PageInfo<>(userList);
        return userPageInfo;
    }

    @Override
    public PageInfo<SysUserDto> list(SysUserQuery obj) {
        List<SysUserDto> lists = sysUserDao.selectList(obj);
        PageInfo<SysUserDto> pageInfo = new PageInfo<>(lists);
        return pageInfo;
    }

    @Override
    public List<SysUserDto> list(Map<String, Object> params) {
        return sysUserDao.list(params);
    }

    @Override
    public List<SysUserDto> selectList(SysUserQuery obj) {
        return sysUserDao.selectList(obj);
    }

    @Override
    public List<SysUserDto> assignAllUser(Long roleId) {
        List<SysUserDto> userList = sysUserDao.allUser(roleId);
        return userList;
    }

    @Override
    public List<SysUserDto> getUserByRole(Long roleId) {
        List<SysUserDto> userList = sysUserDao.getUserByRole(roleId);
        return userList;
    }

    @Override
    public void update(SysUserDto obj) {
        obj.setModifyTime(new Date());
        sysUserDao.update(obj);
    }

    @Override
    public void deleteByIds(List<Long> ids) {
        sysUserDao.deleteByIds(ids);
    }

    @Override
    public SysUserDto getById(Long id) {
        return sysUserDao.getById(id);
    }

    @Override
    public int checkAccount(String account) {
        Integer num = sysUserDao.checkAccount(account);
        return num == null ? 0 : num;
    }

    @Override
    public int resetPassword(Long id) {
        return sysUserDao.resetPassword(MD5Util.encode("123456"), id);
    }

    @Override
    public List<SysUserDto> selectUserList(SysUserQuery user) {
        return sysUserDao.selectList(user);
    }

    @Override
    public Long insertUser(SysUserDto sysUser) {
        Long id = SnowflakeIdWorker.getUUID();
        sysUser.setId(id);
        sysUser.setPassword(MD5Util.encode("123456"));
        sysUser.setCreateTime(new Date());
        sysUserDao.insert(sysUser);
        return id;
    }


    @Override
    public int updatePassword(SysUserDto user, String passWord) {
        user.setPassword(MD5Util.encode(passWord));
        return sysUserDao.update(user);
    }

    @Override
    public SysUserDto getUserByName(String userName) {
        return sysUserDao.getUserByName(userName);
    }

    @Override
    public int updateUserByAccount(SysUserDto sysUser) {
        return sysUserDao.updateUserByAccount(sysUser);
    }
}
