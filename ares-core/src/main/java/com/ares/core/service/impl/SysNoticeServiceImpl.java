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

import com.ares.core.model.query.SysNoticeQuery;
import com.ares.core.model.vo.SysNotice;
import com.ares.core.persistence.entity.SysNoticeDto;
import com.ares.core.persistence.manager.SysNoticeManager;
import com.ares.core.service.ISysNoticeService;
import com.github.pagehelper.PageInfo;
import io.github.linpeilie.Converter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class SysNoticeServiceImpl implements ISysNoticeService {

    private SysNoticeManager noticeManager;
    private Converter converter;

    @Autowired
    public SysNoticeServiceImpl(SysNoticeManager noticeManager, Converter converter) {
        this.noticeManager = noticeManager;
        this.converter = converter;
    }

    @Override
    public PageInfo<SysNotice> list(int pageNo, int pageSize, Map<String, Object> map) {
        PageInfo<SysNoticeDto> list = noticeManager.list(pageNo, pageSize, map);
        PageInfo<SysNotice> pageInfo = list.convert(dto -> {
            SysNotice v = converter.convert(dto, SysNotice.class);
            return v;
        });
        return pageInfo;
    }

    @Override
    public void insert(SysNotice obj) {
        SysNoticeDto sysNoticeDto = converter.convert(obj, SysNoticeDto.class);
        noticeManager.insert(sysNoticeDto);
    }

    @Override
    public void update(SysNotice obj) {
        SysNoticeDto sysNoticeDto = converter.convert(obj, SysNoticeDto.class);
        noticeManager.update(sysNoticeDto);
    }

    @Override
    public void deleteByIds(List<Long> ids) {
        noticeManager.deleteByIds(ids);
    }

    @Override
    public SysNotice getById(Long id) {
        return converter.convert(noticeManager.getById(id), SysNotice.class);
    }

    @Override
    public PageInfo<SysNotice> list(SysNoticeQuery obj) {
        List<SysNoticeDto> lists = noticeManager.selectList(obj);
        PageInfo<SysNoticeDto> pageInfo = new PageInfo<>(lists);
        PageInfo<SysNotice> page = pageInfo.convert(dto -> {
            SysNotice v = converter.convert(dto, SysNotice.class);
            return v;
        });
        return page;
    }

    @Override
    public int noticeNum(Long userId) {
        return noticeManager.noticeNum(userId);
    }

    @Override
    public List<SysNotice> getNotices(Long userId) {
        return converter.convert(noticeManager.getNotices(userId), SysNotice.class);
    }
}
