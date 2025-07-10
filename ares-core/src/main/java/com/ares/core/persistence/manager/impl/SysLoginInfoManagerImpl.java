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

import com.ares.core.model.query.SysLoginInfoQuery;
import com.ares.core.persistence.dao.ISysLoginInfoDao;
import com.ares.core.persistence.entity.SysLoginInfoDto;
import com.ares.core.persistence.manager.SysLoginInfoManager;
import com.ares.core.utils.SnowflakeIdWorker;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;
import java.util.Map;

@Service
public class SysLoginInfoManagerImpl implements SysLoginInfoManager {

    private ISysLoginInfoDao sysLoginInfoDao;

    @Autowired
    public SysLoginInfoManagerImpl(ISysLoginInfoDao sysLoginInfoDao) {
        this.sysLoginInfoDao = sysLoginInfoDao;
    }


    @Override
    public void remove() {
        sysLoginInfoDao.remove();
    }

    @Override
    public Long saveInfo(SysLoginInfoDto sysLoginInfo) {
        Long id = SnowflakeIdWorker.getUUID();
        sysLoginInfo.setId(id);
        sysLoginInfoDao.insert(sysLoginInfo);
        return id;
    }

    @Override
    public PageInfo<SysLoginInfoDto> list(int pageNo, int pageSize, Map<String, Object> map) {
        PageHelper.startPage(pageNo, pageSize);
        List<SysLoginInfoDto> lists = sysLoginInfoDao.list(map);
        PageInfo<SysLoginInfoDto> pageInfo = new PageInfo<>(lists);
        return pageInfo;
    }

    @Override
    public void insert(SysLoginInfoDto obj) {
        obj.setId(SnowflakeIdWorker.getUUID());
        obj.setCreateTime(new Date());
        sysLoginInfoDao.insert(obj);
    }

    @Override
    public void update(SysLoginInfoDto obj) {
        obj.setModifyTime(new Date());
        sysLoginInfoDao.update(obj);
    }

    @Override
    public void deleteByIds(List<Long> ids) {
        sysLoginInfoDao.deleteByIds(ids);
    }

    @Override
    public SysLoginInfoDto getById(Long id) {
        return sysLoginInfoDao.getById(id);
    }

    @Override
    public PageInfo<SysLoginInfoDto> list(SysLoginInfoQuery obj) {
        List<SysLoginInfoDto> lists = sysLoginInfoDao.selectList(obj);
        PageInfo<SysLoginInfoDto> pageInfo = new PageInfo<>(lists);
        return pageInfo;
    }

    @Override
    public List<SysLoginInfoDto> list(Map<String, Object> params) {
        return sysLoginInfoDao.list(params);
    }

    @Override
    public List<SysLoginInfoDto> selectList(SysLoginInfoQuery obj) {
        return sysLoginInfoDao.selectList(obj);
    }
}
