package com.ares.core.model.listener;

import org.springframework.context.ApplicationEvent;

/**
 * @description:
 * @author: Young
 * @date: 2021/01/29
 * @see: com.ares.core.model.listener ElasticsearchEvent.java
 **/
public class ElasticsearchEvent extends ApplicationEvent {

    private static final long serialVersionUID = 465900456430384949L;

    public ElasticsearchEvent(Object source) {
        super(source);
    }
}
