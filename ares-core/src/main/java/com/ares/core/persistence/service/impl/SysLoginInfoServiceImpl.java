/*
 *
 *  * !******************************************************************************
 *  *  * Copyright (c) 2021 - 9999, ARES
 *  *  *
 *  *  * Licensed under the Apache License, Version 2.0 (the "License");
 *  *  * you may not use this file except in compliance with the License.
 *  *  * You may obtain a copy of the License at
 *  *  *
 *  *  *        http://www.apache.org/licenses/LICENSE-2.0
 *  *  *
 *  *  * Unless required by applicable law or agreed to in writing, software
 *  *  * distributed under the License is distributed on an "AS IS" BASIS,
 *  *  * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  *  * See the License for the specific language governing permissions and
 *  *  * limitations under the License.
 *  *  *****************************************************************************
 *
 */

package com.ares.core.persistence.service.impl;

import com.ares.core.model.query.SysLoginInfoQuery;
import com.ares.core.model.vo.SysLoginInfo;
import com.ares.core.persistence.dao.ISysLoginInfoDao;
import com.ares.core.persistence.entity.SysLoginInfoDto;
import com.ares.core.persistence.service.ISysLoginInfoService;
import com.ares.core.utils.SnowflakeIdWorker;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import io.github.linpeilie.Converter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;
import java.util.Map;

@Service
public class SysLoginInfoServiceImpl implements ISysLoginInfoService {

    private ISysLoginInfoDao sysLoginInfoDao;
    private Converter converter;

    @Autowired
    public SysLoginInfoServiceImpl(ISysLoginInfoDao sysLoginInfoDao, Converter converter) {
        this.sysLoginInfoDao = sysLoginInfoDao;
        this.converter = converter;
    }

    @Override
    public Long saveInfo(SysLoginInfo sysLoginInfo) {
        Long id = SnowflakeIdWorker.getUUID();
        sysLoginInfo.setId(id);
        SysLoginInfoDto sysLoginInfoDto = converter.convert(sysLoginInfo, SysLoginInfoDto.class);
        sysLoginInfoDao.insert(sysLoginInfoDto);
        return id;
    }

    @Override
    public void remove() {
        sysLoginInfoDao.remove();
    }

    @Override
    public PageInfo<SysLoginInfo> list(int pageNo, int pageSize, Map<String, Object> map) {
        PageHelper.startPage(pageNo, pageSize);
        List<SysLoginInfo> lists = converter.convert(sysLoginInfoDao.list(map), SysLoginInfo.class);
        PageInfo<SysLoginInfo> pageInfo = new PageInfo<>(lists);
        return pageInfo;
    }

    @Override
    public void insert(SysLoginInfo obj) {
        obj.setId(SnowflakeIdWorker.getUUID());
        obj.setCreateTime(new Date());
        SysLoginInfoDto sysLoginInfoDto = converter.convert(obj, SysLoginInfoDto.class);
        sysLoginInfoDao.insert(sysLoginInfoDto);
    }

    @Override
    public void update(SysLoginInfo obj) {
        obj.setModifyTime(new Date());
        SysLoginInfoDto sysLoginInfoDto = converter.convert(obj, SysLoginInfoDto.class);
        sysLoginInfoDao.update(sysLoginInfoDto);
    }

    @Override
    public void deleteByIds(List<Long> ids) {
        sysLoginInfoDao.deleteByIds(ids);
    }

    @Override
    public SysLoginInfo getById(Long id) {
        return converter.convert(sysLoginInfoDao.getById(id), SysLoginInfo.class);
    }

    @Override
    public List<SysLoginInfo> list(SysLoginInfoQuery obj) {
        List<SysLoginInfo> lists = converter.convert(sysLoginInfoDao.selectList(obj), SysLoginInfo.class);
        return lists;
    }
}
