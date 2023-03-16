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

package com.ares.message.handler;

import com.ares.message.persistence.model.AresMessageEvent;
import com.lmax.disruptor.EventHandler;
import com.lmax.disruptor.WorkHandler;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * @description:
 * @author: Young
 * @date: 2023/1/30
 * @see: com.ares.message.handler.AresMessageHandler.java
 **/
public class AresMessageHandler<T> implements EventHandler<AresMessageEvent<T>>, WorkHandler<AresMessageEvent<T>> {
    private static Logger logger = LoggerFactory.getLogger(AresMessageHandler.class);

    public AresMessageHandler() {
    }

    @Override
    public void onEvent(AresMessageEvent<T> aresMessageEvent, long l, boolean b) throws Exception {
        if (null != aresMessageEvent) {
            logger.info("------>拿到队列中的数据：" + aresMessageEvent);
        }
    }

    @Override
    public void onEvent(AresMessageEvent<T> aresMessageEvent) throws Exception {
        if (null != aresMessageEvent) {
            logger.info("------>拿到队列中的数据：" + aresMessageEvent);
        }
    }
}
