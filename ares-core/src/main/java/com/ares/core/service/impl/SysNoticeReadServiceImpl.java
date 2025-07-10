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

import com.ares.core.model.query.SysNoticeReadQuery;
import com.ares.core.model.vo.SysNoticeRead;
import com.ares.core.persistence.entity.SysNoticeReadDto;
import com.ares.core.persistence.manager.SysNoticeReadManager;
import com.ares.core.service.ISysNoticeReadService;
import com.github.pagehelper.PageInfo;
import io.github.linpeilie.Converter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class SysNoticeReadServiceImpl implements ISysNoticeReadService {

    private SysNoticeReadManager noticeReadManager;
    private Converter converter;

    @Autowired
    public SysNoticeReadServiceImpl(SysNoticeReadManager noticeReadManager, Converter converter) {
        this.noticeReadManager = noticeReadManager;
        this.converter = converter;
    }

    @Override
    public PageInfo<SysNoticeRead> list(int pageNo, int pageSize, Map<String, Object> map) {
        PageInfo<SysNoticeReadDto> list = noticeReadManager.list(pageNo, pageSize, map);
        PageInfo<SysNoticeRead> pageInfo = list.convert(dto -> {
            SysNoticeRead v = converter.convert(dto, SysNoticeRead.class);
            return v;
        });
        return pageInfo;
    }

    @Override
    public void insert(SysNoticeRead obj) {
        SysNoticeReadDto sysNoticeReadDto = converter.convert(obj, SysNoticeReadDto.class);
        noticeReadManager.insert(sysNoticeReadDto);
    }

    @Override
    public void update(SysNoticeRead obj) {
        SysNoticeReadDto sysNoticeReadDto = converter.convert(obj, SysNoticeReadDto.class);
        noticeReadManager.update(sysNoticeReadDto);
    }

    @Override
    public void deleteByIds(List<Long> ids) {
        noticeReadManager.deleteByIds(ids);
    }

    @Override
    public SysNoticeRead getById(Long id) {
        return converter.convert(noticeReadManager.getById(id), SysNoticeRead.class);
    }

    @Override
    public PageInfo<SysNoticeRead> list(SysNoticeReadQuery obj) {
        List<SysNoticeReadDto> lists = noticeReadManager.selectList(obj);
        PageInfo<SysNoticeReadDto> pageInfo = new PageInfo<>(lists);
        PageInfo<SysNoticeRead> page = pageInfo.convert(dto -> {
            SysNoticeRead v = converter.convert(dto, SysNoticeRead.class);
            return v;
        });
        return page;
    }
}
