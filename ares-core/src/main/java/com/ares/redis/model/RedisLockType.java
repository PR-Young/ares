package com.ares.redis.model;

/**
 * @description:
 * @author: Young
 * @date: 2022/11/1
 * @see: com.ares.redis.model.RedisLockType.java
 **/
public enum RedisLockType {

    ONLY("only", "only");

    private String code;
    private String desc;

    RedisLockType(String code, String desc) {
        this.code = code;
        this.desc = desc;
    }

    public String getCode() {
        return code;
    }

    public String getDesc() {
        return desc;
    }

    public String getUniqueKey(String key) {
        return String.format("%s:%s", this.getCode(), key);
    }
}
