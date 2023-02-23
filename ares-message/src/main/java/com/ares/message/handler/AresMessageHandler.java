package com.ares.message.handler;

import com.ares.message.persistence.model.AresMessageEvent;
import com.lmax.disruptor.EventHandler;
import com.lmax.disruptor.WorkHandler;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * @description:
 * @author: Young
 * @date: 2023/1/30
 * @see: com.ares.message.handler.AresMessageHandler.java
 **/
public class AresMessageHandler<T> implements EventHandler<AresMessageEvent<T>>, WorkHandler<AresMessageEvent<T>> {
    private static Logger logger = LoggerFactory.getLogger(AresMessageHandler.class);

    public AresMessageHandler() {
    }

    @Override
    public void onEvent(AresMessageEvent<T> aresMessageEvent, long l, boolean b) throws Exception {
        if (null != aresMessageEvent) {
            logger.info("------>拿到队列中的数据：" + aresMessageEvent);
        }
    }

    @Override
    public void onEvent(AresMessageEvent<T> aresMessageEvent) throws Exception {
        if (null != aresMessageEvent) {
            logger.info("------>拿到队列中的数据：" + aresMessageEvent);
        }
    }
}
