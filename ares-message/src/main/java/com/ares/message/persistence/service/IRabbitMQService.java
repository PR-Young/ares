package com.ares.message.persistence.service;

/**
 * @description:
 * @author: Young 2020/02/25
 **/
public interface IRabbitMQService {

    public void send(Object message);
}
