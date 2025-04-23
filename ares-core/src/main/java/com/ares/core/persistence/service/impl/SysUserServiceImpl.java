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

import com.ares.core.model.query.SysUserQuery;
import com.ares.core.model.vo.SysUser;
import com.ares.core.persistence.dao.ISysRoleDao;
import com.ares.core.persistence.dao.ISysUserDao;
import com.ares.core.persistence.entity.SysRoleDto;
import com.ares.core.persistence.entity.SysUserDto;
import com.ares.core.persistence.service.ISysUserService;
import com.ares.core.utils.MD5Util;
import com.ares.core.utils.SnowflakeIdWorker;
import com.ares.core.utils.StringUtils;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import io.github.linpeilie.Converter;
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
    private Converter converter;

    @Autowired
    public SysUserServiceImpl(ISysUserDao sysUserDao, ISysRoleDao roleDao, Converter converter) {
        this.sysUserDao = sysUserDao;
        this.roleDao = roleDao;
        this.converter = converter;
    }

    @Override
    public void insert(SysUser sysUser) {
        sysUser.setId(SnowflakeIdWorker.getUUID());
        sysUser.setPassword(MD5Util.encode("123456"));
        sysUser.setCreateTime(new Date());
        SysUserDto sysUserDto = converter.convert(sysUser, SysUserDto.class);
        sysUserDao.insert(sysUserDto);
    }

    @Override
    public PageInfo<SysUser> list(int pageNo, int pageSize, Map<String, Object> map) {
        PageHelper.startPage(pageNo, pageSize);
        List<SysUser> userList = converter.convert(sysUserDao.list(map), SysUser.class);
        PageInfo<SysUser> userPageInfo = new PageInfo<>(userList);
        return userPageInfo;
    }

    @Override
    public PageInfo<SysUser> list(SysUserQuery obj) {
        List<SysUserDto> lists = sysUserDao.selectList(obj);
        PageInfo<SysUserDto> pageInfo = new PageInfo<>(lists);
        PageInfo<SysUser> page = pageInfo.convert(dto -> {
            SysUser v = converter.convert(dto, SysUser.class);
            return v;
        });
        return page;
    }

    @Override
    public List<SysUser> assignAllUser(Long roleId) {
        List<SysUser> userList = converter.convert(sysUserDao.allUser(roleId), SysUser.class);
        return userList;
    }

    @Override
    public List<SysUser> getUserByRole(Long roleId) {
        List<SysUser> userList = converter.convert(sysUserDao.getUserByRole(roleId), SysUser.class);
        return userList;
    }

    @Override
    public void update(SysUser obj) {
        obj.setModifyTime(new Date());
        SysUserDto sysUserDto = converter.convert(obj, SysUserDto.class);
        sysUserDao.update(sysUserDto);
    }

    @Override
    public void deleteByIds(List<Long> ids) {
        sysUserDao.deleteByIds(ids);
    }

    @Override
    public SysUser getById(Long id) {
        return converter.convert(sysUserDao.getById(id), SysUser.class);
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
    public List<SysUser> selectUserList(SysUserQuery user) {
        return converter.convert(sysUserDao.selectList(user), SysUser.class);
    }

    @Override
    public Long insertUser(SysUser sysUser) {
        Long id = SnowflakeIdWorker.getUUID();
        sysUser.setId(id);
        sysUser.setPassword(MD5Util.encode("123456"));
        sysUser.setCreateTime(new Date());
        SysUserDto sysUserDto = converter.convert(sysUser, SysUserDto.class);
        sysUserDao.insert(sysUserDto);
        return id;
    }

    @Override
    public String selectUserRoleGroup(Long userId) {
        List<SysRoleDto> roleList = roleDao.getRoleByUserId(userId);
        StringBuffer idsStr = new StringBuffer();
        for (SysRoleDto role : roleList) {
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
        SysUserDto sysUserDto = converter.convert(user, SysUserDto.class);
        return sysUserDao.update(sysUserDto);
    }

    @Override
    public SysUser getUserByName(String userName) {
        return converter.convert(sysUserDao.getUserByName(userName), SysUser.class);
    }

    @Override
    public int updateUserByAccount(SysUser sysUser) {
        SysUserDto sysUserDto = converter.convert(sysUser, SysUserDto.class);
        return sysUserDao.updateUserByAccount(sysUserDto);
    }
}
