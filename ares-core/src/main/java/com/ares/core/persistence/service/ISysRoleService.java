package com.ares.core.persistence.service;

import com.ares.core.persistence.model.system.SysRole;

import java.util.List;

/**
 * @description:
 * @author: Young 2020/01/26
 **/
public interface ISysRoleService extends IBaseService<SysRole> {

    public void saveAssign(String users, String menus, String roleId);

    public List<SysRole> getRoleByUserId(String userId);

    public List<String> getPermsByRoleId(String roleId);

    public List<String> getRoleIdsByUser(String userId);

    public List<SysRole> getAll() ;

    public void saveRoleUser(String[] roleIds, String userId) ;

    public List<SysRole> selectRoleList(SysRole role);

    public boolean checkRoleName(String roleName);

    public String insertRole(SysRole obj) ;

    public void updateRole(SysRole obj);

    public void authDataScope(SysRole role);
}
