package com.ares.core.persistence.service.impl;


import com.ares.core.persistence.dao.ISysMenuDao;
import com.ares.core.persistence.model.MetaVo;
import com.ares.core.persistence.model.RouterVo;
import com.ares.core.persistence.model.SysMenu;
import com.ares.core.persistence.model.SysUser;
import com.ares.core.model.tree.TreeSelect;
import com.ares.core.persistence.service.ISysMenuService;
import com.ares.core.utils.SnowflakeIdWorker;
import com.baomidou.mybatisplus.core.conditions.Wrapper;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;
import java.util.function.Function;
import java.util.stream.Collectors;

/**
 * @description:
 * @author: Young 2020/01/23
 **/
@Service
public class SysMenuServiceImpl implements ISysMenuService {

    private ISysMenuDao sysMenuDao;

    @Autowired
    public SysMenuServiceImpl(ISysMenuDao sysMenuDao) {
        this.sysMenuDao = sysMenuDao;
    }

    /**
     * 根据用户id获取用户角色如果用户为null 获取所有权限
     *
     * @return
     */
    @Override
    public List<SysMenu> getAll(String userId) {
        return sysMenuDao.getMenuByUserId(userId);
    }

    @Override
    public List<SysMenu> list(Map<String, Object> map) {
        return sysMenuDao.list(map);
    }

    @Override
    public void insert(SysMenu obj) {
        obj.setId(SnowflakeIdWorker.getUUID());
        obj.setCreateTime(new Date());
        sysMenuDao.insert(obj);
    }

    @Override
    public void update(SysMenu obj) {
        obj.setModifyTime(new Date());
        sysMenuDao.update(obj);
    }

    @Override
    public void deleteByIds(List<String> ids) {
        sysMenuDao.deleteByIds(ids);
    }

    @Override
    public SysMenu getById(String id) {
        return sysMenuDao.getById(id);
    }

    @Override
    public PageInfo<SysMenu> list(int pageNo, int pageSize, Map<String, Object> map) {
        return null;
    }

    @Override
    public List<SysMenu> list(SysMenu obj) {
        return null;
    }

    @Override
    public SysMenu getByPId(String pid) {
        return sysMenuDao.getByPId(pid);
    }


    @Override
    public List<RouterVo> buildMenus(List<SysMenu> menus, String parentId) {
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
    public List<SysMenu> selectMenuList(SysMenu menu, String userId) {
        List<SysMenu> menuList = null;
        if (SysUser.isAdmin(userId)) {
            menuList = sysMenuDao.selectList(menu);
        } else {
            menu.getParams().put("userId", userId);
            menuList = sysMenuDao.selectListByUser(menu);
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
            if ("0".equals(t.getPId())) {
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
        return getChildList(list, t).size() > 0 ? true : false;
    }

    @Override
    public void remove(String menuId) {
        sysMenuDao.deleteById(menuId);
    }

    @Override
    public boolean hasChildByMenuId(String menuId) {
        int result = sysMenuDao.hasChildByMenuId(menuId);
        return result > 0 ? true : false;
    }

    @Override
    public List<String> selectMenuByRole(String roleId) {
        return sysMenuDao.getMenuByRole(roleId);
    }

    @Override
    public boolean saveBatch(Collection entityList, int batchSize) {
        return false;
    }

    @Override
    public boolean saveOrUpdateBatch(Collection entityList, int batchSize) {
        return false;
    }

    @Override
    public boolean updateBatchById(Collection entityList, int batchSize) {
        return false;
    }

    @Override
    public boolean saveOrUpdate(Object entity) {
        return false;
    }

    @Override
    public Object getOne(Wrapper queryWrapper, boolean throwEx) {
        return null;
    }

    @Override
    public Map<String, Object> getMap(Wrapper queryWrapper) {
        return null;
    }

    @Override
    public BaseMapper getBaseMapper() {
        return null;
    }

    @Override
    public Class getEntityClass() {
        return null;
    }

    @Override
    public Object getObj(Wrapper queryWrapper, Function mapper) {
        return null;
    }
}