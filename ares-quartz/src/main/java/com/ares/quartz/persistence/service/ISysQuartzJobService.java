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

package com.ares.quartz.persistence.service;

import com.ares.core.persistence.service.IBaseService;
import com.ares.quartz.persistence.model.SysQuartzJob;
import org.quartz.SchedulerException;

import java.util.List;

/**
 * @description:
 * @author: Young 2020/01/29
 **/
public interface ISysQuartzJobService extends IBaseService<SysQuartzJob> {

    public int checkUnique(String jobName);

    public int resumeJob(SysQuartzJob job);

    public int pauseJob(SysQuartzJob job);

    public int changeStatus(SysQuartzJob job);

    public void run(SysQuartzJob job) throws SchedulerException ;

    public List<SysQuartzJob> selectJobList(SysQuartzJob job);

}
