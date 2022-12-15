package com.ares.core.persistence.service;


import com.ares.core.persistence.model.system.RouterVo;
import com.ares.core.persistence.model.system.SysMenu;
import com.ares.core.persistence.model.tree.TreeSelect;

import java.util.List;
import java.util.Map;

/**
 * @description:
 * @author: Young 2020/01/23
 **/
public interface ISysMenuService extends IBaseService<SysMenu> {

    /**
     * 根据用户id获取用户角色如果用户为null 获取所有权限
     *
     * @return
     */
    public List<SysMenu> getAll(String userId);

    public List<SysMenu> list(Map<String, Object> map);

    public SysMenu getByPId(String pid);

    public List<RouterVo> buildMenus(List<SysMenu> menus, String parentId);

    public String getRouterPath(SysMenu menu) ;

    public List<SysMenu> selectMenuList(SysMenu menu, String userId) ;

    public List<TreeSelect> buildMenuTreeSelect(List<SysMenu> menus) ;

    public List<SysMenu> buildMenuTree(List<SysMenu> menus);

    public void remove(String menuId);

    public boolean hasChildByMenuId(String menuId) ;

    public List<String> selectMenuByRole(String roleId);

}
