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

package com.ares.redis.utils;


import com.ares.core.utils.StringUtils;
import jakarta.annotation.PostConstruct;
import jakarta.annotation.Resource;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Component;

import java.util.Arrays;
import java.util.Collection;
import java.util.Set;
import java.util.concurrent.TimeUnit;

/**
 * @description: redis操作类
 * @author: Young 2020/04/09
 **/
@Component
public class RedisUtil {
    private static Logger logger = LoggerFactory.getLogger(RedisUtil.class);

    @Resource
    private RedisTemplate<String, Object> template;
    private static RedisTemplate<String, Object> redisTemplate;

    @Resource(name = "redisTemplateObj")
    private RedisTemplate<String, Object> redisTemplateObj;

    @PostConstruct
    public void init() {
        redisTemplate = template;
//        logger.info("===========init redis start===========");
//        redisTemplateObj.delete(redisTemplate.keys("*"));
//        logger.info("===========init redis end===========");
    }

    /**
     * 将数据放入redis
     *
     * @param key
     * @param value
     * @param expire
     * @return
     */
    public static boolean set(String key, Object value, long expire) {
        try {
            if (expire > 0) {
                redisTemplate.opsForValue().set(key, value, expire, TimeUnit.SECONDS);
            } else {
                redisTemplate.opsForValue().set(key, value);
            }
            return true;
        } catch (Exception e) {
            logger.error("redis set {} error ,message {}", key, StringUtils.substring(e.toString(), 0, 2000));
            return false;
        }
    }

    /**
     * 根据key获取数据
     *
     * @param key
     * @return
     */
    public static Object get(String key) {
        return key == null ? null : redisTemplate.opsForValue().get(key);
    }

    /**
     * 删除操作
     *
     * @param keys
     */
    public static void del(String... keys) {
        if (null != keys && keys.length > 0) {
            if (keys.length == 1) {
                redisTemplate.delete(keys[0]);
            } else {
                redisTemplate.delete(Arrays.asList(keys));
            }
        }
    }

    /**
     * 删除操作
     *
     * @param keys
     */
    public static void delete(Collection<String> keys) {
        redisTemplate.delete(keys);
    }

    /**
     * 是否存在key
     *
     * @param key
     * @return
     */
    public static boolean hasKey(String key) {
        try {
            return redisTemplate.hasKey(key);
        } catch (Exception e) {
            logger.error("find {} error,message {}", key, StringUtils.substring(e.toString(), 0, 2000));
            return false;
        }
    }

    /**
     * 获取 hash 数据
     *
     * @param key
     * @param hashKey
     * @return
     */
    public static Object getHash(String key, String hashKey) {
        return redisTemplate.opsForHash().get(key, hashKey);
    }

    /**
     * set hash 数据
     *
     * @param key
     * @param hashKey
     * @param value
     * @return
     */
    public static boolean setHash(String key, Object hashKey, Object value) {
        try {
            redisTemplate.opsForHash().put(key, hashKey, value);
            return true;
        } catch (Exception e) {
            logger.error("setHash key:{} error,message:{}", key, StringUtils.substring(e.toString(), 0, 2000));
            return false;
        }
    }

    /**
     * 删除hash数据
     *
     * @param key
     * @param hashKeys
     * @return
     */
    public static boolean delHash(String key, Object... hashKeys) {
        try {
            redisTemplate.opsForHash().delete(key, hashKeys);
            return true;
        } catch (Exception e) {
            logger.error("delHash key:{} error,message:{}", key, StringUtils.substring(e.toString(), 0, 2000));
            return false;
        }
    }

    public static boolean hasHash(String key, Object hashKey) {
        try {
            redisTemplate.opsForHash().hasKey(key, hashKey);
            return true;
        } catch (Exception e) {
            logger.error("hasHash key:{} error,message:{}", key, StringUtils.substring(e.toString(), 0, 2000));
            return false;
        }
    }

    public static boolean expire(String key, long time) {
        try {
            if (time > 0) {
                redisTemplate.expire(key, time, TimeUnit.SECONDS);
            }
            return true;
        } catch (Exception e) {
            logger.error("expire key:{} error,message:{}", key, StringUtils.substring(e.toString(), 0, 2000));
            return false;
        }
    }

    public static Set<String> getKeysByPattern(String pattern) {
        return redisTemplate.keys(pattern);
    }

    public static boolean lock(String key, String value) {
        return Boolean.TRUE.equals(redisTemplate.opsForValue().setIfAbsent(key, value));
    }
}
