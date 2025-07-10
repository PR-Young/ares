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

package com.ares.core.persistence.manager;

import com.ares.core.model.query.SysUserQuery;
import com.ares.core.persistence.entity.SysUserDto;

import java.util.List;

/**
 * @description:
 * @author: Young 2020/01/22
 **/
public interface SysUserManager extends BaseManager<SysUserDto, SysUserQuery> {
    List<SysUserDto> assignAllUser(Long roleId);

    List<SysUserDto> getUserByRole(Long roleId);

    int checkAccount(String account);

    int resetPassword(Long id);

    List<SysUserDto> selectUserList(SysUserQuery user);

    Long insertUser(SysUserDto sysUser);

    int updatePassword(SysUserDto user, String passWord);

    SysUserDto getUserByName(String userName);

    int updateUserByAccount(SysUserDto sysUser);

}
