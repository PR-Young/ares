package com.ares.system.controller;

import com.ares.redis.aspect.RedisLock;
import com.ares.redis.model.RedisLockType;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * @description:
 * @author: Young
 * @date: 2022/11/1
 * @see: com.ares.system.controller.TestController.java
 **/
@Slf4j
@RestController
@RequestMapping("/test/*")
public class TestController {

    @GetMapping("lock/{userId}")
    @RedisLock(type = RedisLockType.ONLY, lockTime = 3)
    public String testRedisLock(@PathVariable("userId") Long userId) {
        log.info("begin " + userId);
        try {
            Thread.sleep(1000);
        } catch (InterruptedException e) {
            log.info("has some error:", e);
        }
        log.info("end " + userId);
        return null;
    }
}
