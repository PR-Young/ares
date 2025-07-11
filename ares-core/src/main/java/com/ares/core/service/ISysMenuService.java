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

package com.ares.core.service;


import com.ares.core.model.query.SysMenuQuery;
import com.ares.core.model.tree.TreeSelect;
import com.ares.core.model.vo.RouterVo;
import com.ares.core.model.vo.SysMenu;

import java.util.List;
import java.util.Map;

/**
 * @description:
 * @author: Young 2020/01/23
 **/
public interface ISysMenuService extends IBaseService<SysMenu, SysMenuQuery> {

    /**
     * 根据用户id获取用户角色如果用户为null 获取所有权限
     *
     * @return
     */
    List<SysMenu> getAll(Long userId);

    List<SysMenu> list(Map<String, Object> map);

    SysMenu getByPId(Long pid);

    List<RouterVo> buildMenus(List<SysMenu> menus, Long parentId);

    String getRouterPath(SysMenu menu);

    List<SysMenu> selectMenuList(SysMenuQuery menu, Long userId);

    List<TreeSelect> buildMenuTreeSelect(List<SysMenu> menus);

    List<SysMenu> buildMenuTree(List<SysMenu> menus);

    void remove(Long menuId);

    boolean hasChildByMenuId(Long menuId);

    List<Long> selectMenuByRole(Long roleId);

}
