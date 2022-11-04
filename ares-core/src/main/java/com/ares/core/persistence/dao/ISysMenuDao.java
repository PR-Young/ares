package com.ares.core.persistence.dao;


import com.ares.core.persistence.model.system.SysMenu;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

/**
 * @description:
 * @author: Young 2020/01/23
 **/
@Mapper
public interface ISysMenuDao extends IBaseDao<SysMenu> {

    List<SysMenu> getMenuByUserId(String userId);

    SysMenu getByPId(String pid);

    List<String> getMenuByRole(String roleId);

    List<SysMenu> selectListByUser(SysMenu menu);

    int deleteById(String menuId);

    int hasChildByMenuId(String menuId);

}
