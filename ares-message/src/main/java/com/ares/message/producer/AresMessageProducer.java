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

package com.ares.message.producer;


import com.ares.message.persistence.model.DisruptorQueue;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.Calendar;
import java.util.concurrent.atomic.AtomicInteger;

/**
 * @description:
 * @author: Young
 * @date: 2023/1/30
 * @see: com.ares.message.producer.AresMessageProducer.java
 **/
public class AresMessageProducer<T> implements Runnable {
    private static Logger logger = LoggerFactory.getLogger(AresMessageProducer.class);
    private String name;
    private DisruptorQueue disruptorQueue;
    private T data;
    private volatile boolean flag = true;
    private static AtomicInteger count = new AtomicInteger();
    private AtomicInteger frequency;

    public AresMessageProducer(String name, DisruptorQueue disruptorQueue, T data, AtomicInteger frequency) {
        this.name = name;
        this.disruptorQueue = disruptorQueue;
        this.data = data;
        this.frequency = frequency;
    }

    @Override
    public void run() {
        try {
            logger.info(now() + this.name + "------>:线程启动");
            if (frequency.get() > 0) {
                for (int i = 0; i < frequency.get(); i++) {
                    disruptorQueue.add(data);
                    logger.info(now() + this.name + "---" + (i + 1) + "--->:存入" + data + "到队列中。");
                }
            } else {
                while (flag) {
                    disruptorQueue.add(data);
                    logger.info(now() + this.name + "------>:存入" + data + "到队列中。");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            logger.info(now() + this.name + "------>:退出线程。");
        }
    }

    public void stopThread() {
        this.flag = false;
    }

    /**
     * 获取当前时间（分:秒）
     *
     * @return
     */
    public String now() {
        Calendar now = Calendar.getInstance();
        return "[" + now.get(Calendar.MINUTE) + ":" + now.get(Calendar.SECOND) + "] ";
    }
}
