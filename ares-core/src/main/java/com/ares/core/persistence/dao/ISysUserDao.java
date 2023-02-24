package com.ares.core.persistence.dao;


import com.ares.core.persistence.model.SysUser;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @description:
 * @author: Young 2020/01/22
 **/
@Mapper
public interface ISysUserDao extends IBaseDao<SysUser> {

    SysUser getUserByName(String userName);

    Integer checkAccount(String account);

    int resetPassword(@Param("password") String password, @Param("id") String id);

    List<SysUser> getUserByRole(String roleId);

    List<SysUser> allUser(String roleId);

    int updateUserByAccount(SysUser sysUser);

}
