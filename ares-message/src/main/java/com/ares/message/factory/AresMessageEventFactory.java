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

package com.ares.message.factory;

import com.ares.message.persistence.entity.AresMessageEvent;
import com.lmax.disruptor.EventFactory;

/**
 * @description:
 * @author: Young
 * @date: 2023/1/30
 * @see: com.ares.message.factory.AresMessageEventFactory.java
 * @param <T>
 **/
public class AresMessageEventFactory<T> implements EventFactory<AresMessageEvent<T>> {
    @Override
    public AresMessageEvent<T> newInstance() {
        return new AresMessageEvent<T>();
    }
}
