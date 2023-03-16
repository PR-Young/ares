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

package com.ares.redis.model;

import lombok.Data;

/**
 * @description:
 * @author: Young
 * @date: 2022/11/1
 * @see: com.ares.redis.model.RedisLockDefinitionHolder.java
 **/
@Data
public class RedisLockDefinitionHolder {
    private String key;
    private Long lockTime;
    private Long lastModifyTime;
    private Thread currentThread;
    private int tryCount;
    private int currentTryCount;
    private Long modifyPeriod;

    public RedisLockDefinitionHolder(String key, Long lockTime, Long lastModifyTime, Thread currentThread, int tryCount) {
        this.key = key;
        this.lockTime = lockTime;
        this.lastModifyTime = lastModifyTime;
        this.currentThread = currentThread;
        this.tryCount = tryCount;
        this.modifyPeriod = lockTime * 1000 / 3;
    }
}
