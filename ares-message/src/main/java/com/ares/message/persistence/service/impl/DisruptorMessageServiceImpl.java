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

package com.ares.message.persistence.service.impl;

import com.ares.message.persistence.model.AresMessageEvent;
import com.ares.message.persistence.service.IDisruptorMessageService;
import com.lmax.disruptor.RingBuffer;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @description:
 * @author: Young
 * @date: 2023/1/30
 * @see: com.ares.message.persistence.service.impl.DisruptorMessageServiceImpl.java
 **/
@Service
public class DisruptorMessageServiceImpl implements IDisruptorMessageService {
    private static Logger logger = LoggerFactory.getLogger(DisruptorMessageServiceImpl.class);
    private RingBuffer<AresMessageEvent<String>> aresStringMessageModel;

    @Autowired
    public DisruptorMessageServiceImpl(RingBuffer<AresMessageEvent<String>> aresStringMessageModel) {
        this.aresStringMessageModel = aresStringMessageModel;
    }


    @Override
    public void send(String message) {
        if (null != message) {
            long next = aresStringMessageModel.next();
            try {
                AresMessageEvent<String> event = aresStringMessageModel.get(next);
                event.setObj(message);
                logger.info("存入" + message + "到队列中。");
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                aresStringMessageModel.publish(next);
            }
        }
    }
}
