package com.ares.message.factory;

import com.ares.message.handler.AresMessageHandler;
import com.ares.message.persistence.model.AresMessageEvent;
import com.ares.message.persistence.model.DisruptorQueue;
import com.lmax.disruptor.RingBuffer;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

/**
 * @description:
 * @author: Young
 * @date: 2023/1/30
 * @see: com.ares.message.factory.MessageManager.java
 **/
@Configuration
public class MessageManager {

    @Bean("aresStringMessageModel")
    public RingBuffer<AresMessageEvent<String>> messageEventRingBuffer(){
        int bufferSize = 1024 * 1024;
        DisruptorQueue<String> disruptorQueue = DisruptorQueueFactory.getHandleEventsQueue(bufferSize, false, new AresMessageHandler<String>());
        return disruptorQueue.getRingBuffer();
    }
}
