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
