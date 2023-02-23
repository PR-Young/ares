package com.ares.message.persistence.service;

/**
 * @description:
 * @author: Young
 * @date: 2023/1/30
 * @see: com.ares.message.persistence.service.IDisruptorMessageService.java
 **/
public interface IDisruptorMessageService {

    public void send(String message);
}
