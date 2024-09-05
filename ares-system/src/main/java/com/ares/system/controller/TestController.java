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
@RestController("aresTestController")
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
