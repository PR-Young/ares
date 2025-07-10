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

package com.ares.core.service.impl;

import com.ares.core.model.query.SysUserQuery;
import com.ares.core.model.vo.SysUser;
import com.ares.core.persistence.dao.ISysRoleDao;
import com.ares.core.persistence.entity.SysRoleDto;
import com.ares.core.persistence.entity.SysUserDto;
import com.ares.core.persistence.manager.SysUserManager;
import com.ares.core.service.ISysUserService;
import com.ares.core.utils.StringUtils;
import com.github.pagehelper.PageInfo;
import io.github.linpeilie.Converter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 * @description:
 * @author: Young 2020/01/22
 **/
@Service
public class SysUserServiceImpl implements ISysUserService {

    private SysUserManager userManager;
    private ISysRoleDao roleDao;
    private Converter converter;

    @Autowired
    public SysUserServiceImpl(SysUserManager userManager, ISysRoleDao roleDao, Converter converter) {
        this.userManager = userManager;
        this.roleDao = roleDao;
        this.converter = converter;
    }

    @Override
    public void insert(SysUser sysUser) {
        SysUserDto sysUserDto = converter.convert(sysUser, SysUserDto.class);
        userManager.insert(sysUserDto);
    }

    @Override
    public PageInfo<SysUser> list(int pageNo, int pageSize, Map<String, Object> map) {
        PageInfo<SysUserDto> list = userManager.list(pageNo, pageSize, map);
        PageInfo<SysUser> userPageInfo = list.convert(dto -> {
            SysUser v = converter.convert(dto, SysUser.class);
            return v;
        });
        return userPageInfo;
    }

    @Override
    public PageInfo<SysUser> list(SysUserQuery obj) {
        List<SysUserDto> lists = userManager.selectList(obj);
        PageInfo<SysUserDto> pageInfo = new PageInfo<>(lists);
        PageInfo<SysUser> page = pageInfo.convert(dto -> {
            SysUser v = converter.convert(dto, SysUser.class);
            return v;
        });
        return page;
    }

    @Override
    public List<SysUser> assignAllUser(Long roleId) {
        List<SysUser> userList = converter.convert(userManager.assignAllUser(roleId), SysUser.class);
        return userList;
    }

    @Override
    public List<SysUser> getUserByRole(Long roleId) {
        List<SysUser> userList = converter.convert(userManager.getUserByRole(roleId), SysUser.class);
        return userList;
    }

    @Override
    public void update(SysUser obj) {
        SysUserDto sysUserDto = converter.convert(obj, SysUserDto.class);
        userManager.update(sysUserDto);
    }

    @Override
    public void deleteByIds(List<Long> ids) {
        userManager.deleteByIds(ids);
    }

    @Override
    public SysUser getById(Long id) {
        return converter.convert(userManager.getById(id), SysUser.class);
    }

    @Override
    public int checkAccount(String account) {
        return userManager.checkAccount(account);
    }

    @Override
    public int resetPassword(Long id) {
        return userManager.resetPassword(id);
    }

    @Override
    public List<SysUser> selectUserList(SysUserQuery user) {
        return converter.convert(userManager.selectList(user), SysUser.class);
    }

    @Override
    public Long insertUser(SysUser sysUser) {
        SysUserDto sysUserDto = converter.convert(sysUser, SysUserDto.class);
        return userManager.insertUser(sysUserDto);
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
        SysUserDto sysUserDto = converter.convert(user, SysUserDto.class);
        return userManager.updatePassword(sysUserDto, passWord);
    }

    @Override
    public SysUser getUserByName(String userName) {
        return converter.convert(userManager.getUserByName(userName), SysUser.class);
    }

    @Override
    public int updateUserByAccount(SysUser sysUser) {
        SysUserDto sysUserDto = converter.convert(sysUser, SysUserDto.class);
        return userManager.updateUserByAccount(sysUserDto);
    }
}
