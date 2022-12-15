package com.ares.message.persistence.service.impl;

import com.ares.message.persistence.service.IRabbitMQConsumerService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.amqp.core.Message;
import org.springframework.stereotype.Service;

/**
 * @description:
 * @author: Young 2020/02/25
 **/
@Service
public class RabbitMQConsumerServiceImpl implements IRabbitMQConsumerService {

    private Logger logger = LoggerFactory.getLogger(RabbitMQConsumerServiceImpl.class);


    //@RabbitListener(queues = "ares.queue", containerFactory = "single")
    @Override
    public void consumer(Message message) {
        try {

            logger.info("监听到消息： {} ", message.toString());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
