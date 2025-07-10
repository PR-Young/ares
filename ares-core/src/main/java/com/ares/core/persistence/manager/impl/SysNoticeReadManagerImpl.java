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

import com.ares.core.model.query.SysNoticeReadQuery;
import com.ares.core.persistence.dao.ISysNoticeReadDao;
import com.ares.core.persistence.entity.SysNoticeReadDto;
import com.ares.core.persistence.manager.SysNoticeReadManager;
import com.ares.core.utils.SnowflakeIdWorker;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;
import java.util.Map;

@Service
public class SysNoticeReadManagerImpl implements SysNoticeReadManager {

    private ISysNoticeReadDao sysNoticeReadDao;

    @Autowired
    public SysNoticeReadManagerImpl(ISysNoticeReadDao sysNoticeReadDao) {
        this.sysNoticeReadDao = sysNoticeReadDao;
    }

    @Override
    public PageInfo<SysNoticeReadDto> list(int pageNo, int pageSize, Map<String, Object> map) {
        PageHelper.startPage(pageNo, pageSize);
        List<SysNoticeReadDto> lists = sysNoticeReadDao.list(map);
        PageInfo<SysNoticeReadDto> pageInfo = new PageInfo<>(lists);
        return pageInfo;
    }

    @Override
    public void insert(SysNoticeReadDto obj) {
        obj.setId(SnowflakeIdWorker.getUUID());
        obj.setCreateTime(new Date());
        sysNoticeReadDao.insert(obj);
    }

    @Override
    public void update(SysNoticeReadDto obj) {
        obj.setModifyTime(new Date());
        sysNoticeReadDao.update(obj);
    }

    @Override
    public void deleteByIds(List<Long> ids) {
        sysNoticeReadDao.deleteByIds(ids);
    }

    @Override
    public SysNoticeReadDto getById(Long id) {
        return sysNoticeReadDao.getById(id);
    }

    @Override
    public PageInfo<SysNoticeReadDto> list(SysNoticeReadQuery obj) {
        List<SysNoticeReadDto> lists = sysNoticeReadDao.selectList(obj);
        PageInfo<SysNoticeReadDto> pageInfo = new PageInfo<>(lists);
        return pageInfo;
    }

    @Override
    public List<SysNoticeReadDto> list(Map<String, Object> params) {
        return sysNoticeReadDao.list(params);
    }

    @Override
    public List<SysNoticeReadDto> selectList(SysNoticeReadQuery obj) {
        return sysNoticeReadDao.selectList(obj);
    }

    @Override
    public List<Long> getByUserId(Long userId) {
        return sysNoticeReadDao.getByUser(userId);
    }
}
