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

import com.ares.core.model.query.SysLogQuery;
import com.ares.core.model.vo.SysLog;
import com.ares.core.persistence.entity.SysLogDto;
import com.ares.core.persistence.manager.SysLogManager;
import com.ares.core.service.ISysLogService;
import com.github.pagehelper.PageInfo;
import io.github.linpeilie.Converter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @description:
 * @author: Young 2020/01/27
 **/
@Service
public class SysLogServiceImpl implements ISysLogService {

    private SysLogManager logManager;
    private Converter converter;

    @Autowired
    public SysLogServiceImpl(SysLogManager logManager, Converter converter) {
        this.logManager = logManager;
        this.converter = converter;
    }

    @Override
    public void insert(SysLog sysLog) {
        SysLogDto sysLogDto = converter.convert(sysLog, SysLogDto.class);
        logManager.insert(sysLogDto);
    }

    @Override
    public PageInfo<SysLog> list(SysLogQuery sysLog) {
        PageInfo<SysLogDto> pageInfo = logManager.list(sysLog);
        PageInfo<SysLog> page = pageInfo.convert(dto -> {
            SysLog v = converter.convert(dto, SysLog.class);
            return v;
        });
        return page;
    }
}
