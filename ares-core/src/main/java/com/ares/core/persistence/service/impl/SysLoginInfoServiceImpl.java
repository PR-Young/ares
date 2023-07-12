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

import com.ares.core.common.security.SecurityUtils;
import com.ares.core.persistence.dao.ISysLoginInfoDao;
import com.ares.core.persistence.model.SysLoginInfo;
import com.ares.core.persistence.service.ISysLoginInfoService;
import com.ares.core.utils.SnowflakeIdWorker;
import com.ares.core.utils.StringUtils;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.baomidou.mybatisplus.extension.toolkit.SqlHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;

@Service
public class SysLoginInfoServiceImpl extends ServiceImpl<ISysLoginInfoDao, SysLoginInfo> implements ISysLoginInfoService {

    private ISysLoginInfoDao sysLoginInfoDao;

    @Autowired
    public SysLoginInfoServiceImpl(ISysLoginInfoDao sysLoginInfoDao) {
        this.sysLoginInfoDao = sysLoginInfoDao;
    }

    public String saveInfo(SysLoginInfo sysLoginInfo) {
        String id = SnowflakeIdWorker.getUUID();
        sysLoginInfo.setId(id);
        SqlHelper.retBool(this.getBaseMapper().insert(sysLoginInfo));
        return id;
    }

    @Transactional(
            rollbackFor = {Exception.class}
    )
    public boolean saveOrUpdate(SysLoginInfo sysLoginInfo) {
        if (null == sysLoginInfo) {
            return false;
        } else {
            if (StringUtils.isEmpty(sysLoginInfo.getId())) {
                sysLoginInfo.setId(SnowflakeIdWorker.getUUID());
                sysLoginInfo.setCreator(SecurityUtils.getUser().getId());
                sysLoginInfo.setCreateTime(new Date());
                sysLoginInfoDao.insert(sysLoginInfo);
            } else {
                sysLoginInfo.setModifier(SecurityUtils.getUser().getId());
                sysLoginInfo.setModifyTime(new Date());
                sysLoginInfoDao.updateById(sysLoginInfo);
            }
        }
        return true;
    }

    //public PageInfo<SysLoginInfo> list(int pageNo, int pageSize, Map<String, Object> map) {
    //    PageHelper.startPage(pageNo, pageSize);
    //    List<SysLoginInfo> lists = sysLoginInfoDao.list(map);
    //    PageInfo<SysLoginInfo> pageInfo = new PageInfo<>(lists);
    //    return pageInfo;
    //}
    //
    //public void insert(SysLoginInfo obj) {
    //    obj.setId(SnowflakeIdWorker.getUUID());
    //    obj.setCreateTime(new Date());
    //    sysLoginInfoDao.insert(obj);
    //}
    //
    //public void update(SysLoginInfo obj) {
    //    obj.setModifyTime(new Date());
    //    sysLoginInfoDao.update(obj);
    //}
    //
    //public void deleteByIds(List<String> ids) {
    //    sysLoginInfoDao.deleteByIds(ids);
    //}
    //
    //public SysLoginInfo getById(String id) {
    //    return sysLoginInfoDao.getById(id);
    //}
    //
    //public List<SysLoginInfo> list(SysLoginInfo obj) {
    //    List<SysLoginInfo> lists = sysLoginInfoDao.selectList(obj);
    //    return lists;
    //}


}
