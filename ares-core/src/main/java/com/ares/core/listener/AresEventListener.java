package com.ares.core.listener;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.serializer.SerializerFeature;
import com.ares.core.persistence.model.listener.AresEvent;

/**
 * @description:
 * @author: Young
 * @date: 2021/01/06
 * @see: com.ares.core.listener AresEventListener.java
 **/
public class AresEventListener extends DefaultEventListener<AresEvent> {

    @Override
    public void onApplicationEvent(AresEvent aresEvent) {
        logger.info(JSON.toJSONString(aresEvent.getSource(), SerializerFeature.WriteMapNullValue));
    }
}
