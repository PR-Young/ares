package com.ares.message.factory;

import com.ares.message.handler.AresMessageHandler;
import com.ares.message.persistence.model.AresMessageEvent;
import com.ares.message.persistence.model.DisruptorQueue;
import com.lmax.disruptor.SleepingWaitStrategy;
import com.lmax.disruptor.dsl.Disruptor;
import com.lmax.disruptor.dsl.ProducerType;

import java.util.concurrent.Executors;

/**
 * @description:
 * @author: Young
 * @date: 2023/1/30
 * @see: com.ares.message.factory.DisruptorQueueFactory.java
 **/
public class DisruptorQueueFactory {

    public DisruptorQueueFactory() {
    }

    /**
     * 创建"点对点模式"的操作队列，即同一事件会被一组消费者其中之一消费
     *
     * @param queueSize
     * @param isMoreProducer
     * @param handlers
     * @param <T>
     * @return
     */
    public static <T> DisruptorQueue<T> getWorkPoolQueue(int queueSize, boolean isMoreProducer, AresMessageHandler<T>... handlers) {
        Disruptor<AresMessageEvent<T>> disruptor = new Disruptor(new AresMessageEventFactory(), queueSize, Executors.defaultThreadFactory(),
                isMoreProducer ? ProducerType.MULTI : ProducerType.SINGLE, new SleepingWaitStrategy());
        disruptor.handleEventsWithWorkerPool(handlers);
        return new DisruptorQueue(disruptor);
    }

    /**
     * 创建"发布订阅模式"的操作队列，即同一事件会被多个消费者并行消费
     *
     * @param queueSize
     * @param isMoreProducer
     * @param handlers
     * @param <T>
     * @return
     */
    public static <T> DisruptorQueue<T> getHandleEventsQueue(int queueSize, boolean isMoreProducer, AresMessageHandler<T>... handlers) {
        Disruptor<AresMessageEvent<T>> disruptor = new Disruptor(new AresMessageEventFactory(), queueSize, Executors.defaultThreadFactory(),
                isMoreProducer ? ProducerType.MULTI : ProducerType.SINGLE, new SleepingWaitStrategy());
        disruptor.handleEventsWith(handlers);
        return new DisruptorQueue(disruptor);
    }

    /**
     * 直接通过传入的 Disruptor 对象创建操作队列（如果消费者有依赖关系的话可以用此方法）
     * @param disruptor
     * @param <T>
     * @return
     */
    public static <T> DisruptorQueue<T> getQueue(Disruptor<AresMessageEvent<T>> disruptor) {
        return new DisruptorQueue(disruptor);
    }

}
