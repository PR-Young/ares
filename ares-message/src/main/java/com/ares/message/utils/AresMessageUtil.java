package com.ares.message.utils;

import com.ares.message.factory.DisruptorQueueFactory;
import com.ares.message.handler.AresMessageHandler;
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

    public static void sendMessage(String name, Object data, int bufferSize, boolean isMoreProducer,int frequency, AresMessageHandler... handler) {
        DisruptorQueue<String> disruptorQueue = DisruptorQueueFactory.getHandleEventsQueue(bufferSize, isMoreProducer, handler);
        AresMessageProducer<String> producer = new AresMessageProducer(name, disruptorQueue, data,new AtomicInteger(frequency));
        executorService.execute(producer);
    }

}
