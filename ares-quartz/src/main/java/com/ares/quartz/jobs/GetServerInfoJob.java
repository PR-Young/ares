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

package com.ares.quartz.jobs;

import com.ares.core.model.server.Server;
import lombok.extern.slf4j.Slf4j;

/**
 * @description:
 * @author: Young
 * @date: 2023/4/20
 * @see: com.ares.quartz.jobs.GetServerInfoJob.java
 **/
@Slf4j
public class GetServerInfoJob {

    public void getServerInfo() {
        Server server = new Server();
        try {
            server.copyTo();
            log.info("*****************memory info******************");
            log.info("**total********free********used********usage**");
            log.info("  " + server.getMem().getTotal() + "        "
                    + server.getMem().getFree() + "        "
                    + server.getMem().getUsed() + "        "
                    + server.getMem().getUsage() + "  ");
            log.info("**********************************************");
        } catch (Exception e) {
            log.error("get server info error:", e);
        }


    }
}
