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

package com.ares.core.persistence.manager.impl;


import com.ares.core.model.query.SysMenuQuery;
import com.ares.core.persistence.dao.ISysMenuDao;
import com.ares.core.persistence.entity.SysMenuDto;
import com.ares.core.persistence.manager.SysMenuManager;
import com.ares.core.utils.SnowflakeIdWorker;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * @description:
 * @author: Young 2020/01/23
 **/
@Service
public class SysMenuManagerImpl implements SysMenuManager {

    private ISysMenuDao sysMenuDao;

    @Autowired
    public SysMenuManagerImpl(ISysMenuDao sysMenuDao) {
        this.sysMenuDao = sysMenuDao;
    }


    @Override
    public List<SysMenuDto> list(Map<String, Object> map) {
        return sysMenuDao.list(map);
    }

    @Override
    public void insert(SysMenuDto obj) {
        obj.setId(SnowflakeIdWorker.getUUID());
        obj.setCreateTime(new Date());
        sysMenuDao.insert(obj);
    }

    @Override
    public void update(SysMenuDto obj) {
        obj.setModifyTime(new Date());
        sysMenuDao.update(obj);
    }

    @Override
    public void deleteByIds(List<Long> ids) {
        sysMenuDao.deleteByIds(ids);
    }

    @Override
    public SysMenuDto getById(Long id) {
        return sysMenuDao.getById(id);
    }

    @Override
    public PageInfo<SysMenuDto> list(int pageNo, int pageSize, Map<String, Object> map) {
        return null;
    }

    @Override
    public PageInfo<SysMenuDto> list(SysMenuQuery obj) {
        return null;
    }

    @Override
    public List<SysMenuDto> getMenuByUserId(Long userId) {
        return sysMenuDao.getMenuByUserId(userId);
    }

    @Override
    public SysMenuDto getByPId(Long pid) {
        return sysMenuDao.getByPId(pid);
    }


    @Override
    public List<SysMenuDto> selectListByUser(SysMenuQuery menu) {
        return sysMenuDao.selectListByUser(menu);
    }

    @Override
    public int deleteById(Long menuId) {
        return sysMenuDao.deleteById(menuId);
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

    @Override
    public List<SysMenuDto> selectList(SysMenuQuery menu) {
        return sysMenuDao.selectList(menu);
    }
}
