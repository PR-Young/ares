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
        AresMessageProducer<String> producer = new AresMessageProducer("生产者1", disruptorQueue, "test",new AtomicInteger(1));
        Thread thread = new Thread(producer);
        thread.start();

        Thread.sleep(3 * 1000);
        producer.stopThread();
    }


}
