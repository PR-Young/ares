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

package com.ares.core.persistence.service;


import com.ares.core.persistence.model.RouterVo;
import com.ares.core.persistence.model.SysMenu;
import com.ares.core.model.tree.TreeSelect;

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
