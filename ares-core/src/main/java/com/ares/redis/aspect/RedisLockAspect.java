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

package com.ares.redis.aspect;

import com.ares.redis.model.RedisLockDefinitionHolder;
import com.ares.redis.model.RedisLockType;
import com.ares.redis.utils.RedisUtil;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.concurrent.BasicThreadFactory;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.aspectj.lang.reflect.MethodSignature;
import org.springframework.stereotype.Component;

import java.lang.reflect.Method;
import java.util.Iterator;
import java.util.UUID;
import java.util.concurrent.ConcurrentLinkedQueue;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.ScheduledThreadPoolExecutor;
import java.util.concurrent.TimeUnit;

/**
 * @description:
 * @author: Young
 * @date: 2022/11/1
 * @see: com.ares.redis.aspect.RedisLockAspect.java
 **/
@Slf4j
@Aspect
@Component
public class RedisLockAspect {

    private static ConcurrentLinkedQueue<RedisLockDefinitionHolder> holderList = new ConcurrentLinkedQueue<>();

    private static final ScheduledExecutorService SCHEDULED = new ScheduledThreadPoolExecutor(1,
            new BasicThreadFactory.Builder().namingPattern("redisLock-schedule-pool").daemon(true).build());

    {
        SCHEDULED.scheduleAtFixedRate(() -> {
            Iterator<RedisLockDefinitionHolder> iterator = holderList.iterator();
            while (iterator.hasNext()) {
                RedisLockDefinitionHolder holder = iterator.next();
                if (null == holder) {
                    iterator.remove();
                    continue;
                }
                if (RedisUtil.get(holder.getKey()) == null) {
                    iterator.remove();
                    continue;
                }
                if (holder.getCurrentTryCount() > holder.getTryCount()) {
                    holder.getCurrentThread().interrupt();
                    iterator.remove();
                    continue;
                }
                long current = System.currentTimeMillis();
                boolean shouldExtend = (holder.getLastModifyTime() + holder.getModifyPeriod()) <= current;
                if (shouldExtend) {
                    holder.setLastModifyTime(current);
                    RedisUtil.expire(holder.getKey(), holder.getLockTime());
                    log.info("key : [" + holder.getKey() + "], try count :" + holder.getCurrentTryCount());
                    holder.setCurrentTryCount(holder.getCurrentTryCount() + 1);
                }
            }
        }, 0, 2, TimeUnit.SECONDS);
    }

    @Pointcut("@annotation(com.ares.redis.aspect.RedisLock)")
    public void redisLock() {
    }

    @Around(value = "redisLock()")
    public Object around(ProceedingJoinPoint point) throws Throwable {
        MethodSignature signature = (MethodSignature) point.getSignature();
        Method method = signature.getMethod();
        RedisLock redisLock = method.getAnnotation(RedisLock.class);
        RedisLockType type = redisLock.type();
        Object[] params = point.getArgs();
        String lockField = params[redisLock.lockField()].toString();
        String uniqueKey = type.getUniqueKey(lockField);
        String uniqueValue = UUID.randomUUID().toString();
        Object result = null;
        try {
            boolean isSuccess = RedisUtil.lock(uniqueKey, uniqueValue);
            if (!isSuccess) {
                throw new Exception("another has get the lock ==");
            }
            RedisUtil.expire(uniqueKey, redisLock.lockTime());
            Thread currentThread = Thread.currentThread();
            holderList.add(new RedisLockDefinitionHolder(uniqueKey, redisLock.lockTime(), System.currentTimeMillis(), currentThread, redisLock.tryCount()));
            result = point.proceed();
            if (currentThread.isInterrupted()) {
                throw new InterruptedException("you had been interrupted ==");
            }
        } catch (InterruptedException e) {
            log.error("Interrupt exception, rollback transaction", e);
            throw new Exception("Interrupt exception, please send request again");
        } catch (Exception e) {
            log.error("has some error, please check again", e);
        } finally {
            RedisUtil.del(uniqueKey);
            log.info("release the lock, key is [" + uniqueKey + "]");
        }
        return result;
    }


}
