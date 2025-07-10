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

package com.ares.core.service;

import com.ares.core.model.query.SysLogQuery;
import com.ares.core.model.vo.SysLog;
import com.github.pagehelper.PageInfo;

/**
 * @description:
 * @author: Young 2020/01/27
 **/
public interface ISysLogService {

    void insert(SysLog sysLog);

    PageInfo<SysLog> list(SysLogQuery sysLog);

}
