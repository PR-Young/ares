/*
 * !******************************************************************************
 *  * Copyright (c) 2021 - 9999, ARES
 *  *
 *  * Licensed under the Apache License, Version 2.0 (the "License");
 *  * you may not use this file except in compliance with the License.
 *  * You may obtain a copy of the License at
 *  *
 *  *        http://www.apache.org/licenses/LICENSE-2.0
 *  *
 *  * Unless required by applicable law or agreed to in writing, software
 *  * distributed under the License is distributed on an "AS IS" BASIS,
 *  * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  * See the License for the specific language governing permissions and
 *  * limitations under the License.
 *  *****************************************************************************
 */

package com.ares.core.listener;

import com.alibaba.fastjson2.JSON;
import com.alibaba.fastjson2.JSONWriter;
import com.ares.core.model.listener.AresEvent;
import lombok.extern.slf4j.Slf4j;

/**
 * @description:
 * @author: Young
 * @date: 2021/01/06
 * @see: com.ares.core.listener AresEventListener.java
 **/
@Slf4j
public class AresEventListener extends DefaultEventListener<AresEvent> {

    @Override
    public void onApplicationEvent(AresEvent aresEvent) {
        log.info(JSON.toJSONString(aresEvent.getSource(), JSONWriter.Feature.WriteMapNullValue));
    }
}
