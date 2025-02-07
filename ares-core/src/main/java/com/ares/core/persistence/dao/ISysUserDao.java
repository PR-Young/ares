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

package com.ares.core.persistence.dao;


import com.ares.core.model.query.SysUserQuery;
import com.ares.core.persistence.entity.SysUserDto;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @description:
 * @author: Young 2020/01/22
 **/
@Mapper
public interface ISysUserDao extends IBaseDao<SysUserDto, SysUserQuery> {

    SysUserDto getUserByName(String userName);

    Integer checkAccount(String account);

    int resetPassword(@Param("password") String password, @Param("id") Long id);

    List<SysUserDto> getUserByRole(Long roleId);

    List<SysUserDto> allUser(Long roleId);

    int updateUserByAccount(SysUserDto sysUser);

}
