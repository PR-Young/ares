package com.ares.core.common.satoken;

import cn.dev33.satoken.stp.StpInterface;
import com.ares.core.common.exception.UserException;
import com.ares.core.persistence.model.system.SysRole;
import com.ares.core.persistence.model.system.SysUser;
import com.ares.core.persistence.service.SysRoleService;
import com.ares.core.persistence.service.SysUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;

/**
 * @description:
 * @author: Young
 * @date: 2022/12/9
 * @see: com.ares.core.common.satoken.StpInterfaceImpl.java
 **/
@Component
public class StpInterfaceImpl implements StpInterface {

    private SysUserService userService;
    private SysRoleService roleService;

    @Autowired
    public StpInterfaceImpl(SysUserService userService,
                                  SysRoleService roleService) {
        this.userService = userService;
        this.roleService = roleService;
    }

    @Override
    public List<String> getPermissionList(Object loginId, String loginType) {
        List<String> perms = new ArrayList<>();
        SysUser user = userService.getById(String.valueOf(loginId));
        if (null == user) {
            throw new UserException("该用户不存在");
        }
        List<SysRole> roleList = roleService.getRoleByUserId(String.valueOf(loginId));
        for (SysRole role : roleList) {
            if ("gly".equalsIgnoreCase(role.getRoleName())) {
                perms = roleService.getPermsByRoleId(null);
            } else {
                perms = roleService.getPermsByRoleId(role.getId());
            }
        }
        return perms;
    }

    @Override
    public List<String> getRoleList(Object loginId, String loginType) {
        List<String> roles = new ArrayList<>();
        SysUser user = userService.getById(String.valueOf(loginId));
        if (null == user) {
            throw new UserException("该用户不存在");
        }
        List<SysRole> roleList = roleService.getRoleByUserId(String.valueOf(loginId));
        for (SysRole role : roleList) {
           roles.add(role.getRoleName());
        }
        return roles;
    }
}
