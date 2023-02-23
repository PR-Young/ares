package com.ares.message.factory;

import com.ares.message.persistence.model.AresMessageEvent;
import com.lmax.disruptor.EventFactory;

/**
 * @description:
 * @author: Young
 * @date: 2023/1/30
 * @see: com.ares.message.factory.AresMessageEventFactory.java
 **/
public class AresMessageEventFactory<T> implements EventFactory<AresMessageEvent<T>> {
    @Override
    public AresMessageEvent<T> newInstance() {
        return new AresMessageEvent<T>();
    }
}
