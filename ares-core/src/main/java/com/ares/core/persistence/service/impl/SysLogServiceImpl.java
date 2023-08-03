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

import com.ares.core.model.query.SysLogQuery;
import com.ares.core.persistence.dao.ISysLogDao;
import com.ares.core.persistence.model.SysLog;
import com.ares.core.persistence.service.ISysLogService;
import com.ares.core.utils.SnowflakeIdWorker;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

/**
 * @description:
 * @author: Young 2020/01/27
 **/
@Service
public class SysLogServiceImpl implements ISysLogService {

    private ISysLogDao sysLogDao;

    @Autowired
    public SysLogServiceImpl(ISysLogDao sysLogDao) {
        this.sysLogDao = sysLogDao;
    }

    @Override
    public void insert(SysLog sysLog) {
        sysLog.setId(SnowflakeIdWorker.getUUID());
        sysLog.setCreateTime(new Date());
        sysLogDao.insert(sysLog);
    }

    @Override
    public List<SysLog> list(SysLogQuery sysLog) {
        List<SysLog> logList = sysLogDao.list(sysLog);
        return logList;
    }
}
