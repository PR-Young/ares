package com.ares.redis.aspect;

import com.ares.redis.model.RedisLockType;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

/**
 * @description:
 * @author: Young
 * @date: 2022/11/1
 * @see: com.ares.redis.aspect.RedisLock.java
 **/
@Retention(RetentionPolicy.RUNTIME)
@Target({ElementType.METHOD, ElementType.TYPE})
public @interface RedisLock {

    int lockField() default 0;

    int tryCount() default 3;

    RedisLockType type();

    long lockTime() default 30;
}
