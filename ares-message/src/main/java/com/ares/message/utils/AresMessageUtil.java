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

package com.ares.message.utils;

import com.ares.message.factory.DisruptorQueueFactory;
import com.ares.message.handler.AresMessageHandler;
import com.ares.message.persistence.model.AresMessage;
import com.ares.message.persistence.model.DisruptorQueue;
import com.ares.message.producer.AresMessageProducer;

import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.atomic.AtomicInteger;

/**
 * @description:
 * @author: Young
 * @date: 2023/1/31
 * @see: com.ares.message.utils.AresMessageUtil.java
 **/
public class AresMessageUtil {

    private static ExecutorService executorService = Executors.newCachedThreadPool();

    public static void sendMessage(AresMessage message, AresMessageHandler... handler) {
        DisruptorQueue<String> disruptorQueue = DisruptorQueueFactory.getHandleEventsQueue(message.getBufferSize(), message.isMoreProducer(), handler);
        AresMessageProducer<String> producer = new AresMessageProducer(message.getName(), disruptorQueue, message.getData(), new AtomicInteger(message.getFrequency()));
        executorService.execute(producer);
    }

}
