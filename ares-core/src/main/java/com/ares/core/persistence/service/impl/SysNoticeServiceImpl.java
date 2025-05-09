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

import com.ares.core.model.query.SysNoticeQuery;
import com.ares.core.model.vo.SysNotice;
import com.ares.core.model.vo.SysNoticeRead;
import com.ares.core.persistence.dao.ISysNoticeDao;
import com.ares.core.persistence.dao.ISysNoticeReadDao;
import com.ares.core.persistence.entity.SysNoticeDto;
import com.ares.core.persistence.entity.SysNoticeReadDto;
import com.ares.core.persistence.service.ISysNoticeService;
import com.ares.core.utils.SnowflakeIdWorker;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import io.github.linpeilie.Converter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

@Service
public class SysNoticeServiceImpl implements ISysNoticeService {

    private ISysNoticeDao sysNoticeDao;
    private ISysNoticeReadDao noticeReadDao;
    private Converter converter;

    @Autowired
    public SysNoticeServiceImpl(ISysNoticeDao sysNoticeDao, ISysNoticeReadDao noticeReadDao, Converter converter) {
        this.sysNoticeDao = sysNoticeDao;
        this.noticeReadDao = noticeReadDao;
        this.converter = converter;
    }

    @Override
    public PageInfo<SysNotice> list(int pageNo, int pageSize, Map<String, Object> map) {
        PageHelper.startPage(pageNo, pageSize);
        List<SysNotice> lists = converter.convert(sysNoticeDao.list(map), SysNotice.class);
        PageInfo<SysNotice> pageInfo = new PageInfo<>(lists);
        return pageInfo;
    }

    @Override
    public void insert(SysNotice obj) {
        obj.setId(SnowflakeIdWorker.getUUID());
        obj.setCreateTime(new Date());
        SysNoticeDto sysNoticeDto = converter.convert(obj, SysNoticeDto.class);
        sysNoticeDao.insert(sysNoticeDto);
    }

    @Override
    public void update(SysNotice obj) {
        obj.setModifyTime(new Date());
        SysNoticeDto sysNoticeDto = converter.convert(obj, SysNoticeDto.class);
        sysNoticeDao.update(sysNoticeDto);
    }

    @Override
    public void deleteByIds(List<Long> ids) {
        sysNoticeDao.deleteByIds(ids);
    }

    @Override
    public SysNotice getById(Long id) {
        return converter.convert(sysNoticeDao.getById(id), SysNotice.class);
    }

    @Override
    public PageInfo<SysNotice> list(SysNoticeQuery obj) {
        List<SysNoticeDto> lists = sysNoticeDao.selectList(obj);
        PageInfo<SysNoticeDto> pageInfo = new PageInfo<>(lists);
        PageInfo<SysNotice> page = pageInfo.convert(dto -> {
            SysNotice v = converter.convert(dto, SysNotice.class);
            return v;
        });
        return page;
    }

    @Override
    public int noticeNum(Long userId) {
        return sysNoticeDao.noticeNum(userId);
    }

    @Override
    public List<SysNotice> getNotices(Long userId) {
        List<SysNotice> noticeList = converter.convert(sysNoticeDao.getNotices(), SysNotice.class);
        List<SysNoticeRead> noticeReads = new ArrayList<>();
        if (null != noticeList && noticeList.size() > 0) {
            List<Long> noticeReadList = noticeReadDao.getByUser(userId);
            for (SysNotice sysNotice : noticeList) {
                if (noticeReadList.contains(sysNotice.getId())) {
                    continue;
                }
                SysNoticeRead sysNoticeRead = new SysNoticeRead();
                sysNoticeRead.setId(SnowflakeIdWorker.getUUID());
                sysNoticeRead.setNoticeId(sysNotice.getId());
                sysNoticeRead.setUserId(userId);
                sysNoticeRead.setCreator(userId);
                sysNoticeRead.setCreateTime(new Date());
                noticeReads.add(sysNoticeRead);
            }
        }
        if (null != noticeReads && noticeReads.size() > 0) {
            List<SysNoticeReadDto> noticeReadDtos = converter.convert(noticeReads, SysNoticeReadDto.class);
            noticeReadDao.batchInsert(noticeReadDtos);
        }
        return noticeList;
    }
}
