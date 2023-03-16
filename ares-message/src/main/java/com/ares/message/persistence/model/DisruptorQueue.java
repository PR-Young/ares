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

package com.ares.message.persistence.model;

import com.lmax.disruptor.RingBuffer;
import com.lmax.disruptor.dsl.Disruptor;
import lombok.Data;

import java.util.Iterator;
import java.util.List;

/**
 * @description:
 * @author: Young
 * @date: 2023/1/30
 * @see: com.ares.message.utils.DisruptorQueueUtil.java
 **/
@Data
public class DisruptorQueue<T> {

    private Disruptor<AresMessageEvent<T>> disruptor;
    private RingBuffer<AresMessageEvent<T>> ringBuffer;

    public DisruptorQueue(Disruptor<AresMessageEvent<T>> disruptor) {
        this.disruptor = disruptor;
        this.ringBuffer = disruptor.getRingBuffer();
        this.disruptor.start();
    }

    public void add(T obj) {
        if (null != obj) {
            long next = this.ringBuffer.next();
            try {
                AresMessageEvent<T> event = this.ringBuffer.get(next);
                event.setObj(obj);
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                this.ringBuffer.publish(next);
            }
        }
    }

    public void addAll(List<T> list) {
        if (null != list) {
            Iterator<T> iterator = list.iterator();
            while (iterator.hasNext()) {
                T next = iterator.next();
                if (null != next) {
                    this.add(next);
                }
            }
        }
    }

    public long cursor(){
        return this.disruptor.getRingBuffer().getCursor();
    }

    public void shutdown(){
        this.disruptor.shutdown();
    }
}
