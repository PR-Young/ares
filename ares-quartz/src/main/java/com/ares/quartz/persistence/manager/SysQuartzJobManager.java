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

package com.ares.quartz.persistence.manager;

import com.ares.core.persistence.manager.BaseManager;
import com.ares.quartz.model.query.SysQuartzJobQuery;
import com.ares.quartz.persistence.entity.SysQuartzJobDto;

import java.util.List;

/**
 * @description:
 * @author: Young 2020/01/29
 **/
public interface SysQuartzJobManager extends BaseManager<SysQuartzJobDto, SysQuartzJobQuery> {

    int checkUnique(String jobName);

    int resumeJob(SysQuartzJobDto job);

    int pauseJob(SysQuartzJobDto job);

    List<SysQuartzJobDto> selectJobList(SysQuartzJobQuery job);

}
