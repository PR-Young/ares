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

package com.ares.core.service.impl;

import com.ares.core.model.query.SysLoginInfoQuery;
import com.ares.core.model.vo.SysLoginInfo;
import com.ares.core.persistence.entity.SysLoginInfoDto;
import com.ares.core.persistence.manager.SysLoginInfoManager;
import com.ares.core.service.ISysLoginInfoService;
import com.github.pagehelper.PageInfo;
import io.github.linpeilie.Converter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class SysLoginInfoServiceImpl implements ISysLoginInfoService {

    private SysLoginInfoManager loginInfoManager;
    private Converter converter;

    @Autowired
    public SysLoginInfoServiceImpl(SysLoginInfoManager loginInfoManager, Converter converter) {
        this.loginInfoManager = loginInfoManager;
        this.converter = converter;
    }

    @Override
    public Long saveInfo(SysLoginInfo sysLoginInfo) {
        SysLoginInfoDto sysLoginInfoDto = converter.convert(sysLoginInfo, SysLoginInfoDto.class);
        return loginInfoManager.saveInfo(sysLoginInfoDto);
    }

    @Override
    public void remove() {
        loginInfoManager.remove();
    }

    @Override
    public PageInfo<SysLoginInfo> list(int pageNo, int pageSize, Map<String, Object> map) {
        PageInfo<SysLoginInfoDto> list = loginInfoManager.list(pageNo, pageSize, map);
        PageInfo<SysLoginInfo> pageInfo = list.convert(dto -> {
            SysLoginInfo v = converter.convert(dto, SysLoginInfo.class);
            return v;
        });
        return pageInfo;
    }

    @Override
    public void insert(SysLoginInfo obj) {
        SysLoginInfoDto sysLoginInfoDto = converter.convert(obj, SysLoginInfoDto.class);
        loginInfoManager.insert(sysLoginInfoDto);
    }

    @Override
    public void update(SysLoginInfo obj) {
        SysLoginInfoDto sysLoginInfoDto = converter.convert(obj, SysLoginInfoDto.class);
        loginInfoManager.update(sysLoginInfoDto);
    }

    @Override
    public void deleteByIds(List<Long> ids) {
        loginInfoManager.deleteByIds(ids);
    }

    @Override
    public SysLoginInfo getById(Long id) {
        return converter.convert(loginInfoManager.getById(id), SysLoginInfo.class);
    }

    @Override
    public PageInfo<SysLoginInfo> list(SysLoginInfoQuery obj) {
        List<SysLoginInfoDto> lists = loginInfoManager.selectList(obj);
        PageInfo<SysLoginInfoDto> pageInfo = new PageInfo<>(lists);
        PageInfo<SysLoginInfo> page = pageInfo.convert(dto -> {
            SysLoginInfo v = converter.convert(dto, SysLoginInfo.class);
            return v;
        });
        return page;
    }
}
