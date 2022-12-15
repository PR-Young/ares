package com.ares.message.persistence.service.impl;

import com.ares.message.persistence.service.IRabbitMQService;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.amqp.rabbit.core.RabbitTemplate;
import org.springframework.amqp.support.converter.Jackson2JsonMessageConverter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @description:
 * @author: Young 2020/02/25
 **/
@Service
public class RabbitMQServiceImpl implements IRabbitMQService {

    @Autowired
    private RabbitTemplate rabbitTemplate;

    @Autowired
    private ObjectMapper objectMapper;

    @Override
    public void send(Object message) {
        try {
            rabbitTemplate.setMessageConverter(new Jackson2JsonMessageConverter());
            rabbitTemplate.setExchange("testExchange");
            rabbitTemplate.setRoutingKey("test");

            //Message msg = MessageBuilder.withBody(objectMapper.writeValueAsBytes(message)).setDeliveryMode(MessageDeliveryMode.PERSISTENT).build();
            //msg.getMessageProperties().setHeader(AbstractJavaTypeMapper.DEFAULT_CONTENT_CLASSID_FIELD_NAME, MessageProperties.CONTENT_TYPE_JSON);
            rabbitTemplate.convertAndSend(message);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
