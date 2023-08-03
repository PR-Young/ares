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

import com.ares.core.model.query.SysPostQuery;
import com.ares.core.persistence.dao.ISysPostDao;
import com.ares.core.persistence.model.SysPost;
import com.ares.core.persistence.service.ISysPostService;
import com.ares.core.utils.SnowflakeIdWorker;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class SysPostServiceImpl implements ISysPostService {

    private ISysPostDao sysPostDao;

    @Autowired
    public SysPostServiceImpl(ISysPostDao sysPostDao) {
        this.sysPostDao = sysPostDao;
    }

    @Override
    public PageInfo<SysPost> list(int pageNo, int pageSize, Map<String, Object> map) {
        PageHelper.startPage(pageNo, pageSize);
        List<SysPost> lists = sysPostDao.list(map);
        PageInfo<SysPost> pageInfo = new PageInfo<>(lists);
        return pageInfo;
    }

    @Override
    public void insert(SysPost obj) {
        obj.setId(SnowflakeIdWorker.getUUID());
        obj.setCreateTime(new Date());
        sysPostDao.insert(obj);
    }

    @Override
    public void update(SysPost obj) {
        obj.setModifyTime(new Date());
        sysPostDao.update(obj);
    }

    @Override
    public void deleteByIds(List<String> ids) {
        sysPostDao.deleteByIds(ids);
    }

    @Override
    public SysPost getById(String id) {
        return sysPostDao.getById(id);
    }

    @Override
    public List<SysPost> list(SysPostQuery obj) {
        List<SysPost> lists = sysPostDao.selectList(obj);
        return lists;
    }

    @Override
    public List<SysPost> getAll() {
        return sysPostDao.list(new HashMap<>());
    }

}
