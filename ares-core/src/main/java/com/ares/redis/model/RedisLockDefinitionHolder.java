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
