package com.ares.core.model.listener;

import org.springframework.context.ApplicationEvent;

/**
 * @description:
 * @author: Young
 * @date: 2021/01/06
 * @see: com.ares.core.model.listener AresEvent.java
 **/
public class AresEvent extends ApplicationEvent {

    private static final long serialVersionUID = -1780648743308931344L;

    public AresEvent(Object source) {
        super(source);
    }
}
