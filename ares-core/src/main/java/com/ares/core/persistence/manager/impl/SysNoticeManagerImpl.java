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

import com.ares.core.model.query.SysNoticeQuery;
import com.ares.core.persistence.dao.ISysNoticeDao;
import com.ares.core.persistence.dao.ISysNoticeReadDao;
import com.ares.core.persistence.entity.SysNoticeDto;
import com.ares.core.persistence.entity.SysNoticeReadDto;
import com.ares.core.persistence.manager.SysNoticeManager;
import com.ares.core.utils.SnowflakeIdWorker;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

@Service
public class SysNoticeManagerImpl implements SysNoticeManager {

    private ISysNoticeDao sysNoticeDao;
    private ISysNoticeReadDao noticeReadDao;

    @Autowired
    public SysNoticeManagerImpl(ISysNoticeDao sysNoticeDao, ISysNoticeReadDao noticeReadDao) {
        this.sysNoticeDao = sysNoticeDao;
        this.noticeReadDao = noticeReadDao;
    }

    @Override
    public PageInfo<SysNoticeDto> list(int pageNo, int pageSize, Map<String, Object> map) {
        PageHelper.startPage(pageNo, pageSize);
        List<SysNoticeDto> lists = sysNoticeDao.list(map);
        PageInfo<SysNoticeDto> pageInfo = new PageInfo<>(lists);
        return pageInfo;
    }

    @Override
    public void insert(SysNoticeDto obj) {
        obj.setId(SnowflakeIdWorker.getUUID());
        obj.setCreateTime(new Date());
        sysNoticeDao.insert(obj);
    }

    @Override
    public void update(SysNoticeDto obj) {
        obj.setModifyTime(new Date());
        sysNoticeDao.update(obj);
    }

    @Override
    public void deleteByIds(List<Long> ids) {
        sysNoticeDao.deleteByIds(ids);
    }

    @Override
    public SysNoticeDto getById(Long id) {
        return sysNoticeDao.getById(id);
    }

    @Override
    public PageInfo<SysNoticeDto> list(SysNoticeQuery obj) {
        List<SysNoticeDto> lists = sysNoticeDao.selectList(obj);
        PageInfo<SysNoticeDto> pageInfo = new PageInfo<>(lists);
        return pageInfo;
    }

    @Override
    public List<SysNoticeDto> list(Map<String, Object> params) {
        return sysNoticeDao.list(params);
    }

    @Override
    public List<SysNoticeDto> selectList(SysNoticeQuery obj) {
        return sysNoticeDao.selectList(obj);
    }

    @Override
    public int noticeNum(Long userId) {
        return sysNoticeDao.noticeNum(userId);
    }

    @Transactional
    @Override
    public List<SysNoticeDto> getNotices(Long userId) {
        List<SysNoticeDto> noticeList = sysNoticeDao.getNotices();
        List<SysNoticeReadDto> noticeReads = new ArrayList<>();
        if (null != noticeList && noticeList.size() > 0) {
            List<Long> noticeReadList = noticeReadDao.getByUser(userId);
            for (SysNoticeDto sysNotice : noticeList) {
                if (noticeReadList.contains(sysNotice.getId())) {
                    continue;
                }
                SysNoticeReadDto sysNoticeRead = new SysNoticeReadDto();
                sysNoticeRead.setId(SnowflakeIdWorker.getUUID());
                sysNoticeRead.setNoticeId(sysNotice.getId());
                sysNoticeRead.setUserId(userId);
                sysNoticeRead.setCreator(userId);
                sysNoticeRead.setCreateTime(new Date());
                noticeReads.add(sysNoticeRead);
            }
        }
        if (null != noticeReads && noticeReads.size() > 0) {
            noticeReadDao.batchInsert(noticeReads);
        }
        return noticeList;
    }


}
