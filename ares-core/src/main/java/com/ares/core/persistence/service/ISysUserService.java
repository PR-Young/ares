package com.ares.core.persistence.service;

import com.ares.core.persistence.model.SysUser;

import java.util.List;

/**
 * @description:
 * @author: Young 2020/01/22
 **/
public interface ISysUserService extends IBaseService<SysUser> {

    public List<SysUser> assignAllUser(String roleId) ;

    public List<SysUser> getUserByRole(String roleId) ;

    public int checkAccount(String account) ;

    public int resetPassword(String id);

    public List<SysUser> selectUserList(SysUser user);

    public String insertUser(SysUser sysUser);

    public String selectUserRoleGroup(String userId) ;

    public int updatePassword(SysUser user, String passWord);

    public SysUser getUserByName(String userName);

    public int updateUserByAccount(SysUser sysUser);

}
