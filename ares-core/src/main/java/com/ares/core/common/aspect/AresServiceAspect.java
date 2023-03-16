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

package com.ares.core.common.aspect;

import lombok.extern.slf4j.Slf4j;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.*;
import org.springframework.stereotype.Component;

/**
 * @description:
 * @author: Young
 * @date: 2023/2/24
 * @see: com.ares.core.common.aspect.AresServiceAspect.java
 **/
@Slf4j
@Aspect
@Component
public class AresServiceAspect {

    @Pointcut("execution(* com.ares.*.*.service.*.*(..))")
    public void servicePointcut(){}

    @Before(value = "servicePointcut()")
    public void before(JoinPoint joinPoint){
        String name = joinPoint.getSignature().getName();
        log.debug(name+"方法开始执行...");
    }

    @After(value = "servicePointcut()")
    public void after(JoinPoint joinPoint){
        String name = joinPoint.getSignature().getName();
        log.debug(name+"方法开始执行结束...");
    }

    @AfterReturning(value = "servicePointcut()",returning = "result")
    public void before(JoinPoint joinPoint,Object result){
        String name = joinPoint.getSignature().getName();
        log.debug(name+"方法返回值为:"+result);
    }

    @AfterThrowing(value = "servicePointcut()",throwing = "e")
    public void before(JoinPoint joinPoint,Exception e){
        String name = joinPoint.getSignature().getName();
        log.debug(name+"方法出错，异常是:"+e.getMessage());
    }

    @Around(value = "servicePointcut()")
    public Object around(ProceedingJoinPoint pjp) throws Throwable {
        String name = pjp.getSignature().getName();
        long start = System.currentTimeMillis();
        Object proceed = pjp.proceed();
        long end = System.currentTimeMillis();
        log.debug(name+"方法执行时间为:"+(end-start)+"ms");
        return proceed;
    }

}
