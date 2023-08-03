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

package com.ares.test;

import com.ares.message.factory.DisruptorQueueFactory;
import com.ares.message.handler.AresMessageHandler;
import com.ares.message.persistence.model.DisruptorQueue;
import com.ares.message.persistence.service.IDisruptorMessageService;
import com.ares.message.producer.AresMessageProducer;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.concurrent.atomic.AtomicInteger;


/**
 * @description:
 * @author: Young
 * @date: 2023/1/30
 * @see: com.ares.test.AresMessageTest.java
 **/
public class AresMessageTest extends AresBaseTest {

    @Autowired
    private IDisruptorMessageService disruptorMessageService;

    @Test
    public void testMq() throws InterruptedException {
        disruptorMessageService.send("hello world!");
        Thread.sleep(3 * 1000);
    }


    public static void main(String[] args) throws InterruptedException {
        AresMessageHandler<String> handler = new AresMessageHandler<String>();
        DisruptorQueue<String> disruptorQueue = DisruptorQueueFactory.getHandleEventsQueue(1, false, handler);
        AresMessageProducer<String> producer = new AresMessageProducer("生产者1", disruptorQueue, "test", new AtomicInteger(1));
        Thread thread = new Thread(producer);
        thread.start();

        Thread.sleep(3 * 1000);
        producer.stopThread();
    }


}
