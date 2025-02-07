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

package com.ares.core.persistence.service.impl;


import com.ares.core.model.query.SysMenuQuery;
import com.ares.core.model.tree.TreeSelect;
import com.ares.core.model.vo.MetaVo;
import com.ares.core.model.vo.RouterVo;
import com.ares.core.model.vo.SysMenu;
import com.ares.core.persistence.dao.ISysMenuDao;
import com.ares.core.persistence.entity.SysMenuDto;
import com.ares.core.persistence.entity.SysUserDto;
import com.ares.core.persistence.service.ISysMenuService;
import com.ares.core.utils.SnowflakeIdWorker;
import com.github.pagehelper.PageInfo;
import io.github.linpeilie.Converter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;
import java.util.stream.Collectors;

/**
 * @description:
 * @author: Young 2020/01/23
 **/
@Service
public class SysMenuServiceImpl implements ISysMenuService {

    private ISysMenuDao sysMenuDao;
    private Converter converter;

    @Autowired
    public SysMenuServiceImpl(ISysMenuDao sysMenuDao, Converter converter) {
        this.sysMenuDao = sysMenuDao;
        this.converter = converter;
    }

    /**
     * 根据用户id获取用户角色如果用户为null 获取所有权限
     *
     * @return
     */
    @Override
    public List<SysMenu> getAll(Long userId) {
        return converter.convert(sysMenuDao.getMenuByUserId(userId), SysMenu.class);
    }

    @Override
    public List<SysMenu> list(Map<String, Object> map) {
        return converter.convert(sysMenuDao.list(map), SysMenu.class);
    }

    @Override
    public void insert(SysMenu obj) {
        obj.setId(SnowflakeIdWorker.getUUID());
        obj.setCreateTime(new Date());
        SysMenuDto sysMenuDto = converter.convert(obj, SysMenuDto.class);
        sysMenuDao.insert(sysMenuDto);
    }

    @Override
    public void update(SysMenu obj) {
        obj.setModifyTime(new Date());
        SysMenuDto sysMenuDto = converter.convert(obj, SysMenuDto.class);
        sysMenuDao.update(sysMenuDto);
    }

    @Override
    public void deleteByIds(List<Long> ids) {
        sysMenuDao.deleteByIds(ids);
    }

    @Override
    public SysMenu getById(Long id) {
        return converter.convert(sysMenuDao.getById(id), SysMenu.class);
    }

    @Override
    public PageInfo<SysMenu> list(int pageNo, int pageSize, Map<String, Object> map) {
        return null;
    }

    @Override
    public List<SysMenu> list(SysMenuQuery obj) {
        return null;
    }

    @Override
    public SysMenu getByPId(Long pid) {
        return converter.convert(sysMenuDao.getByPId(pid), SysMenu.class);
    }


    @Override
    public List<RouterVo> buildMenus(List<SysMenu> menus, Long parentId) {
        List<RouterVo> routers = new LinkedList<RouterVo>();
        for (SysMenu menu : menus) {
            RouterVo router = new RouterVo();
            if (2 != menu.getType() && parentId.equals(menu.getPId())) {
                router.setHidden(menu.getVisible() == 1);
                router.setName(menu.getName());
                router.setPath(getRouterPath(menu));
                router.setComponent(("#").equals(menu.getUrl()) ? "Layout" : menu.getUrl().substring(1));
                router.setMeta(new MetaVo(menu.getName(), menu.getIcon()));
                if (menu.getChildCount() > 0) {
                    router.setAlwaysShow(true);
                    router.setRedirect("noRedirect");
                    router.setChildren(buildMenus(menus, menu.getId()));
                }
                routers.add(router);
            }
        }
        return routers;
    }

    @Override
    public String getRouterPath(SysMenu menu) {
        String routerPath = menu.getPath();
        // 一级目录
        if ("0".equals(menu.getPId())) {
            routerPath = "/" + menu.getPath();
        }
        return routerPath;
    }

    @Override
    public List<SysMenu> selectMenuList(SysMenuQuery menu, Long userId) {
        List<SysMenu> menuList = null;
        if (SysUserDto.isAdmin(userId)) {
            menuList = converter.convert(sysMenuDao.selectList(menu), SysMenu.class);
        } else {
            menu.getParams().put("userId", userId);
            menuList = converter.convert(sysMenuDao.selectListByUser(menu), SysMenu.class);
        }
        return menuList;
    }

    @Override
    public List<TreeSelect> buildMenuTreeSelect(List<SysMenu> menus) {
        List<SysMenu> menuTrees = buildMenuTree(menus);
        return menuTrees.stream().map(TreeSelect::new).collect(Collectors.toList());
    }

    @Override
    public List<SysMenu> buildMenuTree(List<SysMenu> menus) {
        List<SysMenu> returnList = new ArrayList<SysMenu>();
        for (Iterator<SysMenu> iterator = menus.iterator(); iterator.hasNext(); ) {
            SysMenu t = (SysMenu) iterator.next();
            // 根据传入的某个父节点ID,遍历该父节点的所有子节点
            if (t.getPId() == 0) {
                recursionFn(menus, t);
                returnList.add(t);
            }
        }
        if (returnList.isEmpty()) {
            returnList = menus;
        }
        return returnList;
    }

    private void recursionFn(List<SysMenu> list, SysMenu t) {
        // 得到子节点列表
        List<SysMenu> childList = getChildList(list, t);
        t.setChildren(childList);
        for (SysMenu tChild : childList) {
            if (hasChild(list, tChild)) {
                // 判断是否有子节点
                Iterator<SysMenu> it = childList.iterator();
                while (it.hasNext()) {
                    SysMenu n = (SysMenu) it.next();
                    recursionFn(list, n);
                }
            }
        }
    }

    /**
     * 得到子节点列表
     */
    private List<SysMenu> getChildList(List<SysMenu> list, SysMenu t) {
        List<SysMenu> tlist = new ArrayList<SysMenu>();
        Iterator<SysMenu> it = list.iterator();
        while (it.hasNext()) {
            SysMenu n = (SysMenu) it.next();
            if (n.getPId().equals(t.getId())) {
                tlist.add(n);
            }
        }
        return tlist;
    }

    /**
     * 判断是否有子节点
     */
    private boolean hasChild(List<SysMenu> list, SysMenu t) {
        return getChildList(list, t).size() > 0;
    }

    @Override
    public void remove(Long menuId) {
        sysMenuDao.deleteById(menuId);
    }

    @Override
    public boolean hasChildByMenuId(Long menuId) {
        int result = sysMenuDao.hasChildByMenuId(menuId);
        return result > 0;
    }

    @Override
    public List<Long> selectMenuByRole(Long roleId) {
        return sysMenuDao.getMenuByRole(roleId);
    }
}
