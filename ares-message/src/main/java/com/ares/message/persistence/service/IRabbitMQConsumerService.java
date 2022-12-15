package com.ares.message.persistence.service;

import org.springframework.amqp.core.Message;

/**
 * @description:
 * @author: Young 2020/02/25
 **/
public interface IRabbitMQConsumerService {

    public void consumer(Message message) ;
}
